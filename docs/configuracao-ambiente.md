# Configuração e isolamento do ambiente

[Voltar ao README](../README.md)

## Componentes registrados

| Componente | Configuração |
| --- | --- |
| Sistema hospedeiro | Windows, com 16 GB de RAM e virtualização habilitada |
| Hypervisor | Oracle VirtualBox |
| Máquina de auditoria | Kali Linux (`192.168.56.102`) |
| Máquina-alvo | Metasploitable 2 (`192.168.56.101`) |
| Rede | Host-only compartilhada pelas duas VMs |

Os dados acima foram registrados durante o laboratório. Não há captura específica das telas de configuração do VirtualBox no repositório.

## Topologia e cuidados

```text
Kali Linux (192.168.56.102)
            |
      Rede Host-only
            |
Metasploitable 2 (192.168.56.101)
```

A rede Host-only mantém a comunicação entre host e VMs sem colocar o Metasploitable 2 diretamente na rede física. Como o alvo contém vulnerabilidades deliberadas:

- não configure uma interface Bridge;
- confirme o IP antes de executar qualquer comando;
- mantenha o escopo restrito às VMs próprias;
- use snapshots antes de alterações relevantes;
- registre data, comando, saída e limitação de cada atividade.

## Validações executadas

No Kali, a conectividade foi verificada com:

```bash
ping -c 4 192.168.56.101
```

Foram registrados quatro pacotes enviados, quatro recebidos e 0% de perda. A mesma captura contém o reconhecimento:

```bash
nmap -sV 192.168.56.101
```

A opção `-sV` solicita detecção de serviços e versões. A evidência está em [`images/01-nmap-servicos.png`](../images/01-nmap-servicos.png).

## Ocorrências da sessão

Uma tentativa anterior de salvar a saída em `/home/kali` retornou `Read-only file system (30)`. Também foi digitado inicialmente o endereço incorreto `192.168.52.101`; o endereço foi corrigido para `192.168.56.101` antes da execução documentada. Esses erros não são resultados do alvo, mas registros úteis para reprodução e diagnóstico.
