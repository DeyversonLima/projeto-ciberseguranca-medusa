# Cenários estudados e medidas de mitigação

**Importante:** os três cenários abaixo são discussões didáticas. Nenhuma campanha de força bruta, automação de formulário DVWA ou spraying SMB foi executada no laboratório apresentado.

## Cenário A — FTP e senhas fracas

**Conceito:** ferramentas como Medusa recebem um host, um serviço, uma conta ou lista de contas e uma lista de senhas, executando tentativas para verificar se há credenciais fracas. Uma operação controlada usa poucas credenciais de laboratório, baixa concorrência e autorização explícita.

**O que foi efetivamente observado:** FTP na porta 21 e login `anonymous` bem-sucedido sem senha. Isso é uma configuração de acesso distinta de força bruta; não demonstra que uma senha de usuário tenha sido descoberta.

**Riscos:** exposição de conteúdo quando permissões de leitura anônima estão habilitadas; acesso de escrita indevido quando permissões são excessivas; ataques de adivinhação contra contas reais.

**Prevenção:** eliminar acesso anônimo quando desnecessário, restringir diretórios/ACL, migrar para SFTP, adotar senhas fortes, limites de tentativas, atualização e registro de logs.

## Cenário B — DVWA e formulário web

**Conceito:** em um ambiente didático como o DVWA, um formulário de login pode ser usado para observar diferenças entre respostas válidas e inválidas e discutir tentativas repetidas de credenciais.

**Fluxo hipotético:** acessar o DVWA no laboratório local, identificar o formulário e os campos, criar contas e credenciais de teste, observar respostas a tentativas limitadas e avaliar controles antiabuso. Não foram coletados cookies ou tokens de sessão e não foi executada automação real.

**Riscos:** enumeração de contas, adivinhação de senhas e acesso indevido caso não haja controles.

**Prevenção:** MFA, rate limiting, mecanismos antiabuso, autenticação resistente a enumeração, política de senhas e alertas.

## Cenário C — SMB e password spraying

**Conceito:** password spraying testa uma senha candidata em diversas contas; força bruta tradicional testa muitas senhas numa conta ou serviço. O spraying visa reduzir a frequência de tentativas por conta, por isso o monitoramento deve correlacionar eventos entre múltiplos usuários.

**Fluxo hipotético:** em um domínio ou servidor SMB de laboratório com contas criadas deliberadamente, definir uma senha de teste e um pequeno conjunto de usuários autorizados, observar logs e comparar controles. A enumeração de usuários e as tentativas SMB não foram realizadas neste projeto.

**Riscos:** comprometimento de contas com senhas reutilizadas/fracas, movimento lateral e tentativas distribuídas de autenticação.

**Prevenção:** MFA onde suportado, senhas distintas e robustas, desabilitar contas antigas, monitorar falhas em múltiplos usuários, limitar exposição SMB e aplicar políticas adequadas de bloqueio.

## Checklist para ambientes reais

- [ ] Inventário e minimização de serviços expostos.
- [ ] Desativação de contas e permissões desnecessárias.
- [ ] Atualizações e configuração segura.
- [ ] Autenticação multifator onde disponível.
- [ ] Proteção contra senhas comuns e vazadas.
- [ ] Alertas sobre falhas de login em múltiplas contas.
- [ ] Revisão periódica de logs, acessos e políticas.
