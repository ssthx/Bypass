#!/data/data/com.termux/files/usr/bin/bash

# Configuração
DEVICE_ID=$(cat /proc/sys/kernel/random/boot_id)
FIREBASE_URL="https://projeto1-a6b43-default-rtdb.firebaseio.com/keys.json"
STATUS="OFF"

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
        sleep 2
        continue
    fi

    VALIDADE_ISO=$(echo "$VALIDADE" | awk -F'/' '{print $3"-"$2"-"$1}')
    validade_ts=$(date -d "$VALIDADE_ISO" +%s)
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

# Ativar WALL
_wall_hack_on() {
  echo -e "\n\033[1;32m[ON] Ativando Wall Hack...\033[0m"

  ORIGEM="/data/data/com.termux/files/home/Bypass/wall"
  DESTINO="/sdcard/Android/data/com.dts.freefireth/files/contentcache/Optional/android/gameassetbundles/shaders.2SrgRg~2FMjg7~2BKPeIznO9OYlRoHc~3D"

  if [ -f "$ORIGEM" ]; then
    mkdir -p "$(dirname "$DESTINO")"
    rm -f "$DESTINO"
    cat "$ORIGEM" > "$DESTINO"
    echo "Arquivo sobrescrito com conteúdo de: wall"
  else
    echo "Arquivo wall não encontrado!"
  fi

  STATUS="ON"
  sleep 1
}

# Desativar WALL
_wall_hack_off() {
  echo -e "\n\033[1;31m[OFF] Desativando Wall Hack...\033[0m"

  ORIGEM="/data/data/com.termux/files/home/Bypass/Shader"
  DESTINO="/sdcard/Android/data/com.dts.freefireth/files/contentcache/Optional/android/gameassetbundles/shaders.2SrgRg~2FMjg7~2BKPeIznO9OYlRoHc~3D"

  if [ -f "$ORIGEM" ]; then
    mkdir -p "$(dirname "$DESTINO")"
    rm -f "$DESTINO"
    cat "$ORIGEM" > "$DESTINO"
    echo "Arquivo sobrescrito com conteúdo de: Shader"
  else
    echo "Arquivo Shader não encontrado!"
  fi

  STATUS="OFF"
  sleep 1
}

# Menu
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

# Login
verificar_key_online

# Loop do menu
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