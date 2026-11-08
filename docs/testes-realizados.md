# Procedimentos executados e evidências

[Voltar ao README](../README.md)

Este documento reúne somente procedimentos executados ou verificações relatadas. Cenários não executados estão separados em [`cenarios-e-mitigacoes.md`](cenarios-e-mitigacoes.md).

## Matriz de evidências

| ID | Procedimento | Evidência | Resultado sustentado |
| --- | --- | --- | --- |
| E1 | Ping e reconhecimento Nmap | [`01-nmap-servicos.png`](../images/01-nmap-servicos.png) | Conectividade sem perda; host ativo; 23 portas TCP abertas entre as 1.000 portas padrão |
| E2 | Login FTP anônimo | [`02-ftp-login-anonimo.png`](../images/02-ftp-login-anonimo.png) | Resposta `230 Login successful` para `anonymous` com senha em branco |
| E3 | Listagem FTP | [`03-ftp-listagem.png`](../images/03-ftp-listagem.png) | Solicitação encerrada com `226 Directory send OK`, sem entradas exibidas |
| R1 | Disponibilidade do Medusa 2.3 | Registro textual, sem captura | Ferramenta relatada como disponível; nenhuma tentativa automatizada comprovada |

## 1. Conectividade

```bash
ping -c 4 192.168.56.101
```

**Resultado observado (E1):** quatro pacotes transmitidos, quatro recebidos e 0% de perda. Isso confirma conectividade IP entre as VMs durante a sessão; não avalia serviços ou segurança do alvo.

## 2. Reconhecimento de serviços

```bash
nmap -sV 192.168.56.101
```

**Resultado observado (E1):** Nmap 7.99 identificou o host ativo e 23 portas TCP abertas entre as 1.000 portas padrão. Entre os serviços reportados estavam FTP 21, SSH 22, Telnet 23, HTTP 80, SMB 139/445, FTP 2121, MySQL 3306, PostgreSQL 5432 e HTTP 8180.

**Limite da conclusão:** a detecção de serviço ou versão não demonstra que uma vulnerabilidade seja explorável. Nenhuma exploração baseada em versão foi realizada.

## 3. Validação de FTP anônimo

```bash
ftp 192.168.56.101
```

No cliente FTP, foi informado o usuário `anonymous` e o campo de senha ficou vazio.

**Resultado observado (E2):** `230 Login successful`.

**Interpretação:** o servidor aceitava autenticação anônima. Isso é validação de configuração, não força bruta nem descoberta de senha.

## 4. Solicitação de listagem FTP

Após o login anônimo, foi usado `ls`:

```text
ftp> ls
229 Entering Extended Passive Mode (...)
150 Here comes the directory listing.
226 Directory send OK.
ftp> quit
221 Goodbye.
```

**Resultado observado (E3):** nenhum item aparece entre as mensagens de início e fim da listagem.

**Limite da conclusão:** não há evidência de download, leitura de conteúdo confidencial, permissão de escrita ou execução remota.

## 5. Verificação relatada do Medusa

O Medusa v2.3 foi registrado como disponível no Kali, mas o repositório não contém captura ou saída dessa verificação. Também não há evidência de tentativas automatizadas de autenticação. Por isso, a disponibilidade é tratada como relato, e o cenário de força bruta permanece “estudado; não executado”.

## Fora do escopo executado

- força bruta FTP com Medusa;
- instalação ou automação de login no DVWA;
- enumeração de contas ou *password spraying* em SMB;
- validação de escrita ou transferência de arquivos pelo FTP.

Caso essas atividades sejam realizadas no futuro, devem ser limitadas ao laboratório autorizado e acompanhadas de data, comando, versão, saída completa, evidência e análise defensiva.
