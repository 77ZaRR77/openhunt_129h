export BotValidTeamLeader
code
proc BotValidTeamLeader 8 4
file "../ai_team.c"
line 56
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_team.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_team.c $
;10: * $Author: Ttimo $ 
;11: * $Revision: 33 $
;12: * $Modtime: 4/13/01 4:49p $
;13: * $Date: 4/13/01 4:49p $
;14: *
;15: *****************************************************************************/
;16:
;17:#include "g_local.h"
;18:#include "botlib.h"
;19:#include "be_aas.h"
;20:#include "be_ea.h"
;21:#include "be_ai_char.h"
;22:#include "be_ai_chat.h"
;23:#include "be_ai_gen.h"
;24:#include "be_ai_goal.h"
;25:#include "be_ai_move.h"
;26:#include "be_ai_weap.h"
;27://
;28:#include "ai_main.h"
;29:#include "ai_dmq3.h"
;30:#include "ai_chat.h"
;31:#include "ai_cmd.h"
;32:#include "ai_dmnet.h"
;33:#include "ai_team.h"
;34:#include "ai_vcmd.h"
;35:
;36:#include "match.h"
;37:
;38:// for the voice chats
;39:#include "../../ui/menudef.h"
;40:
;41://ctf task preferences for a client
;42:typedef struct bot_ctftaskpreference_s
;43:{
;44:	char		name[36];
;45:	int			preference;
;46:} bot_ctftaskpreference_t;
;47:
;48:bot_ctftaskpreference_t ctftaskpreferences[MAX_CLIENTS];
;49:
;50:
;51:/*
;52:==================
;53:BotValidTeamLeader
;54:==================
;55:*/
;56:int BotValidTeamLeader(bot_state_t *bs) {
line 57
;57:	if (!strlen(bs->teamleader)) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $54
CNSTI4 0
RETI4
ADDRGP4 $53
JUMPV
LABELV $54
line 58
;58:	if (ClientFromName(bs->teamleader) == -1) return qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 ClientFromName
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 -1
NEI4 $56
CNSTI4 0
RETI4
ADDRGP4 $53
JUMPV
LABELV $56
line 59
;59:	return qtrue;
CNSTI4 1
RETI4
LABELV $53
endproc BotValidTeamLeader 8 4
bss
align 4
LABELV $59
skip 4
export BotNumTeamMates
code
proc BotNumTeamMates 1060 12
line 67
;60:}
;61:
;62:/*
;63:==================
;64:BotNumTeamMates
;65:==================
;66:*/
;67:int BotNumTeamMates(bot_state_t *bs) {
line 72
;68:	int i, numplayers;
;69:	char buf[MAX_INFO_STRING];
;70:	static int maxclients;
;71:
;72:	if (!maxclients)
ADDRGP4 $59
INDIRI4
CNSTI4 0
NEI4 $60
line 73
;73:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $62
ARGP4
ADDRLP4 1032
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $59
ADDRLP4 1032
INDIRI4
ASGNI4
LABELV $60
line 75
;74:
;75:	numplayers = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 76
;76:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $66
JUMPV
LABELV $63
line 77
;77:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 79
;78:		//if no config string or no name
;79:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $70
ADDRLP4 4
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 1040
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $67
LABELV $70
ADDRGP4 $64
JUMPV
LABELV $67
line 81
;80:		//skip spectators
;81:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $73
ARGP4
ADDRLP4 1048
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 3
NEI4 $71
ADDRGP4 $64
JUMPV
LABELV $71
line 83
;82:		//
;83:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1056
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $74
line 84
;84:			numplayers++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 85
;85:		}
LABELV $74
line 86
;86:	}
LABELV $64
line 76
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $66
ADDRLP4 0
INDIRI4
ADDRGP4 $59
INDIRI4
GEI4 $76
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $63
LABELV $76
line 87
;87:	return numplayers;
ADDRLP4 1028
INDIRI4
RETI4
LABELV $58
endproc BotNumTeamMates 1060 12
export BotClientTravelTimeToGoal
proc BotClientTravelTimeToGoal 480 16
line 95
;88:}
;89:
;90:/*
;91:==================
;92:BotClientTravelTimeToGoal
;93:==================
;94:*/
;95:int BotClientTravelTimeToGoal(int client, bot_goal_t *goal) {
line 99
;96:	playerState_t ps;
;97:	int areanum;
;98:
;99:	BotAI_GetClientState(client, &ps);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
line 100
;100:	areanum = BotPointAreaNum(ps.origin);
ADDRLP4 0+20
ARGP4
ADDRLP4 472
ADDRGP4 BotPointAreaNum
CALLI4
ASGNI4
ADDRLP4 468
ADDRLP4 472
INDIRI4
ASGNI4
line 101
;101:	if (!areanum) return 1;
ADDRLP4 468
INDIRI4
CNSTI4 0
NEI4 $79
CNSTI4 1
RETI4
ADDRGP4 $77
JUMPV
LABELV $79
line 102
;102:	return trap_AAS_AreaTravelTimeToGoalArea(areanum, ps.origin, goal->areanum, TFL_DEFAULT);
ADDRLP4 468
INDIRI4
ARGI4
ADDRLP4 0+20
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
CNSTI4 18616254
ARGI4
ADDRLP4 476
ADDRGP4 trap_AAS_AreaTravelTimeToGoalArea
CALLI4
ASGNI4
ADDRLP4 476
INDIRI4
RETI4
LABELV $77
endproc BotClientTravelTimeToGoal 480 16
bss
align 4
LABELV $83
skip 4
export BotSortTeamMatesByBaseTravelTime
code
proc BotSortTeamMatesByBaseTravelTime 1352 12
line 110
;103:}
;104:
;105:/*
;106:==================
;107:BotSortTeamMatesByBaseTravelTime
;108:==================
;109:*/
;110:int BotSortTeamMatesByBaseTravelTime(bot_state_t *bs, int *teammates, int maxteammates) {
line 116
;111:
;112:	int i, j, k, numteammates, traveltime;
;113:	char buf[MAX_INFO_STRING];
;114:	static int maxclients;
;115:	int traveltimes[MAX_CLIENTS];
;116:	bot_goal_t *goal = NULL;
ADDRLP4 1300
CNSTP4 0
ASGNP4
line 118
;117:
;118:	if (gametype == GT_CTF || gametype == GT_1FCTF) {
ADDRLP4 1304
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 1304
INDIRI4
CNSTI4 4
EQI4 $86
ADDRLP4 1304
INDIRI4
CNSTI4 5
NEI4 $84
LABELV $86
line 119
;119:		if (BotTeam(bs) == TEAM_RED)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1308
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 1308
INDIRI4
CNSTI4 1
NEI4 $87
line 120
;120:			goal = &ctf_redflag;
ADDRLP4 1300
ADDRGP4 ctf_redflag
ASGNP4
ADDRGP4 $88
JUMPV
LABELV $87
line 122
;121:		else
;122:			goal = &ctf_blueflag;
ADDRLP4 1300
ADDRGP4 ctf_blueflag
ASGNP4
LABELV $88
line 123
;123:	}
LABELV $84
line 132
;124:#ifdef MISSIONPACK
;125:	else {
;126:		if (BotTeam(bs) == TEAM_RED)
;127:			goal = &redobelisk;
;128:		else
;129:			goal = &blueobelisk;
;130:	}
;131:#endif
;132:	if (!maxclients)
ADDRGP4 $83
INDIRI4
CNSTI4 0
NEI4 $89
line 133
;133:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $62
ARGP4
ADDRLP4 1308
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $83
ADDRLP4 1308
INDIRI4
ASGNI4
LABELV $89
line 135
;134:
;135:	numteammates = 0;
ADDRLP4 264
CNSTI4 0
ASGNI4
line 136
;136:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 268
CNSTI4 0
ASGNI4
ADDRGP4 $94
JUMPV
LABELV $91
line 137
;137:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 268
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 276
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 139
;138:		//if no config string or no name
;139:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 276
ARGP4
ADDRLP4 1312
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1312
INDIRI4
CNSTI4 0
EQI4 $97
ADDRLP4 276
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 1316
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1316
INDIRP4
ARGP4
ADDRLP4 1320
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1320
INDIRI4
CNSTI4 0
NEI4 $95
LABELV $97
ADDRGP4 $92
JUMPV
LABELV $95
line 141
;140:		//skip spectators
;141:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 276
ARGP4
ADDRGP4 $73
ARGP4
ADDRLP4 1324
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1324
INDIRP4
ARGP4
ADDRLP4 1328
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1328
INDIRI4
CNSTI4 3
NEI4 $98
ADDRGP4 $92
JUMPV
LABELV $98
line 143
;142:		//
;143:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
INDIRI4
ARGI4
ADDRLP4 1332
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1332
INDIRI4
CNSTI4 0
EQI4 $100
line 145
;144:			//
;145:			traveltime = BotClientTravelTimeToGoal(i, goal);
ADDRLP4 268
INDIRI4
ARGI4
ADDRLP4 1300
INDIRP4
ARGP4
ADDRLP4 1336
ADDRGP4 BotClientTravelTimeToGoal
CALLI4
ASGNI4
ADDRLP4 272
ADDRLP4 1336
INDIRI4
ASGNI4
line 147
;146:			//
;147:			for (j = 0; j < numteammates; j++) {
ADDRLP4 260
CNSTI4 0
ASGNI4
ADDRGP4 $105
JUMPV
LABELV $102
line 148
;148:				if (traveltime < traveltimes[j]) {
ADDRLP4 272
INDIRI4
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
GEI4 $106
line 149
;149:					for (k = numteammates; k > j; k--) {
ADDRLP4 0
ADDRLP4 264
INDIRI4
ASGNI4
ADDRGP4 $111
JUMPV
LABELV $108
line 150
;150:						traveltimes[k] = traveltimes[k-1];
ADDRLP4 1340
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1340
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 1340
INDIRI4
ADDRLP4 4-4
ADDP4
INDIRI4
ASGNI4
line 151
;151:						teammates[k] = teammates[k-1];
ADDRLP4 1344
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1348
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1344
INDIRI4
ADDRLP4 1348
INDIRP4
ADDP4
ADDRLP4 1344
INDIRI4
CNSTI4 4
SUBI4
ADDRLP4 1348
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 152
;152:					}
LABELV $109
line 149
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $111
ADDRLP4 0
INDIRI4
ADDRLP4 260
INDIRI4
GTI4 $108
line 153
;153:					break;
ADDRGP4 $104
JUMPV
LABELV $106
line 155
;154:				}
;155:			}
LABELV $103
line 147
ADDRLP4 260
ADDRLP4 260
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $105
ADDRLP4 260
INDIRI4
ADDRLP4 264
INDIRI4
LTI4 $102
LABELV $104
line 156
;156:			traveltimes[j] = traveltime;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 272
INDIRI4
ASGNI4
line 157
;157:			teammates[j] = i;
ADDRLP4 260
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 158
;158:			numteammates++;
ADDRLP4 264
ADDRLP4 264
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 159
;159:			if (numteammates >= maxteammates) break;
ADDRLP4 264
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $113
ADDRGP4 $93
JUMPV
LABELV $113
line 160
;160:		}
LABELV $100
line 161
;161:	}
LABELV $92
line 136
ADDRLP4 268
ADDRLP4 268
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $94
ADDRLP4 268
INDIRI4
ADDRGP4 $83
INDIRI4
GEI4 $115
ADDRLP4 268
INDIRI4
CNSTI4 64
LTI4 $91
LABELV $115
LABELV $93
line 162
;162:	return numteammates;
ADDRLP4 264
INDIRI4
RETI4
LABELV $82
endproc BotSortTeamMatesByBaseTravelTime 1352 12
export BotSetTeamMateTaskPreference
proc BotSetTeamMateTaskPreference 36 12
line 170
;163:}
;164:
;165:/*
;166:==================
;167:BotSetTeamMateTaskPreference
;168:==================
;169:*/
;170:void BotSetTeamMateTaskPreference(bot_state_t *bs, int teammate, int preference) {
line 173
;171:	char teammatename[MAX_NETNAME];
;172:
;173:	ctftaskpreferences[teammate].preference = preference;
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 174
;174:	ClientName(teammate, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 175
;175:	strcpy(ctftaskpreferences[teammate].name, teammatename);
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 176
;176:}
LABELV $116
endproc BotSetTeamMateTaskPreference 36 12
export BotGetTeamMateTaskPreference
proc BotGetTeamMateTaskPreference 40 12
line 183
;177:
;178:/*
;179:==================
;180:BotGetTeamMateTaskPreference
;181:==================
;182:*/
;183:int BotGetTeamMateTaskPreference(bot_state_t *bs, int teammate) {
line 186
;184:	char teammatename[MAX_NETNAME];
;185:
;186:	if (!ctftaskpreferences[teammate].preference) return 0;
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $119
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $119
line 187
;187:	ClientName(teammate, teammatename, sizeof(teammatename));
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 188
;188:	if (Q_stricmp(teammatename, ctftaskpreferences[teammate].name)) return 0;
ADDRLP4 0
ARGP4
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $122
CNSTI4 0
RETI4
ADDRGP4 $118
JUMPV
LABELV $122
line 189
;189:	return ctftaskpreferences[teammate].preference;
CNSTI4 40
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 ctftaskpreferences+36
ADDP4
INDIRI4
RETI4
LABELV $118
endproc BotGetTeamMateTaskPreference 40 12
export BotSortTeamMatesByTaskPreference
proc BotSortTeamMatesByTaskPreference 804 12
line 197
;190:}
;191:
;192:/*
;193:==================
;194:BotSortTeamMatesByTaskPreference
;195:==================
;196:*/
;197:int BotSortTeamMatesByTaskPreference(bot_state_t *bs, int *teammates, int numteammates) {
line 203
;198:	int defenders[MAX_CLIENTS], numdefenders;
;199:	int attackers[MAX_CLIENTS], numattackers;
;200:	int roamers[MAX_CLIENTS], numroamers;
;201:	int i, preference;
;202:
;203:	numdefenders = numattackers = numroamers = 0;
ADDRLP4 788
CNSTI4 0
ASGNI4
ADDRLP4 272
ADDRLP4 788
INDIRI4
ASGNI4
ADDRLP4 268
ADDRLP4 788
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 788
INDIRI4
ASGNI4
line 204
;204:	for (i = 0; i < numteammates; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $129
JUMPV
LABELV $126
line 205
;205:		preference = BotGetTeamMateTaskPreference(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 792
ADDRGP4 BotGetTeamMateTaskPreference
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 792
INDIRI4
ASGNI4
line 206
;206:		if (preference & TEAMTP_DEFENDER) {
ADDRLP4 4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $130
line 207
;207:			defenders[numdefenders++] = teammates[i];
ADDRLP4 796
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRLP4 796
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 208
;208:		}
ADDRGP4 $131
JUMPV
LABELV $130
line 209
;209:		else if (preference & TEAMTP_ATTACKER) {
ADDRLP4 4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $132
line 210
;210:			attackers[numattackers++] = teammates[i];
ADDRLP4 796
ADDRLP4 268
INDIRI4
ASGNI4
ADDRLP4 268
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRLP4 796
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRLP4 276
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 211
;211:		}
ADDRGP4 $133
JUMPV
LABELV $132
line 212
;212:		else {
line 213
;213:			roamers[numroamers++] = teammates[i];
ADDRLP4 796
ADDRLP4 272
INDIRI4
ASGNI4
ADDRLP4 272
ADDRLP4 796
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRLP4 796
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRLP4 532
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ASGNI4
line 214
;214:		}
LABELV $133
LABELV $131
line 215
;215:	}
LABELV $127
line 204
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $129
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $126
line 216
;216:	numteammates = 0;
ADDRFP4 8
CNSTI4 0
ASGNI4
line 218
;217:	//defenders at the front of the list
;218:	memcpy(&teammates[numteammates], defenders, numdefenders * sizeof(int));
ADDRLP4 792
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 792
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 8
INDIRI4
CVIU4 4
ADDRLP4 792
INDIRI4
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 219
;219:	numteammates += numdefenders;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 221
;220:	//roamers in the middle
;221:	memcpy(&teammates[numteammates], roamers, numroamers * sizeof(int));
ADDRLP4 796
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 796
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 532
ARGP4
ADDRLP4 272
INDIRI4
CVIU4 4
ADDRLP4 796
INDIRI4
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 222
;222:	numteammates += numroamers;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 272
INDIRI4
ADDI4
ASGNI4
line 224
;223:	//attacker in the back of the list
;224:	memcpy(&teammates[numteammates], attackers, numattackers * sizeof(int));
ADDRLP4 800
CNSTI4 2
ASGNI4
ADDRFP4 8
INDIRI4
ADDRLP4 800
INDIRI4
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
ARGP4
ADDRLP4 276
ARGP4
ADDRLP4 268
INDIRI4
CVIU4 4
ADDRLP4 800
INDIRI4
LSHU4
CVUI4 4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 225
;225:	numteammates += numattackers;
ADDRFP4 8
ADDRFP4 8
INDIRI4
ADDRLP4 268
INDIRI4
ADDI4
ASGNI4
line 227
;226:
;227:	return numteammates;
ADDRFP4 8
INDIRI4
RETI4
LABELV $125
endproc BotSortTeamMatesByTaskPreference 804 12
export BotSayTeamOrderAlways
proc BotSayTeamOrderAlways 548 20
line 235
;228:}
;229:
;230:/*
;231:==================
;232:BotSayTeamOrders
;233:==================
;234:*/
;235:void BotSayTeamOrderAlways(bot_state_t *bs, int toclient) {
line 241
;236:	char teamchat[MAX_MESSAGE_SIZE];
;237:	char buf[MAX_MESSAGE_SIZE];
;238:	char name[MAX_NETNAME];
;239:
;240:	//if the bot is talking to itself
;241:	if (bs->client == toclient) {
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $135
line 243
;242:		//don't show the message just put it in the console message queue
;243:		trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRLP4 256
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_BotGetChatMessage
CALLV
pop
line 244
;244:		ClientName(bs->client, name, sizeof(name));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 512
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 245
;245:		Com_sprintf(teamchat, sizeof(teamchat), EC"(%s"EC")"EC": %s", name, buf);
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $137
ARGP4
ADDRLP4 512
ARGP4
ADDRLP4 256
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 246
;246:		trap_BotQueueConsoleMessage(bs->cs, CMS_CHAT, teamchat);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_BotQueueConsoleMessage
CALLV
pop
line 247
;247:	}
ADDRGP4 $136
JUMPV
LABELV $135
line 248
;248:	else {
line 249
;249:		trap_BotEnterChat(bs->cs, toclient, CHAT_TELL);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 250
;250:	}
LABELV $136
line 251
;251:}
LABELV $134
endproc BotSayTeamOrderAlways 548 20
export BotSayTeamOrder
proc BotSayTeamOrder 0 8
line 258
;252:
;253:/*
;254:==================
;255:BotSayTeamOrders
;256:==================
;257:*/
;258:void BotSayTeamOrder(bot_state_t *bs, int toclient) {
line 265
;259:#ifdef MISSIONPACK
;260:	// voice chats only
;261:	char buf[MAX_MESSAGE_SIZE];
;262:
;263:	trap_BotGetChatMessage(bs->cs, buf, sizeof(buf));
;264:#else
;265:	BotSayTeamOrderAlways(bs, toclient);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrderAlways
CALLV
pop
line 267
;266:#endif
;267:}
LABELV $138
endproc BotSayTeamOrder 0 8
export BotVoiceChat
proc BotVoiceChat 0 0
line 274
;268:
;269:/*
;270:==================
;271:BotVoiceChat
;272:==================
;273:*/
;274:void BotVoiceChat(bot_state_t *bs, int toclient, char *voicechat) {
line 283
;275:#ifdef MISSIONPACK
;276:	if (toclient == -1)
;277:		// voice only say team
;278:		trap_EA_Command(bs->client, va("vsay_team %s", voicechat));
;279:	else
;280:		// voice only tell single player
;281:		trap_EA_Command(bs->client, va("vtell %d %s", toclient, voicechat));
;282:#endif
;283:}
LABELV $139
endproc BotVoiceChat 0 0
export BotVoiceChatOnly
proc BotVoiceChatOnly 0 0
line 290
;284:
;285:/*
;286:==================
;287:BotVoiceChatOnly
;288:==================
;289:*/
;290:void BotVoiceChatOnly(bot_state_t *bs, int toclient, char *voicechat) {
line 299
;291:#ifdef MISSIONPACK
;292:	if (toclient == -1)
;293:		// voice only say team
;294:		trap_EA_Command(bs->client, va("vosay_team %s", voicechat));
;295:	else
;296:		// voice only tell single player
;297:		trap_EA_Command(bs->client, va("votell %d %s", toclient, voicechat));
;298:#endif
;299:}
LABELV $140
endproc BotVoiceChatOnly 0 0
export BotSayVoiceTeamOrder
proc BotSayVoiceTeamOrder 0 0
line 306
;300:
;301:/*
;302:==================
;303:BotSayVoiceTeamOrder
;304:==================
;305:*/
;306:void BotSayVoiceTeamOrder(bot_state_t *bs, int toclient, char *voicechat) {
line 310
;307:#ifdef MISSIONPACK
;308:	BotVoiceChat(bs, toclient, voicechat);
;309:#endif
;310:}
LABELV $141
endproc BotSayVoiceTeamOrder 0 0
export BotCTFOrders_BothFlagsNotAtBase
proc BotCTFOrders_BothFlagsNotAtBase 368 20
line 317
;311:
;312:/*
;313:==================
;314:BotCTFOrders
;315:==================
;316:*/
;317:void BotCTFOrders_BothFlagsNotAtBase(bot_state_t *bs) {
line 322
;318:	int numteammates, defenders, attackers, i, other;
;319:	int teammates[MAX_CLIENTS];
;320:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;321:
;322:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 348
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 348
INDIRI4
ASGNI4
line 323
;323:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 325
;324:	//different orders based on the number of team mates
;325:	switch(bs->numteammates) {
ADDRLP4 352
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 352
INDIRI4
CNSTI4 1
EQI4 $144
ADDRLP4 352
INDIRI4
CNSTI4 2
EQI4 $147
ADDRLP4 352
INDIRI4
CNSTI4 3
EQI4 $153
ADDRGP4 $143
JUMPV
line 326
;326:		case 1: break;
LABELV $147
line 328
;327:		case 2:
;328:		{
line 330
;329:			//tell the one not carrying the flag to attack the enemy base
;330:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
EQI4 $148
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $149
JUMPV
LABELV $148
line 331
;331:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $149
line 332
;332:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 333
;333:			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 334
;334:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 335
;335:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 336
;336:			break;
ADDRGP4 $144
JUMPV
LABELV $153
line 339
;337:		}
;338:		case 3:
;339:		{
line 341
;340:			//tell the one closest to the base not carrying the flag to accompany the flag carrier
;341:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
EQI4 $154
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $155
JUMPV
LABELV $154
line 342
;342:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $155
line 343
;343:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 344
;344:			if ( bs->flagcarrier != -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $157
line 345
;345:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 346
;346:				if (bs->flagcarrier == bs->client) {
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ADDRLP4 360
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $159
line 347
;347:					BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $161
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 348
;348:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $162
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 349
;349:				}
ADDRGP4 $158
JUMPV
LABELV $159
line 350
;350:				else {
line 351
;351:					BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 352
;352:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $164
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 353
;353:				}
line 354
;354:			}
ADDRGP4 $158
JUMPV
LABELV $157
line 355
;355:			else {
line 357
;356:				//
;357:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 358
;358:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 359
;359:			}
LABELV $158
line 360
;360:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 362
;361:			//tell the one furthest from the the base not carrying the flag to get the enemy flag
;362:			if (teammates[2] != bs->flagcarrier) other = teammates[2];
ADDRLP4 4+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
EQI4 $165
ADDRLP4 308
ADDRLP4 4+8
INDIRI4
ASGNI4
ADDRGP4 $166
JUMPV
LABELV $165
line 363
;363:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $166
line 364
;364:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 365
;365:			BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 366
;366:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 367
;367:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_RETURNFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $170
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 368
;368:			break;
ADDRGP4 $144
JUMPV
LABELV $143
line 371
;369:		}
;370:		default:
;371:		{
line 372
;372:			defenders = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 300
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 373
;373:			if (defenders > 4) defenders = 4;
ADDRLP4 300
INDIRI4
CNSTI4 4
LEI4 $171
ADDRLP4 300
CNSTI4 4
ASGNI4
LABELV $171
line 374
;374:			attackers = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 360
CNSTF4 1056964608
ASGNF4
ADDRLP4 304
ADDRLP4 360
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 360
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 375
;375:			if (attackers > 5) attackers = 5;
ADDRLP4 304
INDIRI4
CNSTI4 5
LEI4 $173
ADDRLP4 304
CNSTI4 5
ASGNI4
LABELV $173
line 376
;376:			if (bs->flagcarrier != -1) {
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $175
line 377
;377:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 378
;378:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $180
JUMPV
LABELV $177
line 380
;379:					//
;380:					if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $181
line 381
;381:						continue;
ADDRGP4 $178
JUMPV
LABELV $181
line 384
;382:					}
;383:					//
;384:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 385
;385:					if (bs->flagcarrier == bs->client) {
ADDRLP4 364
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 364
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ADDRLP4 364
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $183
line 386
;386:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $161
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 387
;387:						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $162
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 388
;388:					}
ADDRGP4 $184
JUMPV
LABELV $183
line 389
;389:					else {
line 390
;390:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 260
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 391
;391:						BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $164
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 392
;392:					}
LABELV $184
line 393
;393:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 394
;394:				}
LABELV $178
line 378
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $180
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $177
line 395
;395:			}
ADDRGP4 $176
JUMPV
LABELV $175
line 396
;396:			else {
line 397
;397:				for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $188
JUMPV
LABELV $185
line 399
;398:					//
;399:					if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $189
line 400
;400:						continue;
ADDRGP4 $186
JUMPV
LABELV $189
line 403
;401:					}
;402:					//
;403:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 404
;404:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 405
;405:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 406
;406:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 407
;407:				}
LABELV $186
line 397
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $188
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $185
line 408
;408:			}
LABELV $176
line 409
;409:			for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $194
JUMPV
LABELV $191
line 411
;410:				//
;411:				if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $195
line 412
;412:					continue;
ADDRGP4 $192
JUMPV
LABELV $195
line 415
;413:				}
;414:				//
;415:				ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 416
;416:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 417
;417:				BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 418
;418:				BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_RETURNFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $170
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 419
;419:			}
LABELV $192
line 409
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $194
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $191
line 421
;420:			//
;421:			break;
LABELV $144
line 424
;422:		}
;423:	}
;424:}
LABELV $142
endproc BotCTFOrders_BothFlagsNotAtBase 368 20
export BotCTFOrders_FlagNotAtBase
proc BotCTFOrders_FlagNotAtBase 320 16
line 431
;425:
;426:/*
;427:==================
;428:BotCTFOrders
;429:==================
;430:*/
;431:void BotCTFOrders_FlagNotAtBase(bot_state_t *bs) {
line 436
;432:	int numteammates, defenders, attackers, i;
;433:	int teammates[MAX_CLIENTS];
;434:	char name[MAX_NETNAME];
;435:
;436:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 437
;437:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 439
;438:	//passive strategy
;439:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $202
line 441
;440:		//different orders based on the number of team mates
;441:		switch(bs->numteammates) {
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $203
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $208
ADDRLP4 312
INDIRI4
CNSTI4 3
EQI4 $213
ADDRGP4 $204
JUMPV
line 442
;442:			case 1: break;
LABELV $208
line 444
;443:			case 2:
;444:			{
line 446
;445:				//both will go for the enemy flag
;446:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 447
;447:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 448
;448:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 449
;449:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 451
;450:				//
;451:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 452
;452:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 453
;453:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 454
;454:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 455
;455:				break;
ADDRGP4 $203
JUMPV
LABELV $213
line 458
;456:			}
;457:			case 3:
;458:			{
line 460
;459:				//keep one near the base for when the flag is returned
;460:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 461
;461:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 462
;462:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 463
;463:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 465
;464:				//the other two get the flag
;465:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 466
;466:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 467
;467:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 468
;468:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 470
;469:				//
;470:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 471
;471:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 472
;472:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 473
;473:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 474
;474:				break;
ADDRGP4 $203
JUMPV
LABELV $204
line 477
;475:			}
;476:			default:
;477:			{
line 479
;478:				//keep some people near the base for when the flag is returned
;479:				defenders = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 300
CNSTF4 1050253722
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 480
;480:				if (defenders > 3) defenders = 3;
ADDRLP4 300
INDIRI4
CNSTI4 3
LEI4 $221
ADDRLP4 300
CNSTI4 3
ASGNI4
LABELV $221
line 481
;481:				attackers = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 304
CNSTF4 1060320051
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 482
;482:				if (attackers > 6) attackers = 6;
ADDRLP4 304
INDIRI4
CNSTI4 6
LEI4 $223
ADDRLP4 304
CNSTI4 6
ASGNI4
LABELV $223
line 483
;483:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $228
JUMPV
LABELV $225
line 485
;484:					//
;485:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 486
;486:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 487
;487:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 488
;488:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 489
;489:				}
LABELV $226
line 483
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $228
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $225
line 490
;490:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $232
JUMPV
LABELV $229
line 492
;491:					//
;492:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 493
;493:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 494
;494:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 495
;495:					BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 496
;496:				}
LABELV $230
line 490
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $232
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $229
line 498
;497:				//
;498:				break;
line 501
;499:			}
;500:		}
;501:	}
ADDRGP4 $203
JUMPV
LABELV $202
line 502
;502:	else {
line 504
;503:		//different orders based on the number of team mates
;504:		switch(bs->numteammates) {
ADDRLP4 312
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
INDIRI4
ASGNI4
ADDRLP4 312
INDIRI4
CNSTI4 1
EQI4 $236
ADDRLP4 312
INDIRI4
CNSTI4 2
EQI4 $239
ADDRLP4 312
INDIRI4
CNSTI4 3
EQI4 $243
ADDRGP4 $235
JUMPV
line 505
;505:			case 1: break;
LABELV $239
line 507
;506:			case 2:
;507:			{
line 509
;508:				//both will go for the enemy flag
;509:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 510
;510:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 511
;511:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 512
;512:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 514
;513:				//
;514:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 515
;515:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 516
;516:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 517
;517:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 518
;518:				break;
ADDRGP4 $236
JUMPV
LABELV $243
line 521
;519:			}
;520:			case 3:
;521:			{
line 523
;522:				//everyone go for the flag
;523:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 524
;524:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 525
;525:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 526
;526:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 528
;527:				//
;528:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 529
;529:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 530
;530:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 531
;531:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 533
;532:				//
;533:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 534
;534:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 535
;535:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 536
;536:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 537
;537:				break;
ADDRGP4 $236
JUMPV
LABELV $235
line 540
;538:			}
;539:			default:
;540:			{
line 542
;541:				//keep some people near the base for when the flag is returned
;542:				defenders = (int) (float) numteammates * 0.2 + 0.5;
ADDRLP4 300
CNSTF4 1045220557
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 543
;543:				if (defenders > 2) defenders = 2;
ADDRLP4 300
INDIRI4
CNSTI4 2
LEI4 $250
ADDRLP4 300
CNSTI4 2
ASGNI4
LABELV $250
line 544
;544:				attackers = (int) (float) numteammates * 0.7 + 0.5;
ADDRLP4 304
CNSTF4 1060320051
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 545
;545:				if (attackers > 7) attackers = 7;
ADDRLP4 304
INDIRI4
CNSTI4 7
LEI4 $252
ADDRLP4 304
CNSTI4 7
ASGNI4
LABELV $252
line 546
;546:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $257
JUMPV
LABELV $254
line 548
;547:					//
;548:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 549
;549:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 550
;550:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 551
;551:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 552
;552:				}
LABELV $255
line 546
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $257
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $254
line 553
;553:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $261
JUMPV
LABELV $258
line 555
;554:					//
;555:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 556
;556:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 557
;557:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 558
;558:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 559
;559:				}
LABELV $259
line 553
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $261
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $258
line 561
;560:				//
;561:				break;
LABELV $236
line 564
;562:			}
;563:		}
;564:	}
LABELV $203
line 565
;565:}
LABELV $201
endproc BotCTFOrders_FlagNotAtBase 320 16
export BotCTFOrders_EnemyFlagNotAtBase
proc BotCTFOrders_EnemyFlagNotAtBase 360 20
line 572
;566:
;567:/*
;568:==================
;569:BotCTFOrders
;570:==================
;571:*/
;572:void BotCTFOrders_EnemyFlagNotAtBase(bot_state_t *bs) {
line 577
;573:	int numteammates, defenders, attackers, i, other;
;574:	int teammates[MAX_CLIENTS];
;575:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;576:
;577:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 348
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 260
ADDRLP4 348
INDIRI4
ASGNI4
line 578
;578:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 260
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 580
;579:	//different orders based on the number of team mates
;580:	switch(numteammates) {
ADDRLP4 260
INDIRI4
CNSTI4 1
EQI4 $267
ADDRLP4 260
INDIRI4
CNSTI4 2
EQI4 $269
ADDRLP4 260
INDIRI4
CNSTI4 3
EQI4 $273
ADDRGP4 $266
JUMPV
line 581
;581:		case 1: break;
LABELV $269
line 583
;582:		case 2:
;583:		{
line 585
;584:			//tell the one not carrying the flag to defend the base
;585:			if (teammates[0] == bs->flagcarrier) other = teammates[1];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $270
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
ADDRGP4 $271
JUMPV
LABELV $270
line 586
;586:			else other = teammates[0];
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $271
line 587
;587:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 588
;588:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 589
;589:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 590
;590:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 591
;591:			break;
ADDRGP4 $267
JUMPV
LABELV $273
line 594
;592:		}
;593:		case 3:
;594:		{
line 596
;595:			//tell the one closest to the base not carrying the flag to defend the base
;596:			if (teammates[0] != bs->flagcarrier) other = teammates[0];
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
EQI4 $274
ADDRLP4 308
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $275
JUMPV
LABELV $274
line 597
;597:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $275
line 598
;598:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 599
;599:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 600
;600:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 601
;601:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 603
;602:			//tell the other also to defend the base
;603:			if (teammates[2] != bs->flagcarrier) other = teammates[2];
ADDRLP4 4+8
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
EQI4 $277
ADDRLP4 308
ADDRLP4 4+8
INDIRI4
ASGNI4
ADDRGP4 $278
JUMPV
LABELV $277
line 604
;604:			else other = teammates[1];
ADDRLP4 308
ADDRLP4 4+4
INDIRI4
ASGNI4
LABELV $278
line 605
;605:			ClientName(other, name, sizeof(name));
ADDRLP4 308
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 606
;606:			BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 607
;607:			BotSayTeamOrder(bs, other);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 608
;608:			BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 308
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 609
;609:			break;
ADDRGP4 $267
JUMPV
LABELV $266
line 612
;610:		}
;611:		default:
;612:		{
line 614
;613:			//60% will defend the base
;614:			defenders = (int) (float) numteammates * 0.6 + 0.5;
ADDRLP4 300
CNSTF4 1058642330
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 615
;615:			if (defenders > 6) defenders = 6;
ADDRLP4 300
INDIRI4
CNSTI4 6
LEI4 $282
ADDRLP4 300
CNSTI4 6
ASGNI4
LABELV $282
line 617
;616:			//30% accompanies the flag carrier
;617:			attackers = (int) (float) numteammates * 0.3 + 0.5;
ADDRLP4 304
CNSTF4 1050253722
ADDRLP4 260
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 618
;618:			if (attackers > 3) attackers = 3;
ADDRLP4 304
INDIRI4
CNSTI4 3
LEI4 $284
ADDRLP4 304
CNSTI4 3
ASGNI4
LABELV $284
line 619
;619:			for (i = 0; i < defenders; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $289
JUMPV
LABELV $286
line 621
;620:				//
;621:				if (teammates[i] == bs->flagcarrier) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $290
line 622
;622:					continue;
ADDRGP4 $287
JUMPV
LABELV $290
line 624
;623:				}
;624:				ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 625
;625:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 626
;626:				BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 627
;627:				BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 628
;628:			}
LABELV $287
line 619
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $289
ADDRLP4 0
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $286
line 630
;629:			// if we have a flag carrier
;630:			if ( bs->flagcarrier != -1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $292
line 631
;631:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ARGI4
ADDRLP4 312
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 632
;632:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $297
JUMPV
LABELV $294
line 634
;633:					//
;634:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $298
line 635
;635:						continue;
ADDRGP4 $295
JUMPV
LABELV $298
line 638
;636:					}
;637:					//
;638:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 639
;639:					if (bs->flagcarrier == bs->client) {
ADDRLP4 356
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
ADDRLP4 356
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $302
line 640
;640:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $161
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 641
;641:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $162
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 642
;642:					}
ADDRGP4 $303
JUMPV
LABELV $302
line 643
;643:					else {
line 644
;644:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 264
ARGP4
ADDRLP4 312
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 645
;645:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $164
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 646
;646:					}
LABELV $303
line 647
;647:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 648
;648:				}
LABELV $295
line 632
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $297
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $294
line 649
;649:			}
ADDRGP4 $267
JUMPV
LABELV $292
line 650
;650:			else {
line 651
;651:				for (i = 0; i < attackers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $310
JUMPV
LABELV $307
line 653
;652:					//
;653:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 6972
ADDP4
INDIRI4
NEI4 $311
line 654
;654:						continue;
ADDRGP4 $308
JUMPV
LABELV $311
line 657
;655:					}
;656:					//
;657:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 264
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 658
;658:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 264
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 659
;659:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 660
;660:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 260
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 4-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 661
;661:				}
LABELV $308
line 651
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $310
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $307
line 662
;662:			}
line 664
;663:			//
;664:			break;
LABELV $267
line 667
;665:		}
;666:	}
;667:}
LABELV $265
endproc BotCTFOrders_EnemyFlagNotAtBase 360 20
export BotCTFOrders_BothFlagsAtBase
proc BotCTFOrders_BothFlagsAtBase 320 16
line 675
;668:
;669:
;670:/*
;671:==================
;672:BotCTFOrders
;673:==================
;674:*/
;675:void BotCTFOrders_BothFlagsAtBase(bot_state_t *bs) {
line 681
;676:	int numteammates, defenders, attackers, i;
;677:	int teammates[MAX_CLIENTS];
;678:	char name[MAX_NETNAME];
;679:
;680:	//sort team mates by travel time to base
;681:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRLP4 308
ADDRGP4 BotSortTeamMatesByBaseTravelTime
CALLI4
ASGNI4
ADDRLP4 296
ADDRLP4 308
INDIRI4
ASGNI4
line 683
;682:	//sort team mates by CTF preference
;683:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRGP4 BotSortTeamMatesByTaskPreference
CALLI4
pop
line 685
;684:	//passive strategy
;685:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $318
line 687
;686:		//different orders based on the number of team mates
;687:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $319
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $323
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $327
ADDRGP4 $320
JUMPV
line 688
;688:			case 1: break;
LABELV $323
line 690
;689:			case 2:
;690:			{
line 692
;691:				//the one closest to the base will defend the base
;692:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 693
;693:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 694
;694:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 695
;695:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 697
;696:				//the other will get the flag
;697:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 698
;698:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 699
;699:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 700
;700:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 701
;701:				break;
ADDRGP4 $319
JUMPV
LABELV $327
line 704
;702:			}
;703:			case 3:
;704:			{
line 706
;705:				//the one closest to the base will defend the base
;706:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 707
;707:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 708
;708:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 709
;709:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 711
;710:				//the second one closest to the base will defend the base
;711:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 712
;712:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 713
;713:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 714
;714:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 716
;715:				//the other will get the flag
;716:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 717
;717:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 718
;718:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 719
;719:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 720
;720:				break;
ADDRGP4 $319
JUMPV
LABELV $320
line 723
;721:			}
;722:			default:
;723:			{
line 724
;724:				defenders = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 316
CNSTF4 1056964608
ASGNF4
ADDRLP4 300
ADDRLP4 316
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 316
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 725
;725:				if (defenders > 5) defenders = 5;
ADDRLP4 300
INDIRI4
CNSTI4 5
LEI4 $334
ADDRLP4 300
CNSTI4 5
ASGNI4
LABELV $334
line 726
;726:				attackers = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 304
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 727
;727:				if (attackers > 4) attackers = 4;
ADDRLP4 304
INDIRI4
CNSTI4 4
LEI4 $336
ADDRLP4 304
CNSTI4 4
ASGNI4
LABELV $336
line 728
;728:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $341
JUMPV
LABELV $338
line 730
;729:					//
;730:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 731
;731:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 732
;732:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 733
;733:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 734
;734:				}
LABELV $339
line 728
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $341
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $338
line 735
;735:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $345
JUMPV
LABELV $342
line 737
;736:					//
;737:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 738
;738:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 739
;739:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 740
;740:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 741
;741:				}
LABELV $343
line 735
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $345
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $342
line 743
;742:				//
;743:				break;
line 746
;744:			}
;745:		}
;746:	}
ADDRGP4 $319
JUMPV
LABELV $318
line 747
;747:	else {
line 749
;748:		//different orders based on the number of team mates
;749:		switch(numteammates) {
ADDRLP4 296
INDIRI4
CNSTI4 1
EQI4 $350
ADDRLP4 296
INDIRI4
CNSTI4 2
EQI4 $352
ADDRLP4 296
INDIRI4
CNSTI4 3
EQI4 $356
ADDRGP4 $349
JUMPV
line 750
;750:			case 1: break;
LABELV $352
line 752
;751:			case 2:
;752:			{
line 754
;753:				//the one closest to the base will defend the base
;754:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 755
;755:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 756
;756:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 757
;757:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 759
;758:				//the other will get the flag
;759:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 760
;760:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 761
;761:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 762
;762:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 763
;763:				break;
ADDRGP4 $350
JUMPV
LABELV $356
line 766
;764:			}
;765:			case 3:
;766:			{
line 768
;767:				//the one closest to the base will defend the base
;768:				ClientName(teammates[0], name, sizeof(name));
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 769
;769:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 770
;770:				BotSayTeamOrder(bs, teammates[0]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 771
;771:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 773
;772:				//the others should go for the enemy flag
;773:				ClientName(teammates[1], name, sizeof(name));
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 774
;774:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 775
;775:				BotSayTeamOrder(bs, teammates[1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 776
;776:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 778
;777:				//
;778:				ClientName(teammates[2], name, sizeof(name));
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 779
;779:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 780
;780:				BotSayTeamOrder(bs, teammates[2]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 781
;781:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 782
;782:				break;
ADDRGP4 $350
JUMPV
LABELV $349
line 785
;783:			}
;784:			default:
;785:			{
line 786
;786:				defenders = (int) (float) numteammates * 0.4 + 0.5;
ADDRLP4 300
CNSTF4 1053609165
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
CNSTF4 1056964608
ADDF4
CVFI4 4
ASGNI4
line 787
;787:				if (defenders > 4) defenders = 4;
ADDRLP4 300
INDIRI4
CNSTI4 4
LEI4 $363
ADDRLP4 300
CNSTI4 4
ASGNI4
LABELV $363
line 788
;788:				attackers = (int) (float) numteammates * 0.5 + 0.5;
ADDRLP4 316
CNSTF4 1056964608
ASGNF4
ADDRLP4 304
ADDRLP4 316
INDIRF4
ADDRLP4 296
INDIRI4
CVIF4 4
CVFI4 4
CVIF4 4
MULF4
ADDRLP4 316
INDIRF4
ADDF4
CVFI4 4
ASGNI4
line 789
;789:				if (attackers > 5) attackers = 5;
ADDRLP4 304
INDIRI4
CNSTI4 5
LEI4 $365
ADDRLP4 304
CNSTI4 5
ASGNI4
LABELV $365
line 790
;790:				for (i = 0; i < defenders; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $370
JUMPV
LABELV $367
line 792
;791:					//
;792:					ClientName(teammates[i], name, sizeof(name));
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 793
;793:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $209
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 794
;794:					BotSayTeamOrder(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 795
;795:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
ADDP4
INDIRI4
ARGI4
ADDRGP4 $214
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 796
;796:				}
LABELV $368
line 790
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $370
ADDRLP4 256
INDIRI4
ADDRLP4 300
INDIRI4
LTI4 $367
line 797
;797:				for (i = 0; i < attackers; i++) {
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRGP4 $374
JUMPV
LABELV $371
line 799
;798:					//
;799:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRLP4 260
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 800
;800:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $151
ARGP4
ADDRLP4 260
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 801
;801:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrder
CALLV
pop
line 802
;802:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ADDRLP4 256
INDIRI4
SUBI4
CNSTI4 2
LSHI4
ADDRLP4 0-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 $152
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 803
;803:				}
LABELV $372
line 797
ADDRLP4 256
ADDRLP4 256
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $374
ADDRLP4 256
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $371
line 805
;804:				//
;805:				break;
LABELV $350
line 808
;806:			}
;807:		}
;808:	}
LABELV $319
line 809
;809:}
LABELV $317
endproc BotCTFOrders_BothFlagsAtBase 320 16
export BotCTFOrders
proc BotCTFOrders 20 4
line 816
;810:
;811:/*
;812:==================
;813:BotCTFOrders
;814:==================
;815:*/
;816:void BotCTFOrders(bot_state_t *bs) {
line 820
;817:	int flagstatus;
;818:
;819:	//
;820:	if (BotTeam(bs) == TEAM_RED) flagstatus = bs->redflagstatus * 2 + bs->blueflagstatus;
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $379
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
ADDI4
ASGNI4
ADDRGP4 $380
JUMPV
LABELV $379
line 821
;821:	else flagstatus = bs->blueflagstatus * 2 + bs->redflagstatus;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
CNSTI4 6956
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 6952
ADDP4
INDIRI4
ADDI4
ASGNI4
LABELV $380
line 823
;822:	//
;823:	switch(flagstatus) {
ADDRLP4 16
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $381
ADDRLP4 16
INDIRI4
CNSTI4 3
GTI4 $381
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $387
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $387
address $383
address $384
address $385
address $386
code
LABELV $383
line 824
;824:		case 0: BotCTFOrders_BothFlagsAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_BothFlagsAtBase
CALLV
pop
ADDRGP4 $382
JUMPV
LABELV $384
line 825
;825:		case 1: BotCTFOrders_EnemyFlagNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_EnemyFlagNotAtBase
CALLV
pop
ADDRGP4 $382
JUMPV
LABELV $385
line 826
;826:		case 2: BotCTFOrders_FlagNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_FlagNotAtBase
CALLV
pop
ADDRGP4 $382
JUMPV
LABELV $386
line 827
;827:		case 3: BotCTFOrders_BothFlagsNotAtBase(bs); break;
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders_BothFlagsNotAtBase
CALLV
pop
LABELV $381
LABELV $382
line 829
;828:	}
;829:}
LABELV $378
endproc BotCTFOrders 20 4
export BotCreateGroup
proc BotCreateGroup 76 20
line 837
;830:
;831:
;832:/*
;833:==================
;834:BotCreateGroup
;835:==================
;836:*/
;837:void BotCreateGroup(bot_state_t *bs, int *teammates, int groupsize) {
line 842
;838:	char name[MAX_NETNAME], leadername[MAX_NETNAME];
;839:	int i;
;840:
;841:	// the others in the group will follow the teammates[0]
;842:	ClientName(teammates[0], leadername, sizeof(leadername));
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 40
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 843
;843:	for (i = 1; i < groupsize; i++)
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $392
JUMPV
LABELV $389
line 844
;844:	{
line 845
;845:		ClientName(teammates[i], name, sizeof(name));
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 846
;846:		if (teammates[0] == bs->client) {
ADDRFP4 4
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $393
line 847
;847:			BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $161
ARGP4
ADDRLP4 4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 848
;848:		}
ADDRGP4 $394
JUMPV
LABELV $393
line 849
;849:		else {
line 850
;850:			BotAI_BotInitialChat(bs, "cmd_accompany", name, leadername, NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $163
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 40
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 851
;851:		}
LABELV $394
line 852
;852:		BotSayTeamOrderAlways(bs, teammates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotSayTeamOrderAlways
CALLV
pop
line 853
;853:	}
LABELV $390
line 843
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $392
ADDRLP4 0
INDIRI4
ADDRFP4 8
INDIRI4
LTI4 $389
line 854
;854:}
LABELV $388
endproc BotCreateGroup 76 20
bss
align 4
LABELV $396
skip 4
export BotTeamOrders
code
proc BotTeamOrders 1316 12
line 863
;855:
;856:/*
;857:==================
;858:BotTeamOrders
;859:
;860:  FIXME: defend key areas?
;861:==================
;862:*/
;863:void BotTeamOrders(bot_state_t *bs) {
line 869
;864:	int teammates[MAX_CLIENTS];
;865:	int numteammates, i;
;866:	char buf[MAX_INFO_STRING];
;867:	static int maxclients;
;868:
;869:	if (!maxclients)
ADDRGP4 $396
INDIRI4
CNSTI4 0
NEI4 $397
line 870
;870:		maxclients = trap_Cvar_VariableIntegerValue("sv_maxclients");
ADDRGP4 $62
ARGP4
ADDRLP4 1288
ADDRGP4 trap_Cvar_VariableIntegerValue
CALLI4
ASGNI4
ADDRGP4 $396
ADDRLP4 1288
INDIRI4
ASGNI4
LABELV $397
line 872
;871:
;872:	numteammates = 0;
ADDRLP4 1028
CNSTI4 0
ASGNI4
line 873
;873:	for (i = 0; i < maxclients && i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $402
JUMPV
LABELV $399
line 874
;874:		trap_GetConfigstring(CS_PLAYERS+i, buf, sizeof(buf));
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigstring
CALLV
pop
line 876
;875:		//if no config string or no name
;876:		if (!strlen(buf) || !strlen(Info_ValueForKey(buf, "n"))) continue;
ADDRLP4 4
ARGP4
ADDRLP4 1292
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1292
INDIRI4
CNSTI4 0
EQI4 $405
ADDRLP4 4
ARGP4
ADDRGP4 $69
ARGP4
ADDRLP4 1296
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1296
INDIRP4
ARGP4
ADDRLP4 1300
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1300
INDIRI4
CNSTI4 0
NEI4 $403
LABELV $405
ADDRGP4 $400
JUMPV
LABELV $403
line 878
;877:		//skip spectators
;878:		if (atoi(Info_ValueForKey(buf, "t")) == TEAM_SPECTATOR) continue;
ADDRLP4 4
ARGP4
ADDRGP4 $73
ARGP4
ADDRLP4 1304
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1304
INDIRP4
ARGP4
ADDRLP4 1308
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1308
INDIRI4
CNSTI4 3
NEI4 $406
ADDRGP4 $400
JUMPV
LABELV $406
line 880
;879:		//
;880:		if (BotSameTeam(bs, i)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1312
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 1312
INDIRI4
CNSTI4 0
EQI4 $408
line 881
;881:			teammates[numteammates] = i;
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 1032
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 882
;882:			numteammates++;
ADDRLP4 1028
ADDRLP4 1028
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 883
;883:		}
LABELV $408
line 884
;884:	}
LABELV $400
line 873
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $402
ADDRLP4 0
INDIRI4
ADDRGP4 $396
INDIRI4
GEI4 $410
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $399
LABELV $410
line 886
;885:	//
;886:	switch(numteammates) {
ADDRLP4 1028
INDIRI4
CNSTI4 1
LTI4 $411
ADDRLP4 1028
INDIRI4
CNSTI4 5
GTI4 $411
ADDRLP4 1028
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $426-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $426
address $412
address $412
address $415
address $416
address $418
code
line 887
;887:		case 1: break;
line 889
;888:		case 2:
;889:		{
line 891
;890:			//nothing special
;891:			break;
LABELV $415
line 894
;892:		}
;893:		case 3:
;894:		{
line 896
;895:			//have one follow another and one free roaming
;896:			BotCreateGroup(bs, teammates, 2);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 897
;897:			break;
ADDRGP4 $412
JUMPV
LABELV $416
line 900
;898:		}
;899:		case 4:
;900:		{
line 901
;901:			BotCreateGroup(bs, teammates, 2);		//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 902
;902:			BotCreateGroup(bs, &teammates[2], 2);	//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032+8
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 903
;903:			break;
ADDRGP4 $412
JUMPV
LABELV $418
line 906
;904:		}
;905:		case 5:
;906:		{
line 907
;907:			BotCreateGroup(bs, teammates, 2);		//a group of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 908
;908:			BotCreateGroup(bs, &teammates[2], 3);	//a group of 3
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1032+8
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 909
;909:			break;
ADDRGP4 $412
JUMPV
LABELV $411
line 912
;910:		}
;911:		default:
;912:		{
line 913
;913:			if (numteammates <= 10) {
ADDRLP4 1028
INDIRI4
CNSTI4 10
GTI4 $412
line 914
;914:				for (i = 0; i < numteammates / 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $425
JUMPV
LABELV $422
line 915
;915:					BotCreateGroup(bs, &teammates[i*2], 2);	//groups of 2
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1300
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LSHI4
ADDRLP4 1300
INDIRI4
LSHI4
ADDRLP4 1032
ADDP4
ARGP4
ADDRLP4 1300
INDIRI4
ARGI4
ADDRGP4 BotCreateGroup
CALLV
pop
line 916
;916:				}
LABELV $423
line 914
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $425
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
CNSTI4 2
DIVI4
LTI4 $422
line 917
;917:			}
line 918
;918:			break;
LABELV $412
line 921
;919:		}
;920:	}
;921:}
LABELV $395
endproc BotTeamOrders 1316 12
export FindHumanTeamLeader
proc FindHumanTeamLeader 12 12
line 1883
;922:
;923:#ifdef MISSIONPACK
;924:
;925:/*
;926:==================
;927:Bot1FCTFOrders_FlagAtCenter
;928:
;929:  X% defend the base, Y% get the flag
;930:==================
;931:*/
;932:void Bot1FCTFOrders_FlagAtCenter(bot_state_t *bs) {
;933:	int numteammates, defenders, attackers, i;
;934:	int teammates[MAX_CLIENTS];
;935:	char name[MAX_NETNAME];
;936:
;937:	//sort team mates by travel time to base
;938:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;939:	//sort team mates by CTF preference
;940:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;941:	//passive strategy
;942:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;943:		//different orders based on the number of team mates
;944:		switch(numteammates) {
;945:			case 1: break;
;946:			case 2:
;947:			{
;948:				//the one closest to the base will defend the base
;949:				ClientName(teammates[0], name, sizeof(name));
;950:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;951:				BotSayTeamOrder(bs, teammates[0]);
;952:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;953:				//the other will get the flag
;954:				ClientName(teammates[1], name, sizeof(name));
;955:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;956:				BotSayTeamOrder(bs, teammates[1]);
;957:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;958:				break;
;959:			}
;960:			case 3:
;961:			{
;962:				//the one closest to the base will defend the base
;963:				ClientName(teammates[0], name, sizeof(name));
;964:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;965:				BotSayTeamOrder(bs, teammates[0]);
;966:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;967:				//the second one closest to the base will defend the base
;968:				ClientName(teammates[1], name, sizeof(name));
;969:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;970:				BotSayTeamOrder(bs, teammates[1]);
;971:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;972:				//the other will get the flag
;973:				ClientName(teammates[2], name, sizeof(name));
;974:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;975:				BotSayTeamOrder(bs, teammates[2]);
;976:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;977:				break;
;978:			}
;979:			default:
;980:			{
;981:				//50% defend the base
;982:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;983:				if (defenders > 5) defenders = 5;
;984:				//40% get the flag
;985:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;986:				if (attackers > 4) attackers = 4;
;987:				for (i = 0; i < defenders; i++) {
;988:					//
;989:					ClientName(teammates[i], name, sizeof(name));
;990:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;991:					BotSayTeamOrder(bs, teammates[i]);
;992:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;993:				}
;994:				for (i = 0; i < attackers; i++) {
;995:					//
;996:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;997:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;998:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;999:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1000:				}
;1001:				//
;1002:				break;
;1003:			}
;1004:		}
;1005:	}
;1006:	else { //agressive
;1007:		//different orders based on the number of team mates
;1008:		switch(numteammates) {
;1009:			case 1: break;
;1010:			case 2:
;1011:			{
;1012:				//the one closest to the base will defend the base
;1013:				ClientName(teammates[0], name, sizeof(name));
;1014:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1015:				BotSayTeamOrder(bs, teammates[0]);
;1016:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1017:				//the other will get the flag
;1018:				ClientName(teammates[1], name, sizeof(name));
;1019:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1020:				BotSayTeamOrder(bs, teammates[1]);
;1021:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1022:				break;
;1023:			}
;1024:			case 3:
;1025:			{
;1026:				//the one closest to the base will defend the base
;1027:				ClientName(teammates[0], name, sizeof(name));
;1028:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1029:				BotSayTeamOrder(bs, teammates[0]);
;1030:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1031:				//the others should go for the enemy flag
;1032:				ClientName(teammates[1], name, sizeof(name));
;1033:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1034:				BotSayTeamOrder(bs, teammates[1]);
;1035:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1036:				//
;1037:				ClientName(teammates[2], name, sizeof(name));
;1038:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1039:				BotSayTeamOrder(bs, teammates[2]);
;1040:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1041:				break;
;1042:			}
;1043:			default:
;1044:			{
;1045:				//30% defend the base
;1046:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1047:				if (defenders > 3) defenders = 3;
;1048:				//60% get the flag
;1049:				attackers = (int) (float) numteammates * 0.6 + 0.5;
;1050:				if (attackers > 6) attackers = 6;
;1051:				for (i = 0; i < defenders; i++) {
;1052:					//
;1053:					ClientName(teammates[i], name, sizeof(name));
;1054:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1055:					BotSayTeamOrder(bs, teammates[i]);
;1056:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1057:				}
;1058:				for (i = 0; i < attackers; i++) {
;1059:					//
;1060:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1061:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1062:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1063:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1064:				}
;1065:				//
;1066:				break;
;1067:			}
;1068:		}
;1069:	}
;1070:}
;1071:
;1072:/*
;1073:==================
;1074:Bot1FCTFOrders_TeamHasFlag
;1075:
;1076:  X% towards neutral flag, Y% go towards enemy base and accompany flag carrier if visible
;1077:==================
;1078:*/
;1079:void Bot1FCTFOrders_TeamHasFlag(bot_state_t *bs) {
;1080:	int numteammates, defenders, attackers, i, other;
;1081:	int teammates[MAX_CLIENTS];
;1082:	char name[MAX_NETNAME], carriername[MAX_NETNAME];
;1083:
;1084:	//sort team mates by travel time to base
;1085:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1086:	//sort team mates by CTF preference
;1087:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1088:	//passive strategy
;1089:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1090:		//different orders based on the number of team mates
;1091:		switch(numteammates) {
;1092:			case 1: break;
;1093:			case 2:
;1094:			{
;1095:				//tell the one not carrying the flag to attack the enemy base
;1096:				if (teammates[0] == bs->flagcarrier) other = teammates[1];
;1097:				else other = teammates[0];
;1098:				ClientName(other, name, sizeof(name));
;1099:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1100:				BotSayTeamOrder(bs, other);
;1101:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_OFFENSE);
;1102:				break;
;1103:			}
;1104:			case 3:
;1105:			{
;1106:				//tell the one closest to the base not carrying the flag to defend the base
;1107:				if (teammates[0] != bs->flagcarrier) other = teammates[0];
;1108:				else other = teammates[1];
;1109:				ClientName(other, name, sizeof(name));
;1110:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1111:				BotSayTeamOrder(bs, other);
;1112:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1113:				//tell the one furthest from the base not carrying the flag to accompany the flag carrier
;1114:				if (teammates[2] != bs->flagcarrier) other = teammates[2];
;1115:				else other = teammates[1];
;1116:				ClientName(other, name, sizeof(name));
;1117:				if ( bs->flagcarrier != -1 ) {
;1118:					ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1119:					if (bs->flagcarrier == bs->client) {
;1120:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1121:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
;1122:					}
;1123:					else {
;1124:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1125:						BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
;1126:					}
;1127:				}
;1128:				else {
;1129:					//
;1130:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1131:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_GETFLAG);
;1132:				}
;1133:				BotSayTeamOrder(bs, other);
;1134:				break;
;1135:			}
;1136:			default:
;1137:			{
;1138:				//30% will defend the base
;1139:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1140:				if (defenders > 3) defenders = 3;
;1141:				//70% accompanies the flag carrier
;1142:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1143:				if (attackers > 7) attackers = 7;
;1144:				for (i = 0; i < defenders; i++) {
;1145:					//
;1146:					if (teammates[i] == bs->flagcarrier) {
;1147:						continue;
;1148:					}
;1149:					ClientName(teammates[i], name, sizeof(name));
;1150:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1151:					BotSayTeamOrder(bs, teammates[i]);
;1152:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1153:				}
;1154:				if (bs->flagcarrier != -1) {
;1155:					ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1156:					for (i = 0; i < attackers; i++) {
;1157:						//
;1158:						if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1159:							continue;
;1160:						}
;1161:						//
;1162:						ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1163:						if (bs->flagcarrier == bs->client) {
;1164:							BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1165:							BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
;1166:						}
;1167:						else {
;1168:							BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1169:							BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
;1170:						}
;1171:						BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1172:					}
;1173:				}
;1174:				else {
;1175:					for (i = 0; i < attackers; i++) {
;1176:						//
;1177:						if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1178:							continue;
;1179:						}
;1180:						//
;1181:						ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1182:						BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1183:						BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1184:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1185:					}
;1186:				}
;1187:				//
;1188:				break;
;1189:			}
;1190:		}
;1191:	}
;1192:	else { //agressive
;1193:		//different orders based on the number of team mates
;1194:		switch(numteammates) {
;1195:			case 1: break;
;1196:			case 2:
;1197:			{
;1198:				//tell the one not carrying the flag to defend the base
;1199:				if (teammates[0] == bs->flagcarrier) other = teammates[1];
;1200:				else other = teammates[0];
;1201:				ClientName(other, name, sizeof(name));
;1202:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1203:				BotSayTeamOrder(bs, other);
;1204:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1205:				break;
;1206:			}
;1207:			case 3:
;1208:			{
;1209:				//tell the one closest to the base not carrying the flag to defend the base
;1210:				if (teammates[0] != bs->flagcarrier) other = teammates[0];
;1211:				else other = teammates[1];
;1212:				ClientName(other, name, sizeof(name));
;1213:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1214:				BotSayTeamOrder(bs, other);
;1215:				BotSayVoiceTeamOrder(bs, other, VOICECHAT_DEFEND);
;1216:				//tell the one furthest from the base not carrying the flag to accompany the flag carrier
;1217:				if (teammates[2] != bs->flagcarrier) other = teammates[2];
;1218:				else other = teammates[1];
;1219:				ClientName(other, name, sizeof(name));
;1220:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1221:				if (bs->flagcarrier == bs->client) {
;1222:					BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1223:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWME);
;1224:				}
;1225:				else {
;1226:					BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1227:					BotSayVoiceTeamOrder(bs, other, VOICECHAT_FOLLOWFLAGCARRIER);
;1228:				}
;1229:				BotSayTeamOrder(bs, other);
;1230:				break;
;1231:			}
;1232:			default:
;1233:			{
;1234:				//20% will defend the base
;1235:				defenders = (int) (float) numteammates * 0.2 + 0.5;
;1236:				if (defenders > 2) defenders = 2;
;1237:				//80% accompanies the flag carrier
;1238:				attackers = (int) (float) numteammates * 0.8 + 0.5;
;1239:				if (attackers > 8) attackers = 8;
;1240:				for (i = 0; i < defenders; i++) {
;1241:					//
;1242:					if (teammates[i] == bs->flagcarrier) {
;1243:						continue;
;1244:					}
;1245:					ClientName(teammates[i], name, sizeof(name));
;1246:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1247:					BotSayTeamOrder(bs, teammates[i]);
;1248:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1249:				}
;1250:				ClientName(bs->flagcarrier, carriername, sizeof(carriername));
;1251:				for (i = 0; i < attackers; i++) {
;1252:					//
;1253:					if (teammates[numteammates - i - 1] == bs->flagcarrier) {
;1254:						continue;
;1255:					}
;1256:					//
;1257:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1258:					if (bs->flagcarrier == bs->client) {
;1259:						BotAI_BotInitialChat(bs, "cmd_accompanyme", name, NULL);
;1260:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWME);
;1261:					}
;1262:					else {
;1263:						BotAI_BotInitialChat(bs, "cmd_accompany", name, carriername, NULL);
;1264:						BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_FOLLOWFLAGCARRIER);
;1265:					}
;1266:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1267:				}
;1268:				//
;1269:				break;
;1270:			}
;1271:		}
;1272:	}
;1273:}
;1274:
;1275:/*
;1276:==================
;1277:Bot1FCTFOrders_EnemyHasFlag
;1278:
;1279:  X% defend the base, Y% towards neutral flag
;1280:==================
;1281:*/
;1282:void Bot1FCTFOrders_EnemyHasFlag(bot_state_t *bs) {
;1283:	int numteammates, defenders, attackers, i;
;1284:	int teammates[MAX_CLIENTS];
;1285:	char name[MAX_NETNAME];
;1286:
;1287:	//sort team mates by travel time to base
;1288:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1289:	//sort team mates by CTF preference
;1290:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1291:	//passive strategy
;1292:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1293:		//different orders based on the number of team mates
;1294:		switch(numteammates) {
;1295:			case 1: break;
;1296:			case 2:
;1297:			{
;1298:				//both defend the base
;1299:				ClientName(teammates[0], name, sizeof(name));
;1300:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1301:				BotSayTeamOrder(bs, teammates[0]);
;1302:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1303:				//
;1304:				ClientName(teammates[1], name, sizeof(name));
;1305:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1306:				BotSayTeamOrder(bs, teammates[1]);
;1307:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1308:				break;
;1309:			}
;1310:			case 3:
;1311:			{
;1312:				//the one closest to the base will defend the base
;1313:				ClientName(teammates[0], name, sizeof(name));
;1314:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1315:				BotSayTeamOrder(bs, teammates[0]);
;1316:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1317:				//the second one closest to the base will defend the base
;1318:				ClientName(teammates[1], name, sizeof(name));
;1319:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1320:				BotSayTeamOrder(bs, teammates[1]);
;1321:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1322:				//the other will also defend the base
;1323:				ClientName(teammates[2], name, sizeof(name));
;1324:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1325:				BotSayTeamOrder(bs, teammates[2]);
;1326:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_DEFEND);
;1327:				break;
;1328:			}
;1329:			default:
;1330:			{
;1331:				//80% will defend the base
;1332:				defenders = (int) (float) numteammates * 0.8 + 0.5;
;1333:				if (defenders > 8) defenders = 8;
;1334:				//10% will try to return the flag
;1335:				attackers = (int) (float) numteammates * 0.1 + 0.5;
;1336:				if (attackers > 2) attackers = 2;
;1337:				for (i = 0; i < defenders; i++) {
;1338:					//
;1339:					ClientName(teammates[i], name, sizeof(name));
;1340:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1341:					BotSayTeamOrder(bs, teammates[i]);
;1342:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1343:				}
;1344:				for (i = 0; i < attackers; i++) {
;1345:					//
;1346:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1347:					BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;1348:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1349:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1350:				}
;1351:				//
;1352:				break;
;1353:			}
;1354:		}
;1355:	}
;1356:	else { //agressive
;1357:		//different orders based on the number of team mates
;1358:		switch(numteammates) {
;1359:			case 1: break;
;1360:			case 2:
;1361:			{
;1362:				//the one closest to the base will defend the base
;1363:				ClientName(teammates[0], name, sizeof(name));
;1364:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1365:				BotSayTeamOrder(bs, teammates[0]);
;1366:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1367:				//the other will get the flag
;1368:				ClientName(teammates[1], name, sizeof(name));
;1369:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1370:				BotSayTeamOrder(bs, teammates[1]);
;1371:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1372:				break;
;1373:			}
;1374:			case 3:
;1375:			{
;1376:				//the one closest to the base will defend the base
;1377:				ClientName(teammates[0], name, sizeof(name));
;1378:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1379:				BotSayTeamOrder(bs, teammates[0]);
;1380:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1381:				//the others should go for the enemy flag
;1382:				ClientName(teammates[1], name, sizeof(name));
;1383:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1384:				BotSayTeamOrder(bs, teammates[1]);
;1385:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1386:				//
;1387:				ClientName(teammates[2], name, sizeof(name));
;1388:				BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;1389:				BotSayTeamOrder(bs, teammates[2]);
;1390:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1391:				break;
;1392:			}
;1393:			default:
;1394:			{
;1395:				//70% defend the base
;1396:				defenders = (int) (float) numteammates * 0.7 + 0.5;
;1397:				if (defenders > 8) defenders = 8;
;1398:				//20% try to return the flag
;1399:				attackers = (int) (float) numteammates * 0.2 + 0.5;
;1400:				if (attackers > 2) attackers = 2;
;1401:				for (i = 0; i < defenders; i++) {
;1402:					//
;1403:					ClientName(teammates[i], name, sizeof(name));
;1404:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1405:					BotSayTeamOrder(bs, teammates[i]);
;1406:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1407:				}
;1408:				for (i = 0; i < attackers; i++) {
;1409:					//
;1410:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1411:					BotAI_BotInitialChat(bs, "cmd_returnflag", name, NULL);
;1412:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1413:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1414:				}
;1415:				//
;1416:				break;
;1417:			}
;1418:		}
;1419:	}
;1420:}
;1421:
;1422:/*
;1423:==================
;1424:Bot1FCTFOrders_EnemyDroppedFlag
;1425:
;1426:  X% defend the base, Y% get the flag
;1427:==================
;1428:*/
;1429:void Bot1FCTFOrders_EnemyDroppedFlag(bot_state_t *bs) {
;1430:	int numteammates, defenders, attackers, i;
;1431:	int teammates[MAX_CLIENTS];
;1432:	char name[MAX_NETNAME];
;1433:
;1434:	//sort team mates by travel time to base
;1435:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1436:	//sort team mates by CTF preference
;1437:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1438:	//passive strategy
;1439:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1440:		//different orders based on the number of team mates
;1441:		switch(numteammates) {
;1442:			case 1: break;
;1443:			case 2:
;1444:			{
;1445:				//the one closest to the base will defend the base
;1446:				ClientName(teammates[0], name, sizeof(name));
;1447:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1448:				BotSayTeamOrder(bs, teammates[0]);
;1449:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1450:				//the other will get the flag
;1451:				ClientName(teammates[1], name, sizeof(name));
;1452:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1453:				BotSayTeamOrder(bs, teammates[1]);
;1454:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1455:				break;
;1456:			}
;1457:			case 3:
;1458:			{
;1459:				//the one closest to the base will defend the base
;1460:				ClientName(teammates[0], name, sizeof(name));
;1461:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1462:				BotSayTeamOrder(bs, teammates[0]);
;1463:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1464:				//the second one closest to the base will defend the base
;1465:				ClientName(teammates[1], name, sizeof(name));
;1466:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1467:				BotSayTeamOrder(bs, teammates[1]);
;1468:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1469:				//the other will get the flag
;1470:				ClientName(teammates[2], name, sizeof(name));
;1471:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1472:				BotSayTeamOrder(bs, teammates[2]);
;1473:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1474:				break;
;1475:			}
;1476:			default:
;1477:			{
;1478:				//50% defend the base
;1479:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1480:				if (defenders > 5) defenders = 5;
;1481:				//40% get the flag
;1482:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1483:				if (attackers > 4) attackers = 4;
;1484:				for (i = 0; i < defenders; i++) {
;1485:					//
;1486:					ClientName(teammates[i], name, sizeof(name));
;1487:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1488:					BotSayTeamOrder(bs, teammates[i]);
;1489:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1490:				}
;1491:				for (i = 0; i < attackers; i++) {
;1492:					//
;1493:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1494:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1495:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1496:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_GETFLAG);
;1497:				}
;1498:				//
;1499:				break;
;1500:			}
;1501:		}
;1502:	}
;1503:	else { //agressive
;1504:		//different orders based on the number of team mates
;1505:		switch(numteammates) {
;1506:			case 1: break;
;1507:			case 2:
;1508:			{
;1509:				//the one closest to the base will defend the base
;1510:				ClientName(teammates[0], name, sizeof(name));
;1511:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1512:				BotSayTeamOrder(bs, teammates[0]);
;1513:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1514:				//the other will get the flag
;1515:				ClientName(teammates[1], name, sizeof(name));
;1516:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1517:				BotSayTeamOrder(bs, teammates[1]);
;1518:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1519:				break;
;1520:			}
;1521:			case 3:
;1522:			{
;1523:				//the one closest to the base will defend the base
;1524:				ClientName(teammates[0], name, sizeof(name));
;1525:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1526:				BotSayTeamOrder(bs, teammates[0]);
;1527:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1528:				//the others should go for the enemy flag
;1529:				ClientName(teammates[1], name, sizeof(name));
;1530:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1531:				BotSayTeamOrder(bs, teammates[1]);
;1532:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_GETFLAG);
;1533:				//
;1534:				ClientName(teammates[2], name, sizeof(name));
;1535:				BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1536:				BotSayTeamOrder(bs, teammates[2]);
;1537:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_GETFLAG);
;1538:				break;
;1539:			}
;1540:			default:
;1541:			{
;1542:				//30% defend the base
;1543:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1544:				if (defenders > 3) defenders = 3;
;1545:				//60% get the flag
;1546:				attackers = (int) (float) numteammates * 0.6 + 0.5;
;1547:				if (attackers > 6) attackers = 6;
;1548:				for (i = 0; i < defenders; i++) {
;1549:					//
;1550:					ClientName(teammates[i], name, sizeof(name));
;1551:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1552:					BotSayTeamOrder(bs, teammates[i]);
;1553:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1554:				}
;1555:				for (i = 0; i < attackers; i++) {
;1556:					//
;1557:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1558:					BotAI_BotInitialChat(bs, "cmd_getflag", name, NULL);
;1559:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1560:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_DEFEND);
;1561:				}
;1562:				//
;1563:				break;
;1564:			}
;1565:		}
;1566:	}
;1567:}
;1568:
;1569:/*
;1570:==================
;1571:Bot1FCTFOrders
;1572:==================
;1573:*/
;1574:void Bot1FCTFOrders(bot_state_t *bs) {
;1575:	switch(bs->neutralflagstatus) {
;1576:		case 0: Bot1FCTFOrders_FlagAtCenter(bs); break;
;1577:		case 1: Bot1FCTFOrders_TeamHasFlag(bs); break;
;1578:		case 2: Bot1FCTFOrders_EnemyHasFlag(bs); break;
;1579:		case 3: Bot1FCTFOrders_EnemyDroppedFlag(bs); break;
;1580:	}
;1581:}
;1582:
;1583:/*
;1584:==================
;1585:BotObeliskOrders
;1586:
;1587:  X% in defence Y% in offence
;1588:==================
;1589:*/
;1590:void BotObeliskOrders(bot_state_t *bs) {
;1591:	int numteammates, defenders, attackers, i;
;1592:	int teammates[MAX_CLIENTS];
;1593:	char name[MAX_NETNAME];
;1594:
;1595:	//sort team mates by travel time to base
;1596:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1597:	//sort team mates by CTF preference
;1598:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1599:	//passive strategy
;1600:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1601:		//different orders based on the number of team mates
;1602:		switch(numteammates) {
;1603:			case 1: break;
;1604:			case 2:
;1605:			{
;1606:				//the one closest to the base will defend the base
;1607:				ClientName(teammates[0], name, sizeof(name));
;1608:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1609:				BotSayTeamOrder(bs, teammates[0]);
;1610:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1611:				//the other will attack the enemy base
;1612:				ClientName(teammates[1], name, sizeof(name));
;1613:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1614:				BotSayTeamOrder(bs, teammates[1]);
;1615:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1616:				break;
;1617:			}
;1618:			case 3:
;1619:			{
;1620:				//the one closest to the base will defend the base
;1621:				ClientName(teammates[0], name, sizeof(name));
;1622:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1623:				BotSayTeamOrder(bs, teammates[0]);
;1624:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1625:				//the one second closest to the base also defends the base
;1626:				ClientName(teammates[1], name, sizeof(name));
;1627:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1628:				BotSayTeamOrder(bs, teammates[1]);
;1629:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1630:				//the other one attacks the enemy base
;1631:				ClientName(teammates[2], name, sizeof(name));
;1632:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1633:				BotSayTeamOrder(bs, teammates[2]);
;1634:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1635:				break;
;1636:			}
;1637:			default:
;1638:			{
;1639:				//50% defend the base
;1640:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1641:				if (defenders > 5) defenders = 5;
;1642:				//40% attack the enemy base
;1643:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1644:				if (attackers > 4) attackers = 4;
;1645:				for (i = 0; i < defenders; i++) {
;1646:					//
;1647:					ClientName(teammates[i], name, sizeof(name));
;1648:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1649:					BotSayTeamOrder(bs, teammates[i]);
;1650:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1651:				}
;1652:				for (i = 0; i < attackers; i++) {
;1653:					//
;1654:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1655:					BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1656:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1657:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1658:				}
;1659:				//
;1660:				break;
;1661:			}
;1662:		}
;1663:	}
;1664:	else {
;1665:		//different orders based on the number of team mates
;1666:		switch(numteammates) {
;1667:			case 1: break;
;1668:			case 2:
;1669:			{
;1670:				//the one closest to the base will defend the base
;1671:				ClientName(teammates[0], name, sizeof(name));
;1672:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1673:				BotSayTeamOrder(bs, teammates[0]);
;1674:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1675:				//the other will attack the enemy base
;1676:				ClientName(teammates[1], name, sizeof(name));
;1677:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1678:				BotSayTeamOrder(bs, teammates[1]);
;1679:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1680:				break;
;1681:			}
;1682:			case 3:
;1683:			{
;1684:				//the one closest to the base will defend the base
;1685:				ClientName(teammates[0], name, sizeof(name));
;1686:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1687:				BotSayTeamOrder(bs, teammates[0]);
;1688:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1689:				//the others attack the enemy base
;1690:				ClientName(teammates[1], name, sizeof(name));
;1691:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1692:				BotSayTeamOrder(bs, teammates[1]);
;1693:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1694:				//
;1695:				ClientName(teammates[2], name, sizeof(name));
;1696:				BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1697:				BotSayTeamOrder(bs, teammates[2]);
;1698:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1699:				break;
;1700:			}
;1701:			default:
;1702:			{
;1703:				//30% defend the base
;1704:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1705:				if (defenders > 3) defenders = 3;
;1706:				//70% attack the enemy base
;1707:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1708:				if (attackers > 7) attackers = 7;
;1709:				for (i = 0; i < defenders; i++) {
;1710:					//
;1711:					ClientName(teammates[i], name, sizeof(name));
;1712:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1713:					BotSayTeamOrder(bs, teammates[i]);
;1714:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1715:				}
;1716:				for (i = 0; i < attackers; i++) {
;1717:					//
;1718:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1719:					BotAI_BotInitialChat(bs, "cmd_attackenemybase", name, NULL);
;1720:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1721:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1722:				}
;1723:				//
;1724:				break;
;1725:			}
;1726:		}
;1727:	}
;1728:}
;1729:
;1730:/*
;1731:==================
;1732:BotHarvesterOrders
;1733:
;1734:  X% defend the base, Y% harvest
;1735:==================
;1736:*/
;1737:void BotHarvesterOrders(bot_state_t *bs) {
;1738:	int numteammates, defenders, attackers, i;
;1739:	int teammates[MAX_CLIENTS];
;1740:	char name[MAX_NETNAME];
;1741:
;1742:	//sort team mates by travel time to base
;1743:	numteammates = BotSortTeamMatesByBaseTravelTime(bs, teammates, sizeof(teammates));
;1744:	//sort team mates by CTF preference
;1745:	BotSortTeamMatesByTaskPreference(bs, teammates, numteammates);
;1746:	//passive strategy
;1747:	if (!(bs->ctfstrategy & CTFS_AGRESSIVE)) {
;1748:		//different orders based on the number of team mates
;1749:		switch(numteammates) {
;1750:			case 1: break;
;1751:			case 2:
;1752:			{
;1753:				//the one closest to the base will defend the base
;1754:				ClientName(teammates[0], name, sizeof(name));
;1755:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1756:				BotSayTeamOrder(bs, teammates[0]);
;1757:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1758:				//the other will harvest
;1759:				ClientName(teammates[1], name, sizeof(name));
;1760:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1761:				BotSayTeamOrder(bs, teammates[1]);
;1762:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1763:				break;
;1764:			}
;1765:			case 3:
;1766:			{
;1767:				//the one closest to the base will defend the base
;1768:				ClientName(teammates[0], name, sizeof(name));
;1769:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1770:				BotSayTeamOrder(bs, teammates[0]);
;1771:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1772:				//the one second closest to the base also defends the base
;1773:				ClientName(teammates[1], name, sizeof(name));
;1774:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1775:				BotSayTeamOrder(bs, teammates[1]);
;1776:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_DEFEND);
;1777:				//the other one goes harvesting
;1778:				ClientName(teammates[2], name, sizeof(name));
;1779:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1780:				BotSayTeamOrder(bs, teammates[2]);
;1781:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1782:				break;
;1783:			}
;1784:			default:
;1785:			{
;1786:				//50% defend the base
;1787:				defenders = (int) (float) numteammates * 0.5 + 0.5;
;1788:				if (defenders > 5) defenders = 5;
;1789:				//40% goes harvesting
;1790:				attackers = (int) (float) numteammates * 0.4 + 0.5;
;1791:				if (attackers > 4) attackers = 4;
;1792:				for (i = 0; i < defenders; i++) {
;1793:					//
;1794:					ClientName(teammates[i], name, sizeof(name));
;1795:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1796:					BotSayTeamOrder(bs, teammates[i]);
;1797:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1798:				}
;1799:				for (i = 0; i < attackers; i++) {
;1800:					//
;1801:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1802:					BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1803:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1804:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1805:				}
;1806:				//
;1807:				break;
;1808:			}
;1809:		}
;1810:	}
;1811:	else {
;1812:		//different orders based on the number of team mates
;1813:		switch(numteammates) {
;1814:			case 1: break;
;1815:			case 2:
;1816:			{
;1817:				//the one closest to the base will defend the base
;1818:				ClientName(teammates[0], name, sizeof(name));
;1819:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1820:				BotSayTeamOrder(bs, teammates[0]);
;1821:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1822:				//the other will harvest
;1823:				ClientName(teammates[1], name, sizeof(name));
;1824:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1825:				BotSayTeamOrder(bs, teammates[1]);
;1826:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1827:				break;
;1828:			}
;1829:			case 3:
;1830:			{
;1831:				//the one closest to the base will defend the base
;1832:				ClientName(teammates[0], name, sizeof(name));
;1833:				BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1834:				BotSayTeamOrder(bs, teammates[0]);
;1835:				BotSayVoiceTeamOrder(bs, teammates[0], VOICECHAT_DEFEND);
;1836:				//the others go harvesting
;1837:				ClientName(teammates[1], name, sizeof(name));
;1838:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1839:				BotSayTeamOrder(bs, teammates[1]);
;1840:				BotSayVoiceTeamOrder(bs, teammates[1], VOICECHAT_OFFENSE);
;1841:				//
;1842:				ClientName(teammates[2], name, sizeof(name));
;1843:				BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1844:				BotSayTeamOrder(bs, teammates[2]);
;1845:				BotSayVoiceTeamOrder(bs, teammates[2], VOICECHAT_OFFENSE);
;1846:				break;
;1847:			}
;1848:			default:
;1849:			{
;1850:				//30% defend the base
;1851:				defenders = (int) (float) numteammates * 0.3 + 0.5;
;1852:				if (defenders > 3) defenders = 3;
;1853:				//70% go harvesting
;1854:				attackers = (int) (float) numteammates * 0.7 + 0.5;
;1855:				if (attackers > 7) attackers = 7;
;1856:				for (i = 0; i < defenders; i++) {
;1857:					//
;1858:					ClientName(teammates[i], name, sizeof(name));
;1859:					BotAI_BotInitialChat(bs, "cmd_defendbase", name, NULL);
;1860:					BotSayTeamOrder(bs, teammates[i]);
;1861:					BotSayVoiceTeamOrder(bs, teammates[i], VOICECHAT_DEFEND);
;1862:				}
;1863:				for (i = 0; i < attackers; i++) {
;1864:					//
;1865:					ClientName(teammates[numteammates - i - 1], name, sizeof(name));
;1866:					BotAI_BotInitialChat(bs, "cmd_harvest", name, NULL);
;1867:					BotSayTeamOrder(bs, teammates[numteammates - i - 1]);
;1868:					BotSayVoiceTeamOrder(bs, teammates[numteammates - i - 1], VOICECHAT_OFFENSE);
;1869:				}
;1870:				//
;1871:				break;
;1872:			}
;1873:		}
;1874:	}
;1875:}
;1876:#endif
;1877:
;1878:/*
;1879:==================
;1880:FindHumanTeamLeader
;1881:==================
;1882:*/
;1883:int FindHumanTeamLeader(bot_state_t *bs) {
line 1886
;1884:	int i;
;1885:
;1886:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $429
line 1887
;1887:		if ( g_entities[i].inuse ) {
CNSTI4 808
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $433
line 1889
;1888:			// if this player is not a bot
;1889:			if ( !(g_entities[i].r.svFlags & SVF_BOT) ) {
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
NEI4 $436
line 1891
;1890:				// if this player is ok with being the leader
;1891:				if (!notleader[i]) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 notleader
ADDP4
INDIRI4
CNSTI4 0
NEI4 $440
line 1893
;1892:					// if this player is on the same team
;1893:					if ( BotSameTeam(bs, i) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 BotSameTeam
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $442
line 1894
;1894:						ClientName(i, bs->teamleader, sizeof(bs->teamleader));
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1896
;1895:						// if not yet ordered to do anything
;1896:						if ( !BotSetLastOrderedTask(bs) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 BotSetLastOrderedTask
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $444
line 1898
;1897:							// go on defense by default
;1898:							BotVoiceChat_Defend(bs, i, SAY_TELL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 2
ARGI4
ADDRGP4 BotVoiceChat_Defend
CALLV
pop
line 1899
;1899:						}
LABELV $444
line 1900
;1900:						return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $428
JUMPV
LABELV $442
line 1902
;1901:					}
;1902:				}
LABELV $440
line 1903
;1903:			}
LABELV $436
line 1904
;1904:		}
LABELV $433
line 1905
;1905:	}
LABELV $430
line 1886
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $429
line 1906
;1906:	return qfalse;
CNSTI4 0
RETI4
LABELV $428
endproc FindHumanTeamLeader 12 12
export BotTeamAI
proc BotTeamAI 72 12
line 1914
;1907:}
;1908:
;1909:/*
;1910:==================
;1911:BotTeamAI
;1912:==================
;1913:*/
;1914:void BotTeamAI(bot_state_t *bs) {
line 1919
;1915:	int numteammates;
;1916:	char netname[MAX_NETNAME];
;1917:
;1918:	//
;1919:	if ( gametype < GT_TEAM  )
ADDRGP4 gametype
INDIRI4
CNSTI4 3
GEI4 $447
line 1920
;1920:		return;
ADDRGP4 $446
JUMPV
LABELV $447
line 1922
;1921:	// make sure we've got a valid team leader
;1922:	if (!BotValidTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 BotValidTeamLeader
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $449
line 1924
;1923:		//
;1924:		if (!FindHumanTeamLeader(bs)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 FindHumanTeamLeader
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $451
line 1926
;1925:			//
;1926:			if (!bs->askteamleader_time && !bs->becometeamleader_time) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRLP4 48
INDIRP4
CNSTI4 6932
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
NEF4 $453
ADDRLP4 48
INDIRP4
CNSTI4 6936
ADDP4
INDIRF4
ADDRLP4 52
INDIRF4
NEF4 $453
line 1927
;1927:				if (bs->entergame_time + 10 > FloatTime()) {
ADDRFP4 0
INDIRP4
CNSTI4 6064
ADDP4
INDIRF4
CNSTF4 1092616192
ADDF4
ADDRGP4 floattime
INDIRF4
LEF4 $455
line 1928
;1928:					bs->askteamleader_time = FloatTime() + 5 + random() * 10;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6932
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CNSTF4 1092616192
ADDRLP4 56
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1929
;1929:				}
ADDRGP4 $456
JUMPV
LABELV $455
line 1930
;1930:				else {
line 1931
;1931:					bs->becometeamleader_time = FloatTime() + 5 + random() * 10;
ADDRLP4 56
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
ADDF4
CNSTF4 1092616192
ADDRLP4 56
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1932
;1932:				}
LABELV $456
line 1933
;1933:			}
LABELV $453
line 1934
;1934:			if (bs->askteamleader_time && bs->askteamleader_time < FloatTime()) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 6932
ADDP4
INDIRF4
ASGNF4
ADDRLP4 56
INDIRF4
CNSTF4 0
EQF4 $457
ADDRLP4 56
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $457
line 1936
;1935:				// if asked for a team leader and no response
;1936:				BotAI_BotInitialChat(bs, "whoisteamleader", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $459
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1937
;1937:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1938
;1938:				bs->askteamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6932
ADDP4
CNSTF4 0
ASGNF4
line 1939
;1939:				bs->becometeamleader_time = FloatTime() + 8 + random() * 10;
ADDRLP4 60
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1090519040
ADDF4
CNSTF4 1092616192
ADDRLP4 60
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
ASGNF4
line 1940
;1940:			}
LABELV $457
line 1941
;1941:			if (bs->becometeamleader_time && bs->becometeamleader_time < FloatTime()) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
INDIRF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 0
EQF4 $446
ADDRLP4 60
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $446
line 1942
;1942:				BotAI_BotInitialChat(bs, "iamteamleader", NULL);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $462
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 BotAI_BotInitialChat
CALLV
pop
line 1943
;1943:				trap_BotEnterChat(bs->cs, 0, CHAT_TEAM);
ADDRFP4 0
INDIRP4
CNSTI4 6532
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_BotEnterChat
CALLV
pop
line 1944
;1944:				BotSayVoiceTeamOrder(bs, -1, VOICECHAT_STARTLEADER);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 $463
ARGP4
ADDRGP4 BotSayVoiceTeamOrder
CALLV
pop
line 1945
;1945:				ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1946
;1946:				strncpy(bs->teamleader, netname, sizeof(bs->teamleader));
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 1947
;1947:				bs->teamleader[sizeof(bs->teamleader)] = '\0';
ADDRFP4 0
INDIRP4
CNSTI4 6900
CNSTU4 32
ADDI4
ADDP4
CNSTI1 0
ASGNI1
line 1948
;1948:				bs->becometeamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
CNSTF4 0
ASGNF4
line 1949
;1949:			}
line 1950
;1950:			return;
ADDRGP4 $446
JUMPV
LABELV $451
line 1952
;1951:		}
;1952:	}
LABELV $449
line 1953
;1953:	bs->askteamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6932
ADDP4
CNSTF4 0
ASGNF4
line 1954
;1954:	bs->becometeamleader_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6936
ADDP4
CNSTF4 0
ASGNF4
line 1957
;1955:
;1956:	//return if this bot is NOT the team leader
;1957:	ClientName(bs->client, netname, sizeof(netname));
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 36
ARGI4
ADDRGP4 ClientName
CALLP4
pop
line 1958
;1958:	if (Q_stricmp(netname, bs->teamleader) != 0) return;
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 6900
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $464
ADDRGP4 $446
JUMPV
LABELV $464
line 1960
;1959:	//
;1960:	numteammates = BotNumTeamMates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BotNumTeamMates
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 48
INDIRI4
ASGNI4
line 1962
;1961:	//give orders
;1962:	switch(gametype) {
ADDRLP4 52
ADDRGP4 gametype
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 3
EQI4 $468
ADDRLP4 52
INDIRI4
CNSTI4 4
EQI4 $474
ADDRGP4 $466
JUMPV
LABELV $468
line 1964
;1963:		case GT_TEAM:
;1964:		{
line 1965
;1965:			if (bs->numteammates != numteammates || bs->forceorders) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 6948
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $471
ADDRLP4 56
INDIRP4
CNSTI4 6968
ADDP4
INDIRI4
CNSTI4 0
EQI4 $469
LABELV $471
line 1966
;1966:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1967
;1967:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 1968
;1968:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 0
ASGNI4
line 1969
;1969:			}
LABELV $469
line 1971
;1970:			//if it's time to give orders
;1971:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
INDIRF4
ASGNF4
ADDRLP4 60
INDIRF4
CNSTF4 0
EQF4 $467
ADDRLP4 60
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1084227584
SUBF4
GEF4 $467
line 1972
;1972:				BotTeamOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotTeamOrders
CALLV
pop
line 1974
;1973:				//give orders again after 120 seconds
;1974:				bs->teamgiveorders_time = FloatTime() + 120;
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
ADDRGP4 floattime
INDIRF4
CNSTF4 1123024896
ADDF4
ASGNF4
line 1975
;1975:			}
line 1976
;1976:			break;
ADDRGP4 $467
JUMPV
LABELV $474
line 1979
;1977:		}
;1978:		case GT_CTF:
;1979:		{
line 1982
;1980:			//if the number of team mates changed or the flag status changed
;1981:			//or someone wants to know what to do
;1982:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 6948
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $478
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 6964
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $478
ADDRLP4 56
INDIRP4
CNSTI4 6968
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $475
LABELV $478
line 1983
;1983:				bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1984
;1984:				bs->numteammates = numteammates;
ADDRFP4 0
INDIRP4
CNSTI4 6948
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 1985
;1985:				bs->flagstatuschanged = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6964
ADDP4
CNSTI4 0
ASGNI4
line 1986
;1986:				bs->forceorders = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 6968
ADDP4
CNSTI4 0
ASGNI4
line 1987
;1987:			}
LABELV $475
line 1989
;1988:			//if there were no flag captures the last 3 minutes
;1989:			if (bs->lastflagcapture_time < FloatTime() - 240) {
ADDRFP4 0
INDIRP4
CNSTI4 6944
ADDP4
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1131413504
SUBF4
GEF4 $479
line 1990
;1990:				bs->lastflagcapture_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6944
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1992
;1991:				//randomly change the CTF strategy
;1992:				if (random() < 0.4) {
ADDRLP4 64
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1053609165
GEF4 $481
line 1993
;1993:					bs->ctfstrategy ^= CTFS_AGRESSIVE;
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 6976
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 1994
;1994:					bs->teamgiveorders_time = FloatTime();
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 1995
;1995:				}
LABELV $481
line 1996
;1996:			}
LABELV $479
line 1998
;1997:			//if it's time to give orders
;1998:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 3) {
ADDRLP4 64
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
INDIRF4
ASGNF4
ADDRLP4 64
INDIRF4
CNSTF4 0
EQF4 $467
ADDRLP4 64
INDIRF4
ADDRGP4 floattime
INDIRF4
CNSTF4 1077936128
SUBF4
GEF4 $467
line 1999
;1999:				BotCTFOrders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCTFOrders
CALLV
pop
line 2001
;2000:				//
;2001:				bs->teamgiveorders_time = 0;
ADDRFP4 0
INDIRP4
CNSTI4 6940
ADDP4
CNSTF4 0
ASGNF4
line 2002
;2002:			}
line 2003
;2003:			break;
LABELV $466
LABELV $467
line 2063
;2004:		}
;2005:#ifdef MISSIONPACK
;2006:		case GT_1FCTF:
;2007:		{
;2008:			if (bs->numteammates != numteammates || bs->flagstatuschanged || bs->forceorders) {
;2009:				bs->teamgiveorders_time = FloatTime();
;2010:				bs->numteammates = numteammates;
;2011:				bs->flagstatuschanged = qfalse;
;2012:				bs->forceorders = qfalse;
;2013:			}
;2014:			//if there were no flag captures the last 4 minutes
;2015:			if (bs->lastflagcapture_time < FloatTime() - 240) {
;2016:				bs->lastflagcapture_time = FloatTime();
;2017:				//randomly change the CTF strategy
;2018:				if (random() < 0.4) {
;2019:					bs->ctfstrategy ^= CTFS_AGRESSIVE;
;2020:					bs->teamgiveorders_time = FloatTime();
;2021:				}
;2022:			}
;2023:			//if it's time to give orders
;2024:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 2) {
;2025:				Bot1FCTFOrders(bs);
;2026:				//
;2027:				bs->teamgiveorders_time = 0;
;2028:			}
;2029:			break;
;2030:		}
;2031:		case GT_OBELISK:
;2032:		{
;2033:			if (bs->numteammates != numteammates || bs->forceorders) {
;2034:				bs->teamgiveorders_time = FloatTime();
;2035:				bs->numteammates = numteammates;
;2036:				bs->forceorders = qfalse;
;2037:			}
;2038:			//if it's time to give orders
;2039:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
;2040:				BotObeliskOrders(bs);
;2041:				//give orders again after 30 seconds
;2042:				bs->teamgiveorders_time = FloatTime() + 30;
;2043:			}
;2044:			break;
;2045:		}
;2046:		case GT_HARVESTER:
;2047:		{
;2048:			if (bs->numteammates != numteammates || bs->forceorders) {
;2049:				bs->teamgiveorders_time = FloatTime();
;2050:				bs->numteammates = numteammates;
;2051:				bs->forceorders = qfalse;
;2052:			}
;2053:			//if it's time to give orders
;2054:			if (bs->teamgiveorders_time && bs->teamgiveorders_time < FloatTime() - 5) {
;2055:				BotHarvesterOrders(bs);
;2056:				//give orders again after 30 seconds
;2057:				bs->teamgiveorders_time = FloatTime() + 30;
;2058:			}
;2059:			break;
;2060:		}
;2061:#endif
;2062:	}
;2063:}
LABELV $446
endproc BotTeamAI 72 12
bss
export ctftaskpreferences
align 4
LABELV ctftaskpreferences
skip 2560
import BotVoiceChat_Defend
import BotVoiceChatCommand
import BotDumpNodeSwitches
import BotResetNodeSwitches
import AINode_Battle_NBG
import AINode_Battle_Retreat
import AINode_Battle_Chase
import AINode_Battle_Fight
import AINode_Seek_LTG
import AINode_Seek_NBG
import AINode_Seek_ActivateEntity
import AINode_Stand
import AINode_Respawn
import AINode_Observer
import AINode_Intermission
import AIEnter_Battle_NBG
import AIEnter_Battle_Retreat
import AIEnter_Battle_Chase
import AIEnter_Battle_Fight
import AIEnter_Seek_Camp
import AIEnter_Seek_LTG
import AIEnter_Seek_NBG
import AIEnter_Seek_ActivateEntity
import AIEnter_Stand
import AIEnter_Respawn
import AIEnter_Observer
import AIEnter_Intermission
import BotPrintTeamGoal
import BotMatchMessage
import notleader
import BotChatTest
import BotValidChatPosition
import BotChatTime
import BotChat_Random
import BotChat_EnemySuicide
import BotChat_Kill
import BotChat_Death
import BotChat_HitNoKill
import BotChat_HitNoDeath
import BotChat_HitTalking
import BotChat_EndLevel
import BotChat_StartLevel
import BotChat_ExitGame
import BotChat_EnterGame
import ctf_blueflag
import ctf_redflag
import bot_challenge
import bot_testrchat
import bot_nochat
import bot_fastchat
import bot_rocketjump
import bot_grapple
import maxclients
import gametype
import BotMapScripts
import BotPointAreaNum
import ClientOnSameTeamFromName
import ClientFromName
import stristr
import BotFindWayPoint
import BotCreateWayPoint
import BotAlternateRoute
import BotGetAlternateRouteGoal
import BotCTFRetreatGoals
import BotCTFSeekGoals
import BotRememberLastOrderedTask
import BotCTFCarryingFlag
import BotOppositeTeam
import BotTeam
import BotClearActivateGoalStack
import BotPopFromActivateGoalStack
import BotEnableActivateGoalAreas
import BotAIPredictObstacles
import BotAIBlocked
import BotCheckAttack
import BotAimAtEnemy
import BotEntityVisible
import BotRoamGoal
import BotFindEnemy
import InFieldOfVision
import BotVisibleTeamMatesAndEnemies
import BotEnemyFlagCarrierVisible
import BotTeamFlagCarrierVisible
import BotTeamFlagCarrier
import TeamPlayIsOn
import BotSameTeam
import BotAttackMove
import BotWantsToCamp
import BotHasPersistantPowerupAndWeapon
import BotCanAndWantsToRocketJump
import BotWantsToHelp
import BotWantsToChase
import BotWantsToRetreat
import BotFeelingBad
import BotAggression
import BotTeamGoals
import BotSetLastOrderedTask
import BotSynonymContext
import ClientSkin
import EasyClientName
import ClientName
import BotSetTeamStatus
import BotSetUserInfo
import EntityIsShooting
import EntityIsInvisible
import EntityIsDead
import BotInLavaOrSlime
import BotIntermission
import BotIsObserver
import BotIsDead
import BotBattleUseItems
import BotUpdateBattleInventory
import BotUpdateInventory
import BotSetupForMovement
import BotChooseWeapon
import BotFreeWaypoints
import BotDeathmatchAI
import BotShutdownDeathmatchAI
import BotSetupDeathmatchAI
import BotTeamLeader
import BotAI_GetSnapshotEntity
import BotAI_GetEntityState
import BotAI_GetClientState
import BotAI_Trace
import BotAI_BotInitialChat
import BotAI_Print
import floattime
import BotEntityInfo
import NumBots
import BotResetState
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
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
import g_rankings
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_blueteam
import g_redteam
import g_cubeTimeout
import g_obeliskRespawnDelay
import g_obeliskRegenAmount
import g_obeliskRegenPeriod
import g_obeliskHealth
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_motd
import g_synchronousClients
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlyFire
import g_capturelimit
import g_timelimit
import g_fraglimit
import g_dmflags
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_entities
import level
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
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import InitClientResp
import InitClientPersistant
import BeginIntermission
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
import Com_Printf
import Com_Error
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
LABELV $463
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $462
byte 1 105
byte 1 97
byte 1 109
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $459
byte 1 119
byte 1 104
byte 1 111
byte 1 105
byte 1 115
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $214
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $209
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 0
align 1
LABELV $170
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $164
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 114
byte 1 114
byte 1 105
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $163
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 0
align 1
LABELV $162
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $161
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 97
byte 1 99
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 97
byte 1 110
byte 1 121
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $152
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $151
byte 1 99
byte 1 109
byte 1 100
byte 1 95
byte 1 103
byte 1 101
byte 1 116
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $137
byte 1 25
byte 1 40
byte 1 37
byte 1 115
byte 1 25
byte 1 41
byte 1 25
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $73
byte 1 116
byte 1 0
align 1
LABELV $69
byte 1 110
byte 1 0
align 1
LABELV $62
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
