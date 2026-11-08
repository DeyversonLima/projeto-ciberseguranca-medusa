# Laboratório de autenticação com Kali Linux, Nmap e Medusa

> Projeto de portfólio — Santander | Cibersegurança do Zero à Prática (DIO)

Este repositório documenta um laboratório local e autorizado com Kali Linux e Metasploitable 2. O trabalho prático cobriu conectividade, reconhecimento de serviços e validação de acesso FTP anônimo. Os cenários de força bruta com Medusa, login no DVWA e *password spraying* em SMB foram estudados, mas **não foram executados**.

> **Uso ético:** os comandos e exemplos se destinam somente a sistemas próprios, isolados e expressamente autorizados. O Metasploitable 2 é intencionalmente vulnerável e não deve ser exposto à internet.

## Navegação

- [Escopo e status](#escopo-e-status)
- [Arquitetura e isolamento](#arquitetura-e-isolamento)
- [Procedimentos executados](#procedimentos-executados)
- [Evidências e achados](#evidências-e-achados)
- [Cenários estudados](#cenários-estudados)
- [Limitações e próximos passos](#limitações-e-próximos-passos)
- [Reprodução do escopo documentado](#reprodução-do-escopo-documentado)
- [Documentação complementar](#documentação-complementar)

## Objetivo

Demonstrar a montagem segura de um laboratório vulnerável, registrar um fluxo básico de reconhecimento e interpretar resultados de autenticação sem confundir serviço exposto, configuração insegura e exploração. O repositório também consolida o estudo defensivo dos três cenários sugeridos pelo desafio da DIO.

## Escopo e status

| Cenário ou etapa | Estado | Base da conclusão |
| --- | --- | --- |
| Kali Linux e Metasploitable 2 no VirtualBox | **Executado** | Ambiente descrito em [`docs/configuracao-ambiente.md`](docs/configuracao-ambiente.md) |
| Rede Host-only entre as VMs | **Executado** | Endereços registrados e conectividade confirmada por ping |
| Ping para o alvo | **Executado** | Captura `01-nmap-servicos.png`: 4 enviados, 4 recebidos, 0% de perda |
| Reconhecimento com Nmap `-sV` | **Executado** | [Captura do terminal](images/01-nmap-servicos.png): host ativo e 23 portas TCP abertas |
| Login FTP anônimo | **Executado** | [Captura do terminal](images/02-ftp-login-anonimo.png): resposta `230 Login successful` |
| Solicitação de listagem FTP | **Executado** | [Captura do terminal](images/03-ftp-listagem.png): resposta `226 Directory send OK`, sem itens exibidos |
| Disponibilidade do Medusa 2.3 | **Relatada, sem captura** | Registro textual da sessão; não comprova tentativa de senha |
| Força bruta FTP com Medusa | **Estudado; não executado** | Sintaxe didática e medidas defensivas |
| Tentativas de login no DVWA | **Estudado; não executado** | DVWA não foi instalado neste laboratório |
| Enumeração e *password spraying* SMB | **Estudado; não executado** | Nenhuma tentativa SMB ou enumeração foi registrada |

O estado “executado” não implica exploração bem-sucedida. No escopo prático, foi validada uma configuração de acesso anônimo no FTP; não houve descoberta de senha nem comprometimento do servidor.

## Arquitetura e isolamento

```text
Windows (host com VirtualBox)
            |
      Rede Host-only
            |
    +-------+------------------+
    |                          |
Kali Linux                Metasploitable 2
192.168.56.102            192.168.56.101
Máquina de auditoria      Alvo vulnerável intencional
```

As duas VMs usaram a mesma rede Host-only. Esse modo permite comunicação dentro do laboratório sem colocar o Metasploitable 2 diretamente na rede externa. Não se recomenda configurar o alvo em modo Bridge. A configuração registrada está em [`docs/configuracao-ambiente.md`](docs/configuracao-ambiente.md).

## Ferramentas

| Ferramenta | Uso neste projeto |
| --- | --- |
| Oracle VirtualBox | Execução e isolamento das máquinas virtuais |
| Kali Linux | Máquina de auditoria |
| Metasploitable 2 | Alvo intencionalmente vulnerável |
| Nmap 7.99 | Identificação de portas, serviços e versões anunciadas |
| Cliente FTP | Validação interativa de login anônimo e listagem |
| Medusa 2.3 | Disponibilidade relatada; sintaxe estudada, sem teste automatizado |
| DVWA | Referência de estudo; não instalado nem testado |

## Procedimentos executados

Os comandos abaixo são os que constam na documentação e nas capturas da sessão:

```bash
ping -c 4 192.168.56.101
nmap -sV 192.168.56.101
ftp 192.168.56.101
```

No cliente FTP, foram informados o usuário `anonymous` e uma senha em branco. Depois do login, foram usados `ls` e `quit`.

| Procedimento | Resultado observado | Interpretação limitada ao que foi comprovado |
| --- | --- | --- |
| `ping -c 4 192.168.56.101` | 4 respostas e 0% de perda | Havia conectividade IP entre as VMs naquele momento |
| `nmap -sV 192.168.56.101` | Host ativo; 23 portas abertas entre 1.000 portas TCP padrão | Os serviços estavam acessíveis e anunciaram versões; isso não prova vulnerabilidade explorável |
| Login FTP como `anonymous` | `230 Login successful` | O serviço aceitava acesso anônimo; nenhuma senha foi descoberta |
| `ls` no FTP | `226 Directory send OK`, sem itens exibidos | A solicitação de listagem terminou; não há prova de leitura, download ou escrita de arquivos |

Os detalhes completos estão em [`docs/testes-realizados.md`](docs/testes-realizados.md).

## Evidências e achados

### 1. Conectividade e reconhecimento

![Terminal do Kali mostrando ping sem perda e Nmap com serviços identificados no Metasploitable 2](images/01-nmap-servicos.png)

O Nmap registrou 23 portas TCP abertas. Entre elas estavam FTP (21 e 2121), SSH (22), Telnet (23), HTTP (80 e 8180), SMB (139 e 445), MySQL (3306) e PostgreSQL (5432). As versões são identificações feitas pelo Nmap e devem ser confirmadas antes de qualquer conclusão sobre vulnerabilidades.

### 2. Login FTP anônimo

![Terminal do Kali mostrando login FTP bem-sucedido com o usuário anonymous e senha em branco](images/02-ftp-login-anonimo.png)

A resposta `230 Login successful` comprova apenas que a configuração permitia autenticação anônima naquele serviço.

### 3. Listagem FTP

![Terminal do Kali mostrando o comando ls no FTP, a conclusão 226 e nenhuma entrada listada](images/03-ftp-listagem.png)

O servidor concluiu a solicitação, mas a captura não exibe arquivos ou diretórios. Não há evidência de conteúdo confidencial, escrita, transferência de arquivos ou execução remota.

## Cenários estudados

### FTP e Medusa

O Medusa automatiza tentativas de autenticação. A presença do FTP e o acesso anônimo não demonstram senha fraca. O arquivo [`scripts/exemplos-laboratorio.sh`](scripts/exemplos-laboratorio.sh) apenas imprime uma sintaxe didática e não executa Nmap, FTP ou Medusa. As listas em [`wordlists/`](wordlists/) contêm dados fictícios de laboratório.

### Formulário web no DVWA

O DVWA não foi instalado nem testado. O estudo considera tentativas limitadas em um ambiente local, diferenças de resposta e controles como MFA, limitação de taxa, atrasos progressivos e mensagens que não facilitem enumeração.

### SMB e *password spraying*

*Password spraying* aplica uma senha candidata a várias contas, enquanto a força bruta tradicional testa muitas senhas contra uma conta ou serviço. Não houve enumeração de usuários nem autenticação SMB neste projeto. O fluxo conceitual e as mitigações estão em [`docs/cenarios-e-mitigacoes.md`](docs/cenarios-e-mitigacoes.md).

## Recomendações de mitigação

- Desabilitar o FTP anônimo quando não houver necessidade documentada e restringir permissões e diretórios.
- Preferir SFTP/SSH para transferências autenticadas e protegidas em trânsito.
- Manter somente os serviços necessários, atualizados e segmentados.
- Adotar senhas exclusivas, bloquear senhas comuns ou vazadas e habilitar MFA quando suportado.
- Aplicar limitação de tentativas e atrasos progressivos com cuidado para não facilitar negação de serviço por bloqueio de contas.
- Correlacionar falhas de autenticação entre contas, origens e períodos para detectar força bruta e *spraying*.
- Preservar o isolamento de sistemas deliberadamente vulneráveis e manter registros dos testes autorizados.

## Limitações e próximos passos

- Não há captura da configuração do VirtualBox nem da verificação de versão do Medusa; esses itens permanecem sustentados apenas pelo registro textual.
- Não foram salvas saídas do Nmap em formato de texto ou XML; a captura de tela é a evidência disponível.
- As permissões FTP não foram avaliadas além do login e da listagem vazia.
- Medusa, DVWA e SMB permanecem como estudo, sem resultados práticos.
- As capturas não registram uma execução completa e datada de cada cenário sugerido pelo desafio.

Para ampliar o trabalho, o autor pode executar cada cenário apenas no laboratório isolado, registrar data, escopo, comandos, versões, saídas e logs defensivos, e então atualizar o status. Nenhum resultado deve ser antecipado antes dessa evidência existir.

## Reprodução do escopo documentado

> Execute somente em VMs próprias, isoladas e autorizadas. Confirme os endereços IP antes de cada comando.

1. Configure Kali Linux e Metasploitable 2 na mesma rede Host-only, sem interface Bridge no alvo.
2. Confirme que o alvo usa o IP esperado no laboratório.
3. No Kali, valide a conectividade com `ping -c 4 192.168.56.101`.
4. Faça apenas o reconhecimento documentado com `nmap -sV 192.168.56.101`.
5. Conecte-se com `ftp 192.168.56.101`, informe `anonymous`, deixe a senha em branco e use `ls` e `quit`.
6. Registre a saída real e compare-a com as limitações descritas neste repositório.

Essas instruções reproduzem somente ping, reconhecimento e validação de FTP anônimo. Elas não incluem força bruta, automação web ou *password spraying*.

## Documentação complementar

- [`docs/configuracao-ambiente.md`](docs/configuracao-ambiente.md): topologia, endereços e cuidados de isolamento.
- [`docs/testes-realizados.md`](docs/testes-realizados.md): procedimentos, evidências e limites das conclusões.
- [`docs/cenarios-e-mitigacoes.md`](docs/cenarios-e-mitigacoes.md): cenários não executados e medidas defensivas.
- [`scripts/exemplos-laboratorio.sh`](scripts/exemplos-laboratorio.sh): exemplo inerte que apenas exibe comandos didáticos.

## Aprendizados

O laboratório reforçou que reconhecimento, validação de configuração e exploração são etapas diferentes. Uma porta aberta ou versão anunciada levanta hipóteses; o login FTP anônimo valida uma configuração específica; nenhum dos dois, isoladamente, prova descoberta de credenciais ou comprometimento. Documentar limites e evidências negativas é parte do trabalho técnico.

## Referências

- [Kali Linux](https://www.kali.org/docs/)
- [Nmap Reference Guide](https://nmap.org/book/man.html)
- [Medusa — repositório oficial](https://github.com/jmk-foofus/medusa)
- [Damn Vulnerable Web Application (DVWA)](https://github.com/digininja/DVWA)
- [VirtualBox — Host-only networking](https://www.virtualbox.org/manual/ch06.html#network_hostonly)
