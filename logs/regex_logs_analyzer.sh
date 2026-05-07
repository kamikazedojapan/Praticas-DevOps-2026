#!/usr/bin/env bash
# ------------------------------------------------------------------------ #
# Script Name:   logs_analyzer.sh
# Description:   Analisa o logs Apache (CLF) e gera relatórios detalhados
# Author:        Márcio Reis
# Usage:         ./regex_log_analyzer.sh
# Version:       v1.0
# ------------------------------------------------------------------------ #

# ------------------------------- VARIABLES ------------------------------ #

LOG_FILE="$1"

if [[ -z "$LOG_FILE" ]]; then
    echo "Uso $0 <arquivo.log>"
    exit 1
fi

TIMESTAMP=$(date "+%Y%m%d_%H%M%S")

OUTPUT_DIR="log_analysis_$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

# ------------------------------- FUNCTIONS ------------------------------ #

# Função para log
log_info() {
    echo "[INFO] $1"
}

# ------------------------------- CODE ----------------------------------- #
# 1. Ips únicos
awk '{print $1}' "$LOG_FILE" | sort | uniq > "$OUTPUT_DIR/1_unique_ips.txt"

# 2. Métodos HTTP
awk -F\" '{print $2}' "$LOG_FILE" | awk '{print $1}' | sort | uniq -c | sort -nr > "$OUTPUT_DIR/2_http_methods.txt"

# 3. Métodos perigosos (DELETE e PUT)
grep -E '(DELETE|PUT)' "$LOG_FILE" > "$OUTPUT_DIR/3_dangerous_methods.txt"

# 4. URLs acessadas
awk -F\" '{print $2}' "$LOG_FILE" | awk '{print $2}' | sort | uniq -c | sort -nr > "$OUTPUT_DIR/4_urls.txt"

# 5. Top 10 IPs
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -10 > "$OUTPUT_DIR/5_top_ips.txt"

# 6. Relatório consolidado

{
    echo "===== RELATÒRIO DE ANALISE DE LOG ====="
    echo "Data: $(date)"
    echo ""

    echo "Total de IPs únicos:"
    wc -l < "$OUTPUT_DIR/1_unique_ips.txt"
    
    echo ""
    echo "Top 10 IPs únicos"
    wc -l < "$OUTPUT_DIR/5_top_ips.txt"

    echo ""
    echo "Métodos HTTP:"
    cat "$OUTPUT_DIR/2_http_methods.txt"

    echo ""
    echo "Requisições perigosas (DELETE/PUT):"
    wc -l < "$OUTPUT_DIR/3_dangerous_methods.txt"

    echo ""
    echo "Top URLs:"
    head -10 "$OUTPUT_DIR/4_urls.txt"
} > "$OUTPUT_DIR/report.txt"

echo "Análise concluida! Resultados em: $OUTPUT_DIR"
# ------------------------------- END ------------------------------------ #