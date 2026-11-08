#!/usr/bin/env bash
# EXEMPLO DIDÁTICO — NÃO EXECUTADO NESTE PROJETO.
# Use somente em sistemas próprios, isolados e expressamente autorizados.
# Este arquivo é inerte: apenas exibe comandos e não inicia Nmap, FTP ou Medusa.

set -eu

printf '%s\n' \
  'Exemplos didáticos; nenhum teste será iniciado.' \
  '' \
  '# Verificação de versão (relatada, sem captura no repositório):' \
  'medusa -V' \
  '' \
  '# Sintaxe de estudo para uma conta fictícia de laboratório — NÃO EXECUTADA:' \
  'medusa -h 192.168.56.101 -u lab_usuario_01 -P wordlists/senhas-exemplo.txt -M ftp -t 1' \
  '' \
  '# Comandos executados interativamente e documentados no README:' \
  'ping -c 4 192.168.56.101' \
  'nmap -sV 192.168.56.101' \
  'ftp 192.168.56.101'
