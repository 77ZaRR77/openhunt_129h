data
align 4
LABELV specifyserver_artlist
address $96
address $97
address $98
address $99
address $100
address $101
byte 4 0
code
proc SpecifyServer_Event 272 16
file "..\..\..\..\code\q3_ui\ui_specifyserver.c"
line 50
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "ui_local.h"
;4:
;5:/*********************************************************************************
;6:	SPECIFY SERVER
;7:*********************************************************************************/
;8:
;9:#define SPECIFYSERVER_FRAMEL	"menu/art/frame2_l"
;10:#define SPECIFYSERVER_FRAMER	"menu/art/frame1_r"
;11:#define SPECIFYSERVER_BACK0		"menu/art/back_0"
;12:#define SPECIFYSERVER_BACK1		"menu/art/back_1"
;13:#define SPECIFYSERVER_FIGHT0	"menu/art/fight_0"
;14:#define SPECIFYSERVER_FIGHT1	"menu/art/fight_1"
;15:
;16:#define ID_SPECIFYSERVERBACK	102
;17:#define ID_SPECIFYSERVERGO		103
;18:
;19:static char* specifyserver_artlist[] =
;20:{
;21:	SPECIFYSERVER_FRAMEL,
;22:	SPECIFYSERVER_FRAMER,
;23:	SPECIFYSERVER_BACK0,	
;24:	SPECIFYSERVER_BACK1,	
;25:	SPECIFYSERVER_FIGHT0,
;26:	SPECIFYSERVER_FIGHT1,
;27:	NULL
;28:};
;29:
;30:typedef struct
;31:{
;32:	menuframework_s	menu;
;33:	menutext_s		banner;
;34:	menubitmap_s	framel;
;35:	menubitmap_s	framer;
;36:	menufield_s		domain;
;37:	menufield_s		port;
;38:	menubitmap_s	go;
;39:	menubitmap_s	back;
;40:} specifyserver_t;
;41:
;42:static specifyserver_t	s_specifyserver;
;43:
;44:/*
;45:=================
;46:SpecifyServer_Event
;47:=================
;48:*/
;49:static void SpecifyServer_Event( void* ptr, int event )
;50:{
line 53
;51:	char	buff[256];
;52:
;53:	switch (((menucommon_s*)ptr)->id)
ADDRLP4 256
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 102
EQI4 $128
ADDRLP4 256
INDIRI4
CNSTI4 103
EQI4 $107
ADDRGP4 $104
JUMPV
line 54
;54:	{
LABELV $107
line 56
;55:		case ID_SPECIFYSERVERGO:
;56:			if (event != QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $108
line 57
;57:				break;
ADDRGP4 $105
JUMPV
LABELV $108
line 59
;58:
;59:			if (s_specifyserver.domain.field.buffer[0])
ADDRGP4 s_specifyserver+672+60+12
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $105
line 60
;60:			{
line 61
;61:				strcpy(buff,s_specifyserver.domain.field.buffer);
ADDRLP4 0
ARGP4
ADDRGP4 s_specifyserver+672+60+12
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 62
;62:				if (s_specifyserver.port.field.buffer[0])
ADDRGP4 s_specifyserver+1004+60+12
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $118
line 63
;63:					Com_sprintf( buff+strlen(buff), 128, ":%s", s_specifyserver.port.field.buffer );
ADDRLP4 0
ARGP4
ADDRLP4 264
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
ADDRLP4 0
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $123
ARGP4
ADDRGP4 s_specifyserver+1004+60+12
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
LABELV $118
line 65
;64:
;65:				trap_Cmd_ExecuteText( EXEC_APPEND, va( "connect %s\n", buff ) );
ADDRGP4 $127
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 268
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 268
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 66
;66:			}
line 67
;67:			break;
ADDRGP4 $105
JUMPV
LABELV $128
line 70
;68:
;69:		case ID_SPECIFYSERVERBACK:
;70:			if (event != QM_ACTIVATED)
ADDRFP4 4
INDIRI4
CNSTI4 3
EQI4 $129
line 71
;71:				break;
ADDRGP4 $105
JUMPV
LABELV $129
line 73
;72:
;73:			UI_PopMenu();
ADDRGP4 UI_PopMenu
CALLV
pop
line 74
;74:			break;
LABELV $104
LABELV $105
line 76
;75:	}
;76:}
LABELV $103
endproc SpecifyServer_Event 272 16
export SpecifyServer_MenuInit
proc SpecifyServer_MenuInit 0 16
line 84
;77:
;78:/*
;79:=================
;80:SpecifyServer_MenuInit
;81:=================
;82:*/
;83:void SpecifyServer_MenuInit( void )
;84:{
line 86
;85:	// zero set all our globals
;86:	memset( &s_specifyserver, 0 ,sizeof(specifyserver_t) );
ADDRGP4 s_specifyserver
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1512
ARGI4
ADDRGP4 memset
CALLP4
pop
line 88
;87:
;88:	SpecifyServer_Cache();
ADDRGP4 SpecifyServer_Cache
CALLV
pop
line 90
;89:
;90:	s_specifyserver.menu.wrapAround = qtrue;
ADDRGP4 s_specifyserver+404
CNSTI4 1
ASGNI4
line 91
;91:	s_specifyserver.menu.fullscreen = qtrue;
ADDRGP4 s_specifyserver+408
CNSTI4 1
ASGNI4
line 93
;92:
;93:	s_specifyserver.banner.generic.type	 = MTYPE_BTEXT;
ADDRGP4 s_specifyserver+424
CNSTI4 10
ASGNI4
line 94
;94:	s_specifyserver.banner.generic.x     = 320;
ADDRGP4 s_specifyserver+424+12
CNSTI4 320
ASGNI4
line 95
;95:	s_specifyserver.banner.generic.y     = 16;
ADDRGP4 s_specifyserver+424+16
CNSTI4 16
ASGNI4
line 96
;96:	s_specifyserver.banner.string		 = "SPECIFY SERVER";
ADDRGP4 s_specifyserver+424+60
ADDRGP4 $141
ASGNP4
line 97
;97:	s_specifyserver.banner.color  		 = color_white;
ADDRGP4 s_specifyserver+424+68
ADDRGP4 color_white
ASGNP4
line 98
;98:	s_specifyserver.banner.style  		 = UI_CENTER;
ADDRGP4 s_specifyserver+424+64
CNSTI4 1
ASGNI4
line 100
;99:
;100:	s_specifyserver.framel.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_specifyserver+496
CNSTI4 6
ASGNI4
line 101
;101:	s_specifyserver.framel.generic.name  = SPECIFYSERVER_FRAMEL;
ADDRGP4 s_specifyserver+496+4
ADDRGP4 $96
ASGNP4
line 102
;102:	s_specifyserver.framel.generic.flags = QMF_INACTIVE;
ADDRGP4 s_specifyserver+496+44
CNSTU4 16384
ASGNU4
line 103
;103:	s_specifyserver.framel.generic.x	 = 0;  
ADDRGP4 s_specifyserver+496+12
CNSTI4 0
ASGNI4
line 104
;104:	s_specifyserver.framel.generic.y	 = 78;
ADDRGP4 s_specifyserver+496+16
CNSTI4 78
ASGNI4
line 105
;105:	s_specifyserver.framel.width  	     = 256;
ADDRGP4 s_specifyserver+496+76
CNSTI4 256
ASGNI4
line 106
;106:	s_specifyserver.framel.height  	     = 329;
ADDRGP4 s_specifyserver+496+80
CNSTI4 329
ASGNI4
line 108
;107:
;108:	s_specifyserver.framer.generic.type  = MTYPE_BITMAP;
ADDRGP4 s_specifyserver+584
CNSTI4 6
ASGNI4
line 109
;109:	s_specifyserver.framer.generic.name  = SPECIFYSERVER_FRAMER;
ADDRGP4 s_specifyserver+584+4
ADDRGP4 $97
ASGNP4
line 110
;110:	s_specifyserver.framer.generic.flags = QMF_INACTIVE;
ADDRGP4 s_specifyserver+584+44
CNSTU4 16384
ASGNU4
line 111
;111:	s_specifyserver.framer.generic.x	 = 376;
ADDRGP4 s_specifyserver+584+12
CNSTI4 376
ASGNI4
line 112
;112:	s_specifyserver.framer.generic.y	 = 76;
ADDRGP4 s_specifyserver+584+16
CNSTI4 76
ASGNI4
line 113
;113:	s_specifyserver.framer.width  	     = 256;
ADDRGP4 s_specifyserver+584+76
CNSTI4 256
ASGNI4
line 114
;114:	s_specifyserver.framer.height  	     = 334;
ADDRGP4 s_specifyserver+584+80
CNSTI4 334
ASGNI4
line 116
;115:
;116:	s_specifyserver.domain.generic.type       = MTYPE_FIELD;
ADDRGP4 s_specifyserver+672
CNSTI4 4
ASGNI4
line 117
;117:	s_specifyserver.domain.generic.name       = "Address:";
ADDRGP4 s_specifyserver+672+4
ADDRGP4 $175
ASGNP4
line 118
;118:	s_specifyserver.domain.generic.flags      = QMF_PULSEIFFOCUS|QMF_SMALLFONT;
ADDRGP4 s_specifyserver+672+44
CNSTU4 258
ASGNU4
line 119
;119:	s_specifyserver.domain.generic.x	      = 206;
ADDRGP4 s_specifyserver+672+12
CNSTI4 206
ASGNI4
line 120
;120:	s_specifyserver.domain.generic.y	      = 220;
ADDRGP4 s_specifyserver+672+16
CNSTI4 220
ASGNI4
line 121
;121:	s_specifyserver.domain.field.widthInChars = 38;
ADDRGP4 s_specifyserver+672+60+8
CNSTI4 38
ASGNI4
line 122
;122:	s_specifyserver.domain.field.maxchars     = 80;
ADDRGP4 s_specifyserver+672+60+268
CNSTI4 80
ASGNI4
line 124
;123:
;124:	s_specifyserver.port.generic.type       = MTYPE_FIELD;
ADDRGP4 s_specifyserver+1004
CNSTI4 4
ASGNI4
line 125
;125:	s_specifyserver.port.generic.name	    = "Port:";
ADDRGP4 s_specifyserver+1004+4
ADDRGP4 $191
ASGNP4
line 126
;126:	s_specifyserver.port.generic.flags	    = QMF_PULSEIFFOCUS|QMF_SMALLFONT|QMF_NUMBERSONLY;
ADDRGP4 s_specifyserver+1004+44
CNSTU4 290
ASGNU4
line 127
;127:	s_specifyserver.port.generic.x	        = 206;
ADDRGP4 s_specifyserver+1004+12
CNSTI4 206
ASGNI4
line 128
;128:	s_specifyserver.port.generic.y	        = 250;
ADDRGP4 s_specifyserver+1004+16
CNSTI4 250
ASGNI4
line 129
;129:	s_specifyserver.port.field.widthInChars = 6;
ADDRGP4 s_specifyserver+1004+60+8
CNSTI4 6
ASGNI4
line 130
;130:	s_specifyserver.port.field.maxchars     = 5;
ADDRGP4 s_specifyserver+1004+60+268
CNSTI4 5
ASGNI4
line 132
;131:
;132:	s_specifyserver.go.generic.type	    = MTYPE_BITMAP;
ADDRGP4 s_specifyserver+1336
CNSTI4 6
ASGNI4
line 133
;133:	s_specifyserver.go.generic.name     = SPECIFYSERVER_FIGHT0;
ADDRGP4 s_specifyserver+1336+4
ADDRGP4 $100
ASGNP4
line 134
;134:	s_specifyserver.go.generic.flags    = QMF_RIGHT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_specifyserver+1336+44
CNSTU4 272
ASGNU4
line 135
;135:	s_specifyserver.go.generic.callback = SpecifyServer_Event;
ADDRGP4 s_specifyserver+1336+48
ADDRGP4 SpecifyServer_Event
ASGNP4
line 136
;136:	s_specifyserver.go.generic.id	    = ID_SPECIFYSERVERGO;
ADDRGP4 s_specifyserver+1336+8
CNSTI4 103
ASGNI4
line 137
;137:	s_specifyserver.go.generic.x		= 640;
ADDRGP4 s_specifyserver+1336+12
CNSTI4 640
ASGNI4
line 138
;138:	s_specifyserver.go.generic.y		= 480-64;
ADDRGP4 s_specifyserver+1336+16
CNSTI4 416
ASGNI4
line 139
;139:	s_specifyserver.go.width  		    = 128;
ADDRGP4 s_specifyserver+1336+76
CNSTI4 128
ASGNI4
line 140
;140:	s_specifyserver.go.height  		    = 64;
ADDRGP4 s_specifyserver+1336+80
CNSTI4 64
ASGNI4
line 141
;141:	s_specifyserver.go.focuspic         = SPECIFYSERVER_FIGHT1;
ADDRGP4 s_specifyserver+1336+60
ADDRGP4 $101
ASGNP4
line 143
;142:
;143:	s_specifyserver.back.generic.type	  = MTYPE_BITMAP;
ADDRGP4 s_specifyserver+1424
CNSTI4 6
ASGNI4
line 144
;144:	s_specifyserver.back.generic.name     = SPECIFYSERVER_BACK0;
ADDRGP4 s_specifyserver+1424+4
ADDRGP4 $98
ASGNP4
line 145
;145:	s_specifyserver.back.generic.flags    = QMF_LEFT_JUSTIFY|QMF_PULSEIFFOCUS;
ADDRGP4 s_specifyserver+1424+44
CNSTU4 260
ASGNU4
line 146
;146:	s_specifyserver.back.generic.callback = SpecifyServer_Event;
ADDRGP4 s_specifyserver+1424+48
ADDRGP4 SpecifyServer_Event
ASGNP4
line 147
;147:	s_specifyserver.back.generic.id	      = ID_SPECIFYSERVERBACK;
ADDRGP4 s_specifyserver+1424+8
CNSTI4 102
ASGNI4
line 148
;148:	s_specifyserver.back.generic.x		  = 0;
ADDRGP4 s_specifyserver+1424+12
CNSTI4 0
ASGNI4
line 149
;149:	s_specifyserver.back.generic.y		  = 480-64;
ADDRGP4 s_specifyserver+1424+16
CNSTI4 416
ASGNI4
line 150
;150:	s_specifyserver.back.width  		  = 128;
ADDRGP4 s_specifyserver+1424+76
CNSTI4 128
ASGNI4
line 151
;151:	s_specifyserver.back.height  		  = 64;
ADDRGP4 s_specifyserver+1424+80
CNSTI4 64
ASGNI4
line 152
;152:	s_specifyserver.back.focuspic         = SPECIFYSERVER_BACK1;
ADDRGP4 s_specifyserver+1424+60
ADDRGP4 $99
ASGNP4
line 154
;153:
;154:	Menu_AddItem( &s_specifyserver.menu, &s_specifyserver.banner );
ADDRGP4 s_specifyserver
ARGP4
ADDRGP4 s_specifyserver+424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 155
;155:	Menu_AddItem( &s_specifyserver.menu, &s_specifyserver.framel );
ADDRGP4 s_specifyserver
ARGP4
ADDRGP4 s_specifyserver+496
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 156
;156:	Menu_AddItem( &s_specifyserver.menu, &s_specifyserver.framer );
ADDRGP4 s_specifyserver
ARGP4
ADDRGP4 s_specifyserver+584
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 157
;157:	Menu_AddItem( &s_specifyserver.menu, &s_specifyserver.domain );
ADDRGP4 s_specifyserver
ARGP4
ADDRGP4 s_specifyserver+672
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 158
;158:	Menu_AddItem( &s_specifyserver.menu, &s_specifyserver.port );
ADDRGP4 s_specifyserver
ARGP4
ADDRGP4 s_specifyserver+1004
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 159
;159:	Menu_AddItem( &s_specifyserver.menu, &s_specifyserver.go );
ADDRGP4 s_specifyserver
ARGP4
ADDRGP4 s_specifyserver+1336
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 160
;160:	Menu_AddItem( &s_specifyserver.menu, &s_specifyserver.back );
ADDRGP4 s_specifyserver
ARGP4
ADDRGP4 s_specifyserver+1424
ARGP4
ADDRGP4 Menu_AddItem
CALLV
pop
line 162
;161:
;162:	Com_sprintf( s_specifyserver.port.field.buffer, 6, "%i", 27960 );
ADDRGP4 s_specifyserver+1004+60+12
ARGP4
CNSTI4 6
ARGI4
ADDRGP4 $252
ARGP4
CNSTI4 27960
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 163
;163:}
LABELV $131
endproc SpecifyServer_MenuInit 0 16
export SpecifyServer_Cache
proc SpecifyServer_Cache 4 4
line 171
;164:
;165:/*
;166:=================
;167:SpecifyServer_Cache
;168:=================
;169:*/
;170:void SpecifyServer_Cache( void )
;171:{
line 175
;172:	int	i;
;173:
;174:	// touch all our pics
;175:	for (i=0; ;i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $254
line 176
;176:	{
line 177
;177:		if (!specifyserver_artlist[i])
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 specifyserver_artlist
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $258
line 178
;178:			break;
ADDRGP4 $256
JUMPV
LABELV $258
line 179
;179:		trap_R_RegisterShaderNoMip(specifyserver_artlist[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 specifyserver_artlist
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
pop
line 180
;180:	}
LABELV $255
line 175
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $254
JUMPV
LABELV $256
line 181
;181:}
LABELV $253
endproc SpecifyServer_Cache 4 4
export UI_SpecifyServerMenu
proc UI_SpecifyServerMenu 0 4
line 189
;182:
;183:/*
;184:=================
;185:UI_SpecifyServerMenu
;186:=================
;187:*/
;188:void UI_SpecifyServerMenu( void )
;189:{
line 190
;190:	SpecifyServer_MenuInit();
ADDRGP4 SpecifyServer_MenuInit
CALLV
pop
line 191
;191:	UI_PushMenu( &s_specifyserver.menu );
ADDRGP4 s_specifyserver
ARGP4
ADDRGP4 UI_PushMenu
CALLV
pop
line 192
;192:}
LABELV $260
endproc UI_SpecifyServerMenu 0 4
bss
align 4
LABELV s_specifyserver
skip 1512
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
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
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
LABELV $252
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $191
byte 1 80
byte 1 111
byte 1 114
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $175
byte 1 65
byte 1 100
byte 1 100
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 58
byte 1 0
align 1
LABELV $141
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 73
byte 1 70
byte 1 89
byte 1 32
byte 1 83
byte 1 69
byte 1 82
byte 1 86
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $127
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $123
byte 1 58
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $101
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
LABELV $100
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
LABELV $99
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
LABELV $98
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
LABELV $97
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
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 49
byte 1 95
byte 1 114
byte 1 0
align 1
LABELV $96
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
byte 1 114
byte 1 97
byte 1 109
byte 1 101
byte 1 50
byte 1 95
byte 1 108
byte 1 0
