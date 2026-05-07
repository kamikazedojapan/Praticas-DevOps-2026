#!/usr/bin/env bash
# ------------------------------------------------------------------------ #
# Script Name:   install_webserver.sh
# Description:   Instala e configura o Apache ou o Nginx web server
# Author:        Márcio Reis
# Usage:         ./install_webserver.sh [apache | nginx]
# Version:       v1.0
# ------------------------------------------------------------------------ #

# ------------------------------- VARIABLES ------------------------------ #

SERVER_TYPE="$1"
LOG_FILE="./webserver_install.log"
WEB_ROOT="/var/www/screenmatch"

# ------------------------------- FUNCTIONS ------------------------------ #

log_info() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [INFO] $1" \
    | tee -a "$LOG_FILE"
}

log_error() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [ERROR] $1" \
    | tee -a "$LOG_FILE"
}

check_root() {
    if [[ "$EUID" -ne 0 ]]; then
        log_error "Execute o script como root."
        exit 1
    fi
}

create_web_root() {
    mkdir -p "$WEB_ROOT"

    echo "<h1>Servidor Web funcionando!</h1>" \
    > "$WEB_ROOT/index.html"

    log_info "Diretório web criado em $WEB_ROOT"
}

install_nginx() {

    log_info "Iniciando instalação do Nginx..."

    log_info "Atualizando repositórios..."
    apt update -y >> "$LOG_FILE" 2>&1

    log_info "Instalando Nginx..."

    if apt install nginx -y >> "$LOG_FILE" 2>&1; then
        log_info "Nginx instalado com sucesso."
    else
        log_error "Falha ao instalar Nginx."
        exit 1
    fi

    systemctl stop apache2 2>/dev/null
    
    systemctl enable nginx >> "$LOG_FILE" 2>&1
    systemctl start nginx >> "$LOG_FILE" 2>&1

    if systemctl is-active --quiet nginx; then
        log_info "Serviço Nginx está ativo."
    else
        log_error "Nginx não iniciou corretamente."
        exit 1
    fi
}

install_apache() {

    log_info "Iniciando instalação do Apache..."

    log_info "Atualizando repositórios..."
    apt update -y >> "$LOG_FILE" 2>&1
    
    log_info "Instalando Apache..."
    
    if apt install apache2 -y >> "$LOG_FILE" 2>&1; then
        log_info "Apache instalado com sucesso."
    else 
        log_error "Falha ao instalar Apache."
        exit 1
    fi

    systemctl stop nginx 2>/dev/null

    systemctl enable apache2 >> "$LOG_FILE" 2>&1
    systemctl start apache2 >> "$LOG_FILE" 2>&1

    if systemctl is-active --quiet apache2; then
        log_info "Serviço Apache está ativo."
    else
        log_error "Apache não inciou corretamente."
        exit 1
    fi
}

show_usage() {
    echo "Uso: $0 [apache|nginx]"
    exit 1
}


# ------------------------------- CODE ----------------------------------- #

check_root

if [[ -z "$SERVER_TYPE" ]]; then
    show_usage
fi

create_web_root

case "$SERVER_TYPE" in

    nginx)
        install_nginx
        ;;
    
    apache)
        install_apache
        ;;
    
    *)
        log_error "Servidor inválido: $SERVER_TYPE"
        show_usage
        ;;

esac

log_info "instalação finalizada com sucesso."
    
# ------------------------------- END ------------------------------------ #