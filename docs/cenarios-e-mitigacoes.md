# Cenários estudados e medidas de mitigação

[Voltar ao README](../README.md)

> **Estado deste documento:** estudo didático. Nenhuma força bruta com Medusa, automação no DVWA ou campanha de *password spraying* SMB foi executada. Os exemplos se aplicam somente a ambientes próprios, isolados e autorizados.

## FTP e auditoria de senhas com Medusa

O Medusa recebe um host, um módulo de serviço e uma conta ou lista de contas e senhas para testar autenticações. Em um laboratório, o escopo deve usar contas fictícias criadas para o teste, poucas credenciais, baixa concorrência e monitoração dos logs.

**Observação prática relacionada:** a porta 21 estava aberta e o login `anonymous` com senha em branco foi aceito. Esse mecanismo de acesso não é uma senha descoberta e não comprova fraqueza de credenciais de outras contas.

**Riscos a avaliar:** conteúdo exposto por leitura anônima, escrita indevida quando as permissões permitem e adivinhação de senhas de contas reais.

**Mitigações:** desabilitar acesso anônimo sem necessidade, restringir diretórios e permissões, preferir SFTP, bloquear senhas comuns, limitar tentativas, aplicar atrasos progressivos, atualizar o serviço e monitorar logs.

**Evidência necessária em uma execução futura:** comando e versão do Medusa, conta fictícia preparada, wordlist usada, intervalo e concorrência, saída completa, logs do servidor e resultado real — inclusive quando nenhuma credencial for aceita.

## DVWA e formulário web

O DVWA permite estudar autenticação web em um alvo local deliberadamente vulnerável. Um exercício controlado pode identificar campos e respostas do formulário, usar uma conta fictícia, limitar tentativas e observar controles antiabuso. O DVWA não foi instalado, e cookies, tokens ou automações não foram coletados neste projeto.

**Riscos a avaliar:** enumeração de contas, adivinhação de senhas, ausência de limitação de taxa e acesso indevido.

**Mitigações:** MFA, limitação de taxa, atrasos progressivos, proteção contra automação, respostas que não revelem a existência da conta, senhas fortes e alertas. Bloqueios rígidos precisam ser projetados para evitar abuso como negação de serviço.

**Evidência necessária em uma execução futura:** versão e nível de segurança do DVWA, conta fictícia, URL local, requisição reproduzível com dados sensíveis ocultados, respostas observadas, limites aplicados e logs do servidor.

## SMB e *password spraying*

*Password spraying* testa uma senha candidata em várias contas; força bruta tradicional testa várias senhas contra uma conta ou serviço. Detectar *spraying* exige correlacionar falhas entre diferentes usuários, origens e intervalos.

Não houve enumeração de usuários nem tentativa SMB neste projeto. A presença das portas 139 e 445 no resultado do Nmap comprova apenas que serviços SMB estavam acessíveis durante o reconhecimento.

**Riscos a avaliar:** contas com senhas comuns ou reutilizadas, acesso indevido e movimento lateral.

**Mitigações:** senhas exclusivas e robustas, MFA quando suportado, desativação de contas antigas, segmentação e restrição do SMB, correlação de falhas e política de bloqueio equilibrada.

**Evidência necessária em uma execução futura:** contas fictícias previamente autorizadas, senha de teste, comando e versão da ferramenta, frequência das tentativas, saída completa, logs de autenticação e comprovação dos controles defensivos.

## Síntese defensiva

| Controle | FTP | Web/DVWA | SMB |
| --- | --- | --- | --- |
| Reduzir exposição e permissões | Sim | Sim | Sim |
| Senhas exclusivas e bloqueio de senhas comuns | Sim | Sim | Sim |
| MFA | Quando suportado | Recomendado | Quando suportado |
| Limitação de tentativas e atrasos | Sim | Sim | Sim |
| Correlação e alertas de autenticação | Sim | Sim | Essencial para *spraying* |
| Atualização e configuração segura | Sim | Sim | Sim |
