# Testes realizados e evidências

## 1. Ping

**Comando:** `ping -c 4 192.168.56.101`

**Resultado:** 4 pacotes transmitidos, 4 recebidos; perda de 0%. A conectividade foi confirmada.

## 2. Reconhecimento Nmap

**Comando:** `nmap -sV 192.168.56.101`

**Resultado:** Nmap 7.99 identificou o host ativo e **23 portas TCP abertas** no conjunto de 1.000 portas escaneadas. Entre os serviços: FTP 21, SSH 22, Telnet 23, HTTP 80, SMB 139/445, FTP 2121 e bancos de dados 3306/5432.

**Evidência:** [captura Nmap](../images/01-nmap-servicos.png).

**Limitação:** identificação de versão não é prova de uma vulnerabilidade explorável; nenhuma exploração por versão foi realizada.

## 3. Login FTP anônimo

**Comando:** `ftp 192.168.56.101`

**Credenciais informadas:** usuário `anonymous`; campo de senha vazio.

**Resposta do servidor:** `230 Login successful.`

**Evidência:** [captura login FTP](../images/02-ftp-login-anonimo.png).

**Interpretação:** o servidor aceita autenticação anônima; o risco depende das permissões e da finalidade desse acesso.

## 4. Listagem de diretório

Após login FTP anônimo:

```text
ftp> ls
229 Entering Extended Passive Mode (...)
150 Here comes the directory listing.
226 Directory send OK.
ftp> quit
221 Goodbye.
```

Nenhum item foi apresentado entre o início e o fim da listagem.

**Evidência:** [captura listagem FTP](../images/03-ftp-listagem.png).

**Limitação:** sem evidência de acesso de escrita, download de arquivos, leitura de dados confidenciais ou execução remota.

## 5. Disponibilidade do Medusa

O usuário verificou a disponibilidade do **Medusa v2.3** na máquina Kali. Não há evidência de execução de tentativas automatizadas de autenticação com Medusa neste laboratório.

## Escopo não executado

- Ataque de força bruta com Medusa contra FTP.
- Instalação e automação de login no DVWA.
- Enumeração de contas ou password spraying SMB.

Essas técnicas foram documentadas separadamente como exemplos educacionais e conceitos de defesa.
