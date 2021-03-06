code
proc PlayerIcon 80 20
file "..\..\..\..\code\q3_ui\ui_splevel.c"
line 108
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=============================================================================
;5:
;6:SINGLE PLAYER LEVEL SELECT MENU
;7:
;8:=============================================================================
;9:*/
;10:
;11:#include "ui_local.h"
;12:
;13:
;14:#define ART_LEVELFRAME_FOCUS		"menu/art/maps_select"
;15:#define ART_LEVELFRAME_SELECTED		"menu/art/maps_selected"
;16:#define ART_ARROW					"menu/art/narrow_0"
;17:#define ART_ARROW_FOCUS				"menu/art/narrow_1"
;18:#define ART_MAP_UNKNOWN				"menu/art/unknownmap"
;19:#define ART_MAP_COMPLETE1			"menu/art/level_complete1"
;20:#define ART_MAP_COMPLETE2			"menu/art/level_complete2"
;21:#define ART_MAP_COMPLETE3			"menu/art/level_complete3"
;22:#define ART_MAP_COMPLETE4			"menu/art/level_complete4"
;23:#define ART_MAP_COMPLETE5			"menu/art/level_complete5"
;24:#define ART_BACK0					"menu/art/back_0"
;25:#define ART_BACK1					"menu/art/back_1"	
;26:#define ART_FIGHT0					"menu/art/fight_0"
;27:#define ART_FIGHT1					"menu/art/fight_1"
;28:#define ART_RESET0					"menu/art/reset_0"
;29:#define ART_RESET1					"menu/art/reset_1"	
;30:#define ART_CUSTOM0					"menu/art/skirmish_0"
;31:#define ART_CUSTOM1					"menu/art/skirmish_1"
;32:
;33:#define ID_LEFTARROW		10
;34:#define ID_PICTURE0			11
;35:#define ID_PICTURE1			12
;36:#define ID_PICTURE2			13
;37:#define ID_PICTURE3			14
;38:#define ID_RIGHTARROW		15
;39:#define ID_PLAYERPIC		16
;40:#define ID_AWARD1			17
;41:#define ID_AWARD2			18
;42:#define ID_AWARD3			19
;43:#define ID_AWARD4			20
;44:#define ID_AWARD5			21
;45:#define ID_AWARD6			22
;46:#define ID_BACK				23
;47:#define ID_RESET			24
;48:#define ID_CUSTOM			25
;49:#define ID_NEXT				26
;50:
;51:#define PLAYER_Y			314
;52:#define AWARDS_Y			(PLAYER_Y + 26)
;53:
;54:
;55:typedef struct {
;56:	menuframework_s	menu;
;57:	menutext_s		item_banner;
;58:	menubitmap_s	item_leftarrow;
;59:	menubitmap_s	item_maps[4];
;60:	menubitmap_s	item_rightarrow;
;61:	menubitmap_s	item_player;
;62:	menubitmap_s	item_awards[6];
;63:	menubitmap_s	item_back;
;64:	menubitmap_s	item_reset;
;65:	menubitmap_s	item_custom;
;66:	menubitmap_s	item_next;
;67:	menubitmap_s	item_null;
;68:
;69:	qboolean		reinit;
;70:
;71:	const char *	selectedArenaInfo;
;72:	int				numMaps;
;73:	char			levelPicNames[4][MAX_QPATH];
;74:	char			levelNames[4][16];
;75:	int				levelScores[4];
;76:	int				levelScoresSkill[4];
;77:	qhandle_t		levelSelectedPic;
;78:	qhandle_t		levelFocusPic;
;79:	qhandle_t		levelCompletePic[5];
;80:
;81:	char			playerModel[MAX_QPATH];
;82:	char			playerPicName[MAX_QPATH];
;83:	int				awardLevels[6];
;84:	sfxHandle_t		awardSounds[6];
;85:
;86:	int				numBots;
;87:	qhandle_t		botPics[7];
;88:	char			botNames[7][10];
;89:} levelMenuInfo_t;
;90:
;91:static levelMenuInfo_t	levelMenuInfo;
;92:
;93:static int	selectedArenaSet;
;94:static int	selectedArena;
;95:static int	currentSet;
;96:static int	currentGame;
;97:static int	trainingTier;
;98:static int	finalTier;
;99:static int	minTier;
;100:static int	maxTier;
;101:
;102:
;103:/*
;104:=================
;105:PlayerIcon
;106:=================
;107:*/
;108:static void PlayerIcon( const char *modelAndSkin, char *iconName, int iconNameMaxSize ) {
line 112
;109:	char	*skin;
;110:	char	model[MAX_QPATH];
;111:
;112:	Q_strncpyz( model, modelAndSkin, sizeof(model));
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 113
;113:	skin = Q_strrchr( model, '/' );
ADDRLP4 4
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 68
ADDRGP4 Q_strrchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 68
INDIRP4
ASGNP4
line 114
;114:	if ( skin ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $98
line 115
;115:		*skin++ = '\0';
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 72
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI1 0
ASGNI1
line 116
;116:	}
ADDRGP4 $99
JUMPV
LABELV $98
line 117
;117:	else {
line 118
;118:		skin = "default";
ADDRLP4 0
ADDRGP4 $100
ASGNP4
line 119
;119:	}
LABELV $99
line 121
;120:
;121:	Com_sprintf(iconName, iconNameMaxSize, "models/players/%s/icon_%s.tga", model, skin );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $101
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 123
;122:
;123:	if( !trap_R_RegisterShaderNoMip( iconName ) && Q_stricmp( skin, "default" ) != 0 ) {
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
NEI4 $102
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $100
ARGP4
ADDRLP4 76
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $102
line 124
;124:		Com_sprintf(iconName, iconNameMaxSize, "models/players/%s/icon_default.tga", model );
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 $104
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 125
;125:	}
LABELV $102
line 126
;126:}
LABELV $97
endproc PlayerIcon 80 20
proc PlayerIconHandle 68 12
line 134
;127:
;128:
;129:/*
;130:=================
;131:PlayerIconhandle
;132:=================
;133:*/
;134:static qhandle_t PlayerIconHandle( const char *modelAndSkin ) {
line 137
;135:	char	iconName[MAX_QPATH];
;136:
;137:	PlayerIcon( modelAndSkin, iconName, sizeof(iconName) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 PlayerIcon
CALLV
pop
line 138
;138:	return trap_R_RegisterShaderNoMip( iconName );
ADDRLP4 0
ARGP4
ADDRLP4 64
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
RETI4
LABELV $105
endproc PlayerIconHandle 68 12
proc UI_SPLevelMenu_SetBots 1064 12
line 147
;139:}
;140:
;141:
;142:/*
;143:=================
;144:UI_SPLevelMenu_SetBots
;145:=================
;146:*/
;147:static void UI_SPLevelMenu_SetBots( void ) {
line 153
;148:	char	*p;
;149:	char	*bot;
;150:	char	*botInfo;
;151:	char	bots[MAX_INFO_STRING];
;152:
;153:	levelMenuInfo.numBots = 0;
ADDRGP4 levelMenuInfo+2648
CNSTI4 0
ASGNI4
line 154
;154:	if ( selectedArenaSet > currentSet ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 currentSet
INDIRI4
LEI4 $108
line 155
;155:		return;
ADDRGP4 $106
JUMPV
LABELV $108
line 158
;156:	}
;157:
;158:	Q_strncpyz( bots, Info_ValueForKey( levelMenuInfo.selectedArenaInfo, "bots" ), sizeof(bots) );
ADDRGP4 levelMenuInfo+2084
INDIRP4
ARGP4
ADDRGP4 $111
ARGP4
ADDRLP4 1036
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 12
ARGP4
ADDRLP4 1036
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 160
;159:
;160:	p = &bots[0];
ADDRLP4 0
ADDRLP4 12
ASGNP4
ADDRGP4 $113
JUMPV
line 161
;161:	while( *p && levelMenuInfo.numBots < 7 ) {
LABELV $116
line 163
;162:		//skip spaces
;163:		while( *p && *p == ' ' ) {
line 164
;164:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 165
;165:		}
LABELV $117
line 163
ADDRLP4 1040
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
EQI4 $119
ADDRLP4 1040
INDIRI4
CNSTI4 32
EQI4 $116
LABELV $119
line 166
;166:		if( !p ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $120
line 167
;167:			break;
ADDRGP4 $114
JUMPV
LABELV $120
line 171
;168:		}
;169:
;170:		// mark start of bot name
;171:		bot = p;
ADDRLP4 8
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $123
JUMPV
LABELV $122
line 174
;172:
;173:		// skip until space of null
;174:		while( *p && *p != ' ' ) {
line 175
;175:			p++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 176
;176:		}
LABELV $123
line 174
ADDRLP4 1044
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
EQI4 $125
ADDRLP4 1044
INDIRI4
CNSTI4 32
NEI4 $122
LABELV $125
line 177
;177:		if( *p ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $126
line 178
;178:			*p++ = 0;
ADDRLP4 1048
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1048
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1048
INDIRP4
CNSTI1 0
ASGNI1
line 179
;179:		}
LABELV $126
line 181
;180:
;181:		botInfo = UI_GetBotInfoByName( bot );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 UI_GetBotInfoByName
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1048
INDIRP4
ASGNP4
line 182
;182:		if( botInfo ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $128
line 183
;183:			levelMenuInfo.botPics[levelMenuInfo.numBots] = PlayerIconHandle( Info_ValueForKey( botInfo, "model" ) );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $132
ARGP4
ADDRLP4 1052
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 PlayerIconHandle
CALLI4
ASGNI4
ADDRGP4 levelMenuInfo+2648
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2652
ADDP4
ADDRLP4 1056
INDIRI4
ASGNI4
line 184
;184:			Q_strncpyz( levelMenuInfo.botNames[levelMenuInfo.numBots], Info_ValueForKey( botInfo, "name" ), 10 );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $135
ARGP4
ADDRLP4 1060
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 levelMenuInfo+2648
INDIRI4
CNSTI4 10
MULI4
ADDRGP4 levelMenuInfo+2680
ADDP4
ARGP4
ADDRLP4 1060
INDIRP4
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 185
;185:		}
ADDRGP4 $129
JUMPV
LABELV $128
line 186
;186:		else {
line 187
;187:			levelMenuInfo.botPics[levelMenuInfo.numBots] = 0;
ADDRGP4 levelMenuInfo+2648
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2652
ADDP4
CNSTI4 0
ASGNI4
line 188
;188:			Q_strncpyz( levelMenuInfo.botNames[levelMenuInfo.numBots], bot, 10 );
ADDRGP4 levelMenuInfo+2648
INDIRI4
CNSTI4 10
MULI4
ADDRGP4 levelMenuInfo+2680
ADDP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 189
;189:		}
LABELV $129
line 190
;190:		Q_CleanStr( levelMenuInfo.botNames[levelMenuInfo.numBots] );
ADDRGP4 levelMenuInfo+2648
INDIRI4
CNSTI4 10
MULI4
ADDRGP4 levelMenuInfo+2680
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 191
;191:		levelMenuInfo.numBots++;
ADDRLP4 1052
ADDRGP4 levelMenuInfo+2648
ASGNP4
ADDRLP4 1052
INDIRP4
ADDRLP4 1052
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 192
;192:	}
LABELV $113
line 161
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $143
ADDRGP4 levelMenuInfo+2648
INDIRI4
CNSTI4 7
LTI4 $117
LABELV $143
LABELV $114
line 193
;193:}
LABELV $106
endproc UI_SPLevelMenu_SetBots 1064 12
proc UI_SPLevelMenu_SetMenuArena 84 12
line 201
;194:
;195:
;196:/*
;197:=================
;198:UI_SPLevelMenu_SetMenuItems
;199:=================
;200:*/
;201:static void UI_SPLevelMenu_SetMenuArena( int n, int level, const char *arenaInfo ) {
line 204
;202:	char		map[MAX_QPATH];
;203:
;204:	Q_strncpyz( map, Info_ValueForKey( arenaInfo, "map" ), sizeof(map) );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 64
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 64
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 206
;205:
;206:	Q_strncpyz( levelMenuInfo.levelNames[n], map, sizeof(levelMenuInfo.levelNames[n]) );
ADDRFP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 levelMenuInfo+2348
ADDP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 207
;207:	Q_strupr( levelMenuInfo.levelNames[n] );
ADDRFP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 levelMenuInfo+2348
ADDP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 209
;208:
;209:	UI_GetBestScore( level, &levelMenuInfo.levelScores[n], &levelMenuInfo.levelScoresSkill[n] );
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 68
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2412
ADDP4
ARGP4
ADDRLP4 68
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2428
ADDP4
ARGP4
ADDRGP4 UI_GetBestScore
CALLV
pop
line 210
;210:	if( levelMenuInfo.levelScores[n] > 8 ) {
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2412
ADDP4
INDIRI4
CNSTI4 8
LEI4 $151
line 211
;211:		levelMenuInfo.levelScores[n] = 8;
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2412
ADDP4
CNSTI4 8
ASGNI4
line 212
;212:	}
LABELV $151
line 214
;213:
;214:	strcpy( levelMenuInfo.levelPicNames[n], va( "levelshots/%s.tga", map ) );
ADDRGP4 $156
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 levelMenuInfo+2092
ADDP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 215
;215:	if( !trap_R_RegisterShaderNoMip( levelMenuInfo.levelPicNames[n] ) ) {
ADDRFP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 levelMenuInfo+2092
ADDP4
ARGP4
ADDRLP4 76
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $157
line 216
;216:		strcpy( levelMenuInfo.levelPicNames[n], ART_MAP_UNKNOWN );
ADDRFP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 levelMenuInfo+2092
ADDP4
ARGP4
ADDRGP4 $161
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 217
;217:	}
LABELV $157
line 218
;218:	levelMenuInfo.item_maps[n].shader = 0;
ADDRFP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+584+68
ADDP4
CNSTI4 0
ASGNI4
line 219
;219:	if ( selectedArenaSet > currentSet ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 currentSet
INDIRI4
LEI4 $164
line 220
;220:		levelMenuInfo.item_maps[n].generic.flags |= QMF_GRAYED;
ADDRLP4 80
ADDRFP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+584+44
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRU4
CNSTU4 8192
BORU4
ASGNU4
line 221
;221:	}
ADDRGP4 $165
JUMPV
LABELV $164
line 222
;222:	else {
line 223
;223:		levelMenuInfo.item_maps[n].generic.flags &= ~QMF_GRAYED;
ADDRLP4 80
ADDRFP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+584+44
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRU4
CNSTU4 4294959103
BANDU4
ASGNU4
line 224
;224:	}
LABELV $165
line 226
;225:
;226:	levelMenuInfo.item_maps[n].generic.flags &= ~QMF_INACTIVE;
ADDRLP4 80
ADDRFP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+584+44
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRU4
CNSTU4 4294950911
BANDU4
ASGNU4
line 227
;227:}
LABELV $144
endproc UI_SPLevelMenu_SetMenuArena 84 12
proc UI_SPLevelMenu_SetMenuItems 44 12
line 229
;228:
;229:static void UI_SPLevelMenu_SetMenuItems( void ) {
line 234
;230:	int			n;
;231:	int			level;
;232:	const char	*arenaInfo;
;233:
;234:	if ( selectedArenaSet > currentSet ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 currentSet
INDIRI4
LEI4 $173
line 235
;235:		selectedArena = -1;
ADDRGP4 selectedArena
CNSTI4 -1
ASGNI4
line 236
;236:	}
ADDRGP4 $174
JUMPV
LABELV $173
line 237
;237:	else if ( selectedArena == -1 ) {
ADDRGP4 selectedArena
INDIRI4
CNSTI4 -1
NEI4 $175
line 238
;238:		selectedArena = 0;
ADDRGP4 selectedArena
CNSTI4 0
ASGNI4
line 239
;239:	}
LABELV $175
LABELV $174
line 241
;240:
;241:	if( selectedArenaSet == trainingTier || selectedArenaSet == finalTier ) {
ADDRLP4 12
ADDRGP4 selectedArenaSet
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 trainingTier
INDIRI4
EQI4 $179
ADDRLP4 12
INDIRI4
ADDRGP4 finalTier
INDIRI4
NEI4 $177
LABELV $179
line 242
;242:		selectedArena = 0;
ADDRGP4 selectedArena
CNSTI4 0
ASGNI4
line 243
;243:	}
LABELV $177
line 245
;244:
;245:	if( selectedArena != -1 ) {
ADDRGP4 selectedArena
INDIRI4
CNSTI4 -1
EQI4 $180
line 246
;246:		trap_Cvar_SetValue( "ui_spSelection", selectedArenaSet * ARENAS_PER_TIER + selectedArena );
ADDRGP4 $182
ARGP4
ADDRGP4 selectedArenaSet
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 selectedArena
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 247
;247:	}
LABELV $180
line 249
;248:
;249:	if( selectedArenaSet == trainingTier ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 trainingTier
INDIRI4
NEI4 $183
line 250
;250:		arenaInfo = UI_GetSpecialArenaInfo( "training" );
ADDRGP4 $185
ARGP4
ADDRLP4 16
ADDRGP4 UI_GetSpecialArenaInfo
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 251
;251:		level = atoi( Info_ValueForKey( arenaInfo, "num" ) );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $186
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
line 252
;252:		UI_SPLevelMenu_SetMenuArena( 0, level, arenaInfo );
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_SPLevelMenu_SetMenuArena
CALLV
pop
line 253
;253:		levelMenuInfo.selectedArenaInfo = arenaInfo;
ADDRGP4 levelMenuInfo+2084
ADDRLP4 8
INDIRP4
ASGNP4
line 255
;254:
;255:		levelMenuInfo.item_maps[0].generic.x = 256;
ADDRGP4 levelMenuInfo+584+12
CNSTI4 256
ASGNI4
line 256
;256:		Bitmap_Init( &levelMenuInfo.item_maps[0] );
ADDRGP4 levelMenuInfo+584
ARGP4
ADDRGP4 Bitmap_Init
CALLV
pop
line 257
;257:		levelMenuInfo.item_maps[0].generic.bottom += 32;
ADDRLP4 28
ADDRGP4 levelMenuInfo+584+32
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 258
;258:		levelMenuInfo.numMaps = 1;
ADDRGP4 levelMenuInfo+2088
CNSTI4 1
ASGNI4
line 260
;259:
;260:		levelMenuInfo.item_maps[1].generic.flags |= QMF_INACTIVE;
ADDRLP4 32
ADDRGP4 levelMenuInfo+584+88+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 261
;261:		levelMenuInfo.item_maps[2].generic.flags |= QMF_INACTIVE;
ADDRLP4 36
ADDRGP4 levelMenuInfo+584+176+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 262
;262:		levelMenuInfo.item_maps[3].generic.flags |= QMF_INACTIVE;
ADDRLP4 40
ADDRGP4 levelMenuInfo+584+264+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 263
;263:		levelMenuInfo.levelPicNames[1][0] = 0;
ADDRGP4 levelMenuInfo+2092+64
CNSTI1 0
ASGNI1
line 264
;264:		levelMenuInfo.levelPicNames[2][0] = 0;
ADDRGP4 levelMenuInfo+2092+128
CNSTI1 0
ASGNI1
line 265
;265:		levelMenuInfo.levelPicNames[3][0] = 0;
ADDRGP4 levelMenuInfo+2092+192
CNSTI1 0
ASGNI1
line 266
;266:		levelMenuInfo.item_maps[1].shader = 0;
ADDRGP4 levelMenuInfo+584+88+68
CNSTI4 0
ASGNI4
line 267
;267:		levelMenuInfo.item_maps[2].shader = 0;
ADDRGP4 levelMenuInfo+584+176+68
CNSTI4 0
ASGNI4
line 268
;268:		levelMenuInfo.item_maps[3].shader = 0;
ADDRGP4 levelMenuInfo+584+264+68
CNSTI4 0
ASGNI4
line 269
;269:	}
ADDRGP4 $184
JUMPV
LABELV $183
line 270
;270:	else if( selectedArenaSet == finalTier ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 finalTier
INDIRI4
NEI4 $218
line 271
;271:		arenaInfo = UI_GetSpecialArenaInfo( "final" );
ADDRGP4 $220
ARGP4
ADDRLP4 16
ADDRGP4 UI_GetSpecialArenaInfo
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 16
INDIRP4
ASGNP4
line 272
;272:		level = atoi( Info_ValueForKey( arenaInfo, "num" ) );
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 $186
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 24
INDIRI4
ASGNI4
line 273
;273:		UI_SPLevelMenu_SetMenuArena( 0, level, arenaInfo );
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_SPLevelMenu_SetMenuArena
CALLV
pop
line 274
;274:		levelMenuInfo.selectedArenaInfo = arenaInfo;
ADDRGP4 levelMenuInfo+2084
ADDRLP4 8
INDIRP4
ASGNP4
line 276
;275:
;276:		levelMenuInfo.item_maps[0].generic.x = 256;
ADDRGP4 levelMenuInfo+584+12
CNSTI4 256
ASGNI4
line 277
;277:		Bitmap_Init( &levelMenuInfo.item_maps[0] );
ADDRGP4 levelMenuInfo+584
ARGP4
ADDRGP4 Bitmap_Init
CALLV
pop
line 278
;278:		levelMenuInfo.item_maps[0].generic.bottom += 32;
ADDRLP4 28
ADDRGP4 levelMenuInfo+584+32
ASGNP4
ADDRLP4 28
INDIRP4
ADDRLP4 28
INDIRP4
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 279
;279:		levelMenuInfo.numMaps = 1;
ADDRGP4 levelMenuInfo+2088
CNSTI4 1
ASGNI4
line 281
;280:
;281:		levelMenuInfo.item_maps[1].generic.flags |= QMF_INACTIVE;
ADDRLP4 32
ADDRGP4 levelMenuInfo+584+88+44
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 282
;282:		levelMenuInfo.item_maps[2].generic.flags |= QMF_INACTIVE;
ADDRLP4 36
ADDRGP4 levelMenuInfo+584+176+44
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 283
;283:		levelMenuInfo.item_maps[3].generic.flags |= QMF_INACTIVE;
ADDRLP4 40
ADDRGP4 levelMenuInfo+584+264+44
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRU4
CNSTU4 16384
BORU4
ASGNU4
line 284
;284:		levelMenuInfo.levelPicNames[1][0] = 0;
ADDRGP4 levelMenuInfo+2092+64
CNSTI1 0
ASGNI1
line 285
;285:		levelMenuInfo.levelPicNames[2][0] = 0;
ADDRGP4 levelMenuInfo+2092+128
CNSTI1 0
ASGNI1
line 286
;286:		levelMenuInfo.levelPicNames[3][0] = 0;
ADDRGP4 levelMenuInfo+2092+192
CNSTI1 0
ASGNI1
line 287
;287:		levelMenuInfo.item_maps[1].shader = 0;
ADDRGP4 levelMenuInfo+584+88+68
CNSTI4 0
ASGNI4
line 288
;288:		levelMenuInfo.item_maps[2].shader = 0;
ADDRGP4 levelMenuInfo+584+176+68
CNSTI4 0
ASGNI4
line 289
;289:		levelMenuInfo.item_maps[3].shader = 0;
ADDRGP4 levelMenuInfo+584+264+68
CNSTI4 0
ASGNI4
line 290
;290:	}
ADDRGP4 $219
JUMPV
LABELV $218
line 291
;291:	else {
line 292
;292:		levelMenuInfo.item_maps[0].generic.x = 46;
ADDRGP4 levelMenuInfo+584+12
CNSTI4 46
ASGNI4
line 293
;293:		Bitmap_Init( &levelMenuInfo.item_maps[0] );
ADDRGP4 levelMenuInfo+584
ARGP4
ADDRGP4 Bitmap_Init
CALLV
pop
line 294
;294:		levelMenuInfo.item_maps[0].generic.bottom += 18;
ADDRLP4 16
ADDRGP4 levelMenuInfo+584+32
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 295
;295:		levelMenuInfo.numMaps = 4;
ADDRGP4 levelMenuInfo+2088
CNSTI4 4
ASGNI4
line 297
;296:
;297:		for ( n = 0; n < 4; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $258
line 298
;298:			level = selectedArenaSet * ARENAS_PER_TIER + n;
ADDRLP4 4
ADDRGP4 selectedArenaSet
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 299
;299:			arenaInfo = UI_GetArenaInfoByNumber( level );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 300
;300:			UI_SPLevelMenu_SetMenuArena( n, level, arenaInfo );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 UI_SPLevelMenu_SetMenuArena
CALLV
pop
line 301
;301:		}
LABELV $259
line 297
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $258
line 303
;302:
;303:		if( selectedArena != -1 ) {
ADDRGP4 selectedArena
INDIRI4
CNSTI4 -1
EQI4 $262
line 304
;304:			levelMenuInfo.selectedArenaInfo = UI_GetArenaInfoByNumber( selectedArenaSet * ARENAS_PER_TIER + selectedArena );
ADDRGP4 selectedArenaSet
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 selectedArena
INDIRI4
ADDI4
ARGI4
ADDRLP4 20
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRGP4 levelMenuInfo+2084
ADDRLP4 20
INDIRP4
ASGNP4
line 305
;305:		}
LABELV $262
line 306
;306:	}
LABELV $219
LABELV $184
line 309
;307:
;308:	// enable/disable arrows when they are valid/invalid
;309:	if ( selectedArenaSet == minTier ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 minTier
INDIRI4
NEI4 $265
line 310
;310:		levelMenuInfo.item_leftarrow.generic.flags |= ( QMF_INACTIVE | QMF_HIDDEN );
ADDRLP4 16
ADDRGP4 levelMenuInfo+496+44
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 311
;311:	}
ADDRGP4 $266
JUMPV
LABELV $265
line 312
;312:	else {
line 313
;313:		levelMenuInfo.item_leftarrow.generic.flags &= ~( QMF_INACTIVE | QMF_HIDDEN );
ADDRLP4 16
ADDRGP4 levelMenuInfo+496+44
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 4294946815
BANDU4
ASGNU4
line 314
;314:	}
LABELV $266
line 316
;315:
;316:	if ( selectedArenaSet == maxTier ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 maxTier
INDIRI4
NEI4 $271
line 317
;317:		levelMenuInfo.item_rightarrow.generic.flags |= ( QMF_INACTIVE | QMF_HIDDEN );
ADDRLP4 16
ADDRGP4 levelMenuInfo+936+44
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 20480
BORU4
ASGNU4
line 318
;318:	}
ADDRGP4 $272
JUMPV
LABELV $271
line 319
;319:	else {
line 320
;320:		levelMenuInfo.item_rightarrow.generic.flags &= ~( QMF_INACTIVE | QMF_HIDDEN );
ADDRLP4 16
ADDRGP4 levelMenuInfo+936+44
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRU4
CNSTU4 4294946815
BANDU4
ASGNU4
line 321
;321:	}
LABELV $272
line 323
;322:
;323:	UI_SPLevelMenu_SetBots();
ADDRGP4 UI_SPLevelMenu_SetBots
CALLV
pop
line 324
;324:}
LABELV $172
endproc UI_SPLevelMenu_SetMenuItems 44 12
proc UI_SPLevelMenu_ResetDraw 0 20
line 332
;325:
;326:
;327:/*
;328:=================
;329:UI_SPLevelMenu_ResetEvent
;330:=================
;331:*/
;332:static void UI_SPLevelMenu_ResetDraw( void ) {
line 333
;333:	UI_DrawProportionalString( SCREEN_WIDTH/2, 356 + PROP_HEIGHT * 0, "WARNING: This resets all of the", UI_CENTER|UI_SMALLFONT, color_yellow );
CNSTI4 320
ARGI4
CNSTI4 356
ARGI4
ADDRGP4 $278
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_yellow
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 334
;334:	UI_DrawProportionalString( SCREEN_WIDTH/2, 356 + PROP_HEIGHT * 1, "single player game variables.", UI_CENTER|UI_SMALLFONT, color_yellow );
CNSTI4 320
ARGI4
CNSTI4 383
ARGI4
ADDRGP4 $279
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_yellow
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 335
;335:	UI_DrawProportionalString( SCREEN_WIDTH/2, 356 + PROP_HEIGHT * 2, "Do this only if you want to", UI_CENTER|UI_SMALLFONT, color_yellow );
CNSTI4 320
ARGI4
CNSTI4 410
ARGI4
ADDRGP4 $280
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_yellow
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 336
;336:	UI_DrawProportionalString( SCREEN_WIDTH/2, 356 + PROP_HEIGHT * 3, "start over from the beginning.", UI_CENTER|UI_SMALLFONT, color_yellow );
CNSTI4 320
ARGI4
CNSTI4 437
ARGI4
ADDRGP4 $281
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_yellow
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 337
;337:}
LABELV $277
endproc UI_SPLevelMenu_ResetDraw 0 20
proc UI_SPLevelMenu_ResetAction 0 8
line 339
;338:
;339:static void UI_SPLevelMenu_ResetAction( qboolean result ) {
line 340
;340:	if( !result ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $283
line 341
;341:		return;
ADDRGP4 $282
JUMPV
LABELV $283
line 345
;342:	}
;343:
;344:	// clear game variables
;345:	UI_NewGame();
ADDRGP4 UI_NewGame
CALLV
pop
line 346
;346:	trap_Cvar_SetValue( "ui_spSelection", -4 );
ADDRGP4 $182
ARGP4
CNSTF4 3229614080
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 349
;347:
;348:	// make the level select menu re-initialize
;349:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 350
;350:	UI_SPLevelMenu();
ADDRGP4 UI_SPLevelMenu
CALLV
pop
line 351
;351:}
LABELV $282
endproc UI_SPLevelMenu_ResetAction 0 8
proc UI_SPLevelMenu_ResetEvent 0 12
line 354
;352:
;353:static void UI_SPLevelMenu_ResetEvent( void* ptr, int event )
;354:{
line 355
;355:	if (event != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $286
line 356
;356:		return;
ADDRGP4 $285
JUMPV
LABELV $286
line 359
;357:	}
;358:
;359:	UI_ConfirmMenu( "RESET GAME?", UI_SPLevelMenu_ResetDraw, UI_SPLevelMenu_ResetAction );
ADDRGP4 $288
ARGP4
ADDRGP4 UI_SPLevelMenu_ResetDraw
ARGP4
ADDRGP4 UI_SPLevelMenu_ResetAction
ARGP4
ADDRGP4 UI_ConfirmMenu
CALLV
pop
line 360
;360:}
LABELV $285
endproc UI_SPLevelMenu_ResetEvent 0 12
proc UI_SPLevelMenu_LevelEvent 8 8
line 368
;361:
;362:
;363:/*
;364:=================
;365:UI_SPLevelMenu_LevelEvent
;366:=================
;367:*/
;368:static void UI_SPLevelMenu_LevelEvent( void* ptr, int notification ) {
line 369
;369:	if (notification != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $290
line 370
;370:		return;
ADDRGP4 $289
JUMPV
LABELV $290
line 373
;371:	}
;372:
;373:	if ( selectedArenaSet == trainingTier || selectedArenaSet == finalTier ) {
ADDRLP4 0
ADDRGP4 selectedArenaSet
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRGP4 trainingTier
INDIRI4
EQI4 $294
ADDRLP4 0
INDIRI4
ADDRGP4 finalTier
INDIRI4
NEI4 $292
LABELV $294
line 374
;374:		return;
ADDRGP4 $289
JUMPV
LABELV $292
line 377
;375:	}
;376:
;377:	selectedArena = ((menucommon_s*)ptr)->id - ID_PICTURE0;
ADDRGP4 selectedArena
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 11
SUBI4
ASGNI4
line 378
;378:	levelMenuInfo.selectedArenaInfo = UI_GetArenaInfoByNumber( selectedArenaSet * ARENAS_PER_TIER + selectedArena );
ADDRGP4 selectedArenaSet
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 selectedArena
INDIRI4
ADDI4
ARGI4
ADDRLP4 4
ADDRGP4 UI_GetArenaInfoByNumber
CALLP4
ASGNP4
ADDRGP4 levelMenuInfo+2084
ADDRLP4 4
INDIRP4
ASGNP4
line 379
;379:	UI_SPLevelMenu_SetBots();
ADDRGP4 UI_SPLevelMenu_SetBots
CALLV
pop
line 381
;380:
;381:	trap_Cvar_SetValue( "ui_spSelection", selectedArenaSet * ARENAS_PER_TIER + selectedArena );
ADDRGP4 $182
ARGP4
ADDRGP4 selectedArenaSet
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 selectedArena
INDIRI4
ADDI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 382
;382:}
LABELV $289
endproc UI_SPLevelMenu_LevelEvent 8 8
proc UI_SPLevelMenu_LeftArrowEvent 4 0
line 390
;383:
;384:
;385:/*
;386:=================
;387:UI_SPLevelMenu_LeftArrowEvent
;388:=================
;389:*/
;390:static void UI_SPLevelMenu_LeftArrowEvent( void* ptr, int notification ) {
line 391
;391:	if (notification != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $297
line 392
;392:		return;
ADDRGP4 $296
JUMPV
LABELV $297
line 395
;393:	}
;394:
;395:	if ( selectedArenaSet == minTier ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 minTier
INDIRI4
NEI4 $299
line 396
;396:		return;
ADDRGP4 $296
JUMPV
LABELV $299
line 399
;397:	}
;398:
;399:	selectedArenaSet--;
ADDRLP4 0
ADDRGP4 selectedArenaSet
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 400
;400:	UI_SPLevelMenu_SetMenuItems();
ADDRGP4 UI_SPLevelMenu_SetMenuItems
CALLV
pop
line 401
;401:}
LABELV $296
endproc UI_SPLevelMenu_LeftArrowEvent 4 0
proc UI_SPLevelMenu_RightArrowEvent 4 0
line 409
;402:
;403:
;404:/*
;405:=================
;406:UI_SPLevelMenu_RightArrowEvent
;407:=================
;408:*/
;409:static void UI_SPLevelMenu_RightArrowEvent( void* ptr, int notification ) {
line 410
;410:	if (notification != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $302
line 411
;411:		return;
ADDRGP4 $301
JUMPV
LABELV $302
line 414
;412:	}
;413:
;414:	if ( selectedArenaSet == maxTier ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 maxTier
INDIRI4
NEI4 $304
line 415
;415:		return;
ADDRGP4 $301
JUMPV
LABELV $304
line 418
;416:	}
;417:
;418:	selectedArenaSet++;
ADDRLP4 0
ADDRGP4 selectedArenaSet
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 419
;419:	UI_SPLevelMenu_SetMenuItems();
ADDRGP4 UI_SPLevelMenu_SetMenuItems
CALLV
pop
line 420
;420:}
LABELV $301
endproc UI_SPLevelMenu_RightArrowEvent 4 0
proc UI_SPLevelMenu_PlayerEvent 0 0
line 428
;421:
;422:
;423:/*
;424:=================
;425:UI_SPLevelMenu_PlayerEvent
;426:=================
;427:*/
;428:static void UI_SPLevelMenu_PlayerEvent( void* ptr, int notification ) {
line 429
;429:	if (notification != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $307
line 430
;430:		return;
ADDRGP4 $306
JUMPV
LABELV $307
line 433
;431:	}
;432:
;433:	UI_PlayerSettingsMenu();
ADDRGP4 UI_PlayerSettingsMenu
CALLV
pop
line 434
;434:}
LABELV $306
endproc UI_SPLevelMenu_PlayerEvent 0 0
proc UI_SPLevelMenu_AwardEvent 4 8
line 442
;435:
;436:
;437:/*
;438:=================
;439:UI_SPLevelMenu_AwardEvent
;440:=================
;441:*/
;442:static void UI_SPLevelMenu_AwardEvent( void* ptr, int notification ) {
line 445
;443:	int		n;
;444:
;445:	if (notification != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $310
line 446
;446:		return;
ADDRGP4 $309
JUMPV
LABELV $310
line 449
;447:	}
;448:
;449:	n = ((menucommon_s*)ptr)->id - ID_AWARD1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
CNSTI4 17
SUBI4
ASGNI4
line 450
;450:	trap_S_StartLocalSound( levelMenuInfo.awardSounds[n], CHAN_ANNOUNCER );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2624
ADDP4
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 451
;451:}
LABELV $309
endproc UI_SPLevelMenu_AwardEvent 4 8
proc UI_SPLevelMenu_NextEvent 0 4
line 459
;452:
;453:
;454:/*
;455:=================
;456:UI_SPLevelMenu_NextEvent
;457:=================
;458:*/
;459:static void UI_SPLevelMenu_NextEvent( void* ptr, int notification ) {
line 460
;460:	if (notification != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $314
line 461
;461:		return;
ADDRGP4 $313
JUMPV
LABELV $314
line 464
;462:	}
;463:
;464:	if ( selectedArenaSet > currentSet ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 currentSet
INDIRI4
LEI4 $316
line 465
;465:		return;
ADDRGP4 $313
JUMPV
LABELV $316
line 468
;466:	}
;467:
;468:	if ( selectedArena == -1 ) {
ADDRGP4 selectedArena
INDIRI4
CNSTI4 -1
NEI4 $318
line 469
;469:		selectedArena = 0;
ADDRGP4 selectedArena
CNSTI4 0
ASGNI4
line 470
;470:	}
LABELV $318
line 472
;471:
;472:	UI_SPSkillMenu( levelMenuInfo.selectedArenaInfo );
ADDRGP4 levelMenuInfo+2084
INDIRP4
ARGP4
ADDRGP4 UI_SPSkillMenu
CALLV
pop
line 473
;473:}
LABELV $313
endproc UI_SPLevelMenu_NextEvent 0 4
proc UI_SPLevelMenu_BackEvent 0 0
line 481
;474:
;475:
;476:/*
;477:=================
;478:UI_SPLevelMenu_BackEvent
;479:=================
;480:*/
;481:static void UI_SPLevelMenu_BackEvent( void* ptr, int notification ) {
line 482
;482:	if (notification != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $322
line 483
;483:		return;
ADDRGP4 $321
JUMPV
LABELV $322
line 486
;484:	}
;485:
;486:	if ( selectedArena == -1 ) {
ADDRGP4 selectedArena
INDIRI4
CNSTI4 -1
NEI4 $324
line 487
;487:		selectedArena = 0;
ADDRGP4 selectedArena
CNSTI4 0
ASGNI4
line 488
;488:	}
LABELV $324
line 490
;489:
;490:	UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 491
;491:}
LABELV $321
endproc UI_SPLevelMenu_BackEvent 0 0
proc UI_SPLevelMenu_CustomEvent 0 4
line 499
;492:
;493:
;494:/*
;495:=================
;496:UI_SPLevelMenu_CustomEvent
;497:=================
;498:*/
;499:static void UI_SPLevelMenu_CustomEvent( void* ptr, int notification ) {
line 500
;500:	if (notification != QM_ACTIVATED) {
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $327
line 501
;501:		return;
ADDRGP4 $326
JUMPV
LABELV $327
line 504
;502:	}
;503:
;504:	UI_StartServerMenu( qfalse );
CNSTI4 0
ARGI4
ADDRGP4 UI_StartServerMenu
CALLV
pop
line 505
;505:}
LABELV $326
endproc UI_SPLevelMenu_CustomEvent 0 4
proc UI_SPLevelMenu_MenuDraw 1148 20
line 515
;506:
;507:
;508:/*
;509:=================
;510:UI_SPLevelMenu_MenuDraw
;511:=================
;512:*/
;513:#define LEVEL_DESC_LEFT_MARGIN		332
;514:
;515:static void UI_SPLevelMenu_MenuDraw( void ) {
line 525
;516:	int				n, i;
;517:	int				x, y;
;518:	vec4_t			color;
;519:	int				level;
;520://	int				fraglimit;
;521:	int				pad;
;522:	char			buf[MAX_INFO_VALUE];
;523:	char			string[64];
;524:
;525:	if(	levelMenuInfo.reinit ) {
ADDRGP4 levelMenuInfo+2080
INDIRI4
CNSTI4 0
EQI4 $330
line 526
;526:		UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 527
;527:		UI_SPLevelMenu();
ADDRGP4 UI_SPLevelMenu
CALLV
pop
line 528
;528:		return;
ADDRGP4 $329
JUMPV
LABELV $330
line 532
;529:	}
;530:
;531:	// draw player name
;532:	trap_Cvar_VariableStringBuffer( "name", string, 32 );
ADDRGP4 $135
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 533
;533:	Q_CleanStr( string );
ADDRLP4 16
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 534
;534:	UI_DrawProportionalString( 320, PLAYER_Y, string, UI_CENTER|UI_SMALLFONT, color_orange );
CNSTI4 320
ARGI4
CNSTI4 314
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 537
;535:
;536:	// check for model changes
;537:	trap_Cvar_VariableStringBuffer( "model", buf, sizeof(buf) );
ADDRGP4 $132
ARGP4
ADDRLP4 104
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 538
;538:	if( Q_stricmp( buf, levelMenuInfo.playerModel ) != 0 ) {
ADDRLP4 104
ARGP4
ADDRGP4 levelMenuInfo+2472
ARGP4
ADDRLP4 1128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 0
EQI4 $333
line 539
;539:		Q_strncpyz( levelMenuInfo.playerModel, buf, sizeof(levelMenuInfo.playerModel) );
ADDRGP4 levelMenuInfo+2472
ARGP4
ADDRLP4 104
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 540
;540:		PlayerIcon( levelMenuInfo.playerModel, levelMenuInfo.playerPicName, sizeof(levelMenuInfo.playerPicName) );
ADDRGP4 levelMenuInfo+2472
ARGP4
ADDRGP4 levelMenuInfo+2536
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 PlayerIcon
CALLV
pop
line 541
;541:		levelMenuInfo.item_player.shader = 0;
ADDRGP4 levelMenuInfo+1024+68
CNSTI4 0
ASGNI4
line 542
;542:	}
LABELV $333
line 545
;543:
;544:	// standard menu drawing
;545:	Menu_Draw( &levelMenuInfo.menu );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 Menu_Draw
CALLV
pop
line 548
;546:
;547:	// draw player award levels
;548:	y = AWARDS_Y;
ADDRLP4 8
CNSTI4 340
ASGNI4
line 549
;549:	i = 0;
ADDRLP4 80
CNSTI4 0
ASGNI4
line 550
;550:	for( n = 0; n < 6; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $343
line 551
;551:		level = levelMenuInfo.awardLevels[n];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2600
ADDP4
INDIRI4
ASGNI4
line 552
;552:		if( level > 0 ) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LEI4 $348
line 553
;553:			if( i & 1 ) {
ADDRLP4 80
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $350
line 554
;554:				x = 224 - (i - 1 ) / 2 * (48 + 16);
ADDRLP4 4
CNSTI4 224
ADDRLP4 80
INDIRI4
CNSTI4 1
SUBI4
CNSTI4 2
DIVI4
CNSTI4 6
LSHI4
SUBI4
ASGNI4
line 555
;555:			}
ADDRGP4 $351
JUMPV
LABELV $350
line 556
;556:			else {
line 557
;557:				x = 368 + i / 2 * (48 + 16);
ADDRLP4 4
ADDRLP4 80
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 6
LSHI4
CNSTI4 368
ADDI4
ASGNI4
line 558
;558:			}
LABELV $351
line 559
;559:			i++;
ADDRLP4 80
ADDRLP4 80
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 561
;560:
;561:			if( level == 1 ) {
ADDRLP4 12
INDIRI4
CNSTI4 1
NEI4 $352
line 562
;562:				continue;
ADDRGP4 $344
JUMPV
LABELV $352
line 565
;563:			}
;564:
;565:			if( level >= 1000000 ) {
ADDRLP4 12
INDIRI4
CNSTI4 1000000
LTI4 $354
line 566
;566:				Com_sprintf( string, sizeof(string), "%im", level / 1000000 );
ADDRLP4 16
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $356
ARGP4
ADDRLP4 12
INDIRI4
CNSTI4 1000000
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 567
;567:			}
ADDRGP4 $355
JUMPV
LABELV $354
line 568
;568:			else if( level >= 1000 ) {
ADDRLP4 12
INDIRI4
CNSTI4 1000
LTI4 $357
line 569
;569:				Com_sprintf( string, sizeof(string), "%ik", level / 1000 );
ADDRLP4 16
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $359
ARGP4
ADDRLP4 12
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 570
;570:			}
ADDRGP4 $358
JUMPV
LABELV $357
line 571
;571:			else {
line 572
;572:				Com_sprintf( string, sizeof(string), "%i", level );
ADDRLP4 16
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $360
ARGP4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 573
;573:			}
LABELV $358
LABELV $355
line 575
;574:
;575:			UI_DrawString( x + 24, y + 48, string, UI_CENTER, color_yellow );
ADDRLP4 4
INDIRI4
CNSTI4 24
ADDI4
ARGI4
ADDRLP4 8
INDIRI4
CNSTI4 48
ADDI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 color_yellow
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 576
;576:		}
LABELV $348
line 577
;577:	}
LABELV $344
line 550
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $343
line 579
;578:
;579:	UI_DrawProportionalString( 18, 38, va( "Tier %i", selectedArenaSet + 1 ), UI_LEFT|UI_SMALLFONT, color_orange );
ADDRGP4 $361
ARGP4
ADDRGP4 selectedArenaSet
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1132
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 18
ARGI4
CNSTI4 38
ARGI4
ADDRLP4 1132
INDIRP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 581
;580:
;581:	for ( n = 0; n < levelMenuInfo.numMaps; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $365
JUMPV
LABELV $362
line 582
;582:		x = levelMenuInfo.item_maps[n].generic.x;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+584+12
ADDP4
INDIRI4
ASGNI4
line 583
;583:		y = levelMenuInfo.item_maps[n].generic.y;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+584+16
ADDP4
INDIRI4
ASGNI4
line 584
;584:		UI_FillRect( x, y + 96, 128, 18, color_black );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 96
ADDI4
CVIF4 4
ARGF4
CNSTF4 1124073472
ARGF4
CNSTF4 1099956224
ARGF4
ADDRGP4 color_black
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 585
;585:	}
LABELV $363
line 581
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $365
ADDRLP4 0
INDIRI4
ADDRGP4 levelMenuInfo+2088
INDIRI4
LTI4 $362
line 587
;586:
;587:	if ( selectedArenaSet > currentSet ) {
ADDRGP4 selectedArenaSet
INDIRI4
ADDRGP4 currentSet
INDIRI4
LEI4 $371
line 588
;588:		UI_DrawProportionalString( 320, 216, "ACCESS DENIED", UI_CENTER|UI_BIGFONT, color_red );
CNSTI4 320
ARGI4
CNSTI4 216
ARGI4
ADDRGP4 $373
ARGP4
CNSTI4 33
ARGI4
ADDRGP4 color_red
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 589
;589:		return;
ADDRGP4 $329
JUMPV
LABELV $371
line 593
;590:	}
;591:
;592:	// show levelshots for levels of current tier
;593:	Vector4Copy( color_white, color );
ADDRLP4 88
ADDRGP4 color_white
INDIRF4
ASGNF4
ADDRLP4 88+4
ADDRGP4 color_white+4
INDIRF4
ASGNF4
ADDRLP4 88+8
ADDRGP4 color_white+8
INDIRF4
ASGNF4
ADDRLP4 88+12
ADDRGP4 color_white+12
INDIRF4
ASGNF4
line 594
;594:	color[3] = 0.5+0.5*sin(uis.realtime/PULSE_DIVISOR);
ADDRGP4 uis+4
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 1136
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 88+12
ADDRLP4 1136
INDIRF4
CNSTF4 1056964608
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 595
;595:	for ( n = 0; n < levelMenuInfo.numMaps; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $385
JUMPV
LABELV $382
line 596
;596:		x = levelMenuInfo.item_maps[n].generic.x;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+584+12
ADDP4
INDIRI4
ASGNI4
line 597
;597:		y = levelMenuInfo.item_maps[n].generic.y;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+584+16
ADDP4
INDIRI4
ASGNI4
line 599
;598:
;599:		UI_DrawString( x + 64, y + 96, levelMenuInfo.levelNames[n], UI_CENTER|UI_SMALLFONT, color_orange );
ADDRLP4 4
INDIRI4
CNSTI4 64
ADDI4
ARGI4
ADDRLP4 8
INDIRI4
CNSTI4 96
ADDI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 levelMenuInfo+2348
ADDP4
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 601
;600:
;601:		if( levelMenuInfo.levelScores[n] == 1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2412
ADDP4
INDIRI4
CNSTI4 1
NEI4 $392
line 602
;602:			UI_DrawHandlePic( x, y, 128, 96, levelMenuInfo.levelCompletePic[levelMenuInfo.levelScoresSkill[n] - 1] ); 
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1124073472
ARGF4
CNSTF4 1119879168
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2428
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2452-4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 603
;603:		}
LABELV $392
line 605
;604:
;605:		if ( n == selectedArena ) {
ADDRLP4 0
INDIRI4
ADDRGP4 selectedArena
INDIRI4
NEI4 $398
line 606
;606:			if( Menu_ItemAtCursor( &levelMenuInfo.menu ) == &levelMenuInfo.item_maps[n] ) {
ADDRGP4 levelMenuInfo
ARGP4
ADDRLP4 1140
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+584
ADDP4
CVPU4 4
ADDRLP4 1140
INDIRP4
CVPU4 4
NEU4 $400
line 607
;607:				trap_R_SetColor( color );
ADDRLP4 88
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 608
;608:			}
LABELV $400
line 609
;609:			UI_DrawHandlePic( x-1, y-1, 130, 130 - 14, levelMenuInfo.levelSelectedPic ); 
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
ARGF4
CNSTF4 1124204544
ARGF4
CNSTF4 1122500608
ARGF4
ADDRGP4 levelMenuInfo+2444
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 610
;610:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 611
;611:		}
ADDRGP4 $399
JUMPV
LABELV $398
line 612
;612:		else if( Menu_ItemAtCursor( &levelMenuInfo.menu ) == &levelMenuInfo.item_maps[n] ) {
ADDRGP4 levelMenuInfo
ARGP4
ADDRLP4 1140
ADDRGP4 Menu_ItemAtCursor
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+584
ADDP4
CVPU4 4
ADDRLP4 1140
INDIRP4
CVPU4 4
NEU4 $404
line 613
;613:			trap_R_SetColor( color );
ADDRLP4 88
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 614
;614:			UI_DrawHandlePic( x-31, y-30, 256, 256-27, levelMenuInfo.levelFocusPic); 
ADDRLP4 4
INDIRI4
CNSTI4 31
SUBI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 30
SUBI4
CVIF4 4
ARGF4
CNSTF4 1132462080
ARGF4
CNSTF4 1130692608
ARGF4
ADDRGP4 levelMenuInfo+2448
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 615
;615:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 616
;616:		}
LABELV $404
LABELV $399
line 617
;617:	}
LABELV $383
line 595
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $385
ADDRLP4 0
INDIRI4
ADDRGP4 levelMenuInfo+2088
INDIRI4
LTI4 $382
line 620
;618:
;619:	// show map name and long name of selected level
;620:	y = 192;
ADDRLP4 8
CNSTI4 192
ASGNI4
line 621
;621:	Q_strncpyz( buf, Info_ValueForKey( levelMenuInfo.selectedArenaInfo, "map" ), 20 );
ADDRGP4 levelMenuInfo+2084
INDIRP4
ARGP4
ADDRGP4 $145
ARGP4
ADDRLP4 1140
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 104
ARGP4
ADDRLP4 1140
INDIRP4
ARGP4
CNSTI4 20
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 622
;622:	Q_strupr( buf );
ADDRLP4 104
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 623
;623:	Com_sprintf( string, sizeof(string), "%s: %s", buf, Info_ValueForKey( levelMenuInfo.selectedArenaInfo, "longname" ) );
ADDRGP4 levelMenuInfo+2084
INDIRP4
ARGP4
ADDRGP4 $411
ARGP4
ADDRLP4 1144
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $409
ARGP4
ADDRLP4 104
ARGP4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 624
;624:	UI_DrawProportionalString( 320, y, string, UI_CENTER|UI_SMALLFONT, color_orange );
CNSTI4 320
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 17
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 630
;625:
;626://	fraglimit = atoi( Info_ValueForKey( levelMenuInfo.selectedArenaInfo, "fraglimit" ) );
;627://	UI_DrawString( 18, 212, va("Frags %i", fraglimit) , UI_LEFT|UI_SMALLFONT, color_orange );
;628:
;629:	// draw bot opponents
;630:	y += 24;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 631
;631:	pad = (7 - levelMenuInfo.numBots) * (64 + 26) / 2;
ADDRLP4 84
CNSTI4 7
ADDRGP4 levelMenuInfo+2648
INDIRI4
SUBI4
CNSTI4 90
MULI4
CNSTI4 2
DIVI4
ASGNI4
line 632
;632:	for( n = 0; n < levelMenuInfo.numBots; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $416
JUMPV
LABELV $413
line 633
;633:		x = 18 + pad + (64 + 26) * n;
ADDRLP4 4
ADDRLP4 84
INDIRI4
CNSTI4 18
ADDI4
ADDRLP4 0
INDIRI4
CNSTI4 90
MULI4
ADDI4
ASGNI4
line 634
;634:		if( levelMenuInfo.botPics[n] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2652
ADDP4
INDIRI4
CNSTI4 0
EQI4 $418
line 635
;635:			UI_DrawHandlePic( x, y, 64, 64, levelMenuInfo.botPics[n]);
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1115684864
ARGF4
CNSTF4 1115684864
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2652
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 636
;636:		}
ADDRGP4 $419
JUMPV
LABELV $418
line 637
;637:		else {
line 638
;638:			UI_FillRect( x, y, 64, 64, color_black );
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1115684864
ARGF4
CNSTF4 1115684864
ARGF4
ADDRGP4 color_black
ARGP4
ADDRGP4 UI_FillRect
CALLV
pop
line 639
;639:			UI_DrawProportionalString( x+22, y+18, "?", UI_BIGFONT, color_orange );
ADDRLP4 4
INDIRI4
CNSTI4 22
ADDI4
ARGI4
ADDRLP4 8
INDIRI4
CNSTI4 18
ADDI4
ARGI4
ADDRGP4 $422
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 640
;640:		}
LABELV $419
line 641
;641:		UI_DrawString( x, y + 64, levelMenuInfo.botNames[n], UI_SMALLFONT|UI_LEFT, color_orange );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
CNSTI4 64
ADDI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 10
MULI4
ADDRGP4 levelMenuInfo+2680
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 color_orange
ARGP4
ADDRGP4 UI_DrawString
CALLV
pop
line 642
;642:	}
LABELV $414
line 632
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $416
ADDRLP4 0
INDIRI4
ADDRGP4 levelMenuInfo+2648
INDIRI4
LTI4 $413
line 643
;643:}
LABELV $329
endproc UI_SPLevelMenu_MenuDraw 1148 20
export UI_SPLevelMenu_Cache
proc UI_SPLevelMenu_Cache 32 8
line 651
;644:
;645:
;646:/*
;647:=================
;648:UI_SPLevelMenu_Cache
;649:=================
;650:*/
;651:void UI_SPLevelMenu_Cache( void ) {
line 654
;652:	int				n;
;653:
;654:	trap_R_RegisterShaderNoMip( ART_LEVELFRAME_FOCUS );
ADDRGP4 $425
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 655
;655:	trap_R_RegisterShaderNoMip( ART_LEVELFRAME_SELECTED );
ADDRGP4 $426
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 656
;656:	trap_R_RegisterShaderNoMip( ART_ARROW );
ADDRGP4 $427
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 657
;657:	trap_R_RegisterShaderNoMip( ART_ARROW_FOCUS );
ADDRGP4 $428
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 658
;658:	trap_R_RegisterShaderNoMip( ART_MAP_UNKNOWN );
ADDRGP4 $161
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 659
;659:	trap_R_RegisterShaderNoMip( ART_MAP_COMPLETE1 );
ADDRGP4 $429
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 660
;660:	trap_R_RegisterShaderNoMip( ART_MAP_COMPLETE2 );
ADDRGP4 $430
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 661
;661:	trap_R_RegisterShaderNoMip( ART_MAP_COMPLETE3 );
ADDRGP4 $431
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 662
;662:	trap_R_RegisterShaderNoMip( ART_MAP_COMPLETE4 );
ADDRGP4 $432
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 663
;663:	trap_R_RegisterShaderNoMip( ART_MAP_COMPLETE5 );
ADDRGP4 $433
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 664
;664:	trap_R_RegisterShaderNoMip( ART_BACK0 );
ADDRGP4 $434
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 665
;665:	trap_R_RegisterShaderNoMip( ART_BACK1 );
ADDRGP4 $435
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 666
;666:	trap_R_RegisterShaderNoMip( ART_FIGHT0 );
ADDRGP4 $436
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 667
;667:	trap_R_RegisterShaderNoMip( ART_FIGHT1 );
ADDRGP4 $437
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 668
;668:	trap_R_RegisterShaderNoMip( ART_RESET0 );
ADDRGP4 $438
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 669
;669:	trap_R_RegisterShaderNoMip( ART_RESET1 );
ADDRGP4 $439
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 670
;670:	trap_R_RegisterShaderNoMip( ART_CUSTOM0 );
ADDRGP4 $440
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 671
;671:	trap_R_RegisterShaderNoMip( ART_CUSTOM1 );
ADDRGP4 $441
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 673
;672:
;673:	for( n = 0; n < 6; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $442
line 674
;674:		trap_R_RegisterShaderNoMip( ui_medalPicNames[n] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_medalPicNames
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 675
;675:		levelMenuInfo.awardSounds[n] = trap_S_RegisterSound( ui_medalSounds[n], qfalse );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_medalSounds
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2624
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 676
;676:	}
LABELV $443
line 673
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $442
line 678
;677:
;678:	levelMenuInfo.levelSelectedPic = trap_R_RegisterShaderNoMip( ART_LEVELFRAME_SELECTED );
ADDRGP4 $426
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 levelMenuInfo+2444
ADDRLP4 4
INDIRI4
ASGNI4
line 679
;679:	levelMenuInfo.levelFocusPic = trap_R_RegisterShaderNoMip( ART_LEVELFRAME_FOCUS );
ADDRGP4 $425
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 levelMenuInfo+2448
ADDRLP4 8
INDIRI4
ASGNI4
line 680
;680:	levelMenuInfo.levelCompletePic[0] = trap_R_RegisterShaderNoMip( ART_MAP_COMPLETE1 );
ADDRGP4 $429
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 levelMenuInfo+2452
ADDRLP4 12
INDIRI4
ASGNI4
line 681
;681:	levelMenuInfo.levelCompletePic[1] = trap_R_RegisterShaderNoMip( ART_MAP_COMPLETE2 );
ADDRGP4 $430
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 levelMenuInfo+2452+4
ADDRLP4 16
INDIRI4
ASGNI4
line 682
;682:	levelMenuInfo.levelCompletePic[2] = trap_R_RegisterShaderNoMip( ART_MAP_COMPLETE3 );
ADDRGP4 $431
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 levelMenuInfo+2452+8
ADDRLP4 20
INDIRI4
ASGNI4
line 683
;683:	levelMenuInfo.levelCompletePic[3] = trap_R_RegisterShaderNoMip( ART_MAP_COMPLETE4 );
ADDRGP4 $432
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 levelMenuInfo+2452+12
ADDRLP4 24
INDIRI4
ASGNI4
line 684
;684:	levelMenuInfo.levelCompletePic[4] = trap_R_RegisterShaderNoMip( ART_MAP_COMPLETE5 );
ADDRGP4 $433
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 levelMenuInfo+2452+16
ADDRLP4 28
INDIRI4
ASGNI4
line 685
;685:}
LABELV $424
endproc UI_SPLevelMenu_Cache 32 8
proc UI_SPLevelMenu_Init 112 12
line 693
;686:
;687:
;688:/*
;689:=================
;690:UI_SPLevelMenu_Init
;691:=================
;692:*/
;693:static void UI_SPLevelMenu_Init( void ) {
line 700
;694:	int		skill;
;695:	int		n;
;696:	int		x, y;
;697:	int		count;
;698:	char	buf[MAX_QPATH];
;699:
;700:	skill = (int)trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $459
ARGP4
ADDRLP4 84
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 84
INDIRF4
CVFI4 4
ASGNI4
line 701
;701:	if( skill < 1 || skill > 5 ) {
ADDRLP4 16
INDIRI4
CNSTI4 1
LTI4 $462
ADDRLP4 16
INDIRI4
CNSTI4 5
LEI4 $460
LABELV $462
line 702
;702:		trap_Cvar_Set( "g_spSkill", "2" );
ADDRGP4 $459
ARGP4
ADDRGP4 $463
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 703
;703:		skill = 2;
ADDRLP4 16
CNSTI4 2
ASGNI4
line 704
;704:	}
LABELV $460
line 706
;705:
;706:	memset( &levelMenuInfo, 0, sizeof(levelMenuInfo) );
ADDRGP4 levelMenuInfo
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2752
ARGI4
ADDRGP4 memset
CALLP4
pop
line 707
;707:	levelMenuInfo.menu.fullscreen = qtrue;
ADDRGP4 levelMenuInfo+408
CNSTI4 1
ASGNI4
line 708
;708:	levelMenuInfo.menu.wrapAround = qtrue;
ADDRGP4 levelMenuInfo+404
CNSTI4 1
ASGNI4
line 709
;709:	levelMenuInfo.menu.draw = UI_SPLevelMenu_MenuDraw;
ADDRGP4 levelMenuInfo+396
ADDRGP4 UI_SPLevelMenu_MenuDraw
ASGNP4
line 711
;710:
;711:	UI_SPLevelMenu_Cache();
ADDRGP4 UI_SPLevelMenu_Cache
CALLV
pop
line 713
;712:
;713:	levelMenuInfo.item_banner.generic.type			= MTYPE_BTEXT;
ADDRGP4 levelMenuInfo+424
CNSTI4 10
ASGNI4
line 714
;714:	levelMenuInfo.item_banner.generic.x				= 320;
ADDRGP4 levelMenuInfo+424+12
CNSTI4 320
ASGNI4
line 715
;715:	levelMenuInfo.item_banner.generic.y				= 16;
ADDRGP4 levelMenuInfo+424+16
CNSTI4 16
ASGNI4
line 716
;716:	levelMenuInfo.item_banner.string				= "CHOOSE LEVEL";
ADDRGP4 levelMenuInfo+424+60
ADDRGP4 $474
ASGNP4
line 717
;717:	levelMenuInfo.item_banner.color					= color_red;
ADDRGP4 levelMenuInfo+424+68
ADDRGP4 color_red
ASGNP4
line 718
;718:	levelMenuInfo.item_banner.style					= UI_CENTER;
ADDRGP4 levelMenuInfo+424+64
CNSTI4 1
ASGNI4
line 720
;719:
;720:	levelMenuInfo.item_leftarrow.generic.type		= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+496
CNSTI4 6
ASGNI4
line 721
;721:	levelMenuInfo.item_leftarrow.generic.name		= ART_ARROW;
ADDRGP4 levelMenuInfo+496+4
ADDRGP4 $427
ASGNP4
line 722
;722:	levelMenuInfo.item_leftarrow.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 levelMenuInfo+496+44
CNSTU4 260
ASGNU4
line 723
;723:	levelMenuInfo.item_leftarrow.generic.x			= 18;
ADDRGP4 levelMenuInfo+496+12
CNSTI4 18
ASGNI4
line 724
;724:	levelMenuInfo.item_leftarrow.generic.y			= 64;
ADDRGP4 levelMenuInfo+496+16
CNSTI4 64
ASGNI4
line 725
;725:	levelMenuInfo.item_leftarrow.generic.callback	= UI_SPLevelMenu_LeftArrowEvent;
ADDRGP4 levelMenuInfo+496+48
ADDRGP4 UI_SPLevelMenu_LeftArrowEvent
ASGNP4
line 726
;726:	levelMenuInfo.item_leftarrow.generic.id			= ID_LEFTARROW;
ADDRGP4 levelMenuInfo+496+8
CNSTI4 10
ASGNI4
line 727
;727:	levelMenuInfo.item_leftarrow.width				= 16;
ADDRGP4 levelMenuInfo+496+76
CNSTI4 16
ASGNI4
line 728
;728:	levelMenuInfo.item_leftarrow.height				= 114;
ADDRGP4 levelMenuInfo+496+80
CNSTI4 114
ASGNI4
line 729
;729:	levelMenuInfo.item_leftarrow.focuspic			= ART_ARROW_FOCUS;
ADDRGP4 levelMenuInfo+496+60
ADDRGP4 $428
ASGNP4
line 731
;730:
;731:	levelMenuInfo.item_maps[0].generic.type			= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+584
CNSTI4 6
ASGNI4
line 732
;732:	levelMenuInfo.item_maps[0].generic.name			= levelMenuInfo.levelPicNames[0];
ADDRGP4 levelMenuInfo+584+4
ADDRGP4 levelMenuInfo+2092
ASGNP4
line 733
;733:	levelMenuInfo.item_maps[0].generic.flags		= QMF_LEFT_JUSTIFY;
ADDRGP4 levelMenuInfo+584+44
CNSTU4 4
ASGNU4
line 734
;734:	levelMenuInfo.item_maps[0].generic.x			= 46;
ADDRGP4 levelMenuInfo+584+12
CNSTI4 46
ASGNI4
line 735
;735:	levelMenuInfo.item_maps[0].generic.y			= 64;
ADDRGP4 levelMenuInfo+584+16
CNSTI4 64
ASGNI4
line 736
;736:	levelMenuInfo.item_maps[0].generic.id			= ID_PICTURE0;
ADDRGP4 levelMenuInfo+584+8
CNSTI4 11
ASGNI4
line 737
;737:	levelMenuInfo.item_maps[0].generic.callback		= UI_SPLevelMenu_LevelEvent;
ADDRGP4 levelMenuInfo+584+48
ADDRGP4 UI_SPLevelMenu_LevelEvent
ASGNP4
line 738
;738:	levelMenuInfo.item_maps[0].width				= 128;
ADDRGP4 levelMenuInfo+584+76
CNSTI4 128
ASGNI4
line 739
;739:	levelMenuInfo.item_maps[0].height				= 96;
ADDRGP4 levelMenuInfo+584+80
CNSTI4 96
ASGNI4
line 741
;740:
;741:	levelMenuInfo.item_maps[1].generic.type			= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+584+88
CNSTI4 6
ASGNI4
line 742
;742:	levelMenuInfo.item_maps[1].generic.name			= levelMenuInfo.levelPicNames[1];
ADDRGP4 levelMenuInfo+584+88+4
ADDRGP4 levelMenuInfo+2092+64
ASGNP4
line 743
;743:	levelMenuInfo.item_maps[1].generic.flags		= QMF_LEFT_JUSTIFY;
ADDRGP4 levelMenuInfo+584+88+44
CNSTU4 4
ASGNU4
line 744
;744:	levelMenuInfo.item_maps[1].generic.x			= 186;
ADDRGP4 levelMenuInfo+584+88+12
CNSTI4 186
ASGNI4
line 745
;745:	levelMenuInfo.item_maps[1].generic.y			= 64;
ADDRGP4 levelMenuInfo+584+88+16
CNSTI4 64
ASGNI4
line 746
;746:	levelMenuInfo.item_maps[1].generic.id			= ID_PICTURE1;
ADDRGP4 levelMenuInfo+584+88+8
CNSTI4 12
ASGNI4
line 747
;747:	levelMenuInfo.item_maps[1].generic.callback		= UI_SPLevelMenu_LevelEvent;
ADDRGP4 levelMenuInfo+584+88+48
ADDRGP4 UI_SPLevelMenu_LevelEvent
ASGNP4
line 748
;748:	levelMenuInfo.item_maps[1].width				= 128;
ADDRGP4 levelMenuInfo+584+88+76
CNSTI4 128
ASGNI4
line 749
;749:	levelMenuInfo.item_maps[1].height				= 96;
ADDRGP4 levelMenuInfo+584+88+80
CNSTI4 96
ASGNI4
line 751
;750:
;751:	levelMenuInfo.item_maps[2].generic.type			= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+584+176
CNSTI4 6
ASGNI4
line 752
;752:	levelMenuInfo.item_maps[2].generic.name			= levelMenuInfo.levelPicNames[2];
ADDRGP4 levelMenuInfo+584+176+4
ADDRGP4 levelMenuInfo+2092+128
ASGNP4
line 753
;753:	levelMenuInfo.item_maps[2].generic.flags		= QMF_LEFT_JUSTIFY;
ADDRGP4 levelMenuInfo+584+176+44
CNSTU4 4
ASGNU4
line 754
;754:	levelMenuInfo.item_maps[2].generic.x			= 326;
ADDRGP4 levelMenuInfo+584+176+12
CNSTI4 326
ASGNI4
line 755
;755:	levelMenuInfo.item_maps[2].generic.y			= 64;
ADDRGP4 levelMenuInfo+584+176+16
CNSTI4 64
ASGNI4
line 756
;756:	levelMenuInfo.item_maps[2].generic.id			= ID_PICTURE2;
ADDRGP4 levelMenuInfo+584+176+8
CNSTI4 13
ASGNI4
line 757
;757:	levelMenuInfo.item_maps[2].generic.callback		= UI_SPLevelMenu_LevelEvent;
ADDRGP4 levelMenuInfo+584+176+48
ADDRGP4 UI_SPLevelMenu_LevelEvent
ASGNP4
line 758
;758:	levelMenuInfo.item_maps[2].width				= 128;
ADDRGP4 levelMenuInfo+584+176+76
CNSTI4 128
ASGNI4
line 759
;759:	levelMenuInfo.item_maps[2].height				= 96;
ADDRGP4 levelMenuInfo+584+176+80
CNSTI4 96
ASGNI4
line 761
;760:
;761:	levelMenuInfo.item_maps[3].generic.type			= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+584+264
CNSTI4 6
ASGNI4
line 762
;762:	levelMenuInfo.item_maps[3].generic.name			= levelMenuInfo.levelPicNames[3];
ADDRGP4 levelMenuInfo+584+264+4
ADDRGP4 levelMenuInfo+2092+192
ASGNP4
line 763
;763:	levelMenuInfo.item_maps[3].generic.flags		= QMF_LEFT_JUSTIFY;
ADDRGP4 levelMenuInfo+584+264+44
CNSTU4 4
ASGNU4
line 764
;764:	levelMenuInfo.item_maps[3].generic.x			= 466;
ADDRGP4 levelMenuInfo+584+264+12
CNSTI4 466
ASGNI4
line 765
;765:	levelMenuInfo.item_maps[3].generic.y			= 64;
ADDRGP4 levelMenuInfo+584+264+16
CNSTI4 64
ASGNI4
line 766
;766:	levelMenuInfo.item_maps[3].generic.id			= ID_PICTURE3;
ADDRGP4 levelMenuInfo+584+264+8
CNSTI4 14
ASGNI4
line 767
;767:	levelMenuInfo.item_maps[3].generic.callback		= UI_SPLevelMenu_LevelEvent;
ADDRGP4 levelMenuInfo+584+264+48
ADDRGP4 UI_SPLevelMenu_LevelEvent
ASGNP4
line 768
;768:	levelMenuInfo.item_maps[3].width				= 128;
ADDRGP4 levelMenuInfo+584+264+76
CNSTI4 128
ASGNI4
line 769
;769:	levelMenuInfo.item_maps[3].height				= 96;
ADDRGP4 levelMenuInfo+584+264+80
CNSTI4 96
ASGNI4
line 771
;770:
;771:	levelMenuInfo.item_rightarrow.generic.type		= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+936
CNSTI4 6
ASGNI4
line 772
;772:	levelMenuInfo.item_rightarrow.generic.name		= ART_ARROW;
ADDRGP4 levelMenuInfo+936+4
ADDRGP4 $427
ASGNP4
line 773
;773:	levelMenuInfo.item_rightarrow.generic.flags		= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 levelMenuInfo+936+44
CNSTU4 260
ASGNU4
line 774
;774:	levelMenuInfo.item_rightarrow.generic.x			= 606;
ADDRGP4 levelMenuInfo+936+12
CNSTI4 606
ASGNI4
line 775
;775:	levelMenuInfo.item_rightarrow.generic.y			= 64;
ADDRGP4 levelMenuInfo+936+16
CNSTI4 64
ASGNI4
line 776
;776:	levelMenuInfo.item_rightarrow.generic.callback	= UI_SPLevelMenu_RightArrowEvent;
ADDRGP4 levelMenuInfo+936+48
ADDRGP4 UI_SPLevelMenu_RightArrowEvent
ASGNP4
line 777
;777:	levelMenuInfo.item_rightarrow.generic.id		= ID_RIGHTARROW;
ADDRGP4 levelMenuInfo+936+8
CNSTI4 15
ASGNI4
line 778
;778:	levelMenuInfo.item_rightarrow.width				= -16;
ADDRGP4 levelMenuInfo+936+76
CNSTI4 -16
ASGNI4
line 779
;779:	levelMenuInfo.item_rightarrow.height			= 114;
ADDRGP4 levelMenuInfo+936+80
CNSTI4 114
ASGNI4
line 780
;780:	levelMenuInfo.item_rightarrow.focuspic			= ART_ARROW_FOCUS;
ADDRGP4 levelMenuInfo+936+60
ADDRGP4 $428
ASGNP4
line 782
;781:
;782:	trap_Cvar_VariableStringBuffer( "model", levelMenuInfo.playerModel, sizeof(levelMenuInfo.playerModel) );
ADDRGP4 $132
ARGP4
ADDRGP4 levelMenuInfo+2472
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 783
;783:	PlayerIcon( levelMenuInfo.playerModel, levelMenuInfo.playerPicName, sizeof(levelMenuInfo.playerPicName) );
ADDRGP4 levelMenuInfo+2472
ARGP4
ADDRGP4 levelMenuInfo+2536
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 PlayerIcon
CALLV
pop
line 784
;784:	levelMenuInfo.item_player.generic.type			= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+1024
CNSTI4 6
ASGNI4
line 785
;785:	levelMenuInfo.item_player.generic.name			= levelMenuInfo.playerPicName;
ADDRGP4 levelMenuInfo+1024+4
ADDRGP4 levelMenuInfo+2536
ASGNP4
line 786
;786:	levelMenuInfo.item_player.generic.flags			= QMF_LEFT_JUSTIFY|QMF_MOUSEONLY;
ADDRGP4 levelMenuInfo+1024+44
CNSTU4 2052
ASGNU4
line 787
;787:	levelMenuInfo.item_player.generic.x				= 288;
ADDRGP4 levelMenuInfo+1024+12
CNSTI4 288
ASGNI4
line 788
;788:	levelMenuInfo.item_player.generic.y				= AWARDS_Y;
ADDRGP4 levelMenuInfo+1024+16
CNSTI4 340
ASGNI4
line 789
;789:	levelMenuInfo.item_player.generic.id			= ID_PLAYERPIC;
ADDRGP4 levelMenuInfo+1024+8
CNSTI4 16
ASGNI4
line 790
;790:	levelMenuInfo.item_player.generic.callback		= UI_SPLevelMenu_PlayerEvent;
ADDRGP4 levelMenuInfo+1024+48
ADDRGP4 UI_SPLevelMenu_PlayerEvent
ASGNP4
line 791
;791:	levelMenuInfo.item_player.width					= 64;
ADDRGP4 levelMenuInfo+1024+76
CNSTI4 64
ASGNI4
line 792
;792:	levelMenuInfo.item_player.height				= 64;
ADDRGP4 levelMenuInfo+1024+80
CNSTI4 64
ASGNI4
line 794
;793:
;794:	for( n = 0; n < 6; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $642
line 795
;795:		levelMenuInfo.awardLevels[n] = UI_GetAwardLevel( n );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 96
ADDRGP4 UI_GetAwardLevel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2600
ADDP4
ADDRLP4 96
INDIRI4
ASGNI4
line 796
;796:	}
LABELV $643
line 794
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $642
line 797
;797:	levelMenuInfo.awardLevels[AWARD_FRAGS] = 100 * (levelMenuInfo.awardLevels[AWARD_FRAGS] / 100);
ADDRGP4 levelMenuInfo+2600+16
ADDRGP4 levelMenuInfo+2600+16
INDIRI4
CNSTI4 100
DIVI4
CNSTI4 100
MULI4
ASGNI4
line 799
;798:
;799:	y = AWARDS_Y;
ADDRLP4 12
CNSTI4 340
ASGNI4
line 800
;800:	count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 801
;801:	for( n = 0; n < 6; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $651
line 802
;802:		if( levelMenuInfo.awardLevels[n] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 levelMenuInfo+2600
ADDP4
INDIRI4
CNSTI4 0
EQI4 $655
line 803
;803:			if( count & 1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $658
line 804
;804:				x = 224 - (count - 1 ) / 2 * (48 + 16);
ADDRLP4 8
CNSTI4 224
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
CNSTI4 2
DIVI4
CNSTI4 6
LSHI4
SUBI4
ASGNI4
line 805
;805:			}
ADDRGP4 $659
JUMPV
LABELV $658
line 806
;806:			else {
line 807
;807:				x = 368 + count / 2 * (48 + 16);
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 6
LSHI4
CNSTI4 368
ADDI4
ASGNI4
line 808
;808:			}
LABELV $659
line 810
;809:
;810:			levelMenuInfo.item_awards[count].generic.type		= MTYPE_BITMAP;
ADDRLP4 4
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+1112
ADDP4
CNSTI4 6
ASGNI4
line 811
;811:			levelMenuInfo.item_awards[count].generic.name		= ui_medalPicNames[n];
ADDRLP4 4
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+1112+4
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ui_medalPicNames
ADDP4
INDIRP4
ASGNP4
line 812
;812:			levelMenuInfo.item_awards[count].generic.flags		= QMF_LEFT_JUSTIFY|QMF_SILENT|QMF_MOUSEONLY;
ADDRLP4 4
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+1112+44
ADDP4
CNSTU4 1050628
ASGNU4
line 813
;813:			levelMenuInfo.item_awards[count].generic.x			= x;
ADDRLP4 4
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+1112+12
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 814
;814:			levelMenuInfo.item_awards[count].generic.y			= y;
ADDRLP4 4
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+1112+16
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 815
;815:			levelMenuInfo.item_awards[count].generic.id			= ID_AWARD1 + n;
ADDRLP4 4
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+1112+8
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 17
ADDI4
ASGNI4
line 816
;816:			levelMenuInfo.item_awards[count].generic.callback	= UI_SPLevelMenu_AwardEvent;
ADDRLP4 4
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+1112+48
ADDP4
ADDRGP4 UI_SPLevelMenu_AwardEvent
ASGNP4
line 817
;817:			levelMenuInfo.item_awards[count].width				= 48;
ADDRLP4 4
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+1112+76
ADDP4
CNSTI4 48
ASGNI4
line 818
;818:			levelMenuInfo.item_awards[count].height				= 48;
ADDRLP4 4
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+1112+80
ADDP4
CNSTI4 48
ASGNI4
line 819
;819:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 820
;820:		}
LABELV $655
line 821
;821:	}
LABELV $652
line 801
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 6
LTI4 $651
line 823
;822:
;823:	levelMenuInfo.item_back.generic.type			= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+1640
CNSTI4 6
ASGNI4
line 824
;824:	levelMenuInfo.item_back.generic.name			= ART_BACK0;
ADDRGP4 levelMenuInfo+1640+4
ADDRGP4 $434
ASGNP4
line 825
;825:	levelMenuInfo.item_back.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 levelMenuInfo+1640+44
CNSTU4 260
ASGNU4
line 826
;826:	levelMenuInfo.item_back.generic.x				= 0;
ADDRGP4 levelMenuInfo+1640+12
CNSTI4 0
ASGNI4
line 827
;827:	levelMenuInfo.item_back.generic.y				= 480-64;
ADDRGP4 levelMenuInfo+1640+16
CNSTI4 416
ASGNI4
line 828
;828:	levelMenuInfo.item_back.generic.callback		= UI_SPLevelMenu_BackEvent;
ADDRGP4 levelMenuInfo+1640+48
ADDRGP4 UI_SPLevelMenu_BackEvent
ASGNP4
line 829
;829:	levelMenuInfo.item_back.generic.id				= ID_BACK;
ADDRGP4 levelMenuInfo+1640+8
CNSTI4 23
ASGNI4
line 830
;830:	levelMenuInfo.item_back.width					= 128;
ADDRGP4 levelMenuInfo+1640+76
CNSTI4 128
ASGNI4
line 831
;831:	levelMenuInfo.item_back.height					= 64;
ADDRGP4 levelMenuInfo+1640+80
CNSTI4 64
ASGNI4
line 832
;832:	levelMenuInfo.item_back.focuspic				= ART_BACK1;
ADDRGP4 levelMenuInfo+1640+60
ADDRGP4 $435
ASGNP4
line 834
;833:
;834:	levelMenuInfo.item_reset.generic.type			= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+1728
CNSTI4 6
ASGNI4
line 835
;835:	levelMenuInfo.item_reset.generic.name			= ART_RESET0;
ADDRGP4 levelMenuInfo+1728+4
ADDRGP4 $438
ASGNP4
line 836
;836:	levelMenuInfo.item_reset.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 levelMenuInfo+1728+44
CNSTU4 260
ASGNU4
line 837
;837:	levelMenuInfo.item_reset.generic.x				= 170;
ADDRGP4 levelMenuInfo+1728+12
CNSTI4 170
ASGNI4
line 838
;838:	levelMenuInfo.item_reset.generic.y				= 480-64;
ADDRGP4 levelMenuInfo+1728+16
CNSTI4 416
ASGNI4
line 839
;839:	levelMenuInfo.item_reset.generic.callback		= UI_SPLevelMenu_ResetEvent;
ADDRGP4 levelMenuInfo+1728+48
ADDRGP4 UI_SPLevelMenu_ResetEvent
ASGNP4
line 840
;840:	levelMenuInfo.item_reset.generic.id				= ID_RESET;
ADDRGP4 levelMenuInfo+1728+8
CNSTI4 24
ASGNI4
line 841
;841:	levelMenuInfo.item_reset.width					= 128;
ADDRGP4 levelMenuInfo+1728+76
CNSTI4 128
ASGNI4
line 842
;842:	levelMenuInfo.item_reset.height					= 64;
ADDRGP4 levelMenuInfo+1728+80
CNSTI4 64
ASGNI4
line 843
;843:	levelMenuInfo.item_reset.focuspic				= ART_RESET1;
ADDRGP4 levelMenuInfo+1728+60
ADDRGP4 $439
ASGNP4
line 845
;844:
;845:	levelMenuInfo.item_custom.generic.type			= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+1816
CNSTI4 6
ASGNI4
line 846
;846:	levelMenuInfo.item_custom.generic.name			= ART_CUSTOM0;
ADDRGP4 levelMenuInfo+1816+4
ADDRGP4 $440
ASGNP4
line 847
;847:	levelMenuInfo.item_custom.generic.flags			= QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 levelMenuInfo+1816+44
CNSTU4 260
ASGNU4
line 848
;848:	levelMenuInfo.item_custom.generic.x				= 342;
ADDRGP4 levelMenuInfo+1816+12
CNSTI4 342
ASGNI4
line 849
;849:	levelMenuInfo.item_custom.generic.y				= 480-64;
ADDRGP4 levelMenuInfo+1816+16
CNSTI4 416
ASGNI4
line 850
;850:	levelMenuInfo.item_custom.generic.callback		= UI_SPLevelMenu_CustomEvent;
ADDRGP4 levelMenuInfo+1816+48
ADDRGP4 UI_SPLevelMenu_CustomEvent
ASGNP4
line 851
;851:	levelMenuInfo.item_custom.generic.id			= ID_CUSTOM;
ADDRGP4 levelMenuInfo+1816+8
CNSTI4 25
ASGNI4
line 852
;852:	levelMenuInfo.item_custom.width					= 128;
ADDRGP4 levelMenuInfo+1816+76
CNSTI4 128
ASGNI4
line 853
;853:	levelMenuInfo.item_custom.height				= 64;
ADDRGP4 levelMenuInfo+1816+80
CNSTI4 64
ASGNI4
line 854
;854:	levelMenuInfo.item_custom.focuspic				= ART_CUSTOM1;
ADDRGP4 levelMenuInfo+1816+60
ADDRGP4 $441
ASGNP4
line 856
;855:
;856:	levelMenuInfo.item_next.generic.type			= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+1904
CNSTI4 6
ASGNI4
line 857
;857:	levelMenuInfo.item_next.generic.name			= ART_FIGHT0;
ADDRGP4 levelMenuInfo+1904+4
ADDRGP4 $436
ASGNP4
line 858
;858:	levelMenuInfo.item_next.generic.flags			= QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 levelMenuInfo+1904+44
CNSTU4 272
ASGNU4
line 859
;859:	levelMenuInfo.item_next.generic.x				= 640;
ADDRGP4 levelMenuInfo+1904+12
CNSTI4 640
ASGNI4
line 860
;860:	levelMenuInfo.item_next.generic.y				= 480-64;
ADDRGP4 levelMenuInfo+1904+16
CNSTI4 416
ASGNI4
line 861
;861:	levelMenuInfo.item_next.generic.callback		= UI_SPLevelMenu_NextEvent;
ADDRGP4 levelMenuInfo+1904+48
ADDRGP4 UI_SPLevelMenu_NextEvent
ASGNP4
line 862
;862:	levelMenuInfo.item_next.generic.id				= ID_NEXT;
ADDRGP4 levelMenuInfo+1904+8
CNSTI4 26
ASGNI4
line 863
;863:	levelMenuInfo.item_next.width					= 128;
ADDRGP4 levelMenuInfo+1904+76
CNSTI4 128
ASGNI4
line 864
;864:	levelMenuInfo.item_next.height					= 64;
ADDRGP4 levelMenuInfo+1904+80
CNSTI4 64
ASGNI4
line 865
;865:	levelMenuInfo.item_next.focuspic				= ART_FIGHT1;
ADDRGP4 levelMenuInfo+1904+60
ADDRGP4 $437
ASGNP4
line 867
;866:
;867:	levelMenuInfo.item_null.generic.type			= MTYPE_BITMAP;
ADDRGP4 levelMenuInfo+1992
CNSTI4 6
ASGNI4
line 868
;868:	levelMenuInfo.item_null.generic.flags			= QMF_LEFT_JUSTIFY|QMF_MOUSEONLY|QMF_SILENT;
ADDRGP4 levelMenuInfo+1992+44
CNSTU4 1050628
ASGNU4
line 869
;869:	levelMenuInfo.item_null.generic.x				= 0;
ADDRGP4 levelMenuInfo+1992+12
CNSTI4 0
ASGNI4
line 870
;870:	levelMenuInfo.item_null.generic.y				= 0;
ADDRGP4 levelMenuInfo+1992+16
CNSTI4 0
ASGNI4
line 871
;871:	levelMenuInfo.item_null.width					= 640;
ADDRGP4 levelMenuInfo+1992+76
CNSTI4 640
ASGNI4
line 872
;872:	levelMenuInfo.item_null.height					= 480;
ADDRGP4 levelMenuInfo+1992+80
CNSTI4 480
ASGNI4
line 874
;873:
;874:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_banner );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 876
;875:
;876:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_leftarrow );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 877
;877:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_maps[0] );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+584
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 878
;878:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_maps[1] );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+584+88
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 879
;879:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_maps[2] );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+584+176
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 880
;880:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_maps[3] );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+584+264
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 881
;881:	levelMenuInfo.item_maps[0].generic.bottom += 18;
ADDRLP4 92
ADDRGP4 levelMenuInfo+584+32
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 882
;882:	levelMenuInfo.item_maps[1].generic.bottom += 18;
ADDRLP4 96
ADDRGP4 levelMenuInfo+584+88+32
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 883
;883:	levelMenuInfo.item_maps[2].generic.bottom += 18;
ADDRLP4 100
ADDRGP4 levelMenuInfo+584+176+32
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 884
;884:	levelMenuInfo.item_maps[3].generic.bottom += 18;
ADDRLP4 104
ADDRGP4 levelMenuInfo+584+264+32
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 18
ADDI4
ASGNI4
line 885
;885:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_rightarrow );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+936
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 887
;886:
;887:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_player );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+1024
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 889
;888:
;889:	for( n = 0; n < count; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $789
JUMPV
LABELV $786
line 890
;890:		Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_awards[n] );
ADDRGP4 levelMenuInfo
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 88
MULI4
ADDRGP4 levelMenuInfo+1112
ADDP4
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 891
;891:	}
LABELV $787
line 889
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $789
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $786
line 892
;892:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_back );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+1640
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 893
;893:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_reset );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+1728
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 894
;894:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_custom );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+1816
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 895
;895:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_next );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+1904
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 896
;896:	Menu_AddItem( &levelMenuInfo.menu, &levelMenuInfo.item_null );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+1992
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 898
;897:
;898:	trap_Cvar_VariableStringBuffer( "ui_spSelection", buf, sizeof(buf) );
ADDRGP4 $182
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 899
;899:	if( *buf ) {
ADDRLP4 20
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $796
line 900
;900:		n = atoi( buf );
ADDRLP4 20
ARGP4
ADDRLP4 108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 108
INDIRI4
ASGNI4
line 901
;901:		selectedArenaSet = n / ARENAS_PER_TIER;
ADDRGP4 selectedArenaSet
ADDRLP4 0
INDIRI4
CNSTI4 4
DIVI4
ASGNI4
line 902
;902:		selectedArena = n % ARENAS_PER_TIER;
ADDRGP4 selectedArena
ADDRLP4 0
INDIRI4
CNSTI4 4
MODI4
ASGNI4
line 903
;903:	}
ADDRGP4 $797
JUMPV
LABELV $796
line 904
;904:	else {
line 905
;905:		selectedArenaSet = currentSet;
ADDRGP4 selectedArenaSet
ADDRGP4 currentSet
INDIRI4
ASGNI4
line 906
;906:		selectedArena = currentGame;
ADDRGP4 selectedArena
ADDRGP4 currentGame
INDIRI4
ASGNI4
line 907
;907:	}
LABELV $797
line 909
;908:
;909:	UI_SPLevelMenu_SetMenuItems();
ADDRGP4 UI_SPLevelMenu_SetMenuItems
CALLV
pop
line 910
;910:}
LABELV $458
endproc UI_SPLevelMenu_Init 112 12
export UI_SPLevelMenu
proc UI_SPLevelMenu 32 8
line 918
;911:
;912:
;913:/*
;914:=================
;915:UI_SPLevelMenu
;916:=================
;917:*/
;918:void UI_SPLevelMenu( void ) {
line 923
;919:	int			level;
;920:	int			trainingLevel;
;921:	const char	*arenaInfo;
;922:
;923:	trainingTier = -1;
ADDRGP4 trainingTier
CNSTI4 -1
ASGNI4
line 924
;924:	arenaInfo = UI_GetSpecialArenaInfo( "training" );
ADDRGP4 $185
ARGP4
ADDRLP4 12
ADDRGP4 UI_GetSpecialArenaInfo
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 925
;925:	if( arenaInfo ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $799
line 926
;926:		minTier = trainingTier;
ADDRGP4 minTier
ADDRGP4 trainingTier
INDIRI4
ASGNI4
line 927
;927:		trainingLevel = atoi( Info_ValueForKey( arenaInfo, "num" ) );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 $186
ARGP4
ADDRLP4 16
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 928
;928:	}
ADDRGP4 $800
JUMPV
LABELV $799
line 929
;929:	else {
line 930
;930:		minTier = 0;
ADDRGP4 minTier
CNSTI4 0
ASGNI4
line 931
;931:		trainingLevel = -2;
ADDRLP4 8
CNSTI4 -2
ASGNI4
line 932
;932:	}
LABELV $800
line 934
;933:
;934:	finalTier = UI_GetNumSPTiers();
ADDRLP4 16
ADDRGP4 UI_GetNumSPTiers
CALLI4
ASGNI4
ADDRGP4 finalTier
ADDRLP4 16
INDIRI4
ASGNI4
line 935
;935:	arenaInfo = UI_GetSpecialArenaInfo( "final" );
ADDRGP4 $220
ARGP4
ADDRLP4 20
ADDRGP4 UI_GetSpecialArenaInfo
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 936
;936:	if( arenaInfo ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $801
line 937
;937:		maxTier = finalTier;
ADDRGP4 maxTier
ADDRGP4 finalTier
INDIRI4
ASGNI4
line 938
;938:	}
ADDRGP4 $802
JUMPV
LABELV $801
line 939
;939:	else {
line 940
;940:		maxTier = finalTier - 1;
ADDRGP4 maxTier
ADDRGP4 finalTier
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 941
;941:		if( maxTier < minTier ) {
ADDRGP4 maxTier
INDIRI4
ADDRGP4 minTier
INDIRI4
GEI4 $803
line 942
;942:			maxTier = minTier;
ADDRGP4 maxTier
ADDRGP4 minTier
INDIRI4
ASGNI4
line 943
;943:		}
LABELV $803
line 944
;944:	}
LABELV $802
line 946
;945:
;946:	level = UI_GetCurrentGame();
ADDRLP4 24
ADDRGP4 UI_GetCurrentGame
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ASGNI4
line 947
;947:	if ( level == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $805
line 948
;948:		level = UI_GetNumSPArenas() - 1;
ADDRLP4 28
ADDRGP4 UI_GetNumSPArenas
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 28
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 949
;949:		if( maxTier == finalTier ) {
ADDRGP4 maxTier
INDIRI4
ADDRGP4 finalTier
INDIRI4
NEI4 $807
line 950
;950:			level++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 951
;951:		}
LABELV $807
line 952
;952:	}
LABELV $805
line 954
;953:
;954:	if( level == trainingLevel ) {
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $809
line 955
;955:		currentSet = -1;
ADDRGP4 currentSet
CNSTI4 -1
ASGNI4
line 956
;956:		currentGame = 0;
ADDRGP4 currentGame
CNSTI4 0
ASGNI4
line 957
;957:	}
ADDRGP4 $810
JUMPV
LABELV $809
line 958
;958:	else {
line 959
;959:		currentSet = level / ARENAS_PER_TIER;
ADDRGP4 currentSet
ADDRLP4 0
INDIRI4
CNSTI4 4
DIVI4
ASGNI4
line 960
;960:		currentGame = level % ARENAS_PER_TIER;
ADDRGP4 currentGame
ADDRLP4 0
INDIRI4
CNSTI4 4
MODI4
ASGNI4
line 961
;961:	}
LABELV $810
line 963
;962:
;963:	UI_SPLevelMenu_Init();
ADDRGP4 UI_SPLevelMenu_Init
CALLV
pop
line 964
;964:	UI_PushMenu( &levelMenuInfo.menu );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 965
;965:	Menu_SetCursorToItem( &levelMenuInfo.menu, &levelMenuInfo.item_next );
ADDRGP4 levelMenuInfo
ARGP4
ADDRGP4 levelMenuInfo+1904
ARGP4
ADDRGP4 Menu_SetCursorToItem
CALLV
pop
line 966
;966:}
LABELV $798
endproc UI_SPLevelMenu 32 8
export UI_SPLevelMenu_f
proc UI_SPLevelMenu_f 0 4
line 974
;967:
;968:
;969:/*
;970:=================
;971:UI_SPLevelMenu_f
;972:=================
;973:*/
;974:void UI_SPLevelMenu_f( void ) {
line 975
;975:	trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 976
;976:	uis.menusp = 0;
ADDRGP4 uis+16
CNSTI4 0
ASGNI4
line 977
;977:	UI_SPLevelMenu();
ADDRGP4 UI_SPLevelMenu
CALLV
pop
line 978
;978:}
LABELV $812
endproc UI_SPLevelMenu_f 0 4
export UI_SPLevelMenu_ReInit
proc UI_SPLevelMenu_ReInit 0 0
line 986
;979:
;980:
;981:/*
;982:=================
;983:UI_SPLevelMenu_ReInit
;984:=================
;985:*/
;986:void UI_SPLevelMenu_ReInit( void ) {
line 987
;987:	levelMenuInfo.reinit = qtrue;
ADDRGP4 levelMenuInfo+2080
CNSTI4 1
ASGNI4
line 988
;988:}
LABELV $814
endproc UI_SPLevelMenu_ReInit 0 0
bss
align 4
LABELV maxTier
skip 4
align 4
LABELV minTier
skip 4
align 4
LABELV finalTier
skip 4
align 4
LABELV trainingTier
skip 4
align 4
LABELV currentGame
skip 4
align 4
LABELV currentSet
skip 4
align 4
LABELV selectedArena
skip 4
align 4
LABELV selectedArenaSet
skip 4
align 4
LABELV levelMenuInfo
skip 2752
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_RankingsMenu
import Rankings_Cache
import Rankings_DrawPassword
import Rankings_DrawName
import Rankings_DrawText
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_SetPbClStatus
import trap_VerifyCDKey
import trap_SetCDKey
import trap_GetCDKey
import trap_MemoryRemaining
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_ServerStatus
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_StartBackgroundTrack
import trap_S_StopBackgroundTrack
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_Seek
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import uis
import m_entersound
import UI_StartDemoLoop
import UI_DrawBackPic
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_AdjustFrom640
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_DrawStrlen
import UI_ProportionalStringWidth
import UI_DrawProportionalString_AutoWrapped
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
import UI_RegisterClientModelname
import UI_PlayerInfo_SetInfo
import UI_PlayerInfo_SetModel
import UI_DrawPlayer
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_GTS_Menu
import UI_TemplateList_Complete
import UI_TemplateList_SvTemplate
import UI_TemplateMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import UI_DrawConnectScreen
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_Message
import UI_ConfirmMenu_Style
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_Hunt_Credits
import UI_CreditMenu
import UI_UpdateCvars
import UI_RegisterCvars
import UI_MainMenu
import MainMenu_Cache
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
import ui_cdkeychecked
import ui_cdkey
import ui_server16
import ui_server15
import ui_server14
import ui_server13
import ui_server12
import ui_server11
import ui_server10
import ui_server9
import ui_server8
import ui_server7
import ui_server6
import ui_server5
import ui_server4
import ui_server3
import ui_server2
import ui_server1
import ui_hiDetailTitle
import ui_lensFlare
import ui_marks
import ui_drawCrosshairNames
import ui_drawCrosshair
import ui_brassTime
import ui_browserShowEmpty
import ui_browserShowFull
import ui_browserSortKey
import ui_browserGameType
import ui_browserMaster
import ui_spSelection
import ui_spSkill
import ui_spVideos
import ui_spAwards
import ui_spScores5
import ui_spScores4
import ui_spScores3
import ui_spScores2
import ui_spScores1
import ui_botsFile
import ui_arenasFile
import ui_ctf_friendly
import ui_ctf_timelimit
import ui_ctf_capturelimit
import ui_team_friendly
import ui_team_timelimit
import ui_team_fraglimit
import ui_tourney_timelimit
import ui_tourney_fraglimit
import ui_ffa_timelimit
import ui_ffa_fraglimit
import BG_PlayerTargetOffset
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
import weaponAmmoCharacteristics
import Pmove
import PM_UpdateViewAngles
import BG_TSS_GetPlayerEntityInfo
import BG_TSS_GetPlayerInfo
import BG_TSS_SetPlayerInfo
import BG_TSS_DecodeLeadership
import BG_TSS_CodeLeadership
import BG_TSS_DecodeInstructions
import BG_TSS_CodeInstructions
import TSS_DecodeInt
import TSS_CodeInt
import TSS_DecodeNibble
import TSS_CodeNibble
import BG_TSS_AssignPlayers
import BG_TSS_TakeProportionAway
import BG_TSS_Proportion
import BG_VectorChecksum
import BG_ChecksumChar
import BG_TemplateChecksum
import BG_GetGameTemplateList
import BG_ParseGameTemplate
import local_crandom
import local_random
import DeriveLocalSeed
import LocallySeededRandom
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
import lrand
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
LABELV $474
byte 1 67
byte 1 72
byte 1 79
byte 1 79
byte 1 83
byte 1 69
byte 1 32
byte 1 76
byte 1 69
byte 1 86
byte 1 69
byte 1 76
byte 1 0
align 1
LABELV $463
byte 1 50
byte 1 0
align 1
LABELV $459
byte 1 103
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $441
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 104
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $440
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 114
byte 1 109
byte 1 105
byte 1 115
byte 1 104
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $439
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $438
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $437
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $436
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $435
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $434
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $433
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 53
byte 1 0
align 1
LABELV $432
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 52
byte 1 0
align 1
LABELV $431
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 51
byte 1 0
align 1
LABELV $430
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 50
byte 1 0
align 1
LABELV $429
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 95
byte 1 99
byte 1 111
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 116
byte 1 101
byte 1 49
byte 1 0
align 1
LABELV $428
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 110
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 95
byte 1 49
byte 1 0
align 1
LABELV $427
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 110
byte 1 97
byte 1 114
byte 1 114
byte 1 111
byte 1 119
byte 1 95
byte 1 48
byte 1 0
align 1
LABELV $426
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $425
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 109
byte 1 97
byte 1 112
byte 1 115
byte 1 95
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $422
byte 1 63
byte 1 0
align 1
LABELV $411
byte 1 108
byte 1 111
byte 1 110
byte 1 103
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $409
byte 1 37
byte 1 115
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $373
byte 1 65
byte 1 67
byte 1 67
byte 1 69
byte 1 83
byte 1 83
byte 1 32
byte 1 68
byte 1 69
byte 1 78
byte 1 73
byte 1 69
byte 1 68
byte 1 0
align 1
LABELV $361
byte 1 84
byte 1 105
byte 1 101
byte 1 114
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $360
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $359
byte 1 37
byte 1 105
byte 1 107
byte 1 0
align 1
LABELV $356
byte 1 37
byte 1 105
byte 1 109
byte 1 0
align 1
LABELV $288
byte 1 82
byte 1 69
byte 1 83
byte 1 69
byte 1 84
byte 1 32
byte 1 71
byte 1 65
byte 1 77
byte 1 69
byte 1 63
byte 1 0
align 1
LABELV $281
byte 1 115
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 32
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 102
byte 1 114
byte 1 111
byte 1 109
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 98
byte 1 101
byte 1 103
byte 1 105
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 0
align 1
LABELV $280
byte 1 68
byte 1 111
byte 1 32
byte 1 116
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 111
byte 1 110
byte 1 108
byte 1 121
byte 1 32
byte 1 105
byte 1 102
byte 1 32
byte 1 121
byte 1 111
byte 1 117
byte 1 32
byte 1 119
byte 1 97
byte 1 110
byte 1 116
byte 1 32
byte 1 116
byte 1 111
byte 1 0
align 1
LABELV $279
byte 1 115
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 118
byte 1 97
byte 1 114
byte 1 105
byte 1 97
byte 1 98
byte 1 108
byte 1 101
byte 1 115
byte 1 46
byte 1 0
align 1
LABELV $278
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 58
byte 1 32
byte 1 84
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 114
byte 1 101
byte 1 115
byte 1 101
byte 1 116
byte 1 115
byte 1 32
byte 1 97
byte 1 108
byte 1 108
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 0
align 1
LABELV $220
byte 1 102
byte 1 105
byte 1 110
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $186
byte 1 110
byte 1 117
byte 1 109
byte 1 0
align 1
LABELV $185
byte 1 116
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $182
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 112
byte 1 83
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $161
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $156
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $145
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $135
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $132
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $111
byte 1 98
byte 1 111
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $104
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $101
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $100
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
