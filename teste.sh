#!/data/data/com.termux/files/usr/bin/bash

# Caminho da origem e destino
ORIGEM="$HOME/Bypass/wall"
DESTINO="/sdcard/teste/wall"

# Criar pasta destino se não existir
mkdir -p "/sdcard/teste"

# Verificar e copiar o arquivo
if [ -f "$ORIGEM" ]; then
    cp "$ORIGEM" "$DESTINO"
    echo "Arquivo copiado com sucesso para: $DESTINO"
else
    echo "Arquivo de origem não encontrado: $ORIGEM"
fi