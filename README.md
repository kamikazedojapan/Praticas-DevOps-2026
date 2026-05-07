# Comandos do bash (Linux)🐧
## 1. grep - Buscar texto em arquivos
### Funcionalidade: Procura padrões (palavras/frases) dentro dos arquivos.
#### Exemplo:  
`grep "erro" log.txt`

#### Demonstração:  
`echo "erro ao conectar" > log.txt`  
`echo "sucesso" >> log.txt`  
`grep "erro" log.txt`

#### Saída:
Erro ao conectar


## 2. touch - Criar arquivos
### Funcionalidade: Criar arquivo vazio ou atualiza data de modificação.
#### Exemplo:  
`touch teste.txt`  

#### Demonstração:
`touch teste.txt`  
`ls`

## 3. curl - Requisições HTTP
### Funcionalidade: Faz requisições para APIs ou baixa o conteúdo diretamente da internet.
#### Exemplo:  
`curl https://api.github.com`  

#### Demonstração:
`curl -o site.html https://example.com`


## 4. cat — Mostrar conteúdo de arquivos
### O que faz: Exibe conteúdo no terminal.

#### Exemplo:
`cat arquivo.txt`
#### Demonstração:
`echo "Olá mundo" > arquivo.txt`  
`cat arquivo.txt`

Saída:  
Olá mundo

## 5. gzip — Compactar arquivos
### O que faz: Compacta arquivos (gera .gz).

#### Exemplo:
`gzip arquivo.txt`
#### Demonstração:
`echo "dados importantes" > dados.txt`  
`gzip dados.txt`  
`ls`

#### Resultado:  
📁 dados.txt.gz

#### Para descompactar:

`gunzip dados.txt.gz`

## 6. chmod — Permissões
### O que faz: Define permissões de leitura, escrita e execução.

#### Exemplo:
`chmod +x script.sh`
#### Demonstração:
`touch script.sh`  
`chmod +x script.sh`  
`ls -l`

#### Saída:

rwxr-xr-x script.sh

## 7. date — Data e hora
### O que faz: Mostra data/hora atual.

#### Exemplo:
`date`
#### Demonstração:
`date "+%Y-%m-%d %H:%M:%S"`

#### Saída:
2026-04-20 14:30:00

## 8. pwd — Diretório atual
### O que faz: mostra em qual pasta você está no sistema.

#### Exemplo:
`pwd`
#### Demonstração:
`cd /tmp`  
`pwd`
#### Saída:

/tmp

## 9. pgrep — Buscar processos
### O que faz: Encontra PID de processos pelo nome.

#### Exemplo:
`pgrep bash`
#### Demonstração:
`sleep 1000 & pgrep sleep`

#### Saída:
PID do processo.

## 10. ps — Processos ativos
### O que faz: Mostra processos em execução.

#### Exemplo:
`ps aux`
## Demonstração:
`ps aux | grep bash`
#### Saída: 
Mostra processos do bash.

## 11. df — Espaço em disco
### O que faz: Mostra uso de disco.

#### Exemplo:
`df -h`
#### Demonstração:
`df -h`

#### Saída:
Filesystem  Size  Used Avail Use%  
/dev/sda1    50G   20G   30G  40%

-h = formato legível.

## 12. du — Uso de diretórios
### O que faz: Mostra tamanho de arquivos/pastas.

#### Exemplo:
`du -sh pasta/`
#### Demonstração:
`du -sh .`
#### Saída:
120M .
