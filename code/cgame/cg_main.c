// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_main.c -- initialization and primary entry point for cgame
#include "cg_local.h"

#ifdef MISSIONPACK
#include "../ui/ui_shared.h"
// display context for new ui stuff
displayContextDef_t cgDC;
#endif

#define LFDEBUG 0	// JUHOX DEBUG

int forceModelModificationCount = -1;

void CG_Init( int serverMessageNum, int serverCommandSequence, int clientNum );
void CG_Shutdown( void );


/*
================
vmMain

This is the only way control passes into the module.
This must be the very first function compiled into the .q3vm file
================
*/
int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {

	switch ( command ) {
	case CG_INIT:
		CG_Init( arg0, arg1, arg2 );
		return 0;
	case CG_SHUTDOWN:
		CG_Shutdown();
		return 0;
	case CG_CONSOLE_COMMAND:
		return CG_ConsoleCommand();
	case CG_DRAW_ACTIVE_FRAME:
		CG_DrawActiveFrame( arg0, arg1, arg2 );
		return 0;
	case CG_CROSSHAIR_PLAYER:
		return CG_CrosshairPlayer();
	case CG_LAST_ATTACKER:
		return CG_LastAttacker();
	case CG_KEY_EVENT:
		CG_KeyEvent(arg0, arg1);
		return 0;
	case CG_MOUSE_EVENT:
#ifdef MISSIONPACK
		cgDC.cursorx = cgs.cursorX;
		cgDC.cursory = cgs.cursorY;
#endif
		CG_MouseEvent(arg0, arg1);
		return 0;
	case CG_EVENT_HANDLING:
		CG_EventHandling(arg0);
		return 0;
	default:
		CG_Error( "vmMain: unknown command %i", command );
		break;
	}
	return -1;
}


cg_t				cg;
cgs_t				cgs;
centity_t			cg_entities[MAX_GENTITIES];
weaponInfo_t		cg_weapons[MAX_WEAPONS];
itemInfo_t			cg_items[MAX_ITEMS];


vmCvar_t	cg_railTrailTime;
vmCvar_t	cg_centertime;
vmCvar_t	cg_runpitch;
vmCvar_t	cg_runroll;
vmCvar_t	cg_bobup;
vmCvar_t	cg_bobpitch;
vmCvar_t	cg_bobroll;
vmCvar_t	cg_swingSpeed;
vmCvar_t	cg_shadows;
vmCvar_t	cg_gibs;
vmCvar_t	cg_drawTimer;
vmCvar_t	cg_drawFPS;
vmCvar_t	cg_drawSnapshot;
vmCvar_t	cg_draw3dIcons;
vmCvar_t	cg_drawIcons;
vmCvar_t	cg_drawAmmoWarning;
vmCvar_t	cg_drawCrosshair;
vmCvar_t	cg_drawCrosshairNames;
vmCvar_t	cg_drawRewards;
vmCvar_t	cg_crosshairSize;
vmCvar_t	cg_crosshairX;
vmCvar_t	cg_crosshairY;
vmCvar_t	cg_crosshairHealth;
vmCvar_t	cg_draw2D;
vmCvar_t	cg_drawStatus;
vmCvar_t	cg_animSpeed;
vmCvar_t	cg_debugAnim;
vmCvar_t	cg_debugPosition;
vmCvar_t	cg_debugEvents;
vmCvar_t	cg_errorDecay;
vmCvar_t	cg_nopredict;
vmCvar_t	cg_noPlayerAnims;
vmCvar_t	cg_showmiss;
vmCvar_t	cg_footsteps;
vmCvar_t	cg_addMarks;
vmCvar_t	cg_brassTime;
vmCvar_t	cg_viewsize;
vmCvar_t	cg_drawGun;
vmCvar_t	cg_gun_frame;
vmCvar_t	cg_gun_x;
vmCvar_t	cg_gun_y;
vmCvar_t	cg_gun_z;
vmCvar_t	cg_tracerChance;
vmCvar_t	cg_tracerWidth;
vmCvar_t	cg_tracerLength;
vmCvar_t	cg_autoswitch;
vmCvar_t	cg_autoswitchAmmoLimit;	// JUHOX
vmCvar_t	cg_weaponOrder[NUM_WEAPONORDERS];		// JUHOX
vmCvar_t	cg_weaponOrderName[NUM_WEAPONORDERS];	// JUHOX
vmCvar_t	cg_ignore;
#if MONSTER_MODE	// JUHOX:  STU cvars
vmCvar_t	cg_drawNumMonsters;
vmCvar_t	cg_fireballTrail;
#endif
#if ESCAPE_MODE	// JUHOX: EFH cvars
vmCvar_t	cg_drawSegment;
#endif
vmCvar_t	cg_tssiMouse;	// JUHOX
vmCvar_t	cg_tssiKey;		// JUHOX
vmCvar_t	cg_tmplcmd;		// JUHOX
vmCvar_t	cg_noTrace;		// JUHOX
vmCvar_t	cg_simpleItems;
vmCvar_t	cg_fov;
vmCvar_t	cg_zoomFov;
vmCvar_t	cg_thirdPerson;
vmCvar_t	cg_thirdPersonRange;
vmCvar_t	cg_thirdPersonAngle;
vmCvar_t	cg_stereoSeparation;
vmCvar_t	cg_lagometer;
vmCvar_t	cg_drawAttacker;
vmCvar_t	cg_synchronousClients;
vmCvar_t 	cg_teamChatTime;
vmCvar_t 	cg_teamChatHeight;
vmCvar_t 	cg_stats;
vmCvar_t 	cg_buildScript;
vmCvar_t 	cg_forceModel;
vmCvar_t	cg_paused;
vmCvar_t	cg_blood;
vmCvar_t	cg_predictItems;
vmCvar_t	cg_deferPlayers;
vmCvar_t	cg_drawTeamOverlay;
vmCvar_t	cg_teamOverlayUserinfo;
vmCvar_t	cg_drawFriend;
vmCvar_t	cg_teamChatsOnly;
vmCvar_t	cg_noVoiceChats;
vmCvar_t	cg_noVoiceText;
vmCvar_t	cg_hudFiles;
vmCvar_t 	cg_scorePlum;
vmCvar_t 	cg_smoothClients;
vmCvar_t	pmove_fixed;
//vmCvar_t	cg_pmove_fixed;
vmCvar_t	pmove_msec;
vmCvar_t	cg_pmove_msec;
vmCvar_t	cg_cameraMode;
vmCvar_t	cg_cameraOrbit;
vmCvar_t	cg_cameraOrbitDelay;
vmCvar_t	cg_timescaleFadeEnd;
vmCvar_t	cg_timescaleFadeSpeed;
vmCvar_t	cg_timescale;
vmCvar_t	cg_smallFont;
vmCvar_t	cg_bigFont;
vmCvar_t	cg_noTaunt;
vmCvar_t	cg_noProjectileTrail;
vmCvar_t	cg_oldRail;
vmCvar_t	cg_oldRocket;
vmCvar_t	cg_oldPlasma;
vmCvar_t	cg_trueLightning;
vmCvar_t	cg_glassCloaking;	// JUHOX
vmCvar_t	cg_lensFlare;		// JUHOX
#if MAPLENSFLARES
vmCvar_t	cg_mapFlare;		// JUHOX
vmCvar_t	cg_sunFlare;		// JUHOX
vmCvar_t	cg_missileFlare;	// JUHOX
#endif
vmCvar_t	cg_BFGsuperExpl;		// JUHOX
vmCvar_t	cg_nearbox;			// JUHOX
vmCvar_t	cg_autoGLC;			// JUHOX
#if PLAYLIST
vmCvar_t	cg_music;	// JUHOX: 0 = no music, 1 = default music, 2 = playlist
#endif
/*
vmCvar_t	cg_tssFileService;	// JUHOX
vmCvar_t	cg_tssFileLen;		// JUHOX
vmCvar_t	cg_tssPacketLen;	// JUHOX
*/

#ifdef MISSIONPACK
vmCvar_t 	cg_redTeamName;
vmCvar_t 	cg_blueTeamName;
vmCvar_t	cg_currentSelectedPlayer;
vmCvar_t	cg_currentSelectedPlayerName;
vmCvar_t	cg_singlePlayer;
vmCvar_t	cg_enableDust;
vmCvar_t	cg_enableBreath;
vmCvar_t	cg_singlePlayerActive;
vmCvar_t	cg_recordSPDemo;
vmCvar_t	cg_recordSPDemoName;
vmCvar_t	cg_obeliskRespawnDelay;
#endif

typedef struct {
	vmCvar_t	*vmCvar;
	char		*cvarName;
	char		*defaultString;
	int			cvarFlags;
} cvarTable_t;

static cvarTable_t cvarTable[] = { // bk001129
	{ &cg_ignore, "cg_ignore", "0", 0 },	// used for debugging
#if MONSTER_MODE	// JUHOX: STU cvars
	{ &cg_drawNumMonsters, "cg_drawNumMonsters", "0", CVAR_ARCHIVE},
	{ &cg_fireballTrail, "cg_fireballTrail", "1", CVAR_ARCHIVE},
#endif
#if ESCAPE_MODE	// JUHOX: EFH cvars
	{ &cg_drawSegment, "cg_drawSegment", "0", CVAR_ARCHIVE},
#endif
	{ &cg_tssiMouse, "tssi_mouse", "", CVAR_ROM },	// JUHOX
	{ &cg_tssiKey, "tssi_key", "", CVAR_ROM },	// JUHOX
	{ &cg_tmplcmd, "tmplcmd", "", CVAR_ROM },	// JUHOX
	{ &cg_noTrace, "cg_noTrace", "0", CVAR_ARCHIVE },	// JUHOX
	{ &cg_autoswitch, "cg_autoswitch", "1", CVAR_ARCHIVE },
	// JUHOX: new weapon switching cvars
#if 1
	{ &cg_autoswitchAmmoLimit, "cg_autoswitchAmmoLimit", "50", CVAR_ARCHIVE },
	{ &cg_weaponOrder[0], "cg_weaponOrder0", "ICFJDHGLEB", CVAR_ARCHIVE },
	{ &cg_weaponOrder[1], "cg_weaponOrder1", "DCGHLBIFEJ", CVAR_ARCHIVE },
	{ &cg_weaponOrder[2], "cg_weaponOrder2", "FCIDGEJLHB", CVAR_ARCHIVE },
	{ &cg_weaponOrder[3], "cg_weaponOrder3", "JFCEIDHGLB", CVAR_ARCHIVE },
	{ &cg_weaponOrder[4], "cg_weaponOrder4", "HLJCFGIDEB", CVAR_ARCHIVE },
	{ &cg_weaponOrder[5], "cg_weaponOrder5", "LGEJICDFHB", CVAR_ARCHIVE },
	{ &cg_weaponOrderName[0], "cg_weaponOrder0Name", "pursuit", CVAR_ARCHIVE },
	{ &cg_weaponOrderName[1], "cg_weaponOrder1Name", "close combat", CVAR_ARCHIVE },
	{ &cg_weaponOrderName[2], "cg_weaponOrder2Name", "attack", CVAR_ARCHIVE },
	{ &cg_weaponOrderName[3], "cg_weaponOrder3Name", "annihilation", CVAR_ARCHIVE },
	{ &cg_weaponOrderName[4], "cg_weaponOrder4Name", "revenge", CVAR_ARCHIVE },
	{ &cg_weaponOrderName[5], "cg_weaponOrder5Name", "defence", CVAR_ARCHIVE },
#endif
	{ &cg_drawGun, "cg_drawGun", "1", CVAR_ARCHIVE },
	{ &cg_zoomFov, "cg_zoomfov", "22.5", CVAR_ARCHIVE },
	{ &cg_fov, "cg_fov", "90", CVAR_ARCHIVE },
	{ &cg_viewsize, "cg_viewsize", "100", CVAR_ARCHIVE },
	{ &cg_stereoSeparation, "cg_stereoSeparation", "0.4", CVAR_ARCHIVE  },
	{ &cg_shadows, "cg_shadows", "1", CVAR_ARCHIVE  },
	{ &cg_gibs, "cg_gibs", "1", CVAR_ARCHIVE  },
	{ &cg_draw2D, "cg_draw2D", "1", CVAR_ARCHIVE  },
	{ &cg_drawStatus, "cg_drawStatus", "1", CVAR_ARCHIVE  },
	{ &cg_drawTimer, "cg_drawTimer", "0", CVAR_ARCHIVE  },
	{ &cg_drawFPS, "cg_drawFPS", "0", CVAR_ARCHIVE  },
	{ &cg_drawSnapshot, "cg_drawSnapshot", "0", CVAR_ARCHIVE  },
	{ &cg_draw3dIcons, "cg_draw3dIcons", "1", CVAR_ARCHIVE  },
	{ &cg_drawIcons, "cg_drawIcons", "1", CVAR_ARCHIVE  },
	{ &cg_drawAmmoWarning, "cg_drawAmmoWarning", "1", CVAR_ARCHIVE  },
	{ &cg_drawAttacker, "cg_drawAttacker", "1", CVAR_ARCHIVE  },
	{ &cg_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE },
	{ &cg_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE },
	{ &cg_drawRewards, "cg_drawRewards", "1", CVAR_ARCHIVE },
	{ &cg_crosshairSize, "cg_crosshairSize", "24", CVAR_ARCHIVE },
	{ &cg_crosshairHealth, "cg_crosshairHealth", "1", CVAR_ARCHIVE },
	{ &cg_crosshairX, "cg_crosshairX", "0", CVAR_ARCHIVE },
	{ &cg_crosshairY, "cg_crosshairY", "0", CVAR_ARCHIVE },
	{ &cg_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE },
	{ &cg_simpleItems, "cg_simpleItems", "0", CVAR_ARCHIVE },
	{ &cg_addMarks, "cg_marks", "1", CVAR_ARCHIVE },
	{ &cg_lagometer, "cg_lagometer", "1", CVAR_ARCHIVE },
	{ &cg_railTrailTime, "cg_railTrailTime", "400", CVAR_ARCHIVE  },
	{ &cg_gun_x, "cg_gunX", "0", CVAR_CHEAT },
	{ &cg_gun_y, "cg_gunY", "0", CVAR_CHEAT },
	{ &cg_gun_z, "cg_gunZ", "0", CVAR_CHEAT },
	{ &cg_centertime, "cg_centertime", "3", CVAR_CHEAT },
	{ &cg_runpitch, "cg_runpitch", "0.002", CVAR_ARCHIVE},
	{ &cg_runroll, "cg_runroll", "0.005", CVAR_ARCHIVE },
	{ &cg_bobup , "cg_bobup", "0.005", CVAR_CHEAT },
	{ &cg_bobpitch, "cg_bobpitch", "0.002", CVAR_ARCHIVE },
	{ &cg_bobroll, "cg_bobroll", "0.002", CVAR_ARCHIVE },
	{ &cg_swingSpeed, "cg_swingSpeed", "0.3", CVAR_CHEAT },
	{ &cg_animSpeed, "cg_animspeed", "1", CVAR_CHEAT },
	{ &cg_debugAnim, "cg_debuganim", "0", CVAR_CHEAT },
	{ &cg_debugPosition, "cg_debugposition", "0", CVAR_CHEAT },
	{ &cg_debugEvents, "cg_debugevents", "0", CVAR_CHEAT },
	{ &cg_errorDecay, "cg_errordecay", "100", 0 },
	{ &cg_nopredict, "cg_nopredict", "0", 0 },
	{ &cg_noPlayerAnims, "cg_noplayeranims", "0", CVAR_CHEAT },
	{ &cg_showmiss, "cg_showmiss", "0", 0 },
	{ &cg_footsteps, "cg_footsteps", "1", CVAR_CHEAT },
	{ &cg_tracerChance, "cg_tracerchance", "0.4", CVAR_CHEAT },
	{ &cg_tracerWidth, "cg_tracerwidth", "1", CVAR_CHEAT },
	{ &cg_tracerLength, "cg_tracerlength", "100", CVAR_CHEAT },
	{ &cg_thirdPersonRange, "cg_thirdPersonRange", "40", CVAR_CHEAT },
	{ &cg_thirdPersonAngle, "cg_thirdPersonAngle", "0", CVAR_CHEAT },
	{ &cg_thirdPerson, "cg_thirdPerson", "0", 0 },
	{ &cg_teamChatTime, "cg_teamChatTime", "3000", CVAR_ARCHIVE  },
	{ &cg_teamChatHeight, "cg_teamChatHeight", "0", CVAR_ARCHIVE  },
	{ &cg_forceModel, "cg_forceModel", "0", CVAR_ARCHIVE  },
	{ &cg_predictItems, "cg_predictItems", "1", CVAR_ARCHIVE },
#ifdef MISSIONPACK
	{ &cg_deferPlayers, "cg_deferPlayers", "0", CVAR_ARCHIVE },
#else
	{ &cg_deferPlayers, "cg_deferPlayers", "1", CVAR_ARCHIVE },
#endif
	{ &cg_drawTeamOverlay, "cg_drawTeamOverlay", "0", CVAR_ARCHIVE },
	{ &cg_teamOverlayUserinfo, "teamoverlay", "0", CVAR_ROM | CVAR_USERINFO },
	{ &cg_stats, "cg_stats", "0", 0 },
	{ &cg_glassCloaking, "cg_glassCloaking", "0", CVAR_ARCHIVE | CVAR_USERINFO},	// JUHOX
	{ &cg_lensFlare, "cg_lensFlare", "1", CVAR_ARCHIVE},	// JUHOX
#if MAPLENSFLARES
	{ &cg_mapFlare, "cg_mapFlare", "2", CVAR_ARCHIVE},		// JUHOX
	{ &cg_sunFlare, "cg_sunFlare", "2", CVAR_ARCHIVE},		// JUHOX
	{ &cg_missileFlare, "cg_missileFlare", "1", CVAR_ARCHIVE},	// JUHOX
#endif
	{ &cg_BFGsuperExpl, "cg_BFGsuperExpl", "1", CVAR_ARCHIVE},	// JUHOX
	{ &cg_nearbox, "cg_nearbox", "1", CVAR_ARCHIVE},	// JUHOX
	{ &cg_autoGLC, "cg_autoGLC", "1", CVAR_ARCHIVE},	// JUHOX
	{ &cg_drawFriend, "cg_drawFriend", "1", CVAR_ARCHIVE },
	{ &cg_teamChatsOnly, "cg_teamChatsOnly", "0", CVAR_ARCHIVE },
	{ &cg_noVoiceChats, "cg_noVoiceChats", "0", CVAR_ARCHIVE },
	{ &cg_noVoiceText, "cg_noVoiceText", "0", CVAR_ARCHIVE },
	// the following variables are created in other parts of the system,
	// but we also reference them here
	{ &cg_buildScript, "com_buildScript", "0", 0 },	// force loading of all possible data amd error on failures
	{ &cg_paused, "cl_paused", "0", CVAR_ROM },
	{ &cg_blood, "com_blood", "1", CVAR_ARCHIVE },
	{ &cg_synchronousClients, "g_synchronousClients", "0", 0 },	// communicated by systeminfo
/*
	{ &cg_tssFileService, "cg_tssFileService", "0", CVAR_ROM },	// JUHOX
	{ &cg_tssFileLen, "cg_tssFileLen", "0", CVAR_ROM },	// JUHOX
	{ &cg_tssPacketLen, "cg_tssPacketLen", "0", CVAR_ROM },	// JUHOX
*/
#ifdef MISSIONPACK
	{ &cg_redTeamName, "g_redteam", DEFAULT_REDTEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO },
	{ &cg_blueTeamName, "g_blueteam", DEFAULT_BLUETEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO },
	{ &cg_currentSelectedPlayer, "cg_currentSelectedPlayer", "0", CVAR_ARCHIVE},
	{ &cg_currentSelectedPlayerName, "cg_currentSelectedPlayerName", "", CVAR_ARCHIVE},
	{ &cg_singlePlayer, "ui_singlePlayerActive", "0", CVAR_USERINFO},
	{ &cg_enableDust, "g_enableDust", "0", CVAR_SERVERINFO},
	{ &cg_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO},
	{ &cg_singlePlayerActive, "ui_singlePlayerActive", "0", CVAR_USERINFO},
	{ &cg_recordSPDemo, "ui_recordSPDemo", "0", CVAR_ARCHIVE},
	{ &cg_recordSPDemoName, "ui_recordSPDemoName", "", CVAR_ARCHIVE},
	{ &cg_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO},
	{ &cg_hudFiles, "cg_hudFiles", "ui/hud.txt", CVAR_ARCHIVE},
#endif
	{ &cg_cameraOrbit, "cg_cameraOrbit", "0", CVAR_CHEAT},
	{ &cg_cameraOrbitDelay, "cg_cameraOrbitDelay", "50", CVAR_ARCHIVE},
	// JUHOX: make timescale cvars be cheat protected
#if 0
	{ &cg_timescaleFadeEnd, "cg_timescaleFadeEnd", "1", 0},
	{ &cg_timescaleFadeSpeed, "cg_timescaleFadeSpeed", "0", 0},
	{ &cg_timescale, "timescale", "1", 0},
#else
	{ &cg_timescaleFadeEnd, "cg_timescaleFadeEnd", "1", CVAR_CHEAT},
	{ &cg_timescaleFadeSpeed, "cg_timescaleFadeSpeed", "0", CVAR_CHEAT},
	{ &cg_timescale, "timescale", "1", CVAR_CHEAT},
#endif
	{ &cg_scorePlum, "cg_scorePlums", "1", CVAR_USERINFO | CVAR_ARCHIVE},
	{ &cg_smoothClients, "cg_smoothClients", "0", CVAR_USERINFO | CVAR_ARCHIVE},
	{ &cg_cameraMode, "com_cameraMode", "0", CVAR_CHEAT},

#if PLAYLIST
	{ &cg_music, "cg_music", "0", CVAR_ARCHIVE},	// JUHOX
#endif

	{ &pmove_fixed, "pmove_fixed", "0", 0},
	{ &pmove_msec, "pmove_msec", "8", 0},
	{ &cg_noTaunt, "cg_noTaunt", "0", CVAR_ARCHIVE},
	{ &cg_noProjectileTrail, "cg_noProjectileTrail", "0", CVAR_ARCHIVE},
	{ &cg_smallFont, "ui_smallFont", "0.25", CVAR_ARCHIVE},
	{ &cg_bigFont, "ui_bigFont", "0.4", CVAR_ARCHIVE},

	{ &cg_oldRail, "cg_oldRail", "1", CVAR_ARCHIVE},
	{ &cg_oldRocket, "cg_oldRocket", "1", CVAR_ARCHIVE},
	{ &cg_oldPlasma, "cg_oldPlasma", "1", CVAR_ARCHIVE},
	{ &cg_trueLightning, "cg_trueLightning", "0.0", CVAR_ARCHIVE}
//	{ &cg_pmove_fixed, "cg_pmove_fixed", "0", CVAR_USERINFO | CVAR_ARCHIVE }
};

		static int  cvarTableSize = sizeof( cvarTable ) / sizeof( cvarTable[0] );

/*
=================
CG_RegisterCvars
=================
*/
void CG_RegisterCvars( void ) {
	int			i;
	cvarTable_t	*cv;
	char		var[MAX_TOKEN_CHARS];

	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
			cv->defaultString, cv->cvarFlags );
	}

	// see if we are also running the server on this machine
	trap_Cvar_VariableStringBuffer( "sv_running", var, sizeof( var ) );
	cgs.localServer = atoi( var );

	forceModelModificationCount = cg_forceModel.modificationCount;

	trap_Cvar_Register(NULL, "model", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
	trap_Cvar_Register(NULL, "headmodel", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
	trap_Cvar_Register(NULL, "team_model", DEFAULT_TEAM_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
	trap_Cvar_Register(NULL, "team_headmodel", DEFAULT_TEAM_HEAD, CVAR_USERINFO | CVAR_ARCHIVE );
	trap_Cvar_Register(NULL, "crouchCutsRope", "1", CVAR_USERINFO | CVAR_ARCHIVE);	// JUHOX
	trap_Cvar_Register(NULL, "color", "1", CVAR_USERINFO | CVAR_ARCHIVE);	// JUHOX
	trap_Cvar_Register(NULL, "developer", "0", CVAR_INIT);	// JUHOX
	trap_Cvar_Register(NULL, "monsterModel1", "klesk/maneater", CVAR_ARCHIVE);	// JUHOX
	trap_Cvar_Register(NULL, "monsterModel2", "tankjr/default", CVAR_ARCHIVE);	// JUHOX
	trap_Cvar_Register(NULL, "monsterModel3", "uriel/default", CVAR_ARCHIVE);	// JUHOX
}

/*
===================
CG_ForceModelChange
===================
*/
static void CG_ForceModelChange( void ) {
	int		i;

	for (i=0 ; i<MAX_CLIENTS ; i++) {
		const char		*clientInfo;

		clientInfo = CG_ConfigString( CS_PLAYERS+i );
		if ( !clientInfo[0] ) {
			continue;
		}
		CG_NewClientInfo( i );
	}
}

static int tssiMouseModificationCount = -1;	// JUHOX
static int tssiKeyModificationCount = -1;	// JUHOX
static int tmplcmdModificationCount = -1;	// JUHOX
static int lastTmplcmdTime = 0;	// JUHOX

/*
=================
CG_UpdateCvars
=================
*/
void CG_UpdateCvars( void ) {
	int			i;
	cvarTable_t	*cv;

	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
		trap_Cvar_Update( cv->vmCvar );
	}

	// check for modications here

	// If team overlay is on, ask for updates from the server.  If its off,
	// let the server know so we don't receive it
	if ( drawTeamOverlayModificationCount != cg_drawTeamOverlay.modificationCount ) {
		drawTeamOverlayModificationCount = cg_drawTeamOverlay.modificationCount;

		if ( cg_drawTeamOverlay.integer > 0 ) {
			trap_Cvar_Set( "teamoverlay", "1" );
		} else {
			trap_Cvar_Set( "teamoverlay", "0" );
		}
		// FIXME E3 HACK
		trap_Cvar_Set( "teamoverlay", "1" );
	}

	// if force model changed
	if ( forceModelModificationCount != cg_forceModel.modificationCount ) {
		forceModelModificationCount = cg_forceModel.modificationCount;
		CG_ForceModelChange();
	}

	// JUHOX: check for mouse & keyboard events
#if 1
	if (tssiMouseModificationCount != cg_tssiMouse.modificationCount) {
		tssiMouseModificationCount = cg_tssiMouse.modificationCount;
		CG_TSS_CheckMouseEvents();
	}
	if (tssiKeyModificationCount != cg_tssiKey.modificationCount) {
		tssiKeyModificationCount = cg_tssiKey.modificationCount;
		CG_TSS_CheckKeyEvents();
	}
#endif

	// JUHOX: check for template list commands from the UI module
#if 1
	if (
		!cg.infoScreenText[0] &&
		cg.snap &&
		!(cg.snap->snapFlags & SNAPFLAG_NOT_ACTIVE) &&
		tmplcmdModificationCount != cg_tmplcmd.modificationCount &&
		lastTmplcmdTime < cg.time - 1500
	) {
		tmplcmdModificationCount = cg_tmplcmd.modificationCount;

		if (cg_tmplcmd.string[0]) {
			trap_SendClientCommand(&cg_tmplcmd.string[1]);
			lastTmplcmdTime = cg.time;
		}
	}
#endif
}

int CG_CrosshairPlayer( void ) {
	if ( cg.time > ( cg.crosshairClientTime + 1000 ) ) {
		return -1;
	}
	return cg.crosshairClientNum;
}

int CG_LastAttacker( void ) {
	if ( !cg.attackerTime ) {
		return -1;
	}
	return cg.snap->ps.persistant[PERS_ATTACKER];
}

void QDECL CG_Printf( const char *msg, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, msg);
	vsprintf (text, msg, argptr);
	va_end (argptr);

	trap_Print( text );
}

void QDECL CG_Error( const char *msg, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, msg);
	vsprintf (text, msg, argptr);
	va_end (argptr);

	trap_Error( text );
}

#ifndef CGAME_HARD_LINKED
// this is only here so the functions in q_shared.c and bg_*.c can link (FIXME)

void QDECL Com_Error( int level, const char *error, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, error);
	vsprintf (text, error, argptr);
	va_end (argptr);

	CG_Error( "%s", text);
}

void QDECL Com_Printf( const char *msg, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, msg);
	vsprintf (text, msg, argptr);
	va_end (argptr);

	CG_Printf ("%s", text);
}

#endif

/*
================
CG_Argv
================
*/
const char *CG_Argv( int arg ) {
	static char	buffer[MAX_STRING_CHARS];

	trap_Argv( arg, buffer, sizeof( buffer ) );

	return buffer;
}


//========================================================================

/*
=================
CG_RegisterItemSounds

The server says this item is used on this level
=================
*/
static void CG_RegisterItemSounds( int itemNum ) {
	gitem_t			*item;
	char			data[MAX_QPATH];
	char			*s, *start;
	int				len;

	item = &bg_itemlist[ itemNum ];

	if( item->pickup_sound ) {
		trap_S_RegisterSound( item->pickup_sound, qfalse );
	}

	// parse the space seperated precache string for other media
	s = item->sounds;
	if (!s || !s[0])
		return;

	while (*s) {
		start = s;
		while (*s && *s != ' ') {
			s++;
		}

		len = s-start;
		if (len >= MAX_QPATH || len < 5) {
			CG_Error( "PrecacheItem: %s has bad precache string",
				item->classname);
			return;
		}
		memcpy (data, start, len);
		data[len] = 0;
		if ( *s ) {
			s++;
		}

		if ( !strcmp(data+len-3, "wav" )) {
			trap_S_RegisterSound( data, qfalse );
		}
	}
}


/*
=================
CG_RegisterSounds

called during a precache command
=================
*/
static void CG_RegisterSounds( void ) {
	int		i;
	char	items[MAX_ITEMS+1];
	char	name[MAX_QPATH];
	const char	*soundName;

	// voice commands
#ifdef MISSIONPACK
	CG_LoadVoiceChats();
#endif

	cgs.media.silence = trap_S_RegisterSound("sound/misc/silence.wav", qfalse);	// JUHOX

	cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/1_minute.wav", qtrue );
	cgs.media.fiveMinuteSound = trap_S_RegisterSound( "sound/feedback/5_minute.wav", qtrue );
	cgs.media.suddenDeathSound = trap_S_RegisterSound( "sound/feedback/sudden_death.wav", qtrue );
	cgs.media.oneFragSound = trap_S_RegisterSound( "sound/feedback/1_frag.wav", qtrue );
	cgs.media.twoFragSound = trap_S_RegisterSound( "sound/feedback/2_frags.wav", qtrue );
	cgs.media.threeFragSound = trap_S_RegisterSound( "sound/feedback/3_frags.wav", qtrue );
	cgs.media.count3Sound = trap_S_RegisterSound( "sound/feedback/three.wav", qtrue );
	cgs.media.count2Sound = trap_S_RegisterSound( "sound/feedback/two.wav", qtrue );
	cgs.media.count1Sound = trap_S_RegisterSound( "sound/feedback/one.wav", qtrue );
	cgs.media.countFightSound = trap_S_RegisterSound( "sound/feedback/fight.wav", qtrue );
	cgs.media.countPrepareSound = trap_S_RegisterSound( "sound/feedback/prepare.wav", qtrue );
#ifdef MISSIONPACK
	cgs.media.countPrepareTeamSound = trap_S_RegisterSound( "sound/feedback/prepare_team.wav", qtrue );
#endif

	if ( cgs.gametype >= GT_TEAM || cg_buildScript.integer ) {

		cgs.media.captureAwardSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_yourteam.wav", qtrue );
		cgs.media.redLeadsSound = trap_S_RegisterSound( "sound/feedback/redleads.wav", qtrue );
		cgs.media.blueLeadsSound = trap_S_RegisterSound( "sound/feedback/blueleads.wav", qtrue );
		cgs.media.teamsTiedSound = trap_S_RegisterSound( "sound/feedback/teamstied.wav", qtrue );
		cgs.media.hitTeamSound = trap_S_RegisterSound( "sound/feedback/hit_teammate.wav", qtrue );

		cgs.media.redScoredSound = trap_S_RegisterSound( "sound/teamplay/voc_red_scores.wav", qtrue );
		cgs.media.blueScoredSound = trap_S_RegisterSound( "sound/teamplay/voc_blue_scores.wav", qtrue );

		cgs.media.captureYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_yourteam.wav", qtrue );
		cgs.media.captureOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_opponent.wav", qtrue );

		cgs.media.returnYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_yourteam.wav", qtrue );
		cgs.media.returnOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );

		cgs.media.takenYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagtaken_yourteam.wav", qtrue );
		cgs.media.takenOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagtaken_opponent.wav", qtrue );

		if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
			cgs.media.redFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/voc_red_returned.wav", qtrue );
			cgs.media.blueFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/voc_blue_returned.wav", qtrue );
			cgs.media.enemyTookYourFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_flag.wav", qtrue );
			cgs.media.yourTeamTookEnemyFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_flag.wav", qtrue );
		}

#ifdef MISSIONPACK
		if ( cgs.gametype == GT_1FCTF || cg_buildScript.integer ) {
			// FIXME: get a replacement for this sound ?
			cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
			cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_1flag.wav", qtrue );
			cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_1flag.wav", qtrue );
		}

		if ( cgs.gametype == GT_1FCTF || cgs.gametype == GT_CTF || cg_buildScript.integer ) {
			cgs.media.youHaveFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_you_flag.wav", qtrue );
			cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
		}

		if ( cgs.gametype == GT_OBELISK || cg_buildScript.integer ) {
			cgs.media.yourBaseIsUnderAttackSound = trap_S_RegisterSound( "sound/teamplay/voc_base_attack.wav", qtrue );
		}
#else
		cgs.media.youHaveFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_you_flag.wav", qtrue );
		cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
		cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
		cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_1flag.wav", qtrue );
		cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_1flag.wav", qtrue );
#endif
	}

	cgs.media.tracerSound = trap_S_RegisterSound( "sound/weapons/machinegun/buletby1.wav", qfalse );
	cgs.media.selectSound = trap_S_RegisterSound( "sound/weapons/change.wav", qfalse );
	cgs.media.wearOffSound = trap_S_RegisterSound( "sound/items/wearoff.wav", qfalse );
	cgs.media.useNothingSound = trap_S_RegisterSound( "sound/items/use_nothing.wav", qfalse );
	cgs.media.gibSound = trap_S_RegisterSound( "sound/player/gibsplt1.wav", qfalse );
	cgs.media.gibBounce1Sound = trap_S_RegisterSound( "sound/player/gibimp1.wav", qfalse );
	cgs.media.gibBounce2Sound = trap_S_RegisterSound( "sound/player/gibimp2.wav", qfalse );
	cgs.media.gibBounce3Sound = trap_S_RegisterSound( "sound/player/gibimp3.wav", qfalse );

#ifdef MISSIONPACK
	cgs.media.useInvulnerabilitySound = trap_S_RegisterSound( "sound/items/invul_activate.wav", qfalse );
	cgs.media.invulnerabilityImpactSound1 = trap_S_RegisterSound( "sound/items/invul_impact_01.wav", qfalse );
	cgs.media.invulnerabilityImpactSound2 = trap_S_RegisterSound( "sound/items/invul_impact_02.wav", qfalse );
	cgs.media.invulnerabilityImpactSound3 = trap_S_RegisterSound( "sound/items/invul_impact_03.wav", qfalse );
	cgs.media.invulnerabilityJuicedSound = trap_S_RegisterSound( "sound/items/invul_juiced.wav", qfalse );
	cgs.media.obeliskHitSound1 = trap_S_RegisterSound( "sound/items/obelisk_hit_01.wav", qfalse );
	cgs.media.obeliskHitSound2 = trap_S_RegisterSound( "sound/items/obelisk_hit_02.wav", qfalse );
	cgs.media.obeliskHitSound3 = trap_S_RegisterSound( "sound/items/obelisk_hit_03.wav", qfalse );
	cgs.media.obeliskRespawnSound = trap_S_RegisterSound( "sound/items/obelisk_respawn.wav", qfalse );

	cgs.media.ammoregenSound = trap_S_RegisterSound("sound/items/cl_ammoregen.wav", qfalse);
	cgs.media.doublerSound = trap_S_RegisterSound("sound/items/cl_doubler.wav", qfalse);
	cgs.media.guardSound = trap_S_RegisterSound("sound/items/cl_guard.wav", qfalse);
	cgs.media.scoutSound = trap_S_RegisterSound("sound/items/cl_scout.wav", qfalse);
#endif

	cgs.media.teleInSound = trap_S_RegisterSound( "sound/world/telein.wav", qfalse );
	cgs.media.teleOutSound = trap_S_RegisterSound( "sound/world/teleout.wav", qfalse );
	cgs.media.respawnSound = trap_S_RegisterSound( "sound/items/respawn1.wav", qfalse );

	cgs.media.noAmmoSound = trap_S_RegisterSound( "sound/weapons/noammo.wav", qfalse );

	cgs.media.talkSound = trap_S_RegisterSound( "sound/player/talk.wav", qfalse );
	cgs.media.landSound = trap_S_RegisterSound( "sound/player/land1.wav", qfalse);

	cgs.media.hitSound = trap_S_RegisterSound( "sound/feedback/hit.wav", qfalse );
#ifdef MISSIONPACK
	cgs.media.hitSoundHighArmor = trap_S_RegisterSound( "sound/feedback/hithi.wav", qfalse );
	cgs.media.hitSoundLowArmor = trap_S_RegisterSound( "sound/feedback/hitlo.wav", qfalse );
#endif

	cgs.media.impressiveSound = trap_S_RegisterSound( "sound/feedback/impressive.wav", qtrue );
	cgs.media.excellentSound = trap_S_RegisterSound( "sound/feedback/excellent.wav", qtrue );
	cgs.media.deniedSound = trap_S_RegisterSound( "sound/feedback/denied.wav", qtrue );
	cgs.media.humiliationSound = trap_S_RegisterSound( "sound/feedback/humiliation.wav", qtrue );
	cgs.media.assistSound = trap_S_RegisterSound( "sound/feedback/assist.wav", qtrue );
	cgs.media.defendSound = trap_S_RegisterSound( "sound/feedback/defense.wav", qtrue );
#ifdef MISSIONPACK
	cgs.media.firstImpressiveSound = trap_S_RegisterSound( "sound/feedback/first_impressive.wav", qtrue );
	cgs.media.firstExcellentSound = trap_S_RegisterSound( "sound/feedback/first_excellent.wav", qtrue );
	cgs.media.firstHumiliationSound = trap_S_RegisterSound( "sound/feedback/first_gauntlet.wav", qtrue );
#endif

	cgs.media.takenLeadSound = trap_S_RegisterSound( "sound/feedback/takenlead.wav", qtrue);
	cgs.media.tiedLeadSound = trap_S_RegisterSound( "sound/feedback/tiedlead.wav", qtrue);
	cgs.media.lostLeadSound = trap_S_RegisterSound( "sound/feedback/lostlead.wav", qtrue);

#ifdef MISSIONPACK
	cgs.media.voteNow = trap_S_RegisterSound( "sound/feedback/vote_now.wav", qtrue);
	cgs.media.votePassed = trap_S_RegisterSound( "sound/feedback/vote_passed.wav", qtrue);
	cgs.media.voteFailed = trap_S_RegisterSound( "sound/feedback/vote_failed.wav", qtrue);
#endif

	cgs.media.watrInSound = trap_S_RegisterSound( "sound/player/watr_in.wav", qfalse);
	cgs.media.watrOutSound = trap_S_RegisterSound( "sound/player/watr_out.wav", qfalse);
	cgs.media.watrUnSound = trap_S_RegisterSound( "sound/player/watr_un.wav", qfalse);

	cgs.media.jumpPadSound = trap_S_RegisterSound ("sound/world/jumppad.wav", qfalse );

	for (i=0 ; i<4 ; i++) {
		Com_sprintf (name, sizeof(name), "sound/player/footsteps/step%i.wav", i+1);
		cgs.media.footsteps[FOOTSTEP_NORMAL][i] = trap_S_RegisterSound (name, qfalse);

		Com_sprintf (name, sizeof(name), "sound/player/footsteps/boot%i.wav", i+1);
		cgs.media.footsteps[FOOTSTEP_BOOT][i] = trap_S_RegisterSound (name, qfalse);

		Com_sprintf (name, sizeof(name), "sound/player/footsteps/flesh%i.wav", i+1);
		cgs.media.footsteps[FOOTSTEP_FLESH][i] = trap_S_RegisterSound (name, qfalse);

		Com_sprintf (name, sizeof(name), "sound/player/footsteps/mech%i.wav", i+1);
		cgs.media.footsteps[FOOTSTEP_MECH][i] = trap_S_RegisterSound (name, qfalse);

		Com_sprintf (name, sizeof(name), "sound/player/footsteps/energy%i.wav", i+1);
		cgs.media.footsteps[FOOTSTEP_ENERGY][i] = trap_S_RegisterSound (name, qfalse);

		Com_sprintf (name, sizeof(name), "sound/player/footsteps/splash%i.wav", i+1);
		cgs.media.footsteps[FOOTSTEP_SPLASH][i] = trap_S_RegisterSound (name, qfalse);

		Com_sprintf (name, sizeof(name), "sound/player/footsteps/clank%i.wav", i+1);
		cgs.media.footsteps[FOOTSTEP_METAL][i] = trap_S_RegisterSound (name, qfalse);
	}

	cgs.media.overkillSound = trap_S_RegisterSound("sound/overkill.wav", qfalse);	// JUHOX
	cgs.media.exterminatedSound = trap_S_RegisterSound("sound/exterminated.wav", qfalse);	// JUHOX
	// JUHOX: register the respawn warn sound (also used for EFH)
#if RESPAWN_DELAY || ESCAPE_MODE
	cgs.media.respawnWarnSound = trap_S_RegisterSound("sound/respawn_warn.wav", qfalse);
#endif
	cgs.media.tssBeepSound = trap_S_RegisterSound("sound/tssbeep.wav", qfalse);	// JUHOX
	cgs.media.bounceArmorSoundA1 = trap_S_RegisterSound("sound/bounce_armorA1.wav", qfalse);	// JUHOX
	cgs.media.bounceArmorSoundA2 = trap_S_RegisterSound("sound/bounce_armorA2.wav", qfalse);	// JUHOX
	cgs.media.bounceArmorSoundA3 = trap_S_RegisterSound("sound/bounce_armorA3.wav", qfalse);	// JUHOX
	cgs.media.bounceArmorSoundB1 = trap_S_RegisterSound("sound/bounce_armorB1.wav", qfalse);	// JUHOX
	cgs.media.bounceArmorSoundB2 = trap_S_RegisterSound("sound/bounce_armorB2.wav", qfalse);	// JUHOX
	cgs.media.bounceArmorSoundB3 = trap_S_RegisterSound("sound/bounce_armorB3.wav", qfalse);	// JUHOX

	// JUHOX: register monster sounds
#if MONSTER_MODE
	cgs.media.earthquakeSound = trap_S_RegisterSound("sound/earthquake.wav", qfalse);
	if (cgs.gametype == GT_STU) {
		cgs.media.lastArtefactSound = trap_S_RegisterSound("sound/last_artefact.wav", qfalse);
		cgs.media.detectorBeepSound = trap_S_RegisterSound("sound/detector_beep.wav", qfalse);
	}
#endif

	// JUHOX: register pant sounds
#if 1
	cgs.media.malePantSound = trap_S_RegisterSound("sound/player/pantm.wav", qfalse);
	cgs.media.femalePantSound = trap_S_RegisterSound("sound/player/pantf.wav", qfalse);
	cgs.media.neuterPantSound = trap_S_RegisterSound("sound/player/pantn.wav", qfalse);
#endif

	// only register the items that the server says we need
	strcpy( items, CG_ConfigString( CS_ITEMS ) );

	for ( i = 1 ; i < bg_numItems ; i++ ) {
//		if ( items[ i ] == '1' || cg_buildScript.integer ) {
			CG_RegisterItemSounds( i );
//		}
	}

	for ( i = 1 ; i < MAX_SOUNDS ; i++ ) {
		soundName = CG_ConfigString( CS_SOUNDS+i );
		if ( !soundName[0] ) {
			break;
		}
		if ( soundName[0] == '*' ) {
			continue;	// custom sound
		}
		cgs.gameSounds[i] = trap_S_RegisterSound( soundName, qfalse );
	}

	// FIXME: only needed with item
	cgs.media.flightSound = trap_S_RegisterSound( "sound/items/flight.wav", qfalse );
	cgs.media.medkitSound = trap_S_RegisterSound ("sound/items/use_medkit.wav", qfalse);
	cgs.media.quadSound = trap_S_RegisterSound("sound/items/damage3.wav", qfalse);
	cgs.media.sfx_ric1 = trap_S_RegisterSound ("sound/weapons/machinegun/ric1.wav", qfalse);
	cgs.media.sfx_ric2 = trap_S_RegisterSound ("sound/weapons/machinegun/ric2.wav", qfalse);
	cgs.media.sfx_ric3 = trap_S_RegisterSound ("sound/weapons/machinegun/ric3.wav", qfalse);
	cgs.media.sfx_railg = trap_S_RegisterSound ("sound/weapons/railgun/railgf1a.wav", qfalse);
	cgs.media.sfx_rockexp = trap_S_RegisterSound ("sound/weapons/rocket/rocklx1a.wav", qfalse);
	cgs.media.sfx_plasmaexp = trap_S_RegisterSound ("sound/weapons/plasma/plasmx1a.wav", qfalse);
#ifdef MISSIONPACK
	cgs.media.sfx_proxexp = trap_S_RegisterSound( "sound/weapons/proxmine/wstbexpl.wav" , qfalse);
	cgs.media.sfx_nghit = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpd.wav" , qfalse);
	cgs.media.sfx_nghitflesh = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpl.wav" , qfalse);
	cgs.media.sfx_nghitmetal = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpm.wav", qfalse );
	cgs.media.sfx_chghit = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpd.wav", qfalse );
	cgs.media.sfx_chghitflesh = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpl.wav", qfalse );
	cgs.media.sfx_chghitmetal = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpm.wav", qfalse );
	cgs.media.weaponHoverSound = trap_S_RegisterSound( "sound/weapons/weapon_hover.wav", qfalse );
	cgs.media.kamikazeExplodeSound = trap_S_RegisterSound( "sound/items/kam_explode.wav", qfalse );
	cgs.media.kamikazeImplodeSound = trap_S_RegisterSound( "sound/items/kam_implode.wav", qfalse );
	cgs.media.kamikazeFarSound = trap_S_RegisterSound( "sound/items/kam_explode_far.wav", qfalse );
	cgs.media.winnerSound = trap_S_RegisterSound( "sound/feedback/voc_youwin.wav", qfalse );
	cgs.media.loserSound = trap_S_RegisterSound( "sound/feedback/voc_youlose.wav", qfalse );
	cgs.media.youSuckSound = trap_S_RegisterSound( "sound/misc/yousuck.wav", qfalse );
	cgs.media.wstbimplSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpl.wav", qfalse);
	cgs.media.wstbimpmSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpm.wav", qfalse);
	cgs.media.wstbimpdSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpd.wav", qfalse);
	cgs.media.wstbactvSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbactv.wav", qfalse);
#endif

	cgs.media.regenSound = trap_S_RegisterSound("sound/items/regen.wav", qfalse);
	cgs.media.protectSound = trap_S_RegisterSound("sound/items/protect3.wav", qfalse);
	cgs.media.n_healthSound = trap_S_RegisterSound("sound/items/n_health.wav", qfalse );
	cgs.media.hgrenb1aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb1a.wav", qfalse);
	cgs.media.hgrenb2aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb2a.wav", qfalse);

#ifdef MISSIONPACK
	trap_S_RegisterSound("sound/player/james/death1.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/death2.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/death3.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/jump1.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/pain25_1.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/pain75_1.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/pain100_1.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/falling1.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/gasp.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/drown.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/fall1.wav", qfalse );
	trap_S_RegisterSound("sound/player/james/taunt.wav", qfalse );

	trap_S_RegisterSound("sound/player/janet/death1.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/death2.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/death3.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/jump1.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/pain25_1.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/pain75_1.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/pain100_1.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/falling1.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/gasp.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/drown.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/fall1.wav", qfalse );
	trap_S_RegisterSound("sound/player/janet/taunt.wav", qfalse );
#endif

}


//===================================================================================


/*
=====================
JUHOX: CG_LFEntOrigin
=====================
*/
#if MAPLENSFLARES
void CG_LFEntOrigin(const lensFlareEntity_t* lfent, vec3_t origin) {
	VectorCopy(lfent->origin, origin);
	if (lfent->lock) {
		VectorAdd(origin, lfent->lock->lerpOrigin, origin);
	}
}
#endif

/*
=====================
JUHOX: CG_SetLFEntOrigin
=====================
*/
#if MAPLENSFLARES
void CG_SetLFEntOrigin(lensFlareEntity_t* lfent, const vec3_t origin) {
	if (lfent->lock) {
		VectorSubtract(origin, lfent->lock->lerpOrigin, lfent->origin);
	}
	else {
		VectorCopy(origin, lfent->origin);
	}
}
#endif

/*
=================
JUHOX: CG_SetLFEdMoveMode
=================
*/
#if MAPLENSFLARES
void CG_SetLFEdMoveMode(lfeMoveMode_t mode) {
	vec3_t origin;

	if (cg.lfEditor.moveMode == mode) return;

	switch (mode) {
	case LFEMM_coarse:
		VectorCopy(cg.snap->ps.origin, origin);
		if (
			cg.lfEditor.moveMode == LFEMM_fine &&
			cg.lfEditor.selectedLFEnt
		) {
			vec3_t dir;

			AngleVectors(cg.snap->ps.viewangles, dir, NULL, NULL);
			CG_LFEntOrigin(cg.lfEditor.selectedLFEnt, origin);
			VectorMA(origin, -cg.lfEditor.fmm_distance, dir, origin);
		}
		trap_SendClientCommand(va("lfemm %d %f %f %f", mode, origin[0], origin[1], origin[2]));
		break;
	case LFEMM_fine:
		CG_LFEntOrigin(cg.lfEditor.selectedLFEnt, origin);
		VectorSubtract(origin, cg.refdef.vieworg, cg.lfEditor.fmm_offset);
		cg.lfEditor.fmm_distance = VectorLength(cg.lfEditor.fmm_offset);
		trap_SendClientCommand(va("lfemm %d", mode));
		break;
	}

	cg.lfEditor.moveMode = mode;
}
#endif

/*
=================
JUHOX: CG_SelectLFEnt
=================
*/
#if MAPLENSFLARES
void CG_SelectLFEnt(int lfentnum) {
	lensFlareEntity_t* lfent;

	if (lfentnum < 0 || lfentnum >= cgs.numLensFlareEntities) return;

	CG_SetLFEdMoveMode(LFEMM_coarse);
	lfent = &cgs.lensFlareEntities[lfentnum];
	cg.lfEditor.selectedLFEnt = lfent;
	cg.lfEditor.markedLFEnt = -1;
	cg.lfEditor.editMode = LFEEM_none;
	cg.lfEditor.originalLFEnt = *lfent;
}
#endif

#if MAPLENSFLARES	// JUHOX: definitions needed for parsing the lens flare files
#define FILESTACK_NAMESIZE 128
typedef struct {
	char path[FILESTACK_NAMESIZE];
	char name[FILESTACK_NAMESIZE];
} lfFileData_t;

#define FILESTACK_SIZE 128
static int numFilesOnStack;
static lfFileData_t fileStack[FILESTACK_SIZE];

static char lfNameBase[128];

static char lfbuf[65536];
#endif

/*
=================
JUHOX: CG_InitFileStack
=================
*/
#if MAPLENSFLARES
static void CG_InitFileStack(void) {
#if LFDEBUG
	CG_LoadingString("LF: CG_InitFileStack()");
#endif
	numFilesOnStack = 0;
	lfbuf[0] = 0;
}
#endif

/*
=================
JUHOX: CG_PushFile
=================
*/
#if MAPLENSFLARES
static void CG_PushFile(const char* path, const char* name) {
#if LFDEBUG
	CG_LoadingString(va("LF: CG_PushFile(%s)", name));
#endif
	if (numFilesOnStack >= FILESTACK_SIZE) return;

	Q_strncpyz(fileStack[numFilesOnStack].path, path, FILESTACK_NAMESIZE);
	Q_strncpyz(fileStack[numFilesOnStack].name, name, FILESTACK_NAMESIZE);
	numFilesOnStack++;
}
#endif

/*
=================
JUHOX: CG_PopFile
=================
*/
#if MAPLENSFLARES
static qboolean CG_PopFile(void) {
	char name[256];
	fileHandle_t file;
	int len;

#if LFDEBUG
	CG_LoadingString("LF: CG_PopFile()");
#endif
	PopFile:
	if (numFilesOnStack <= 0) return qfalse;

	numFilesOnStack--;
	Q_strncpyz(lfNameBase, fileStack[numFilesOnStack].name, sizeof(lfNameBase)-1);
	Com_sprintf(name, sizeof(name), "%s%s", fileStack[numFilesOnStack].path, lfNameBase);
	COM_StripExtension(lfNameBase, lfNameBase);
	len = strlen(lfNameBase);
	lfNameBase[len] = '/';
	lfNameBase[len+1] = 0;

	len = trap_FS_FOpenFile(name, &file, FS_READ);
	if (!file) {
		CG_Printf(S_COLOR_YELLOW "'%s' not found\n", name);
#if LFDEBUG
		CG_LoadingString(va("LF: CG_PopFile(%s) failed", name));
#endif
		goto PopFile;
	}
	if (len >= sizeof(lfbuf)) {
		CG_Printf(S_COLOR_YELLOW "file too large: '%s' > %d\n", name, sizeof(lfbuf)-1);
#if LFDEBUG
		CG_LoadingString(va("LF: CG_PopFile(%s): file too large", name));
#endif
		goto PopFile;
	}
	CG_Printf("reading '%s'...\n", name);
#if LFDEBUG
	CG_LoadingString(va("%s", name));
#endif

	trap_FS_Read(lfbuf, len, file);
	lfbuf[len] = 0;
	trap_FS_FCloseFile(file);
	return qtrue;
}
#endif

/*
=================
JUHOX: CG_ParseLensFlare
=================
*/
#if MAPLENSFLARES
static qboolean CG_ParseLensFlare(char** p, lensFlare_t* lf, const char* lfename) {
	char* token;

#if LFDEBUG
	CG_LoadingString(va("LF: CG_ParseLensFlare(%s)", lfename));
#endif
	// set non-zero default values
	lf->pos = 1.0;
	lf->size = 1.0;
	lf->rgba[0] = 0xff;
	lf->rgba[1] = 0xff;
	lf->rgba[2] = 0xff;
	lf->rgba[3] = 0xff;
	lf->fadeAngleFactor = 1.0;
	lf->entityAngleFactor = 1.0;
	lf->rotationRollFactor = 1.0;

	while (1) {
		token = COM_Parse(p);
		if (!token[0]) {
			CG_Printf(S_COLOR_YELLOW "unexpected end of lens flare definition in '%s'\n", lfename);
#if LFDEBUG
			CG_LoadingString(va("LF: CG_ParseLensFlare(%s) unexpected end", lfename));
#endif
			return qfalse;
		}

		if (!Q_stricmp(token, "}")) break;

		if (!Q_stricmp(token, "shader")) {
			token = COM_Parse(p);
			if (token[0]) {
				lf->shader = trap_R_RegisterShaderNoMip(token);
			}
		}
		else if (!Q_stricmp(token, "mode")) {
			token = COM_Parse(p);
			if (!Q_stricmp(token, "reflexion")) {
				lf->mode = LFM_reflexion;
			}
			else if (!Q_stricmp(token, "glare")) {
				lf->mode = LFM_glare;
			}
			else if (!Q_stricmp(token, "star")) {
				lf->mode = LFM_star;
			}
			else {
				CG_Printf(S_COLOR_YELLOW "unknown mode '%s' in '%s'\n", token, lfename);
				return qfalse;
			}
		}
		else if (!Q_stricmp(token, "pos")) {
			token = COM_Parse(p);
			lf->pos = atof(token);
		}
		else if (!Q_stricmp(token, "size")) {
			token = COM_Parse(p);
			lf->size = atof(token);
		}
		else if (!Q_stricmp(token, "color")) {
			token = COM_Parse(p);
			lf->rgba[0] = 0xff * Com_Clamp(0, 1, atof(token));

			token = COM_Parse(p);
			lf->rgba[1] = 0xff * Com_Clamp(0, 1, atof(token));

			token = COM_Parse(p);
			lf->rgba[2] = 0xff * Com_Clamp(0, 1, atof(token));
		}
		else if (!Q_stricmp(token, "alpha")) {
			token = COM_Parse(p);
			lf->rgba[3] = 0xff * Com_Clamp(0, 1000, atof(token));
		}
		else if (!Q_stricmp(token, "rotation")) {
			token = COM_Parse(p);
			lf->rotationOffset = Com_Clamp(-360, 360, atof(token));

			token = COM_Parse(p);
			lf->rotationYawFactor = atof(token);

			token = COM_Parse(p);
			lf->rotationPitchFactor = atof(token);

			token = COM_Parse(p);
			lf->rotationRollFactor = atof(token);
		}
		else if (!Q_stricmp(token, "fadeAngleFactor")) {
			token = COM_Parse(p);
			lf->fadeAngleFactor = atof(token);
			if (lf->fadeAngleFactor < 0) lf->fadeAngleFactor = 0;
		}
		else if (!Q_stricmp(token, "entityAngleFactor")) {
			token = COM_Parse(p);
			lf->entityAngleFactor = atof(token);
			if (lf->entityAngleFactor < 0) lf->entityAngleFactor = 0;
		}
		else if (!Q_stricmp(token, "intensityThreshold")) {
			token = COM_Parse(p);
			lf->intensityThreshold = Com_Clamp(0, 0.99, atof(token));
		}
		else {
			CG_Printf(S_COLOR_YELLOW "unexpected token '%s' in '%s'\n", token, lfename);
			return qfalse;
		}
	}
	return qtrue;
}
#endif

/*
=================
JUHOX: CG_FindLensFlareEffect
=================
*/
#if MAPLENSFLARES
static const lensFlareEffect_t* CG_FindLensFlareEffect(const char* name) {
	int i;

#if LFDEBUG
	CG_LoadingString(va("LF: CG_FindLensFlareEffect(%s)", name));
#endif
	for (i = 0; i < cgs.numLensFlareEffects; i++) {
		if (!Q_stricmp(name, cgs.lensFlareEffects[i].name)) {
			return &cgs.lensFlareEffects[i];
		}
	}
	return NULL;
}
#endif

/*
=================
JUHOX: CG_FinalizeLensFlareEffect
=================
*/
#if MAPLENSFLARES
static void CG_FinalizeLensFlareEffect(lensFlareEffect_t* lfeff) {
	int i;

#if LFDEBUG
	CG_LoadingString("LF: CG_FinalizeLensFlareEffect()");
#endif
	if (lfeff->range >= 0) return;

	for (i = 0; i < lfeff->numLensFlares; i++) {
		lensFlare_t* lf;

		lf = &lfeff->lensFlares[i];

		lf->intensityThreshold = 1 / (1 - lf->intensityThreshold) - 1;
	}
}
#endif

/*
=================
JUHOX: CG_ParseLensFlareEffect
=================
*/
#if MAPLENSFLARES
static qboolean CG_ParseLensFlareEffect(char** p, lensFlareEffect_t* lfe) {
	char* token;
	char* name;

#if LFDEBUG
	CG_LoadingString("LF: CG_ParseLensFlareEffect()");
#endif
	ParseEffect:
	token = COM_Parse(p);
	if (!token[0]) {
		if (CG_PopFile()) {
			*p = lfbuf;
			goto ParseEffect;
		}
		return qfalse;
	}

	if (!Q_stricmp(token, "import")) {
		CG_PushFile("flares/import/", COM_Parse(p));
		goto ParseEffect;
	}

	if (!Q_stricmp(token, "sunparm")) {
		token = COM_Parse(p);
		Q_strncpyz(cgs.sunFlareEffect, token, sizeof(cgs.sunFlareEffect));

		token = COM_Parse(p);
		cgs.sunFlareYaw = atof(token);

		token = COM_Parse(p);
		cgs.sunFlarePitch = atof(token);

		token = COM_Parse(p);
		cgs.sunFlareDistance = atof(token);
		goto ParseEffect;
	}

	name = va("%s%s", lfNameBase, token);
	if (CG_FindLensFlareEffect(name)) {
		SkipBracedSection(p);
		goto ParseEffect;
	}

	Q_strncpyz(lfe->name, name, sizeof(lfe->name));

	token = COM_Parse(p);
	if (Q_stricmp(token, "{")) {
		CG_Printf(S_COLOR_YELLOW "read '%s', expected '{' in '%s'\n", token, lfe->name);
		return qfalse;
	}

	// set non-zero default values
	lfe->range = 400;
	lfe->fadeAngle = 20;

	while (1) {
		token = COM_Parse(p);
		if (!token[0]) {
			CG_Printf(S_COLOR_YELLOW "unexpected end of lens flare effect '%s'\n", lfe->name);
			return qfalse;
		}

		if (!Q_stricmp(token, "}")) break;

		if (!Q_stricmp(token, "{")) {
			if (lfe->numLensFlares >= MAX_LENSFLARES_PER_EFFECT) {
				CG_Printf(S_COLOR_YELLOW "too many lensflares in '%s' (max=%d)\n", lfe->name, MAX_LENSFLARES_PER_EFFECT);
				return qfalse;
			}

			if (!CG_ParseLensFlare(p, &lfe->lensFlares[lfe->numLensFlares], lfe->name)) return qfalse;
			lfe->numLensFlares++;
		}
		else if (!Q_stricmp(token, "range")) {
			token = COM_Parse(p);
			lfe->range = atof(token);
			lfe->rangeSqr = Square(lfe->range);
		}
		else if (!Q_stricmp(token, "fadeAngle")) {
			token = COM_Parse(p);
			lfe->fadeAngle = Com_Clamp(0, 180, atof(token));
		}
		else {
			CG_Printf(S_COLOR_YELLOW "unexpected token '%s' in '%s'\n", token, lfe->name);
			return qfalse;
		}
	}

	CG_FinalizeLensFlareEffect(lfe);

	return qtrue;
}
#endif

/*
=================
JUHOX: CG_LoadLensFlares
=================
*/
#if MAPLENSFLARES
void CG_LoadLensFlares(void) {
	char* p;

#if LFDEBUG
	CG_LoadingString("LF: CG_LoadLensFlares()");
#endif

	CG_InitFileStack();

	cgs.numLensFlareEffects = 0;
	memset(&cgs.lensFlareEffects, 0, sizeof(cgs.lensFlareEffects));

	CG_PushFile("flares/", va("%s.lfs", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "mapname")));
	if (!CG_PopFile()) return;
	lfNameBase[0] = 0;

	p = lfbuf;

	// parse all lens flare effects
	while (cgs.numLensFlareEffects < MAX_LENSFLARE_EFFECTS && p) {
		if (!CG_ParseLensFlareEffect(&p, &cgs.lensFlareEffects[cgs.numLensFlareEffects])) {
			break;
		}
		cgs.numLensFlareEffects++;
	}
	CG_Printf("%d lens flare effects loaded\n", cgs.numLensFlareEffects);
}
#endif

/*
=================
JUHOX: CG_ComputeMaxVisAngle
=================
*/
#if MAPLENSFLARES
void CG_ComputeMaxVisAngle(lensFlareEntity_t* lfent) {
	const lensFlareEffect_t* lfeff;
	int i;
	float maxVisAngle;

#if LFDEBUG
	CG_LoadingString("LF: CG_ComputeMaxVisAngle()");
#endif
	lfeff = lfent->lfeff;
	if (lfent->angle >= 0 && lfeff) {
		maxVisAngle = 0.0;
		for (i = 0; i < lfeff->numLensFlares; i++) {
			const lensFlare_t* lf;
			float visAngle;

			lf = &lfeff->lensFlares[i];
			visAngle = lfent->angle * lf->entityAngleFactor + lfeff->fadeAngle * lf->fadeAngleFactor;
			if (visAngle > maxVisAngle) maxVisAngle = visAngle;
		}
	}
	else {
		maxVisAngle = 999.0;
	}
	lfent->maxVisAngle = maxVisAngle;
}
#endif

/*
=================
JUHOX: CG_ParseLensFlareEntity
=================
*/
#if MAPLENSFLARES
static qboolean CG_ParseLensFlareEntity(char** p, lensFlareEntity_t* lfent) {
	char* token;

#if LFDEBUG
	CG_LoadingString("LF: CG_ParseLensFlareEntity()");
#endif
	token = COM_Parse(p);
	if (!token[0]) return qfalse;

	if (Q_stricmp(token, "{")) {
		CG_Printf(S_COLOR_YELLOW "read '%s', expected '{'\n", token);
		return qfalse;
	}

	token = COM_Parse(p);
	if (!token[0]) {
		CG_Printf(S_COLOR_YELLOW "unexpected end of file\n");
		return qfalse;
	}
	lfent->lfeff = CG_FindLensFlareEffect(token);
	if (!lfent->lfeff) {
		CG_Printf(S_COLOR_YELLOW "undefined lens flare effect '%s'\n", token);
		//return qfalse;
	}

	lfent->origin[0] = atof(COM_Parse(p));
	lfent->origin[1] = atof(COM_Parse(p));
	lfent->origin[2] = atof(COM_Parse(p));

	lfent->radius = atof(COM_Parse(p));

	lfent->dir[0] = atof(COM_Parse(p));
	lfent->dir[1] = atof(COM_Parse(p));
	lfent->dir[2] = atof(COM_Parse(p));
	if (VectorLength(lfent->dir) < 0.1) {
		lfent->dir[0] = 1;
	}
	VectorNormalize(lfent->dir);

	lfent->angle = atof(COM_Parse(p));
	if (lfent->angle < 0) lfent->angle = -1;
	if (lfent->angle > 180) lfent->angle = 180;

	CG_ComputeMaxVisAngle(lfent);

	while (1) {
		token = COM_Parse(p);
		if (!token[0]) {
			CG_Printf(S_COLOR_YELLOW "unexpected end of file\n");
			return qfalse;
		}
		if (!Q_stricmp(token, "}")) {
			break;
		}
		else if (!Q_stricmp(token, "lr")) {
			lfent->lightRadius = atof(COM_Parse(p));
			if (lfent->lightRadius > lfent->radius) {
				lfent->lightRadius = lfent->radius;
			}
		}
		else if (!Q_stricmp(token, "mv")) {
			int entnum;

			entnum = atoi(COM_Parse(p));
			if (entnum >= MAX_CLIENTS && entnum < ENTITYNUM_WORLD) {
				lfent->lock = &cg_entities[entnum];
			}
		}
		else {
			CG_Printf(S_COLOR_YELLOW "unexpected token '%s'\n", token);
			return qfalse;
		}
	}

	return qtrue;
}
#endif

/*
=================
JUHOX: CG_LoadLensFlareEntities
=================
*/
#if MAPLENSFLARES
void CG_LoadLensFlareEntities(void) {
	char name[256];
	fileHandle_t f;
	int len;
	char* p;

#if LFDEBUG
	CG_LoadingString("LF: CG_LoadLensFlareEntities()");
#endif
	cgs.numLensFlareEntities = 0;
	memset(&cgs.lensFlareEntities, 0, sizeof(cgs.lensFlareEntities));

	if (cgs.sunFlareEffect[0]) {
		lensFlareEntity_t* lfent;
		vec3_t angles;
		vec3_t sunDir;

		lfent = &cgs.sunFlare;

		lfent->lfeff = CG_FindLensFlareEffect(cgs.sunFlareEffect);
		if (!lfent->lfeff) {
			CG_Printf(S_COLOR_YELLOW "undefined sun flare effect '%s'\n", cgs.sunFlareEffect);
		}

		angles[YAW] = cgs.sunFlareYaw;
		angles[PITCH] = -cgs.sunFlarePitch;
		angles[ROLL] = 0;
		AngleVectors(angles, sunDir, NULL, NULL);
		VectorScale(sunDir, cgs.sunFlareDistance, lfent->origin);

		lfent->radius = 150;
		lfent->lightRadius = 100;
		lfent->angle = -1;

		CG_ComputeMaxVisAngle(lfent);

		CG_Printf("sun flare entity created\n");
	}

	Com_sprintf(name, sizeof(name), "flares/%s.lfe", Info_ValueForKey(CG_ConfigString(CS_SERVERINFO), "mapname"));

	len = trap_FS_FOpenFile(name, &f, FS_READ);
	if (!f) {
		CG_Printf("'%s' not found\n", name);
		return;
	}
	if (len >= sizeof(lfbuf)) {
		CG_Printf(S_COLOR_YELLOW "file too large: '%s' > %d\n", name, sizeof(lfbuf)-1);
		return;
	}
	CG_Printf("reading '%s'...\n", name);
#if LFDEBUG
	CG_LoadingString(va("%s", name));
#endif

	trap_FS_Read(lfbuf, len, f);
	lfbuf[len] = 0;
	trap_FS_FCloseFile(f);

	COM_Compress(lfbuf);

	p = lfbuf;

	// parse all lens flare entities
	while (cgs.numLensFlareEntities < MAX_LIGHTS_PER_MAP && p) {
		if (!CG_ParseLensFlareEntity(&p, &cgs.lensFlareEntities[cgs.numLensFlareEntities])) {
			break;
		}
		cgs.numLensFlareEntities++;
	}

	CG_Printf("%d lens flare entities loaded\n", cgs.numLensFlareEntities);
#if LFDEBUG
	CG_LoadingString("LF: CG_LoadLensFlareEntities() ready");
#endif
}
#endif

/*
=================
CG_RegisterGraphics

This function may execute for a couple of minutes with a slow disk.
=================
*/
static void CG_RegisterGraphics( void ) {
	int			i;
	char		items[MAX_ITEMS+1];
	static char		*sb_nums[11] = {
		"gfx/2d/numbers/zero_32b",
		"gfx/2d/numbers/one_32b",
		"gfx/2d/numbers/two_32b",
		"gfx/2d/numbers/three_32b",
		"gfx/2d/numbers/four_32b",
		"gfx/2d/numbers/five_32b",
		"gfx/2d/numbers/six_32b",
		"gfx/2d/numbers/seven_32b",
		"gfx/2d/numbers/eight_32b",
		"gfx/2d/numbers/nine_32b",
		"gfx/2d/numbers/minus_32b",
	};

	// clear any references to old media
	memset( &cg.refdef, 0, sizeof( cg.refdef ) );
	trap_R_ClearScene();

	CG_LoadingString( cgs.mapname );

	trap_R_LoadWorldMap( cgs.mapname );

#if MAPLENSFLARES	// JUHOX: load map lens flares
	CG_LoadingString("lens flares");
	CG_LoadLensFlares();
	CG_LoadLensFlareEntities();
	cg.lfEditor.copyOptions = -1;
	cg.lfEditor.copiedLFEnt.dir[0] = 1;
#endif

	// JUHOX: load nearbox shaders
#if 1
	if (cgs.nearboxShaderName[0]) {
		//cgs.media.nearbox_up = trap_R_RegisterShader(va("%s_up", cgs.nearboxShaderName));
		cgs.media.nearbox_dn = trap_R_RegisterShader(va("%s_dn", cgs.nearboxShaderName));
		cgs.media.nearbox_ft = trap_R_RegisterShader(va("%s_ft", cgs.nearboxShaderName));
		cgs.media.nearbox_bk = trap_R_RegisterShader(va("%s_bk", cgs.nearboxShaderName));
		cgs.media.nearbox_lf = trap_R_RegisterShader(va("%s_lf", cgs.nearboxShaderName));
		cgs.media.nearbox_rt = trap_R_RegisterShader(va("%s_rt", cgs.nearboxShaderName));
	}
#endif

	// precache status bar pics
	CG_LoadingString( "game media" );

	for ( i=0 ; i<11 ; i++) {
		cgs.media.numberShaders[i] = trap_R_RegisterShader( sb_nums[i] );
	}

	cgs.media.botSkillShaders[0] = trap_R_RegisterShader( "menu/art/skill1.tga" );
	cgs.media.botSkillShaders[1] = trap_R_RegisterShader( "menu/art/skill2.tga" );
	cgs.media.botSkillShaders[2] = trap_R_RegisterShader( "menu/art/skill3.tga" );
	cgs.media.botSkillShaders[3] = trap_R_RegisterShader( "menu/art/skill4.tga" );
	cgs.media.botSkillShaders[4] = trap_R_RegisterShader( "menu/art/skill5.tga" );

	cgs.media.viewBloodShader = trap_R_RegisterShader( "viewBloodBlend" );

	cgs.media.deferShader = trap_R_RegisterShaderNoMip( "gfx/2d/defer.tga" );

	cgs.media.scoreboardName = trap_R_RegisterShaderNoMip( "menu/tab/name.tga" );
	cgs.media.scoreboardPing = trap_R_RegisterShaderNoMip( "menu/tab/ping.tga" );
	cgs.media.scoreboardScore = trap_R_RegisterShaderNoMip( "menu/tab/score.tga" );
	cgs.media.scoreboardTime = trap_R_RegisterShaderNoMip( "menu/tab/time.tga" );

	cgs.media.smokePuffShader = trap_R_RegisterShader( "smokePuff" );
	cgs.media.smokePuffRageProShader = trap_R_RegisterShader( "smokePuffRagePro" );
	cgs.media.shotgunSmokePuffShader = trap_R_RegisterShader( "shotgunSmokePuff" );
#ifdef MISSIONPACK
	cgs.media.nailPuffShader = trap_R_RegisterShader( "nailtrail" );
	cgs.media.blueProxMine = trap_R_RegisterModel( "models/weaphits/proxmineb.md3" );
#endif
	cgs.media.plasmaBallShader = trap_R_RegisterShader( "sprites/plasma1" );
	cgs.media.bloodTrailShader = trap_R_RegisterShader( "bloodTrail" );
	cgs.media.monsterBloodTrail1Shader = trap_R_RegisterShader("monsterBloodTrail1");	// JUHOX
	cgs.media.monsterBloodTrail2Shader = trap_R_RegisterShader("monsterBloodTrail2");	// JUHOX
	cgs.media.monsterBloodExplosionShader = trap_R_RegisterShader("gfx/damage/monster_blood_explosion");	// JUHOX
	cgs.media.lagometerShader = trap_R_RegisterShader("lagometer" );
	cgs.media.connectionShader = trap_R_RegisterShader( "disconnected" );

	cgs.media.waterBubbleShader = trap_R_RegisterShader( "waterBubble" );

	cgs.media.tracerShader = trap_R_RegisterShader( "gfx/misc/tracer" );
	cgs.media.selectShader = trap_R_RegisterShader( "gfx/2d/select" );

	for ( i = 0 ; i < NUM_CROSSHAIRS ; i++ ) {
		cgs.media.crosshairShader[i] = trap_R_RegisterShader( va("gfx/2d/crosshair%c", 'a'+i) );
	}

	cgs.media.backTileShader = trap_R_RegisterShader( "gfx/2d/backtile" );
	cgs.media.noammoShader = trap_R_RegisterShader( "icons/noammo" );

	// powerup shaders
	cgs.media.quadShader = trap_R_RegisterShader("powerups/quad" );
	cgs.media.quadWeaponShader = trap_R_RegisterShader("powerups/quadWeapon" );
	cgs.media.battleSuitShader = trap_R_RegisterShader("powerups/battleSuit" );
	cgs.media.battleWeaponShader = trap_R_RegisterShader("powerups/battleWeapon" );
	// JUHOX: new invisibility shader
#if 0
	cgs.media.invisShader = trap_R_RegisterShader("powerups/invisibility" );
#else
	cgs.media.invisShader = trap_R_RegisterShader("powerups/stdInvis" );
#endif
	cgs.media.regenShader = trap_R_RegisterShader("powerups/regen" );
	cgs.media.hastePuffShader = trap_R_RegisterShader("hasteSmokePuff" );
	cgs.media.chargeShader = trap_R_RegisterShader("powerups/charge");				// JUHOX
	cgs.media.chargeWeaponShader = trap_R_RegisterShader("powerups/chargeWeapon");	// JUHOX
	cgs.media.targetMarker = trap_R_RegisterShader("powerups/targetMarker");		// JUHOX
	cgs.media.shieldShader = trap_R_RegisterShader("powerups/shield");				// JUHOX
	cgs.media.shieldWeaponShader = trap_R_RegisterShader("powerups/shieldWeapon");	// JUHOX
	cgs.media.glassCloakingShader = trap_R_RegisterShader("powerups/glassCloaking");	// JUHOX
	cgs.media.glassCloakingSpecShader = trap_R_RegisterShader("powerups/glassCloakingSpecular");	// JUHOX
	// JUHOX: load shaders for new spawn effect
#if 1
	cgs.media.spawnHullShader = trap_R_RegisterShader("spawnHull");
	cgs.media.spawnHullGlow1Shader = trap_R_RegisterShader("spawnHullGlow1");
	cgs.media.spawnHullGlow2Shader = trap_R_RegisterShader("spawnHullGlow2");
	cgs.media.spawnHullGlow3Shader = trap_R_RegisterShader("spawnHullGlow3");
	cgs.media.spawnHullGlow4Shader = trap_R_RegisterShader("spawnHullGlow4");
	cgs.media.spawnHullWeaponShader = trap_R_RegisterShader("spawnHullWeapon");
	cgs.media.spawnHullGlow1WeaponShader = trap_R_RegisterShader("spawnHullGlow1Weapon");
	cgs.media.spawnHullGlow2WeaponShader = trap_R_RegisterShader("spawnHullGlow2Weapon");
	cgs.media.spawnHullGlow3WeaponShader = trap_R_RegisterShader("spawnHullGlow3Weapon");
	cgs.media.spawnHullGlow4WeaponShader = trap_R_RegisterShader("spawnHullGlow4Weapon");
#endif

	cgs.media.navaidShader = trap_R_RegisterShader("navaidline");	// JUHOX
	cgs.media.navaid2Shader = trap_R_RegisterShader("navaidline2");	// JUHOX
	cgs.media.navaidGoalShader = trap_R_RegisterShader("navAidGoal");	// JUHOX
	cgs.media.navaidTargetShader = trap_R_RegisterShader("navAidTarget");	// JUHOX

	cgs.media.fightInProgressShader = trap_R_RegisterShader("icons/fight");	// JUHOX
#if MONSTER_MODE
	if (cgs.gametype >= GT_STU) {
		cgs.media.artefactsShader = trap_R_RegisterShader("icons/artefact");	// JUHOX
		cgs.media.lifesShader = trap_R_RegisterShader("icons/lifes");	// JUHOX
		cgs.media.detectorShader = trap_R_RegisterShader("icons/detector_beep");	// JUHOX
		cgs.media.clockShader = trap_R_RegisterShader("icons/clock");	// JUHOX
		cgs.media.monsterSeedMetalShader = trap_R_RegisterShader("models/weapons2/monsterl/seed");	// JUHOX
	}
#endif

#if MONSTER_MODE
	cgs.media.hotAirShader = trap_R_RegisterShader("hotAir");	// JUHOX
#endif

	cgs.media.huntNameShader = trap_R_RegisterShader("gfx/hunt_name.tga");	// JUHOX

	cgs.media.deathBlurryShader = trap_R_RegisterShader("deathBlurry");	// JUHOX
	// JUHOX: load skull skin for CTF place-of-death marker
#if 1
	if (cgs.gametype == GT_CTF) {
		cgs.media.podSkullSkin = trap_R_RegisterSkin("models/players/bones/head_bones.skin");
	}
#endif
#if SPECIAL_VIEW_MODES
	cgs.media.scannerShader = trap_R_RegisterShader("scannerFilter");		// JUHOX
	cgs.media.amplifierShader = trap_R_RegisterShader("lightAmplifier");	// JUHOX
#endif

#ifdef MISSIONPACK
	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF || cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
#else
	if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
#endif
		cgs.media.redCubeModel = trap_R_RegisterModel( "models/powerups/orb/r_orb.md3" );
		cgs.media.blueCubeModel = trap_R_RegisterModel( "models/powerups/orb/b_orb.md3" );
		cgs.media.redCubeIcon = trap_R_RegisterShader( "icons/skull_red" );
		cgs.media.blueCubeIcon = trap_R_RegisterShader( "icons/skull_blue" );
	}

#ifdef MISSIONPACK
	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF || cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
#else
	if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
#endif
		cgs.media.redFlagModel = trap_R_RegisterModel( "models/flags/r_flag.md3" );
		cgs.media.blueFlagModel = trap_R_RegisterModel( "models/flags/b_flag.md3" );
		cgs.media.redFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_red1" );
		cgs.media.redFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_red2" );
		cgs.media.redFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_red3" );
		cgs.media.blueFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_blu1" );
		cgs.media.blueFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_blu2" );
		cgs.media.blueFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_blu3" );
#ifdef MISSIONPACK
		cgs.media.flagPoleModel = trap_R_RegisterModel( "models/flag2/flagpole.md3" );
		cgs.media.flagFlapModel = trap_R_RegisterModel( "models/flag2/flagflap3.md3" );

		cgs.media.redFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/red.skin" );
		cgs.media.blueFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/blue.skin" );
		cgs.media.neutralFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/white.skin" );

		cgs.media.redFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/red_base.md3" );
		cgs.media.blueFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/blue_base.md3" );
		cgs.media.neutralFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/ntrl_base.md3" );
#endif
	}

#ifdef MISSIONPACK
	if ( cgs.gametype == GT_1FCTF || cg_buildScript.integer ) {
		cgs.media.neutralFlagModel = trap_R_RegisterModel( "models/flags/n_flag.md3" );
		cgs.media.flagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_neutral1" );
		cgs.media.flagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_red2" );
		cgs.media.flagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_blu2" );
		cgs.media.flagShader[3] = trap_R_RegisterShaderNoMip( "icons/iconf_neutral3" );
	}

	if ( cgs.gametype == GT_OBELISK || cg_buildScript.integer ) {
		cgs.media.overloadBaseModel = trap_R_RegisterModel( "models/powerups/overload_base.md3" );
		cgs.media.overloadTargetModel = trap_R_RegisterModel( "models/powerups/overload_target.md3" );
		cgs.media.overloadLightsModel = trap_R_RegisterModel( "models/powerups/overload_lights.md3" );
		cgs.media.overloadEnergyModel = trap_R_RegisterModel( "models/powerups/overload_energy.md3" );
	}

	if ( cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
		cgs.media.harvesterModel = trap_R_RegisterModel( "models/powerups/harvester/harvester.md3" );
		cgs.media.harvesterRedSkin = trap_R_RegisterSkin( "models/powerups/harvester/red.skin" );
		cgs.media.harvesterBlueSkin = trap_R_RegisterSkin( "models/powerups/harvester/blue.skin" );
		cgs.media.harvesterNeutralModel = trap_R_RegisterModel( "models/powerups/obelisk/obelisk.md3" );
	}

	cgs.media.redKamikazeShader = trap_R_RegisterShader( "models/weaphits/kamikred" );
	cgs.media.dustPuffShader = trap_R_RegisterShader("hasteSmokePuff" );
#endif

	if ( cgs.gametype >= GT_TEAM || cg_buildScript.integer ) {
		cgs.media.friendShader = trap_R_RegisterShader( "sprites/foe" );
		cgs.media.redQuadShader = trap_R_RegisterShader("powerups/blueflag" );
		cgs.media.teamStatusBar = trap_R_RegisterShader( "gfx/2d/colorbar.tga" );
#ifdef MISSIONPACK
		cgs.media.blueKamikazeShader = trap_R_RegisterShader( "models/weaphits/kamikblu" );
#endif
		cgs.media.blueInvis = trap_R_RegisterShader("powerups/blueInvis");	// JUHOX
		cgs.media.redInvis = trap_R_RegisterShader("powerups/redInvis");	// JUHOX
	}

	// JUHOX: load friend shader for monster launcher
#if MONSTER_MODE
	if (cgs.gametype < GT_TEAM && cgs.monsterLauncher && !cgs.media.friendShader) {
		cgs.media.friendShader = trap_R_RegisterShader("sprites/foe");
	}
#endif

	cgs.media.armorModel = trap_R_RegisterModel( "models/powerups/armor/armor_yel.md3" );
	cgs.media.armorIcon  = trap_R_RegisterShaderNoMip( "icons/iconr_yellow" );

	cgs.media.machinegunBrassModel = trap_R_RegisterModel( "models/weapons2/shells/m_shell.md3" );
	cgs.media.shotgunBrassModel = trap_R_RegisterModel( "models/weapons2/shells/s_shell.md3" );

	cgs.media.gibAbdomen = trap_R_RegisterModel( "models/gibs/abdomen.md3" );
	cgs.media.gibArm = trap_R_RegisterModel( "models/gibs/arm.md3" );
	cgs.media.gibChest = trap_R_RegisterModel( "models/gibs/chest.md3" );
	cgs.media.gibFist = trap_R_RegisterModel( "models/gibs/fist.md3" );
	cgs.media.gibFoot = trap_R_RegisterModel( "models/gibs/foot.md3" );
	cgs.media.gibForearm = trap_R_RegisterModel( "models/gibs/forearm.md3" );
	cgs.media.gibIntestine = trap_R_RegisterModel( "models/gibs/intestine.md3" );
	cgs.media.gibLeg = trap_R_RegisterModel( "models/gibs/leg.md3" );
	cgs.media.gibSkull = trap_R_RegisterModel( "models/gibs/skull.md3" );
	cgs.media.gibBrain = trap_R_RegisterModel( "models/gibs/brain.md3" );
	// JUHOX: load monster gibs shader
#if MONSTER_MODE
	if (cgs.gametype >= GT_STU || cgs.monsterLauncher) {
		cgs.media.monsterGibsShader = trap_R_RegisterShader("models/gibs/monstergibs.tga");
	}
#endif

	cgs.media.smoke2 = trap_R_RegisterModel( "models/weapons2/shells/s_shell.md3" );

	cgs.media.balloonShader = trap_R_RegisterShader( "sprites/balloon3" );

	cgs.media.bloodExplosionShader = trap_R_RegisterShader( "bloodExplosion" );

	cgs.media.bulletFlashModel = trap_R_RegisterModel("models/weaphits/bullet.md3");
	cgs.media.ringFlashModel = trap_R_RegisterModel("models/weaphits/ring02.md3");
	cgs.media.dishFlashModel = trap_R_RegisterModel("models/weaphits/boom01.md3");
#ifdef MISSIONPACK
	cgs.media.teleportEffectModel = trap_R_RegisterModel( "models/powerups/pop.md3" );
#else
	cgs.media.teleportEffectModel = trap_R_RegisterModel( "models/misc/telep.md3" );
	cgs.media.teleportEffectShader = trap_R_RegisterShader( "teleportEffect" );
#endif
#ifdef MISSIONPACK
	cgs.media.kamikazeEffectModel = trap_R_RegisterModel( "models/weaphits/kamboom2.md3" );
	cgs.media.kamikazeShockWave = trap_R_RegisterModel( "models/weaphits/kamwave.md3" );
	cgs.media.kamikazeHeadModel = trap_R_RegisterModel( "models/powerups/kamikazi.md3" );
	cgs.media.kamikazeHeadTrail = trap_R_RegisterModel( "models/powerups/trailtest.md3" );
	cgs.media.guardPowerupModel = trap_R_RegisterModel( "models/powerups/guard_player.md3" );
	cgs.media.scoutPowerupModel = trap_R_RegisterModel( "models/powerups/scout_player.md3" );
	cgs.media.doublerPowerupModel = trap_R_RegisterModel( "models/powerups/doubler_player.md3" );
	cgs.media.ammoRegenPowerupModel = trap_R_RegisterModel( "models/powerups/ammo_player.md3" );
	cgs.media.invulnerabilityImpactModel = trap_R_RegisterModel( "models/powerups/shield/impact.md3" );
	cgs.media.invulnerabilityJuicedModel = trap_R_RegisterModel( "models/powerups/shield/juicer.md3" );
	cgs.media.medkitUsageModel = trap_R_RegisterModel( "models/powerups/regen.md3" );
	cgs.media.heartShader = trap_R_RegisterShaderNoMip( "ui/assets/statusbar/selectedhealth.tga" );

#endif

	cgs.media.invulnerabilityPowerupModel = trap_R_RegisterModel( "models/powerups/shield/shield.md3" );
	cgs.media.medalImpressive = trap_R_RegisterShaderNoMip( "medal_impressive" );
	cgs.media.medalExcellent = trap_R_RegisterShaderNoMip( "medal_excellent" );
	cgs.media.medalGauntlet = trap_R_RegisterShaderNoMip( "medal_gauntlet" );
	cgs.media.medalDefend = trap_R_RegisterShaderNoMip( "medal_defend" );
	cgs.media.medalAssist = trap_R_RegisterShaderNoMip( "medal_assist" );
	cgs.media.medalCapture = trap_R_RegisterShaderNoMip( "medal_capture" );

	// JUHOX: load group mark sprites
#if 1
	cgs.media.groupDesignated = trap_R_RegisterShader("tssgroupDesignated");
	cgs.media.groupTemporary = trap_R_RegisterShader("tssgroupTemporary");
	for (i = 0; i < MAX_GROUPS; i++) {
		char name[32];

		Com_sprintf(name, sizeof(name), "tssgroup%c", i + 'A');
		cgs.media.groupMarks[i] = trap_R_RegisterShader(name);
	}
#endif

	memset( cg_items, 0, sizeof( cg_items ) );
	memset( cg_weapons, 0, sizeof( cg_weapons ) );

	// only register the items that the server says we need
	strcpy( items, CG_ConfigString( CS_ITEMS) );

	for ( i = 1 ; i < bg_numItems ; i++ ) {
		if ( items[ i ] == '1' || cg_buildScript.integer ) {
			CG_LoadingItem( i );
			CG_RegisterItemVisuals( i );
		}
	}

	// wall marks
	cgs.media.bulletMarkShader = trap_R_RegisterShader( "gfx/damage/bullet_mrk" );
	cgs.media.burnMarkShader = trap_R_RegisterShader( "gfx/damage/burn_med_mrk" );
	cgs.media.holeMarkShader = trap_R_RegisterShader( "gfx/damage/hole_lg_mrk" );
	cgs.media.energyMarkShader = trap_R_RegisterShader( "gfx/damage/plasma_mrk" );
	cgs.media.shadowMarkShader = trap_R_RegisterShader( "markShadow" );
	cgs.media.wakeMarkShader = trap_R_RegisterShader( "wake" );
	cgs.media.bloodMarkShader = trap_R_RegisterShader( "bloodMark" );
	cgs.media.monsterBloodMarkShader = trap_R_RegisterShader("monsterBloodMark");	// JUHOX

	// register the inline models
	cgs.numInlineModels = trap_CM_NumInlineModels();
	for ( i = 1 ; i < cgs.numInlineModels ; i++ ) {
		char	name[10];
		vec3_t			mins, maxs;
		int				j;

		Com_sprintf( name, sizeof(name), "*%i", i );
		cgs.inlineDrawModel[i] = trap_R_RegisterModel( name );
		trap_R_ModelBounds( cgs.inlineDrawModel[i], mins, maxs );
		for ( j = 0 ; j < 3 ; j++ ) {
			cgs.inlineModelMidpoints[i][j] = mins[j] + 0.5 * ( maxs[j] - mins[j] );
		}
	}

	// register all the server specified models
	for (i=1 ; i<MAX_MODELS ; i++) {
		const char		*modelName;

		modelName = CG_ConfigString( CS_MODELS+i );
		if ( !modelName[0] ) {
			break;
		}
		cgs.gameModels[i] = trap_R_RegisterModel( modelName );
	}

#ifdef MISSIONPACK
	// new stuff
	cgs.media.patrolShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/patrol.tga");
	cgs.media.assaultShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/assault.tga");
	cgs.media.campShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/camp.tga");
	cgs.media.followShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/follow.tga");
	cgs.media.defendShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/defend.tga");
	cgs.media.teamLeaderShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/team_leader.tga");
	cgs.media.retrieveShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/retrieve.tga");
	cgs.media.escortShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/escort.tga");
	cgs.media.cursor = trap_R_RegisterShaderNoMip( "menu/art/3_cursor2" );
	cgs.media.sizeCursor = trap_R_RegisterShaderNoMip( "ui/assets/sizecursor.tga" );
	cgs.media.selectCursor = trap_R_RegisterShaderNoMip( "ui/assets/selectcursor.tga" );
	cgs.media.flagShaders[0] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_in_base.tga");
	cgs.media.flagShaders[1] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_capture.tga");
	cgs.media.flagShaders[2] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_missing.tga");

	trap_R_RegisterModel( "models/players/james/lower.md3" );
	trap_R_RegisterModel( "models/players/james/upper.md3" );
	trap_R_RegisterModel( "models/players/heads/james/james.md3" );

	trap_R_RegisterModel( "models/players/janet/lower.md3" );
	trap_R_RegisterModel( "models/players/janet/upper.md3" );
	trap_R_RegisterModel( "models/players/heads/janet/janet.md3" );

#endif
	CG_ClearParticles ();
/*
	for (i=1; i<MAX_PARTICLES_AREAS; i++)
	{
		{
			int rval;

			rval = CG_NewParticleArea ( CS_PARTICLES + i);
			if (!rval)
				break;
		}
	}
*/
}



/*
=======================
CG_BuildSpectatorString

=======================
*/
void CG_BuildSpectatorString() {
	int i;
	cg.spectatorList[0] = 0;
	for (i = 0; i < MAX_CLIENTS; i++) {
		if (cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_SPECTATOR ) {
			Q_strcat(cg.spectatorList, sizeof(cg.spectatorList), va("%s     ", cgs.clientinfo[i].name));
		}
	}
	i = strlen(cg.spectatorList);
	if (i != cg.spectatorLen) {
		cg.spectatorLen = i;
		cg.spectatorWidth = -1;
	}
}


/*
===================
CG_RegisterClients
===================
*/
static void CG_RegisterClients( void ) {
	int		i;

	// JUHOX: don't load client models in lens flare editor
#if MAPLENSFLARES
	if (cgs.editMode == EM_mlf) return;
#endif

	CG_LoadingClient(cg.clientNum);
	CG_NewClientInfo(cg.clientNum);

	// JUHOX: load monster
#if MONSTER_MODE
	if (cgs.gametype >= GT_STU) {
		CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_PREDATOR);
		CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_GUARD);
		CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_TITAN);
	}
	else if (cgs.monsterLauncher) {
		if (cgs.gametype < GT_TEAM) {
			CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_PREDATOR);
		}
		else {
			CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_PREDATOR_RED);
			CG_InitMonsterClientInfo(CLIENTNUM_MONSTER_PREDATOR_BLUE);
		}
	}
#endif

	for (i=0 ; i<MAX_CLIENTS ; i++) {
		const char		*clientInfo;

		if (cg.clientNum == i) {
			continue;
		}

		clientInfo = CG_ConfigString( CS_PLAYERS+i );
		if ( !clientInfo[0]) {
			continue;
		}
		CG_LoadingClient( i );
		CG_NewClientInfo( i );
	}
	CG_BuildSpectatorString();
}

//===========================================================================

/*
=================
CG_ConfigString
=================
*/
const char *CG_ConfigString( int index ) {
	if ( index < 0 || index >= MAX_CONFIGSTRINGS ) {
		CG_Error( "CG_ConfigString: bad index: %i", index );
	}
	return cgs.gameState.stringData + cgs.gameState.stringOffsets[ index ];
}

//==================================================================

/*
======================
CG_StartMusic

======================
*/
void CG_StartMusic( void ) {
	char	*s;
	char	parm1[MAX_QPATH], parm2[MAX_QPATH];

	// JUHOX: check type of music
#if PLAYLIST
	switch (cg_music.integer) {
	case 0:	// no music
	default:
		CG_StopPlayList();	// also stops any other music
		return;
	case 1:	// default music
		CG_StopPlayList();
		break;
	case 2:	// play list
		CG_ContinuePlayList();
		return;
	}
#endif

	// start the background music
	s = (char *)CG_ConfigString( CS_MUSIC );
	Q_strncpyz( parm1, COM_Parse( &s ), sizeof( parm1 ) );
	Q_strncpyz( parm2, COM_Parse( &s ), sizeof( parm2 ) );

	trap_S_StartBackgroundTrack( parm1, parm2 );
}
#ifdef MISSIONPACK
char *CG_GetMenuBuffer(const char *filename) {
	int	len;
	fileHandle_t	f;
	static char buf[MAX_MENUFILE];

	len = trap_FS_FOpenFile( filename, &f, FS_READ );
	if ( !f ) {
		trap_Print( va( S_COLOR_RED "menu file not found: %s, using default\n", filename ) );
		return NULL;
	}
	if ( len >= MAX_MENUFILE ) {
		trap_Print( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", filename, len, MAX_MENUFILE ) );
		trap_FS_FCloseFile( f );
		return NULL;
	}

	trap_FS_Read( buf, len, f );
	buf[len] = 0;
	trap_FS_FCloseFile( f );

	return buf;
}

//
// ==============================
// new hud stuff ( mission pack )
// ==============================
//
qboolean CG_Asset_Parse(int handle) {
	pc_token_t token;
	const char *tempStr;

	if (!trap_PC_ReadToken(handle, &token))
		return qfalse;
	if (Q_stricmp(token.string, "{") != 0) {
		return qfalse;
	}

	while ( 1 ) {
		if (!trap_PC_ReadToken(handle, &token))
			return qfalse;

		if (Q_stricmp(token.string, "}") == 0) {
			return qtrue;
		}

		// font
		if (Q_stricmp(token.string, "font") == 0) {
			int pointSize;
			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
				return qfalse;
			}
			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.textFont);
			continue;
		}

		// smallFont
		if (Q_stricmp(token.string, "smallFont") == 0) {
			int pointSize;
			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
				return qfalse;
			}
			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.smallFont);
			continue;
		}

		// font
		if (Q_stricmp(token.string, "bigfont") == 0) {
			int pointSize;
			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
				return qfalse;
			}
			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.bigFont);
			continue;
		}

		// gradientbar
		if (Q_stricmp(token.string, "gradientbar") == 0) {
			if (!PC_String_Parse(handle, &tempStr)) {
				return qfalse;
			}
			cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
			continue;
		}

		// enterMenuSound
		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
			if (!PC_String_Parse(handle, &tempStr)) {
				return qfalse;
			}
			cgDC.Assets.menuEnterSound = trap_S_RegisterSound( tempStr, qfalse );
			continue;
		}

		// exitMenuSound
		if (Q_stricmp(token.string, "menuExitSound") == 0) {
			if (!PC_String_Parse(handle, &tempStr)) {
				return qfalse;
			}
			cgDC.Assets.menuExitSound = trap_S_RegisterSound( tempStr, qfalse );
			continue;
		}

		// itemFocusSound
		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
			if (!PC_String_Parse(handle, &tempStr)) {
				return qfalse;
			}
			cgDC.Assets.itemFocusSound = trap_S_RegisterSound( tempStr, qfalse );
			continue;
		}

		// menuBuzzSound
		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
			if (!PC_String_Parse(handle, &tempStr)) {
				return qfalse;
			}
			cgDC.Assets.menuBuzzSound = trap_S_RegisterSound( tempStr, qfalse );
			continue;
		}

		if (Q_stricmp(token.string, "cursor") == 0) {
			if (!PC_String_Parse(handle, &cgDC.Assets.cursorStr)) {
				return qfalse;
			}
			cgDC.Assets.cursor = trap_R_RegisterShaderNoMip( cgDC.Assets.cursorStr);
			continue;
		}

		if (Q_stricmp(token.string, "fadeClamp") == 0) {
			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeClamp)) {
				return qfalse;
			}
			continue;
		}

		if (Q_stricmp(token.string, "fadeCycle") == 0) {
			if (!PC_Int_Parse(handle, &cgDC.Assets.fadeCycle)) {
				return qfalse;
			}
			continue;
		}

		if (Q_stricmp(token.string, "fadeAmount") == 0) {
			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeAmount)) {
				return qfalse;
			}
			continue;
		}

		if (Q_stricmp(token.string, "shadowX") == 0) {
			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowX)) {
				return qfalse;
			}
			continue;
		}

		if (Q_stricmp(token.string, "shadowY") == 0) {
			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowY)) {
				return qfalse;
			}
			continue;
		}

		if (Q_stricmp(token.string, "shadowColor") == 0) {
			if (!PC_Color_Parse(handle, &cgDC.Assets.shadowColor)) {
				return qfalse;
			}
			cgDC.Assets.shadowFadeClamp = cgDC.Assets.shadowColor[3];
			continue;
		}
	}
	return qfalse; // bk001204 - why not?
}

void CG_ParseMenu(const char *menuFile) {
	pc_token_t token;
	int handle;

	handle = trap_PC_LoadSource(menuFile);
	if (!handle)
		handle = trap_PC_LoadSource("ui/testhud.menu");
	if (!handle)
		return;

	while ( 1 ) {
		if (!trap_PC_ReadToken( handle, &token )) {
			break;
		}

		//if ( Q_stricmp( token, "{" ) ) {
		//	Com_Printf( "Missing { in menu file\n" );
		//	break;
		//}

		//if ( menuCount == MAX_MENUS ) {
		//	Com_Printf( "Too many menus!\n" );
		//	break;
		//}

		if ( token.string[0] == '}' ) {
			break;
		}

		if (Q_stricmp(token.string, "assetGlobalDef") == 0) {
			if (CG_Asset_Parse(handle)) {
				continue;
			} else {
				break;
			}
		}


		if (Q_stricmp(token.string, "menudef") == 0) {
			// start a new menu
			Menu_New(handle);
		}
	}
	trap_PC_FreeSource(handle);
}

qboolean CG_Load_Menu(char **p) {
	char *token;

	token = COM_ParseExt(p, qtrue);

	if (token[0] != '{') {
		return qfalse;
	}

	while ( 1 ) {

		token = COM_ParseExt(p, qtrue);

		if (Q_stricmp(token, "}") == 0) {
			return qtrue;
		}

		if ( !token || token[0] == 0 ) {
			return qfalse;
		}

		CG_ParseMenu(token);
	}
	return qfalse;
}



void CG_LoadMenus(const char *menuFile) {
	char	*token;
	char *p;
	int	len, start;
	fileHandle_t	f;
	static char buf[MAX_MENUDEFFILE];

	start = trap_Milliseconds();

	len = trap_FS_FOpenFile( menuFile, &f, FS_READ );
	if ( !f ) {
		trap_Error( va( S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile ) );
		len = trap_FS_FOpenFile( "ui/hud.txt", &f, FS_READ );
		if (!f) {
			trap_Error( va( S_COLOR_RED "default menu file not found: ui/hud.txt, unable to continue!\n", menuFile ) );
		}
	}

	if ( len >= MAX_MENUDEFFILE ) {
		trap_Error( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", menuFile, len, MAX_MENUDEFFILE ) );
		trap_FS_FCloseFile( f );
		return;
	}

	trap_FS_Read( buf, len, f );
	buf[len] = 0;
	trap_FS_FCloseFile( f );

	COM_Compress(buf);

	Menu_Reset();

	p = buf;

	while ( 1 ) {
		token = COM_ParseExt( &p, qtrue );
		if( !token || token[0] == 0 || token[0] == '}') {
			break;
		}

		//if ( Q_stricmp( token, "{" ) ) {
		//	Com_Printf( "Missing { in menu file\n" );
		//	break;
		//}

		//if ( menuCount == MAX_MENUS ) {
		//	Com_Printf( "Too many menus!\n" );
		//	break;
		//}

		if ( Q_stricmp( token, "}" ) == 0 ) {
			break;
		}

		if (Q_stricmp(token, "loadmenu") == 0) {
			if (CG_Load_Menu(&p)) {
				continue;
			} else {
				break;
			}
		}
	}

	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);

}



static qboolean CG_OwnerDrawHandleKey(int ownerDraw, int flags, float *special, int key) {
	return qfalse;
}


static int CG_FeederCount(float feederID) {
	int i, count;
	count = 0;
	if (feederID == FEEDER_REDTEAM_LIST) {
		for (i = 0; i < cg.numScores; i++) {
			if (cg.scores[i].team == TEAM_RED) {
				count++;
			}
		}
	} else if (feederID == FEEDER_BLUETEAM_LIST) {
		for (i = 0; i < cg.numScores; i++) {
			if (cg.scores[i].team == TEAM_BLUE) {
				count++;
			}
		}
	} else if (feederID == FEEDER_SCOREBOARD) {
		return cg.numScores;
	}
	return count;
}


void CG_SetScoreSelection(void *p) {
	menuDef_t *menu = (menuDef_t*)p;
	playerState_t *ps = &cg.snap->ps;
	int i, red, blue;
	red = blue = 0;
	for (i = 0; i < cg.numScores; i++) {
		if (cg.scores[i].team == TEAM_RED) {
			red++;
		} else if (cg.scores[i].team == TEAM_BLUE) {
			blue++;
		}
		if (ps->clientNum == cg.scores[i].client) {
			cg.selectedScore = i;
		}
	}

	if (menu == NULL) {
		// just interested in setting the selected score
		return;
	}

	if ( cgs.gametype >= GT_TEAM ) {
		int feeder = FEEDER_REDTEAM_LIST;
		i = red;
		if (cg.scores[cg.selectedScore].team == TEAM_BLUE) {
			feeder = FEEDER_BLUETEAM_LIST;
			i = blue;
		}
		Menu_SetFeederSelection(menu, feeder, i, NULL);
	} else {
		Menu_SetFeederSelection(menu, FEEDER_SCOREBOARD, cg.selectedScore, NULL);
	}
}

// FIXME: might need to cache this info
static clientInfo_t * CG_InfoFromScoreIndex(int index, int team, int *scoreIndex) {
	int i, count;
	if ( cgs.gametype >= GT_TEAM ) {
		count = 0;
		for (i = 0; i < cg.numScores; i++) {
			if (cg.scores[i].team == team) {
				if (count == index) {
					*scoreIndex = i;
					return &cgs.clientinfo[cg.scores[i].client];
				}
				count++;
			}
		}
	}
	*scoreIndex = index;
	return &cgs.clientinfo[ cg.scores[index].client ];
}

static const char *CG_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
	gitem_t *item;
	int scoreIndex = 0;
	clientInfo_t *info = NULL;
	int team = -1;
	score_t *sp = NULL;

	*handle = -1;

	if (feederID == FEEDER_REDTEAM_LIST) {
		team = TEAM_RED;
	} else if (feederID == FEEDER_BLUETEAM_LIST) {
		team = TEAM_BLUE;
	}

	info = CG_InfoFromScoreIndex(index, team, &scoreIndex);
	sp = &cg.scores[scoreIndex];

	if (info && info->infoValid) {
		switch (column) {
			case 0:
				if ( info->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
					item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
					*handle = cg_items[ ITEM_INDEX(item) ].icon;
				} else if ( info->powerups & ( 1 << PW_REDFLAG ) ) {
					item = BG_FindItemForPowerup( PW_REDFLAG );
					*handle = cg_items[ ITEM_INDEX(item) ].icon;
				} else if ( info->powerups & ( 1 << PW_BLUEFLAG ) ) {
					item = BG_FindItemForPowerup( PW_BLUEFLAG );
					*handle = cg_items[ ITEM_INDEX(item) ].icon;
				} else {
					if ( info->botSkill > 0 && info->botSkill <= 5 ) {
						*handle = cgs.media.botSkillShaders[ info->botSkill - 1 ];
					} else if ( info->handicap < 100 ) {
					return va("%i", info->handicap );
					}
				}
			break;
			case 1:
				if (team == -1) {
					return "";
				} else {
					*handle = CG_StatusHandle(info->teamTask);
				}
		  break;
			case 2:
				if ( cg.snap->ps.stats[ STAT_CLIENTS_READY ] & ( 1 << sp->client ) ) {
					return "Ready";
				}
				if (team == -1) {
					if (cgs.gametype == GT_TOURNAMENT) {
						return va("%i/%i", info->wins, info->losses);
					} else if (info->infoValid && info->team == TEAM_SPECTATOR ) {
						return "Spectator";
					} else {
						return "";
					}
				} else {
					if (info->teamLeader) {
						return "Leader";
					}
				}
			break;
			case 3:
				return info->name;
			break;
			case 4:
				return va("%i", info->score);
			break;
			case 5:
				return va("%4i", sp->time);
			break;
			case 6:
				if ( sp->ping == -1 ) {
					return "connecting";
				}
				return va("%4i", sp->ping);
			break;
		}
	}

	return "";
}

static qhandle_t CG_FeederItemImage(float feederID, int index) {
	return 0;
}

static void CG_FeederSelection(float feederID, int index) {
	if ( cgs.gametype >= GT_TEAM ) {
		int i, count;
		int team = (feederID == FEEDER_REDTEAM_LIST) ? TEAM_RED : TEAM_BLUE;
		count = 0;
		for (i = 0; i < cg.numScores; i++) {
			if (cg.scores[i].team == team) {
				if (index == count) {
					cg.selectedScore = i;
				}
				count++;
			}
		}
	} else {
		cg.selectedScore = index;
	}
}
#endif

#ifdef MISSIONPACK // bk001204 - only needed there
static float CG_Cvar_Get(const char *cvar) {
	char buff[128];
	memset(buff, 0, sizeof(buff));
	trap_Cvar_VariableStringBuffer(cvar, buff, sizeof(buff));
	return atof(buff);
}
#endif

#ifdef MISSIONPACK
void CG_Text_PaintWithCursor(float x, float y, float scale, vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style) {
	CG_Text_Paint(x, y, scale, color, text, 0, limit, style);
}

static int CG_OwnerDrawWidth(int ownerDraw, float scale) {
	switch (ownerDraw) {
	  case CG_GAME_TYPE:
			return CG_Text_Width(CG_GameTypeString(), scale, 0);
	  case CG_GAME_STATUS:
			return CG_Text_Width(CG_GetGameStatusText(), scale, 0);
			break;
	  case CG_KILLER:
			return CG_Text_Width(CG_GetKillerText(), scale, 0);
			break;
	  case CG_RED_NAME:
			return CG_Text_Width(cg_redTeamName.string, scale, 0);
			break;
	  case CG_BLUE_NAME:
			return CG_Text_Width(cg_blueTeamName.string, scale, 0);
			break;


	}
	return 0;
}

static int CG_PlayCinematic(const char *name, float x, float y, float w, float h) {
  return trap_CIN_PlayCinematic(name, x, y, w, h, CIN_loop);
}

static void CG_StopCinematic(int handle) {
  trap_CIN_StopCinematic(handle);
}

static void CG_DrawCinematic(int handle, float x, float y, float w, float h) {
  trap_CIN_SetExtents(handle, x, y, w, h);
  trap_CIN_DrawCinematic(handle);
}

static void CG_RunCinematicFrame(int handle) {
  trap_CIN_RunCinematic(handle);
}

/*
=================
CG_LoadHudMenu();

=================
*/
void CG_LoadHudMenu() {
	char buff[1024];
	const char *hudSet;

	cgDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
	cgDC.setColor = &trap_R_SetColor;
	cgDC.drawHandlePic = &CG_DrawPic;
	cgDC.drawStretchPic = &trap_R_DrawStretchPic;
	cgDC.drawText = &CG_Text_Paint;
	cgDC.textWidth = &CG_Text_Width;
	cgDC.textHeight = &CG_Text_Height;
	cgDC.registerModel = &trap_R_RegisterModel;
	cgDC.modelBounds = &trap_R_ModelBounds;
	cgDC.fillRect = &CG_FillRect;
	cgDC.drawRect = &CG_DrawRect;
	cgDC.drawSides = &CG_DrawSides;
	cgDC.drawTopBottom = &CG_DrawTopBottom;
	cgDC.clearScene = &trap_R_ClearScene;
	cgDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
	cgDC.renderScene = &trap_R_RenderScene;
	cgDC.registerFont = &trap_R_RegisterFont;
	cgDC.ownerDrawItem = &CG_OwnerDraw;
	cgDC.getValue = &CG_GetValue;
	cgDC.ownerDrawVisible = &CG_OwnerDrawVisible;
	cgDC.runScript = &CG_RunMenuScript;
	cgDC.getTeamColor = &CG_GetTeamColor;
	cgDC.setCVar = trap_Cvar_Set;
	cgDC.getCVarString = trap_Cvar_VariableStringBuffer;
	cgDC.getCVarValue = CG_Cvar_Get;
	cgDC.drawTextWithCursor = &CG_Text_PaintWithCursor;
	//cgDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
	//cgDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
	cgDC.startLocalSound = &trap_S_StartLocalSound;
	cgDC.ownerDrawHandleKey = &CG_OwnerDrawHandleKey;
	cgDC.feederCount = &CG_FeederCount;
	cgDC.feederItemImage = &CG_FeederItemImage;
	cgDC.feederItemText = &CG_FeederItemText;
	cgDC.feederSelection = &CG_FeederSelection;
	//cgDC.setBinding = &trap_Key_SetBinding;
	//cgDC.getBindingBuf = &trap_Key_GetBindingBuf;
	//cgDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
	//cgDC.executeText = &trap_Cmd_ExecuteText;
	cgDC.Error = &Com_Error;
	cgDC.Print = &Com_Printf;
	cgDC.ownerDrawWidth = &CG_OwnerDrawWidth;
	//cgDC.Pause = &CG_Pause;
	cgDC.registerSound = &trap_S_RegisterSound;
	cgDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
	cgDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
	cgDC.playCinematic = &CG_PlayCinematic;
	cgDC.stopCinematic = &CG_StopCinematic;
	cgDC.drawCinematic = &CG_DrawCinematic;
	cgDC.runCinematicFrame = &CG_RunCinematicFrame;

	Init_Display(&cgDC);

	Menu_Reset();

	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
	hudSet = buff;
	if (hudSet[0] == '\0') {
		hudSet = "ui/hud.txt";
	}

	CG_LoadMenus(hudSet);
}

void CG_AssetCache() {
	//if (Assets.textFont == NULL) {
	//  trap_R_RegisterFont("fonts/arial.ttf", 72, &Assets.textFont);
	//}
	//Assets.background = trap_R_RegisterShaderNoMip( ASSET_BACKGROUND );
	//Com_Printf("Menu Size: %i bytes\n", sizeof(Menus));
	cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip( ASSET_GRADIENTBAR );
	cgDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip( ART_FX_BASE );
	cgDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip( ART_FX_RED );
	cgDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip( ART_FX_YELLOW );
	cgDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip( ART_FX_GREEN );
	cgDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip( ART_FX_TEAL );
	cgDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip( ART_FX_BLUE );
	cgDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip( ART_FX_CYAN );
	cgDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip( ART_FX_WHITE );
	cgDC.Assets.scrollBar = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR );
	cgDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWDOWN );
	cgDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWUP );
	cgDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWLEFT );
	cgDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWRIGHT );
	cgDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip( ASSET_SCROLL_THUMB );
	cgDC.Assets.sliderBar = trap_R_RegisterShaderNoMip( ASSET_SLIDER_BAR );
	cgDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip( ASSET_SLIDER_THUMB );
}
#endif


/*
=================
JUHOX: CG_Get3DFontModelBounds
=================
*/
/*
static void CG_Get3DFontModelBounds(void) {
	int i;
	fileHandle_t file;

	trap_FS_FOpenFile("font.txt", &file, FS_WRITE);
	if (!file) return;

	for (i = 33; i < 256; i++) {
		qhandle_t model;
		char buf[32];

		model = trap_R_RegisterModel(va("models/fonts/hunt1/f_%d.md3", i));
		if (model) {
			vec3_t mins, maxs;
			float width;

			trap_R_ModelBounds(model, mins, maxs);
			width = maxs[1] - mins[1];
			Com_sprintf(buf, sizeof(buf), "%f,\n", width);
		}
		else {
			Com_sprintf(buf, sizeof(buf), "0, //omitted\n");
		}
		trap_FS_Write(buf, strlen(buf), file);
	}
	trap_FS_FCloseFile(file);
}
*/

/*
=================
CG_Init

Called after every level change or subsystem restart
Will perform callbacks to make the loading info screen update.
=================
*/
void CG_Init( int serverMessageNum, int serverCommandSequence, int clientNum ) {
	const char	*s;

	// clear everything
	memset( &cgs, 0, sizeof( cgs ) );
	memset( &cg, 0, sizeof( cg ) );
	memset( cg_entities, 0, sizeof(cg_entities) );
	memset( cg_weapons, 0, sizeof(cg_weapons) );
	memset( cg_items, 0, sizeof(cg_items) );

	//CG_Get3DFontModelBounds();	// JUHOX

	cg.clientNum = clientNum;

	cgs.processedSnapshotNum = serverMessageNum;
	cgs.serverCommandSequence = serverCommandSequence;

	CG_TSS_InitInterface();	// JUHOX

	// load a few needed things before we do any screen updates
#if 0	// JUHOX: new charsetShader
	cgs.media.charsetShader		= trap_R_RegisterShader( "gfx/2d/bigchars" );
#else
	cgs.media.oldCharsetShader = trap_R_RegisterShader("gfx/2d/bigchars");	// better readable with low resolutions
	cgs.media.charsetShaders[0] = trap_R_RegisterShader("gfx/2d/bigchar0");
	cgs.media.charsetShaders[1] = trap_R_RegisterShader("gfx/2d/bigchar1");
	cgs.media.charsetShaders[2] = trap_R_RegisterShader("gfx/2d/bigchar2");
	cgs.media.charsetShaders[3] = trap_R_RegisterShader("gfx/2d/bigchar3");
	cgs.media.charsetShaders[4] = trap_R_RegisterShader("gfx/2d/bigchar4");
	cgs.media.charsetShaders[5] = trap_R_RegisterShader("gfx/2d/bigchar5");
	cgs.media.charsetShaders[6] = trap_R_RegisterShader("gfx/2d/bigchar6");
	cgs.media.charsetShaders[7] = trap_R_RegisterShader("gfx/2d/bigchar7");
#endif
	cgs.media.whiteShader		= trap_R_RegisterShader( "white" );
	cgs.media.charsetProp		= trap_R_RegisterShaderNoMip( "menu/art/font1_prop.tga" );
	cgs.media.charsetPropGlow	= trap_R_RegisterShaderNoMip( "menu/art/font1_prop_glo.tga" );
	cgs.media.charsetPropB		= trap_R_RegisterShaderNoMip( "menu/art/font2_prop.tga" );

	CG_RegisterCvars();

	CG_InitConsoleCommands();

	cg.weaponSelect = WP_MACHINEGUN;
	cg.weaponManuallySet = qtrue;	// JUHOX
	cg.weaponOrderActive = qfalse;	// JUHOX

	cgs.redflag = cgs.blueflag = -1; // For compatibily, default to unset for
	cgs.flagStatus = -1;
	// old servers

	// get the rendering configuration from the client system
	trap_GetGlconfig( &cgs.glconfig );
	cgs.screenXScale = cgs.glconfig.vidWidth / 640.0;
	cgs.screenYScale = cgs.glconfig.vidHeight / 480.0;

	// get the gamestate from the client system
	trap_GetGameState( &cgs.gameState );

	// check version
	s = CG_ConfigString( CS_GAME_VERSION );
	if ( strcmp( s, GAME_VERSION ) ) {
		CG_Error( "Client/Server game mismatch: %s/%s", GAME_VERSION, s );
	}

	s = CG_ConfigString( CS_LEVEL_START_TIME );
	cgs.levelStartTime = atoi( s );

#if 1	// JUHOX: get nearbox shader name
	Q_strncpyz(cgs.nearboxShaderName, CG_ConfigString(CS_NEARBOX), sizeof(cgs.nearboxShaderName));
#endif

	CG_ParseServerinfo();

	// load the new map
	CG_LoadingString( "collision map" );

	trap_CM_LoadMap( cgs.mapname );

#ifdef MISSIONPACK
	String_Init();
#endif

	cg.loading = qtrue;		// force players to load instead of defer

	CG_LoadingString( "sounds" );

	CG_RegisterSounds();

	CG_LoadingString( "graphics" );

	CG_RegisterGraphics();

	CG_LoadingString( "clients" );

	CG_RegisterClients();		// if low on memory, some clients will be deferred

#ifdef MISSIONPACK
	CG_AssetCache();
	CG_LoadHudMenu();      // load new hud stuff
#endif

	cg.loading = qfalse;	// future players will be deferred

	CG_InitLocalEntities();

	CG_InitMarkPolys();

	// remove the last loading update
	cg.infoScreenText[0] = 0;

	// Make sure we have update values (scores)
	CG_SetConfigValues();

#if 0	// JUHOX: don't play in-game music
	CG_StartMusic();
#else

#if !PLAYLIST	// JUHOX: init playlist
	trap_S_StopBackgroundTrack();
#else
	CG_InitPlayList();
	CG_ParsePlayList();
#endif

#endif


	CG_LoadingString( "" );

#ifdef MISSIONPACK
	CG_InitTeamChat();
#endif

	CG_ShaderStateChanged();

	trap_S_ClearLoopingSounds( qtrue );

	CG_TSS_LoadInterface();	// JUHOX

	trap_Cvar_Set("ui_init", "0");	// JUHOX
#if MONSTER_MODE	// JUHOX: prevent "sudden death" announcement in STU
	if (cgs.gametype >= GT_STU) {
		cg.timelimitWarnings = 4;
	}
#endif
#if 1	// JUHOX: get record
	{
		int recordType;

		recordType = GC_none;
		cgs.record = 0;
		sscanf(CG_ConfigString(CS_RECORD), "%d,%d", &recordType, &cgs.record);
		cgs.recordType = recordType;
	}
#endif
}

/*
=================
CG_Shutdown

Called before every level change or subsystem restart
=================
*/
void CG_Shutdown( void ) {
	// some mods may need to do cleanup work here,
	// like closing files or archiving session data
	CG_TSS_SaveInterface();	// JUHOX
}


/*
==================
CG_EventHandling
==================
 type 0 - no event handling
      1 - team menu
      2 - hud editor

*/
#ifndef MISSIONPACK
void CG_EventHandling(int type) {
}



void CG_KeyEvent(int key, qboolean down) {
}

void CG_MouseEvent(int x, int y) {
}
#endif
