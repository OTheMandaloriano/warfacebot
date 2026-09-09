#!/usr/bin/env bash
# ==============================================================================
# WARFACEBOT - CONSOLE LAUNCHER & SESSION MANAGER
# Based on WarfaceBot by Levak Borok
# Multi-language: English / Русский / Português (Brasil)
# ==============================================================================

# Cores ANSI
C_RED='\033[1;31m'
C_GREEN='\033[1;32m'
C_YELLOW='\033[1;33m'
C_BLUE='\033[0;34m'
C_CYAN='\033[1;36m'
C_WHITE='\033[1;37m'
C_GRAY='\033[0;90m'
BG_BLUE='\E[44;1;37m'
RESET='\033[0m'
BARRA="${C_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/.wb_config"

# Variaveis de Configuracao
SERVER_IP="127.0.0.1"
SERVER_PORT="5222"
GAME_VERSION="1.11700.452.21500"
BOT_UID=""
BOT_TOKEN=""
BOT_NICK=""
CURRENT_LANG=""

clean_str() {
    local s="$1"
    s="${s//$'\r'/}"
    s="${s//$'\xef\xbb\xbf'/}"
    echo "$s"
}

check_server_socket() {
    if timeout 1 bash -c "</dev/tcp/$SERVER_IP/$SERVER_PORT" 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

set_language() {
    CURRENT_LANG="$1"
    case "$CURRENT_LANG" in
        ru)
            L_BANNER="WARFACEBOT • ПАНЕЛЬ УПРАВЛЕНИЯ | Levak"
            L_SRV_DATA="ПАРАМЕТРЫ ПОДКЛЮЧЕНИЯ"
            L_LBL_HOST="Сервер / IP:   "
            L_LBL_PORT="Порт XMPP:     "
            L_LBL_VER="Версия игры:   "
            L_LBL_UID="UID аккаунта:  "
            L_LBL_NICK="Позывной:      "
            L_LBL_STATUS="Статус сети:   "
            L_STATUS_ONLINE="ОНЛАЙН [ПОРТ ОТКРЫТ]"
            L_STATUS_OFFLINE="ОФФЛАЙН [ПОРТ НЕДОСТУПЕН]"
            L_OPT_START="ПОДКЛЮЧИТЬСЯ К ИГРЕ (wb.exe)"
            L_OPT_TEST="ПРОВЕРИТЬ СВЯЗЬ С СЕРВЕРОМ"
            L_OPT_CFG="НАСТРОИТЬ АККАУНТ И СЕРВЕР"
            L_OPT_LANG="СМЕНИТЬ ЯЗЫК"
            L_OPT_EXIT="ВЫХОД"
            L_PROMPT="Выберите действие"
            L_DISCONNECTING="Отключение..."
            L_WIZ_TITLE="НАЧАЛЬНАЯ НАСТРОЙКА"
            L_WIZ_SRV_IP="Адрес сервера / IP"
            L_WIZ_SRV_PORT="Порт сервера"
            L_WIZ_GAME_VER="Версия игры Warface"
            L_WIZ_LOGIN="Login / UID аккаунта"
            L_WIZ_TOKEN="Пароль / Токен аккаунта"
            L_WIZ_NICK="Позывной бота"
            L_WIZ_SAVING="Сохранение настроек..."
            L_CONNECTING="Запуск WarfaceBot..."
            L_CMD_HEADER="ДОСТУПНЫЕ КОМАНДЫ В CMD# БОТА:"
            L_CMD_FRIENDS="friends              - Список друзей"
            L_CMD_FOLLOW="follow <ник>         - Следовать за игроком в комнату"
            L_CMD_INVITE="invite <ник>         - Пригласить игрока в комнату"
            L_CMD_READY="ready [класс]        - Готов / смена класса (medic, sniper, ...)"
            L_CMD_UNREADY="unready              - Снять готовность"
            L_CMD_OPEN="open <миссия/карта>  - Создать PvE или PvP комнату"
            L_CMD_START="start                - Начать матч (когда глава комнаты)"
            L_CMD_LEAVE="leave                - Выйти из комнаты"
            L_CMD_MASTER="master <ник>         - Передать главу комнаты"
            L_CMD_SAY="say <сообщение>      - Сообщение в чат комнаты"
            L_CMD_WHISPER="whisper <ник> <сооб> - Личное сообщение"
            L_CMD_STATS="stats                - Статистика сессии"
            L_CMD_QUIT="quit                 - Отключиться и вернуться в меню"
            L_PRESS_ENTER="Нажмите ENTER для возврата..."
            L_TEST_RUNNING="Проверка соединения с $SERVER_IP:$SERVER_PORT..."
            L_TEST_SUCCESS="Подключение успешно! Сервер активен и принимает запросы."
            L_TEST_FAILED="Ошибка: Порт $SERVER_PORT на $SERVER_IP закрыт или недоступен."
            ;;
        pt)
            L_BANNER="WARFACEBOT • PAINEL DE CONTROLE | Levak"
            L_SRV_DATA="PARAMETROS DE CONEXAO"
            L_LBL_HOST="Servidor / Host: "
            L_LBL_PORT="Porta XMPP:      "
            L_LBL_VER="Versao do Jogo:  "
            L_LBL_UID="UID da Conta:    "
            L_LBL_NICK="Codinome / Nick: "
            L_LBL_STATUS="Status da Rede:  "
            L_STATUS_ONLINE="ONLINE [PORTA ABERTA]"
            L_STATUS_OFFLINE="OFFLINE [PORTA INACESSIVEL]"
            L_OPT_START="CONECTAR AO JOGO (SESSAO REAL - wb.exe)"
            L_OPT_TEST="TESTAR CONEXAO COM O SERVIDOR (SOCKET TEST)"
            L_OPT_CFG="CONFIGURAR CONTA E SERVIDOR (WIZARD)"
            L_OPT_LANG="ALTERAR IDIOMA (LANGUAGE)"
            L_OPT_EXIT="SAIR"
            L_PROMPT="Escolha uma opcao"
            L_DISCONNECTING="Encerrando..."
            L_WIZ_TITLE="CONFIGURACAO DE CONEXAO"
            L_WIZ_SRV_IP="Endereco do Servidor / IP"
            L_WIZ_SRV_PORT="Porta do Servidor"
            L_WIZ_GAME_VER="Versao do Warface"
            L_WIZ_LOGIN="Login / UID da Conta"
            L_WIZ_TOKEN="Senha / Token da Conta"
            L_WIZ_NICK="Nickname do Bot"
            L_WIZ_SAVING="Salvando configuracoes..."
            L_CONNECTING="Iniciando sessao real do WarfaceBot..."
            L_CMD_HEADER="COMANDOS REAIS DISPONIVEIS NO PROMPT CMD# DO BOT:"
            L_CMD_FRIENDS="friends              - Lista amigos no servidor"
            L_CMD_FOLLOW="follow <apelido>     - Seguir jogador para a sala"
            L_CMD_INVITE="invite <apelido>     - Convidar amigo para a sala"
            L_CMD_READY="ready [classe]       - Ficar pronto / trocar classe (medic, sniper, ...)"
            L_CMD_UNREADY="unready              - Cancelar prontidao na sala"
            L_CMD_OPEN="open <missao/mapa>   - Criar sala PvE ou PvP"
            L_CMD_START="start                - Iniciar a partida na sala"
            L_CMD_LEAVE="leave                - Sair da sala atual"
            L_CMD_MASTER="master <apelido>     - Devolver lideranca da sala"
            L_CMD_SAY="say <mensagem>       - Enviar mensagem no chat da sala"
            L_CMD_WHISPER="whisper <nick> <msg> - Enviar sussurro privado"
            L_CMD_STATS="stats                - Exibir estatisticas da sessao"
            L_CMD_QUIT="quit                 - Desconectar e voltar ao menu"
            L_PRESS_ENTER="Pressione ENTER para voltar..."
            L_TEST_RUNNING="Testando conexao de socket com $SERVER_IP:$SERVER_PORT..."
            L_TEST_SUCCESS="Sucesso! O servidor XMPP esta ativo e respondendo na porta."
            L_TEST_FAILED="Falha: Nao foi possivel alcancar a porta $SERVER_PORT em $SERVER_IP."
            ;;
        *)
            CURRENT_LANG="en"
            L_BANNER="WARFACEBOT • CONTROL PANEL | Levak"
            L_SRV_DATA="CONNECTION PARAMETERS"
            L_LBL_HOST="Server Host / IP: "
            L_LBL_PORT="XMPP Port:        "
            L_LBL_VER="Game Version:     "
            L_LBL_UID="Account UID:      "
            L_LBL_NICK="Bot Nickname:     "
            L_LBL_STATUS="Network Status:   "
            L_STATUS_ONLINE="ONLINE [PORT OPEN]"
            L_STATUS_OFFLINE="OFFLINE [PORT CLOSED]"
            L_OPT_START="CONNECT TO GAME (REAL SESSION - wb.exe)"
            L_OPT_TEST="TEST SERVER CONNECTION (SOCKET TEST)"
            L_OPT_CFG="CONFIGURE ACCOUNT & SERVER (WIZARD)"
            L_OPT_LANG="CHANGE LANGUAGE"
            L_OPT_EXIT="EXIT"
            L_PROMPT="Choose an option"
            L_DISCONNECTING="Exiting..."
            L_WIZ_TITLE="CONNECTION SETUP"
            L_WIZ_SRV_IP="Server Host / IP Address"
            L_WIZ_SRV_PORT="Server Port"
            L_WIZ_GAME_VER="Warface Game Version"
            L_WIZ_LOGIN="Account Login / UID"
            L_WIZ_TOKEN="Account Token / Password"
            L_WIZ_NICK="Bot Nickname"
            L_WIZ_SAVING="Saving settings..."
            L_CONNECTING="Launching real WarfaceBot session..."
            L_CMD_HEADER="REAL COMMANDS AVAILABLE IN THE BOT'S CMD# PROMPT:"
            L_CMD_FRIENDS="friends              - List friends on server"
            L_CMD_FOLLOW="follow <nickname>    - Follow player into game room"
            L_CMD_INVITE="invite <nickname>    - Invite friend to your game room"
            L_CMD_READY="ready [class]        - Toggle ready / select class (medic, sniper, ...)"
            L_CMD_UNREADY="unready              - Cancel ready in room"
            L_CMD_OPEN="open <mission/map>   - Create PvE or PvP room"
            L_CMD_START="start                - Start match (when Room Master)"
            L_CMD_LEAVE="leave                - Leave current room"
            L_CMD_MASTER="master <nickname>    - Transfer Room Master"
            L_CMD_SAY="say <message>        - Send message in room chat"
            L_CMD_WHISPER="whisper <nick> <msg> - Send private whisper"
            L_CMD_STATS="stats                - Display session statistics"
            L_CMD_QUIT="quit                 - Disconnect and return to menu"
            L_PRESS_ENTER="Press ENTER to return..."
            L_TEST_RUNNING="Testing socket connection to $SERVER_IP:$SERVER_PORT..."
            L_TEST_SUCCESS="Success! XMPP server is active and listening on port."
            L_TEST_FAILED="Error: Unable to connect to port $SERVER_PORT on $SERVER_IP."
            ;;
    esac
}

generate_random_nick() {
    local prefixes=("Ghost" "Shadow" "Viper" "Spectre" "Raven" "Falcon" "Delta" "Titan" "Hunter" "Reaper")
    local rand_prefix=${prefixes[$((RANDOM % ${#prefixes[@]}))]}
    local rand_num=$((RANDOM % 900 + 100))
    echo "${rand_prefix}_${rand_num}"
}

save_bot_config() {
    cat <<EOF > "$CONFIG_FILE"
LANG=$CURRENT_LANG
SERVER_IP=$SERVER_IP
SERVER_PORT=$SERVER_PORT
GAME_VERSION=$GAME_VERSION
BOT_UID=$BOT_UID
BOT_TOKEN=$BOT_TOKEN
BOT_NICK=$BOT_NICK
EOF

    local srv_dir="$SCRIPT_DIR/cfg/server"
    mkdir -p "$srv_dir"
    cat <<EOF > "$srv_dir/custom.cfg"
# WarfaceBot Auto-Generated Server Config
online_server = $SERVER_IP
online_server_port = $SERVER_PORT
online_host = warface
online_use_tls = 1
online_use_protect = 0
game_version = $GAME_VERSION
game_server_name = custom
game_lang = Portuguese
EOF
}

load_bot_config() {
    if [[ -f "$CONFIG_FILE" ]]; then
        while IFS='=' read -r key val || [[ -n "$key" ]]; do
            key=$(clean_str "$key")
            val=$(clean_str "$val")
            case "$key" in
                LANG) [[ -n "$val" ]] && CURRENT_LANG="$val" ;;
                SERVER_IP) [[ -n "$val" ]] && SERVER_IP="$val" ;;
                SERVER_PORT) [[ -n "$val" ]] && SERVER_PORT="$val" ;;
                GAME_VERSION) [[ -n "$val" ]] && GAME_VERSION="$val" ;;
                BOT_UID) [[ -n "$val" ]] && BOT_UID="$val" ;;
                BOT_TOKEN) [[ -n "$val" ]] && BOT_TOKEN="$val" ;;
                BOT_NICK) [[ -n "$val" ]] && BOT_NICK="$val" ;;
            esac
        done < "$CONFIG_FILE"
    fi
}

run_setup_wizard() {
    clear
    echo -e "$BARRA"
    echo -e "${BG_BLUE}             $L_WIZ_TITLE             ${RESET}"
    echo -e "$BARRA"
    echo ""
    echo -ne "  ${C_YELLOW}$L_WIZ_SRV_IP ${C_WHITE}[${SERVER_IP:-127.0.0.1}]: ${RESET}"
    read -r in_ip
    in_ip=$(clean_str "$in_ip")
    SERVER_IP="${in_ip:-${SERVER_IP:-127.0.0.1}}"

    echo -ne "  ${C_YELLOW}$L_WIZ_SRV_PORT ${C_WHITE}[${SERVER_PORT:-5222}]: ${RESET}"
    read -r in_port
    in_port=$(clean_str "$in_port")
    SERVER_PORT="${in_port:-${SERVER_PORT:-5222}}"

    echo -ne "  ${C_YELLOW}$L_WIZ_GAME_VER ${C_WHITE}[${GAME_VERSION:-1.11700.452.21500}]: ${RESET}"
    read -r in_ver
    in_ver=$(clean_str "$in_ver")
    GAME_VERSION="${in_ver:-${GAME_VERSION:-1.11700.452.21500}}"

    echo ""
    echo -ne "  ${C_YELLOW}$L_WIZ_LOGIN ${C_WHITE}[${BOT_UID:-3}]: ${RESET}"
    read -r in_uid
    in_uid=$(clean_str "$in_uid")
    BOT_UID="${in_uid:-${BOT_UID:-3}}"

    echo -ne "  ${C_YELLOW}$L_WIZ_TOKEN ${C_WHITE}: ${RESET}"
    read -r in_token
    in_token=$(clean_str "$in_token")
    if [[ -n "$in_token" ]]; then
        BOT_TOKEN="$in_token"
    fi

    local def_nick="${BOT_NICK:-BotPlayer}"
    if [[ "$def_nick" == "BotPlayer" || -z "$def_nick" ]]; then
        def_nick=$(generate_random_nick)
    fi

    echo -ne "  ${C_YELLOW}$L_WIZ_NICK ${C_WHITE}[$def_nick]: ${RESET}"
    read -r in_nick
    in_nick=$(clean_str "$in_nick")
    BOT_NICK="${in_nick:-$def_nick}"

    save_bot_config
}

select_initial_language() {
    clear
    echo -e "$BARRA"
    echo -e "${BG_BLUE}             LANGUAGE / IDIOMA / ЯЗЫК             ${RESET}"
    echo -e "$BARRA"
    echo ""
    echo -e "  ${C_RED}[${C_CYAN}1${C_RED}] ${C_WHITE}• ${C_YELLOW}English"
    echo -e "  ${C_RED}[${C_CYAN}2${C_RED}] ${C_WHITE}• ${C_YELLOW}Русский"
    echo -e "  ${C_RED}[${C_CYAN}3${C_RED}] ${C_WHITE}• ${C_YELLOW}Português (Brasil)"
    echo ""
    echo -ne "  ${C_GREEN}Choice [1-3] ${C_WHITE}: ${RESET}"
    read -r chosen_lang
    chosen_lang=$(clean_str "$chosen_lang")

    case "$chosen_lang" in
        2) set_language "ru";;
        3) set_language "pt";;
        *) set_language "en";;
    esac
}

testar_conexao_socket() {
    clear
    echo -e "$BARRA"
    echo -e "${BG_BLUE}             $L_OPT_TEST             ${RESET}"
    echo -e "$BARRA"
    echo ""
    echo -e "  ${C_CYAN}$L_TEST_RUNNING${RESET}"
    echo ""

    if check_server_socket; then
        echo -e "  ${C_GREEN}[OK] $L_TEST_SUCCESS${RESET}"
    else
        echo -e "  ${C_RED}[!] $L_TEST_FAILED${RESET}"
    fi

    echo ""
    echo -e "$BARRA"
    echo -ne "  ${C_YELLOW}$L_PRESS_ENTER${RESET}"
    read -r
}

conectar_bot_real() {
    clear
    local bin_path=""
    if [[ -f "$SCRIPT_DIR/wb.exe" ]]; then
        bin_path="$SCRIPT_DIR/wb.exe"
    elif [[ -f "$SCRIPT_DIR/../wb.exe" ]]; then
        bin_path="$SCRIPT_DIR/../wb.exe"
    fi

    local cfg_path="$SCRIPT_DIR/cfg/server/custom.cfg"
    if [[ ! -f "$cfg_path" ]]; then
        save_bot_config
    fi

    if [[ -z "$bin_path" ]]; then
        echo -e "${C_RED}wb.exe nao encontrado no diretorio!${RESET}"
        sleep 2
        return
    fi

    if [[ -z "$BOT_UID" || -z "$BOT_TOKEN" ]]; then
        run_setup_wizard
    fi

    echo -e "$BARRA"
    echo -e "${BG_BLUE}             $L_CONNECTING             ${RESET}"
    echo -e "$BARRA"
    echo -e "${C_CYAN}$L_LBL_HOST ${C_WHITE}$SERVER_IP:$SERVER_PORT"
    echo -e "${C_CYAN}$L_LBL_VER  ${C_WHITE}$GAME_VERSION"
    echo -e "${C_CYAN}$L_LBL_UID  ${C_WHITE}$BOT_UID"
    echo -e "${C_CYAN}$L_LBL_NICK ${C_WHITE}$BOT_NICK"
    echo -e "$BARRA"
    echo ""
    echo -e "${C_GREEN}$L_CMD_HEADER${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_FRIENDS${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_FOLLOW${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_INVITE${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_READY${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_UNREADY${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_OPEN${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_START${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_LEAVE${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_MASTER${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_SAY${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_WHISPER${RESET}"
    echo -e "  ${C_YELLOW}$L_CMD_STATS${RESET}"
    echo -e "  ${C_RED}$L_CMD_QUIT${RESET}"
    echo -e "$BARRA"
    echo ""

    local auth_pass="$BOT_TOKEN"
    if [[ "$auth_pass" != *"~"* ]]; then
        auth_pass="${GAME_VERSION}~${BOT_TOKEN}"
    fi

    "$bin_path" -t "$BOT_UID" -i "$auth_pass" -f "$cfg_path"

    echo ""
    echo -ne "${C_YELLOW}$L_PRESS_ENTER${RESET}"
    read -r
}

# Inicializacao
load_bot_config

if [[ -z "$CURRENT_LANG" ]]; then
    select_initial_language
    save_bot_config
fi
set_language "$CURRENT_LANG"

if [[ -z "$BOT_UID" || -z "$BOT_TOKEN" ]]; then
    run_setup_wizard
fi

while true; do
    clear
    echo -e "$BARRA"
    echo -e "${BG_BLUE}             $L_BANNER             ${RESET}"
    echo -e "$BARRA"
    echo -e "${C_CYAN} --- $L_SRV_DATA ---${RESET}"
    echo -e "  ${C_RED}$L_LBL_HOST ${C_WHITE}$SERVER_IP:$SERVER_PORT"
    echo -e "  ${C_RED}$L_LBL_VER  ${C_WHITE}$GAME_VERSION"
    echo -e "  ${C_RED}$L_LBL_UID  ${C_WHITE}$BOT_UID"
    echo -e "  ${C_RED}$L_LBL_NICK ${C_WHITE}$BOT_NICK"

    if check_server_socket; then
        echo -e "  ${C_RED}$L_LBL_STATUS ${C_GREEN}$L_STATUS_ONLINE${RESET}"
    else
        echo -e "  ${C_RED}$L_LBL_STATUS ${C_RED}$L_STATUS_OFFLINE${RESET}"
    fi

    echo -e "$BARRA"
    echo ""
    echo -e "  ${C_RED}[${C_CYAN}01${C_RED}] ${C_WHITE}• ${C_GREEN}$L_OPT_START${RESET}"
    echo -e "  ${C_RED}[${C_CYAN}02${C_RED}] ${C_WHITE}• ${C_CYAN}$L_OPT_TEST${RESET}"
    echo -e "  ${C_RED}[${C_CYAN}03${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_CFG${RESET}"
    echo -e "  ${C_RED}[${C_CYAN}04${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_LANG${RESET}"
    echo -e "  ${C_RED}[${C_CYAN}00${C_RED}] ${C_WHITE}• ${C_RED}$L_OPT_EXIT <<<${RESET}"
    echo ""
    echo -e "$BARRA"
    echo -ne "  ${C_GREEN}$L_PROMPT ${C_WHITE}: ${RESET}"

    if ! read -r opt; then
        echo ""
        exit 0
    fi
    opt=$(clean_str "$opt")

    case "$opt" in
        1|01)
            conectar_bot_real
            ;;
        2|02)
            testar_conexao_socket
            ;;
        3|03)
            run_setup_wizard
            ;;
        4|04)
            select_initial_language
            save_bot_config
            ;;
        0|00)
            echo ""
            echo -e "${C_RED}$L_DISCONNECTING${RESET}"
            sleep 0.5
            clear
            exit 0
            ;;
        *)
            echo -e "\n  ${C_RED}Opcao invalida!${RESET}"
            sleep 1
            ;;
    esac
done
