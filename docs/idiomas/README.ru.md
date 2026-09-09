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

[![Лицензия: AGPLv3](https://img.shields.io/badge/%D0%9B%D0%B8%D1%86%D0%B5%D0%BD%D0%B7%D0%B8%D1%8F-AGPLv3-3B82F6.svg?style=for-the-badge)](../../LICENSE)
[![Язык: C99](https://img.shields.io/badge/%D0%AF%D0%B7%D1%8B%D0%BA-C99-blue.svg?style=for-the-badge&logo=c)](../../Makefile)
[![Панель: Terminal](https://img.shields.io/badge/%D0%9F%D0%B0%D0%BD%D0%B5%D0%BB%D1%8C-Terminal%20TUI-10B981.svg?style=for-the-badge)](../../wb_dashboard.sh)
[![Языки: 3](https://img.shields.io/badge/%D0%AF%D0%B7%D1%8B%D0%BA%D0%B8-PT--BR%20%7C%20EN%20%7C%20RU-F97316.svg?style=for-the-badge)](./)
[![Платформа: Linux / Windows](https://img.shields.io/badge/%D0%9F%D0%BB%D0%B0%D1%82%D1%84%D0%BE%D1%80%D0%BC%D0%B0-Linux%20%7C%20Windows-6B7280.svg?style=for-the-badge)](../../releases)

**Консольный headless XMPP клиент и автоматизированный менеджер сессий для Warface с интерактивной терминальной панелью**

</div>

---

## <img src="https://api.iconify.design/solar:info-circle-bold.svg?color=%233B82F6&width=20" align="top" /> О программе

**WarfaceBot** представляет собой консольный headless XMPP клиент, созданный исключительно для Warface. Игра использует специальный протокол поверх стандартного XMPP для маскировки и защиты трафика. Клиент является безграфическим (headless): он выполняет любые действия в лобби, комнатах и магазине без необходимости запуска тяжелого графического клиента игры и может работать на удаленных серверах.

Программа поставляется полностью работоспособной и пригодной для модификаций (например, подключение Cleverbot, сбор игровой статистики или кастомные сценарии). Также в ней предусмотрена консоль для выполнения команд владельца и прямой отправки XMPP запросов.

---

## <img src="https://api.iconify.design/solar:question-circle-bold.svg?color=%233B82F6&width=20" align="top" /> Зачем создан этот проект (Мотивация)

После [подробного анализа игрового сетевого протокола Warface](https://stackedit.io/viewer#!provider=gist&gistId=b9a1852a0a17e334f041&filename=wfre) автор принял решение написать headless клиент для выполнения статистических задач. В процессе разработки выяснилось, что программа также отлично подходит для **создания одиночных комнат (solo games)**, давая обычным игрокам возможность проходить миссии в одиночку, что недоступно в официальном клиенте.

---

## <img src="https://api.iconify.design/solar:server-square-bold.svg?color=%233B82F6&width=20" align="top" /> Как это работает?

Программа имитирует поведение стандартного клиента игры. По сути, это реализация промежуточного протокола Warface, протокола присутствия XMPP и специальных XML запросов CryOnline. Все действия в лобби и магазине осуществляются посредством этих запросов.

Архитектура разделена на две части, аналогично самой игре:

1. **Лаунчер (Launcher)**: Отвечает за авторизацию на HTTP сервере аутентификации и получение токена сессии (*session token*). Вынесен в отдельные скрипты для удобства автоматизации и поддержки разных региональных серверов (RU, EU, NA, BR, VN). Доступные варианты:
   - `wb.sh`: Bash скрипт для Linux и Git Bash;
   - `wb_launcher.hta`: Графический лаунчер для Windows;
   - `wbd_launcher`: Bash лаунчер при сборке в режиме DBUS;
   - `wbm_launcher`: Bash лаунчер для DBUS менеджера;
   - `wb_dashboard.sh`: Наша новая интерактивная консольная панель с поддержкой трех языков.

2. **Клиент (`wb` / `wb.exe`)**: Основная скомпилированная программа на C. Использует токен сессии от лаунчера для подключения к XMPP сервису по TLS. После входа клиент полностью воспроизводит поведение игры в лобби.

---

## <img src="https://api.iconify.design/solar:monitor-smartphone-bold.svg?color=%233B82F6&width=20" align="top" /> Новинка: Интерактивная консольная панель (Dashboard v2.0)

В этот форк добавлен скрипт `wb_dashboard.sh` (и ярлык `dashboard.bat`): интерактивная консольная панель управления для надежного администрирования игровых сессий. Она выполняет диагностику сетевого подключения в реальном времени (socket test) и передает управление в интерактивную консоль бота:

```text
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
             WARFACEBOT • ПАНЕЛЬ УПРАВЛЕНИЯ | Levak             
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 --- ПАРАМЕТРЫ ПОДКЛЮЧЕНИЯ ---
  Сервер / IP:   127.0.0.1:5222
  Версия игры:   1.11700.452.21500
  UID аккаунта:  3
  Позывной:      Falcon_623
  Статус сети:   ОНЛАЙН [ПОРТ ОТКРЫТ]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  [01] • ПОДКЛЮЧИТЬСЯ К ИГРЕ (wb.exe)
  [02] • ПРОВЕРИТЬ СВЯЗЬ С СЕРВЕРОМ
  [03] • НАСТРОИТЬ АККАУНТ И СЕРВЕР
  [04] • СМЕНИТЬ ЯЗЫК
  [00] • ВЫХОД <<<

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Выберите действие : 
```

### Преимущества панели
- **Сетевая диагностика в реальном времени [02]**: Проверяет доступность и открытость порта XMPP сервера перед запуском игровой сессии.
- **Мастер начальной настройки (Setup Wizard) [03]**: Пошагово помогает настроить адрес сервера, порт, версию Warface и учетные данные аккаунта (с генератором позывных).
- **Авто-вход и постоянная конфигурация**: Настройки безопасно сохраняются в локальный файл `.wb_config` и генерируют `cfg/server/custom.cfg` (оба исключены в `.gitignore`).
- **Реальное подключение к игре [01]**: Запускает исполняемый файл `wb.exe` с TLS/SASL аутентификацией, выводит памятку по командам и передает управление в живой prompt `CMD# `:
  - `friends`: Список друзей на сервере;
  - `follow <ник>`: Следовать за игроком в его комнату;
  - `invite <ник>`: Пригласить игрока в свою комнату;
  - `ready [класс]`: Подтвердить готовность / сменить класс (`medic`, `rifleman`, `engineer`, `sniper`);
  - `unready`: Снять статус готовности;
  - `open <миссия/карта>`: Создать PvE или PvP комнату;
  - `start`: Запустить матч (если глава комнаты);
  - `leave`: Выйти из текущей комнаты;
  - `master <ник>`: Передать лидерство комнаты другому игроку;
  - `say <сообщение>`: Отправить сообщение в чат комнаты;
  - `whisper <ник> <сообщение>`: Отправить личное сообщение;
  - `stats`: Статистика текущей сессии;
  - `quit`: Безопасно отключиться и вернуться в меню панели.
- **Мультиязычность [04]**: Полная локализация на Русский, English и Português (Brasil).

---

## <img src="https://api.iconify.design/solar:shield-warning-bold.svg?color=%23F97316&width=20" align="top" /> Важные замечания и безопасность

> [!WARNING]
> **Изоляция аккаунтов и риск блокировки**: Не запускайте аккаунты ботов на том же физическом компьютере или с того же внешнего IP адреса, с которого играет основной аккаунт. Системы защиты CryOnline могут временно заблокировать доступ. Запускайте ботов на отдельном ПК, в виртуальной машине или песочнице.

> [!NOTE]
> **Известные ограничения (из оригинального TODO)**:
> - **HWID**: Генератор HWID не реализован. Некоторые серверы кикают невалидные HWID. Используйте переменную `game_hwid` при запуске для передачи корректного значения.
> - **XML парсер**: Запросы формируются вручную по шаблонам строк без внешней XML библиотеки. Работает стабильно на поддерживаемых серверах, но может потребовать правок при изменении структуры серверного XML.

---

## <img src="https://api.iconify.design/solar:users-group-rounded-bold.svg?color=%233B82F6&width=20" align="top" /> Подготовка и привязка аккаунтов

Если вы хотите использовать ботов для помощи в запуске соло-игр, их необходимо предварительно прокачать в официальном клиенте:

- **Комнаты Сложно и Профи (Skilled / Hardcore)**: Доступны с **4-го уровня**. Необходимо пройти обучение классов, карты Новичков и быстрые матчи (около **30 минут игры на аккаунт**).
- **Спецоперации (Survival)**: Доступны с **10-го уровня** (Белая Акула с 25 уровня). Потребуется поиграть в PvP режим Штурм (около **2 дней игры на аккаунт**).

### Как привязать основной аккаунт к боту:
1. Создайте аккаунт для бота.
2. Запустите бота через WarfaceBot (`./wb_dashboard.sh` или `./wb.sh <сервер>`).
3. Запустите основной аккаунт через официальный клиент игры.
4. Отправьте запрос в друзья боту с основного аккаунта.
5. Бот автоматически примет заявку в друзья.
6. *(Опционально)*: Зайдите ботом в официальную игру для поднятия уровня 4 или 10.

---

## <img src="https://api.iconify.design/solar:play-circle-bold.svg?color=%2310B981&width=20" align="top" /> Установка и компиляция

### Способ 1: Готовый архив для Windows
В разделе [Releases](../../releases):
1. Скачайте `warfacebot-v2.0.0-dashboard.zip`.
2. Распакуйте архив в любую папку.
3. Запустите `dashboard.bat` (или выполните `./wb_dashboard.sh` через Git Bash).
4. При первом запуске мастер настройки запросит язык, параметры сервера (IP, порт, версия) и данные учетной записи (с генератором позывного при необходимости).
5. Параметры сохранятся в `.wb_config` и `cfg/server/custom.cfg` для последующего авто-входа.

### Способ 2: Ручная компиляция (Linux / Cygwin)

#### Необходимые пакеты (Cygwin / Linux):
- `Devel/make`
- `Devel/gcc-core`
- `Net/curl`
- `Libs/zlib-devel`
- `Net/libssl-devel`
- `Libs/libreadline-devel`

#### Сборка:
```bash
git clone https://github.com/OTheMandaloriano/warfacebot.git
cd warfacebot
make
```

#### Запуск:
```bash
# Запуск через интерактивную консольную панель:
./wb_dashboard.sh

# Либо запуск классического скрипта:
./wb.sh ru
# Для других регионов:
./wb.sh eu
./wb.sh br
```

---

## <img src="https://api.iconify.design/solar:chat-round-line-bold.svg?color=%233B82F6&width=20" align="top" /> Команды шепота (из чата игры)

С основного аккаунта боту можно отправлять команды в личные сообщения (`/w <НикБота> <команда>`):

| Команда | Параметры | Описание |
| :--- | :--- | :--- |
| `help` | - | Отправляет в ответ список поддерживаемых команд бота |
| `follow` | `[никнейм]` | Бот переходит в комнату, где находится указанный игрок |
| `invite` | `[никнейм]` | Отправляет игроку приглашение в текущую комнату бота |
| `ready` | - | Переводит бота в состояние готовности к матчу |
| `take <класс>` | `<класс>` | Алиас для `ready <класс>`. Выбор класса (`medic`, `sniper`, `engineer`, `rifleman`) |
| `master` | - | Бот передает статус лидера (Room Master) игроку |
| `start` | - | Запуск матча (если бот является главой комнаты) |
| `stay` | - | Оставаться в комнате даже после старта матча (на 1 час или до выхода) |
| `switch` | - | В режиме PvP попытка сменить команду |
| `unready` | - | Снять готовность до команды `ready` или выхода из комнаты |
| `missions` | - | Запрос текущих заданий за Короны |
| `whois <никнейм>` | `<никнейм>` | Проверка региона и статуса подключения игрока к серверу |
| `leave` | - | Бот покидает текущую комнату |

---

## <img src="https://api.iconify.design/solar:code-square-bold.svg?color=%233B82F6&width=20" align="top" /> Команды владельца (в консоли)

Команды, вводимые напрямую в терминал бота или через меню панели:

| Команда | Описание |
| :--- | :--- |
| `create <никнейм>` | Создание нового профиля игрока на сервере (см. `game_manual_profile_creation`) |
| `add <никнейм>` | Отправка заявки в друзья указанному игроку |
| `remove <никнейм>` | Удаление игрока из списка друзей |
| `removeall` | Удаление всех игроков из списка друзей |
| `say <сообщение>` | Отправка сообщения в чат текущей комнаты |
| `open <миссия/карта>` | Создание комнаты PvE (`easy`, `normal`, `hard`, `survival`) или карты PvP |
| `name <имя_комнаты>` | Смена названия PvP комнаты |
| `change <миссия/карта>` | Смена спецоперации или карты в текущей комнате |
| `safe <карта>` | Создание комнаты с черным списком (см. `src/cmds/cmd_safe.c`) |
| `channel <канал>` | Переход на указанный канал (`pve`, `pvp_pro_1` и др.) |
| `whisper <ник> <сообщение>` | Отправка личного сообщения другу или соклановцу |
| `friends` | Вывод списка друзей и участников клана со статусами |
| `sleep [n]` | Приостановка потока readline на *n* секунд (по умолчанию: 1 сек) |
| `stats` | Статистика загруженности игровых каналов |
| `stay <кол-во> [ед]` | Удержание бота в комнате после старта на заданное время |
| `randombox [<имя> <кол-во>]` | Открытие коробок удачи или просмотр списка доступных коробок с ценами |
| `last <никнейм>` | Дата и время последнего входа в сеть друга или соклановца |
| `quickplay <cmd> [arg]` | Матчмейкинг быстрой игры (`open`, `invite`, `cancel`, `start`) |
| `quit` | Безопасное завершение сессии и выход из программы |

---

## <img src="https://api.iconify.design/solar:tuning-square-2-bold.svg?color=%23F97316&width=20" align="top" /> Конфигурационные переменные (CVars)

CVars позволяют настраивать поведение бота без перекомпиляции исходного кода.

Файлы конфигурации используют синтаксис с разделителем пробелом или знаком равенства `=`:
```text
cvar_name 1
cvar_name=1
cvar_name   1
cvar_name = 1
```

> [!NOTE]
> При запуске `./wb.sh <сервер>` загружается файл `./cfg/server/<сервер>.cfg` для определения версии и хоста игры. При выходе обновлений игры отредактируйте этот файл.

### 4 способа задания CVars:
1. В основном файле конфигурации `wb.cfg`;
2. Из файла, переданного при запуске: `./wb.sh eu -f <файл.cfg>`
3. Через аргумент командной строки: `./wb.sh eu -d <cvar=значение>`
4. Напрямую в интерактивной консоли: `CMD# cvar_name = значение`

### Переменные игры (Game CVars)
- `game_version`: Версия клиента игры при авторизации *(Обязательно)*;
- `game_server_name`: Идентификатор сервера игры *(Обязательно)*;
- `game_crypt_iv`: Переопределение IV ключа шифрования сервера (по умолчанию: NULL);
- `game_crypt_key`: Переопределение ключа шифрования сервера (по умолчанию: NULL);
- `game_hwid`: Значение HWID при логине (по умолчанию: 0);
- `game_manual_profile_creation`: Не создавать профиль автоматически при его отсутствии, ожидая команду `create <никнейм>` (по умолчанию: FALSE);
- `g_language`: Язык при запуске для чтения `cfg/lang/<g_language>.cfg` (по умолчанию: english).

### Переменные CryOnline (CryOnline CVars)
- `online_server`: Хост сервера игры (по умолчанию: NULL);
- `online_server_port`: Порт сервера (по умолчанию: 5222);
- `online_channel_type`: Начальный тип канала при входе (по умолчанию: pve);
- `online_pvp_rank`: Ранг аккаунта для выбора подходящего PvP канала (по умолчанию: 1);
- `online_host`: Имя сервера XMPP (по умолчанию: warface);
- `online_bootstrap`: Префикс для `online_host` (по умолчанию: NULL);
- `online_region_id`: Регион подключения (по умолчанию: global);
- `online_use_protect`: Использование дополнительного уровня шифрования (по умолчанию: TRUE);
- `online_use_tls`: Использование протокола TLS (по умолчанию: TRUE).

### Переменные DBus (DBus CVars)
- `dbus_id`: Уникальный идентификатор DBus для создания имени шины бота *(Обязательно в режиме DBus)*.

### Переменные запросов и кэша (Query CVars)
- `query_dump_to_file`: Запись запросов в файл в режиме DEBUG (по умолчанию: FALSE);
- `query_dump_location`: Папка для сохранения запросов (по умолчанию: `./Logs/`);
- `query_debug`: Вывод запросов в stdout в режиме DEBUG (по умолчанию: TRUE);
- `query_cache`: Включение кэширования запросов (по умолчанию: TRUE);
- `query_cache_location`: Папка для хранения кэша (по умолчанию: `./QueryCache/`);
- `query_disable_items`: Отключение получения предметов инвентаря (по умолчанию: FALSE);
- `query_disable_shop_get_offers`: Отключение загрузки товаров и коробок удачи (по умолчанию: FALSE);
- `query_disable_quickplay_maplist`: Отключение загрузки списка карт быстрой игры (по умолчанию: FALSE);
- `query_disable_get_configs`: Отключение загрузки конфигураций игры (по умолчанию: FALSE).

*Совет по оптимизации: Для ускорения входа и переключения каналов рекомендуется отключить последние четыре опции, если они не требуются для текущих задач.*

### Переменные WarfaceBot (Warfacebot CVars)
- `wb_safemaster`: Режим безопасного мастера комнаты (по умолчанию: FALSE);
- `wb_safemaster_room_name`: Имя комнаты в режиме safemaster;
- `wb_safemaster_channel`: Канал комнаты safemaster (по умолчанию: pvp_pro_1);
- `wb_join_global_rooms`: Разрешить команду `say` для глобальных каналов (по умолчанию: FALSE);
- `wb_accept_friend_requests`: Автоматически принимать заявки в друзья (по умолчанию: TRUE);
- `wb_postpone_friend_requests`: Игнорировать заявки в друзья (по умолчанию: FALSE);
- `wb_accept_clan_invites`: Автоматически принимать приглашения в клан (по умолчанию: TRUE);
- `wb_postpone_clan_invites`: Игнорировать приглашения в клан (по умолчанию: FALSE);
- `wb_enable_whisper_commands`: Обрабатывать команды шепота из чата (по умолчанию: TRUE);
- `wb_leave_on_start`: Автоматически выходить из комнаты при старте игры (по умолчанию: TRUE);
- `wb_accept_room_follows`: Разрешить друзьям следовать за ботом в комнату (по умолчанию: TRUE);
- `wb_accept_room_invitations`: Принимать приглашения в комнаты от друзей (по умолчанию: TRUE);
- `wb_postpone_room_invitations`: Игнорировать приглашения в комнаты (по умолчанию: FALSE);
- `wb_enable_invite`: Включить команду шепота `invite` (по умолчанию: TRUE);
- `wb_auto_start`: Автоматически запускать комнату при получении прав лидера (по умолчанию: TRUE);
- `wb_auto_afk`: Включать статус АФК при простое (по умолчанию: FALSE);
- `wb_ping_unit`: Интервал проверки пинга (по умолчанию: 60 сек);
- `wb_ping_count_is_afk`: Количество интервалов перед отправкой АФК (по умолчанию: 1);
- `wb_ping_count_is_stall`: Интервалы без активности до пинга (по умолчанию: 3);
- `wb_ping_count_is_over`: Интервалы до фиксации потери соединения (по умолчанию: 4);
- `wb_ping_count_is_outdated`: Интервалы до принудительного обновления профиля (по умолчанию: 5);
- `wb_qp_search_started`: Принимать комнаты быстрой игры, которые уже начались (по умолчанию: TRUE);
- `wb_qp_search_non_started`: Принимать комнаты быстрой игры, которые еще не начались (по умолчанию: TRUE).

---

## <img src="https://api.iconify.design/solar:medal-ribbons-star-bold.svg?color=%23F59E0B&width=20" align="top" /> Благодарности и авторы

> [!NOTE]
> Fork de um projeto que merece crédito. Se este trabalho foi útil, o original também foi.

<div align="center">

Based on [WarfaceBot](https://github.com/Levak/warfacebot) by [Levak](https://github.com/Levak) · AGPL-3.0 License

<br />

Оригинальный проект

[![LEVAK - WARFACEBOT](https://img.shields.io/badge/LEVAK-WARFACEBOT-black?style=for-the-badge&logo=github)](https://github.com/Levak/warfacebot)

<br />

<p align="center">
  <sub><b>Авторы и контрибьюторы оригинального проекта:</b></sub><br />
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

Исправления и консольная панель в этом форке

[![@OTHEMANDALORIANO](https://img.shields.io/badge/@OTHEMANDALORIANO-black?style=for-the-badge&logo=github)](https://github.com/OTheMandaloriano)

</div>

---

## <img src="https://api.iconify.design/solar:document-text-bold.svg?color=%233B82F6&width=20" align="top" /> Лицензия

Программа распространяется на условиях свободной лицензии **GNU Affero General Public License v3.0 (AGPLv3)**. Полный текст условий содержится в файле [LICENSE](../../LICENSE).
