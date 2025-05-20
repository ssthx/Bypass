#!/data/data/com.termux/files/usr/bin/bash

ORIGEM="$HOME/Bypass/wall"
DESTINO="/sdcard/teste/wall"

mkdir -p "/sdcard/teste"

if [ -f "$ORIGEM" ]; then
    cp "$ORIGEM" "$DESTINO"
    echo "Arquivo copiado para: $DESTINO"
else
    echo "Arquivo de origem não encontrado: $ORIGEM"
fi