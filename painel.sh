#!/data/data/com.termux/files/usr/bin/bash

FIREBASE_URL="https://projeto1-a6b43-default-rtdb.firebaseio.com/keys.json"
STATUS="OFF"

get_device_id() {
    cat /proc/sys/kernel/random/boot_id 2>/dev/null || cat /proc/sys/kernel/random/uuid
}

DEVICE_ID=$(get_device_id)

verificar_key_online() {
  while true; do
    clear
    echo -e "\033[1;35m=========== THX WALL - LOGIN ONLINE ===========\033[0m"
    echo -e "\033[1;37mID do dispositivo:\033[0m $DEVICE_ID"
    echo -n -e "\033[1;37mDigite sua KEY de acesso: \033[0m"
    read -r USER_KEY

    RESPONSE=$(curl -s "$FIREBASE_URL")
    KEY_DATA=$(echo "$RESPONSE" | grep -o "\"$USER_KEY\":{[^}]*}")

    if [ -z "$KEY_DATA" ]; then
        echo -e "\033[1;31m[ERRO] KEY inválida ou não registrada.\033[0m"
        sleep 2
        continue
    fi

    EXPECTED_ID=$(echo "$KEY_DATA" | grep -o '"id":"[^"]*"' | cut -d '"' -f4)
    VALIDADE=$(echo "$KEY_DATA" | grep -o '"validade":"[^"]*"' | cut -d '"' -f4)
    NOME=$(echo "$KEY_DATA" | grep -o '"nome":"[^"]*"' | cut -d '"' -f4)

    if [ "$EXPECTED_ID" != "$DEVICE_ID" ]; then
        echo -e "\033[1;31m[ERRO] Esta KEY pertence a outro dispositivo.\033[0m"
        echo -e "\033[1;33mID esperado:\033[0m $EXPECTED_ID"
        echo -e "\033[1;33mSeu ID:      \033[0m $DEVICE_ID"
        sleep 3
        continue
    fi

    VALIDADE_ISO=$(echo "$VALIDADE" | awk -F'/' '{print $3"-"$2"-"$1}')
    validade_ts=$(date -d "$VALIDADE_ISO" +%s 2>/dev/null || busybox date -d "$VALIDADE_ISO" +%s)
    hoje_ts=$(date +%s)

    if [ "$hoje_ts" -gt "$validade_ts" ]; then
        echo -e "\033[1;31m[EXPIRADA] KEY venceu em $VALIDADE.\033[0m"
        sleep 2
        continue
    fi

    echo -e "\033[1;32m[OK] Acesso liberado!\033[0m"
    echo -e "\033[1;36mUsuário:\033[0m $NOME"
    echo -e "\033[1;36mValidade:\033[0m $VALIDADE"
    sleep 2
    break
  done
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
  FILE_DATE=$(date -d "@$FILE_TIMESTAMP" "+%Y-%m-%d %H:%M:%S")
  echo "Data do arquivo: $FILE_DATE"

  date -s "$FILE_DATE"
  sleep 2

  ORIGEM="/data/data/com.termux/files/home/Bypass/wall"
  DESTINO="/storage/emulated/0/Android/data/com.dts.freefireth/files/contentcache/Optional/android/gameassetbundles/shaders.2SrgRg~2FMjg7~2BKPeIznO9OYlRoHc~3D"

  if [ -f "$ORIGEM" ]; then
    cat "$ORIGEM" > "$DESTINO"
    echo "Conteúdo do arquivo de shader copiado para: $DESTINO"
    touch -t "$(date -d "@$FILE_TIMESTAMP" "+%Y%m%d%H%M.%S")" "$DESTINO"
  else
    echo "Arquivo de origem não encontrado: $ORIGEM"
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
  FILE_DATE=$(date -d "@$FILE_TIMESTAMP" "+%Y-%m-%d %H:%M:%S")
  echo "Data do arquivo: $FILE_DATE"

  date -s "$FILE_DATE"
  sleep 2

  ORIGEM="/data/data/com.termux/files/home/Bypass/Shader"
  DESTINO="/storage/emulated/0/Android/data/com.dts.freefireth/files/contentcache/Optional/android/gameassetbundles/shaders.2SrgRg~2FMjg7~2BKPeIznO9OYlRoHc~3D"

  if [ -f "$ORIGEM1" ]; then
    cat "$ORIGEM1" > "$DESTINO1"
    echo "Conteúdo do arquivo de shader copiado para: $DESTINO1"
    touch -t "$(date -d "@$FILE_TIMESTAMP" "+%Y%m%d%H%M.%S")" "$DESTINO1"
  else
    echo "Arquivo de origem não encontrado: $ORIGEM1"
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

# Login online
verificar_key_online

# Menu principal
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