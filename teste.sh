#!/data/data/com.termux/files/usr/bin/bash

# Caminho do repositório
REPO_URL="https://github.com/ssthx/Bypass"
CLONE_DIR="$HOME/Bypass"

# Arquivo de teste
ARQUIVO_ORIGEM="$CLONE_DIR/wall"
ARQUIVO_DESTINO="/sdcard/teste/wall"

# Clonar repositório se não existir
if [ ! -d "$CLONE_DIR" ]; then
    echo "Clonando repositório..."
    git clone "$REPO_URL" "$CLONE_DIR" || { echo "Erro ao clonar repositório."; exit 1; }
else
    echo "Repositório já clonado."
fi

# Criar pasta destino se não existir
mkdir -p "/sdcard/teste"

# Verificar e copiar o arquivo
if [ -f "$ARQUIVO_ORIGEM" ]; then
    cp "$ARQUIVO_ORIGEM" "$ARQUIVO_DESTINO"
    echo "Arquivo copiado com sucesso para: $ARQUIVO_DESTINO"
else
    echo "Arquivo de origem não encontrado: $ARQUIVO_ORIGEM"
fi