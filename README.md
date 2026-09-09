<div align="center">
  <a href="README.md"><img src="https://api.iconify.design/circle-flags:br.svg?width=28" alt="Português (Brasil)" /></a>
  &nbsp;&nbsp;
  <a href="docs/idiomas/README.en.md"><img src="https://api.iconify.design/circle-flags:us.svg?width=28" alt="English" /></a>
  &nbsp;&nbsp;
  <a href="docs/idiomas/README.ru.md"><img src="https://api.iconify.design/circle-flags:ru.svg?width=28" alt="Русский" /></a>
</div>

<br />

<div align="center">

# WarfaceBot

[![Licença: AGPLv3](https://img.shields.io/badge/Licen%C3%A7a-AGPLv3-3B82F6.svg?style=for-the-badge)](LICENSE)
[![Linguagem: C99](https://img.shields.io/badge/Linguagem-C99-blue.svg?style=for-the-badge&logo=c)](Makefile)
[![Dashboard: Terminal](https://img.shields.io/badge/Dashboard-Terminal%20TUI-10B981.svg?style=for-the-badge)](wb_dashboard.sh)
[![Idiomas: 3](https://img.shields.io/badge/Idiomas-PT--BR%20%7C%20EN%20%7C%20RU-F97316.svg?style=for-the-badge)](docs/idiomas/)
[![Plataforma: Linux / Windows](https://img.shields.io/badge/Plataforma-Linux%20%7C%20Windows-6B7280.svg?style=for-the-badge)](releases)

**Cliente headless XMPP e gerenciador automatizado de sessões para Warface com painel interativo de console**

</div>

---

## <img src="https://api.iconify.design/solar:info-circle-bold.svg?color=%233B82F6&width=20" align="top" /> Sobre o Programa

O **WarfaceBot** é um cliente XMPP headless desenvolvido exclusivamente para o Warface. O jogo utiliza um protocolo customizado sobreposto para encapsular e proteger a comunicação XMPP. Por ser um cliente headless (sem interface gráfica 3D do jogo), ele executa todas as operações de lobby, salas e gerenciamento de inventário sem a necessidade de abrir o cliente pesado do jogo, podendo ser executado em computadores modestos ou servidores dedicados.

O programa é distribuído totalmente funcional e modular, permitindo integrações customizadas (como suporte a Cleverbot, coleta de métricas estatísticas de partidas ou comandos de automação personalizados). Ele inclui console interativo para execução de comandos restritos ao operador e envio manual de consultas XMPP.

---

## <img src="https://api.iconify.design/solar:question-circle-bold.svg?color=%233B82F6&width=20" align="top" /> Por que o Projeto Foi Criado (Motivação)

Após a [análise detalhada do protocolo de rede in-game do Warface](https://stackedit.io/viewer#!provider=gist&gistId=b9a1852a0a17e334f041&filename=wfre), o autor original decidiu construir um cliente headless para realizar tarefas estatísticas. Durante o desenvolvimento, constatou-se que o software viabilizava diversas outras utilidades práticas, como a **abertura de salas para partidas solo**, permitindo que jogadores enfrentem desafios sem a obrigatoriedade de compor times completos de 5 jogadores exigidos pelo cliente oficial.

---

## <img src="https://api.iconify.design/solar:server-square-bold.svg?color=%233B82F6&width=20" align="top" /> Como Funciona

O programa opera de maneira idêntica a um cliente de jogo legítimo. Trata-se de uma implementação do protocolo sobreposto do Warface, do padrão XMPP de presença e das consultas XML proprietárias utilizadas pelos servidores da CryOnline. Todas as ações de lobby e loja ocorrem através dessas requisições XMPP.

A arquitetura é dividida em duas etapas principais:

1. **Launcher (Inicializador)**: Responsável por realizar a autenticação HTTP no servidor de login e obter o *session token*. Por ser desacoplado em scripts, permite fácil customização para diferentes servidores regionais (EU, NA, BR, RU, VN). Estão disponíveis os seguintes launchers:
   - `wb.sh`: Lançador Bash para ambientes Linux e Git Bash;
   - `wb_launcher.hta`: Interface gráfica leve para usuários Windows;
   - `wbd_launcher`: Lançador Bash para execução quando o warfacebot é compilado com suporte a DBus;
   - `wbm_launcher`: Lançador Bash para o gerenciador DBus;
   - `wb_dashboard.sh`: Nosso novo painel interativo de console com suporte multi-idioma.

2. **Client (`wb` / `wb.exe`)**: O binário executável principal em C. Utiliza o token de sessão gerado pelo launcher para estabelecer conexão no serviço XMPP via TLS e assumir o comportamento do jogador no lobby.

---

## <img src="https://api.iconify.design/solar:monitor-smartphone-bold.svg?color=%233B82F6&width=20" align="top" /> Novidade: Painel Interativo de Console (Dashboard v2.0)

Neste fork foi introduzido o `wb_dashboard.sh`, um painel interativo no terminal projetado para administração ágil de sessões. Ele traz ergonomia visual, telemetria de conexão e acesso rápido a todas as funções:

```text
  ========================================================================
    WARFACEBOT • PAINEL DE CONTROLE | Levak
  ========================================================================
   BOT: Shadow_104     SERVER: 127.0.0.1:5222    STATUS: ONLINE [OK]
  ========================================================================
  PERFIL DO BOT           SALA DE JOGO              SISTEMA E REDE
  Nick:     Shadow_104    Sala:     Lobby_PvE       Ping:      12ms
  Rank:     1             Missao:   Normal          Uptime:    00:15:32
  Clan:     Sem Cla       Lider:    Shadow_104      Memoria:   34.5 MB
  GP$:      50000         Jogadores:1/5             Threads:   5 Active
  Coroas:   500
  ========================================================================
  CLASSE: [Fuzileiro]  PRONTO: NAO  AUTO-SEGUIR: SIM
  ========================================================================

  [01] • CONECTAR AO JOGO (SESSAO REAL)   [08] • SEGUIR JOGADOR
  [02] • ALTERAR CLASSE                   [09] • PASSAR LIDER
  [03] • PRONTO / NAO PRONTO              [10] • CONVIDAR AMIGO
  [04] • CRIAR SALA PVE                   [11] • ADICIONAR AMIGO (ENVIAR)
  [05] • CRIAR SALA PVP                   [12] • LISTA DE AMIGOS
  [06] • INICIAR PARTIDA                  [13] • DETALHES DO BOT
  [07] • SAIR DA SALA                     [14] • CONFIGURAR CONTA/SERVIDOR
                                          [15] • ALTERAR IDIOMA
                                          [00] • DESCONECTAR E SAIR <<<

  ========================================================================
  [*] NOTIFICACOES E EVENTOS RECENTES:
    [18:30:10] Conectado com sucesso ao servidor XMPP (127.0.0.1:5222).
    [18:30:30] Bot pronto para operacao sob o nick: Shadow_104.
    [18:31:00] Auto-aceite de amizade e convites de sala ativo.
  ========================================================================

  Escolha uma opcao :
```

### Características do Dashboard
- **Assistente de Onboarding (Setup Wizard)**: No primeiro uso, o painel pergunta o idioma preferido (`Português`, `English`, `Русский`) e guia a configuração do servidor (IP/Porta), versão do Warface e credenciais da conta do bot (com opção de gerar codinomes aleatórios como `Shadow_421`).
- **Auto-Login e Sessão Persistente**: Salva com segurança as definições locais em `.wb_config` e gera o arquivo `cfg/server/custom.cfg` (ambos protegidos no `.gitignore`). Nas execuções seguintes, o painel abre diretamente sem refazer perguntas.
- **Conexão Real ao Jogo [01]**: Inicia o executável `wb.exe` conectando diretamente ao servidor configurado com o token e UID da conta.
- **Ajuda In-Game por Sussurro**: Qualquer mensagem enviada para o bot no chat privado (`/w <NomeDoBot> help`) recebe como resposta a lista de comandos suportados:
  `[WarfaceBot] Comandos: ready [classe] | unready | switch | start | leave | master | stay | invite`
- **Gestão de Amigos e Auto-Aceite [11]**: O bot aceita automaticamente solicitações de amizade recebidas e permite enviar novos pedidos de amizade diretamente pelo menu do terminal.
- **Alternância Instantânea de Idioma [15]**: Permite trocar o idioma da interface a qualquer momento.
- **Entrada Híbrida**: Permite navegar pelas opções numéricas (`01` a `15`) ou digitar comandos manuais (`open`, `say`, `quit`, `stats`).

---

## <img src="https://api.iconify.design/solar:shield-warning-bold.svg?color=%23F97316&width=20" align="top" /> Avisos Importantes e Recomendações

> [!WARNING]
> **Isolamento de Ambiente e Risco de Banimento**: Não execute o bot na mesma máquina física ou sob o mesmo IP público em que você joga com sua conta principal. Sistemas de detecção automática podem emitir suspensões temporárias. Utilize sempre uma máquina virtual, sandbox dedicada ou servidor remoto.

> [!NOTE]
> **Limitações Conhecidas de Detecção (TODO original)**:
> - **HWID**: Não possui gerador dinâmico de HWID nativo. Servidores que validam rigidez de HWID podem desconectar o bot. Use a CVar `game_hwid` na inicialização para fornecer um identificador válido.
> - **Parser XML**: As consultas utilizam templates manuais de formatação de strings em vez de um parser XML genérico. Opera com estabilidade nos servidores suportados, mas pode requerer ajustes caso o servidor envie nós XML não mapeados.

---

## <img src="https://api.iconify.design/solar:users-group-rounded-bold.svg?color=%233B82F6&width=20" align="top" /> Preparação e Vinculação de Contas

Se deseja usar o bot para iniciar partidas solo ou dar suporte, você deve preparar a conta do bot previamente no jogo oficial antes de conectá-la:

- **Salas Skilled e Hardcore (Iniciado / Regular / Pro)**: Desbloqueadas a partir do **nível 4**. É necessário concluir o tutorial de classes, mapas de iniciação e partidas rápidas (aproximadamente **30 minutos de jogo por conta**).
- **Salas Survival (Sobrevivência)**: Desbloqueadas a partir do **nível 10** (a missão ColdPeak exige nível 25). É necessário jogar partidas no modo Tempestade/PvP (aproximadamente **2 dias de jogo por conta**).

### Passos para Vincular a Conta Principal com o Bot:
1. Crie uma conta dedicada para o bot.
2. Inicie a conta do bot usando o WarfaceBot (`./wb_dashboard.sh` ou `./wb.sh <servidor>`).
3. Inicie sua conta principal através do cliente oficial do Warface.
4. Envie uma solicitação de amizade da sua conta principal para a conta do bot.
5. O bot aceitará o convite de amizade automaticamente.
6. *(Opcional)*: Abra a conta do bot no cliente oficial caso necessite subir para o nível 4 ou 10.

---

## <img src="https://api.iconify.design/solar:play-circle-bold.svg?color=%2310B981&width=20" align="top" /> Instalação e Compilação

### Opção 1: Pacote Pré-compilado para Windows
Na aba de [Releases](../../releases) deste repositório:
1. Baixe o pacote `warfacebot-v2.0.0-dashboard.zip`.
2. Extraia o arquivo zip em qualquer pasta.
3. Dê dois cliques em `dashboard.bat` (ou execute `./wb_dashboard.sh` pelo Git Bash).
4. No primeiro acesso, o Assistente de Configuração solicitará o idioma, dados do servidor (Host, Porta, Versão) e credenciais da conta do bot (com sugestão aleatória de nickname caso queira criar um novo).
5. As configurações serão salvas localmente em `.wb_config` e `cfg/server/custom.cfg` para auto-login futuro.

### Opção 2: Compilação Manual (Linux / Cygwin)

#### Pacotes Necessários (Cygwin / Distribuições Linux):
- `gcc` / `gcc-core` (Compilador C99)
- `make` (Ferramenta de build)
- `libcurl` / `curl`
- `zlib` / `zlib-devel` / `zlib1g-dev`
- `openssl` / `libssl-devel`
- `libreadline` / `libreadline-devel`

#### Procedimento de Compilação:
```bash
git clone https://github.com/OTheMandaloriano/warfacebot.git
cd warfacebot
make
```

#### Execução:
```bash
# Executar com o novo painel interativo:
./wb_dashboard.sh

# Ou executar o inicializador clássico em linha de comando:
./wb.sh eu
# Para outros servidores regionais:
./wb.sh br
./wb.sh ru
```

---

## <img src="https://api.iconify.design/solar:chat-round-line-bold.svg?color=%233B82F6&width=20" align="top" /> Comandos de Whisper (Sussurro In-Game)

Sua conta principal pode controlar o bot remotamente enviando comandos no chat privado (`/w <NomeDoBot> <comando>`):

| Comando | Argumentos | Descrição |
| :--- | :--- | :--- |
| `help` | - | Retorna no chat a lista de comandos suportados pelo bot |
| `follow` | `[apelido]` | Ordena que o bot siga o jogador para a sala atual |
| `invite` | `[apelido]` | Solicita que o bot envie um convite para a sala em que ele se encontra |
| `ready` | - | Define o status do bot no lobby como pronto |
| `take <classe>` | `<classe>` | Atalho para `ready <classe>`. Força a classe (`rifleman`, `medic`, `engineer`, `sniper`) |
| `master` | - | Pede para o bot passar a liderança da sala (Room Master) para você |
| `start` | - | Se o bot for o líder, inicia a partida |
| `stay` | - | Garante permanência na sala mesmo após o início da partida (por 1h ou até sair) |
| `switch` | - | Em partidas PvP, tenta trocar de equipe |
| `unready` | - | Mantém o bot desmarcado até novo comando `ready` ou saída da sala |
| `missions` | - | Consulta os objetivos e desafios de Coroas |
| `whois <apelido>` | `<apelido>` | Consulta país de conexão e status no lobby de qualquer jogador conectado |
| `leave` | - | Faz o bot sair imediatamente da sala atual |

---

## <img src="https://api.iconify.design/solar:code-square-bold.svg?color=%233B82F6&width=20" align="top" /> Comandos de Operador no Console

Comandos executados diretamente no prompt CMD# do bot ou acionados pelo painel interativo:

| Comando | Descrição |
| :--- | :--- |
| `create <apelido>` | Cria um novo perfil de jogador no servidor (ver CVar `game_manual_profile_creation`) |
| `add <apelido>` | Envia convite de amizade para o jogador especificado |
| `remove <apelido>` | Remove o usuário especificado da lista de amigos |
| `removeall` | Remove todos os usuários da lista de amigos |
| `say <mensagem>` | Envia mensagem no chat da sala de jogo atual |
| `open <mapa/missao>` | Cria uma sala com a missão PvE ou mapa PvP especificado |
| `name <nome_sala>` | Altera o nome da sala PvP |
| `change <mapa/missao>` | Altera a missão ou mapa da sala ativa |
| `safe <mapa>` | Cria sala protegida por lista negra (ver `src/cmds/cmd_safe.c`) |
| `channel <canal>` | Troca para canal específico (`pve`, `pvp_pro_1`, etc.) |
| `whisper <apelido> <msg>` | Envia mensagem privada para um amigo ou membro de clã |
| `friends` | Lista amigos e membros de clã cadastrados |
| `sleep [n]` | Pausa a thread readline por *n* segundos (padrão: 1 segundo) |
| `stats` | Exibe estatísticas completas de tráfego de todos os canais |
| `stay <qtd> [unidade]` | Mantém o bot na sala após o início por uma quantidade de tempo especificada |
| `randombox [<nome> <qtd>]` | Abre caixas aleatórias da loja ou lista as caixas disponíveis |
| `last <apelido>` | Mostra a data e hora da última vez que um amigo foi visto online |
| `quickplay <cmd> [arg]` | Matchmaking de partida rápida (`open`, `invite`, `cancel`, `start`) |
| `quit` | Encerra a conexão e finaliza o WarfaceBot com segurança |

---

## <img src="https://api.iconify.design/solar:tuning-square-2-bold.svg?color=%23F97316&width=20" align="top" /> Variáveis de Console (CVars)

As CVars permitem alterar dinamicamente o comportamento do bot sem necessidade de recompilação.

Os arquivos de configuração utilizam sintaxe separada por token único (espaço, sinal de igualdade `=` ou ambos):
```text
cvar_name 1
cvar_name=1
cvar_name   1
cvar_name = 1
```

> [!NOTE]
> Ao usar `./wb.sh <servidor>`, o arquivo `./cfg/server/<servidor>.cfg` é carregado para definir a versão e o host do jogo. Se o jogo for atualizado, atualize este arquivo com a nova versão.

### 4 Formas de Definir CVars:
1. No arquivo padrão `wb.cfg`;
2. Em arquivo de configuração informado na inicialização: `./wb.sh eu -f <arquivo.cfg>`
3. Como variável direta na linha de inicialização: `./wb.sh eu -d <cvar=valor>`
4. Diretamente no prompt de comando: `CMD# cvar_name = valor`

### Variáveis do Jogo (Game CVars)
- `game_version`: Versão do cliente de jogo exigida no login *(Obrigatória)*;
- `game_server_name`: Identificador do servidor de jogo *(Obrigatório)*;
- `game_crypt_iv`: Sobrescrita opcional do IV de criptografia do servidor (padrão: NULL);
- `game_crypt_key`: Sobrescrita opcional da chave de criptografia do servidor (padrão: NULL);
- `game_hwid`: HWID enviado no login (padrão: 0);
- `game_manual_profile_creation`: Não tenta criar perfil automaticamente caso nenhum seja encontrado, aguardando o comando `create <apelido>` (padrão: FALSE);
- `g_language`: Idioma utilizado na inicialização para ler `cfg/lang/<idioma>.cfg` (padrão: english).

### Variáveis CryOnline (CryOnline CVars)
- `online_server`: Endereço do host do servidor de jogo (padrão: NULL);
- `online_server_port`: Porta do servidor (padrão: 5222);
- `online_channel_type`: Tipo de canal padrão para conexão (padrão: pve);
- `online_pvp_rank`: Patente salva da conta para encontrar canal PvP compatível (padrão: 1);
- `online_host`: Nome do servidor XMPP (padrão: warface);
- `online_bootstrap`: Prefixo para `online_host` (padrão: NULL);
- `online_region_id`: Região de conexão (padrão: global);
- `online_use_protect`: Utiliza camada extra de proteção proprietária (padrão: TRUE);
- `online_use_tls`: Utiliza criptografia TLS na camada de transporte (padrão: TRUE).

### Variáveis DBus (DBus CVars)
- `dbus_id`: Identificador único DBus utilizado para criar o busname do bot *(Obrigatório no modo DBus)*.

### Variáveis de Consulta e Cache (Query CVars)
- `query_dump_to_file`: Grava histórico de queries XML em arquivo em modo DEBUG (padrão: FALSE);
- `query_dump_location`: Diretório onde salvar queries gravadas (padrão: `./Logs/`);
- `query_debug`: Exibe queries na saída padrão em modo DEBUG (padrão: TRUE);
- `query_cache`: Ativa sistema de cache local de consultas (padrão: TRUE);
- `query_cache_location`: Diretório para armazenar o cache de consultas (padrão: `./QueryCache/`);
- `query_disable_items`: Desativa a busca de itens de inventário (padrão: FALSE);
- `query_disable_shop_get_offers`: Desativa busca de ofertas e caixas da loja (padrão: FALSE);
- `query_disable_quickplay_maplist`: Desativa busca de lista de mapas para PvP rápido (padrão: FALSE);
- `query_disable_get_configs`: Desativa busca de configurações do jogo (padrão: FALSE).

*Dica de Desempenho: Para otimizar a velocidade de conexão do bot e trocas de canal, recomenda-se desativar as quatro opções acima caso não pretenda usar compras da loja ou quickplay.*

### Variáveis do WarfaceBot (Warfacebot CVars)
- `wb_safemaster`: Configura o bot como safemaster (padrão: FALSE);
- `wb_safemaster_room_name`: Nome padrão da sala em modo safemaster;
- `wb_safemaster_channel`: Canal padrão da sala safemaster (padrão: pvp_pro_1);
- `wb_join_global_rooms`: Habilita o comando `say` para canais globais (padrão: FALSE);
- `wb_accept_friend_requests`: Aceita automaticamente solicitações de amizade (padrão: TRUE);
- `wb_postpone_friend_requests`: Ignora e adia solicitações de amizade (padrão: FALSE);
- `wb_accept_clan_invites`: Aceita automaticamente convites para clã (padrão: TRUE);
- `wb_postpone_clan_invites`: Ignora e adia convites para clã (padrão: FALSE);
- `wb_enable_whisper_commands`: Processa comandos recebidos por sussurro (padrão: TRUE);
- `wb_leave_on_start`: Sai da sala automaticamente no início da partida (padrão: TRUE);
- `wb_accept_room_follows`: Aceita que amigos sigam o bot para a sala (padrão: TRUE);
- `wb_accept_room_invitations`: Aceita convites de salas enviados por amigos (padrão: TRUE);
- `wb_postpone_room_invitations`: Ignora convites de salas (padrão: FALSE);
- `wb_enable_invite`: Habilita o comando de sussurro `invite` (padrão: TRUE);
- `wb_auto_start`: Inicia a partida automaticamente quando for o líder da sala (padrão: TRUE);
- `wb_auto_afk`: Habilita estado ausente (AFK) quando ocioso (padrão: FALSE);
- `wb_ping_unit`: Intervalo base da thread de ping (padrão: 60 segundos);
- `wb_ping_count_is_afk`: Unidades de ping para enviar status AFK (padrão: 1);
- `wb_ping_count_is_stall`: Unidades de ping sem consultas antes de emitir ping (padrão: 3);
- `wb_ping_count_is_over`: Unidades de ping antes de considerar conexão perdida (padrão: 4);
- `wb_ping_count_is_outdated`: Unidades de ping antes de forçar atualização de status do perfil (padrão: 5);
- `wb_qp_search_started`: Aceita partidas de quickplay que já começaram (padrão: TRUE);
- `wb_qp_search_non_started`: Aceita partidas de quickplay ainda não iniciadas (padrão: TRUE).

---

## <img src="https://api.iconify.design/solar:medal-ribbons-star-bold.svg?color=%23F59E0B&width=20" align="top" /> Créditos

> [!NOTE]
> Fork de um projeto que merece crédito. Se este trabalho foi útil, o original também foi.

<div align="center">

Based on [WarfaceBot](https://github.com/Levak/warfacebot) by [Levak](https://github.com/Levak) · AGPL-3.0 License

<br />

Projeto original

[![LEVAK - WARFACEBOT](https://img.shields.io/badge/LEVAK-WARFACEBOT-black?style=for-the-badge&logo=github)](https://github.com/Levak/warfacebot)

<br />

<p align="center">
  <sub><b>Contribuidores originais do projeto:</b></sub><br />
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

Correções e Dashboard neste fork

[![@OTHEMANDALORIANO](https://img.shields.io/badge/@OTHEMANDALORIANO-black?style=for-the-badge&logo=github)](https://github.com/OTheMandaloriano)

</div>

---

## <img src="https://api.iconify.design/solar:document-text-bold.svg?color=%233B82F6&width=20" align="top" /> Licença

Este programa é distribuído sob os termos da licença **GNU Affero General Public License v3.0 (AGPLv3)**. Por favor, reserve um tempo para ler e compreender o arquivo [LICENSE](LICENSE) fornecido neste repositório.
