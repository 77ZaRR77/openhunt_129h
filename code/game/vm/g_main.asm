data
align 4
LABELV gameCvarTable
address g_cheats
address $53
address $54
byte 4 0
byte 4 0
byte 4 0
skip 4
byte 4 0
address $55
address $56
byte 4 68
byte 4 0
byte 4 0
skip 4
byte 4 0
address $57
address $58
byte 4 64
byte 4 0
byte 4 0
skip 4
address g_restarted
address $59
address $60
byte 4 64
byte 4 0
byte 4 0
skip 4
byte 4 0
address $61
address $54
byte 4 68
byte 4 0
byte 4 0
skip 4
address g_gametype
address $62
address $60
byte 4 38
byte 4 0
byte 4 0
skip 4
address g_maxclients
address $63
address $64
byte 4 37
byte 4 0
byte 4 0
skip 4
address g_maxGameClients
address $65
address $60
byte 4 37
byte 4 0
byte 4 0
skip 4
address g_dmflags
address $66
address $60
byte 4 5
byte 4 0
byte 4 1
skip 4
address g_fraglimit
address $67
address $68
byte 4 1029
byte 4 0
byte 4 1
skip 4
address g_timelimit
address $69
address $60
byte 4 1029
byte 4 0
byte 4 1
skip 4
address g_capturelimit
address $70
address $64
byte 4 1029
byte 4 0
byte 4 1
skip 4
address g_synchronousClients
address $71
address $60
byte 4 8
byte 4 0
byte 4 0
skip 4
address g_friendlyFire
address $72
address $60
byte 4 1
byte 4 0
byte 4 1
skip 4
address g_teamAutoJoin
address $73
address $60
byte 4 1
skip 12
address g_teamForceBalance
address $74
address $60
byte 4 1
skip 12
address g_warmup
address $75
address $68
byte 4 1
byte 4 0
byte 4 1
skip 4
address g_doWarmup
address $76
address $60
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_log
address $77
address $78
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_logSync
address $79
address $60
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_password
address $80
address $54
byte 4 2
byte 4 0
byte 4 0
skip 4
address g_banIPs
address $81
address $54
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_filterBan
address $82
address $83
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_needpass
address $84
address $60
byte 4 68
byte 4 0
byte 4 0
skip 4
address g_dedicated
address $85
address $60
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_speed
address $86
address $87
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_gravity
address $88
address $89
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_knockback
address $90
address $91
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_quadfactor
address $92
address $93
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_weaponRespawn
address $94
address $95
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_weaponTeamRespawn
address $96
address $97
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_forcerespawn
address $98
address $68
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_inactivity
address $99
address $60
byte 4 0
byte 4 0
byte 4 1
skip 4
address g_debugMove
address $100
address $60
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_debugDamage
address $101
address $60
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_debugAlloc
address $102
address $60
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_motd
address $103
address $54
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_blood
address $104
address $83
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_podiumDist
address $105
address $106
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_podiumDrop
address $107
address $108
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_allowVote
address $109
address $83
byte 4 1
byte 4 0
byte 4 0
skip 4
address g_listEntity
address $110
address $60
byte 4 0
byte 4 0
byte 4 0
skip 4
address g_smoothClients
address $111
address $83
byte 4 0
byte 4 0
byte 4 0
skip 4
address pmove_fixed
address $112
address $60
byte 4 8
byte 4 0
byte 4 0
skip 4
address pmove_msec
address $113
address $64
byte 4 8
byte 4 0
byte 4 0
skip 4
address g_rankings
address $114
address $60
byte 4 0
byte 4 0
byte 4 0
skip 4
align 4
LABELV gameCvarTableSize
byte 4 46
export vmMain
code
proc vmMain 16 12
file "../g_main.c"
line 183
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:#include "g_local.h"
;5:
;6:level_locals_t	level;
;7:
;8:typedef struct {
;9:	vmCvar_t	*vmCvar;
;10:	char		*cvarName;
;11:	char		*defaultString;
;12:	int			cvarFlags;
;13:	int			modificationCount;  // for tracking changes
;14:	qboolean	trackChange;	    // track this variable, and announce if changed
;15:  qboolean teamShader;        // track and if changed, update shader state
;16:} cvarTable_t;
;17:
;18:gentity_t		g_entities[MAX_GENTITIES];
;19:gclient_t		g_clients[MAX_CLIENTS];
;20:
;21:vmCvar_t	g_gametype;
;22:vmCvar_t	g_dmflags;
;23:vmCvar_t	g_fraglimit;
;24:vmCvar_t	g_timelimit;
;25:vmCvar_t	g_capturelimit;
;26:vmCvar_t	g_friendlyFire;
;27:vmCvar_t	g_password;
;28:vmCvar_t	g_needpass;
;29:vmCvar_t	g_maxclients;
;30:vmCvar_t	g_maxGameClients;
;31:vmCvar_t	g_dedicated;
;32:vmCvar_t	g_speed;
;33:vmCvar_t	g_gravity;
;34:vmCvar_t	g_cheats;
;35:vmCvar_t	g_knockback;
;36:vmCvar_t	g_quadfactor;
;37:vmCvar_t	g_forcerespawn;
;38:vmCvar_t	g_inactivity;
;39:vmCvar_t	g_debugMove;
;40:vmCvar_t	g_debugDamage;
;41:vmCvar_t	g_debugAlloc;
;42:vmCvar_t	g_weaponRespawn;
;43:vmCvar_t	g_weaponTeamRespawn;
;44:vmCvar_t	g_motd;
;45:vmCvar_t	g_synchronousClients;
;46:vmCvar_t	g_warmup;
;47:vmCvar_t	g_doWarmup;
;48:vmCvar_t	g_restarted;
;49:vmCvar_t	g_log;
;50:vmCvar_t	g_logSync;
;51:vmCvar_t	g_blood;
;52:vmCvar_t	g_podiumDist;
;53:vmCvar_t	g_podiumDrop;
;54:vmCvar_t	g_allowVote;
;55:vmCvar_t	g_teamAutoJoin;
;56:vmCvar_t	g_teamForceBalance;
;57:vmCvar_t	g_banIPs;
;58:vmCvar_t	g_filterBan;
;59:vmCvar_t	g_smoothClients;
;60:vmCvar_t	pmove_fixed;
;61:vmCvar_t	pmove_msec;
;62:vmCvar_t	g_rankings;
;63:vmCvar_t	g_listEntity;
;64:#ifdef MISSIONPACK
;65:vmCvar_t	g_obeliskHealth;
;66:vmCvar_t	g_obeliskRegenPeriod;
;67:vmCvar_t	g_obeliskRegenAmount;
;68:vmCvar_t	g_obeliskRespawnDelay;
;69:vmCvar_t	g_cubeTimeout;
;70:vmCvar_t	g_redteam;
;71:vmCvar_t	g_blueteam;
;72:vmCvar_t	g_singlePlayer;
;73:vmCvar_t	g_enableDust;
;74:vmCvar_t	g_enableBreath;
;75:vmCvar_t	g_proxMineTimeout;
;76:#endif
;77:
;78:// bk001129 - made static to avoid aliasing
;79:static cvarTable_t		gameCvarTable[] = {
;80:	// don't override the cheat state set by the system
;81:	{ &g_cheats, "sv_cheats", "", 0, 0, qfalse },
;82:
;83:	// noset vars
;84:	{ NULL, "gamename", GAMEVERSION , CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },
;85:	{ NULL, "gamedate", __DATE__ , CVAR_ROM, 0, qfalse  },
;86:	{ &g_restarted, "g_restarted", "0", CVAR_ROM, 0, qfalse  },
;87:	{ NULL, "sv_mapname", "", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse  },
;88:
;89:	// latched vars
;90:	{ &g_gametype, "g_gametype", "0", CVAR_SERVERINFO | CVAR_USERINFO | CVAR_LATCH, 0, qfalse  },
;91:
;92:	{ &g_maxclients, "sv_maxclients", "8", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse  },
;93:	{ &g_maxGameClients, "g_maxGameClients", "0", CVAR_SERVERINFO | CVAR_LATCH | CVAR_ARCHIVE, 0, qfalse  },
;94:
;95:	// change anytime vars
;96:	{ &g_dmflags, "dmflags", "0", CVAR_SERVERINFO | CVAR_ARCHIVE, 0, qtrue  },
;97:	{ &g_fraglimit, "fraglimit", "20", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
;98:	{ &g_timelimit, "timelimit", "0", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
;99:	{ &g_capturelimit, "capturelimit", "8", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART, 0, qtrue },
;100:
;101:	{ &g_synchronousClients, "g_synchronousClients", "0", CVAR_SYSTEMINFO, 0, qfalse  },
;102:
;103:	{ &g_friendlyFire, "g_friendlyFire", "0", CVAR_ARCHIVE, 0, qtrue  },
;104:
;105:	{ &g_teamAutoJoin, "g_teamAutoJoin", "0", CVAR_ARCHIVE  },
;106:	{ &g_teamForceBalance, "g_teamForceBalance", "0", CVAR_ARCHIVE  },
;107:
;108:	{ &g_warmup, "g_warmup", "20", CVAR_ARCHIVE, 0, qtrue  },
;109:	{ &g_doWarmup, "g_doWarmup", "0", 0, 0, qtrue  },
;110:	{ &g_log, "g_log", "games.log", CVAR_ARCHIVE, 0, qfalse  },
;111:	{ &g_logSync, "g_logSync", "0", CVAR_ARCHIVE, 0, qfalse  },
;112:
;113:	{ &g_password, "g_password", "", CVAR_USERINFO, 0, qfalse  },
;114:
;115:	{ &g_banIPs, "g_banIPs", "", CVAR_ARCHIVE, 0, qfalse  },
;116:	{ &g_filterBan, "g_filterBan", "1", CVAR_ARCHIVE, 0, qfalse  },
;117:
;118:	{ &g_needpass, "g_needpass", "0", CVAR_SERVERINFO | CVAR_ROM, 0, qfalse },
;119:
;120:	{ &g_dedicated, "dedicated", "0", 0, 0, qfalse  },
;121:
;122:	{ &g_speed, "g_speed", "320", 0, 0, qtrue  },
;123:	{ &g_gravity, "g_gravity", "800", 0, 0, qtrue  },
;124:	{ &g_knockback, "g_knockback", "1000", 0, 0, qtrue  },
;125:	{ &g_quadfactor, "g_quadfactor", "3", 0, 0, qtrue  },
;126:	{ &g_weaponRespawn, "g_weaponrespawn", "5", 0, 0, qtrue  },
;127:	{ &g_weaponTeamRespawn, "g_weaponTeamRespawn", "30", 0, 0, qtrue },
;128:	{ &g_forcerespawn, "g_forcerespawn", "20", 0, 0, qtrue },
;129:	{ &g_inactivity, "g_inactivity", "0", 0, 0, qtrue },
;130:	{ &g_debugMove, "g_debugMove", "0", 0, 0, qfalse },
;131:	{ &g_debugDamage, "g_debugDamage", "0", 0, 0, qfalse },
;132:	{ &g_debugAlloc, "g_debugAlloc", "0", 0, 0, qfalse },
;133:	{ &g_motd, "g_motd", "", 0, 0, qfalse },
;134:	{ &g_blood, "com_blood", "1", 0, 0, qfalse },
;135:
;136:	{ &g_podiumDist, "g_podiumDist", "80", 0, 0, qfalse },
;137:	{ &g_podiumDrop, "g_podiumDrop", "70", 0, 0, qfalse },
;138:
;139:	{ &g_allowVote, "g_allowVote", "1", CVAR_ARCHIVE, 0, qfalse },
;140:	{ &g_listEntity, "g_listEntity", "0", 0, 0, qfalse },
;141:
;142:#ifdef MISSIONPACK
;143:	{ &g_obeliskHealth, "g_obeliskHealth", "2500", 0, 0, qfalse },
;144:	{ &g_obeliskRegenPeriod, "g_obeliskRegenPeriod", "1", 0, 0, qfalse },
;145:	{ &g_obeliskRegenAmount, "g_obeliskRegenAmount", "15", 0, 0, qfalse },
;146:	{ &g_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO, 0, qfalse },
;147:
;148:	{ &g_cubeTimeout, "g_cubeTimeout", "30", 0, 0, qfalse },
;149:	{ &g_redteam, "g_redteam", "Stroggs", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO , 0, qtrue, qtrue },
;150:	{ &g_blueteam, "g_blueteam", "Pagans", CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO , 0, qtrue, qtrue  },
;151:	{ &g_singlePlayer, "ui_singlePlayerActive", "", 0, 0, qfalse, qfalse  },
;152:
;153:	{ &g_enableDust, "g_enableDust", "0", CVAR_SERVERINFO, 0, qtrue, qfalse },
;154:	{ &g_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO, 0, qtrue, qfalse },
;155:	{ &g_proxMineTimeout, "g_proxMineTimeout", "20000", 0, 0, qfalse },
;156:#endif
;157:	{ &g_smoothClients, "g_smoothClients", "1", 0, 0, qfalse},
;158:	{ &pmove_fixed, "pmove_fixed", "0", CVAR_SYSTEMINFO, 0, qfalse},
;159:	{ &pmove_msec, "pmove_msec", "8", CVAR_SYSTEMINFO, 0, qfalse},
;160:
;161:	{ &g_rankings, "g_rankings", "0", 0, 0, qfalse}
;162:
;163:};
;164:
;165:// bk001129 - made static to avoid aliasing
;166:static int gameCvarTableSize = sizeof( gameCvarTable ) / sizeof( gameCvarTable[0] );
;167:
;168:
;169:void G_InitGame( int levelTime, int randomSeed, int restart );
;170:void G_RunFrame( int levelTime );
;171:void G_ShutdownGame( int restart );
;172:void CheckExitRules( void );
;173:
;174:
;175:/*
;176:================
;177:vmMain
;178:
;179:This is the only way control passes into the module.
;180:This must be the very first function compiled into the .q3vm file
;181:================
;182:*/
;183:int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
line 184
;184:	switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $116
ADDRLP4 0
INDIRI4
CNSTI4 10
GTI4 $116
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $129
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $129
address $118
address $119
address $120
address $124
address $122
address $123
address $125
address $121
address $126
address $127
address $128
code
LABELV $118
line 186
;185:	case GAME_INIT:
;186:		G_InitGame( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 G_InitGame
CALLV
pop
line 187
;187:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $115
JUMPV
LABELV $119
line 189
;188:	case GAME_SHUTDOWN:
;189:		G_ShutdownGame( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_ShutdownGame
CALLV
pop
line 190
;190:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $115
JUMPV
LABELV $120
line 192
;191:	case GAME_CLIENT_CONNECT:
;192:		return (int)ClientConnect( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 ClientConnect
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CVUI4 4
RETI4
ADDRGP4 $115
JUMPV
LABELV $121
line 194
;193:	case GAME_CLIENT_THINK:
;194:		ClientThink( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientThink
CALLV
pop
line 195
;195:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $115
JUMPV
LABELV $122
line 197
;196:	case GAME_CLIENT_USERINFO_CHANGED:
;197:		ClientUserinfoChanged( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 198
;198:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $115
JUMPV
LABELV $123
line 200
;199:	case GAME_CLIENT_DISCONNECT:
;200:		ClientDisconnect( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientDisconnect
CALLV
pop
line 201
;201:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $115
JUMPV
LABELV $124
line 203
;202:	case GAME_CLIENT_BEGIN:
;203:		ClientBegin( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientBegin
CALLV
pop
line 204
;204:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $115
JUMPV
LABELV $125
line 206
;205:	case GAME_CLIENT_COMMAND:
;206:		ClientCommand( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientCommand
CALLV
pop
line 207
;207:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $115
JUMPV
LABELV $126
line 209
;208:	case GAME_RUN_FRAME:
;209:		G_RunFrame( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_RunFrame
CALLV
pop
line 210
;210:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $115
JUMPV
LABELV $127
line 212
;211:	case GAME_CONSOLE_COMMAND:
;212:		return ConsoleCommand();
ADDRLP4 8
ADDRGP4 ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $115
JUMPV
LABELV $128
line 214
;213:	case BOTAI_START_FRAME:
;214:		return BotAIStartFrame( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 BotAIStartFrame
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $115
JUMPV
LABELV $116
line 217
;215:	}
;216:
;217:	return -1;
CNSTI4 -1
RETI4
LABELV $115
endproc vmMain 16 12
export G_Printf
proc G_Printf 1028 12
line 221
;218:}
;219:
;220:
;221:void QDECL G_Printf( const char *fmt, ... ) {
line 225
;222:	va_list		argptr;
;223:	char		text[1024];
;224:
;225:	va_start (argptr, fmt);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 226
;226:	vsprintf (text, fmt, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 227
;227:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 229
;228:
;229:	trap_Printf( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Printf
CALLV
pop
line 230
;230:}
LABELV $130
endproc G_Printf 1028 12
export G_Error
proc G_Error 1028 12
line 232
;231:
;232:void QDECL G_Error( const char *fmt, ... ) {
line 236
;233:	va_list		argptr;
;234:	char		text[1024];
;235:
;236:	va_start (argptr, fmt);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 237
;237:	vsprintf (text, fmt, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 238
;238:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 240
;239:
;240:	trap_Error( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 241
;241:}
LABELV $132
endproc G_Error 1028 12
export G_FindTeams
proc G_FindTeams 48 12
line 254
;242:
;243:/*
;244:================
;245:G_FindTeams
;246:
;247:Chain together all entities with a matching team field.
;248:Entity teams are used for item groups and multi-entity mover groups.
;249:
;250:All but the first will have the FL_TEAMSLAVE flag set and teammaster field set
;251:All but the last will have the teamchain field set to the next one
;252:================
;253:*/
;254:void G_FindTeams( void ) {
line 259
;255:	gentity_t	*e, *e2;
;256:	int		i, j;
;257:	int		c, c2;
;258:
;259:	c = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 260
;260:	c2 = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 261
;261:	for ( i=1, e=g_entities+i ; i < level.num_entities ; i++,e++ ){
ADDRLP4 16
CNSTI4 1
ASGNI4
ADDRLP4 4
CNSTI4 808
ADDRLP4 16
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
ADDRGP4 $138
JUMPV
LABELV $135
line 262
;262:		if (!e->inuse)
ADDRLP4 4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $140
line 263
;263:			continue;
ADDRGP4 $136
JUMPV
LABELV $140
line 264
;264:		if (!e->team)
ADDRLP4 4
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $142
line 265
;265:			continue;
ADDRGP4 $136
JUMPV
LABELV $142
line 266
;266:		if (e->flags & FL_TEAMSLAVE)
ADDRLP4 4
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $144
line 267
;267:			continue;
ADDRGP4 $136
JUMPV
LABELV $144
line 268
;268:		e->teammaster = e;
ADDRLP4 4
INDIRP4
CNSTI4 780
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 269
;269:		c++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 270
;270:		c2++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 271
;271:		for (j=i+1, e2=e+1 ; j < level.num_entities ; j++,e2++)
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
ASGNP4
ADDRGP4 $149
JUMPV
LABELV $146
line 272
;272:		{
line 273
;273:			if (!e2->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $151
line 274
;274:				continue;
ADDRGP4 $147
JUMPV
LABELV $151
line 275
;275:			if (!e2->team)
ADDRLP4 0
INDIRP4
CNSTI4 656
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $153
line 276
;276:				continue;
ADDRGP4 $147
JUMPV
LABELV $153
line 277
;277:			if (e2->flags & FL_TEAMSLAVE)
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $155
line 278
;278:				continue;
ADDRGP4 $147
JUMPV
LABELV $155
line 279
;279:			if (!strcmp(e->team, e2->team))
ADDRLP4 28
CNSTI4 656
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $157
line 280
;280:			{
line 281
;281:				c2++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 282
;282:				e2->teamchain = e->teamchain;
ADDRLP4 36
CNSTI4 776
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRLP4 4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 283
;283:				e->teamchain = e2;
ADDRLP4 4
INDIRP4
CNSTI4 776
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 284
;284:				e2->teammaster = e;
ADDRLP4 0
INDIRP4
CNSTI4 780
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 285
;285:				e2->flags |= FL_TEAMSLAVE;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1024
BORI4
ASGNI4
line 288
;286:
;287:				// make sure that targets only point at the master
;288:				if ( e2->targetname ) {
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $159
line 289
;289:					e->targetname = e2->targetname;
ADDRLP4 44
CNSTI4 652
ASGNI4
ADDRLP4 4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
ADDRLP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 290
;290:					e2->targetname = NULL;
ADDRLP4 0
INDIRP4
CNSTI4 652
ADDP4
CNSTP4 0
ASGNP4
line 291
;291:				}
LABELV $159
line 292
;292:			}
LABELV $157
line 293
;293:		}
LABELV $147
line 271
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
ASGNP4
LABELV $149
ADDRLP4 8
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $146
line 294
;294:	}
LABELV $136
line 261
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 808
ADDP4
ASGNP4
LABELV $138
ADDRLP4 16
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $135
line 296
;295:
;296:	G_Printf ("%i teams with %i entities\n", c, c2);
ADDRGP4 $161
ARGP4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 297
;297:}
LABELV $134
endproc G_FindTeams 48 12
export G_RemapTeamShaders
proc G_RemapTeamShaders 0 0
line 299
;298:
;299:void G_RemapTeamShaders() {
line 311
;300:#ifdef MISSIONPACK
;301:	char string[1024];
;302:	float f = level.time * 0.001;
;303:	Com_sprintf( string, sizeof(string), "team_icon/%s_red", g_redteam.string );
;304:	AddRemap("textures/ctf2/redteam01", string, f); 
;305:	AddRemap("textures/ctf2/redteam02", string, f); 
;306:	Com_sprintf( string, sizeof(string), "team_icon/%s_blue", g_blueteam.string );
;307:	AddRemap("textures/ctf2/blueteam01", string, f); 
;308:	AddRemap("textures/ctf2/blueteam02", string, f); 
;309:	trap_SetConfigstring(CS_SHADERSTATE, BuildShaderStateConfig());
;310:#endif
;311:}
LABELV $162
endproc G_RemapTeamShaders 0 0
export G_RegisterCvars
proc G_RegisterCvars 20 16
line 319
;312:
;313:
;314:/*
;315:=================
;316:G_RegisterCvars
;317:=================
;318:*/
;319:void G_RegisterCvars( void ) {
line 322
;320:	int			i;
;321:	cvarTable_t	*cv;
;322:	qboolean remapped = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 324
;323:
;324:	for ( i = 0, cv = gameCvarTable ; i < gameCvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 gameCvarTable
ASGNP4
ADDRGP4 $167
JUMPV
LABELV $164
line 325
;325:		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 327
;326:			cv->defaultString, cv->cvarFlags );
;327:		if ( cv->vmCvar )
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $168
line 328
;328:			cv->modificationCount = cv->vmCvar->modificationCount;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
LABELV $168
line 330
;329:
;330:		if (cv->teamShader) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $170
line 331
;331:			remapped = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 332
;332:		}
LABELV $170
line 333
;333:	}
LABELV $165
line 324
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
LABELV $167
ADDRLP4 4
INDIRI4
ADDRGP4 gameCvarTableSize
INDIRI4
LTI4 $164
line 335
;334:
;335:	if (remapped) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $172
line 336
;336:		G_RemapTeamShaders();
ADDRGP4 G_RemapTeamShaders
CALLV
pop
line 337
;337:	}
LABELV $172
line 340
;338:
;339:	// check some things
;340:	if ( g_gametype.integer < 0 || g_gametype.integer >= GT_MAX_GAME_TYPE ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 0
LTI4 $178
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
LTI4 $174
LABELV $178
line 341
;341:		G_Printf( "g_gametype %i is out of range, defaulting to 0\n", g_gametype.integer );
ADDRGP4 $179
ARGP4
ADDRGP4 g_gametype+12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 342
;342:		trap_Cvar_Set( "g_gametype", "0" );
ADDRGP4 $62
ARGP4
ADDRGP4 $60
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 343
;343:	}
LABELV $174
line 345
;344:
;345:	level.warmupModificationCount = g_warmup.modificationCount;
ADDRGP4 level+352
ADDRGP4 g_warmup+4
INDIRI4
ASGNI4
line 346
;346:}
LABELV $163
endproc G_RegisterCvars 20 16
export G_UpdateCvars
proc G_UpdateCvars 28 12
line 353
;347:
;348:/*
;349:=================
;350:G_UpdateCvars
;351:=================
;352:*/
;353:void G_UpdateCvars( void ) {
line 356
;354:	int			i;
;355:	cvarTable_t	*cv;
;356:	qboolean remapped = qfalse;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 358
;357:
;358:	for ( i = 0, cv = gameCvarTable ; i < gameCvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 gameCvarTable
ASGNP4
ADDRGP4 $187
JUMPV
LABELV $184
line 359
;359:		if ( cv->vmCvar ) {
ADDRLP4 0
INDIRP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $188
line 360
;360:			trap_Cvar_Update( cv->vmCvar );
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 362
;361:
;362:			if ( cv->modificationCount != cv->vmCvar->modificationCount ) {
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
EQI4 $190
line 363
;363:				cv->modificationCount = cv->vmCvar->modificationCount;
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 365
;364:
;365:				if ( cv->trackChange ) {
ADDRLP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 0
EQI4 $192
line 366
;366:					trap_SendServerCommand( -1, va("print \"Server: %s changed to %s\n\"", 
ADDRGP4 $194
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 368
;367:						cv->cvarName, cv->vmCvar->string ) );
;368:				}
LABELV $192
line 370
;369:
;370:				if (cv->teamShader) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI4
CNSTI4 0
EQI4 $195
line 371
;371:					remapped = qtrue;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 372
;372:				}
LABELV $195
line 373
;373:			}
LABELV $190
line 374
;374:		}
LABELV $188
line 375
;375:	}
LABELV $185
line 358
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
ASGNP4
LABELV $187
ADDRLP4 4
INDIRI4
ADDRGP4 gameCvarTableSize
INDIRI4
LTI4 $184
line 377
;376:
;377:	if (remapped) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $197
line 378
;378:		G_RemapTeamShaders();
ADDRGP4 G_RemapTeamShaders
CALLV
pop
line 379
;379:	}
LABELV $197
line 380
;380:}
LABELV $183
endproc G_UpdateCvars 28 12
export G_InitGame
proc G_InitGame 1032 20
line 388
;381:
;382:/*
;383:============
;384:G_InitGame
;385:
;386:============
;387:*/
;388:void G_InitGame( int levelTime, int randomSeed, int restart ) {
line 391
;389:	int					i;
;390:
;391:	G_Printf ("------- Game Initialization -------\n");
ADDRGP4 $200
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 392
;392:	G_Printf ("gamename: %s\n", GAMEVERSION);
ADDRGP4 $201
ARGP4
ADDRGP4 $56
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 393
;393:	G_Printf ("gamedate: %s\n", __DATE__);
ADDRGP4 $202
ARGP4
ADDRGP4 $58
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 395
;394:
;395:	srand( randomSeed );
ADDRFP4 4
INDIRI4
CVIU4 4
ARGU4
ADDRGP4 srand
CALLV
pop
line 397
;396:
;397:	G_RegisterCvars();
ADDRGP4 G_RegisterCvars
CALLV
pop
line 399
;398:
;399:	G_ProcessIPBans();
ADDRGP4 G_ProcessIPBans
CALLV
pop
line 401
;400:
;401:	G_InitMemory();
ADDRGP4 G_InitMemory
CALLV
pop
line 404
;402:
;403:	// set some level globals
;404:	memset( &level, 0, sizeof( level ) );
ADDRGP4 level
ARGP4
CNSTI4 0
ARGI4
CNSTI4 9212
ARGI4
ADDRGP4 memset
CALLP4
pop
line 405
;405:	level.time = levelTime;
ADDRGP4 level+32
ADDRFP4 0
INDIRI4
ASGNI4
line 406
;406:	level.startTime = levelTime;
ADDRGP4 level+40
ADDRFP4 0
INDIRI4
ASGNI4
line 408
;407:
;408:	level.snd_fry = G_SoundIndex("sound/player/fry.wav");	// FIXME standing in lava / slime
ADDRGP4 $206
ARGP4
ADDRLP4 4
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRGP4 level+348
ADDRLP4 4
INDIRI4
ASGNI4
line 410
;409:
;410:	if ( g_gametype.integer != GT_SINGLE_PLAYER && g_log.string[0] ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $207
ADDRGP4 g_log+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $207
line 411
;411:		if ( g_logSync.integer ) {
ADDRGP4 g_logSync+12
INDIRI4
CNSTI4 0
EQI4 $211
line 412
;412:			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND_SYNC );
ADDRGP4 g_log+16
ARGP4
ADDRGP4 level+20
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 413
;413:		} else {
ADDRGP4 $212
JUMPV
LABELV $211
line 414
;414:			trap_FS_FOpenFile( g_log.string, &level.logFile, FS_APPEND );
ADDRGP4 g_log+16
ARGP4
ADDRGP4 level+20
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 415
;415:		}
LABELV $212
line 416
;416:		if ( !level.logFile ) {
ADDRGP4 level+20
INDIRI4
CNSTI4 0
NEI4 $218
line 417
;417:			G_Printf( "WARNING: Couldn't open logfile: %s\n", g_log.string );
ADDRGP4 $221
ARGP4
ADDRGP4 g_log+16
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 418
;418:		} else {
ADDRGP4 $208
JUMPV
LABELV $218
line 421
;419:			char	serverinfo[MAX_INFO_STRING];
;420:
;421:			trap_GetServerinfo( serverinfo, sizeof( serverinfo ) );
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetServerinfo
CALLV
pop
line 423
;422:
;423:			G_LogPrintf("------------------------------------------------------------\n" );
ADDRGP4 $223
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 424
;424:			G_LogPrintf("InitGame: %s\n", serverinfo );
ADDRGP4 $224
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 425
;425:		}
line 426
;426:	} else {
ADDRGP4 $208
JUMPV
LABELV $207
line 427
;427:		G_Printf( "Not logging to disk.\n" );
ADDRGP4 $225
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 428
;428:	}
LABELV $208
line 430
;429:
;430:	G_InitWorldSession();
ADDRGP4 G_InitWorldSession
CALLV
pop
line 433
;431:
;432:	// initialize all entities for this game
;433:	memset( g_entities, 0, MAX_GENTITIES * sizeof(g_entities[0]) );
ADDRGP4 g_entities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 827392
ARGI4
ADDRGP4 memset
CALLP4
pop
line 434
;434:	level.gentities = g_entities;
ADDRGP4 level+4
ADDRGP4 g_entities
ASGNP4
line 437
;435:
;436:	// initialize all clients for this game
;437:	level.maxclients = g_maxclients.integer;
ADDRGP4 level+24
ADDRGP4 g_maxclients+12
INDIRI4
ASGNI4
line 438
;438:	memset( g_clients, 0, MAX_CLIENTS * sizeof(g_clients[0]) );
ADDRGP4 g_clients
ARGP4
CNSTI4 0
ARGI4
CNSTI4 49664
ARGI4
ADDRGP4 memset
CALLP4
pop
line 439
;439:	level.clients = g_clients;
ADDRGP4 level
ADDRGP4 g_clients
ASGNP4
line 442
;440:
;441:	// set client fields on player ents
;442:	for ( i=0 ; i<level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $232
JUMPV
LABELV $229
line 443
;443:		g_entities[i].client = level.clients + i;
CNSTI4 808
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+516
ADDP4
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 444
;444:	}
LABELV $230
line 442
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $232
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $229
line 449
;445:
;446:	// always leave room for the max number of clients,
;447:	// even if they aren't all used, so numbers inside that
;448:	// range are NEVER anything but clients
;449:	level.num_entities = MAX_CLIENTS;
ADDRGP4 level+12
CNSTI4 64
ASGNI4
line 452
;450:
;451:	// let the server system know where the entites are
;452:	trap_LocateGameData( level.gentities, level.num_entities, sizeof( gentity_t ), 
ADDRGP4 level+4
INDIRP4
ARGP4
ADDRGP4 level+12
INDIRI4
ARGI4
CNSTI4 808
ARGI4
ADDRGP4 level
INDIRP4
ARGP4
CNSTI4 776
ARGI4
ADDRGP4 trap_LocateGameData
CALLV
pop
line 456
;453:		&level.clients[0].ps, sizeof( level.clients[0] ) );
;454:
;455:	// reserve some spots for dead player bodies
;456:	InitBodyQue();
ADDRGP4 InitBodyQue
CALLV
pop
line 458
;457:
;458:	ClearRegisteredItems();
ADDRGP4 ClearRegisteredItems
CALLV
pop
line 461
;459:
;460:	// parse the key/value pairs and spawn gentities
;461:	G_SpawnEntitiesFromString();
ADDRGP4 G_SpawnEntitiesFromString
CALLV
pop
line 464
;462:
;463:	// general initialization
;464:	G_FindTeams();
ADDRGP4 G_FindTeams
CALLV
pop
line 467
;465:
;466:	// make sure we have flags for CTF, etc
;467:	if( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $238
line 468
;468:		G_CheckTeamItems();
ADDRGP4 G_CheckTeamItems
CALLV
pop
line 469
;469:	}
LABELV $238
line 471
;470:
;471:	SaveRegisteredItems();
ADDRGP4 SaveRegisteredItems
CALLV
pop
line 473
;472:
;473:	G_Printf ("-----------------------------------\n");
ADDRGP4 $241
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 475
;474:
;475:	if( g_gametype.integer == GT_SINGLE_PLAYER || trap_Cvar_VariableIntegerValue( "com_buildScript" ) ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $246
ADDRGP4 $245
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $242
LABELV $246
line 476
;476:		G_ModelIndex( SP_PODIUM_MODEL );
ADDRGP4 $247
ARGP4
ADDRGP4 G_ModelIndex
CALLI4
pop
line 477
;477:		G_SoundIndex( "sound/player/gurp1.wav" );
ADDRGP4 $248
ARGP4
ADDRGP4 G_SoundIndex
CALLI4
pop
line 478
;478:		G_SoundIndex( "sound/player/gurp2.wav" );
ADDRGP4 $249
ARGP4
ADDRGP4 G_SoundIndex
CALLI4
pop
line 479
;479:	}
LABELV $242
line 481
;480:
;481:	if ( trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $252
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $250
line 482
;482:		BotAISetup( restart );
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotAISetup
CALLI4
pop
line 483
;483:		BotAILoadMap( restart );
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 BotAILoadMap
CALLI4
pop
line 484
;484:		G_InitBots( restart );
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 G_InitBots
CALLV
pop
line 485
;485:	}
LABELV $250
line 487
;486:
;487:	G_RemapTeamShaders();
ADDRGP4 G_RemapTeamShaders
CALLV
pop
line 489
;488:
;489:}
LABELV $199
endproc G_InitGame 1032 20
export G_ShutdownGame
proc G_ShutdownGame 4 4
line 498
;490:
;491:
;492:
;493:/*
;494:=================
;495:G_ShutdownGame
;496:=================
;497:*/
;498:void G_ShutdownGame( int restart ) {
line 499
;499:	G_Printf ("==== ShutdownGame ====\n");
ADDRGP4 $254
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 501
;500:
;501:	if ( level.logFile ) {
ADDRGP4 level+20
INDIRI4
CNSTI4 0
EQI4 $255
line 502
;502:		G_LogPrintf("ShutdownGame:\n" );
ADDRGP4 $258
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 503
;503:		G_LogPrintf("------------------------------------------------------------\n" );
ADDRGP4 $223
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 504
;504:		trap_FS_FCloseFile( level.logFile );
ADDRGP4 level+20
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 505
;505:	}
LABELV $255
line 508
;506:
;507:	// write all the client session data so we can get it back
;508:	G_WriteSessionData();
ADDRGP4 G_WriteSessionData
CALLV
pop
line 510
;509:
;510:	if ( trap_Cvar_VariableIntegerValue( "bot_enable" ) ) {
ADDRGP4 $252
ARGP4
ADDRLP4 0
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $260
line 511
;511:		BotAIShutdown( restart );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAIShutdown
CALLI4
pop
line 512
;512:	}
LABELV $260
line 513
;513:}
LABELV $253
endproc G_ShutdownGame 4 4
export Com_Error
proc Com_Error 1028 12
line 522
;514:
;515:
;516:
;517://===================================================================
;518:
;519:#ifndef GAME_HARD_LINKED
;520:// this is only here so the functions in q_shared.c and bg_*.c can link
;521:
;522:void QDECL Com_Error ( int level, const char *error, ... ) {
line 526
;523:	va_list		argptr;
;524:	char		text[1024];
;525:
;526:	va_start (argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 527
;527:	vsprintf (text, error, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 528
;528:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 530
;529:
;530:	G_Error( "%s", text);
ADDRGP4 $264
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 531
;531:}
LABELV $262
endproc Com_Error 1028 12
export Com_Printf
proc Com_Printf 1028 12
line 533
;532:
;533:void QDECL Com_Printf( const char *msg, ... ) {
line 537
;534:	va_list		argptr;
;535:	char		text[1024];
;536:
;537:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 538
;538:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 539
;539:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 541
;540:
;541:	G_Printf ("%s", text);
ADDRGP4 $264
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 542
;542:}
LABELV $265
endproc Com_Printf 1028 12
export AddTournamentPlayer
proc AddTournamentPlayer 24 8
line 562
;543:
;544:#endif
;545:
;546:/*
;547:========================================================================
;548:
;549:PLAYER COUNTING / SCORE SORTING
;550:
;551:========================================================================
;552:*/
;553:
;554:/*
;555:=============
;556:AddTournamentPlayer
;557:
;558:If there are less than two tournament players, put a
;559:spectator in the game and restart
;560:=============
;561:*/
;562:void AddTournamentPlayer( void ) {
line 567
;563:	int			i;
;564:	gclient_t	*client;
;565:	gclient_t	*nextInLine;
;566:
;567:	if ( level.numPlayingClients >= 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
LTI4 $268
line 568
;568:		return;
ADDRGP4 $267
JUMPV
LABELV $268
line 572
;569:	}
;570:
;571:	// never change during intermission
;572:	if ( level.intermissiontime ) {
ADDRGP4 level+9128
INDIRI4
CNSTI4 0
EQI4 $271
line 573
;573:		return;
ADDRGP4 $267
JUMPV
LABELV $271
line 576
;574:	}
;575:
;576:	nextInLine = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 578
;577:
;578:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $277
JUMPV
LABELV $274
line 579
;579:		client = &level.clients[i];
ADDRLP4 0
CNSTI4 776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 580
;580:		if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $279
line 581
;581:			continue;
ADDRGP4 $275
JUMPV
LABELV $279
line 583
;582:		}
;583:		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
EQI4 $281
line 584
;584:			continue;
ADDRGP4 $275
JUMPV
LABELV $281
line 587
;585:		}
;586:		// never select the dedicated follow or scoreboard clients
;587:		if ( client->sess.spectatorState == SPECTATOR_SCOREBOARD || 
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $285
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
CNSTI4 0
GEI4 $283
LABELV $285
line 588
;588:			client->sess.spectatorClient < 0  ) {
line 589
;589:			continue;
ADDRGP4 $275
JUMPV
LABELV $283
line 592
;590:		}
;591:
;592:		if ( !nextInLine || client->sess.spectatorTime < nextInLine->sess.spectatorTime ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $288
ADDRLP4 20
CNSTI4 620
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
ADDRLP4 8
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
GEI4 $286
LABELV $288
line 593
;593:			nextInLine = client;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
line 594
;594:		}
LABELV $286
line 595
;595:	}
LABELV $275
line 578
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $277
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $274
line 597
;596:
;597:	if ( !nextInLine ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $289
line 598
;598:		return;
ADDRGP4 $267
JUMPV
LABELV $289
line 601
;599:	}
;600:
;601:	level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 604
;602:
;603:	// set them to free-for-all team
;604:	SetTeam( &g_entities[ nextInLine - level.clients ], "f" );
CNSTI4 808
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRGP4 level
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 776
DIVI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 $292
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 605
;605:}
LABELV $267
endproc AddTournamentPlayer 24 8
export RemoveTournamentLoser
proc RemoveTournamentLoser 4 8
line 614
;606:
;607:/*
;608:=======================
;609:RemoveTournamentLoser
;610:
;611:Make the loser a spectator at the back of the line
;612:=======================
;613:*/
;614:void RemoveTournamentLoser( void ) {
line 617
;615:	int			clientNum;
;616:
;617:	if ( level.numPlayingClients != 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
EQI4 $294
line 618
;618:		return;
ADDRGP4 $293
JUMPV
LABELV $294
line 621
;619:	}
;620:
;621:	clientNum = level.sortedClients[1];
ADDRLP4 0
ADDRGP4 level+84+4
INDIRI4
ASGNI4
line 623
;622:
;623:	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $299
line 624
;624:		return;
ADDRGP4 $293
JUMPV
LABELV $299
line 628
;625:	}
;626:
;627:	// make them a spectator
;628:	SetTeam( &g_entities[ clientNum ], "s" );
CNSTI4 808
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 $301
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 629
;629:}
LABELV $293
endproc RemoveTournamentLoser 4 8
export RemoveTournamentWinner
proc RemoveTournamentWinner 4 8
line 636
;630:
;631:/*
;632:=======================
;633:RemoveTournamentWinner
;634:=======================
;635:*/
;636:void RemoveTournamentWinner( void ) {
line 639
;637:	int			clientNum;
;638:
;639:	if ( level.numPlayingClients != 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
EQI4 $303
line 640
;640:		return;
ADDRGP4 $302
JUMPV
LABELV $303
line 643
;641:	}
;642:
;643:	clientNum = level.sortedClients[0];
ADDRLP4 0
ADDRGP4 level+84
INDIRI4
ASGNI4
line 645
;644:
;645:	if ( level.clients[ clientNum ].pers.connected != CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $307
line 646
;646:		return;
ADDRGP4 $302
JUMPV
LABELV $307
line 650
;647:	}
;648:
;649:	// make them a spectator
;650:	SetTeam( &g_entities[ clientNum ], "s" );
CNSTI4 808
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 $301
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 651
;651:}
LABELV $302
endproc RemoveTournamentWinner 4 8
export AdjustTournamentScores
proc AdjustTournamentScores 8 4
line 658
;652:
;653:/*
;654:=======================
;655:AdjustTournamentScores
;656:=======================
;657:*/
;658:void AdjustTournamentScores( void ) {
line 661
;659:	int			clientNum;
;660:
;661:	clientNum = level.sortedClients[0];
ADDRLP4 0
ADDRGP4 level+84
INDIRI4
ASGNI4
line 662
;662:	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $311
line 663
;663:		level.clients[ clientNum ].sess.wins++;
ADDRLP4 4
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 632
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 664
;664:		ClientUserinfoChanged( clientNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 665
;665:	}
LABELV $311
line 667
;666:
;667:	clientNum = level.sortedClients[1];
ADDRLP4 0
ADDRGP4 level+84+4
INDIRI4
ASGNI4
line 668
;668:	if ( level.clients[ clientNum ].pers.connected == CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $315
line 669
;669:		level.clients[ clientNum ].sess.losses++;
ADDRLP4 4
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 636
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 670
;670:		ClientUserinfoChanged( clientNum );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 671
;671:	}
LABELV $315
line 673
;672:
;673:}
LABELV $309
endproc AdjustTournamentScores 8 4
export SortRanks
proc SortRanks 32 0
line 681
;674:
;675:/*
;676:=============
;677:SortRanks
;678:
;679:=============
;680:*/
;681:int QDECL SortRanks( const void *a, const void *b ) {
line 684
;682:	gclient_t	*ca, *cb;
;683:
;684:	ca = &level.clients[*(int *)a];
ADDRLP4 0
CNSTI4 776
ADDRFP4 0
INDIRP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 685
;685:	cb = &level.clients[*(int *)b];
ADDRLP4 4
CNSTI4 776
ADDRFP4 4
INDIRP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 688
;686:
;687:	// sort special clients last
;688:	if ( ca->sess.spectatorState == SPECTATOR_SCOREBOARD || ca->sess.spectatorClient < 0 ) {
ADDRLP4 0
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $320
ADDRLP4 0
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
CNSTI4 0
GEI4 $318
LABELV $320
line 689
;689:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $317
JUMPV
LABELV $318
line 691
;690:	}
;691:	if ( cb->sess.spectatorState == SPECTATOR_SCOREBOARD || cb->sess.spectatorClient < 0  ) {
ADDRLP4 4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 3
EQI4 $323
ADDRLP4 4
INDIRP4
CNSTI4 628
ADDP4
INDIRI4
CNSTI4 0
GEI4 $321
LABELV $323
line 692
;692:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $317
JUMPV
LABELV $321
line 696
;693:	}
;694:
;695:	// then connecting clients
;696:	if ( ca->pers.connected == CON_CONNECTING ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $324
line 697
;697:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $317
JUMPV
LABELV $324
line 699
;698:	}
;699:	if ( cb->pers.connected == CON_CONNECTING ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $326
line 700
;700:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $317
JUMPV
LABELV $326
line 705
;701:	}
;702:
;703:
;704:	// then spectators
;705:	if ( ca->sess.sessionTeam == TEAM_SPECTATOR && cb->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 16
CNSTI4 616
ASGNI4
ADDRLP4 20
CNSTI4 3
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $328
ADDRLP4 4
INDIRP4
ADDRLP4 16
INDIRI4
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $328
line 706
;706:		if ( ca->sess.spectatorTime < cb->sess.spectatorTime ) {
ADDRLP4 24
CNSTI4 620
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
GEI4 $330
line 707
;707:			return -1;
CNSTI4 -1
RETI4
ADDRGP4 $317
JUMPV
LABELV $330
line 709
;708:		}
;709:		if ( ca->sess.spectatorTime > cb->sess.spectatorTime ) {
ADDRLP4 28
CNSTI4 620
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
LEI4 $332
line 710
;710:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $317
JUMPV
LABELV $332
line 712
;711:		}
;712:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $317
JUMPV
LABELV $328
line 714
;713:	}
;714:	if ( ca->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $334
line 715
;715:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $317
JUMPV
LABELV $334
line 717
;716:	}
;717:	if ( cb->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 4
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $336
line 718
;718:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $317
JUMPV
LABELV $336
line 722
;719:	}
;720:
;721:	// then sort by score
;722:	if ( ca->ps.persistant[PERS_SCORE]
ADDRLP4 24
CNSTI4 248
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
LEI4 $338
line 723
;723:		> cb->ps.persistant[PERS_SCORE] ) {
line 724
;724:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $317
JUMPV
LABELV $338
line 726
;725:	}
;726:	if ( ca->ps.persistant[PERS_SCORE]
ADDRLP4 28
CNSTI4 248
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRI4
GEI4 $340
line 727
;727:		< cb->ps.persistant[PERS_SCORE] ) {
line 728
;728:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $317
JUMPV
LABELV $340
line 730
;729:	}
;730:	return 0;
CNSTI4 0
RETI4
LABELV $317
endproc SortRanks 32 0
export CalculateRanks
proc CalculateRanks 44 16
line 742
;731:}
;732:
;733:/*
;734:============
;735:CalculateRanks
;736:
;737:Recalculates the score ranks of all players
;738:This will be called on every client connect, begin, disconnect, death,
;739:and team change.
;740:============
;741:*/
;742:void CalculateRanks( void ) {
line 749
;743:	int		i;
;744:	int		rank;
;745:	int		score;
;746:	int		newScore;
;747:	gclient_t	*cl;
;748:
;749:	level.follow1 = -1;
ADDRGP4 level+340
CNSTI4 -1
ASGNI4
line 750
;750:	level.follow2 = -1;
ADDRGP4 level+344
CNSTI4 -1
ASGNI4
line 751
;751:	level.numConnectedClients = 0;
ADDRGP4 level+72
CNSTI4 0
ASGNI4
line 752
;752:	level.numNonSpectatorClients = 0;
ADDRGP4 level+76
CNSTI4 0
ASGNI4
line 753
;753:	level.numPlayingClients = 0;
ADDRGP4 level+80
CNSTI4 0
ASGNI4
line 754
;754:	level.numVotingClients = 0;		// don't count bots
ADDRGP4 level+2420
CNSTI4 0
ASGNI4
line 755
;755:	for ( i = 0; i < TEAM_NUM_TEAMS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $349
line 756
;756:		level.numteamVotingClients[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4496
ADDP4
CNSTI4 0
ASGNI4
line 757
;757:	}
LABELV $350
line 755
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $349
line 758
;758:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $357
JUMPV
LABELV $354
line 759
;759:		if ( level.clients[i].pers.connected != CON_DISCONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $359
line 760
;760:			level.sortedClients[level.numConnectedClients] = i;
ADDRGP4 level+72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 761
;761:			level.numConnectedClients++;
ADDRLP4 20
ADDRGP4 level+72
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 763
;762:
;763:			if ( level.clients[i].sess.sessionTeam != TEAM_SPECTATOR ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
EQI4 $364
line 764
;764:				level.numNonSpectatorClients++;
ADDRLP4 24
ADDRGP4 level+76
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 767
;765:			
;766:				// decide if this should be auto-followed
;767:				if ( level.clients[i].pers.connected == CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $367
line 768
;768:					level.numPlayingClients++;
ADDRLP4 28
ADDRGP4 level+80
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 769
;769:					if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
CNSTI4 808
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $370
line 770
;770:						level.numVotingClients++;
ADDRLP4 32
ADDRGP4 level+2420
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 771
;771:						if ( level.clients[i].sess.sessionTeam == TEAM_RED )
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 1
NEI4 $375
line 772
;772:							level.numteamVotingClients[0]++;
ADDRLP4 36
ADDRGP4 level+4496
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $376
JUMPV
LABELV $375
line 773
;773:						else if ( level.clients[i].sess.sessionTeam == TEAM_BLUE )
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 2
NEI4 $378
line 774
;774:							level.numteamVotingClients[1]++;
ADDRLP4 40
ADDRGP4 level+4496+4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $378
LABELV $376
line 775
;775:					}
LABELV $370
line 776
;776:					if ( level.follow1 == -1 ) {
ADDRGP4 level+340
INDIRI4
CNSTI4 -1
NEI4 $382
line 777
;777:						level.follow1 = i;
ADDRGP4 level+340
ADDRLP4 0
INDIRI4
ASGNI4
line 778
;778:					} else if ( level.follow2 == -1 ) {
ADDRGP4 $383
JUMPV
LABELV $382
ADDRGP4 level+344
INDIRI4
CNSTI4 -1
NEI4 $386
line 779
;779:						level.follow2 = i;
ADDRGP4 level+344
ADDRLP4 0
INDIRI4
ASGNI4
line 780
;780:					}
LABELV $386
LABELV $383
line 781
;781:				}
LABELV $367
line 782
;782:			}
LABELV $364
line 783
;783:		}
LABELV $359
line 784
;784:	}
LABELV $355
line 758
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $357
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $354
line 786
;785:
;786:	qsort( level.sortedClients, level.numConnectedClients, 
ADDRGP4 level+84
ARGP4
ADDRGP4 level+72
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 SortRanks
ARGP4
ADDRGP4 qsort
CALLV
pop
line 790
;787:		sizeof(level.sortedClients[0]), SortRanks );
;788:
;789:	// set the rank value for all clients that are connected and not spectators
;790:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $393
line 792
;791:		// in team games, rank is just the order of the teams, 0=red, 1=blue, 2=tied
;792:		for ( i = 0;  i < level.numConnectedClients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $399
JUMPV
LABELV $396
line 793
;793:			cl = &level.clients[ level.sortedClients[i] ];
ADDRLP4 4
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 794
;794:			if ( level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE] ) {
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 level+44+8
INDIRI4
NEI4 $402
line 795
;795:				cl->ps.persistant[PERS_RANK] = 2;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
CNSTI4 2
ASGNI4
line 796
;796:			} else if ( level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE] ) {
ADDRGP4 $403
JUMPV
LABELV $402
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 level+44+8
INDIRI4
LEI4 $408
line 797
;797:				cl->ps.persistant[PERS_RANK] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
CNSTI4 0
ASGNI4
line 798
;798:			} else {
ADDRGP4 $409
JUMPV
LABELV $408
line 799
;799:				cl->ps.persistant[PERS_RANK] = 1;
ADDRLP4 4
INDIRP4
CNSTI4 256
ADDP4
CNSTI4 1
ASGNI4
line 800
;800:			}
LABELV $409
LABELV $403
line 801
;801:		}
LABELV $397
line 792
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $399
ADDRLP4 0
INDIRI4
ADDRGP4 level+72
INDIRI4
LTI4 $396
line 802
;802:	} else {	
ADDRGP4 $394
JUMPV
LABELV $393
line 803
;803:		rank = -1;
ADDRLP4 12
CNSTI4 -1
ASGNI4
line 804
;804:		score = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 805
;805:		for ( i = 0;  i < level.numPlayingClients; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $417
JUMPV
LABELV $414
line 806
;806:			cl = &level.clients[ level.sortedClients[i] ];
ADDRLP4 4
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 807
;807:			newScore = cl->ps.persistant[PERS_SCORE];
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 808
;808:			if ( i == 0 || newScore != score ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $422
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $420
LABELV $422
line 809
;809:				rank = i;
ADDRLP4 12
ADDRLP4 0
INDIRI4
ASGNI4
line 811
;810:				// assume we aren't tied until the next client is checked
;811:				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank;
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 812
;812:			} else {
ADDRGP4 $421
JUMPV
LABELV $420
line 814
;813:				// we are tied with the previous client
;814:				level.clients[ level.sortedClients[i-1] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84-4
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 815
;815:				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 816
;816:			}
LABELV $421
line 817
;817:			score = newScore;
ADDRLP4 16
ADDRLP4 8
INDIRI4
ASGNI4
line 818
;818:			if ( g_gametype.integer == GT_SINGLE_PLAYER && level.numPlayingClients == 1 ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $427
ADDRGP4 level+80
INDIRI4
CNSTI4 1
NEI4 $427
line 819
;819:				level.clients[ level.sortedClients[i] ].ps.persistant[PERS_RANK] = rank | RANK_TIED_FLAG;
CNSTI4 776
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 256
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 16384
BORI4
ASGNI4
line 820
;820:			}
LABELV $427
line 821
;821:		}
LABELV $415
line 805
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $417
ADDRLP4 0
INDIRI4
ADDRGP4 level+80
INDIRI4
LTI4 $414
line 822
;822:	}
LABELV $394
line 825
;823:
;824:	// set the CS_SCORES1/2 configstrings, which will be visible to everyone
;825:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $432
line 826
;826:		trap_SetConfigstring( CS_SCORES1, va("%i", level.teamScores[TEAM_RED] ) );
ADDRGP4 $435
ARGP4
ADDRGP4 level+44+4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 827
;827:		trap_SetConfigstring( CS_SCORES2, va("%i", level.teamScores[TEAM_BLUE] ) );
ADDRGP4 $435
ARGP4
ADDRGP4 level+44+8
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 828
;828:	} else {
ADDRGP4 $433
JUMPV
LABELV $432
line 829
;829:		if ( level.numConnectedClients == 0 ) {
ADDRGP4 level+72
INDIRI4
CNSTI4 0
NEI4 $440
line 830
;830:			trap_SetConfigstring( CS_SCORES1, va("%i", SCORE_NOT_PRESENT) );
ADDRGP4 $435
ARGP4
CNSTI4 -9999
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 831
;831:			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
ADDRGP4 $435
ARGP4
CNSTI4 -9999
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 832
;832:		} else if ( level.numConnectedClients == 1 ) {
ADDRGP4 $441
JUMPV
LABELV $440
ADDRGP4 level+72
INDIRI4
CNSTI4 1
NEI4 $443
line 833
;833:			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
ADDRGP4 $435
ARGP4
CNSTI4 776
ADDRGP4 level+84
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 834
;834:			trap_SetConfigstring( CS_SCORES2, va("%i", SCORE_NOT_PRESENT) );
ADDRGP4 $435
ARGP4
CNSTI4 -9999
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 835
;835:		} else {
ADDRGP4 $444
JUMPV
LABELV $443
line 836
;836:			trap_SetConfigstring( CS_SCORES1, va("%i", level.clients[ level.sortedClients[0] ].ps.persistant[PERS_SCORE] ) );
ADDRGP4 $435
ARGP4
CNSTI4 776
ADDRGP4 level+84
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 6
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 837
;837:			trap_SetConfigstring( CS_SCORES2, va("%i", level.clients[ level.sortedClients[1] ].ps.persistant[PERS_SCORE] ) );
ADDRGP4 $435
ARGP4
CNSTI4 776
ADDRGP4 level+84+4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 7
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 838
;838:		}
LABELV $444
LABELV $441
line 839
;839:	}
LABELV $433
line 842
;840:
;841:	// see if it is time to end the level
;842:	CheckExitRules();
ADDRGP4 CheckExitRules
CALLV
pop
line 845
;843:
;844:	// if we are at the intermission, send the new info to everyone
;845:	if ( level.intermissiontime ) {
ADDRGP4 level+9128
INDIRI4
CNSTI4 0
EQI4 $450
line 846
;846:		SendScoreboardMessageToAllClients();
ADDRGP4 SendScoreboardMessageToAllClients
CALLV
pop
line 847
;847:	}
LABELV $450
line 848
;848:}
LABELV $342
endproc CalculateRanks 44 16
export SendScoreboardMessageToAllClients
proc SendScoreboardMessageToAllClients 4 4
line 867
;849:
;850:
;851:/*
;852:========================================================================
;853:
;854:MAP CHANGING
;855:
;856:========================================================================
;857:*/
;858:
;859:/*
;860:========================
;861:SendScoreboardMessageToAllClients
;862:
;863:Do this at BeginIntermission time and whenever ranks are recalculated
;864:due to enters/exits/forced team changes
;865:========================
;866:*/
;867:void SendScoreboardMessageToAllClients( void ) {
line 870
;868:	int		i;
;869:
;870:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $457
JUMPV
LABELV $454
line 871
;871:		if ( level.clients[ i ].pers.connected == CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $459
line 872
;872:			DeathmatchScoreboardMessage( g_entities + i );
CNSTI4 808
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 DeathmatchScoreboardMessage
CALLV
pop
line 873
;873:		}
LABELV $459
line 874
;874:	}
LABELV $455
line 870
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $457
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $454
line 875
;875:}
LABELV $453
endproc SendScoreboardMessageToAllClients 4 4
export MoveClientToIntermission
proc MoveClientToIntermission 0 12
line 885
;876:
;877:/*
;878:========================
;879:MoveClientToIntermission
;880:
;881:When the intermission starts, this will be called for all players.
;882:If a new client connects, this will be called after the spawn function.
;883:========================
;884:*/
;885:void MoveClientToIntermission( gentity_t *ent ) {
line 887
;886:	// take out of follow mode if needed
;887:	if ( ent->client->sess.spectatorState == SPECTATOR_FOLLOW ) {
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 624
ADDP4
INDIRI4
CNSTI4 2
NEI4 $462
line 888
;888:		StopFollowing( ent );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 StopFollowing
CALLV
pop
line 889
;889:	}
LABELV $462
line 893
;890:
;891:
;892:	// move to the spot
;893:	VectorCopy( level.intermission_origin, ent->s.origin );
ADDRFP4 0
INDIRP4
CNSTI4 92
ADDP4
ADDRGP4 level+9144
INDIRB
ASGNB 12
line 894
;894:	VectorCopy( level.intermission_origin, ent->client->ps.origin );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ADDRGP4 level+9144
INDIRB
ASGNB 12
line 895
;895:	VectorCopy (level.intermission_angle, ent->client->ps.viewangles);
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRGP4 level+9156
INDIRB
ASGNB 12
line 896
;896:	ent->client->ps.pm_type = PM_INTERMISSION;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 5
ASGNI4
line 899
;897:
;898:	// clean up powerup info
;899:	memset( ent->client->ps.powerups, 0, sizeof(ent->client->ps.powerups) );
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 64
ARGI4
ADDRGP4 memset
CALLP4
pop
line 901
;900:
;901:	ent->client->ps.eFlags = 0;
ADDRFP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 104
ADDP4
CNSTI4 0
ASGNI4
line 902
;902:	ent->s.eFlags = 0;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
CNSTI4 0
ASGNI4
line 903
;903:	ent->s.eType = ET_GENERAL;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ASGNI4
line 904
;904:	ent->s.modelindex = 0;
ADDRFP4 0
INDIRP4
CNSTI4 160
ADDP4
CNSTI4 0
ASGNI4
line 905
;905:	ent->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 906
;906:	ent->s.event = 0;
ADDRFP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 907
;907:	ent->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 460
ADDP4
CNSTI4 0
ASGNI4
line 908
;908:}
LABELV $461
endproc MoveClientToIntermission 0 12
export FindIntermissionPoint
proc FindIntermissionPoint 32 12
line 917
;909:
;910:/*
;911:==================
;912:FindIntermissionPoint
;913:
;914:This is also used for spectator spawns
;915:==================
;916:*/
;917:void FindIntermissionPoint( void ) {
line 922
;918:	gentity_t	*ent, *target;
;919:	vec3_t		dir;
;920:
;921:	// find the intermission spot
;922:	ent = G_Find (NULL, FOFS(classname), "info_player_intermission");
CNSTP4 0
ARGP4
CNSTI4 524
ARGI4
ADDRGP4 $468
ARGP4
ADDRLP4 20
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 923
;923:	if ( !ent ) {	// the map creator forgot to put in an intermission point...
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $469
line 924
;924:		SelectSpawnPoint ( vec3_origin, level.intermission_origin, level.intermission_angle );
ADDRGP4 vec3_origin
ARGP4
ADDRGP4 level+9144
ARGP4
ADDRGP4 level+9156
ARGP4
ADDRGP4 SelectSpawnPoint
CALLP4
pop
line 925
;925:	} else {
ADDRGP4 $470
JUMPV
LABELV $469
line 926
;926:		VectorCopy (ent->s.origin, level.intermission_origin);
ADDRGP4 level+9144
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 927
;927:		VectorCopy (ent->s.angles, level.intermission_angle);
ADDRGP4 level+9156
ADDRLP4 0
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 929
;928:		// if it has a target, look towards it
;929:		if ( ent->target ) {
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $475
line 930
;930:			target = G_PickTarget( ent->target );
ADDRLP4 0
INDIRP4
CNSTI4 648
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 G_PickTarget
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 931
;931:			if ( target ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $477
line 932
;932:				VectorSubtract( target->s.origin, level.intermission_origin, dir );
ADDRLP4 28
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
ADDRGP4 level+9144
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 28
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
ADDRGP4 level+9144+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 4
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
ADDRGP4 level+9144+8
INDIRF4
SUBF4
ASGNF4
line 933
;933:				vectoangles( dir, level.intermission_angle );
ADDRLP4 8
ARGP4
ADDRGP4 level+9156
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 934
;934:			}
LABELV $477
line 935
;935:		}
LABELV $475
line 936
;936:	}
LABELV $470
line 938
;937:
;938:}
LABELV $467
endproc FindIntermissionPoint 32 12
export BeginIntermission
proc BeginIntermission 8 4
line 945
;939:
;940:/*
;941:==================
;942:BeginIntermission
;943:==================
;944:*/
;945:void BeginIntermission( void ) {
line 949
;946:	int			i;
;947:	gentity_t	*client;
;948:
;949:	if ( level.intermissiontime ) {
ADDRGP4 level+9128
INDIRI4
CNSTI4 0
EQI4 $488
line 950
;950:		return;		// already active
ADDRGP4 $487
JUMPV
LABELV $488
line 954
;951:	}
;952:
;953:	// if in tournement mode, change the wins / losses
;954:	if ( g_gametype.integer == GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $491
line 955
;955:		AdjustTournamentScores();
ADDRGP4 AdjustTournamentScores
CALLV
pop
line 956
;956:	}
LABELV $491
line 958
;957:
;958:	level.intermissiontime = level.time;
ADDRGP4 level+9128
ADDRGP4 level+32
INDIRI4
ASGNI4
line 959
;959:	FindIntermissionPoint();
ADDRGP4 FindIntermissionPoint
CALLV
pop
line 968
;960:
;961:#ifdef MISSIONPACK
;962:	if (g_singlePlayer.integer) {
;963:		trap_Cvar_Set("ui_singlePlayerActive", "0");
;964:		UpdateTournamentInfo();
;965:	}
;966:#else
;967:	// if single player game
;968:	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $496
line 969
;969:		UpdateTournamentInfo();
ADDRGP4 UpdateTournamentInfo
CALLV
pop
line 970
;970:		SpawnModelsOnVictoryPads();
ADDRGP4 SpawnModelsOnVictoryPads
CALLV
pop
line 971
;971:	}
LABELV $496
line 975
;972:#endif
;973:
;974:	// move all clients to the intermission point
;975:	for (i=0 ; i< level.maxclients ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $502
JUMPV
LABELV $499
line 976
;976:		client = g_entities + i;
ADDRLP4 0
CNSTI4 808
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 977
;977:		if (!client->inuse)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $504
line 978
;978:			continue;
ADDRGP4 $500
JUMPV
LABELV $504
line 980
;979:		// respawn if dead
;980:		if (client->health <= 0) {
ADDRLP4 0
INDIRP4
CNSTI4 732
ADDP4
INDIRI4
CNSTI4 0
GTI4 $506
line 981
;981:			respawn(client);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 respawn
CALLV
pop
line 982
;982:		}
LABELV $506
line 983
;983:		MoveClientToIntermission( client );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 MoveClientToIntermission
CALLV
pop
line 984
;984:	}
LABELV $500
line 975
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $502
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $499
line 987
;985:
;986:	// send the current scoring to all clients
;987:	SendScoreboardMessageToAllClients();
ADDRGP4 SendScoreboardMessageToAllClients
CALLV
pop
line 989
;988:
;989:}
LABELV $487
endproc BeginIntermission 8 4
export ExitLevel
proc ExitLevel 8 8
line 1001
;990:
;991:
;992:/*
;993:=============
;994:ExitLevel
;995:
;996:When the intermission has been exited, the server is either killed
;997:or moved to a new level based on the "nextmap" cvar 
;998:
;999:=============
;1000:*/
;1001:void ExitLevel (void) {
line 1006
;1002:	int		i;
;1003:	gclient_t *cl;
;1004:
;1005:	//bot interbreeding
;1006:	BotInterbreedEndMatch();
ADDRGP4 BotInterbreedEndMatch
CALLV
pop
line 1010
;1007:
;1008:	// if we are running a tournement map, kick the loser to spectator status,
;1009:	// which will automatically grab the next spectator and restart
;1010:	if ( g_gametype.integer == GT_TOURNAMENT  ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $509
line 1011
;1011:		if ( !level.restarted ) {
ADDRGP4 level+68
INDIRI4
CNSTI4 0
NEI4 $508
line 1012
;1012:			RemoveTournamentLoser();
ADDRGP4 RemoveTournamentLoser
CALLV
pop
line 1013
;1013:			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
CNSTI4 2
ARGI4
ADDRGP4 $515
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1014
;1014:			level.restarted = qtrue;
ADDRGP4 level+68
CNSTI4 1
ASGNI4
line 1015
;1015:			level.changemap = NULL;
ADDRGP4 level+9132
CNSTP4 0
ASGNP4
line 1016
;1016:			level.intermissiontime = 0;
ADDRGP4 level+9128
CNSTI4 0
ASGNI4
line 1017
;1017:		}
line 1018
;1018:		return;	
ADDRGP4 $508
JUMPV
LABELV $509
line 1022
;1019:	}
;1020:
;1021:
;1022:	trap_SendConsoleCommand( EXEC_APPEND, "vstr nextmap\n" );
CNSTI4 2
ARGI4
ADDRGP4 $519
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1023
;1023:	level.changemap = NULL;
ADDRGP4 level+9132
CNSTP4 0
ASGNP4
line 1024
;1024:	level.intermissiontime = 0;
ADDRGP4 level+9128
CNSTI4 0
ASGNI4
line 1027
;1025:
;1026:	// reset all the scores so we don't enter the intermission again
;1027:	level.teamScores[TEAM_RED] = 0;
ADDRGP4 level+44+4
CNSTI4 0
ASGNI4
line 1028
;1028:	level.teamScores[TEAM_BLUE] = 0;
ADDRGP4 level+44+8
CNSTI4 0
ASGNI4
line 1029
;1029:	for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $529
JUMPV
LABELV $526
line 1030
;1030:		cl = level.clients + i;
ADDRLP4 4
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1031
;1031:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 4
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $531
line 1032
;1032:			continue;
ADDRGP4 $527
JUMPV
LABELV $531
line 1034
;1033:		}
;1034:		cl->ps.persistant[PERS_SCORE] = 0;
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
CNSTI4 0
ASGNI4
line 1035
;1035:	}
LABELV $527
line 1029
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $529
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $526
line 1038
;1036:
;1037:	// we need to do this here before chaning to CON_CONNECTING
;1038:	G_WriteSessionData();
ADDRGP4 G_WriteSessionData
CALLV
pop
line 1042
;1039:
;1040:	// change all client states to connecting, so the early players into the
;1041:	// next level will know the others aren't done reconnecting
;1042:	for (i=0 ; i< g_maxclients.integer ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $536
JUMPV
LABELV $533
line 1043
;1043:		if ( level.clients[i].pers.connected == CON_CONNECTED ) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
NEI4 $538
line 1044
;1044:			level.clients[i].pers.connected = CON_CONNECTING;
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
CNSTI4 1
ASGNI4
line 1045
;1045:		}
LABELV $538
line 1046
;1046:	}
LABELV $534
line 1042
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $536
ADDRLP4 0
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $533
line 1048
;1047:
;1048:}
LABELV $508
endproc ExitLevel 8 8
export G_LogPrintf
proc G_LogPrintf 1044 24
line 1057
;1049:
;1050:/*
;1051:=================
;1052:G_LogPrintf
;1053:
;1054:Print to the logfile with a time stamp if it is open
;1055:=================
;1056:*/
;1057:void QDECL G_LogPrintf( const char *fmt, ... ) {
line 1062
;1058:	va_list		argptr;
;1059:	char		string[1024];
;1060:	int			min, tens, sec;
;1061:
;1062:	sec = level.time / 1000;
ADDRLP4 0
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 1064
;1063:
;1064:	min = sec / 60;
ADDRLP4 1032
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1065
;1065:	sec -= min * 60;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDRLP4 1032
INDIRI4
MULI4
SUBI4
ASGNI4
line 1066
;1066:	tens = sec / 10;
ADDRLP4 1036
ADDRLP4 0
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 1067
;1067:	sec -= tens * 10;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 10
ADDRLP4 1036
INDIRI4
MULI4
SUBI4
ASGNI4
line 1069
;1068:
;1069:	Com_sprintf( string, sizeof(string), "%3i:%i%i ", min, tens, sec );
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $542
ARGP4
ADDRLP4 1032
INDIRI4
ARGI4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1071
;1070:
;1071:	va_start( argptr, fmt );
ADDRLP4 1028
ADDRFP4 0+4
ASGNP4
line 1072
;1072:	vsprintf( string +7 , fmt,argptr );
ADDRLP4 4+7
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 1073
;1073:	va_end( argptr );
ADDRLP4 1028
CNSTP4 0
ASGNP4
line 1075
;1074:
;1075:	if ( g_dedicated.integer ) {
ADDRGP4 g_dedicated+12
INDIRI4
CNSTI4 0
EQI4 $545
line 1076
;1076:		G_Printf( "%s", string + 7 );
ADDRGP4 $264
ARGP4
ADDRLP4 4+7
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1077
;1077:	}
LABELV $545
line 1079
;1078:
;1079:	if ( !level.logFile ) {
ADDRGP4 level+20
INDIRI4
CNSTI4 0
NEI4 $549
line 1080
;1080:		return;
ADDRGP4 $540
JUMPV
LABELV $549
line 1083
;1081:	}
;1082:
;1083:	trap_FS_Write( string, strlen( string ), level.logFile );
ADDRLP4 4
ARGP4
ADDRLP4 1040
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ARGP4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 level+20
INDIRI4
ARGI4
ADDRGP4 trap_FS_Write
CALLV
pop
line 1084
;1084:}
LABELV $540
endproc G_LogPrintf 1044 24
export LogExit
proc LogExit 24 20
line 1093
;1085:
;1086:/*
;1087:================
;1088:LogExit
;1089:
;1090:Append information about this game to the log file
;1091:================
;1092:*/
;1093:void LogExit( const char *string ) {
line 1099
;1094:	int				i, numSorted;
;1095:	gclient_t		*cl;
;1096:#ifdef MISSIONPACK // bk001205
;1097:	qboolean won = qtrue;
;1098:#endif
;1099:	G_LogPrintf( "Exit: %s\n", string );
ADDRGP4 $554
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1101
;1100:
;1101:	level.intermissionQueued = level.time;
ADDRGP4 level+9124
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1105
;1102:
;1103:	// this will keep the clients from playing any voice sounds
;1104:	// that will get cut off when the queued intermission starts
;1105:	trap_SetConfigstring( CS_INTERMISSION, "1" );
CNSTI4 22
ARGI4
ADDRGP4 $83
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1108
;1106:
;1107:	// don't send more than 32 scores (FIXME?)
;1108:	numSorted = level.numConnectedClients;
ADDRLP4 8
ADDRGP4 level+72
INDIRI4
ASGNI4
line 1109
;1109:	if ( numSorted > 32 ) {
ADDRLP4 8
INDIRI4
CNSTI4 32
LEI4 $558
line 1110
;1110:		numSorted = 32;
ADDRLP4 8
CNSTI4 32
ASGNI4
line 1111
;1111:	}
LABELV $558
line 1113
;1112:
;1113:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $560
line 1114
;1114:		G_LogPrintf( "red:%i  blue:%i\n",
ADDRGP4 $563
ARGP4
ADDRGP4 level+44+4
INDIRI4
ARGI4
ADDRGP4 level+44+8
INDIRI4
ARGI4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1116
;1115:			level.teamScores[TEAM_RED], level.teamScores[TEAM_BLUE] );
;1116:	}
LABELV $560
line 1118
;1117:
;1118:	for (i=0 ; i < numSorted ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $571
JUMPV
LABELV $568
line 1121
;1119:		int		ping;
;1120:
;1121:		cl = &level.clients[level.sortedClients[i]];
ADDRLP4 0
CNSTI4 776
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1123
;1122:
;1123:		if ( cl->sess.sessionTeam == TEAM_SPECTATOR ) {
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 3
NEI4 $573
line 1124
;1124:			continue;
ADDRGP4 $569
JUMPV
LABELV $573
line 1126
;1125:		}
;1126:		if ( cl->pers.connected == CON_CONNECTING ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 1
NEI4 $575
line 1127
;1127:			continue;
ADDRGP4 $569
JUMPV
LABELV $575
line 1130
;1128:		}
;1129:
;1130:		ping = cl->ps.ping < 999 ? cl->ps.ping : 999;
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
CNSTI4 999
GEI4 $578
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $579
JUMPV
LABELV $578
ADDRLP4 16
CNSTI4 999
ASGNI4
LABELV $579
ADDRLP4 12
ADDRLP4 16
INDIRI4
ASGNI4
line 1132
;1131:
;1132:		G_LogPrintf( "score: %i  ping: %i  client: %i %s\n", cl->ps.persistant[PERS_SCORE], ping, level.sortedClients[i],	cl->pers.netname );
ADDRGP4 $580
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+84
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1141
;1133:#ifdef MISSIONPACK
;1134:		if (g_singlePlayer.integer && g_gametype.integer == GT_TOURNAMENT) {
;1135:			if (g_entities[cl - level.clients].r.svFlags & SVF_BOT && cl->ps.persistant[PERS_RANK] == 0) {
;1136:				won = qfalse;
;1137:			}
;1138:		}
;1139:#endif
;1140:
;1141:	}
LABELV $569
line 1118
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $571
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $568
line 1153
;1142:
;1143:#ifdef MISSIONPACK
;1144:	if (g_singlePlayer.integer) {
;1145:		if (g_gametype.integer >= GT_CTF) {
;1146:			won = level.teamScores[TEAM_RED] > level.teamScores[TEAM_BLUE];
;1147:		}
;1148:		trap_SendConsoleCommand( EXEC_APPEND, (won) ? "spWin\n" : "spLose\n" );
;1149:	}
;1150:#endif
;1151:
;1152:
;1153:}
LABELV $553
endproc LogExit 24 20
export CheckIntermissionExit
proc CheckIntermissionExit 20 0
line 1166
;1154:
;1155:
;1156:/*
;1157:=================
;1158:CheckIntermissionExit
;1159:
;1160:The level will stay at the intermission for a minimum of 5 seconds
;1161:If all players wish to continue, the level will then exit.
;1162:If one or more players have not acknowledged the continue, the game will
;1163:wait 10 seconds before going on.
;1164:=================
;1165:*/
;1166:void CheckIntermissionExit( void ) {
line 1172
;1167:	int			ready, notReady;
;1168:	int			i;
;1169:	gclient_t	*cl;
;1170:	int			readyMask;
;1171:
;1172:	if ( g_gametype.integer == GT_SINGLE_PLAYER ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $583
line 1173
;1173:		return;
ADDRGP4 $582
JUMPV
LABELV $583
line 1177
;1174:	}
;1175:
;1176:	// see which players are ready
;1177:	ready = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1178
;1178:	notReady = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1179
;1179:	readyMask = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1180
;1180:	for (i=0 ; i< g_maxclients.integer ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $589
JUMPV
LABELV $586
line 1181
;1181:		cl = level.clients + i;
ADDRLP4 0
CNSTI4 776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1182
;1182:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $591
line 1183
;1183:			continue;
ADDRGP4 $587
JUMPV
LABELV $591
line 1185
;1184:		}
;1185:		if ( g_entities[cl->ps.clientNum].r.svFlags & SVF_BOT ) {
CNSTI4 808
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $593
line 1186
;1186:			continue;
ADDRGP4 $587
JUMPV
LABELV $593
line 1189
;1187:		}
;1188:
;1189:		if ( cl->readyToExit ) {
ADDRLP4 0
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
CNSTI4 0
EQI4 $597
line 1190
;1190:			ready++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1191
;1191:			if ( i < 16 ) {
ADDRLP4 4
INDIRI4
CNSTI4 16
GEI4 $598
line 1192
;1192:				readyMask |= 1 << i;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDRLP4 4
INDIRI4
LSHI4
BORI4
ASGNI4
line 1193
;1193:			}
line 1194
;1194:		} else {
ADDRGP4 $598
JUMPV
LABELV $597
line 1195
;1195:			notReady++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1196
;1196:		}
LABELV $598
line 1197
;1197:	}
LABELV $587
line 1180
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $589
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $586
line 1201
;1198:
;1199:	// copy the readyMask to each player's stats so
;1200:	// it can be displayed on the scoreboard
;1201:	for (i=0 ; i< g_maxclients.integer ; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $604
JUMPV
LABELV $601
line 1202
;1202:		cl = level.clients + i;
ADDRLP4 0
CNSTI4 776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1203
;1203:		if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $606
line 1204
;1204:			continue;
ADDRGP4 $602
JUMPV
LABELV $606
line 1206
;1205:		}
;1206:		cl->ps.stats[STAT_CLIENTS_READY] = readyMask;
ADDRLP4 0
INDIRP4
CNSTI4 204
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 1207
;1207:	}
LABELV $602
line 1201
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $604
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $601
line 1210
;1208:
;1209:	// never exit in less than five seconds
;1210:	if ( level.time < level.intermissiontime + 5000 ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9128
INDIRI4
CNSTI4 5000
ADDI4
GEI4 $608
line 1211
;1211:		return;
ADDRGP4 $582
JUMPV
LABELV $608
line 1215
;1212:	}
;1213:
;1214:	// if nobody wants to go, clear timer
;1215:	if ( !ready ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $612
line 1216
;1216:		level.readyToExit = qfalse;
ADDRGP4 level+9136
CNSTI4 0
ASGNI4
line 1217
;1217:		return;
ADDRGP4 $582
JUMPV
LABELV $612
line 1221
;1218:	}
;1219:
;1220:	// if everyone wants to go, go now
;1221:	if ( !notReady ) {
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $615
line 1222
;1222:		ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 1223
;1223:		return;
ADDRGP4 $582
JUMPV
LABELV $615
line 1227
;1224:	}
;1225:
;1226:	// the first person to ready starts the ten second timeout
;1227:	if ( !level.readyToExit ) {
ADDRGP4 level+9136
INDIRI4
CNSTI4 0
NEI4 $617
line 1228
;1228:		level.readyToExit = qtrue;
ADDRGP4 level+9136
CNSTI4 1
ASGNI4
line 1229
;1229:		level.exitTime = level.time;
ADDRGP4 level+9140
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1230
;1230:	}
LABELV $617
line 1234
;1231:
;1232:	// if we have waited ten seconds since at least one player
;1233:	// wanted to exit, go ahead
;1234:	if ( level.time < level.exitTime + 10000 ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9140
INDIRI4
CNSTI4 10000
ADDI4
GEI4 $623
line 1235
;1235:		return;
ADDRGP4 $582
JUMPV
LABELV $623
line 1238
;1236:	}
;1237:
;1238:	ExitLevel();
ADDRGP4 ExitLevel
CALLV
pop
line 1239
;1239:}
LABELV $582
endproc CheckIntermissionExit 20 0
export ScoreIsTied
proc ScoreIsTied 12 0
line 1246
;1240:
;1241:/*
;1242:=============
;1243:ScoreIsTied
;1244:=============
;1245:*/
;1246:qboolean ScoreIsTied( void ) {
line 1249
;1247:	int		a, b;
;1248:
;1249:	if ( level.numPlayingClients < 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
GEI4 $628
line 1250
;1250:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $627
JUMPV
LABELV $628
line 1253
;1251:	}
;1252:	
;1253:	if ( g_gametype.integer >= GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LTI4 $631
line 1254
;1254:		return level.teamScores[TEAM_RED] == level.teamScores[TEAM_BLUE];
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 level+44+8
INDIRI4
NEI4 $639
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $640
JUMPV
LABELV $639
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $640
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $627
JUMPV
LABELV $631
line 1257
;1255:	}
;1256:
;1257:	a = level.clients[level.sortedClients[0]].ps.persistant[PERS_SCORE];
ADDRLP4 0
CNSTI4 776
ADDRGP4 level+84
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 1258
;1258:	b = level.clients[level.sortedClients[1]].ps.persistant[PERS_SCORE];
ADDRLP4 4
CNSTI4 776
ADDRGP4 level+84+4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 1260
;1259:
;1260:	return a == b;
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $645
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRGP4 $646
JUMPV
LABELV $645
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $646
ADDRLP4 8
INDIRI4
RETI4
LABELV $627
endproc ScoreIsTied 12 0
export CheckExitRules
proc CheckExitRules 20 8
line 1272
;1261:}
;1262:
;1263:/*
;1264:=================
;1265:CheckExitRules
;1266:
;1267:There will be a delay between the time the exit is qualified for
;1268:and the time everyone is moved to the intermission spot, so you
;1269:can see the last frag.
;1270:=================
;1271:*/
;1272:void CheckExitRules( void ) {
line 1277
;1273: 	int			i;
;1274:	gclient_t	*cl;
;1275:	// if at the intermission, wait for all non-bots to
;1276:	// signal ready, then go to next level
;1277:	if ( level.intermissiontime ) {
ADDRGP4 level+9128
INDIRI4
CNSTI4 0
EQI4 $648
line 1278
;1278:		CheckIntermissionExit ();
ADDRGP4 CheckIntermissionExit
CALLV
pop
line 1279
;1279:		return;
ADDRGP4 $647
JUMPV
LABELV $648
line 1282
;1280:	}
;1281:
;1282:	if ( level.intermissionQueued ) {
ADDRGP4 level+9124
INDIRI4
CNSTI4 0
EQI4 $651
line 1290
;1283:#ifdef MISSIONPACK
;1284:		int time = (g_singlePlayer.integer) ? SP_INTERMISSION_DELAY_TIME : INTERMISSION_DELAY_TIME;
;1285:		if ( level.time - level.intermissionQueued >= time ) {
;1286:			level.intermissionQueued = 0;
;1287:			BeginIntermission();
;1288:		}
;1289:#else
;1290:		if ( level.time - level.intermissionQueued >= INTERMISSION_DELAY_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+9124
INDIRI4
SUBI4
CNSTI4 1000
LTI4 $647
line 1291
;1291:			level.intermissionQueued = 0;
ADDRGP4 level+9124
CNSTI4 0
ASGNI4
line 1292
;1292:			BeginIntermission();
ADDRGP4 BeginIntermission
CALLV
pop
line 1293
;1293:		}
line 1295
;1294:#endif
;1295:		return;
ADDRGP4 $647
JUMPV
LABELV $651
line 1299
;1296:	}
;1297:
;1298:	// check for sudden death
;1299:	if ( ScoreIsTied() ) {
ADDRLP4 8
ADDRGP4 ScoreIsTied
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $659
line 1301
;1300:		// always wait for sudden death
;1301:		return;
ADDRGP4 $647
JUMPV
LABELV $659
line 1304
;1302:	}
;1303:
;1304:	if ( g_timelimit.integer && !level.warmupTime ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 g_timelimit+12
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $661
ADDRGP4 level+16
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $661
line 1305
;1305:		if ( level.time - level.startTime >= g_timelimit.integer*60000 ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+40
INDIRI4
SUBI4
CNSTI4 60000
ADDRGP4 g_timelimit+12
INDIRI4
MULI4
LTI4 $665
line 1306
;1306:			trap_SendServerCommand( -1, "print \"Timelimit hit.\n\"");
CNSTI4 -1
ARGI4
ADDRGP4 $670
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1307
;1307:			LogExit( "Timelimit hit." );
ADDRGP4 $671
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1308
;1308:			return;
ADDRGP4 $647
JUMPV
LABELV $665
line 1310
;1309:		}
;1310:	}
LABELV $661
line 1312
;1311:
;1312:	if ( level.numPlayingClients < 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
GEI4 $672
line 1313
;1313:		return;
ADDRGP4 $647
JUMPV
LABELV $672
line 1316
;1314:	}
;1315:
;1316:	if ( g_gametype.integer < GT_CTF && g_fraglimit.integer ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
GEI4 $675
ADDRGP4 g_fraglimit+12
INDIRI4
CNSTI4 0
EQI4 $675
line 1317
;1317:		if ( level.teamScores[TEAM_RED] >= g_fraglimit.integer ) {
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 g_fraglimit+12
INDIRI4
LTI4 $679
line 1318
;1318:			trap_SendServerCommand( -1, "print \"Red hit the fraglimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $684
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1319
;1319:			LogExit( "Fraglimit hit." );
ADDRGP4 $685
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1320
;1320:			return;
ADDRGP4 $647
JUMPV
LABELV $679
line 1323
;1321:		}
;1322:
;1323:		if ( level.teamScores[TEAM_BLUE] >= g_fraglimit.integer ) {
ADDRGP4 level+44+8
INDIRI4
ADDRGP4 g_fraglimit+12
INDIRI4
LTI4 $686
line 1324
;1324:			trap_SendServerCommand( -1, "print \"Blue hit the fraglimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $691
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1325
;1325:			LogExit( "Fraglimit hit." );
ADDRGP4 $685
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1326
;1326:			return;
ADDRGP4 $647
JUMPV
LABELV $686
line 1329
;1327:		}
;1328:
;1329:		for ( i=0 ; i< g_maxclients.integer ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $695
JUMPV
LABELV $692
line 1330
;1330:			cl = level.clients + i;
ADDRLP4 0
CNSTI4 776
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 1331
;1331:			if ( cl->pers.connected != CON_CONNECTED ) {
ADDRLP4 0
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $697
line 1332
;1332:				continue;
ADDRGP4 $693
JUMPV
LABELV $697
line 1334
;1333:			}
;1334:			if ( cl->sess.sessionTeam != TEAM_FREE ) {
ADDRLP4 0
INDIRP4
CNSTI4 616
ADDP4
INDIRI4
CNSTI4 0
EQI4 $699
line 1335
;1335:				continue;
ADDRGP4 $693
JUMPV
LABELV $699
line 1338
;1336:			}
;1337:
;1338:			if ( cl->ps.persistant[PERS_SCORE] >= g_fraglimit.integer ) {
ADDRLP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ADDRGP4 g_fraglimit+12
INDIRI4
LTI4 $701
line 1339
;1339:				LogExit( "Fraglimit hit." );
ADDRGP4 $685
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1340
;1340:				trap_SendServerCommand( -1, va("print \"%s" S_COLOR_WHITE " hit the fraglimit.\n\"",
ADDRGP4 $704
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1342
;1341:					cl->pers.netname ) );
;1342:				return;
ADDRGP4 $647
JUMPV
LABELV $701
line 1344
;1343:			}
;1344:		}
LABELV $693
line 1329
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $695
ADDRLP4 4
INDIRI4
ADDRGP4 g_maxclients+12
INDIRI4
LTI4 $692
line 1345
;1345:	}
LABELV $675
line 1347
;1346:
;1347:	if ( g_gametype.integer >= GT_CTF && g_capturelimit.integer ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
LTI4 $705
ADDRGP4 g_capturelimit+12
INDIRI4
CNSTI4 0
EQI4 $705
line 1349
;1348:
;1349:		if ( level.teamScores[TEAM_RED] >= g_capturelimit.integer ) {
ADDRGP4 level+44+4
INDIRI4
ADDRGP4 g_capturelimit+12
INDIRI4
LTI4 $709
line 1350
;1350:			trap_SendServerCommand( -1, "print \"Red hit the capturelimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $714
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1351
;1351:			LogExit( "Capturelimit hit." );
ADDRGP4 $715
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1352
;1352:			return;
ADDRGP4 $647
JUMPV
LABELV $709
line 1355
;1353:		}
;1354:
;1355:		if ( level.teamScores[TEAM_BLUE] >= g_capturelimit.integer ) {
ADDRGP4 level+44+8
INDIRI4
ADDRGP4 g_capturelimit+12
INDIRI4
LTI4 $716
line 1356
;1356:			trap_SendServerCommand( -1, "print \"Blue hit the capturelimit.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $721
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1357
;1357:			LogExit( "Capturelimit hit." );
ADDRGP4 $715
ARGP4
ADDRGP4 LogExit
CALLV
pop
line 1358
;1358:			return;
LABELV $716
line 1360
;1359:		}
;1360:	}
LABELV $705
line 1361
;1361:}
LABELV $647
endproc CheckExitRules 20 8
export CheckTournament
proc CheckTournament 32 8
line 1381
;1362:
;1363:
;1364:
;1365:/*
;1366:========================================================================
;1367:
;1368:FUNCTIONS CALLED EVERY FRAME
;1369:
;1370:========================================================================
;1371:*/
;1372:
;1373:
;1374:/*
;1375:=============
;1376:CheckTournament
;1377:
;1378:Once a frame, check for changes in tournement player state
;1379:=============
;1380:*/
;1381:void CheckTournament( void ) {
line 1384
;1382:	// check because we run 3 game frames before calling Connect and/or ClientBegin
;1383:	// for clients on a map_restart
;1384:	if ( level.numPlayingClients == 0 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 0
NEI4 $723
line 1385
;1385:		return;
ADDRGP4 $722
JUMPV
LABELV $723
line 1388
;1386:	}
;1387:
;1388:	if ( g_gametype.integer == GT_TOURNAMENT ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 1
NEI4 $726
line 1391
;1389:
;1390:		// pull in a spectator if needed
;1391:		if ( level.numPlayingClients < 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
GEI4 $729
line 1392
;1392:			AddTournamentPlayer();
ADDRGP4 AddTournamentPlayer
CALLV
pop
line 1393
;1393:		}
LABELV $729
line 1396
;1394:
;1395:		// if we don't have two players, go back to "waiting for players"
;1396:		if ( level.numPlayingClients != 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
EQI4 $732
line 1397
;1397:			if ( level.warmupTime != -1 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 -1
EQI4 $722
line 1398
;1398:				level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1399
;1399:				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $435
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1400
;1400:				G_LogPrintf( "Warmup:\n" );
ADDRGP4 $740
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1401
;1401:			}
line 1402
;1402:			return;
ADDRGP4 $722
JUMPV
LABELV $732
line 1405
;1403:		}
;1404:
;1405:		if ( level.warmupTime == 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $741
line 1406
;1406:			return;
ADDRGP4 $722
JUMPV
LABELV $741
line 1410
;1407:		}
;1408:
;1409:		// if the warmup is changed at the console, restart it
;1410:		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
ADDRGP4 g_warmup+4
INDIRI4
ADDRGP4 level+352
INDIRI4
EQI4 $744
line 1411
;1411:			level.warmupModificationCount = g_warmup.modificationCount;
ADDRGP4 level+352
ADDRGP4 g_warmup+4
INDIRI4
ASGNI4
line 1412
;1412:			level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1413
;1413:		}
LABELV $744
line 1416
;1414:
;1415:		// if all players have arrived, start the countdown
;1416:		if ( level.warmupTime < 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
GEI4 $751
line 1417
;1417:			if ( level.numPlayingClients == 2 ) {
ADDRGP4 level+80
INDIRI4
CNSTI4 2
NEI4 $722
line 1419
;1418:				// fudge by -1 to account for extra delays
;1419:				level.warmupTime = level.time + ( g_warmup.integer - 1 ) * 1000;
ADDRLP4 0
CNSTI4 1000
ASGNI4
ADDRGP4 level+16
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRI4
ADDRGP4 g_warmup+12
INDIRI4
MULI4
ADDRLP4 0
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1420
;1420:				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $435
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1421
;1421:			}
line 1422
;1422:			return;
ADDRGP4 $722
JUMPV
LABELV $751
line 1426
;1423:		}
;1424:
;1425:		// if the warmup time has counted down, restart
;1426:		if ( level.time > level.warmupTime ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+16
INDIRI4
LEI4 $727
line 1427
;1427:			level.warmupTime += 10000;
ADDRLP4 0
ADDRGP4 level+16
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 1428
;1428:			trap_Cvar_Set( "g_restarted", "1" );
ADDRGP4 $59
ARGP4
ADDRGP4 $83
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1429
;1429:			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
CNSTI4 2
ARGI4
ADDRGP4 $515
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1430
;1430:			level.restarted = qtrue;
ADDRGP4 level+68
CNSTI4 1
ASGNI4
line 1431
;1431:			return;
ADDRGP4 $722
JUMPV
line 1433
;1432:		}
;1433:	} else if ( g_gametype.integer != GT_SINGLE_PLAYER && level.warmupTime != 0 ) {
LABELV $726
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $767
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $767
line 1435
;1434:		int		counts[TEAM_NUM_TEAMS];
;1435:		qboolean	notEnough = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1437
;1436:
;1437:		if ( g_gametype.integer > GT_TEAM ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
LEI4 $771
line 1438
;1438:			counts[TEAM_BLUE] = TeamCount( -1, TEAM_BLUE );
CNSTI4 -1
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 20
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 4+8
ADDRLP4 20
INDIRI4
ASGNI4
line 1439
;1439:			counts[TEAM_RED] = TeamCount( -1, TEAM_RED );
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 24
ADDRGP4 TeamCount
CALLI4
ASGNI4
ADDRLP4 4+4
ADDRLP4 24
INDIRI4
ASGNI4
line 1441
;1440:
;1441:			if (counts[TEAM_RED] < 1 || counts[TEAM_BLUE] < 1) {
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 4+4
INDIRI4
ADDRLP4 28
INDIRI4
LTI4 $780
ADDRLP4 4+8
INDIRI4
ADDRLP4 28
INDIRI4
GEI4 $772
LABELV $780
line 1442
;1442:				notEnough = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1443
;1443:			}
line 1444
;1444:		} else if ( level.numPlayingClients < 2 ) {
ADDRGP4 $772
JUMPV
LABELV $771
ADDRGP4 level+80
INDIRI4
CNSTI4 2
GEI4 $781
line 1445
;1445:			notEnough = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1446
;1446:		}
LABELV $781
LABELV $772
line 1448
;1447:
;1448:		if ( notEnough ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $784
line 1449
;1449:			if ( level.warmupTime != -1 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 -1
EQI4 $722
line 1450
;1450:				level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1451
;1451:				trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $435
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1452
;1452:				G_LogPrintf( "Warmup:\n" );
ADDRGP4 $740
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 1453
;1453:			}
line 1454
;1454:			return; // still waiting for team members
ADDRGP4 $722
JUMPV
LABELV $784
line 1457
;1455:		}
;1456:
;1457:		if ( level.warmupTime == 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
NEI4 $791
line 1458
;1458:			return;
ADDRGP4 $722
JUMPV
LABELV $791
line 1462
;1459:		}
;1460:
;1461:		// if the warmup is changed at the console, restart it
;1462:		if ( g_warmup.modificationCount != level.warmupModificationCount ) {
ADDRGP4 g_warmup+4
INDIRI4
ADDRGP4 level+352
INDIRI4
EQI4 $794
line 1463
;1463:			level.warmupModificationCount = g_warmup.modificationCount;
ADDRGP4 level+352
ADDRGP4 g_warmup+4
INDIRI4
ASGNI4
line 1464
;1464:			level.warmupTime = -1;
ADDRGP4 level+16
CNSTI4 -1
ASGNI4
line 1465
;1465:		}
LABELV $794
line 1468
;1466:
;1467:		// if all players have arrived, start the countdown
;1468:		if ( level.warmupTime < 0 ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
GEI4 $801
line 1470
;1469:			// fudge by -1 to account for extra delays
;1470:			level.warmupTime = level.time + ( g_warmup.integer - 1 ) * 1000;
ADDRLP4 20
CNSTI4 1000
ASGNI4
ADDRGP4 level+16
ADDRGP4 level+32
INDIRI4
ADDRLP4 20
INDIRI4
ADDRGP4 g_warmup+12
INDIRI4
MULI4
ADDRLP4 20
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1471
;1471:			trap_SetConfigstring( CS_WARMUP, va("%i", level.warmupTime) );
ADDRGP4 $435
ARGP4
ADDRGP4 level+16
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 5
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1472
;1472:			return;
ADDRGP4 $722
JUMPV
LABELV $801
line 1476
;1473:		}
;1474:
;1475:		// if the warmup time has counted down, restart
;1476:		if ( level.time > level.warmupTime ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+16
INDIRI4
LEI4 $808
line 1477
;1477:			level.warmupTime += 10000;
ADDRLP4 20
ADDRGP4 level+16
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 10000
ADDI4
ASGNI4
line 1478
;1478:			trap_Cvar_Set( "g_restarted", "1" );
ADDRGP4 $59
ARGP4
ADDRGP4 $83
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1479
;1479:			trap_SendConsoleCommand( EXEC_APPEND, "map_restart 0\n" );
CNSTI4 2
ARGI4
ADDRGP4 $515
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1480
;1480:			level.restarted = qtrue;
ADDRGP4 level+68
CNSTI4 1
ASGNI4
line 1481
;1481:			return;
LABELV $808
line 1483
;1482:		}
;1483:	}
LABELV $767
LABELV $727
line 1484
;1484:}
LABELV $722
endproc CheckTournament 32 8
export CheckVote
proc CheckVote 4 8
line 1492
;1485:
;1486:
;1487:/*
;1488:==================
;1489:CheckVote
;1490:==================
;1491:*/
;1492:void CheckVote( void ) {
line 1493
;1493:	if ( level.voteExecuteTime && level.voteExecuteTime < level.time ) {
ADDRGP4 level+2408
INDIRI4
CNSTI4 0
EQI4 $815
ADDRGP4 level+2408
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $815
line 1494
;1494:		level.voteExecuteTime = 0;
ADDRGP4 level+2408
CNSTI4 0
ASGNI4
line 1495
;1495:		trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.voteString ) );
ADDRGP4 $821
ARGP4
ADDRGP4 level+356
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1496
;1496:	}
LABELV $815
line 1497
;1497:	if ( !level.voteTime ) {
ADDRGP4 level+2404
INDIRI4
CNSTI4 0
NEI4 $823
line 1498
;1498:		return;
ADDRGP4 $814
JUMPV
LABELV $823
line 1500
;1499:	}
;1500:	if ( level.time - level.voteTime >= VOTE_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+2404
INDIRI4
SUBI4
CNSTI4 30000
LTI4 $826
line 1501
;1501:		trap_SendServerCommand( -1, "print \"Vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $830
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1502
;1502:	} else {
ADDRGP4 $827
JUMPV
LABELV $826
line 1503
;1503:		if ( level.voteYes > level.numVotingClients/2 ) {
ADDRGP4 level+2412
INDIRI4
ADDRGP4 level+2420
INDIRI4
CNSTI4 2
DIVI4
LEI4 $831
line 1505
;1504:			// execute the command, then remove the vote
;1505:			trap_SendServerCommand( -1, "print \"Vote passed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $835
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1506
;1506:			level.voteExecuteTime = level.time + 3000;
ADDRGP4 level+2408
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 1507
;1507:		} else if ( level.voteNo >= level.numVotingClients/2 ) {
ADDRGP4 $832
JUMPV
LABELV $831
ADDRGP4 level+2416
INDIRI4
ADDRGP4 level+2420
INDIRI4
CNSTI4 2
DIVI4
LTI4 $814
line 1509
;1508:			// same behavior as a timeout
;1509:			trap_SendServerCommand( -1, "print \"Vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $830
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1510
;1510:		} else {
line 1512
;1511:			// still waiting for a majority
;1512:			return;
LABELV $839
LABELV $832
line 1514
;1513:		}
;1514:	}
LABELV $827
line 1515
;1515:	level.voteTime = 0;
ADDRGP4 level+2404
CNSTI4 0
ASGNI4
line 1516
;1516:	trap_SetConfigstring( CS_VOTE_TIME, "" );
CNSTI4 8
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1518
;1517:
;1518:}
LABELV $814
endproc CheckVote 4 8
export PrintTeam
proc PrintTeam 4 8
line 1525
;1519:
;1520:/*
;1521:==================
;1522:PrintTeam
;1523:==================
;1524:*/
;1525:void PrintTeam(int team, char *message) {
line 1528
;1526:	int i;
;1527:
;1528:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $847
JUMPV
LABELV $844
line 1529
;1529:		if (level.clients[i].sess.sessionTeam != team)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $849
line 1530
;1530:			continue;
ADDRGP4 $845
JUMPV
LABELV $849
line 1531
;1531:		trap_SendServerCommand( i, message );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1532
;1532:	}
LABELV $845
line 1528
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $847
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $844
line 1533
;1533:}
LABELV $843
endproc PrintTeam 4 8
export SetLeader
proc SetLeader 8 8
line 1540
;1534:
;1535:/*
;1536:==================
;1537:SetLeader
;1538:==================
;1539:*/
;1540:void SetLeader(int team, int client) {
line 1543
;1541:	int i;
;1542:
;1543:	if ( level.clients[client].pers.connected == CON_DISCONNECTED ) {
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 0
NEI4 $852
line 1544
;1544:		PrintTeam(team, va("print \"%s is not connected\n\"", level.clients[client].pers.netname) );
ADDRGP4 $854
ARGP4
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintTeam
CALLV
pop
line 1545
;1545:		return;
ADDRGP4 $851
JUMPV
LABELV $852
line 1547
;1546:	}
;1547:	if (level.clients[client].sess.sessionTeam != team) {
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $855
line 1548
;1548:		PrintTeam(team, va("print \"%s is not on the team anymore\n\"", level.clients[client].pers.netname) );
ADDRGP4 $857
ARGP4
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintTeam
CALLV
pop
line 1549
;1549:		return;
ADDRGP4 $851
JUMPV
LABELV $855
line 1551
;1550:	}
;1551:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $861
JUMPV
LABELV $858
line 1552
;1552:		if (level.clients[i].sess.sessionTeam != team)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $863
line 1553
;1553:			continue;
ADDRGP4 $859
JUMPV
LABELV $863
line 1554
;1554:		if (level.clients[i].sess.teamLeader) {
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $865
line 1555
;1555:			level.clients[i].sess.teamLeader = qfalse;
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
CNSTI4 0
ASGNI4
line 1556
;1556:			ClientUserinfoChanged(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 1557
;1557:		}
LABELV $865
line 1558
;1558:	}
LABELV $859
line 1551
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $861
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $858
line 1559
;1559:	level.clients[client].sess.teamLeader = qtrue;
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
CNSTI4 1
ASGNI4
line 1560
;1560:	ClientUserinfoChanged( client );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 ClientUserinfoChanged
CALLV
pop
line 1561
;1561:	PrintTeam(team, va("print \"%s is the new team leader\n\"", level.clients[client].pers.netname) );
ADDRGP4 $867
ARGP4
CNSTI4 776
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 PrintTeam
CALLV
pop
line 1562
;1562:}
LABELV $851
endproc SetLeader 8 8
export CheckTeamLeader
proc CheckTeamLeader 4 0
line 1569
;1563:
;1564:/*
;1565:==================
;1566:CheckTeamLeader
;1567:==================
;1568:*/
;1569:void CheckTeamLeader( int team ) {
line 1572
;1570:	int i;
;1571:
;1572:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $872
JUMPV
LABELV $869
line 1573
;1573:		if (level.clients[i].sess.sessionTeam != team)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $874
line 1574
;1574:			continue;
ADDRGP4 $870
JUMPV
LABELV $874
line 1575
;1575:		if (level.clients[i].sess.teamLeader)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
INDIRI4
CNSTI4 0
EQI4 $876
line 1576
;1576:			break;
ADDRGP4 $871
JUMPV
LABELV $876
line 1577
;1577:	}
LABELV $870
line 1572
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $872
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $869
LABELV $871
line 1578
;1578:	if (i >= level.maxclients) {
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $878
line 1579
;1579:		for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $884
JUMPV
LABELV $881
line 1580
;1580:			if (level.clients[i].sess.sessionTeam != team)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $886
line 1581
;1581:				continue;
ADDRGP4 $882
JUMPV
LABELV $886
line 1582
;1582:			if (!(g_entities[i].r.svFlags & SVF_BOT)) {
CNSTI4 808
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+208+216
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $888
line 1583
;1583:				level.clients[i].sess.teamLeader = qtrue;
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
CNSTI4 1
ASGNI4
line 1584
;1584:				break;
ADDRGP4 $883
JUMPV
LABELV $888
line 1586
;1585:			}
;1586:		}
LABELV $882
line 1579
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $884
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $881
LABELV $883
line 1587
;1587:		for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $895
JUMPV
LABELV $892
line 1588
;1588:			if (level.clients[i].sess.sessionTeam != team)
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 616
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
EQI4 $897
line 1589
;1589:				continue;
ADDRGP4 $893
JUMPV
LABELV $897
line 1590
;1590:			level.clients[i].sess.teamLeader = qtrue;
CNSTI4 776
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 640
ADDP4
CNSTI4 1
ASGNI4
line 1591
;1591:			break;
ADDRGP4 $894
JUMPV
LABELV $893
line 1587
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $895
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $892
LABELV $894
line 1593
;1592:		}
;1593:	}
LABELV $878
line 1594
;1594:}
LABELV $868
endproc CheckTeamLeader 4 0
export CheckTeamVote
proc CheckTeamVote 20 12
line 1601
;1595:
;1596:/*
;1597:==================
;1598:CheckTeamVote
;1599:==================
;1600:*/
;1601:void CheckTeamVote( int team ) {
line 1604
;1602:	int cs_offset;
;1603:
;1604:	if ( team == TEAM_RED )
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $900
line 1605
;1605:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $901
JUMPV
LABELV $900
line 1606
;1606:	else if ( team == TEAM_BLUE )
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $899
line 1607
;1607:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1609
;1608:	else
;1609:		return;
LABELV $903
LABELV $901
line 1611
;1610:
;1611:	if ( !level.teamVoteTime[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4472
ADDP4
INDIRI4
CNSTI4 0
NEI4 $904
line 1612
;1612:		return;
ADDRGP4 $899
JUMPV
LABELV $904
line 1614
;1613:	}
;1614:	if ( level.time - level.teamVoteTime[cs_offset] >= VOTE_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4472
ADDP4
INDIRI4
SUBI4
CNSTI4 30000
LTI4 $907
line 1615
;1615:		trap_SendServerCommand( -1, "print \"Team vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $911
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1616
;1616:	} else {
ADDRGP4 $908
JUMPV
LABELV $907
line 1617
;1617:		if ( level.teamVoteYes[cs_offset] > level.numteamVotingClients[cs_offset]/2 ) {
ADDRLP4 4
CNSTI4 2
ASGNI4
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LSHI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 level+4480
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDRGP4 level+4496
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
DIVI4
LEI4 $912
line 1619
;1618:			// execute the command, then remove the vote
;1619:			trap_SendServerCommand( -1, "print \"Team vote passed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $916
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1621
;1620:			//
;1621:			if ( !Q_strncmp( "leader", level.teamVoteString[cs_offset], 6) ) {
ADDRGP4 $919
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+2424
ADDP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 12
ADDRGP4 Q_strncmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $917
line 1623
;1622:				//set the team leader
;1623:				SetLeader(team, atoi(level.teamVoteString[cs_offset] + 7));
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+2424+7
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 SetLeader
CALLV
pop
line 1624
;1624:			}
ADDRGP4 $913
JUMPV
LABELV $917
line 1625
;1625:			else {
line 1626
;1626:				trap_SendConsoleCommand( EXEC_APPEND, va("%s\n", level.teamVoteString[cs_offset] ) );
ADDRGP4 $821
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 level+2424
ADDP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_SendConsoleCommand
CALLV
pop
line 1627
;1627:			}
line 1628
;1628:		} else if ( level.teamVoteNo[cs_offset] >= level.numteamVotingClients[cs_offset]/2 ) {
ADDRGP4 $913
JUMPV
LABELV $912
ADDRLP4 12
CNSTI4 2
ASGNI4
ADDRLP4 16
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 level+4488
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRGP4 level+4496
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
DIVI4
LTI4 $899
line 1630
;1629:			// same behavior as a timeout
;1630:			trap_SendServerCommand( -1, "print \"Team vote failed.\n\"" );
CNSTI4 -1
ARGI4
ADDRGP4 $911
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 1631
;1631:		} else {
line 1633
;1632:			// still waiting for a majority
;1633:			return;
LABELV $925
LABELV $913
line 1635
;1634:		}
;1635:	}
LABELV $908
line 1636
;1636:	level.teamVoteTime[cs_offset] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+4472
ADDP4
CNSTI4 0
ASGNI4
line 1637
;1637:	trap_SetConfigstring( CS_TEAMVOTE_TIME + cs_offset, "" );
ADDRLP4 0
INDIRI4
CNSTI4 12
ADDI4
ARGI4
ADDRGP4 $54
ARGP4
ADDRGP4 trap_SetConfigstring
CALLV
pop
line 1639
;1638:
;1639:}
LABELV $899
endproc CheckTeamVote 20 12
data
align 4
LABELV $930
byte 4 -1
export CheckCvars
code
proc CheckCvars 4 8
line 1647
;1640:
;1641:
;1642:/*
;1643:==================
;1644:CheckCvars
;1645:==================
;1646:*/
;1647:void CheckCvars( void ) {
line 1650
;1648:	static int lastMod = -1;
;1649:
;1650:	if ( g_password.modificationCount != lastMod ) {
ADDRGP4 g_password+4
INDIRI4
ADDRGP4 $930
INDIRI4
EQI4 $931
line 1651
;1651:		lastMod = g_password.modificationCount;
ADDRGP4 $930
ADDRGP4 g_password+4
INDIRI4
ASGNI4
line 1652
;1652:		if ( *g_password.string && Q_stricmp( g_password.string, "none" ) ) {
ADDRGP4 g_password+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $935
ADDRGP4 g_password+16
ARGP4
ADDRGP4 $939
ARGP4
ADDRLP4 0
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $935
line 1653
;1653:			trap_Cvar_Set( "g_needpass", "1" );
ADDRGP4 $84
ARGP4
ADDRGP4 $83
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1654
;1654:		} else {
ADDRGP4 $936
JUMPV
LABELV $935
line 1655
;1655:			trap_Cvar_Set( "g_needpass", "0" );
ADDRGP4 $84
ARGP4
ADDRGP4 $60
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1656
;1656:		}
LABELV $936
line 1657
;1657:	}
LABELV $931
line 1658
;1658:}
LABELV $929
endproc CheckCvars 4 8
export G_RunThink
proc G_RunThink 8 4
line 1667
;1659:
;1660:/*
;1661:=============
;1662:G_RunThink
;1663:
;1664:Runs thinking code for this frame if necessary
;1665:=============
;1666:*/
;1667:void G_RunThink (gentity_t *ent) {
line 1670
;1668:	float	thinktime;
;1669:
;1670:	thinktime = ent->nextthink;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1671
;1671:	if (thinktime <= 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
GTF4 $941
line 1672
;1672:		return;
ADDRGP4 $940
JUMPV
LABELV $941
line 1674
;1673:	}
;1674:	if (thinktime > level.time) {
ADDRLP4 0
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $943
line 1675
;1675:		return;
ADDRGP4 $940
JUMPV
LABELV $943
line 1678
;1676:	}
;1677:	
;1678:	ent->nextthink = 0;
ADDRFP4 0
INDIRP4
CNSTI4 688
ADDP4
CNSTI4 0
ASGNI4
line 1679
;1679:	if (!ent->think) {
ADDRFP4 0
INDIRP4
CNSTI4 692
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $946
line 1680
;1680:		G_Error ( "NULL ent->think");
ADDRGP4 $948
ARGP4
ADDRGP4 G_Error
CALLV
pop
line 1681
;1681:	}
LABELV $946
line 1682
;1682:	ent->think (ent);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 692
ADDP4
INDIRP4
CALLV
pop
line 1683
;1683:}
LABELV $940
endproc G_RunThink 8 4
export G_RunFrame
proc G_RunFrame 44 12
line 1692
;1684:
;1685:/*
;1686:================
;1687:G_RunFrame
;1688:
;1689:Advances the non-player objects in the world
;1690:================
;1691:*/
;1692:void G_RunFrame( int levelTime ) {
line 1699
;1693:	int			i;
;1694:	gentity_t	*ent;
;1695:	int			msec;
;1696:int start, end;
;1697:
;1698:	// if we are waiting for the level to restart, do nothing
;1699:	if ( level.restarted ) {
ADDRGP4 level+68
INDIRI4
CNSTI4 0
EQI4 $950
line 1700
;1700:		return;
ADDRGP4 $949
JUMPV
LABELV $950
line 1703
;1701:	}
;1702:
;1703:	level.framenum++;
ADDRLP4 20
ADDRGP4 level+28
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1704
;1704:	level.previousTime = level.time;
ADDRGP4 level+36
ADDRGP4 level+32
INDIRI4
ASGNI4
line 1705
;1705:	level.time = levelTime;
ADDRGP4 level+32
ADDRFP4 0
INDIRI4
ASGNI4
line 1706
;1706:	msec = level.time - level.previousTime;
ADDRLP4 16
ADDRGP4 level+32
INDIRI4
ADDRGP4 level+36
INDIRI4
SUBI4
ASGNI4
line 1709
;1707:
;1708:	// get any cvar changes
;1709:	G_UpdateCvars();
ADDRGP4 G_UpdateCvars
CALLV
pop
line 1714
;1710:
;1711:	//
;1712:	// go through all allocated objects
;1713:	//
;1714:	start = trap_Milliseconds();
ADDRLP4 24
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 24
INDIRI4
ASGNI4
line 1715
;1715:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 1716
;1716:	for (i=0 ; i<level.num_entities ; i++, ent++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $962
JUMPV
LABELV $959
line 1717
;1717:		if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
NEI4 $964
line 1718
;1718:			continue;
ADDRGP4 $960
JUMPV
LABELV $964
line 1722
;1719:		}
;1720:
;1721:		// clear events that are too old
;1722:		if ( level.time - ent->eventTime > EVENT_VALID_MSEC ) {
ADDRGP4 level+32
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 552
ADDP4
INDIRI4
SUBI4
CNSTI4 300
LEI4 $966
line 1723
;1723:			if ( ent->s.event ) {
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
INDIRI4
CNSTI4 0
EQI4 $969
line 1724
;1724:				ent->s.event = 0;	// &= EV_EVENT_BITS;
ADDRLP4 0
INDIRP4
CNSTI4 180
ADDP4
CNSTI4 0
ASGNI4
line 1725
;1725:				if ( ent->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $971
line 1726
;1726:					ent->client->ps.externalEvent = 0;
ADDRLP4 0
INDIRP4
CNSTI4 516
ADDP4
INDIRP4
CNSTI4 128
ADDP4
CNSTI4 0
ASGNI4
line 1730
;1727:					// predicted events should never be set to zero
;1728:					//ent->client->ps.events[0] = 0;
;1729:					//ent->client->ps.events[1] = 0;
;1730:				}
LABELV $971
line 1731
;1731:			}
LABELV $969
line 1732
;1732:			if ( ent->freeAfterEvent ) {
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $973
line 1734
;1733:				// tempEntities or dropped items completely go away after their event
;1734:				G_FreeEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_FreeEntity
CALLV
pop
line 1735
;1735:				continue;
ADDRGP4 $960
JUMPV
LABELV $973
line 1736
;1736:			} else if ( ent->unlinkAfterEvent ) {
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
CNSTI4 0
EQI4 $975
line 1738
;1737:				// items that will respawn will hide themselves after their pickup event
;1738:				ent->unlinkAfterEvent = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 560
ADDP4
CNSTI4 0
ASGNI4
line 1739
;1739:				trap_UnlinkEntity( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_UnlinkEntity
CALLV
pop
line 1740
;1740:			}
LABELV $975
line 1741
;1741:		}
LABELV $966
line 1744
;1742:
;1743:		// temporary entities don't think
;1744:		if ( ent->freeAfterEvent ) {
ADDRLP4 0
INDIRP4
CNSTI4 556
ADDP4
INDIRI4
CNSTI4 0
EQI4 $977
line 1745
;1745:			continue;
ADDRGP4 $960
JUMPV
LABELV $977
line 1748
;1746:		}
;1747:
;1748:		if ( !ent->r.linked && ent->neverFree ) {
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $979
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $979
line 1749
;1749:			continue;
ADDRGP4 $960
JUMPV
LABELV $979
line 1752
;1750:		}
;1751:
;1752:		if ( ent->s.eType == ET_MISSILE ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $981
line 1753
;1753:			G_RunMissile( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunMissile
CALLV
pop
line 1754
;1754:			continue;
ADDRGP4 $960
JUMPV
LABELV $981
line 1757
;1755:		}
;1756:
;1757:		if ( ent->s.eType == ET_ITEM || ent->physicsObject ) {
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $985
ADDRLP4 0
INDIRP4
CNSTI4 564
ADDP4
INDIRI4
CNSTI4 0
EQI4 $983
LABELV $985
line 1758
;1758:			G_RunItem( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunItem
CALLV
pop
line 1759
;1759:			continue;
ADDRGP4 $960
JUMPV
LABELV $983
line 1762
;1760:		}
;1761:
;1762:		if ( ent->s.eType == ET_MOVER ) {
ADDRLP4 40
CNSTI4 4
ASGNI4
ADDRLP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $986
line 1763
;1763:			G_RunMover( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunMover
CALLV
pop
line 1764
;1764:			continue;
ADDRGP4 $960
JUMPV
LABELV $986
line 1767
;1765:		}
;1766:
;1767:		if ( i < MAX_CLIENTS ) {
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $988
line 1768
;1768:			G_RunClient( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunClient
CALLV
pop
line 1769
;1769:			continue;
ADDRGP4 $960
JUMPV
LABELV $988
line 1772
;1770:		}
;1771:
;1772:		G_RunThink( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 G_RunThink
CALLV
pop
line 1773
;1773:	}
LABELV $960
line 1716
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
ASGNP4
LABELV $962
ADDRLP4 4
INDIRI4
ADDRGP4 level+12
INDIRI4
LTI4 $959
line 1774
;1774:end = trap_Milliseconds();
ADDRLP4 28
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 28
INDIRI4
ASGNI4
line 1776
;1775:
;1776:start = trap_Milliseconds();
ADDRLP4 32
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 32
INDIRI4
ASGNI4
line 1778
;1777:	// perform final fixups on the players
;1778:	ent = &g_entities[0];
ADDRLP4 0
ADDRGP4 g_entities
ASGNP4
line 1779
;1779:	for (i=0 ; i < level.maxclients ; i++, ent++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $993
JUMPV
LABELV $990
line 1780
;1780:		if ( ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $995
line 1781
;1781:			ClientEndFrame( ent );
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 ClientEndFrame
CALLV
pop
line 1782
;1782:		}
LABELV $995
line 1783
;1783:	}
LABELV $991
line 1779
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 808
ADDP4
ASGNP4
LABELV $993
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $990
line 1784
;1784:end = trap_Milliseconds();
ADDRLP4 36
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 1787
;1785:
;1786:	// see if it is time to do a tournement restart
;1787:	CheckTournament();
ADDRGP4 CheckTournament
CALLV
pop
line 1790
;1788:
;1789:	// see if it is time to end the level
;1790:	CheckExitRules();
ADDRGP4 CheckExitRules
CALLV
pop
line 1793
;1791:
;1792:	// update to team status?
;1793:	CheckTeamStatus();
ADDRGP4 CheckTeamStatus
CALLV
pop
line 1796
;1794:
;1795:	// cancel vote if timed out
;1796:	CheckVote();
ADDRGP4 CheckVote
CALLV
pop
line 1799
;1797:
;1798:	// check team votes
;1799:	CheckTeamVote( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 CheckTeamVote
CALLV
pop
line 1800
;1800:	CheckTeamVote( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 CheckTeamVote
CALLV
pop
line 1803
;1801:
;1802:	// for tracking changes
;1803:	CheckCvars();
ADDRGP4 CheckCvars
CALLV
pop
line 1805
;1804:
;1805:	if (g_listEntity.integer) {
ADDRGP4 g_listEntity+12
INDIRI4
CNSTI4 0
EQI4 $997
line 1806
;1806:		for (i = 0; i < MAX_GENTITIES; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $1000
line 1807
;1807:			G_Printf("%4i: %s\n", i, g_entities[i].classname);
ADDRGP4 $1004
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 808
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
line 1808
;1808:		}
LABELV $1001
line 1806
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $1000
line 1809
;1809:		trap_Cvar_Set("g_listEntity", "0");
ADDRGP4 $110
ARGP4
ADDRGP4 $60
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1810
;1810:	}
LABELV $997
line 1811
;1811:}
LABELV $949
endproc G_RunFrame 44 12
bss
export g_listEntity
align 4
LABELV g_listEntity
skip 272
export g_podiumDrop
align 4
LABELV g_podiumDrop
skip 272
export g_podiumDist
align 4
LABELV g_podiumDist
skip 272
export g_logSync
align 4
LABELV g_logSync
skip 272
export g_log
align 4
LABELV g_log
skip 272
export g_clients
align 4
LABELV g_clients
skip 49664
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Milliseconds
import trap_Error
import trap_Printf
import g_proxMineTimeout
import g_singlePlayer
import g_enableBreath
import g_enableDust
export g_rankings
align 4
LABELV g_rankings
skip 272
export pmove_msec
align 4
LABELV pmove_msec
skip 272
export pmove_fixed
align 4
LABELV pmove_fixed
skip 272
export g_smoothClients
align 4
LABELV g_smoothClients
skip 272
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
export g_filterBan
align 4
LABELV g_filterBan
skip 272
export g_banIPs
align 4
LABELV g_banIPs
skip 272
export g_teamForceBalance
align 4
LABELV g_teamForceBalance
skip 272
export g_teamAutoJoin
align 4
LABELV g_teamAutoJoin
skip 272
export g_allowVote
align 4
LABELV g_allowVote
skip 272
export g_blood
align 4
LABELV g_blood
skip 272
export g_doWarmup
align 4
LABELV g_doWarmup
skip 272
export g_warmup
align 4
LABELV g_warmup
skip 272
export g_motd
align 4
LABELV g_motd
skip 272
export g_synchronousClients
align 4
LABELV g_synchronousClients
skip 272
export g_weaponTeamRespawn
align 4
LABELV g_weaponTeamRespawn
skip 272
export g_weaponRespawn
align 4
LABELV g_weaponRespawn
skip 272
export g_debugDamage
align 4
LABELV g_debugDamage
skip 272
export g_debugAlloc
align 4
LABELV g_debugAlloc
skip 272
export g_debugMove
align 4
LABELV g_debugMove
skip 272
export g_inactivity
align 4
LABELV g_inactivity
skip 272
export g_forcerespawn
align 4
LABELV g_forcerespawn
skip 272
export g_quadfactor
align 4
LABELV g_quadfactor
skip 272
export g_knockback
align 4
LABELV g_knockback
skip 272
export g_speed
align 4
LABELV g_speed
skip 272
export g_gravity
align 4
LABELV g_gravity
skip 272
export g_needpass
align 4
LABELV g_needpass
skip 272
export g_password
align 4
LABELV g_password
skip 272
export g_friendlyFire
align 4
LABELV g_friendlyFire
skip 272
export g_capturelimit
align 4
LABELV g_capturelimit
skip 272
export g_timelimit
align 4
LABELV g_timelimit
skip 272
export g_fraglimit
align 4
LABELV g_fraglimit
skip 272
export g_dmflags
align 4
LABELV g_dmflags
skip 272
export g_restarted
align 4
LABELV g_restarted
skip 272
export g_maxGameClients
align 4
LABELV g_maxGameClients
skip 272
export g_maxclients
align 4
LABELV g_maxclients
skip 272
export g_cheats
align 4
LABELV g_cheats
skip 272
export g_dedicated
align 4
LABELV g_dedicated
skip 272
export g_gametype
align 4
LABELV g_gametype
skip 272
export g_entities
align 4
LABELV g_entities
skip 827392
export level
align 4
LABELV level
skip 9212
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import BotTestAAS
import BotAIStartFrame
import BotAIShutdownClient
import BotAISetupClient
import BotAILoadMap
import BotAIShutdown
import BotAISetup
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import Svcmd_AbortPodium_f
import SpawnModelsOnVictoryPads
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import CheckObeliskAttack
import Team_CheckDroppedItem
import OnSameTeam
import G_RunClient
import ClientEndFrame
import ClientThink
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import DeathmatchScoreboardMessage
import G_SetStats
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_grapple
import fire_bfg
import fire_rocket
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import TossClientItems
import body_die
import G_InvulnerabilityEffect
import G_RadiusDamage
import G_Damage
import CanDamage
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vectoyaw
import vtos
import tv
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_Sound
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_Find
import G_KillBox
import G_TeamCommand
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $1004
byte 1 37
byte 1 52
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $948
byte 1 78
byte 1 85
byte 1 76
byte 1 76
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 45
byte 1 62
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 107
byte 1 0
align 1
LABELV $939
byte 1 110
byte 1 111
byte 1 110
byte 1 101
byte 1 0
align 1
LABELV $919
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $916
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $911
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 118
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $867
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 110
byte 1 101
byte 1 119
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $857
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 111
byte 1 110
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 97
byte 1 110
byte 1 121
byte 1 109
byte 1 111
byte 1 114
byte 1 101
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $854
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 110
byte 1 111
byte 1 116
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $835
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $830
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 32
byte 1 102
byte 1 97
byte 1 105
byte 1 108
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $821
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $740
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $721
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $715
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $714
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $704
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $691
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 66
byte 1 108
byte 1 117
byte 1 101
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $685
byte 1 70
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $684
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 82
byte 1 101
byte 1 100
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $671
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 0
align 1
LABELV $670
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $580
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 32
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $563
byte 1 114
byte 1 101
byte 1 100
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 32
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $554
byte 1 69
byte 1 120
byte 1 105
byte 1 116
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $542
byte 1 37
byte 1 51
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 32
byte 1 0
align 1
LABELV $519
byte 1 118
byte 1 115
byte 1 116
byte 1 114
byte 1 32
byte 1 110
byte 1 101
byte 1 120
byte 1 116
byte 1 109
byte 1 97
byte 1 112
byte 1 10
byte 1 0
align 1
LABELV $515
byte 1 109
byte 1 97
byte 1 112
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $468
byte 1 105
byte 1 110
byte 1 102
byte 1 111
byte 1 95
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $435
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $301
byte 1 115
byte 1 0
align 1
LABELV $292
byte 1 102
byte 1 0
align 1
LABELV $264
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $258
byte 1 83
byte 1 104
byte 1 117
byte 1 116
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 10
byte 1 0
align 1
LABELV $254
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 32
byte 1 83
byte 1 104
byte 1 117
byte 1 116
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 61
byte 1 61
byte 1 61
byte 1 61
byte 1 10
byte 1 0
align 1
LABELV $252
byte 1 98
byte 1 111
byte 1 116
byte 1 95
byte 1 101
byte 1 110
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $249
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $248
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 103
byte 1 117
byte 1 114
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $247
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 111
byte 1 98
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 47
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 52
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $245
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $241
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $225
byte 1 78
byte 1 111
byte 1 116
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 103
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 100
byte 1 105
byte 1 115
byte 1 107
byte 1 46
byte 1 10
byte 1 0
align 1
LABELV $224
byte 1 73
byte 1 110
byte 1 105
byte 1 116
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $223
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $221
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 67
byte 1 111
byte 1 117
byte 1 108
byte 1 100
byte 1 110
byte 1 39
byte 1 116
byte 1 32
byte 1 111
byte 1 112
byte 1 101
byte 1 110
byte 1 32
byte 1 108
byte 1 111
byte 1 103
byte 1 102
byte 1 105
byte 1 108
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $206
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 102
byte 1 114
byte 1 121
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $202
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $201
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $200
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 32
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 73
byte 1 110
byte 1 105
byte 1 116
byte 1 105
byte 1 97
byte 1 108
byte 1 105
byte 1 122
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 45
byte 1 10
byte 1 0
align 1
LABELV $194
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $179
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 117
byte 1 116
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 114
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 44
byte 1 32
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 48
byte 1 10
byte 1 0
align 1
LABELV $161
byte 1 37
byte 1 105
byte 1 32
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 32
byte 1 119
byte 1 105
byte 1 116
byte 1 104
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 101
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 105
byte 1 101
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $114
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 110
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $113
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $112
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $111
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 111
byte 1 116
byte 1 104
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $110
byte 1 103
byte 1 95
byte 1 108
byte 1 105
byte 1 115
byte 1 116
byte 1 69
byte 1 110
byte 1 116
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $109
byte 1 103
byte 1 95
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 86
byte 1 111
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $108
byte 1 55
byte 1 48
byte 1 0
align 1
LABELV $107
byte 1 103
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 68
byte 1 114
byte 1 111
byte 1 112
byte 1 0
align 1
LABELV $106
byte 1 56
byte 1 48
byte 1 0
align 1
LABELV $105
byte 1 103
byte 1 95
byte 1 112
byte 1 111
byte 1 100
byte 1 105
byte 1 117
byte 1 109
byte 1 68
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $104
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $103
byte 1 103
byte 1 95
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 0
align 1
LABELV $102
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 65
byte 1 108
byte 1 108
byte 1 111
byte 1 99
byte 1 0
align 1
LABELV $101
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $100
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 77
byte 1 111
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $99
byte 1 103
byte 1 95
byte 1 105
byte 1 110
byte 1 97
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $98
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $97
byte 1 51
byte 1 48
byte 1 0
align 1
LABELV $96
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 82
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $95
byte 1 53
byte 1 0
align 1
LABELV $94
byte 1 103
byte 1 95
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $93
byte 1 51
byte 1 0
align 1
LABELV $92
byte 1 103
byte 1 95
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 102
byte 1 97
byte 1 99
byte 1 116
byte 1 111
byte 1 114
byte 1 0
align 1
LABELV $91
byte 1 49
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $90
byte 1 103
byte 1 95
byte 1 107
byte 1 110
byte 1 111
byte 1 99
byte 1 107
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 0
align 1
LABELV $89
byte 1 56
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $88
byte 1 103
byte 1 95
byte 1 103
byte 1 114
byte 1 97
byte 1 118
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $87
byte 1 51
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $86
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $85
byte 1 100
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $84
byte 1 103
byte 1 95
byte 1 110
byte 1 101
byte 1 101
byte 1 100
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $83
byte 1 49
byte 1 0
align 1
LABELV $82
byte 1 103
byte 1 95
byte 1 102
byte 1 105
byte 1 108
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 97
byte 1 110
byte 1 0
align 1
LABELV $81
byte 1 103
byte 1 95
byte 1 98
byte 1 97
byte 1 110
byte 1 73
byte 1 80
byte 1 115
byte 1 0
align 1
LABELV $80
byte 1 103
byte 1 95
byte 1 112
byte 1 97
byte 1 115
byte 1 115
byte 1 119
byte 1 111
byte 1 114
byte 1 100
byte 1 0
align 1
LABELV $79
byte 1 103
byte 1 95
byte 1 108
byte 1 111
byte 1 103
byte 1 83
byte 1 121
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $78
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 46
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $77
byte 1 103
byte 1 95
byte 1 108
byte 1 111
byte 1 103
byte 1 0
align 1
LABELV $76
byte 1 103
byte 1 95
byte 1 100
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $75
byte 1 103
byte 1 95
byte 1 119
byte 1 97
byte 1 114
byte 1 109
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $74
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 70
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 66
byte 1 97
byte 1 108
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $73
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 65
byte 1 117
byte 1 116
byte 1 111
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $72
byte 1 103
byte 1 95
byte 1 102
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 108
byte 1 121
byte 1 70
byte 1 105
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $71
byte 1 103
byte 1 95
byte 1 115
byte 1 121
byte 1 110
byte 1 99
byte 1 104
byte 1 114
byte 1 111
byte 1 110
byte 1 111
byte 1 117
byte 1 115
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $70
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $69
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $68
byte 1 50
byte 1 48
byte 1 0
align 1
LABELV $67
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $66
byte 1 100
byte 1 109
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 0
align 1
LABELV $65
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $64
byte 1 56
byte 1 0
align 1
LABELV $63
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 120
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $62
byte 1 103
byte 1 95
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $61
byte 1 115
byte 1 118
byte 1 95
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $60
byte 1 48
byte 1 0
align 1
LABELV $59
byte 1 103
byte 1 95
byte 1 114
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $58
byte 1 65
byte 1 117
byte 1 103
byte 1 32
byte 1 49
byte 1 50
byte 1 32
byte 1 50
byte 1 48
byte 1 48
byte 1 49
byte 1 0
align 1
LABELV $57
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $56
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 113
byte 1 51
byte 1 0
align 1
LABELV $55
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $54
byte 1 0
align 1
LABELV $53
byte 1 115
byte 1 118
byte 1 95
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 0
