# Configuração do ambiente

## Host e virtualização

- Sistema principal: Windows.
- Memória RAM disponível: 16 GB.
- Virtualização do processador: habilitada.
- Hypervisor: Oracle VirtualBox.
- Máquina de auditoria: Kali Linux.
- Máquina-alvo: Metasploitable 2.

## Rede

As duas VMs utilizam uma rede **Host-only** em comum:

| Máquina | Endereço usado no teste |
| --- | --- |
| Kali Linux | `192.168.56.102` |
| Metasploitable 2 | `192.168.56.101` |

O tráfego ficou restrito ao laboratório. Evite configurar uma interface Bridge no Metasploitable, pois ele contém vulnerabilidades deliberadas.

## Verificação de conectividade

No Kali:

```bash
ping -c 4 192.168.56.101
```

Resultado registrado: quatro respostas, **0% de perda**.

## Reconhecimento

```bash
nmap -sV 192.168.56.101
```

A opção `-sV` solicita identificação de serviços e versões. O resultado foi exibido no terminal. Uma tentativa anterior de salvar arquivo em `/home/kali` falhou com `Read-only file system (30)`; por isso, a varredura validada foi executada sem redirecionamento para arquivo. Em uma tentativa também se digitou um IP incorreto (`192.168.52.101`), corrigido para `192.168.56.101`.

## Boas práticas do laboratório

- Manter as VMs vulneráveis sem exposição à rede externa.
- Tirar snapshots antes de alterações relevantes.
- Limitar testes ao IP de laboratório.
- Registrar datas, comandos, respostas e limitações.
