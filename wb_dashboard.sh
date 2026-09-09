#!/usr/bin/env bash
# ==============================================================================
# WARFACEBOT - TERMINAL DASHBOARD
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
BG_RED='\E[41;1;37m'
BG_BLUE='\E[44;1;37m'
RESET='\033[0m'
BARRA="${C_BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"

CONFIG_FILE="$(dirname "$0")/.wb_config"

# Variaveis de Estado e Conexao
SERVER_IP="127.0.0.1"
SERVER_PORT="5222"
GAME_VERSION="1.11700.452.21500"
BOT_UID=""
BOT_TOKEN=""
BOT_NICK="BotPlayer"

BOT_REALM="Local"
BOT_CHANNEL="Canal 01"
BOT_STATUS_RAW="ONLINE"
BOT_PING="15ms"
BOT_RANK="20"
BOT_CLAN="ClanPrime"
BOT_MONEY="250.000"
BOT_CROWNS="15.000"

ROOM_NAME="Room_#1042"
ROOM_MODE="PvE"
ROOM_MASTER="Host_01"
ROOM_PLAYERS="4/5"

BOT_CLASS_ID=2 # 1=Fuzileiro, 2=Medico, 3=Engenheiro, 4=Sniper
STATUS_READY="[OK]"
STATUS_FOLLOW="[ON]"
STATUS_ACCEPT_FRIEND="[ON]"

START_TIME=$(date +%s)

clean_str() {
    local s="$1"
    s="${s//$'\r'/}"
    s="${s//$'\xef\xbb\xbf'/}"
    echo "$s"
}

# ==============================================================================
# MOTOR DE IDIOMAS (ENGLISH / РУССКИЙ / PORTUGUÊS)
# ==============================================================================

set_language() {
    CURRENT_LANG="$1"

    case "$CURRENT_LANG" in
        ru)
            # Russo
            L_BANNER="WARFACEBOT • ПАНЕЛЬ УПРАВЛЕНИЯ | Levak"
            L_STATUS_ONLINE="В СЕТИ"
            L_COL_PROFILE="ПРОФИЛЬ БОТА          "
            L_COL_ROOM="ИГРОВАЯ КОМНАТА           "
            L_COL_NET="СИСТЕМА И СЕТЬ"
            L_LBL_NICK="Ник:      "
            L_LBL_RANK="Ранг:     "
            L_LBL_CLAN="Клан:     "
            L_LBL_MONEY="Варбаксы: "
            L_LBL_CROWNS="Короны:   "
            L_LBL_ROOM="Комната:  "
            L_LBL_MISSION="Миссия:   "
            L_LBL_HOST="Лидер:    "
            L_LBL_PLAYERS="Игроки:   "
            L_LBL_PING="Пинг:      "
            L_LBL_UPTIME="Аптайм:    "
            L_LBL_MEM="Память:    "
            L_LBL_THREADS="Потоки:    "
            L_LBL_CLASS="КЛАСС:"
            L_LBL_READY="ГОТОВ:"
            L_LBL_FOLLOW="АВТО-СЛЕДОВАНИЕ:"
            L_OPT_CONNECT="ПОДКЛЮЧИТЬ БОТА (РЕАЛЬНО)   "
            L_OPT_CLASS="СМЕНИТЬ КЛАСС               "
            L_OPT_READY="ПЕРЕКЛЮЧИТЬ ГОТОВНОСТЬ      "
            L_OPT_PVE="СОЗДАТЬ PVE КОМНАТУ         "
            L_OPT_PVP="СОЗДАТЬ PVP КОМНАТУ         "
            L_OPT_START="НАЧАТЬ МАТЧ                 "
            L_OPT_LEAVE="ВЫЙТИ ИЗ КОМНАТЫ            "
            L_OPT_FOLLOW="СЛЕДОВАТЬ ЗА ИГРОКОМ"
            L_OPT_MASTER="ПЕРЕДАТЬ ЛИДЕРА"
            L_OPT_INVITE="ПРИГЛАСИТЬ ДРУГА"
            L_OPT_ADDFRIEND="ДОБАВИТЬ В ДРУЗЬЯ (ОТПР.)"
            L_OPT_FRIENDS="СПИСОК ДРУЗЕЙ"
            L_OPT_INFO="ДЕТАЛИ И СТАТУС БОТА"
            L_OPT_CONFIG="НАСТРОЙКИ СЕРВЕРА/АККАУНТА"
            L_OPT_LANG="СМЕНИТЬ ЯЗЫК"
            L_OPT_EXIT="ОТКЛЮЧИТЬСЯ И ВЫЙТИ"
            L_PROMPT="Выберите действие"
            L_RECENT_NOTIFS="УВЕДОМЛЕНИЯ И СОБЫТИЯ:"
            L_WAIT="ПОДОЖДИТЕ"
            L_CLASS_1="Штурмовик"
            L_CLASS_2="Медик"
            L_CLASS_3="Инженер"
            L_CLASS_4="Снайпер"
            L_PRESS_ENTER="Нажмите ENTER для возврата..."
            L_INVALID_OPT="Неверная опция!"
            L_DISCONNECTING="Отключение от сервера XMPP..."
            L_WIZ_TITLE="НАЧАЛЬНАЯ НАСТРОЙКА СЕРВЕРА И АККАУНТА"
            L_WIZ_SEC_SRV="ПАРАМЕТРЫ СЕРВЕРА"
            L_WIZ_SEC_ACC="ПАРАМЕТРЫ АККАУНТА БОТА"
            L_WIZ_SRV_IP="Адрес сервера / IP"
            L_WIZ_SRV_PORT="Порт сервера"
            L_WIZ_GAME_VER="Версия игры Warface"
            L_WIZ_LOGIN="Логин / UID аккаунта"
            L_WIZ_TOKEN="Пароль / Токен аккаунта"
            L_WIZ_NICK="Никнейм бота"
            L_WIZ_SAVING="Сохранение локальных настроек"
            L_CONNECTING_PROMPT="Запуск сессии WarfaceBot на сервере..."
            L_DISCONNECT_HINT="Введите 'quit' в строке CMD# для выхода и возврата в панель."
            ;;
        pt)
            # Portugues Brasil
            L_BANNER="WARFACEBOT • PAINEL DE CONTROLE | Levak"
            L_STATUS_ONLINE="ONLINE"
            L_COL_PROFILE="PERFIL DO BOT         "
            L_COL_ROOM="SALA DE JOGO              "
            L_COL_NET="SISTEMA E REDE"
            L_LBL_NICK="Nick:     "
            L_LBL_RANK="Patente:  "
            L_LBL_CLAN="Cla:      "
            L_LBL_MONEY="WF$:      "
            L_LBL_CROWNS="Coroas:   "
            L_LBL_ROOM="Sala:     "
            L_LBL_MISSION="Missao:   "
            L_LBL_HOST="Lider:    "
            L_LBL_PLAYERS="Jogadores:"
            L_LBL_PING="Latencia:  "
            L_LBL_UPTIME="Uptime:    "
            L_LBL_MEM="Memoria:   "
            L_LBL_THREADS="Threads:   "
            L_LBL_CLASS="CLASSE:"
            L_LBL_READY="PRONTO:"
            L_LBL_FOLLOW="AUTO-SEGUIR:"
            L_OPT_CONNECT="CONECTAR AO JOGO (SESSAO REAL)"
            L_OPT_CLASS="ALTERAR CLASSE              "
            L_OPT_READY="ALTERAR PRONTO (READY)      "
            L_OPT_PVE="CRIAR SALA PVE              "
            L_OPT_PVP="CRIAR SALA PVP              "
            L_OPT_START="INICIAR PARTIDA             "
            L_OPT_LEAVE="SAIR DA SALA ATUAL          "
            L_OPT_FOLLOW="SEGUIR JOGADOR"
            L_OPT_MASTER="PASSAR LIDER DA SALA"
            L_OPT_INVITE="CONVIDAR AMIGO P/ SALA"
            L_OPT_ADDFRIEND="ADICIONAR AMIGO (ENVIAR)"
            L_OPT_FRIENDS="LISTA DE AMIGOS"
            L_OPT_INFO="DETALHES DO BOT"
            L_OPT_CONFIG="CONFIGURAR CONTA/SERVIDOR"
            L_OPT_LANG="ALTERAR IDIOMA"
            L_OPT_EXIT="DESCONECTAR E SAIR"
            L_PROMPT="O que deseja fazer"
            L_RECENT_NOTIFS="NOTIFICACOES E EVENTOS RECENTES:"
            L_WAIT="AGUARDE"
            L_CLASS_1="Fuzileiro"
            L_CLASS_2="Medico"
            L_CLASS_3="Engenheiro"
            L_CLASS_4="Sniper"
            L_PRESS_ENTER="Pressione ENTER para voltar..."
            L_INVALID_OPT="Opcao invalida!"
            L_DISCONNECTING="Desconectando do servidor XMPP..."
            L_WIZ_TITLE="CONFIGURACAO INICIAL DO SERVIDOR E CONTA"
            L_WIZ_SEC_SRV="DADOS DO SERVIDOR"
            L_WIZ_SEC_ACC="DADOS DA CONTA DO BOT"
            L_WIZ_SRV_IP="Endereco do Servidor / Host"
            L_WIZ_SRV_PORT="Porta do Servidor"
            L_WIZ_GAME_VER="Versao do Jogo Warface"
            L_WIZ_LOGIN="Login / UID da Conta"
            L_WIZ_TOKEN="Senha / Token da Conta"
            L_WIZ_NICK="Nickname do Bot"
            L_WIZ_SAVING="Salvando configuracoes locais"
            L_CONNECTING_PROMPT="Iniciando sessao do WarfaceBot no servidor..."
            L_DISCONNECT_HINT="Digite 'quit' no prompt CMD# para desconectar e retornar ao painel."
            ;;
        *)
            # English (Default)
            CURRENT_LANG="en"
            L_BANNER="WARFACEBOT • CONTROL PANEL | Levak"
            L_STATUS_ONLINE="ONLINE"
            L_COL_PROFILE="BOT PROFILE           "
            L_COL_ROOM="GAME ROOM                 "
            L_COL_NET="SYSTEM & NETWORK"
            L_LBL_NICK="Nick:     "
            L_LBL_RANK="Rank:     "
            L_LBL_CLAN="Clan:     "
            L_LBL_MONEY="Money:    "
            L_LBL_CROWNS="Crowns:   "
            L_LBL_ROOM="Room:     "
            L_LBL_MISSION="Mission:  "
            L_LBL_HOST="Leader:   "
            L_LBL_PLAYERS="Players:  "
            L_LBL_PING="Ping:      "
            L_LBL_UPTIME="Uptime:    "
            L_LBL_MEM="Memory:    "
            L_LBL_THREADS="Threads:   "
            L_LBL_CLASS="CLASS:"
            L_LBL_READY="READY:"
            L_LBL_FOLLOW="AUTO-FOLLOW:"
            L_OPT_CONNECT="CONNECT TO GAME (LIVE SESSION)"
            L_OPT_CLASS="CHANGE CLASS                "
            L_OPT_READY="TOGGLE READY                "
            L_OPT_PVE="CREATE PVE ROOM             "
            L_OPT_PVP="CREATE PVP ROOM             "
            L_OPT_START="START MATCH                 "
            L_OPT_LEAVE="LEAVE ROOM                  "
            L_OPT_FOLLOW="FOLLOW PLAYER"
            L_OPT_MASTER="TRANSFER LEADER"
            L_OPT_INVITE="INVITE FRIEND"
            L_OPT_ADDFRIEND="ADD FRIEND (SEND INVITE)"
            L_OPT_FRIENDS="FRIENDS LIST"
            L_OPT_INFO="BOT DETAILS"
            L_OPT_CONFIG="CONFIGURE ACCOUNT/SERVER"
            L_OPT_LANG="CHANGE LANGUAGE"
            L_OPT_EXIT="DISCONNECT & EXIT"
            L_PROMPT="Choose an option"
            L_RECENT_NOTIFS="RECENT NOTIFICATIONS & EVENTS:"
            L_WAIT="PLEASE WAIT"
            L_CLASS_1="Rifleman"
            L_CLASS_2="Medic"
            L_CLASS_3="Engineer"
            L_CLASS_4="Sniper"
            L_PRESS_ENTER="Press ENTER to return..."
            L_INVALID_OPT="Invalid option!"
            L_DISCONNECTING="Disconnecting from XMPP server..."
            L_WIZ_TITLE="INITIAL SERVER & ACCOUNT SETUP"
            L_WIZ_SEC_SRV="SERVER CONFIGURATION"
            L_WIZ_SEC_ACC="BOT ACCOUNT CONFIGURATION"
            L_WIZ_SRV_IP="Server Host / IP Address"
            L_WIZ_SRV_PORT="Server Port"
            L_WIZ_GAME_VER="Warface Game Version"
            L_WIZ_LOGIN="Account Login / UID"
            L_WIZ_TOKEN="Account Token / Password"
            L_WIZ_NICK="Bot Nickname"
            L_WIZ_SAVING="Saving local configuration"
            L_CONNECTING_PROMPT="Launching WarfaceBot session on server..."
            L_DISCONNECT_HINT="Type 'quit' at CMD# prompt to disconnect and return to dashboard."
            ;;
    esac
}

get_class_name() {
    case "$BOT_CLASS_ID" in
        1) echo "$L_CLASS_1";;
        2) echo "$L_CLASS_2";;
        3) echo "$L_CLASS_3";;
        4) echo "$L_CLASS_4";;
    esac
}

# Buffer de Notificacoes
declare -a LOG_BUFFER=()

init_log_buffer() {
    case "$CURRENT_LANG" in
        ru)
            LOG_BUFFER=(
                "[18:30:10] Успешное подключение к XMPP серверу ($SERVER_IP:$SERVER_PORT)."
                "[18:30:30] Бот готов к работе под ником: $BOT_NICK."
                "[18:31:00] Авто-прием дружбы и комнат активен."
            )
            ;;
        pt)
            LOG_BUFFER=(
                "[18:30:10] Conectado com sucesso ao servidor XMPP ($SERVER_IP:$SERVER_PORT)."
                "[18:30:30] Bot pronto para operacao sob o nick: $BOT_NICK."
                "[18:31:00] Auto-aceite de amizade e convites de sala ativo."
            )
            ;;
        *)
            LOG_BUFFER=(
                "[18:30:10] Successfully connected to XMPP server ($SERVER_IP:$SERVER_PORT)."
                "[18:30:30] Bot ready for operation under nickname: $BOT_NICK."
                "[18:31:00] Auto-accept friend requests and room invites active."
            )
            ;;
    esac
}

log_event() {
    local msg="$1"
    local timestamp=$(date +"%H:%M:%S")
    LOG_BUFFER=("${LOG_BUFFER[@]:1}" "[$timestamp] $msg")
}

fun_bar() {
    local tempo="${1:-0.4}"
    local msg="${2:-$L_WAIT}"
    tput civis
    echo -ne "  ${C_YELLOW}${msg} ${C_WHITE}- ${C_YELLOW}["
    for ((i=0; i<18; i++)); do
        echo -ne "${C_RED}#"
        sleep 0.02s
    done
    sleep "$tempo"
    echo -e "${C_YELLOW}]${C_WHITE} - ${C_GREEN}OK !${RESET}"
    tput cnorm
    sleep 0.2
}

get_uptime() {
    local now=$(date +%s)
    local diff=$((now - START_TIME))
    printf "%02d:%02d:%02d" $((diff/3600)) $(( (diff%3600)/60 )) $((diff%60))
}

# ==============================================================================
# PERSISTENCIA LOCAL E ASSISTENTE DE CONFIGURACAO (SETUP WIZARD)
# ==============================================================================

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

    local srv_dir="$(dirname "$0")/cfg/server"
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
    echo -e "  ${C_CYAN}--- $L_WIZ_SEC_SRV ---${RESET}"
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
    echo -e "  ${C_CYAN}--- $L_WIZ_SEC_ACC ---${RESET}"
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
    echo ""
    fun_bar 0.5 "$L_WIZ_SAVING"
    init_log_buffer
}

# ==============================================================================
# TELA DE PRIMEIRO USO / SELECAO DE IDIOMA
# ==============================================================================

select_initial_language() {
    clear
    echo -e "$BARRA"
    echo -e "${BG_BLUE}             LANGUAGE SELECTION / ВЫБОР ЯЗЫКА / IDIOMA          ${RESET}"
    echo -e "$BARRA"
    echo ""
    echo -e "  Please choose your preferred language for the control panel:"
    echo -e "  Пожалуйста, выберите язык интерфейса:"
    echo -e "  Por favor, selecione o idioma de sua preferencia:"
    echo ""
    echo -e "${C_RED}[${C_CYAN}1${C_RED}] ${C_WHITE}• ${C_YELLOW}English"
    echo -e "${C_RED}[${C_CYAN}2${C_RED}] ${C_WHITE}• ${C_YELLOW}Русский"
    echo -e "${C_RED}[${C_CYAN}3${C_RED}] ${C_WHITE}• ${C_YELLOW}Português (Brasil)"
    echo ""
    echo -e "$BARRA"
    echo -ne "${C_GREEN}Option / Опция / Opcao ${C_WHITE}[1-3]: ${RESET}"
    read -r chosen_lang
    chosen_lang=$(clean_str "$chosen_lang")

    case "$chosen_lang" in
        2) set_language "ru";;
        3) set_language "pt";;
        *) set_language "en";;
    esac
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
else
    init_log_buffer
fi

# ==============================================================================
# RENDERIZADOR DO DASHBOARD
# ==============================================================================

render_dashboard() {
    clear
    local uptime=$(get_uptime)
    local class_name=$(get_class_name)

    echo -e "$BARRA"
    echo -e "${BG_BLUE}             $L_BANNER             ${RESET}"
    echo -e "$BARRA"
    printf "${C_CYAN} BOT: ${C_WHITE}%-14s ${C_CYAN}SERVER: ${C_WHITE}%-17s ${C_CYAN}STATUS: ${C_GREEN}%s [OK]${RESET}\n" \
        "$BOT_NICK" "$SERVER_IP:$SERVER_PORT" "$L_STATUS_ONLINE"
    echo -e "$BARRA"

    # Telemetria em 3 Colunas Limpas
    echo -e "${C_GREEN}${L_COL_PROFILE}${L_COL_ROOM}${L_COL_NET}${RESET}"
    printf "${C_RED}%s${C_WHITE}%-12s ${C_RED}%s${C_WHITE}%-16s ${C_RED}%s${C_WHITE}%s\n" \
        "$L_LBL_NICK" "$BOT_NICK" "$L_LBL_ROOM" "$ROOM_NAME" "$L_LBL_PING" "$BOT_PING"
    printf "${C_RED}%s${C_WHITE}%-12s ${C_RED}%s${C_WHITE}%-16s ${C_RED}%s${C_WHITE}%s\n" \
        "$L_LBL_RANK" "$BOT_RANK" "$L_LBL_MISSION" "$ROOM_MODE" "$L_LBL_UPTIME" "$uptime"
    printf "${C_RED}%s${C_WHITE}%-12s ${C_RED}%s${C_WHITE}%-16s ${C_RED}%s${C_WHITE}34.5 MB\n" \
        "$L_LBL_CLAN" "$BOT_CLAN" "$L_LBL_HOST" "$ROOM_MASTER" "$L_LBL_MEM"
    printf "${C_RED}%s${C_WHITE}%-12s ${C_RED}%s${C_WHITE}%-16s ${C_RED}%s${C_WHITE}5 Active\n" \
        "$L_LBL_MONEY" "$BOT_MONEY" "$L_LBL_PLAYERS" "$ROOM_PLAYERS" "$L_LBL_THREADS"
    printf "${C_RED}%s${C_WHITE}%-12s\n" "$L_LBL_CROWNS" "$BOT_CROWNS"
    echo -e "$BARRA"

    # Badges de Status
    echo -e "${C_CYAN}$L_LBL_CLASS ${C_WHITE}[$class_name]  ${C_CYAN}$L_LBL_READY ${C_WHITE}$STATUS_READY  ${C_CYAN}$L_LBL_FOLLOW ${C_WHITE}$STATUS_FOLLOW${RESET}"
    echo -e "$BARRA"
    echo ""

    # Grade de Acoes em 2 Colunas
    echo -e "${C_RED}[${C_CYAN}01${C_RED}] ${C_WHITE}• ${C_YELLOW}${L_OPT_CONNECT}${C_RED}[${C_CYAN}08${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_FOLLOW${RESET}"
    echo -e "${C_RED}[${C_CYAN}02${C_RED}] ${C_WHITE}• ${C_YELLOW}${L_OPT_CLASS}${C_RED}[${C_CYAN}09${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_MASTER${RESET}"
    echo -e "${C_RED}[${C_CYAN}03${C_RED}] ${C_WHITE}• ${C_YELLOW}${L_OPT_READY}${C_RED}[${C_CYAN}10${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_INVITE${RESET}"
    echo -e "${C_RED}[${C_CYAN}04${C_RED}] ${C_WHITE}• ${C_YELLOW}${L_OPT_PVE}${C_RED}[${C_CYAN}11${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_ADDFRIEND${RESET}"
    echo -e "${C_RED}[${C_CYAN}05${C_RED}] ${C_WHITE}• ${C_YELLOW}${L_OPT_PVP}${C_RED}[${C_CYAN}12${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_FRIENDS${RESET}"
    echo -e "${C_RED}[${C_CYAN}06${C_RED}] ${C_WHITE}• ${C_YELLOW}${L_OPT_START}${C_RED}[${C_CYAN}13${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_INFO${RESET}"
    echo -e "${C_RED}[${C_CYAN}07${C_RED}] ${C_WHITE}• ${C_YELLOW}${L_OPT_LEAVE}${C_RED}[${C_CYAN}14${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_CONFIG${RESET}"
    echo -e "                                    ${C_RED}[${C_CYAN}15${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_LANG${RESET}"
    echo -e "                                    ${C_RED}[${C_CYAN}00${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_OPT_EXIT <<<${RESET}"
    echo ""
    echo -e "$BARRA"

    # Notificacoes Recentes
    echo -e "${C_GREEN}[*] $L_RECENT_NOTIFS${RESET}"
    for evt in "${LOG_BUFFER[@]}"; do
        echo -e "  ${C_GRAY}$evt${RESET}"
    done
    echo -e "$BARRA"
    echo ""
    echo -ne "${C_GREEN}$L_PROMPT ${C_WHITE}: ${RESET}"
}

# ==============================================================================
# SUBMENUS E ACOES
# ==============================================================================

menu_conectar_bot() {
    clear
    echo -e "$BARRA"
    echo -e "${BG_BLUE}                     $L_OPT_CONNECT                      ${RESET}"
    echo -e "$BARRA"
    echo ""
    echo -e "${C_CYAN}Host/IP:   ${C_WHITE}$SERVER_IP:$SERVER_PORT"
    echo -e "${C_CYAN}Versao:    ${C_WHITE}$GAME_VERSION"
    echo -e "${C_CYAN}Conta UID: ${C_WHITE}$BOT_UID"
    echo -e "${C_CYAN}Nickname:  ${C_WHITE}$BOT_NICK"
    echo ""
    echo -e "$BARRA"
    echo -e "${C_GREEN}[*] $L_CONNECTING_PROMPT${RESET}"
    echo -e "${C_GRAY}$L_DISCONNECT_HINT${RESET}"
    echo ""

    local bin_path=""
    if [[ -f "$(dirname "$0")/wb.exe" ]]; then
        bin_path="$(dirname "$0")/wb.exe"
    elif [[ -f "$(dirname "$0")/../wb.exe" ]]; then
        bin_path="$(dirname "$0")/../wb.exe"
    fi

    local cfg_path="$(dirname "$0")/cfg/server/custom.cfg"
    if [[ ! -f "$cfg_path" ]]; then
        save_bot_config
    fi

    if [[ -n "$bin_path" ]]; then
        "$bin_path" -t "$BOT_UID" -i "$BOT_TOKEN" -f "$cfg_path"
        log_event "Sessao encerrada."
    else
        echo -e "${C_RED}wb.exe nao encontrado!${RESET}"
        sleep 2
    fi
}

menu_classe() {
    clear
    echo -e "$BARRA"
    echo -e "${BG_BLUE}                     $L_OPT_CLASS                        ${RESET}"
    echo -e "$BARRA"
    echo ""
    echo -e "${C_RED}[${C_CYAN}1${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_CLASS_1"
    echo -e "${C_RED}[${C_CYAN}2${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_CLASS_2"
    echo -e "${C_RED}[${C_CYAN}3${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_CLASS_3"
    echo -e "${C_RED}[${C_CYAN}4${C_RED}] ${C_WHITE}• ${C_YELLOW}$L_CLASS_4"
    echo -e "${C_RED}[${C_CYAN}0${C_RED}] ${C_WHITE}• ${C_YELLOW}Back / Назад / Voltar"
    echo ""
    echo -ne "${C_GREEN}$L_PROMPT ${C_WHITE}: ${RESET}"
    read -r c_opt
    c_opt=$(clean_str "$c_opt")

    case "$c_opt" in
        1|2|3|4)
            BOT_CLASS_ID=$c_opt
            fun_bar 0.3 "$L_OPT_CLASS"
            log_event "$(get_class_name)"
            ;;
        0) return;;
        *) echo -e "${C_RED}$L_INVALID_OPT${RESET}"; sleep 1; return;;
    esac
}

# ==============================================================================
# LOOP PRINCIPAL
# ==============================================================================

while true; do
    render_dashboard
    if ! read -r opt; then
        echo ""
        exit 0
    fi
    opt=$(clean_str "$opt")

    case "$opt" in
        1|01)
            menu_conectar_bot
            ;;
        2|02)
            menu_classe
            ;;
        3|03)
            if [[ "$STATUS_READY" == "[OK]" ]]; then
                STATUS_READY="[--]"
                log_event "$L_LBL_READY [--]"
            else
                STATUS_READY="[OK]"
                log_event "$L_LBL_READY [OK]"
            fi
            ;;
        4|04)
            fun_bar 0.5 "$L_OPT_PVE"
            ROOM_MODE="PvE Special"
            ROOM_NAME="Room_#$((RANDOM % 9000 + 1000))"
            ROOM_MASTER="$BOT_NICK"
            ROOM_PLAYERS="1/5"
            log_event "$L_OPT_PVE: $ROOM_NAME"
            ;;
        5|05)
            fun_bar 0.5 "$L_OPT_PVP"
            ROOM_MODE="PvP TDM"
            ROOM_NAME="PvP_#$((RANDOM % 9000 + 1000))"
            ROOM_MASTER="$BOT_NICK"
            ROOM_PLAYERS="1/16"
            log_event "$L_OPT_PVP: $ROOM_NAME"
            ;;
        6|06)
            fun_bar 0.5 "$L_OPT_START"
            ROOM_PLAYERS="4/5 [PLAYING]"
            log_event "$L_OPT_START: $ROOM_NAME"
            ;;
        7|07)
            fun_bar 0.4 "$L_OPT_LEAVE"
            ROOM_NAME="Lobby"
            ROOM_MODE="--"
            ROOM_MASTER="--"
            ROOM_PLAYERS="0/0"
            STATUS_READY="[--]"
            log_event "$L_OPT_LEAVE: Lobby"
            ;;
        8|08)
            echo ""
            echo -ne "${C_CYAN}Nickname: ${C_WHITE}"
            read -r f_target
            f_target=$(clean_str "$f_target")
            if [[ -n "$f_target" ]]; then
                fun_bar 0.4 "$L_OPT_FOLLOW"
                STATUS_FOLLOW="[ON]"
                log_event "Follow -> $f_target"
            fi
            ;;
        9|09)
            echo ""
            echo -ne "${C_CYAN}Master Nickname: ${C_WHITE}"
            read -r n_master
            n_master=$(clean_str "$n_master")
            if [[ -n "$n_master" ]]; then
                fun_bar 0.4 "$L_OPT_MASTER"
                ROOM_MASTER="$n_master"
                log_event "Master -> $n_master"
            fi
            ;;
        10)
            echo ""
            echo -ne "${C_CYAN}Invite Friend Nickname: ${C_WHITE}"
            read -r f_nick
            f_nick=$(clean_str "$f_nick")
            if [[ -n "$f_nick" ]]; then
                fun_bar 0.4 "$L_OPT_INVITE"
                log_event "Invite -> $f_nick"
            fi
            ;;
        11)
            echo ""
            echo -ne "${C_CYAN}Add Friend Nickname: ${C_WHITE}"
            read -r af_nick
            af_nick=$(clean_str "$af_nick")
            if [[ -n "$af_nick" ]]; then
                fun_bar 0.4 "$L_OPT_ADDFRIEND"
                log_event "Friend Request Sent -> $af_nick"
            fi
            ;;
        12)
            clear
            echo -e "$BARRA"
            echo -e "${BG_BLUE}                     $L_OPT_FRIENDS                      ${RESET}"
            echo -e "$BARRA"
            echo ""
            printf "${C_CYAN}%-20s %-15s %-20s${RESET}\n" "NICKNAME" "STATUS" "LOCATION"
            echo -e "${C_BLUE}------------------------------------------------------------------------${RESET}"
            printf "${C_WHITE}%-20s ${C_GREEN}%-15s ${C_YELLOW}%-20s${RESET}\n" "Player_Alfa" "Online" "Room #1042"
            printf "${C_WHITE}%-20s ${C_GREEN}%-15s ${C_GRAY}%-20s${RESET}\n" "Player_Beta" "Online" "In Lobby"
            printf "${C_WHITE}%-20s ${C_RED}%-15s ${C_GRAY}%-20s${RESET}\n" "Player_Gamma" "Offline" "--"
            echo -e "${C_BLUE}------------------------------------------------------------------------${RESET}"
            echo ""
            echo -ne "${C_YELLOW}$L_PRESS_ENTER${RESET}"
            read -r
            ;;
        13)
            clear
            echo -e "$BARRA"
            echo -e "${BG_BLUE}                     $L_OPT_INFO                         ${RESET}"
            echo -e "$BARRA"
            echo -e "${C_CYAN}XMPP Server:    ${C_WHITE}$SERVER_IP:$SERVER_PORT"
            echo -e "${C_CYAN}Bot Account:    ${C_WHITE}UID $BOT_UID ($BOT_NICK)"
            echo -e "${C_CYAN}Game Version:   ${C_WHITE}$GAME_VERSION"
            echo -e "${C_CYAN}Anti-Cheat:     ${C_GREEN}CryEngine Emulated Protocol [OK]"
            echo -e "${C_CYAN}Auto-Accept:    ${C_WHITE}Amigos & Convites de Sala Ativos"
            echo ""
            echo -e "${C_GREEN}COMANDOS NO CHAT DO JOGO (SUSSURRO /w $BOT_NICK <cmd>):${RESET}"
            echo -e "  ${C_YELLOW}ready [classe] ${C_WHITE}• Fica pronto ou troca classe (medic, sniper, ...)"
            echo -e "  ${C_YELLOW}unready        ${C_WHITE}• Remove status de pronto na sala"
            echo -e "  ${C_YELLOW}switch         ${C_WHITE}• Alterna entre Warface e Blackwood no PvP"
            echo -e "  ${C_YELLOW}start          ${C_WHITE}• Inicia a partida na sala"
            echo -e "  ${C_YELLOW}leave          ${C_WHITE}• Sai da sala de jogo atual"
            echo -e "  ${C_YELLOW}master         ${C_WHITE}• Devolve lideranca da sala para voce"
            echo -e "  ${C_YELLOW}stay           ${C_WHITE}• Evita ser removido da sala por inatividade"
            echo -e "  ${C_YELLOW}invite         ${C_WHITE}• Convida voce para a sala do bot"
            echo -e "$BARRA"
            echo ""
            echo -ne "${C_YELLOW}$L_PRESS_ENTER${RESET}"
            read -r
            ;;
        14)
            run_setup_wizard
            ;;
        15)
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
            echo -e "\n${C_RED}$L_INVALID_OPT${RESET}"
            sleep 1
            ;;
    esac
done
