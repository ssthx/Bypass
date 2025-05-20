#!/data/data/com.termux/files/usr/bin/bash

# Caminhos
ORIGEM="/data/data/com.termux/files/home/Bypass/wall"
DESTINO="/sdcard/teste/"

# Criar a pasta destino se necessário
mkdir -p "/sdcard/teste"

# Verificar e copiar o arquivo
if [ -f "$ORIGEM" ]; then
    cp "$ORIGEM" "$DESTINO"
    echo "Arquivo copiado com sucesso para: $DESTINO"
else
    echo "Arquivo de origem não encontrado: $ORIGEM"
fi