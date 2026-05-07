#!/usr/bin/env bash
# ------------------------------------------------------------------------ #
# Script Name:   update-system.sh
# Description:   Atualiza o sistema operacional e limpa pacotes desnecessários
# Author:        Marcio Reis
# Site:          https://github.com/seuusuario/Praticas-DevOps-2026
# ------------------------------------------------------------------------ #
# Usage:
#       $ ./update-system.sh
# ------------------------------------------------------------------------ #
# Tested on:
#       Bash 5.x (Ubuntu/Debian)
# ------------------------------------------------------------------------ #
# History:
#       v1.0 29/04/2026, Marcio:
#       - Versão inicial com update e limpeza
# ------------------------------------------------------------------------ #

# ------------------------------- VARIABLES ------------------------------ #
LOG_FILE="../logs/update-system.log"
DATE=$(date "+%Y-%m-%d %H:%M:%S")

# ------------------------------- FUNCTIONS ------------------------------ #

log_info() {
    echo "[$DATE] [INFO] $1" | tee -a "$LOG_FILE"
}

log_error() {
    echo "[$DATE] [ERROR] $1" | tee -a "$LOG_FILE"
}

check_root() {
    if [[ "$EUID" -ne 0 ]]; then
        log_error "Este script precisa ser executado como root!"
        exit 1
    fi
}

# ------------------------------- CODE ----------------------------------- #

check_root

log_info "Iniciando atualização do sistema..."

if apt update -y >> "$LOG_FILE" 2>&1; then
    log_info "Repositórios atualizados com sucesso."
else
    log_error "Falha no apt update."
    exit 1
fi

if apt upgrade -y >> "$LOG_FILE" 2>&1; then
    log_info "Sistema atualizado com sucesso."
else
    log_error "Falha no apt upgrade."
    exit 1
fi

if apt clean >> "$LOG_FILE" 2>&1; then
    log_info "Limpeza concluída."
else
    log_error "Falha na limpeza."
fi

log_info "Processo finalizado com sucesso!"

# ------------------------------- END ------------------------------------ #