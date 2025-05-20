#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_PATH="/sdcard/bypass.sha.sh"
KEY_CORRETA="123456"
STATUS="OFF"

verificar_key() {
  clear
  echo -e "\033[1;35m=========== THX WALL ===========\033[0m"
  echo -n -e "\033[1;37mDigite a Key de acesso: \033[0m"
  read -r key
  if [ "$key" != "$KEY_CORRETA" ]; then
    echo -e "\033[1;31mKey incorreta! Encerrando...\033[0m"
    sleep 1
    exit 1
  fi
}

_wall_hack_on() {
  echo -e "\n\033[1;32m[ON] Ativando Wall Hack...\033[0m"
  settings put global auto_time 0
  settings put global auto_time_zone 0
  sleep 1

  CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")
  echo "Data atual: $CURRENT_DATE"

  OBB_PATH="/sdcard/Android/obb/com.dts.freefireth"
  OBB_FILE=$(find "$OBB_PATH" -type f -name "*.obb" | head -n 1)

  if [ ! -f "$OBB_FILE" ]; then
    echo "Nenhum arquivo .obb encontrado!"
    date -s "$CURRENT_DATE"
    settings put global auto_time 1
    settings put global auto_time_zone 1
    exit 1
  fi

  echo "Arquivo .obb encontrado: $OBB_FILE"

  FILE_TIMESTAMP=$(stat -c "%Y" "$OBB_FILE")
  echo "Timestamp do arquivo: $FILE_TIMESTAMP"

  FILE_DATE=$(date -d "@$FILE_TIMESTAMP" "+%Y-%m-%d %H:%M:%S")
  echo "Data do arquivo: $FILE_DATE"

  date -s "$FILE_DATE"
  sleep 2

  ORIGEM="/data/data/com.termux/files/home/Bypass/wall"
  DESTINO="/sdcard/teste/teste"

  if [ -f "$ORIGEM" ]; then
    mkdir -p "$(dirname "$DESTINO")"
    cat "$ORIGEM" > "$DESTINO"
    echo "Arquivo 'wall' copiado para: $DESTINO"
    touch -t "$(date -d "@$FILE_TIMESTAMP" "+%Y%m%d%H%M.%S")" "$DESTINO"
  else
    echo "Arquivo 'wall' não encontrado: $ORIGEM"
  fi

  date -s "$CURRENT_DATE"
  echo "Data restaurada: $CURRENT_DATE"

  settings put global auto_time 1
  settings put global auto_time_zone 1

  echo "Processo concluído."
  STATUS="ON"
  sleep 1
}

_wall_hack_off() {
  echo -e "\n\033[1;31m[OFF] Wall Hack desativado.\033[0m"
  settings put global auto_time 0
  settings put global auto_time_zone 0
  sleep 1

  CURRENT_DATE=$(date "+%Y-%m-%d %H:%M:%S")
  echo "Data atual: $CURRENT_DATE"

  OBB_PATH="/sdcard/Android/obb/com.dts.freefireth"
  OBB_FILE=$(find "$OBB_PATH" -type f -name "*.obb" | head -n 1)

  if [ ! -f "$OBB_FILE" ]; then
    echo "Nenhum arquivo .obb encontrado!"
    date -s "$CURRENT_DATE"
    settings put global auto_time 1
    settings put global auto_time_zone 1
    exit 1
  fi

  echo "Arquivo .obb encontrado: $OBB_FILE"

  FILE_TIMESTAMP=$(stat -c "%Y" "$OBB_FILE")
  echo "Timestamp do arquivo: $FILE_TIMESTAMP"

  FILE_DATE=$(date -d "@$FILE_TIMESTAMP" "+%Y-%m-%d %H:%M:%S")
  echo "Data do arquivo: $FILE_DATE"

  date -s "$FILE_DATE"
  sleep 2

  ORIGEM="$HOME/Bypass/Shaderpadrao"
  DESTINO="/sdcard/teste/teste"

  if [ -f "$ORIGEM" ]; then
    mkdir -p "$(dirname "$DESTINO")"
    cat "$ORIGEM" > "$DESTINO"
    echo "Arquivo 'Shaderpadrao' copiado para: $DESTINO"
    touch -t "$(date -d "@$FILE_TIMESTAMP" "+%Y%m%d%H%M.%S")" "$DESTINO"
  else
    echo "Arquivo 'Shaderpadrao' não encontrado: $ORIGEM"
  fi

  date -s "$CURRENT_DATE"
  echo "Data restaurada: $CURRENT_DATE"

  settings put global auto_time 1
  settings put global auto_time_zone 1

  echo "Processo concluído."
  STATUS="OFF"
  sleep 1
}

mostrar_menu() {
  clear
  echo -e "\033[1;35m=========== THX WALL ===========\033[0m"
  if [ "$STATUS" = "OFF" ]; then
    echo -e "\033[1;31m[1] WALL HACK [OFF]\033[0m"
  else
    echo -e "\033[1;32m[1] WALL HACK [ON]\033[0m"
  fi
  echo -e "\033[1;33m[2] SAIR\033[0m"
  echo -e "\033[1;35m===============================\033[0m"
  echo -n -e "\033[1;37mEscolha uma opção: \033[0m"
}

verificar_key

while true; do
  mostrar_menu
  read -r opcao
  case "$opcao" in
    1)
      if [ "$STATUS" = "OFF" ]; then
        _wall_hack_on
      else
        _wall_hack_off
      fi
      ;;
    2)
      echo -e "\033[1;31mSaindo...\033[0m"
      exit 0
      ;;
    *)
      echo -e "\033[1;31mOpção inválida.\033[0m"
      sleep 1
      ;;
  esac
done