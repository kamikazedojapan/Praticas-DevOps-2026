#!/usr/bin/env bash
# ------------------------------------------------------------------------ #
# Script Name:   update-system.sh
# Description:   Atualiza os pacotes do sistema e limpa arquivos desnecessários
# Author:        Marcio Reis
# Site:          github.com/kamikazedojapan/Praticas-DevOps-2026
# ------------------------------------------------------------------------ #
# Usage:
#       $ ./update-system.sh
# ------------------------------------------------------------------------ #
# Tested on:
#       Bash 5.x
# ------------------------------------------------------------------------ #
# History:
#       v1.0 20/04/2026, Marcio:
#           - Versão inicial
# ------------------------------------------------------------------------ #

# ------------------------------- VARIABLES ------------------------------ #
LOG_FILE="./comandos.log"

# ------------------------------- FUNCTIONS ------------------------------ #
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [INFO] $1" | tee -a "$LOG_FILE"
}
# -------------------------------- CODE ---------------------------------- #
log "Iniciando demonstrações..."

# ------------------------------------------------------------------------ #
# GREP
# Descrição: Busca padrões em arquivos
# Exemplo: grep "texto" arquivo.txt
# Help: man grep | grep --help
log "Executando GREP"
echo "erro no sistema" > exemplo.txt
echo "tudo ok" >> exemplo.txt
grep "erro" exemplo.txt

# ------------------------------------------------------------------------ #
# TOUCH
# Descrição: Cria arquivos vazios
# Exemplo: touch arquivo.txt
# Help: man touch | touch --help
log "Executando TOUCH"
touch arquivo_touch.txt

# ------------------------------------------------------------------------ #
# CURL
# Descrição: Faz requisições HTTP
# Exemplo: curl https://example.com
# Help: man curl | curl --help
log "Executando CURL"
curl -o exemplo.html https://example.com

# ------------------------------------------------------------------------ #
# CAT
# Descrição: Exibe conteúdo de arquivos
# Exemplo: cat arquivo.txt
# Help: man cat | cat --help
log "Executando CAT"
cat exemplo.txt

# ------------------------------------------------------------------------ #
# GZIP
# Descrição: Compacta arquivos
# Exemplo: gzip arquivo.txt
# Help: man gzip | gzip --help
log "Executando GZIP"
gzip -k exemplo.txt   # -k mantém original

# ------------------------------------------------------------------------ #
# CHMOD
# Descrição: Altera permissões
# Exemplo: chmod +x script.sh
# Help: man chmod | chmod --help
log "Executando CHMOD"
touch script.sh
chmod +x script.sh

# ------------------------------------------------------------------------ #
# DATE
# Descrição: Mostra data e hora
# Exemplo: date "+%Y-%m-%d"
# Help: man date | date --help
log "Executando DATE"
date "+%Y-%m-%d %H:%M:%S"

# ------------------------------------------------------------------------ #
# PWD
# Descrição: Mostra diretório atual
# Exemplo: pwd
# Help: man pwd | pwd --help
log "Executando PWD"
pwd

# ------------------------------------------------------------------------ #
# PGREP
# Descrição: Busca processos pelo nome
# Exemplo: pgrep bash
# Help: man pgrep | pgrep --help
log "Executando PGREP"
sleep 60 &
pgrep sleep

# ------------------------------------------------------------------------ #
# PS
# Descrição: Lista processos
# Exemplo: ps aux
# Help: man ps | ps --help
log "Executando PS"
ps aux | grep sleep

# ------------------------------------------------------------------------ #
# DF
# Descrição: Mostra uso de disco
# Exemplo: df -h
# Help: man df | df --help
log "Executando DF"
df -h

# ------------------------------------------------------------------------ #
# DU
# Descrição: Mostra tamanho de arquivos/pastas
# Exemplo: du -sh pasta/
# Help: man du | du --help
log "Executando DU"
du -sh .

log "Script finalizado."

# -------------------------------- END ----------------------------------- #