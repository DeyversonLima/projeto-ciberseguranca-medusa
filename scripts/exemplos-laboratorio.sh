#!/usr/bin/env bash
# EXEMPLOS DIDÁTICOS — NÃO EXECUTADOS NESTE PROJETO.
# EXECUTAR SOMENTE EM LABORATÓRIO PRÓPRIO E ISOLADO, COM AUTORIZAÇÃO.
# Abaixo, apenas exemplos de sintaxe para estudo, limitados a uma única conta
# e senhas de laboratório, sem concorrência agressiva.

# 1. Verificar disponibilidade:
medusa -V

# 2. Exemplo NÃO EXECUTADO para FTP, contra conta criada/permitida no lab:
# medusa -h 192.168.56.101 -u usuario_teste -P wordlists/senhas-exemplo.txt -M ftp -t 1

# 3. O Nmap foi efetivamente executado na sessão prática:
# nmap -sV 192.168.56.101

# 4. Login FTP anônimo realmente executado de forma interativa:
# ftp 192.168.56.101
# usuário: anonymous; senha: Enter; depois ls e quit

printf 'Exemplos didáticos; nenhum teste automatizado foi iniciado.\n'
