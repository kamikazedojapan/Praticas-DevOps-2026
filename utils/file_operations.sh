#!/usr/bin/env bash
# ------------------------------------------------------------------------ #
# Nome do Script: file_operations.sh
# Descrição:     Script multifuncional para operações com arquivos
# Site:
# Escrito por:   Márcio Reis
# Manutenção:    Márcio Reis
# ------------------------------------------------------------------------ #
# Uso:
#       $ ./file_operations.sh [opção] [argumentos]
#       $ ./file_operations.sh --menu (para modo interativo)
#
# Exemplos:
#       $ ./file_operations.sh renomear
#       $ ./file_operations.sh converter
#       $ ./file_operations.sh compactar
#       $ ./file_operations.sh extrair
#       $ ./file_operations.sh permissao
#       $ ./file_operations.sh buscar
# ------------------------------------------------------------------------ #

# VARIÁVEIS --------------------------------------------------------------- #
OPERACAO="$1"
ARG1="$2"
ARG2="$3"

# FUNÇÕES ----------------------------------------------------------------- #

mostrar_menu() {

    clear

    echo "=========================================="
    echo "   OPERAÇÕES COM ARQUIVOS - DevOps Tools"
    echo "=========================================="
    echo ""
    echo "1. Renomear arquivos (prefixo/sufixo)"
    echo "2. Converter imagens (JPG para PNG)"
    echo "3. Compactar arquivos/diretórios"
    echo "4. Extrair arquivos compactados"
    echo "5. Alterar permissões"
    echo "6. Buscar arquivos por padrão"
    echo "0. Sair"
    echo ""
    echo -n "Escolha uma opção: "
}

# ------------------------------------------------------------------------ #
# Função: renomear_arquivos
# Descrição:
#       Renomeia arquivos adicionando prefixo ou sufixo
#
# Exemplo:
#       arquivo.txt -> backup_arquivo.txt
#
# Ajuda:
#       man mv
# ------------------------------------------------------------------------ #

renomear_arquivos() {

    echo "========== RENOMEAR ARQUIVOS =========="
    echo ""

    read -p "Digite o diretório: " diretorio
    read -p "Adicionar prefixo ou sufixo? (p/s): " modo
    read -p "Texto para adicionar: " texto

    if [ ! -d "$diretorio" ]; then
        echo "Diretório não encontrado!"
        return
    fi

    for arquivo in "$diretorio"/*; do

        [ -f "$arquivo" ] || continue

        nome_arquivo=$(basename "$arquivo")

        if [ "$modo" = "p" ]; then

            mv "$arquivo" "$diretorio/${texto}_${nome_arquivo}"

        elif [ "$modo" = "s" ]; then

            extensao="${nome_arquivo##*.}"
            nome="${nome_arquivo%.*}"

            mv "$arquivo" "$diretorio/${nome}_${texto}.${extensao}"

        else
            echo "Opção inválida!"
            return
        fi
    done

    echo ""
    echo "Arquivos renomeados com sucesso!"
}

# ------------------------------------------------------------------------ #
# Função: converter_imagens
# Descrição:
#       Converte imagens JPG para PNG
#
# Dependência:
#       imagemagick
#
# Instalação:
#       sudo apt install imagemagick
#
# Exemplo:
#       imagem.jpg -> imagem.png
#
# Ajuda:
#       man convert
# ------------------------------------------------------------------------ #

converter_imagens() {

    echo "========== CONVERSÃO DE IMAGENS =========="
    echo ""

    read -p "Digite o diretório das imagens JPG: " diretorio

    if [ ! -d "$diretorio" ]; then
        echo "Diretório não encontrado!"
        return
    fi

    for imagem in "$diretorio"/*.jpg; do

        [ -f "$imagem" ] || continue

        saida="${imagem%.jpg}.png"

        convert "$imagem" "$saida"

        echo "Convertido: $imagem -> $saida"
    done

    echo ""
    echo "Conversão concluída!"
}

# ------------------------------------------------------------------------ #
# Função: compactar_arquivos
# Descrição:
#       Compacta arquivos ou diretórios usando tar.gz
#
# Exemplo:
#       backup.tar.gz
#
# Ajuda:
#       man tar
# ------------------------------------------------------------------------ #

compactar_arquivos() {

    echo "========== COMPACTAR ARQUIVOS =========="
    echo ""

    read -p "Digite o arquivo ou diretório: " alvo

    if [ ! -e "$alvo" ]; then
        echo "Arquivo ou diretório não encontrado!"
        return
    fi

    nome_compactado="$(basename "$alvo").tar.gz"

    tar -czvf "$nome_compactado" "$alvo"

    echo ""
    echo "Compactação concluída: $nome_compactado"
}

# ------------------------------------------------------------------------ #
# Função: extrair_arquivos
# Descrição:
#       Extrai arquivos compactados .tar.gz
#
# Exemplo:
#       backup.tar.gz
#
# Ajuda:
#       man tar
# ------------------------------------------------------------------------ #

extrair_arquivos() {

    echo "========== EXTRAIR ARQUIVOS =========="
    echo ""

    read -p "Digite o arquivo compactado (.tar.gz): " arquivo

    if [ ! -f "$arquivo" ]; then
        echo "Arquivo não encontrado!"
        return
    fi

    tar -xzvf "$arquivo"

    echo ""
    echo "Extração concluída!"
}

# ------------------------------------------------------------------------ #
# Função: alterar_permissoes
# Descrição:
#       Altera permissões de arquivos ou diretórios
#
# Exemplo:
#       chmod 755 script.sh
#
# Ajuda:
#       man chmod
# ------------------------------------------------------------------------ #

alterar_permissoes() {

    echo "========== ALTERAR PERMISSÕES =========="
    echo ""

    read -p "Digite o arquivo ou diretório: " alvo
    read -p "Digite a permissão (exemplo: 755): " permissao

    if [ ! -e "$alvo" ]; then
        echo "Arquivo ou diretório não encontrado!"
        return
    fi

    chmod "$permissao" "$alvo"

    echo ""
    echo "Permissões alteradas com sucesso!"
}

# ------------------------------------------------------------------------ #
# Função: buscar_arquivos
# Descrição:
#       Busca arquivos por padrão/nome
#
# Exemplo:
#       *.txt
#
# Ajuda:
#       man find
# ------------------------------------------------------------------------ #

buscar_arquivos() {

    echo "========== BUSCAR ARQUIVOS =========="
    echo ""

    read -p "Digite o diretório de busca: " diretorio
    read -p "Digite o padrão (exemplo: *.txt): " padrao

    if [ ! -d "$diretorio" ]; then
        echo "Diretório não encontrado!"
        return
    fi

    find "$diretorio" -type f -name "$padrao"
}

# CÓDIGO PRINCIPAL -------------------------------------------------------- #

# Suporte para modo de linha de comando
if [ "$OPERACAO" = "--menu" ] || [ -z "$OPERACAO" ]; then

    while true; do

        mostrar_menu

        read opcao

        case $opcao in

            1)
                renomear_arquivos
            ;;

            2)
                converter_imagens
            ;;

            3)
                compactar_arquivos
            ;;

            4)
                extrair_arquivos
            ;;

            5)
                alterar_permissoes
            ;;

            6)
                buscar_arquivos
            ;;

            0)
                echo "Encerrando script..."
                exit 0
            ;;

            *)
                echo "Opção inválida!"
            ;;
        esac

        echo ""
        echo -n "Pressione Enter para continuar..."
        read

    done

else

    # Modo linha de comando
    case "$OPERACAO" in

        "renomear")
            renomear_arquivos
        ;;

        "converter")
            converter_imagens
        ;;

        "compactar")
            compactar_arquivos
        ;;

        "extrair")
            extrair_arquivos
        ;;

        "permissao")
            alterar_permissoes
        ;;

        "buscar")
            buscar_arquivos
        ;;

        *)
            echo "Uso: $0 [--menu|renomear|converter|compactar|extrair|permissao|buscar]"
        ;;
    esac
fi