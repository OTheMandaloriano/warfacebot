<div align="center">
  <a href="../../README.md"><img src="https://api.iconify.design/circle-flags:br.svg?width=28" alt="Português (Brasil)" /></a>
  &nbsp;&nbsp;
  <a href="README.en.md"><img src="https://api.iconify.design/circle-flags:us.svg?width=28" alt="English" /></a>
  &nbsp;&nbsp;
  <a href="README.ru.md"><img src="https://api.iconify.design/circle-flags:ru.svg?width=28" alt="Русский" /></a>
</div>

<br />

<div align="center">

# WarfaceBot

[![License: AGPLv3](https://img.shields.io/badge/License-AGPLv3-3B82F6.svg?style=for-the-badge)](../../LICENSE)
[![Language: C99](https://img.shields.io/badge/Language-C99-blue.svg?style=for-the-badge&logo=c)](../../Makefile)
[![Dashboard: Terminal](https://img.shields.io/badge/Dashboard-Terminal%20TUI-10B981.svg?style=for-the-badge)](../../wb_dashboard.sh)
[![Languages: 3](https://img.shields.io/badge/Languages-PT--BR%20%7C%20EN%20%7C%20RU-F97316.svg?style=for-the-badge)](./)
[![Platform: Linux / Windows](https://img.shields.io/badge/Platform-Linux%20%7C%20Windows-6B7280.svg?style=for-the-badge)](../../releases)

**Headless XMPP client and automated session manager for Warface with integrated interactive terminal dashboard**

</div>

---

## <img src="https://api.iconify.design/solar:info-circle-bold.svg?color=%233B82F6&width=20" align="top" /> About this Program

This is a headless XMPP client for Warface only, as the latter uses a special overlay protocol to hide the fact that it is using XMPP. It is a headless client because it performs lobby actions without the need of launching a resource-needing game and can be run on a dedicated server.

This program is shipped fully functional but is intended to be customized (such as adding support to Cleverbot, adding stats, or custom commands). It also features a console that lets you enter owner-only commands and can be used to send XMPP queries.

---

## <img src="https://api.iconify.design/solar:question-circle-bold.svg?color=%233B82F6&width=20" align="top" /> Why (Original Motivation)

After [analysis of the Warface in-game protocol](https://stackedit.io/viewer#!provider=gist&gistId=b9a1852a0a17e334f041&filename=wfre), the original author decided to write a headless client that will perform various statistical tasks. While developing it, it was found it could be used for other means, such as **create solo games**, which could be the opportunity for legit players to face new difficulties as the official game does not have support for single player.

---

## <img src="https://api.iconify.design/solar:server-square-bold.svg?color=%233B82F6&width=20" align="top" /> How does it work?

This program acts like a normal game client. It is basically an implementation of both Warface overlay protocol, XMPP, and the custom queries used by Warface. XMPP is a standard presence protocol. All the lobby and shop actions are made using custom XMPP queries.

It is composed of two parts, similarly to the game:

1. **Launcher**: Responsible for logging you into the authentication server which provides a session token. The launcher is kept separate in order to be scriptable and customizable (for instance, to work for different Warface servers such as VN, RU, BR, NA, or EU). Available launchers:
   - `wb.sh`: Bash launcher for GNU/Linux users and Git Bash;
   - `wb_launcher.hta`: GUI launcher for Windows users;
   - `wbd_launcher`: Bash launcher when warfacebot is compiled in DBUS mode;
   - `wbm_launcher`: Bash launcher for the DBUS manager;
   - `wb_dashboard.sh`: Our new interactive multi-language terminal console dashboard.

2. **Client (`wb` / `wb.exe`)**: The actual compiled C program. It uses the session token given by the launcher to login to the XMPP service. Once there, this program acts like the real game does.

---

## <img src="https://api.iconify.design/solar:monitor-smartphone-bold.svg?color=%233B82F6&width=20" align="top" /> New: Interactive Console Dashboard (v2.0)

This fork introduces `wb_dashboard.sh` (and shortcut `dashboard.bat`), an interactive terminal dashboard designed for streamlined, reliable session management. It runs real-time server connectivity diagnostics (socket test) and hands direct control to the bot's native console:

```text
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
             WARFACEBOT • CONTROL PANEL | Levak             
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 --- CONNECTION PARAMETERS ---
  Server Host / IP: 127.0.0.1:5222
  Game Version:     1.11700.452.21500
  Account UID:      3
  Bot Nickname:     Falcon_623
  Network Status:   ONLINE [PORT OPEN]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  [01] • CONNECT TO GAME (REAL SESSION - wb.exe)
  [02] • TEST SERVER CONNECTION (SOCKET TEST)
  [03] • CONFIGURE ACCOUNT & SERVER (WIZARD)
  [04] • CHANGE LANGUAGE
  [00] • EXIT <<<

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Choose an option : 
```

### Dashboard Features
- **Live Network Diagnostic [02]**: Verifies if the XMPP server port is actively open and listening before starting a session.
- **Onboarding Setup Wizard [03]**: Guides initial setup for server host/port, game version, and bot credentials (with random tactical nick generation).
- **Persistent Local Config**: Safely saves local settings to `.wb_config` and outputs `cfg/server/custom.cfg` (both protected by `.gitignore`).
- **Real In-Game Connection [01]**: Spawns native `wb.exe` with TLS/SASL authentication, displays a full command cheatsheet, and hands interactive control over to the live `CMD# ` prompt:
  - `friends`: List account friends on server;
  - `follow <nickname>`: Follow a player into their room;
  - `invite <nickname>`: Invite a player into your room;
  - `ready [class]`: Toggle ready and/or select class (`medic`, `rifleman`, `engineer`, `sniper`);
  - `unready`: Cancel ready state;
  - `open <mission/map>`: Create PvE or PvP room;
  - `start`: Start the match (when Room Master);
  - `leave`: Leave current room;
  - `master <nickname>`: Transfer room master leadership;
  - `say <message>`: Send message to room chat;
  - `whisper <nickname> <msg>`: Send private whisper;
  - `stats`: Display session stats;
  - `quit`: Disconnect cleanly and return to dashboard.
- **Multi-language Support [04]**: Full native translation for English, Русский, and Português (Brasil).

---

## <img src="https://api.iconify.design/solar:shield-warning-bold.svg?color=%23F97316&width=20" align="top" /> Important Notices and Security

> [!WARNING]
> **Environment Isolation**: Do not run the bot on the same machine or public IP as your main account, or the main account could receive a temporary suspension. Always run bot accounts on another machine, dedicated virtual machine, or sandbox.

> [!NOTE]
> **Known Limitations (Original TODO)**:
> - **HWID**: Not dynamically generated. Some servers ban or kick invalid HWIDs. Use the CVar `game_hwid` on launch to set a valid identifier.
> - **XML Parser**: Queries are hand-crafted string templates rather than using an external XML library. Works reliably for supported servers, but could need adjustments if a server returns unexpected XML structures.

---

## <img src="https://api.iconify.design/solar:users-group-rounded-bold.svg?color=%233B82F6&width=20" align="top" /> Preparing the Accounts

If you wish to use your bots for helping you start solo games, you need to train them in the official game client before using this program as they will not be able to join Skilled, Hardcore, or Survival rooms otherwise:

- **Skilled and Hardcore rooms**: Unlocked starting from **level 4**. You must complete class tutorials, initiation and regular maps, and some PvP games (represents **30 minutes of game per account**).
- **Survival rooms**: Available starting from **level 10** (ColdPeak is unlocked at level 25). Spend time in PvP Storm (represents **2 days of game per account**).

### Linking your Main Account with your Bot:
1. Create a bot account.
2. Launch your bot account with WarfaceBot (`./wb_dashboard.sh` or `./wb.sh <server>`).
3. Launch your main account with the official game.
4. Send a friend request to your bot account from your main account.
5. The bot will automatically accept the friend invitation request.
6. *(Optional)*: Launch the bot account with the official game to level up to 4 or 10.

---

## <img src="https://api.iconify.design/solar:play-circle-bold.svg?color=%2310B981&width=20" align="top" /> Installation and Compilation

### Option 1: Pre-compiled Windows Package
From the [Releases](../../releases) section:
1. Download `warfacebot-v2.0.0-dashboard.zip`.
2. Extract the archive into a dedicated directory.
3. Double-click `dashboard.bat` (or run `./wb_dashboard.sh` via Git Bash).
4. On first launch, the Setup Wizard prompts for language, server details (Host, Port, Version), and account credentials (with an automatic random nickname generator).
5. Settings are saved locally to `.wb_config` and `cfg/server/custom.cfg` for future auto-logins.

### Option 2: Step by Step Manual Compilation (Linux / Cygwin)

#### Required Dependencies (Cygwin packages / Linux):
- `Devel/make`
- `Devel/gcc-core`
- `Net/curl`
- `Libs/zlib-devel`
- `Net/libssl-devel`
- `Libs/libreadline-devel`

#### Building:
```bash
git clone https://github.com/OTheMandaloriano/warfacebot.git
cd warfacebot
make
```

#### Running:
```bash
# Run with the interactive dashboard:
./wb_dashboard.sh

# Or run the traditional bash launcher:
./wb.sh eu
# Or specify another regional server:
./wb.sh br
./wb.sh ru
```

---

## <img src="https://api.iconify.design/solar:chat-round-line-bold.svg?color=%233B82F6&width=20" align="top" /> Whisper Commands (In-Game Private Chat)

You can whisper commands to the bot from your main account (`/w <BotNick> <command>`):

| Command | Parameters | Description |
| :--- | :--- | :--- |
| `help` | - | Replies with the list of supported in-game whisper commands |
| `follow` | `[nickname]` | Directs the bot to follow you or somebody into the room |
| `invite` | `[nickname]` | Sends you an invitation request to the room he is currently in |
| `ready` | - | Sets his lobby state to ready |
| `take <class>` | `<class>` | Alias to `ready <class>`. Forces him to take a specific class (`medic`, `sniper`, `engineer`, `rifleman`) |
| `master` | - | Asks him to give you the room master permissions |
| `start` | - | If he is room master, tries to start the room |
| `stay` | - | Makes sure to stay even if the room started (for 1h or until leaving) |
| `switch` | - | If in PvP, tries to switch team |
| `unready` | - | Keeps unready until receiving `ready` or leaving room |
| `missions` | - | Crown challenge objectives |
| `whois <nickname>` | `<nickname>` | Retrieves any connected player country and lobby status |
| `leave` | - | Tells him to leave the current game room |

---

## <img src="https://api.iconify.design/solar:code-square-bold.svg?color=%233B82F6&width=20" align="top" /> Owner-only Commands (Console)

Enter owner-only commands directly in the readline terminal or dashboard:

| Command | Description |
| :--- | :--- |
| `create <nickname>` | Creates a new profile on the server (see `game_manual_profile_creation`) |
| `add <nickname>` | Sends a friend request to specified player |
| `remove <nickname>` | Removes player from the buddy-list |
| `removeall` | Removes all buddies from the buddy-list |
| `say <message>` | Makes the bot speak in the current game room |
| `open <map/mission>` | Opens game room with mission (PvE) or map (PvP) |
| `name <roomname>` | Changes the name of the PvP room |
| `change <map/mission>` | Changes to specified map or mission |
| `safe <map>` | Creates a blacklist-based safe-room (see `src/cmds/cmd_safe.c`) |
| `channel <channel>` | Switches to specified channel |
| `whisper <nickname> <msg>` | Sends private message to friend or clan mate |
| `friends` | Lists friends and clanmates |
| `sleep [n]` | Hangs the readline thread for *n* seconds (default: 1 second) |
| `stats` | Lists all channel load statistics |
| `stay <count> [unit]` | Stays in room after start for specified duration |
| `randombox [<name> <count>]` | Opens random boxes or lists available shop boxes and prices |
| `last <nickname>` | Displays last seen timestamp of friend or clan mate |
| `quickplay <cmd> [arg]` | Quickplay matchmaking (`open`, `invite`, `cancel`, `start`) |
| `quit` | Gracefully exits warfacebot |

---

## <img src="https://api.iconify.design/solar:tuning-square-2-bold.svg?color=%23F97316&width=20" align="top" /> Console Variables (CVars)

CVars dynamically configure bot behavior without recompilation.

Config files are single-token-separated files (space, equal sign `=`, or both):
```text
cvar_name 1
cvar_name=1
cvar_name   1
cvar_name = 1
```

> [!NOTE]
> When using `wb.sh <server>`, `./cfg/server/<server>.cfg` is loaded to determine game version and server host. If the game version changed, update this file accordingly.

### 4 Ways to Define CVars:
1. In the default config file `wb.cfg`;
2. From a config file given at launch: `./wb.sh eu -f <config.cfg>`
3. From a variable defined at launch: `./wb.sh eu -d <cvar=value>`
4. From the readline prompt: `CMD# cvar_name = value`

### Game-related Variables
- `game_version`: Game version used at login *(Mandatory)*;
- `game_server_name`: Game server identifier *(Mandatory)*;
- `game_crypt_iv`: Optional server encryption IV override (default: NULL);
- `game_crypt_key`: Optional server encryption key override (default: NULL);
- `game_hwid`: HWID used at login (default: 0);
- `game_manual_profile_creation`: Do not try to create profile automatically if none found, waits for `create <nickname>` (default: FALSE);
- `g_language`: Language used at startup to read `cfg/lang/<g_language>.cfg` (default: english).

### CryOnline-related Variables
- `online_server`: Game server host to connect to (default: NULL);
- `online_server_port`: Game server port (default: 5222);
- `online_channel_type`: Default channel type to connect to (default: pve);
- `online_pvp_rank`: Cached rank of account to find proper PvP channel (default: 1);
- `online_host`: XMPP server name (default: warface);
- `online_bootstrap`: Prefix for `online_host` (default: NULL);
- `online_region_id`: Region to use (default: global);
- `online_use_protect`: Use additional encryption layer (default: TRUE);
- `online_use_tls`: Use TLS encryption (default: TRUE).

### DBus-related Variables
- `dbus_id`: In DBUS mode, unique identifier used to construct bot busname *(Mandatory)*.

### Query-related Variables
- `query_dump_to_file`: In DEBUG mode, enable logging queries to file (default: FALSE);
- `query_dump_location`: Location of logged queries (default: `./Logs/`);
- `query_debug`: Output queries to stdout in DEBUG mode (default: TRUE);
- `query_cache`: Enable query cache system (default: TRUE);
- `query_cache_location`: Filesystem location for query cache (default: `./QueryCache/`);
- `query_disable_items`: Disable fetching items (default: FALSE);
- `query_disable_shop_get_offers`: Disable fetching shop offers (default: FALSE);
- `query_disable_quickplay_maplist`: Disable fetching quickplay maps (default: FALSE);
- `query_disable_get_configs`: Disable fetching game configs (default: FALSE).

*Performance Tip: To improve bot performances at launch and channel switch, disable the four options above unless needed.*

### Warfacebot-related Variables
- `wb_safemaster`: Setup bot as safemaster (default: FALSE);
- `wb_safemaster_room_name`: Safemaster default room name;
- `wb_safemaster_channel`: Safemaster default room channel (default: pvp_pro_1);
- `wb_join_global_rooms`: Whether `say` works for global channels (default: FALSE);
- `wb_accept_friend_requests`: Accept incoming friend requests (default: TRUE);
- `wb_postpone_friend_requests`: Postpone friend requests (default: FALSE);
- `wb_accept_clan_invites`: Accept clan invitations (default: TRUE);
- `wb_postpone_clan_invites`: Postpone clan invitations (default: FALSE);
- `wb_enable_whisper_commands`: Process whisper commands (default: TRUE);
- `wb_leave_on_start`: Automatically leave when room starts (default: TRUE);
- `wb_accept_room_follows`: Accept buddies following bot (default: TRUE);
- `wb_accept_room_invitations`: Accept buddy room invitations (default: TRUE);
- `wb_postpone_room_invitations`: Ignore buddy room invitations (default: FALSE);
- `wb_enable_invite`: Enable `invite` whisper command (default: TRUE);
- `wb_auto_start`: Auto start when room master (default: TRUE);
- `wb_auto_afk`: Enable AFK status when idle (default: FALSE);
- `wb_ping_unit`: Period used to throttle ping thread (default: 60 sec);
- `wb_ping_count_is_afk`: Ping units before sending AFK (default: 1);
- `wb_ping_count_is_stall`: Ping units without queries before sending ping (default: 3);
- `wb_ping_count_is_over`: Ping units before considering connection lost (default: 4);
- `wb_ping_count_is_outdated`: Ping units before forcing profile update (default: 5);
- `wb_qp_search_started`: Accept quickplay rooms already started (default: TRUE);
- `wb_qp_search_non_started`: Accept quickplay rooms not started yet (default: TRUE).

---

## <img src="https://api.iconify.design/solar:medal-ribbons-star-bold.svg?color=%23F59E0B&width=20" align="top" /> Credits

> [!NOTE]
> Fork of a project that deserves credit. If this work was useful, the original was too.

<div align="center">

Based on [WarfaceBot](https://github.com/Levak/warfacebot) by [Levak](https://github.com/Levak) · AGPL-3.0 License

<br />

Original project

[![LEVAK - WARFACEBOT](https://img.shields.io/badge/LEVAK-WARFACEBOT-black?style=for-the-badge&logo=github)](https://github.com/Levak/warfacebot)

<br />

<p align="center">
  <sub><b>Original project contributors:</b></sub><br />
  <a href="https://github.com/Levak" title="Levak"><img src="https://github.com/Levak.png?size=40" width="36" height="36" alt="@Levak" style="border-radius:50%;" /></a>&nbsp;
  <a href="https://github.com/seanwlk" title="seanwlk"><img src="https://github.com/seanwlk.png?size=40" width="36" height="36" alt="@seanwlk" style="border-radius:50%;" /></a>&nbsp;
  <a href="https://github.com/tuononh" title="tuononh"><img src="https://github.com/tuononh.png?size=40" width="36" height="36" alt="@tuononh" style="border-radius:50%;" /></a>&nbsp;
  <a href="https://github.com/Kavan72" title="Kavan72"><img src="https://github.com/Kavan72.png?size=40" width="36" height="36" alt="@Kavan72" style="border-radius:50%;" /></a>&nbsp;
  <a href="https://github.com/Weser87" title="Weser87"><img src="https://github.com/Weser87.png?size=40" width="36" height="36" alt="@Weser87" style="border-radius:50%;" /></a>&nbsp;
  <a href="https://github.com/nathan130200" title="nathan130200"><img src="https://github.com/nathan130200.png?size=40" width="36" height="36" alt="@nathan130200" style="border-radius:50%;" /></a>&nbsp;
  <a href="https://github.com/afrostalin" title="afrostalin"><img src="https://github.com/afrostalin.png?size=40" width="36" height="36" alt="@afrostalin" style="border-radius:50%;" /></a>&nbsp;
  <a href="https://github.com/0xLaileb" title="0xLaileb"><img src="https://github.com/0xLaileb.png?size=40" width="36" height="36" alt="@0xLaileb" style="border-radius:50%;" /></a>&nbsp;
  <a href="https://github.com/Platex" title="Platex"><img src="https://github.com/Platex.png?size=40" width="36" height="36" alt="@Platex" style="border-radius:50%;" /></a>&nbsp;
  <a href="https://github.com/overskye" title="overskye"><img src="https://github.com/overskye.png?size=40" width="36" height="36" alt="@overskye" style="border-radius:50%;" /></a>&nbsp;
  <a href="https://github.com/RED-SKY42" title="RED-SKY42"><img src="https://github.com/RED-SKY42.png?size=40" width="36" height="36" alt="@RED-SKY42" style="border-radius:50%;" /></a>
</p>

<br />

Fixes and Dashboard in this fork

[![@OTHEMANDALORIANO](https://img.shields.io/badge/@OTHEMANDALORIANO-black?style=for-the-badge&logo=github)](https://github.com/OTheMandaloriano)

</div>

---

## <img src="https://api.iconify.design/solar:document-text-bold.svg?color=%233B82F6&width=20" align="top" /> License

This program is distributed under the terms of **GNU Affero General Public License v3.0 (AGPLv3)**. Please take the time to read and understand the file [LICENSE](../../LICENSE) shipped within this repository.
