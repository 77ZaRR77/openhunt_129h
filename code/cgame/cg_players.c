// Copyright (C) 1999-2000 Id Software, Inc.
//
// cg_players.c -- handle the media and animation for player entities
#include "cg_local.h"

char	*cg_customSoundNames[MAX_CUSTOM_SOUNDS] = {
	"*death1.wav",
	"*death2.wav",
	"*death3.wav",
	"*jump1.wav",
	"*pain25_1.wav",
	"*pain50_1.wav",
	"*pain75_1.wav",
	"*pain100_1.wav",
	"*falling1.wav",
	"*gasp.wav",
	"*drown.wav",
	"*fall1.wav",
	"*taunt.wav"
};


/*
================
CG_CustomSound

================
*/
sfxHandle_t	CG_CustomSound( int clientNum, const char *soundName ) {
	clientInfo_t *ci;
	int			i;

	if ( soundName[0] != '*' ) {
		return trap_S_RegisterSound( soundName, qfalse );
	}

	// JUHOX: accept EXTRA_CLIENTNUMS
#if !MONSTER_MODE
	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
		clientNum = 0;
	}
	ci = &cgs.clientinfo[ clientNum ];
#else
	if (clientNum < 0 || clientNum >= ENTITYNUM_MAX_NORMAL) {
		clientNum = 0;
	}
	if (clientNum >= MAX_CLIENTS) {
		clientNum = cg_entities[clientNum].currentState.clientNum;
		if (clientNum < 0 || clientNum >= MAX_CLIENTS + EXTRA_CLIENTNUMS) {
			clientNum = CLIENTNUM_MONSTER_PREDATOR;
		}
	}
	ci = &cgs.clientinfo[ clientNum ];
	if (!ci->infoValid) ci = &cgs.clientinfo[0];
#endif

	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS && cg_customSoundNames[i] ; i++ ) {
		if ( !strcmp( soundName, cg_customSoundNames[i] ) ) {
			return ci->sounds[i];
		}
	}

	CG_Error( "Unknown custom sound: %s", soundName );
	return 0;
}



/*
=============================================================================

CLIENT INFO

=============================================================================
*/

/*
======================
CG_ParseAnimationFile

Read a configuration file containing animation coutns and rates
models/players/visor/animation.cfg, etc
======================
*/
static qboolean	CG_ParseAnimationFile( const char *filename, clientInfo_t *ci ) {
	char		*text_p, *prev;
	int			len;
	int			i;
	char		*token;
	float		fps;
	int			skip;
	char		text[20000];
	fileHandle_t	f;
	animation_t *animations;

	animations = ci->animations;

	// load the file
	len = trap_FS_FOpenFile( filename, &f, FS_READ );
	if ( len <= 0 ) {
		return qfalse;
	}
	if ( len >= sizeof( text ) - 1 ) {
		CG_Printf( "File %s too long\n", filename );
		return qfalse;
	}
	trap_FS_Read( text, len, f );
	text[len] = 0;
	trap_FS_FCloseFile( f );

	// parse the text
	text_p = text;
	skip = 0;	// quite the compiler warning

	ci->footsteps = FOOTSTEP_NORMAL;
	VectorClear( ci->headOffset );
	ci->gender = GENDER_MALE;
	ci->fixedlegs = qfalse;
	ci->fixedtorso = qfalse;

	// read optional parameters
	while ( 1 ) {
		prev = text_p;	// so we can unget
		token = COM_Parse( &text_p );
		if ( !token ) {
			break;
		}
		if ( !Q_stricmp( token, "footsteps" ) ) {
			token = COM_Parse( &text_p );
			if ( !token ) {
				break;
			}
			if ( !Q_stricmp( token, "default" ) || !Q_stricmp( token, "normal" ) ) {
				ci->footsteps = FOOTSTEP_NORMAL;
			} else if ( !Q_stricmp( token, "boot" ) ) {
				ci->footsteps = FOOTSTEP_BOOT;
			} else if ( !Q_stricmp( token, "flesh" ) ) {
				ci->footsteps = FOOTSTEP_FLESH;
			} else if ( !Q_stricmp( token, "mech" ) ) {
				ci->footsteps = FOOTSTEP_MECH;
			} else if ( !Q_stricmp( token, "energy" ) ) {
				ci->footsteps = FOOTSTEP_ENERGY;
			} else {
				CG_Printf( "Bad footsteps parm in %s: %s\n", filename, token );
			}
			continue;
		} else if ( !Q_stricmp( token, "headoffset" ) ) {
			for ( i = 0 ; i < 3 ; i++ ) {
				token = COM_Parse( &text_p );
				if ( !token ) {
					break;
				}
				ci->headOffset[i] = atof( token );
			}
			continue;
		} else if ( !Q_stricmp( token, "sex" ) ) {
			token = COM_Parse( &text_p );
			if ( !token ) {
				break;
			}
			if ( token[0] == 'f' || token[0] == 'F' ) {
				ci->gender = GENDER_FEMALE;
			} else if ( token[0] == 'n' || token[0] == 'N' ) {
				ci->gender = GENDER_NEUTER;
			} else {
				ci->gender = GENDER_MALE;
			}
			continue;
		} else if ( !Q_stricmp( token, "fixedlegs" ) ) {
			ci->fixedlegs = qtrue;
			continue;
		} else if ( !Q_stricmp( token, "fixedtorso" ) ) {
			ci->fixedtorso = qtrue;
			continue;
		}

		// if it is a number, start parsing animations
		if ( token[0] >= '0' && token[0] <= '9' ) {
			text_p = prev;	// unget the token
			break;
		}
		Com_Printf( "unknown token '%s' is %s\n", token, filename );
	}

	// read information for each frame
	for ( i = 0 ; i < MAX_ANIMATIONS ; i++ ) {

		token = COM_Parse( &text_p );
		if ( !*token ) {
			if( i >= TORSO_GETFLAG && i <= TORSO_NEGATIVE ) {
				animations[i].firstFrame = animations[TORSO_GESTURE].firstFrame;
				animations[i].frameLerp = animations[TORSO_GESTURE].frameLerp;
				animations[i].initialLerp = animations[TORSO_GESTURE].initialLerp;
				animations[i].loopFrames = animations[TORSO_GESTURE].loopFrames;
				animations[i].numFrames = animations[TORSO_GESTURE].numFrames;
				animations[i].reversed = qfalse;
				animations[i].flipflop = qfalse;
				continue;
			}
			break;
		}
		animations[i].firstFrame = atoi( token );
		// leg only frames are adjusted to not count the upper body only frames
		if ( i == LEGS_WALKCR ) {
			skip = animations[LEGS_WALKCR].firstFrame - animations[TORSO_GESTURE].firstFrame;
		}
		if ( i >= LEGS_WALKCR && i<TORSO_GETFLAG) {
			animations[i].firstFrame -= skip;
		}

		token = COM_Parse( &text_p );
		if ( !*token ) {
			break;
		}
		animations[i].numFrames = atoi( token );

		animations[i].reversed = qfalse;
		animations[i].flipflop = qfalse;
		// if numFrames is negative the animation is reversed
		if (animations[i].numFrames < 0) {
			animations[i].numFrames = -animations[i].numFrames;
			animations[i].reversed = qtrue;
		}

		token = COM_Parse( &text_p );
		if ( !*token ) {
			break;
		}
		animations[i].loopFrames = atoi( token );

		token = COM_Parse( &text_p );
		if ( !*token ) {
			break;
		}
		fps = atof( token );
		if ( fps == 0 ) {
			fps = 1;
		}
		animations[i].frameLerp = 1000 / fps;
		animations[i].initialLerp = 1000 / fps;
	}

	if ( i != MAX_ANIMATIONS ) {
		CG_Printf( "Error parsing animation file: %s", filename );
		return qfalse;
	}

	// crouch backward animation
	memcpy(&animations[LEGS_BACKCR], &animations[LEGS_WALKCR], sizeof(animation_t));
	animations[LEGS_BACKCR].reversed = qtrue;
	// walk backward animation
	memcpy(&animations[LEGS_BACKWALK], &animations[LEGS_WALK], sizeof(animation_t));
	animations[LEGS_BACKWALK].reversed = qtrue;
	// flag moving fast
	animations[FLAG_RUN].firstFrame = 0;
	animations[FLAG_RUN].numFrames = 16;
	animations[FLAG_RUN].loopFrames = 16;
	animations[FLAG_RUN].frameLerp = 1000 / 15;
	animations[FLAG_RUN].initialLerp = 1000 / 15;
	animations[FLAG_RUN].reversed = qfalse;
	// flag not moving or moving slowly
	animations[FLAG_STAND].firstFrame = 16;
	animations[FLAG_STAND].numFrames = 5;
	animations[FLAG_STAND].loopFrames = 0;
	animations[FLAG_STAND].frameLerp = 1000 / 20;
	animations[FLAG_STAND].initialLerp = 1000 / 20;
	animations[FLAG_STAND].reversed = qfalse;
	// flag speeding up
	animations[FLAG_STAND2RUN].firstFrame = 16;
	animations[FLAG_STAND2RUN].numFrames = 5;
	animations[FLAG_STAND2RUN].loopFrames = 1;
	animations[FLAG_STAND2RUN].frameLerp = 1000 / 15;
	animations[FLAG_STAND2RUN].initialLerp = 1000 / 15;
	animations[FLAG_STAND2RUN].reversed = qtrue;
	//
	// new anims changes
	//
//	animations[TORSO_GETFLAG].flipflop = qtrue;
//	animations[TORSO_GUARDBASE].flipflop = qtrue;
//	animations[TORSO_PATROL].flipflop = qtrue;
//	animations[TORSO_AFFIRMATIVE].flipflop = qtrue;
//	animations[TORSO_NEGATIVE].flipflop = qtrue;
	//
	return qtrue;
}

/*
==========================
CG_FileExists
==========================
*/
static qboolean	CG_FileExists(const char *filename) {
	int len;

#if 0	// JUHOX: make it compatible to version 1.27g
	len = trap_FS_FOpenFile( filename, 0, FS_READ );
#else
	{
		fileHandle_t f;

		len = trap_FS_FOpenFile(filename, &f, FS_READ);
		if (f) trap_FS_FCloseFile(f);
	}
#endif
	if (len>0) {
		return qtrue;
	}
	return qfalse;
}

/*
==========================
CG_FindClientModelFile
==========================
*/
static qboolean	CG_FindClientModelFile( char *filename, int length, clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *base, const char *ext ) {
	char *team, *charactersFolder;
	int i;

#if !MONSTER_MODE	// JUHOX: use default skin in STU
	if ( cgs.gametype >= GT_TEAM ) {
#else
	if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
#endif
		switch ( ci->team ) {
			case TEAM_BLUE: {
				team = "blue";
				break;
			}
			default: {
				team = "red";
				break;
			}
		}
	}
	else {
		team = "default";
	}
	charactersFolder = "";
	while(1) {
		for ( i = 0; i < 2; i++ ) {
			if ( i == 0 && teamName && *teamName ) {
				//								"models/players/characters/james/stroggs/lower_lily_red.skin"
				Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, team, ext );
			}
			else {
				//								"models/players/characters/james/lower_lily_red.skin"
				Com_sprintf( filename, length, "models/players/%s%s/%s_%s_%s.%s", charactersFolder, modelName, base, skinName, team, ext );
			}
			if ( CG_FileExists( filename ) ) {
				return qtrue;
			}
#if !MONSTER_MODE	// JUHOX: use default skin in STU
			if ( cgs.gametype >= GT_TEAM ) {
#else
			if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
#endif
				if ( i == 0 && teamName && *teamName ) {
					//								"models/players/characters/james/stroggs/lower_red.skin"
					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, team, ext );
				}
				else {
					//								"models/players/characters/james/lower_red.skin"
					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, team, ext );
				}
			}
			else {
				if ( i == 0 && teamName && *teamName ) {
					//								"models/players/characters/james/stroggs/lower_lily.skin"
					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", charactersFolder, modelName, teamName, base, skinName, ext );
				}
				else {
					//								"models/players/characters/james/lower_lily.skin"
					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", charactersFolder, modelName, base, skinName, ext );
				}
			}
			if ( CG_FileExists( filename ) ) {
				return qtrue;
			}
			if ( !teamName || !*teamName ) {
				break;
			}
		}
		// if tried the heads folder first
		if ( charactersFolder[0] ) {
			break;
		}
		charactersFolder = "characters/";
	}

	return qfalse;
}

/*
==========================
CG_FindClientHeadFile
==========================
*/
static qboolean	CG_FindClientHeadFile( char *filename, int length, clientInfo_t *ci, const char *teamName, const char *headModelName, const char *headSkinName, const char *base, const char *ext ) {
	char *team, *headsFolder;
	int i;

#if !MONSTER_MODE	// JUHOX: use default skin in STU
	if ( cgs.gametype >= GT_TEAM ) {
#else
	if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
#endif
		switch ( ci->team ) {
			case TEAM_BLUE: {
				team = "blue";
				break;
			}
			default: {
				team = "red";
				break;
			}
		}
	}
	else {
		team = "default";
	}

	if ( headModelName[0] == '*' ) {
		headsFolder = "heads/";
		headModelName++;
	}
	else {
		headsFolder = "";
	}
	while(1) {
		for ( i = 0; i < 2; i++ ) {
			if ( i == 0 && teamName && *teamName ) {
				Com_sprintf( filename, length, "models/players/%s%s/%s/%s%s_%s.%s", headsFolder, headModelName, headSkinName, teamName, base, team, ext );
			}
			else {
				Com_sprintf( filename, length, "models/players/%s%s/%s/%s_%s.%s", headsFolder, headModelName, headSkinName, base, team, ext );
			}
			if ( CG_FileExists( filename ) ) {
				return qtrue;
			}
#if !MONSTER_MODE	// JUHOX: use default skin in STU
			if ( cgs.gametype >= GT_TEAM ) {
#else
			if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
#endif
				if ( i == 0 &&  teamName && *teamName ) {
					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, team, ext );
				}
				else {
					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, team, ext );
				}
			}
			else {
				if ( i == 0 && teamName && *teamName ) {
					Com_sprintf( filename, length, "models/players/%s%s/%s%s_%s.%s", headsFolder, headModelName, teamName, base, headSkinName, ext );
				}
				else {
					Com_sprintf( filename, length, "models/players/%s%s/%s_%s.%s", headsFolder, headModelName, base, headSkinName, ext );
				}
			}
			if ( CG_FileExists( filename ) ) {
				return qtrue;
			}
			if ( !teamName || !*teamName ) {
				break;
			}
		}
		// if tried the heads folder first
		if ( headsFolder[0] ) {
			break;
		}
		headsFolder = "heads/";
	}

	return qfalse;
}

/*
==========================
CG_RegisterClientSkin
==========================
*/
static qboolean	CG_RegisterClientSkin( clientInfo_t *ci, const char *teamName, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName ) {
	char filename[MAX_QPATH];

	/*
	Com_sprintf( filename, sizeof( filename ), "models/players/%s/%slower_%s.skin", modelName, teamName, skinName );
	ci->legsSkin = trap_R_RegisterSkin( filename );
	if (!ci->legsSkin) {
		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/%slower_%s.skin", modelName, teamName, skinName );
		ci->legsSkin = trap_R_RegisterSkin( filename );
		if (!ci->legsSkin) {
			Com_Printf( "Leg skin load failure: %s\n", filename );
		}
	}


	Com_sprintf( filename, sizeof( filename ), "models/players/%s/%supper_%s.skin", modelName, teamName, skinName );
	ci->torsoSkin = trap_R_RegisterSkin( filename );
	if (!ci->torsoSkin) {
		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/%supper_%s.skin", modelName, teamName, skinName );
		ci->torsoSkin = trap_R_RegisterSkin( filename );
		if (!ci->torsoSkin) {
			Com_Printf( "Torso skin load failure: %s\n", filename );
		}
	}
	*/
	if ( CG_FindClientModelFile( filename, sizeof(filename), ci, teamName, modelName, skinName, "lower", "skin" ) ) {
		ci->legsSkin = trap_R_RegisterSkin( filename );
	}
	if (!ci->legsSkin) {
		Com_Printf( "Leg skin load failure: %s\n", filename );
	}

	if ( CG_FindClientModelFile( filename, sizeof(filename), ci, teamName, modelName, skinName, "upper", "skin" ) ) {
		ci->torsoSkin = trap_R_RegisterSkin( filename );
	}
	if (!ci->torsoSkin) {
		Com_Printf( "Torso skin load failure: %s\n", filename );
	}

	if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headModelName, headSkinName, "head", "skin" ) ) {
		ci->headSkin = trap_R_RegisterSkin( filename );
	}
	if (!ci->headSkin) {
		Com_Printf( "Head skin load failure: %s\n", filename );
	}

	// if any skins failed to load
	if ( !ci->legsSkin || !ci->torsoSkin || !ci->headSkin ) {
		return qfalse;
	}
	return qtrue;
}

/*
==========================
CG_RegisterClientModelname
==========================
*/
static qboolean CG_RegisterClientModelname( clientInfo_t *ci, const char *modelName, const char *skinName, const char *headModelName, const char *headSkinName, const char *teamName ) {
	char	filename[MAX_QPATH*2];
	const char		*headName;
	char newTeamName[MAX_QPATH*2];

	if ( headModelName[0] == '\0' ) {
		headName = modelName;
	}
	else {
		headName = headModelName;
	}
	Com_sprintf( filename, sizeof( filename ), "models/players/%s/lower.md3", modelName );
	ci->legsModel = trap_R_RegisterModel( filename );
	if ( !ci->legsModel ) {
		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/lower.md3", modelName );
		ci->legsModel = trap_R_RegisterModel( filename );
		if ( !ci->legsModel ) {
			Com_Printf( "Failed to load model file %s\n", filename );
			return qfalse;
		}
	}

	Com_sprintf( filename, sizeof( filename ), "models/players/%s/upper.md3", modelName );
	ci->torsoModel = trap_R_RegisterModel( filename );
	if ( !ci->torsoModel ) {
		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/upper.md3", modelName );
		ci->torsoModel = trap_R_RegisterModel( filename );
		if ( !ci->torsoModel ) {
			Com_Printf( "Failed to load model file %s\n", filename );
			return qfalse;
		}
	}

	if( headName[0] == '*' ) {
		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", &headModelName[1], &headModelName[1] );
	}
	else {
		Com_sprintf( filename, sizeof( filename ), "models/players/%s/head.md3", headName );
	}
	ci->headModel = trap_R_RegisterModel( filename );
	// if the head model could not be found and we didn't load from the heads folder try to load from there
	if ( !ci->headModel && headName[0] != '*' ) {
		Com_sprintf( filename, sizeof( filename ), "models/players/heads/%s/%s.md3", headModelName, headModelName );
		ci->headModel = trap_R_RegisterModel( filename );
	}
	if ( !ci->headModel ) {
		Com_Printf( "Failed to load model file %s\n", filename );
		return qfalse;
	}

	// if any skins failed to load, return failure
	if ( !CG_RegisterClientSkin( ci, teamName, modelName, skinName, headName, headSkinName ) ) {
		if ( teamName && *teamName) {
			Com_Printf( "Failed to load skin file: %s : %s : %s, %s : %s\n", teamName, modelName, skinName, headName, headSkinName );
			if( ci->team == TEAM_BLUE ) {
				Com_sprintf(newTeamName, sizeof(newTeamName), "%s/", DEFAULT_BLUETEAM_NAME);
			}
			else {
				Com_sprintf(newTeamName, sizeof(newTeamName), "%s/", DEFAULT_REDTEAM_NAME);
			}
			if ( !CG_RegisterClientSkin( ci, newTeamName, modelName, skinName, headName, headSkinName ) ) {
				Com_Printf( "Failed to load skin file: %s : %s : %s, %s : %s\n", newTeamName, modelName, skinName, headName, headSkinName );
				return qfalse;
			}
		} else {
			Com_Printf( "Failed to load skin file: %s : %s, %s : %s\n", modelName, skinName, headName, headSkinName );
			return qfalse;
		}
	}

	// load the animations
	Com_sprintf( filename, sizeof( filename ), "models/players/%s/animation.cfg", modelName );
	if ( !CG_ParseAnimationFile( filename, ci ) ) {
		Com_sprintf( filename, sizeof( filename ), "models/players/characters/%s/animation.cfg", modelName );
		if ( !CG_ParseAnimationFile( filename, ci ) ) {
			Com_Printf( "Failed to load animation file %s\n", filename );
			return qfalse;
		}
	}

	if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headName, headSkinName, "icon", "skin" ) ) {
		ci->modelIcon = trap_R_RegisterShaderNoMip( filename );
	}
	else if ( CG_FindClientHeadFile( filename, sizeof(filename), ci, teamName, headName, headSkinName, "icon", "tga" ) ) {
		ci->modelIcon = trap_R_RegisterShaderNoMip( filename );
	}

	if ( !ci->modelIcon ) {
		return qfalse;
	}
#if 1	// JUHOX: fix some badly choosen gender characteristics (needed for correct panting)
	if (!Q_stricmp(headName, "bones")) {
		ci->gender = GENDER_NEUTER;
	}
	else if (!Q_stricmp(headName, "sorlag")) {
		ci->gender = GENDER_NEUTER;
	}
#endif

	return qtrue;
}


/*
====================
CG_ColorFromString
====================
*/
static void CG_ColorFromString( const char *v, vec3_t color ) {
	int val;

	VectorClear( color );

	val = atoi( v );

	if ( val < 1 || val > 7 ) {
		VectorSet( color, 1, 1, 1 );
		return;
	}

	if ( val & 1 ) {
		color[2] = 1.0f;
	}
	if ( val & 2 ) {
		color[1] = 1.0f;
	}
	if ( val & 4 ) {
		color[0] = 1.0f;
	}
}

/*
===================
CG_LoadClientInfo

Load it now, taking the disk hits.
This will usually be deferred to a safe time
===================
*/
#if 0	// JUHOX: additional parameter for CG_LoadClientInfo()
static void CG_LoadClientInfo( clientInfo_t *ci ) {
#else
static void CG_LoadClientInfo(clientInfo_t *ci, const char* defaultModel) {
#endif
	const char	*dir, *fallback;
	int			i, modelloaded;
	const char	*s;
	int			clientNum;
	char		teamname[MAX_QPATH];

	teamname[0] = 0;
#ifdef MISSIONPACK
	if( cgs.gametype >= GT_TEAM) {
		if( ci->team == TEAM_BLUE ) {
			Q_strncpyz(teamname, cg_blueTeamName.string, sizeof(teamname) );
		} else {
			Q_strncpyz(teamname, cg_redTeamName.string, sizeof(teamname) );
		}
	}
	if( teamname[0] ) {
		strcat( teamname, "/" );
	}
#endif
	modelloaded = qtrue;
	if ( !CG_RegisterClientModelname( ci, ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname ) ) {
		
		if ( cg_buildScript.integer ) {
			CG_Error( "CG_RegisterClientModelname( %s, %s, %s, %s %s ) failed", ci->modelName, ci->skinName, ci->headModelName, ci->headSkinName, teamname );
		}

		// fall back
#if MONSTER_MODE	// JUHOX: use default skin as fall back
		if (defaultModel) {
			if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
				if (!CG_RegisterClientModelname(ci, defaultModel, ci->skinName, defaultModel, ci->skinName, teamname)) {
					CG_Error("default model / skin (%s/%s) failed to register", defaultModel, ci->skinName);
				}
			}
			else {
				if (!CG_RegisterClientModelname(ci, defaultModel, "default", defaultModel, "default", teamname)) {
					CG_Error("default model / skin (%s/%s) failed to register", defaultModel, ci->skinName);
				}
			}
		}
		else
#endif
#if !MONSTER_MODE	// JUHOX: use default skin in STU
		if( cgs.gametype >= GT_TEAM) {
#else
		if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
#endif
			// keep skin name
			if ( !CG_RegisterClientModelname( ci, DEFAULT_TEAM_MODEL, ci->skinName, DEFAULT_TEAM_HEAD, ci->skinName, teamname ) ) {
				CG_Error( "DEFAULT_TEAM_MODEL / skin (%s/%s) failed to register", DEFAULT_TEAM_MODEL, ci->skinName );
			}
		} else {
			if ( !CG_RegisterClientModelname( ci, DEFAULT_MODEL, "default", DEFAULT_MODEL, "default", teamname ) ) {
				CG_Error( "DEFAULT_MODEL (%s) failed to register", DEFAULT_MODEL );
			}
		}
		modelloaded = qfalse;
	}

	ci->newAnims = qfalse;
	if ( ci->torsoModel ) {
		orientation_t tag;
		// if the torso model has the "tag_flag"
		if ( trap_R_LerpTag( &tag, ci->torsoModel, 0, 0, 1, "tag_flag" ) ) {
			ci->newAnims = qtrue;
		}
	}

	// sounds
	dir = ci->modelName;
#if !MONSTER_MODE	// JUHOX: use DEFAULT_MODEL sounds as fall back in STU
	fallback = (cgs.gametype >= GT_TEAM) ? DEFAULT_TEAM_MODEL : DEFAULT_MODEL;
#else
	fallback = defaultModel;
	if (!fallback) {
		fallback = (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) ? DEFAULT_TEAM_MODEL : DEFAULT_MODEL;
	}
#endif

	for ( i = 0 ; i < MAX_CUSTOM_SOUNDS ; i++ ) {
		s = cg_customSoundNames[i];
		if ( !s ) {
			break;
		}
		ci->sounds[i] = 0;
		// if the model didn't load use the sounds of the default model
		if (modelloaded) {
			ci->sounds[i] = trap_S_RegisterSound( va("sound/player/%s/%s", dir, s + 1), qfalse );
		}
		if ( !ci->sounds[i] ) {
			ci->sounds[i] = trap_S_RegisterSound( va("sound/player/%s/%s", fallback, s + 1), qfalse );
		}
	}

	ci->deferred = qfalse;

	// reset any existing players and bodies, because they might be in bad
	// frames for this new model
	clientNum = ci - cgs.clientinfo;
	for ( i = 0 ; i < MAX_GENTITIES ; i++ ) {
		if ( cg_entities[i].currentState.clientNum == clientNum
			&& cg_entities[i].currentState.eType == ET_PLAYER ) {
			CG_ResetPlayerEntity( &cg_entities[i] );
		}
	}
}

/*
======================
CG_CopyClientInfoModel
======================
*/
static void CG_CopyClientInfoModel( clientInfo_t *from, clientInfo_t *to ) {
	VectorCopy( from->headOffset, to->headOffset );
	to->footsteps = from->footsteps;
	to->gender = from->gender;

	to->legsModel = from->legsModel;
	to->legsSkin = from->legsSkin;
	to->torsoModel = from->torsoModel;
	to->torsoSkin = from->torsoSkin;
	to->headModel = from->headModel;
	to->headSkin = from->headSkin;
	to->modelIcon = from->modelIcon;

	to->newAnims = from->newAnims;

	memcpy( to->animations, from->animations, sizeof( to->animations ) );
	memcpy( to->sounds, from->sounds, sizeof( to->sounds ) );
}

/*
======================
CG_ScanForExistingClientInfo
======================
*/
static qboolean CG_ScanForExistingClientInfo( clientInfo_t *ci ) {
	int		i;
	clientInfo_t	*match;

	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
		match = &cgs.clientinfo[ i ];
		if ( !match->infoValid ) {
			continue;
		}
		if ( match->deferred ) {
			continue;
		}
		if ( !Q_stricmp( ci->modelName, match->modelName )
			&& !Q_stricmp( ci->skinName, match->skinName )
			&& !Q_stricmp( ci->headModelName, match->headModelName )
			&& !Q_stricmp( ci->headSkinName, match->headSkinName ) 
			&& !Q_stricmp( ci->blueTeam, match->blueTeam ) 
			&& !Q_stricmp( ci->redTeam, match->redTeam )
			// JUHOX: in STU all teams use their normal skins
#if !MONSTER_MODE
			&& (cgs.gametype < GT_TEAM || ci->team == match->team) ) {
#else
			&& (cgs.gametype < GT_TEAM || cgs.gametype >= GT_STU || ci->team == match->team)) {
#endif
			// this clientinfo is identical, so use it's handles

			ci->deferred = qfalse;

			CG_CopyClientInfoModel( match, ci );

			return qtrue;
		}
	}

	// nothing matches, so defer the load
	return qfalse;
}

/*
======================
CG_SetDeferredClientInfo

We aren't going to load it now, so grab some other
client's info to use until we have some spare time.
======================
*/
static void CG_SetDeferredClientInfo( clientInfo_t *ci ) {
	int		i;
	clientInfo_t	*match;

	// JUHOX: don't care about client models in lens flare editor
#if MAPLENSFLARES
	if (cgs.editMode == EM_mlf) return;
#endif

	// if someone else is already the same models and skins we
	// can just load the client info
	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
		match = &cgs.clientinfo[ i ];
		if ( !match->infoValid || match->deferred ) {
			continue;
		}
		if ( Q_stricmp( ci->skinName, match->skinName ) ||
			 Q_stricmp( ci->modelName, match->modelName ) ||
			 // JUHOX: 1.29h
#if 0
			 Q_stricmp( ci->headModelName, match->headModelName ) ||
			 Q_stricmp( ci->headSkinName, match->headSkinName ) ) {
#else
			 // JUHOX: in STU all teams use their normal skins
#if !MONSTER_MODE
			 (cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
#else
			 (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU && ci->team != match->team) ) {
#endif
#endif
			continue;
		}
		// just load the real info cause it uses the same models and skins

		// JUHOX: additional parameter for CG_LoacClientInfo()
#if 0
		CG_LoadClientInfo( ci );
#else
		CG_LoadClientInfo(ci, NULL);
#endif
		return;
	}

	// if we are in teamplay, only grab a model if the skin is correct
	// JUHOX: don't need to check skin in STU
#if !MONSTER_MODE
	if ( cgs.gametype >= GT_TEAM ) {
#else
	if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
#endif
		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
			match = &cgs.clientinfo[ i ];
			if ( !match->infoValid || match->deferred ) {
				continue;
			}
			if ( Q_stricmp( ci->skinName, match->skinName ) ||
				(cgs.gametype >= GT_TEAM && ci->team != match->team) ) {
				continue;
			}
			ci->deferred = qtrue;
			CG_CopyClientInfoModel( match, ci );
			return;
		}
		// load the full model, because we don't ever want to show
		// an improper team skin.  This will cause a hitch for the first
		// player, when the second enters.  Combat shouldn't be going on
		// yet, so it shouldn't matter
		// JUHOX: additional parameter for CG_LoacClientInfo()
#if 0
		CG_LoadClientInfo( ci );
#else
		CG_LoadClientInfo(ci, NULL);
#endif
		return;
	}

	// find the first valid clientinfo and grab its stuff
	for ( i = 0 ; i < cgs.maxclients ; i++ ) {
		match = &cgs.clientinfo[ i ];
		if ( !match->infoValid ) {
			continue;
		}

		ci->deferred = qtrue;
		CG_CopyClientInfoModel( match, ci );
		return;
	}

	// we should never get here...
	CG_Printf( "CG_SetDeferredClientInfo: no valid clients!\n" );

	// JUHOX: additional parameter for CG_LoacClientInfo()
#if 0
	CG_LoadClientInfo( ci );
#else
	CG_LoadClientInfo(ci, NULL);
#endif
}


/*
======================
CG_NewClientInfo
======================
*/
void CG_NewClientInfo( int clientNum ) {
	clientInfo_t *ci;
	clientInfo_t newInfo;
	const char	*configstring;
	const char	*v;
	char		*slash;

	ci = &cgs.clientinfo[clientNum];

	configstring = CG_ConfigString( clientNum + CS_PLAYERS );
	if ( !configstring[0] ) {
		memset( ci, 0, sizeof( *ci ) );
		return;		// player just left
	}

	// build into a temp buffer so the defer checks can use
	// the old value
	memset( &newInfo, 0, sizeof( newInfo ) );

	newInfo.group = -1;			// JUHOX
	newInfo.memberStatus = -1;	// JUHOX

	// isolate the player's name
	v = Info_ValueForKey(configstring, "n");
	Q_strncpyz( newInfo.name, v, sizeof( newInfo.name ) );

	// colors
	v = Info_ValueForKey( configstring, "c1" );
	CG_ColorFromString( v, newInfo.color1 );

	v = Info_ValueForKey( configstring, "c2" );
	CG_ColorFromString( v, newInfo.color2 );

	// bot skill
	v = Info_ValueForKey( configstring, "skill" );
	newInfo.botSkill = atoi( v );

	// handicap
	v = Info_ValueForKey( configstring, "hc" );
	newInfo.handicap = atoi( v );

	// wins
	v = Info_ValueForKey( configstring, "w" );
	newInfo.wins = atoi( v );

	// losses
	v = Info_ValueForKey( configstring, "l" );
	newInfo.losses = atoi( v );

	// JUHOX: client info: glass cloaking
#if 1
	v = Info_ValueForKey(configstring, "gc");
	newInfo.usesGlassCloaking = atoi(v);
#endif

	// team
	v = Info_ValueForKey( configstring, "t" );
	newInfo.team = atoi( v );

	// team task
	v = Info_ValueForKey( configstring, "tt" );
	newInfo.teamTask = atoi(v);

	// team leader
	v = Info_ValueForKey( configstring, "tl" );
	newInfo.teamLeader = atoi(v);

	v = Info_ValueForKey( configstring, "g_redteam" );
	Q_strncpyz(newInfo.redTeam, v, MAX_TEAMNAME);

	v = Info_ValueForKey( configstring, "g_blueteam" );
	Q_strncpyz(newInfo.blueTeam, v, MAX_TEAMNAME);

	// model
	v = Info_ValueForKey( configstring, "model" );
	if ( cg_forceModel.integer ) {
		// forcemodel makes everyone use a single model
		// to prevent load hitches
		char modelStr[MAX_QPATH];
		char *skin;

		// JUHOX: use default skin in STU
#if !MONSTER_MODE
		if( cgs.gametype >= GT_TEAM ) {
#else
		if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
#endif
			Q_strncpyz( newInfo.modelName, DEFAULT_TEAM_MODEL, sizeof( newInfo.modelName ) );
			Q_strncpyz( newInfo.skinName, "default", sizeof( newInfo.skinName ) );
		} else {
			trap_Cvar_VariableStringBuffer( "model", modelStr, sizeof( modelStr ) );
			if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
				skin = "default";
			} else {
				*skin++ = 0;
			}

			Q_strncpyz( newInfo.skinName, skin, sizeof( newInfo.skinName ) );
			Q_strncpyz( newInfo.modelName, modelStr, sizeof( newInfo.modelName ) );
		}

		// JUHOX: use default skin in STU
#if !MONSTER_MODE
		if ( cgs.gametype >= GT_TEAM ) {
#else
		if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
#endif
			// keep skin name
			slash = strchr( v, '/' );
			if ( slash ) {
				Q_strncpyz( newInfo.skinName, slash + 1, sizeof( newInfo.skinName ) );
			}
		}
	} else {
		Q_strncpyz( newInfo.modelName, v, sizeof( newInfo.modelName ) );

		slash = strchr( newInfo.modelName, '/' );
		if ( !slash ) {
			// modelName didn not include a skin name
			Q_strncpyz( newInfo.skinName, "default", sizeof( newInfo.skinName ) );
		} else {
			Q_strncpyz( newInfo.skinName, slash + 1, sizeof( newInfo.skinName ) );
			// truncate modelName
			*slash = 0;
		}
	}

	// head model
	v = Info_ValueForKey( configstring, "hmodel" );
	if ( cg_forceModel.integer ) {
		// forcemodel makes everyone use a single model
		// to prevent load hitches
		char modelStr[MAX_QPATH];
		char *skin;

		// JUHOX: use default skin in STU
#if !MONSTER_MODE
		if( cgs.gametype >= GT_TEAM ) {
#else
		if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
#endif
			Q_strncpyz( newInfo.headModelName, DEFAULT_TEAM_MODEL, sizeof( newInfo.headModelName ) );
			Q_strncpyz( newInfo.headSkinName, "default", sizeof( newInfo.headSkinName ) );
		} else {
			trap_Cvar_VariableStringBuffer( "headmodel", modelStr, sizeof( modelStr ) );
			if ( ( skin = strchr( modelStr, '/' ) ) == NULL) {
				skin = "default";
			} else {
				*skin++ = 0;
			}

			Q_strncpyz( newInfo.headSkinName, skin, sizeof( newInfo.headSkinName ) );
			Q_strncpyz( newInfo.headModelName, modelStr, sizeof( newInfo.headModelName ) );
		}

		// JUHOX: use default skin in STU
#if !MONSTER_MODE
		if ( cgs.gametype >= GT_TEAM ) {
#else
		if (cgs.gametype >= GT_TEAM && cgs.gametype < GT_STU) {
#endif
			// keep skin name
			slash = strchr( v, '/' );
			if ( slash ) {
				Q_strncpyz( newInfo.headSkinName, slash + 1, sizeof( newInfo.headSkinName ) );
			}
		}
	} else {
		Q_strncpyz( newInfo.headModelName, v, sizeof( newInfo.headModelName ) );

		slash = strchr( newInfo.headModelName, '/' );
		if ( !slash ) {
			// modelName didn not include a skin name
			Q_strncpyz( newInfo.headSkinName, "default", sizeof( newInfo.headSkinName ) );
		} else {
			Q_strncpyz( newInfo.headSkinName, slash + 1, sizeof( newInfo.headSkinName ) );
			// truncate modelName
			*slash = 0;
		}
	}

	// scan for an existing clientinfo that matches this modelname
	// so we can avoid loading checks if possible
	if ( !CG_ScanForExistingClientInfo( &newInfo ) ) {
		qboolean	forceDefer;

		forceDefer = trap_MemoryRemaining() < 4000000;

		// if we are defering loads, just have it pick the first valid
		if ( forceDefer || ( cg_deferPlayers.integer && !cg_buildScript.integer && !cg.loading ) ) {
			// keep whatever they had if it won't violate team skins
			CG_SetDeferredClientInfo( &newInfo );
			// if we are low on memory, leave them with this model
			if ( forceDefer ) {
				CG_Printf( "Memory is low.  Using deferred model.\n" );
				newInfo.deferred = qfalse;
			}
		} else {
			// JUHOX: additional parameter for CG_LoadClientInfo()
#if 0
			CG_LoadClientInfo( &newInfo );
#else
			CG_LoadClientInfo(&newInfo, NULL);
#endif
		}
	}

	// replace whatever was there with the new one
	newInfo.infoValid = qtrue;
	*ci = newInfo;
}

/*
======================
JUHOX: CG_InitMonsterClientInfo

derived from 'CG_NewClientInfo()' (see above)
======================
*/
#if MONSTER_MODE
void CG_InitMonsterClientInfo(int clientNum) {
	clientInfo_t* ci;
	clientInfo_t newInfo;
	const char* configstring;
	const char* modelCvar;
	const char* defaultModel;

	configstring = CG_ConfigString(CS_SERVERINFO);

	ci = &cgs.clientinfo[clientNum];

	// build into a temp buffer so the defer checks can use
	// the old value
	memset(&newInfo, 0, sizeof(newInfo));

	newInfo.group = -1;
	newInfo.memberStatus = -1;

	VectorSet(newInfo.color1, 1, 1, 1);
	VectorSet(newInfo.color2, 1, 1, 1);

	newInfo.botSkill = 3;

	newInfo.handicap = 100;

	switch (clientNum) {
	case CLIENTNUM_MONSTER_PREDATOR:
		Q_strncpyz(newInfo.name, "Predator", sizeof(newInfo.name));
		modelCvar = "monsterModel1";
		defaultModel = "klesk";
		newInfo.team = TEAM_FREE;
		break;
	case CLIENTNUM_MONSTER_GUARD:
		Q_strncpyz(newInfo.name, "Guard", sizeof(newInfo.name));
		modelCvar = "monsterModel2";
		defaultModel = "tankjr";
		newInfo.team = TEAM_FREE;

		cgs.media.guardStartSound = trap_S_RegisterSound("sound/weapons/guard_start.wav", qfalse);
		break;
	case CLIENTNUM_MONSTER_TITAN:
		Q_strncpyz(newInfo.name, "Titan", sizeof(newInfo.name));
		modelCvar = "monsterModel3";
		defaultModel = "uriel";
		newInfo.team = TEAM_FREE;

		cgs.media.titanFootstepSound = trap_S_RegisterSound("sound/big_footstep.wav", qfalse);
		break;
	case CLIENTNUM_MONSTER_PREDATOR_RED:
		Q_strncpyz(newInfo.name, "Predator", sizeof(newInfo.name));
		modelCvar = "monsterModel1";
		defaultModel = "klesk";
		newInfo.team = TEAM_RED;
		break;
	case CLIENTNUM_MONSTER_PREDATOR_BLUE:
		Q_strncpyz(newInfo.name, "Predator", sizeof(newInfo.name));
		modelCvar = "monsterModel1";
		defaultModel = "klesk";
		newInfo.team = TEAM_BLUE;
		break;
	default:
		return;
	}

	if (cg_forceModel.integer) {
		trap_Cvar_VariableStringBuffer(modelCvar, newInfo.modelName, sizeof(newInfo.modelName));
	}
	else {
		Q_strncpyz(newInfo.modelName, Info_ValueForKey(configstring, modelCvar), sizeof(newInfo.modelName));
	}

	//CG_LoadingString(newInfo.modelName);
	CG_LoadingClient(clientNum);

	{
		char* slash;

		slash = strchr( newInfo.modelName, '/' );
		if ( !slash ) {
			// modelName didn not include a skin name
			Q_strncpyz( newInfo.skinName, "default", sizeof( newInfo.skinName ) );
		} else {
			Q_strncpyz( newInfo.skinName, slash + 1, sizeof( newInfo.skinName ) );
			// truncate modelName
			*slash = 0;
		}
	}

	// head model
	Q_strncpyz(newInfo.headModelName, newInfo.modelName, sizeof(newInfo.headModelName));
	Q_strncpyz(newInfo.headSkinName, newInfo.skinName, sizeof(newInfo.headSkinName));
	/*
	v = Info_ValueForKey( configstring, "hmodel" );
	{
		Q_strncpyz( newInfo.headModelName, v, sizeof( newInfo.headModelName ) );

		slash = strchr( newInfo.headModelName, '/' );
		if ( !slash ) {
			// modelName didn not include a skin name
			Q_strncpyz( newInfo.headSkinName, "default", sizeof( newInfo.headSkinName ) );
		} else {
			Q_strncpyz( newInfo.headSkinName, slash + 1, sizeof( newInfo.headSkinName ) );
			// truncate modelName
			*slash = 0;
		}
	}
	*/

	CG_LoadClientInfo(&newInfo, defaultModel);

	// replace whatever was there with the new one
	newInfo.infoValid = qtrue;
	*ci = newInfo;
}
#endif



/*
======================
CG_LoadDeferredPlayers

Called each frame when a player is dead
and the scoreboard is up
so deferred players can be loaded
======================
*/
void CG_LoadDeferredPlayers( void ) {
	int		i;
	clientInfo_t	*ci;

	// scan for a deferred player to load
	for ( i = 0, ci = cgs.clientinfo ; i < cgs.maxclients ; i++, ci++ ) {
		if ( ci->infoValid && ci->deferred ) {
			// if we are low on memory, leave it deferred
			if ( trap_MemoryRemaining() < 4000000 ) {
				CG_Printf( "Memory is low.  Using deferred model.\n" );
				ci->deferred = qfalse;
				continue;
			}
			// JUHOX: additional parameter for CG_LoadClientInfo()
#if 0
			CG_LoadClientInfo( ci );
#else
			CG_LoadClientInfo(ci, NULL);
#endif
//			break;
		}
	}
}

/*
=============================================================================

PLAYER ANIMATION

=============================================================================
*/


/*
===============
CG_SetLerpFrameAnimation

may include ANIM_TOGGLEBIT
===============
*/
static void CG_SetLerpFrameAnimation( clientInfo_t *ci, lerpFrame_t *lf, int newAnimation ) {
	animation_t	*anim;

	lf->animationNumber = newAnimation;
	newAnimation &= ~ANIM_TOGGLEBIT;

	if ( newAnimation < 0 || newAnimation >= MAX_TOTALANIMATIONS ) {
		CG_Error( "Bad animation number: %i", newAnimation );
	}

	anim = &ci->animations[ newAnimation ];

	lf->animation = anim;
	lf->animationTime = lf->frameTime + anim->initialLerp;

	if ( cg_debugAnim.integer ) {
		CG_Printf( "Anim: %i\n", newAnimation );
	}
}

/*
===============
CG_RunLerpFrame

Sets cg.snap, cg.oldFrame, and cg.backlerp
cg.time should be between oldFrameTime and frameTime after exit
===============
*/
static void CG_RunLerpFrame( clientInfo_t *ci, lerpFrame_t *lf, int newAnimation, float speedScale ) {
	int			f, numFrames;
	animation_t	*anim;

	// debugging tool to get no animations
	if ( cg_animSpeed.integer == 0 ) {
		lf->oldFrame = lf->frame = lf->backlerp = 0;
		return;
	}

#if SCREENSHOT_TOOLS	// JUHOX
	if (cg.stopTime) speedScale = 0;
#endif

#if 1	// JUHOX: update local animation clock
	lf->clock += cg.frametime * speedScale;
#endif

	// see if the animation sequence is switching
	if ( newAnimation != lf->animationNumber || !lf->animation ) {
		CG_SetLerpFrameAnimation( ci, lf, newAnimation );
	}

	// if we have passed the current frame, move it to
	// oldFrame and calculate a new frame
	if ( /*cg.time*/lf->clock >= lf->frameTime ) {	// JUHOX
		lf->oldFrame = lf->frame;
		lf->oldFrameTime = lf->frameTime;

		// get the next frame based on the animation
		anim = lf->animation;
		if ( !anim->frameLerp ) {
			return;		// shouldn't happen
		}
		if ( /*cg.time*/lf->clock < lf->animationTime ) {	// JUHOX
			lf->frameTime = lf->animationTime;		// initial lerp
		} else {
			lf->frameTime = lf->oldFrameTime + anim->frameLerp;
		}
#if 0	// JUHOX BUGFIX: improve precision
		f = ( lf->frameTime - lf->animationTime ) / anim->frameLerp;
		f *= speedScale;		// adjust for haste, etc
#else
		f = (lf->frameTime - lf->animationTime) / anim->frameLerp;
#endif

		numFrames = anim->numFrames;
		if (anim->flipflop) {
			numFrames *= 2;
		}
		if ( f >= numFrames ) {
			f -= numFrames;
			if ( anim->loopFrames ) {
				f %= anim->loopFrames;
				f += anim->numFrames - anim->loopFrames;
			} else {
				f = numFrames - 1;
				// the animation is stuck at the end, so it
				// can immediately transition to another sequence
				lf->frameTime = /*cg.time*/lf->clock;	// JUHOX
			}
		}
		if ( anim->reversed ) {
			lf->frame = anim->firstFrame + anim->numFrames - 1 - f;
		}
		else if (anim->flipflop && f>=anim->numFrames) {
			lf->frame = anim->firstFrame + anim->numFrames - 1 - (f%anim->numFrames);
		}
		else {
			lf->frame = anim->firstFrame + f;
		}
		if ( /*cg.time*/lf->clock > lf->frameTime ) {	// JUHOX
			lf->frameTime = /*cg.time*/lf->clock;		// JUHOX
			if ( cg_debugAnim.integer ) {
				CG_Printf( "Clamp lf->frameTime\n");
			}
		}
	}

	if ( lf->frameTime > /*cg.time*/lf->clock + 200 ) {	// JUHOX
		lf->frameTime = /*cg.time*/lf->clock;			// JUHOX
	}

	if ( lf->oldFrameTime > /*cg.time*/lf->clock ) {	// JUHOX
		lf->oldFrameTime = /*cg.time*/lf->clock;		// JUHOX
	}
	// calculate current lerp value
	if ( lf->frameTime == lf->oldFrameTime ) {
		lf->backlerp = 0;
	} else {
		lf->backlerp = 1.0 - (float)( /*cg.time*/lf->clock - lf->oldFrameTime ) / ( lf->frameTime - lf->oldFrameTime );	// JUHOX
	}
}


/*
===============
CG_ClearLerpFrame
===============
*/
static void CG_ClearLerpFrame( clientInfo_t *ci, lerpFrame_t *lf, int animationNumber ) {
	lf->frameTime = lf->oldFrameTime = /*cg.time*/lf->clock;	// JUHOX
	CG_SetLerpFrameAnimation( ci, lf, animationNumber );
	lf->oldFrame = lf->frame = lf->animation->firstFrame;
}


/*
===============
CG_PlayerAnimation
===============
*/
static void CG_PlayerAnimation( centity_t *cent, int *legsOld, int *legs, float *legsBackLerp,
						int *torsoOld, int *torso, float *torsoBackLerp ) {
	clientInfo_t	*ci;
	int				clientNum;
	float			speedScale;

	clientNum = cent->currentState.clientNum;

	if ( cg_noPlayerAnims.integer ) {
		*legsOld = *legs = *torsoOld = *torso = 0;
		return;
	}

	// JUHOX: adapt animation speed to player speed
#if 0
	if ( cent->currentState.powerups & ( 1 << PW_HASTE ) ) {
		speedScale = 1.5;
	} else {
		speedScale = 1;
	}
#else
	{
		qboolean forceFullSpeed;

		forceFullSpeed = qfalse;
		speedScale = VectorLength(cent->currentState.pos.trDelta) / 320.0;
		switch (cent->currentState.legsAnim & ~ANIM_TOGGLEBIT) {
		case LEGS_WALK:
		case LEGS_WALKCR:
		case LEGS_BACKWALK:
		case LEGS_BACKCR:
			speedScale *= 2;
			/*
			switch (clientNum) {
			case CLIENTNUM_MONSTER_GUARD:
				speedScale /= MONSTER_GUARD_SCALE;
				break;
			case CLIENTNUM_MONSTER_TITAN:
				speedScale /= MONSTER_TITAN_SCALE;
				break;
			}
			*/
			break;
		case BOTH_DEATH1:
		case BOTH_DEAD1:
		case BOTH_DEATH2:
		case BOTH_DEAD2:
		case BOTH_DEATH3:
		case BOTH_DEAD3:
		case LEGS_JUMP:
		case LEGS_LAND:
		case LEGS_JUMPB:
		case LEGS_LANDB:
			forceFullSpeed = qtrue;
			speedScale = 1;
			break;
		case LEGS_IDLE:
		case LEGS_IDLECR:
			speedScale = 1;
			break;
		}
#if MONSTER_MODE	// JUHOX: adapt animation speed to monster size
		if (!forceFullSpeed) switch (clientNum) {	// NOTE: death animation must not change speed or sound will be async
		case CLIENTNUM_MONSTER_GUARD:
			speedScale /= MONSTER_GUARD_SCALE;
			break;
		case CLIENTNUM_MONSTER_TITAN:
			speedScale /= MONSTER_TITAN_SCALE;
			break;
		}
#endif
		if (speedScale < 0.2) speedScale = 0.2;
	}
#endif


	ci = &cgs.clientinfo[ clientNum ];

#if MONSTER_MODE	// JUHOX: sleeping titan doesn't get animated
	if (
		clientNum == CLIENTNUM_MONSTER_TITAN &&
		cent->currentState.otherEntityNum2
	) {
		CG_ClearLerpFrame(ci, &cent->pe.legs, cent->currentState.legsAnim);
		CG_ClearLerpFrame(ci, &cent->pe.torso, cent->currentState.torsoAnim);

		*legsOld = cent->pe.legs.oldFrame;
		*legs = cent->pe.legs.frame;
		*legsBackLerp = cent->pe.legs.backlerp;

		*torsoOld = cent->pe.torso.oldFrame;
		*torso = cent->pe.torso.frame;
		*torsoBackLerp = cent->pe.torso.backlerp;
		return;
	}
#endif

	// do the shuffle turn frames locally
	if ( cent->pe.legs.yawing && ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) == LEGS_IDLE ) {
		CG_RunLerpFrame( ci, &cent->pe.legs, LEGS_TURN, speedScale );
	} else {
		CG_RunLerpFrame( ci, &cent->pe.legs, cent->currentState.legsAnim, speedScale );
	}

	*legsOld = cent->pe.legs.oldFrame;
	*legs = cent->pe.legs.frame;
	*legsBackLerp = cent->pe.legs.backlerp;

#if 1	// JUHOX: make sure attack and gesture animation plays full speed independent from movement
	/*
	switch (cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) {
	case TORSO_ATTACK:
	case TORSO_ATTACK2:
	case TORSO_GESTURE:
	case TORSO_DROP:
	case TORSO_RAISE:
		speedScale = 1;
		break;
	}
	*/
	speedScale = 1;
#endif

	CG_RunLerpFrame( ci, &cent->pe.torso, cent->currentState.torsoAnim, speedScale );

	*torsoOld = cent->pe.torso.oldFrame;
	*torso = cent->pe.torso.frame;
	*torsoBackLerp = cent->pe.torso.backlerp;
}

/*
=============================================================================

PLAYER ANGLES

=============================================================================
*/

/*
==================
CG_SwingAngles
==================
*/
static void CG_SwingAngles( float destination, float swingTolerance, float clampTolerance,
					float speed, float *angle, qboolean *swinging ) {
	float	swing;
	float	move;
	float	scale;

	if ( !*swinging ) {
		// see if a swing should be started
		swing = AngleSubtract( *angle, destination );
		if ( swing > swingTolerance || swing < -swingTolerance ) {
			*swinging = qtrue;
		}
	}

	if ( !*swinging ) {
		return;
	}
	
	// modify the speed depending on the delta
	// so it doesn't seem so linear
	swing = AngleSubtract( destination, *angle );
	scale = fabs( swing );
	if ( scale < swingTolerance * 0.5 ) {
		scale = 0.5;
	} else if ( scale < swingTolerance ) {
		scale = 1.0;
	} else {
		scale = 2.0;
	}

	// swing towards the destination angle
	if ( swing >= 0 ) {
		move = cg.frametime * scale * speed;
		if ( move >= swing ) {
			move = swing;
			*swinging = qfalse;
		}
		*angle = AngleMod( *angle + move );
	} else if ( swing < 0 ) {
		move = cg.frametime * scale * -speed;
		if ( move <= swing ) {
			move = swing;
			*swinging = qfalse;
		}
		*angle = AngleMod( *angle + move );
	}

	// clamp to no more than tolerance
	swing = AngleSubtract( destination, *angle );
	if ( swing > clampTolerance ) {
		*angle = AngleMod( destination - (clampTolerance - 1) );
	} else if ( swing < -clampTolerance ) {
		*angle = AngleMod( destination + (clampTolerance - 1) );
	}
}

/*
=================
CG_AddPainTwitch
=================
*/
static void CG_AddPainTwitch( centity_t *cent, vec3_t torsoAngles ) {
	int		t;
	float	f;

	t = cg.time - cent->pe.painTime;
	if ( t >= PAIN_TWITCH_TIME ) {
		return;
	}

	f = 1.0 - (float)t / PAIN_TWITCH_TIME;

	if ( cent->pe.painDirection ) {
		torsoAngles[ROLL] += 20 * f;
	} else {
		torsoAngles[ROLL] -= 20 * f;
	}
}


/*
===============
CG_PlayerAngles

Handles seperate torso motion

  legs pivot based on direction of movement

  head always looks exactly at cent->lerpAngles

  if motion < 20 degrees, show in head only
  if < 45 degrees, also show in torso
===============
*/
static void CG_PlayerAngles( centity_t *cent, vec3_t legs[3], vec3_t torso[3], vec3_t head[3] ) {
	vec3_t		legsAngles, torsoAngles, headAngles;
	float		dest;
	static	int	movementOffsets[8] = { 0, 22, 45, -22, 0, 22, -45, -22 };
	vec3_t		velocity;
	float		speed;
	int			dir, clientNum;
	clientInfo_t	*ci;

	VectorCopy( cent->lerpAngles, headAngles );
	headAngles[YAW] = AngleMod( headAngles[YAW] );
	VectorClear( legsAngles );
	VectorClear( torsoAngles );

	// --------- yaw -------------

	// allow yaw to drift a bit
	if ( ( cent->currentState.legsAnim & ~ANIM_TOGGLEBIT ) != LEGS_IDLE 
#if 0	// JUHOX BUGFIX: TORSO_STAND2 also means standing still
		|| ( cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT ) != TORSO_STAND  ) {
#else
		|| (
			(cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_STAND &&
			(cent->currentState.torsoAnim & ~ANIM_TOGGLEBIT) != TORSO_STAND2
		)
	) {
#endif
		// if not standing still, always point all in the same direction
		cent->pe.torso.yawing = qtrue;	// always center
		cent->pe.torso.pitching = qtrue;	// always center
		cent->pe.legs.yawing = qtrue;	// always center
	}

	// adjust legs for movement dir
	if ( cent->currentState.eFlags & EF_DEAD ) {
		// don't let dead bodies twitch
		dir = 0;
	} else {
		// -JUHOX: get movementDir from entityState_t.angles[YAW]
#if 1
		dir = cent->currentState.angles2[YAW];
#else
		dir = cent->currentState.angles[YAW];
#endif
		if ( dir < 0 || dir > 7 ) {
			CG_Error( "Bad player movement angle" );
		}
	}
	legsAngles[YAW] = headAngles[YAW] + movementOffsets[ dir ];
	torsoAngles[YAW] = headAngles[YAW] + 0.25 * movementOffsets[ dir ];

	// torso
	CG_SwingAngles( torsoAngles[YAW], 25, 90, cg_swingSpeed.value, &cent->pe.torso.yawAngle, &cent->pe.torso.yawing );
	CG_SwingAngles( legsAngles[YAW], 40, 90, cg_swingSpeed.value, &cent->pe.legs.yawAngle, &cent->pe.legs.yawing );

	torsoAngles[YAW] = cent->pe.torso.yawAngle;
	legsAngles[YAW] = cent->pe.legs.yawAngle;

	// --------- pitch -------------

	// only show a fraction of the pitch angle in the torso
	if ( headAngles[PITCH] > 180 ) {
		dest = (-360 + headAngles[PITCH]) * 0.75f;
	} else {
		dest = headAngles[PITCH] * 0.75f;
	}
	CG_SwingAngles( dest, 15, 30, 0.1f, &cent->pe.torso.pitchAngle, &cent->pe.torso.pitching );
	torsoAngles[PITCH] = cent->pe.torso.pitchAngle;

	//
	clientNum = cent->currentState.clientNum;
	// JUHOX: handle monsters too
#if !MONSTER_MODE
	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
#else
	if (clientNum >= 0 && clientNum < MAX_CLIENTS+EXTRA_CLIENTNUMS) {
#endif
		ci = &cgs.clientinfo[ clientNum ];
		if ( ci->fixedtorso ) {
			torsoAngles[PITCH] = 0.0f;
		}
	}

	// --------- roll -------------


	// lean towards the direction of travel
	VectorCopy( cent->currentState.pos.trDelta, velocity );
	speed = VectorNormalize( velocity );
	if ( speed ) {
		vec3_t	axis[3];
		float	side;

		speed *= 0.05f;

		AnglesToAxis( legsAngles, axis );
		side = speed * DotProduct( velocity, axis[1] );
		legsAngles[ROLL] -= side;

		side = speed * DotProduct( velocity, axis[0] );
		legsAngles[PITCH] += side;
	}

	//
	clientNum = cent->currentState.clientNum;
	// JUHOX: handle monsters too
#if !MONSTER_MODE
	if ( clientNum >= 0 && clientNum < MAX_CLIENTS ) {
#else
	if (clientNum >= 0 && clientNum < MAX_CLIENTS+EXTRA_CLIENTNUMS) {
#endif
		ci = &cgs.clientinfo[ clientNum ];
		if ( ci->fixedlegs ) {
			legsAngles[YAW] = torsoAngles[YAW];
			legsAngles[PITCH] = 0.0f;
			legsAngles[ROLL] = 0.0f;
		}
	}

	// pain twitch
	CG_AddPainTwitch( cent, torsoAngles );

	// pull the angles back out of the hierarchial chain
	AnglesSubtract( headAngles, torsoAngles, headAngles );
	AnglesSubtract( torsoAngles, legsAngles, torsoAngles );
	AnglesToAxis( legsAngles, legs );
	AnglesToAxis( torsoAngles, torso );
	AnglesToAxis( headAngles, head );
}


//==========================================================================

/*
===============
CG_HasteTrail
===============
*/
static void CG_HasteTrail( centity_t *cent ) {
	localEntity_t	*smoke;
	vec3_t			origin;
	int				anim;

	if ( cent->trailTime > cg.time ) {
		return;
	}
	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
	if ( anim != LEGS_RUN && anim != LEGS_BACK ) {
		return;
	}

	cent->trailTime += 100;
	if ( cent->trailTime < cg.time ) {
		cent->trailTime = cg.time;
	}

	VectorCopy( cent->lerpOrigin, origin );
	origin[2] -= 16;

	smoke = CG_SmokePuff( origin, vec3_origin, 
				  8, 
				  1, 1, 1, 1,
				  500, 
				  cg.time,
				  0,
				  0,
				  cgs.media.hastePuffShader );

	// use the optimized local entity add
	smoke->leType = LE_SCALE_FADE;
}

#ifdef MISSIONPACK
/*
===============
CG_BreathPuffs
===============
*/
static void CG_BreathPuffs( centity_t *cent, refEntity_t *head) {
	clientInfo_t *ci;
	vec3_t up, origin;
	int contents;

	ci = &cgs.clientinfo[ cent->currentState.number ];

	if (!cg_enableBreath.integer) {
		return;
	}
	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson) {
		return;
	}
	if ( cent->currentState.eFlags & EF_DEAD ) {
		return;
	}
	contents = trap_CM_PointContents( head->origin, 0 );
	if ( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
		return;
	}
	if ( ci->breathPuffTime > cg.time ) {
		return;
	}

	VectorSet( up, 0, 0, 8 );
	VectorMA(head->origin, 8, head->axis[0], origin);
	VectorMA(origin, -4, head->axis[2], origin);
	CG_SmokePuff( origin, up, 16, 1, 1, 1, 0.66f, 1500, cg.time, cg.time + 400, LEF_PUFF_DONT_SCALE, cgs.media.shotgunSmokePuffShader );
	ci->breathPuffTime = cg.time + 2000;
}

/*
===============
CG_DustTrail
===============
*/
static void CG_DustTrail( centity_t *cent ) {
	int				anim;
	localEntity_t	*dust;
	vec3_t end, vel;
	trace_t tr;

	if (!cg_enableDust.integer)
		return;

	if ( cent->dustTrailTime > cg.time ) {
		return;
	}

	anim = cent->pe.legs.animationNumber & ~ANIM_TOGGLEBIT;
	if ( anim != LEGS_LANDB && anim != LEGS_LAND ) {
		return;
	}

	cent->dustTrailTime += 40;
	if ( cent->dustTrailTime < cg.time ) {
		cent->dustTrailTime = cg.time;
	}

	VectorCopy(cent->currentState.pos.trBase, end);
	end[2] -= 64;
	CG_Trace( &tr, cent->currentState.pos.trBase, NULL, NULL, end, cent->currentState.number, MASK_PLAYERSOLID );

	if ( !(tr.surfaceFlags & SURF_DUST) )
		return;

	VectorCopy( cent->currentState.pos.trBase, end );
	end[2] -= 16;

	VectorSet(vel, 0, 0, -30);
	dust = CG_SmokePuff( end, vel,
				  24,
				  .8f, .8f, 0.7f, 0.33f,
				  500,
				  cg.time,
				  0,
				  0,
				  cgs.media.dustPuffShader );
}

#endif

/*
===============
CG_TrailItem
===============
*/
static void CG_TrailItem( centity_t *cent, qhandle_t hModel ) {
	refEntity_t		ent;
	vec3_t			angles;
	vec3_t			axis[3];

	VectorCopy( cent->lerpAngles, angles );
	angles[PITCH] = 0;
	angles[ROLL] = 0;
	AnglesToAxis( angles, axis );

	memset( &ent, 0, sizeof( ent ) );
	VectorMA( cent->lerpOrigin, -16, axis[0], ent.origin );
	ent.origin[2] += 16;
	angles[YAW] += 90;
	AnglesToAxis( angles, ent.axis );

	ent.hModel = hModel;
	trap_R_AddRefEntityToScene( &ent );
}


/*
===============
CG_PlayerFlag
===============
*/
static void CG_PlayerFlag( centity_t *cent, qhandle_t hSkin, refEntity_t *torso ) {
	clientInfo_t	*ci;
	refEntity_t	pole;
	refEntity_t	flag;
	vec3_t		angles, dir;
	int			legsAnim, flagAnim, updateangles;
	float		angle, d;

	// show the flag pole model
	memset( &pole, 0, sizeof(pole) );
	pole.hModel = cgs.media.flagPoleModel;
	VectorCopy( torso->lightingOrigin, pole.lightingOrigin );
	pole.shadowPlane = torso->shadowPlane;
	pole.renderfx = torso->renderfx;
	CG_PositionEntityOnTag( &pole, torso, torso->hModel, "tag_flag" );
	trap_R_AddRefEntityToScene( &pole );

	// show the flag model
	memset( &flag, 0, sizeof(flag) );
	flag.hModel = cgs.media.flagFlapModel;
	flag.customSkin = hSkin;
	VectorCopy( torso->lightingOrigin, flag.lightingOrigin );
	flag.shadowPlane = torso->shadowPlane;
	flag.renderfx = torso->renderfx;

	VectorClear(angles);

	updateangles = qfalse;
	legsAnim = cent->currentState.legsAnim & ~ANIM_TOGGLEBIT;
	if( legsAnim == LEGS_IDLE || legsAnim == LEGS_IDLECR ) {
		flagAnim = FLAG_STAND;
	} else if ( legsAnim == LEGS_WALK || legsAnim == LEGS_WALKCR ) {
		flagAnim = FLAG_STAND;
		updateangles = qtrue;
	} else {
		flagAnim = FLAG_RUN;
		updateangles = qtrue;
	}

	if ( updateangles ) {

		VectorCopy( cent->currentState.pos.trDelta, dir );
		// add gravity
		dir[2] += 100;
		VectorNormalize( dir );
		d = DotProduct(pole.axis[2], dir);
		// if there is anough movement orthogonal to the flag pole
		if (fabs(d) < 0.9) {
			//
			d = DotProduct(pole.axis[0], dir);
			if (d > 1.0f) {
				d = 1.0f;
			}
			else if (d < -1.0f) {
				d = -1.0f;
			}
			angle = acos(d);

			d = DotProduct(pole.axis[1], dir);
			if (d < 0) {
				angles[YAW] = 360 - angle * 180 / M_PI;
			}
			else {
				angles[YAW] = angle * 180 / M_PI;
			}
			if (angles[YAW] < 0)
				angles[YAW] += 360;
			if (angles[YAW] > 360)
				angles[YAW] -= 360;

			//vectoangles( cent->currentState.pos.trDelta, tmpangles );
			//angles[YAW] = tmpangles[YAW] + 45 - cent->pe.torso.yawAngle;
			// change the yaw angle
			CG_SwingAngles( angles[YAW], 25, 90, 0.15f, &cent->pe.flag.yawAngle, &cent->pe.flag.yawing );
		}

		/*
		d = DotProduct(pole.axis[2], dir);
		angle = Q_acos(d);

		d = DotProduct(pole.axis[1], dir);
		if (d < 0) {
			angle = 360 - angle * 180 / M_PI;
		}
		else {
			angle = angle * 180 / M_PI;
		}
		if (angle > 340 && angle < 20) {
			flagAnim = FLAG_RUNUP;
		}
		if (angle > 160 && angle < 200) {
			flagAnim = FLAG_RUNDOWN;
		}
		*/
	}

	// set the yaw angle
	angles[YAW] = cent->pe.flag.yawAngle;
	// lerp the flag animation frames
	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
	CG_RunLerpFrame( ci, &cent->pe.flag, flagAnim, 1 );
	flag.oldframe = cent->pe.flag.oldFrame;
	flag.frame = cent->pe.flag.frame;
	flag.backlerp = cent->pe.flag.backlerp;

	AnglesToAxis( angles, flag.axis );
	CG_PositionRotatedEntityOnTag( &flag, &pole, pole.hModel, "tag_flag" );

	trap_R_AddRefEntityToScene( &flag );
}


#ifdef MISSIONPACK // bk001204
/*
===============
CG_PlayerTokens
===============
*/
static void CG_PlayerTokens( centity_t *cent, int renderfx ) {
	int			tokens, i, j;
	float		angle;
	refEntity_t	ent;
	vec3_t		dir, origin;
	skulltrail_t *trail;
	trail = &cg.skulltrails[cent->currentState.number];
	tokens = cent->currentState.generic1;
	if ( !tokens ) {
		trail->numpositions = 0;
		return;
	}

	if ( tokens > MAX_SKULLTRAIL ) {
		tokens = MAX_SKULLTRAIL;
	}

	// add skulls if there are more than last time
	for (i = 0; i < tokens - trail->numpositions; i++) {
		for (j = trail->numpositions; j > 0; j--) {
			VectorCopy(trail->positions[j-1], trail->positions[j]);
		}
		VectorCopy(cent->lerpOrigin, trail->positions[0]);
	}
	trail->numpositions = tokens;

	// move all the skulls along the trail
	VectorCopy(cent->lerpOrigin, origin);
	for (i = 0; i < trail->numpositions; i++) {
		VectorSubtract(trail->positions[i], origin, dir);
		if (VectorNormalize(dir) > 30) {
			VectorMA(origin, 30, dir, trail->positions[i]);
		}
		VectorCopy(trail->positions[i], origin);
	}

	memset( &ent, 0, sizeof( ent ) );
	if( cgs.clientinfo[ cent->currentState.clientNum ].team == TEAM_BLUE ) {
		ent.hModel = cgs.media.redCubeModel;
	} else {
		ent.hModel = cgs.media.blueCubeModel;
	}
	ent.renderfx = renderfx;

	VectorCopy(cent->lerpOrigin, origin);
	for (i = 0; i < trail->numpositions; i++) {
		VectorSubtract(origin, trail->positions[i], ent.axis[0]);
		ent.axis[0][2] = 0;
		VectorNormalize(ent.axis[0]);
		VectorSet(ent.axis[2], 0, 0, 1);
		CrossProduct(ent.axis[0], ent.axis[2], ent.axis[1]);

		VectorCopy(trail->positions[i], ent.origin);
		angle = (((cg.time + 500 * MAX_SKULLTRAIL - 500 * i) / 16) & 255) * (M_PI * 2) / 255;
		ent.origin[2] += sin(angle) * 10;
		trap_R_AddRefEntityToScene( &ent );
		VectorCopy(trail->positions[i], origin);
	}
}
#endif


/*
===============
CG_PlayerPowerups
===============
*/
static void CG_PlayerPowerups( centity_t *cent, refEntity_t *torso ) {
	int		powerups;
	clientInfo_t	*ci;

	// JUHOX FIXME: no dlights in EFH
#if ESCAPE_MODE
	if (cgs.gametype == GT_EFH) return;
#endif

	powerups = cent->currentState.powerups;
	if ( !powerups ) {
		return;
	}

	// JUHOX: moved to here from below
#if 1
	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
#endif
	// quad gives a dlight
	if ( powerups & ( 1 << PW_QUAD ) ) {
		// JUHOX: consider team color for the quad light color
#if 0
		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1 );
#else
		if (ci->team == TEAM_RED) {
			trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 1, 0.2f, 0.2f );
		}
		else {
			trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1 );
		}
#endif
	}

	// flight plays a looped sound
	if ( powerups & ( 1 << PW_FLIGHT ) ) {
		trap_S_AddLoopingSound( cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.flightSound );
	}

	// JUHOX: we need this earlier
#if 0
	ci = &cgs.clientinfo[ cent->currentState.clientNum ];
#endif
	// redflag
	if ( powerups & ( 1 << PW_REDFLAG ) ) {
		if (ci->newAnims) {
			CG_PlayerFlag( cent, cgs.media.redFlagFlapSkin, torso );
		}
		else {
			CG_TrailItem( cent, cgs.media.redFlagModel );
		}
		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 1.0, 0.2f, 0.2f );
	}

	// blueflag
	if ( powerups & ( 1 << PW_BLUEFLAG ) ) {
		if (ci->newAnims){
			CG_PlayerFlag( cent, cgs.media.blueFlagFlapSkin, torso );
		}
		else {
			CG_TrailItem( cent, cgs.media.blueFlagModel );
		}
		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 0.2f, 0.2f, 1.0 );
	}

	// neutralflag
	if ( powerups & ( 1 << PW_NEUTRALFLAG ) ) {
		if (ci->newAnims) {
			CG_PlayerFlag( cent, cgs.media.neutralFlagFlapSkin, torso );
		}
		else {
			CG_TrailItem( cent, cgs.media.neutralFlagModel );
		}
		trap_R_AddLightToScene( cent->lerpOrigin, 200 + (rand()&31), 1.0, 1.0, 1.0 );
	}
	// -JUHOX: PW_CHARGE lighting
#if 0
	if (powerups & (1 << PW_CHARGE)) {
		float intensity;

		intensity = cent->currentState.time2 - cg.time;
		if (intensity > 0) {
			if (intensity > 10000) intensity = 10000;
			trap_R_AddLightToScene(
				cent->lerpOrigin,
				(intensity / 10000.0) * (200 + (rand()&63)),
				1.0, 1.0, 1.0
			);
		}
	}
#endif

	// haste leaves smoke trails
	if ( powerups & ( 1 << PW_HASTE ) ) {
		CG_HasteTrail( cent );
	}
}


/*
===============
CG_PlayerFloatSprite

Float a sprite over the player's head
===============
*/
static void CG_PlayerFloatSprite( centity_t *cent, qhandle_t shader ) {
	int				rf;
	refEntity_t		ent;

	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson ) {
		rf = RF_THIRD_PERSON;		// only show in mirrors
	} else {
		rf = 0;
	}

	memset( &ent, 0, sizeof( ent ) );
	VectorCopy( cent->lerpOrigin, ent.origin );
	ent.origin[2] += 48;
	ent.reType = RT_SPRITE;
	ent.customShader = shader;
	ent.radius = 10;
	ent.renderfx = rf;
	ent.shaderRGBA[0] = 255;
	ent.shaderRGBA[1] = 255;
	ent.shaderRGBA[2] = 255;
	ent.shaderRGBA[3] = 255;
	trap_R_AddRefEntityToScene( &ent );
}

/*
===============
JUHOX: CG_PlayerGroupSprite
===============
*/
static void CG_PlayerGroupSprite(centity_t *cent, qhandle_t shader, int rgb) {
	int				rf;
	refEntity_t		ent;

	if ( cent->currentState.number == cg.snap->ps.clientNum && !cg.renderingThirdPerson ) {
		rf = RF_THIRD_PERSON;		// only show in mirrors
	} else {
		rf = 0;
	}

	memset(&ent, 0, sizeof(ent));
	VectorCopy(cent->lerpOrigin, ent.origin);
	ent.origin[2] += 48;
	ent.reType = RT_SPRITE;
	ent.customShader = shader;
	ent.radius = 10;
	ent.renderfx = rf;
	ent.shaderRGBA[0] = (rgb >> 16) & 255;
	ent.shaderRGBA[1] = (rgb >>  8) & 255;
	ent.shaderRGBA[2] = (rgb      ) & 255;
	ent.shaderRGBA[3] = 255;
	trap_R_AddRefEntityToScene(&ent);
}

/*
===============
CG_PlayerSprites

Float sprites over the player's head
===============
s*/
static void CG_PlayerSprites( centity_t *cent ) {
	int		team;

	if ( cent->currentState.eFlags & EF_CONNECTION ) {
		CG_PlayerFloatSprite( cent, cgs.media.connectionShader );
		return;
	}

	if ( cent->currentState.eFlags & EF_TALK ) {
		CG_PlayerFloatSprite( cent, cgs.media.balloonShader );
		return;
	}

	if ( cent->currentState.eFlags & EF_AWARD_IMPRESSIVE ) {
		CG_PlayerFloatSprite( cent, cgs.media.medalImpressive );
		return;
	}

	if ( cent->currentState.eFlags & EF_AWARD_EXCELLENT ) {
		CG_PlayerFloatSprite( cent, cgs.media.medalExcellent );
		return;
	}

	if ( cent->currentState.eFlags & EF_AWARD_GAUNTLET ) {
		CG_PlayerFloatSprite( cent, cgs.media.medalGauntlet );
		return;
	}

	if ( cent->currentState.eFlags & EF_AWARD_DEFEND ) {
		CG_PlayerFloatSprite( cent, cgs.media.medalDefend );
		return;
	}

	if ( cent->currentState.eFlags & EF_AWARD_ASSIST ) {
		CG_PlayerFloatSprite( cent, cgs.media.medalAssist );
		return;
	}

	if ( cent->currentState.eFlags & EF_AWARD_CAP ) {
		CG_PlayerFloatSprite( cent, cgs.media.medalCapture );
		return;
	}

#if MONSTER_MODE	// JUHOX: mark monsters created by our client
	if (
		cgs.gametype < GT_STU &&
		!(cent->currentState.eFlags & EF_DEAD) &&
		cent->currentState.clientNum >= MAX_CLIENTS &&
		cent->currentState.otherEntityNum == cg.snap->ps.clientNum
	) {
		CG_PlayerFloatSprite(cent, cgs.media.friendShader);
		return;
	}
#endif

	team = cgs.clientinfo[ cent->currentState.clientNum ].team;
	if ( !(cent->currentState.eFlags & EF_DEAD) && 
		cg.snap->ps.persistant[PERS_TEAM] == team &&
		cgs.gametype >= GT_TEAM) {
		if (cg_drawFriend.integer) {
#if 0	// JUHOX: draw group mark sprites
			CG_PlayerFloatSprite( cent, cgs.media.friendShader );
#else
			if (BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_isValid)) {
				tss_groupMemberStatus_t gms;
				int group;
				qhandle_t backShader;
				int backColor;
				int frontColor;

				gms = BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_groupMemberStatus);
				switch (gms) {
				case TSSGMS_retreating:
					backShader = cgs.media.groupTemporary;
					backColor = TSSGROUPCOLOR_BLACK;
					frontColor = TSSGROUPCOLOR_MINT;
					break;
				case TSSGMS_temporaryFighter:
					backShader = cgs.media.groupTemporary;
					backColor = TSSGROUPCOLOR_WHITE;
					frontColor = TSSGROUPCOLOR_BLACK;
					break;
				case TSSGMS_designatedFighter:
					backShader = cgs.media.groupDesignated;
					backColor = TSSGROUPCOLOR_WHITE;
					frontColor = TSSGROUPCOLOR_BLACK;
					break;
				case TSSGMS_temporaryLeader:
					backShader = cgs.media.groupTemporary;
					backColor = TSSGROUPCOLOR_YELLOW;
					frontColor = TSSGROUPCOLOR_BLACK;
					break;
				case TSSGMS_designatedLeader:
					backShader = cgs.media.groupDesignated;
					backColor = TSSGROUPCOLOR_YELLOW;
					frontColor = TSSGROUPCOLOR_BLACK;
					break;
				default:
					backShader = 0;
					backColor = 0;
					frontColor = 0;
					break;
				}
				
				group = BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_group);
				if (group >= 0 && group < MAX_GROUPS && backShader) {
					CG_PlayerGroupSprite(cent, backShader, backColor);
					CG_PlayerGroupSprite(cent, cgs.media.groupMarks[group], frontColor);
				}
			}
#endif
		}
		return;
	}
}

/*
===============
CG_PlayerShadow

Returns the Z component of the surface being shadowed

  should it return a full plane instead of a Z?
===============
*/
#define	SHADOW_DISTANCE		128
static qboolean CG_PlayerShadow( centity_t *cent, float *shadowPlane ) {
	vec3_t		end, mins = {-15, -15, 0}, maxs = {15, 15, 2};
	trace_t		trace;
	float		alpha;
	// JUHOX: vars needed to adapt player shadow to guard monsters
#if MONSTER_MODE
	float shadowDistance;
	float radius;
#endif

	*shadowPlane = 0;

	if ( cg_shadows.integer == 0 ) {
		return qfalse;
	}

	// JUHOX FIXME: no shadows for monsters (might exceed internal limits of the Quake engine)
#if MONSTER_MODE
	if (cent->currentState.clientNum >= CLIENTNUM_MONSTERS) {
		return qfalse;
	}
#endif

	// no shadows when invisible
	if ( cent->currentState.powerups & ( 1 << PW_INVIS ) ) {
		return qfalse;
	}

	// JUHOX: compute vars needed to adapt player shadow to guard monsters
#if MONSTER_MODE
	shadowDistance = SHADOW_DISTANCE;
	radius = 24;

	switch (cent->currentState.clientNum) {
	case CLIENTNUM_MONSTER_GUARD:
		shadowDistance *= MONSTER_GUARD_SCALE;
		radius *= MONSTER_GUARD_SCALE;
		break;
	}
#endif

	// send a trace down from the player to the ground
	VectorCopy( cent->lerpOrigin, end );
	// JUHOX: adapt shadow distance to guard monsters
#if !MONSTER_MODE
	end[2] -= SHADOW_DISTANCE;
#else
	end[2] -= shadowDistance;
#endif

	trap_CM_BoxTrace( &trace, cent->lerpOrigin, end, mins, maxs, 0, MASK_PLAYERSOLID );

	// no shadow if too high
	if ( trace.fraction == 1.0 || trace.startsolid || trace.allsolid ) {
		return qfalse;
	}

	*shadowPlane = trace.endpos[2] + 1;

	if ( cg_shadows.integer != 1 ) {	// no mark for stencil or projection shadows
		return qtrue;
	}

	// fade the shadow out with height
	alpha = 1.0 - trace.fraction;

	// bk0101022 - hack / FPE - bogus planes?
	//assert( DotProduct( trace.plane.normal, trace.plane.normal ) != 0.0f ) 

	// add the mark as a temporary, so it goes directly to the renderer
	// without taking a spot in the cg_marks array
	// JUHOX: adapt shadow radius to guard monsters
#if !MONSTER_MODE
	CG_ImpactMark( cgs.media.shadowMarkShader, trace.endpos, trace.plane.normal, 
		cent->pe.legs.yawAngle, alpha,alpha,alpha,1, qfalse, 24, qtrue );
#else
	CG_ImpactMark(
		cgs.media.shadowMarkShader, trace.endpos, trace.plane.normal,
		cent->pe.legs.yawAngle, alpha,alpha,alpha, 1, qfalse, radius, qtrue
	);
#endif

	return qtrue;
}


/*
===============
CG_PlayerSplash

Draw a mark at the water surface
===============
*/
static void CG_PlayerSplash( centity_t *cent ) {
	vec3_t		start, end;
	trace_t		trace;
	int			contents;
	polyVert_t	verts[4];
	// JUHOX: vars needed to adapt player splash to guard monsters;
#if MONSTER_MODE
	float top_size;
	float bottom_size;
	float width;
#endif

	if ( !cg_shadows.integer ) {
		return;
	}

	// JUHOX: compute vars needed to adapt player splash to guard monsters
#if MONSTER_MODE
	top_size = 32;
	bottom_size = 24;
	width = 32;
	switch (cent->currentState.clientNum) {
	case CLIENTNUM_MONSTER_GUARD:
		top_size *= MONSTER_GUARD_SCALE;
		bottom_size *= MONSTER_GUARD_SCALE;
		width *= MONSTER_GUARD_SCALE;
		break;
	}
#endif

	VectorCopy( cent->lerpOrigin, end );
	// JUHOX: adapt player bottom size of guard monsters for player splash
#if !MONSTER_MODE
	end[2] -= 24;
#else
	end[2] -= bottom_size;
#endif

	// if the feet aren't in liquid, don't make a mark
	// this won't handle moving water brushes, but they wouldn't draw right anyway...
	contents = trap_CM_PointContents( end, 0 );
	if ( !( contents & ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) ) {
		return;
	}

	VectorCopy( cent->lerpOrigin, start );
	// JUHOX: adapt player top size of guard monsters for player splash
#if !MONSTER_MODE
	start[2] += 32;
#else
	start[2] += top_size;
#endif

	// if the head isn't out of liquid, don't make a mark
	contents = trap_CM_PointContents( start, 0 );
	if ( contents & ( CONTENTS_SOLID | CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) ) {
		return;
	}

	// trace down to find the surface
	trap_CM_BoxTrace( &trace, start, end, NULL, NULL, 0, ( CONTENTS_WATER | CONTENTS_SLIME | CONTENTS_LAVA ) );

	if ( trace.fraction == 1.0 ) {
		return;
	}

	// create a mark polygon
	VectorCopy( trace.endpos, verts[0].xyz );
	// JUHOX: adapt player width of guard monsters for player splash
#if !MONSTER_MODE
	verts[0].xyz[0] -= 32;
	verts[0].xyz[1] -= 32;
#else
	verts[0].xyz[0] -= width;
	verts[0].xyz[1] -= width;
#endif
	verts[0].st[0] = 0;
	verts[0].st[1] = 0;
	verts[0].modulate[0] = 255;
	verts[0].modulate[1] = 255;
	verts[0].modulate[2] = 255;
	verts[0].modulate[3] = 255;

	VectorCopy( trace.endpos, verts[1].xyz );
	// JUHOX: adapt player width of guard monsters for player splash
#if !MONSTER_MODE
	verts[1].xyz[0] -= 32;
	verts[1].xyz[1] += 32;
#else
	verts[1].xyz[0] -= width;
	verts[1].xyz[1] += width;
#endif
	verts[1].st[0] = 0;
	verts[1].st[1] = 1;
	verts[1].modulate[0] = 255;
	verts[1].modulate[1] = 255;
	verts[1].modulate[2] = 255;
	verts[1].modulate[3] = 255;

	VectorCopy( trace.endpos, verts[2].xyz );
	// JUHOX: adapt player width of guard monsters for player splash
#if !MONSTER_MODE
	verts[2].xyz[0] += 32;
	verts[2].xyz[1] += 32;
#else
	verts[2].xyz[0] += width;
	verts[2].xyz[1] += width;
#endif
	verts[2].st[0] = 1;
	verts[2].st[1] = 1;
	verts[2].modulate[0] = 255;
	verts[2].modulate[1] = 255;
	verts[2].modulate[2] = 255;
	verts[2].modulate[3] = 255;

	VectorCopy( trace.endpos, verts[3].xyz );
	// JUHOX: adapt player width of guard monsters for player splash
#if !MONSTER_MODE
	verts[3].xyz[0] += 32;
	verts[3].xyz[1] -= 32;
#else
	verts[3].xyz[0] += width;
	verts[3].xyz[1] -= width;
#endif
	verts[3].st[0] = 1;
	verts[3].st[1] = 0;
	verts[3].modulate[0] = 255;
	verts[3].modulate[1] = 255;
	verts[3].modulate[2] = 255;
	verts[3].modulate[3] = 255;

	trap_R_AddPolyToScene( cgs.media.wakeMarkShader, 4, verts );
}


/*
===============
JUHOX: CG_GetSpawnEffectParameters
===============
*/
qboolean CG_GetSpawnEffectParameters(
	entityState_t* state,
	float* intensity, qboolean* skipOthers, int* powerups,
	refEntity_t* refEnt
) {
	int startTime;
	int effectTime;
	float effectDuration;
	qboolean dummy1;
	int dummy2;
	playerEffect_t effect;

	if (!state->time) return qfalse;
	if (cg.time >= state->time) return qfalse;
	effect = state->frame;
	switch (effect) {
	case PE_spawn:
	case PE_fade_in:
	case PE_fade_out:
	case PE_hibernation:
	case PE_titan_awaking:
		break;
	default:
		return qfalse;
	}

	if (!skipOthers) skipOthers = &dummy1;
	if (!powerups) powerups = &dummy2;

	startTime = state->time - SPAWNHULL_TIME;
	effectTime = cg.time - startTime;
	if (effectTime < 0) effectTime = 0;

	if (effectTime <= SPAWNHULL_FADEIN_TIME) {
		effectDuration = SPAWNHULL_FADEIN_TIME;
		switch (effect) {
		case PE_spawn:
			*skipOthers = qtrue;
			break;
		case PE_fade_in:
			*skipOthers = qfalse;
			*powerups |= 1 << PW_INVIS;
			break;
		case PE_fade_out:
		case PE_hibernation:
			*skipOthers = qfalse;
			*powerups &= ~(1 << PW_INVIS);
			break;
		case PE_titan_awaking:
			if (refEnt) {
				refEnt->customShader = trap_R_RegisterShader("stone");
				trap_R_AddRefEntityToScene(refEnt);
				refEnt->customShader = 0;
			}
			*skipOthers = qtrue;
			break;
		}
	}
	else {
		effectTime = SPAWNHULL_TIME - effectTime;
		effectDuration = SPAWNHULL_FADEOUT_TIME;
		*skipOthers = qfalse;
		switch (effect) {
		case PE_spawn:
			break;
		case PE_fade_in:
			*powerups &= ~(1 << PW_INVIS);
			break;
		case PE_fade_out:
			*powerups |= 1 << PW_INVIS;
			break;
		case PE_hibernation:
			*skipOthers = qtrue;
			break;
		case PE_titan_awaking:
			break;
		}
	}
	*intensity = (float)effectTime / effectDuration;
	return qtrue;
}

/*
===============
CG_AddRefEntityWithPowerups

Adds a piece with modifications or duplications for powerups
Also called by CG_Missile for quad rockets, but nobody can tell...
===============
*/
void CG_AddRefEntityWithPowerups( refEntity_t *ent, entityState_t *state, int team ) {
	int powerups;	// JUHOX

	// JUHOX: set corrected lighting origin for EFH
#if ESCAPE_MODE
	if (cgs.gametype == GT_EFH) {
		ent->renderfx |= RF_LIGHTING_ORIGIN;
		VectorCopy(state->origin, ent->lightingOrigin);
	}
#endif

	// JUHOX: draw spawn hull
#if 1
	powerups = state->powerups;

	{
		float intensity;
		qboolean skipOthers;

		if (CG_GetSpawnEffectParameters(state, &intensity, &skipOthers, &powerups, ent)) {
			ent->customShader = cgs.media.spawnHullShader;
			ent->shaderRGBA[3] = 255 * intensity;
			trap_R_AddRefEntityToScene(ent);

			if (ent->shaderRGBA[3] > 128) {
				ent->shaderRGBA[3] -= 128;
				ent->shaderRGBA[3] >>= 3;
				ent->customShader = cgs.media.spawnHullGlow1Shader;
				trap_R_AddRefEntityToScene(ent);

				ent->customShader = cgs.media.spawnHullGlow2Shader;
				trap_R_AddRefEntityToScene(ent);

				ent->customShader = cgs.media.spawnHullGlow3Shader;
				trap_R_AddRefEntityToScene(ent);

				ent->customShader = cgs.media.spawnHullGlow4Shader;
				trap_R_AddRefEntityToScene(ent);
			}

			if (skipOthers) return;

			ent->customShader = 0;
		}
	}
#endif

	// JUHOX: draw monster glow
#if MONSTER_MODE
	if (
		cg.viewMode == VIEW_scanner &&
		cg.scannerActivationTime &&
		state->eType == ET_PLAYER &&
		state->clientNum >= CLIENTNUM_MONSTERS &&
		state->clientNum < MAX_CLIENTS + EXTRA_CLIENTNUMS &&
		(
			state->clientNum != CLIENTNUM_MONSTER_TITAN ||
			!state->otherEntityNum2	// qtrue if titan is sleeping
		)
	) {
		centity_t* cent;
		int color;

		cent = &cg_entities[state->number];
		color = 255;
		if (cent->deathTime) {
			#define SCANNER_DEATH_FADE_TIME 5000

			if (cg.time < cent->deathTime + SCANNER_DEATH_FADE_TIME) {
				color = 255 - (255 * (cg.time - cent->deathTime)) / SCANNER_DEATH_FADE_TIME;
				if (color < 0) color = 0;
				if (color > 255) color = 255;
			}
			else {
				color = 0;
			}
		}
		if (cg.time < cg.scannerActivationTime + SCANNER_DEATH_FADE_TIME) {
			color = (color * (cg.time - cg.scannerActivationTime)) / SCANNER_DEATH_FADE_TIME;
		}
		if (color > 0) {
			ent->customShader = trap_R_RegisterShader("monsterGlow");
			ent->shaderRGBA[0] = color;
			ent->shaderRGBA[1] = color;
			ent->shaderRGBA[2] = color;
			ent->shaderRGBA[3] = 255;
			ent->shaderTime = state->number * 1.731;
			trap_R_AddRefEntityToScene(ent);
			ent->customShader = 0;
		}
	}
#endif

	// JUHOX: powerups may be redefined by CG_GetSpawnEffectParameters()
#if 0
	if ( state->powerups & ( 1 << PW_INVIS ) ) {
#else
	if (powerups & (1 << PW_INVIS)) {
#endif
		// JUHOX: draw the marks even if the entity is invisible
#if 0
		ent->customShader = cgs.media.invisShader;
		trap_R_AddRefEntityToScene( ent );
#else
		qboolean drawInvisShader;

		drawInvisShader = qtrue;
		if (
			cgs.gametype >= GT_TEAM &&
			(
#if MONSTER_MODE
				cgs.gametype >= GT_STU ||
#endif
				cg.snap->ps.persistant[PERS_TEAM] == team
			)
		) {
			if (team == TEAM_RED)
				ent->customShader = cgs.media.redInvis;
			else
				ent->customShader = cgs.media.blueInvis;
			trap_R_AddRefEntityToScene(ent);
			drawInvisShader = qfalse;

			if (state->powerups & (1<<PW_REGEN)) {
				if (((cg.time / 100) % 10) == 1) {
					ent->customShader = cgs.media.regenShader;
					trap_R_AddRefEntityToScene(ent);
				}
			}
		}
		if (state->powerups & (1 << PW_CHARGE)) {
			ent->customShader = cgs.media.chargeShader;
			ent->shaderRGBA[3] = 64;
			trap_R_AddRefEntityToScene(ent);
			drawInvisShader = qfalse;
		}
		if (state->powerups & (1 << PW_BATTLESUIT)) {
			ent->customShader = cgs.media.battleSuitShader;
			trap_R_AddRefEntityToScene(ent);
			drawInvisShader = qfalse;
		}
		if (state->powerups & (1 << PW_SHIELD)) {
			ent->customShader = cgs.media.shieldShader;
			trap_R_AddRefEntityToScene(ent);
			drawInvisShader = qfalse;
		}
		// invisibility shader not needed if any marker drawn
		if (drawInvisShader || cg_glassCloaking.integer) {
			if (cg_glassCloaking.integer) {
				ent->customShader = cgs.media.glassCloakingShader;
				trap_R_AddRefEntityToScene(ent);

				/*
				if (drawInvisShader) {
					if (cg.clientNum == state->number) {
						ent->customShader = cgs.media.glassCloakingSpecShader;
						ent->shaderRGBA[3] = 255;
						trap_R_AddRefEntityToScene(ent);
					}
					else {
						float distance;

						distance = Distance(cg.snap->ps.origin, state->pos.trBase);
						if (distance < GLASSCLOAKINGSPECSHADER_MAXDISTANCE) {
							ent->customShader = cgs.media.glassCloakingSpecShader;
							ent->shaderRGBA[3] =
								GLASSCLOAKINGSPECSHADER_MAXALPHA *
								(1.0 - distance / GLASSCLOAKINGSPECSHADER_MAXDISTANCE);
							trap_R_AddRefEntityToScene(ent);
						}

					}
				}
				*/
			}
			else {
				ent->customShader = cgs.media.invisShader;
				trap_R_AddRefEntityToScene(ent);
			}
		}
#endif
	} else {
#if MONSTER_MODE	// JUHOX: titan's stone skin
		if (state->clientNum == CLIENTNUM_MONSTER_TITAN && state->otherEntityNum2) {
			ent->customShader = trap_R_RegisterShader("stone");
		}
#endif
		/*
		if ( state->eFlags & EF_KAMIKAZE ) {
			if (team == TEAM_BLUE)
				ent->customShader = cgs.media.blueKamikazeShader;
			else
				ent->customShader = cgs.media.redKamikazeShader;
			trap_R_AddRefEntityToScene( ent );
		}
		else {*/
			trap_R_AddRefEntityToScene( ent );
		//}

		if ( state->powerups & ( 1 << PW_QUAD ) )
		{
			if (team == TEAM_RED)
				ent->customShader = cgs.media.redQuadShader;
			else
				ent->customShader = cgs.media.quadShader;
			trap_R_AddRefEntityToScene( ent );
		}
		if ( state->powerups & ( 1 << PW_REGEN ) ) {
			if ( ( ( cg.time / 100 ) % 10 ) == 1 ) {
				ent->customShader = cgs.media.regenShader;
				trap_R_AddRefEntityToScene( ent );
			}
		}
		if ( state->powerups & ( 1 << PW_BATTLESUIT ) ) {
			ent->customShader = cgs.media.battleSuitShader;
			trap_R_AddRefEntityToScene( ent );
		}
		// JUHOX: draw the shield shader
#if 1
		if (state->powerups & (1 << PW_SHIELD)) {
			ent->customShader = cgs.media.shieldShader;
			trap_R_AddRefEntityToScene(ent);
		}
#endif
		// JUHOX: draw the charge shader
#if 1
		if (state->powerups & (1 << PW_CHARGE)) {
			ent->customShader = cgs.media.chargeShader;
			ent->shaderRGBA[3] = 128;
			trap_R_AddRefEntityToScene(ent);
		}
#endif
	}
	// JUHOX: users of the gauntlet get the target marked
#if 1
	if (
		cg.snap->ps.weapon == WP_GAUNTLET &&
		cg.snap->ps.stats[STAT_TARGET] == state->number
	) {
		ent->customShader = cgs.media.targetMarker;
		trap_R_AddRefEntityToScene(ent);
	}
#endif
}

/*
===============
JUHOX: GetDischargeStartPoint
===============
*/
/*
static void GetDischargeStartPoint(const centity_t* cent, vec3_t pos, vec3_t dir) {
	vec3_t angles;

	VectorCopy(cent->lerpOrigin, pos);
	pos[0] += 15 * crandom();
	pos[1] += 15 * crandom();
	pos[2] += 28 * crandom() + 4;

	angles[0] = 360.0 * random();
	angles[1] = 360.0 * random();
	angles[2] = 360.0 * random();
	AngleVectors(angles, dir, NULL, NULL);
}
*/

/*
===============
JUHOX: AddDischargeFlash
===============
*/
void AddDischargeFlash(
	const vec3_t origin, const vec3_t startAngles, dischargeFlash_t* flash, int entnum,
	const vec3_t mins, const vec3_t maxs, qhandle_t shader
) {
	localseed_t seed;
	float f;
	int i;
	vec3_t startPoint;
	vec3_t endPoint;
	vec3_t angles;
	float totalLen;

	if (cg.time >= flash->nextChangeTime) {
		flash->seed = lrand();
		flash->lastChangeTime = cg.time;
		flash->nextChangeTime = cg.time + lrand() % DISCHARGE_MAX_DURATION;
	}

	seed.seed0 = flash->seed;
	seed.seed1 = entnum;
	seed.seed2 = 0;
	seed.seed3 = 0;

	f = (float)(cg.time - flash->lastChangeTime) / (float)DISCHARGE_MAX_DURATION;

	VectorCopy(origin, startPoint);

	if (startAngles) {
		VectorCopy(startAngles, angles);
	}
	else {
		angles[0] = 360.0 * local_random(&seed);
		angles[1] = 360.0 * local_random(&seed);

		startPoint[0] += mins[0] + (maxs[0] - mins[0]) * local_random(&seed);
		startPoint[1] += mins[1] + (maxs[1] - mins[1]) * local_random(&seed);
		startPoint[2] += mins[2] + (maxs[2] - mins[2]) * local_random(&seed);
	}

	totalLen = 0;
	for (i = 0; i < 15; i++) {
		float a;
		float b;
		vec3_t dir;
		trace_t trace;

		a = DISCHARGE_MAX_ANGLE_DIFF * local_crandom(&seed);
		b = DISCHARGE_MAX_ANGLE_DIFF * local_crandom(&seed);
		angles[0] += a + (b - a) * f;
		a = DISCHARGE_MAX_ANGLE_DIFF * local_crandom(&seed);
		b = DISCHARGE_MAX_ANGLE_DIFF * local_crandom(&seed);
		angles[1] += a + (b - a) * f;
		AngleVectors(angles, dir, NULL, NULL);
	
		a = DISCHARGE_MIN_LEN + DISCHARGE_MAX_ADD * local_random(&seed);
		b = DISCHARGE_MIN_LEN + DISCHARGE_MAX_ADD * local_random(&seed);
		VectorMA(startPoint, a + (b - a) * f, dir, endPoint);
		
		if (cg_noTrace.integer) {
			CG_Draw3DLine(startPoint, endPoint, shader);
		}
		else {
			CG_Trace(&trace, startPoint, NULL, NULL, endPoint, entnum, MASK_SHOT);
			CG_Draw3DLine(startPoint, trace.endpos, shader);
			if (trace.fraction < 1) return;
		}

		VectorCopy(endPoint, startPoint);
	}
}

/*
===============
JUHOX: CG_AddDischarges
===============
*/
static void CG_AddDischarges(centity_t* cent) {
#if 0
	trace_t		trace;
	vec3_t		angles;
	vec3_t		dir;
	vec3_t		startPoint, endPoint;
	int i, n;
	qboolean multiFlashes;
	float charge;

	GetDischargeStartPoint(cent, startPoint, dir);

	if (cent->currentState.number == cg.snap->ps.clientNum) {
		charge = (cg.snap->ps.powerups[PW_CHARGE] - cg.time) / 1000.0;
	}
	else {
		charge = (cent->currentState.time2 - cg.time) / 1000.0;
	}
	if (charge <= 0) return;
	if (charge > 20) charge = 20;
	if (charge > 10) {
		n = charge;
		charge -= n;
		if (random() < charge) n++;
		multiFlashes = qtrue;
	}
	else {
		if (10 * random() > charge) return;
		n = 10;
		multiFlashes = qfalse;
	}
	for (i = 0; i < n; i++) {
		vec3_t angles;

		vectoangles(dir, angles);
		angles[0] += 30.0 * crandom();
		angles[1] += 30.0 * crandom();
		//angles[2] += 30.0 * crandom();
		AngleVectors(angles, dir, NULL, NULL);
	
		VectorMA(startPoint, /*15 + 50*random()*/25.0, dir, endPoint);
	
		// see if it hit a wall
		CG_Trace(&trace, startPoint, vec3_origin, vec3_origin, endPoint, cent->currentState.number, MASK_SHOT);
	
		CG_Draw3DLine(startPoint, trace.endpos, cgs.media.dischargeFlashShader);

		if (trace.fraction >= 1) {
			// continue the flash
			VectorCopy(trace.endpos, startPoint);
		}
		else {
			// begin a new flash
			if (!multiFlashes) return;
			GetDischargeStartPoint(cent, startPoint, dir);
		}
	}
#else

	float charge;
	int i;
	int n;
	vec3_t mins;
	vec3_t maxs;

	if (cent->currentState.number == cg.snap->ps.clientNum) {
		charge = (cg.snap->ps.powerups[PW_CHARGE] - cg.time) / 1000.0;
	}
	else {
		charge = (cent->currentState.time2 - cg.time) / 1000.0;
	}
	if (charge <= 0) return;

	charge *= 0.25;	
	n = charge;
	charge -= n;
	if (random() < charge) n++;

	if (n > MAX_DISCHARGE_FLASHES_PER_ENTITY) {
		n = MAX_DISCHARGE_FLASHES_PER_ENTITY;
	}

	switch (cent->currentState.clientNum) {
	case CLIENTNUM_MONSTER_PREDATOR:
	case CLIENTNUM_MONSTER_PREDATOR_RED:
	case CLIENTNUM_MONSTER_PREDATOR_BLUE:
		if (cent->currentState.modelindex & PFMI_HIBERNATION_MORPHED) {
			VectorSet(mins, 0, 0, 0);
			VectorSet(maxs, 0, 0, 0);
		}
		else {
			VectorSet(mins, -15, -15, -24);
			VectorSet(maxs, +15, +15, +32);
		}
		break;
	case CLIENTNUM_MONSTER_GUARD:
		VectorSet(mins, -15*MONSTER_GUARD_SCALE, -15*MONSTER_GUARD_SCALE, -24*MONSTER_GUARD_SCALE);
		VectorSet(maxs, +15*MONSTER_GUARD_SCALE, +15*MONSTER_GUARD_SCALE, +32*MONSTER_GUARD_SCALE);
		break;
	case CLIENTNUM_MONSTER_TITAN:
		VectorSet(mins, -15*MONSTER_TITAN_SCALE, -15*MONSTER_TITAN_SCALE, -24*MONSTER_TITAN_SCALE);
		VectorSet(maxs, +15*MONSTER_TITAN_SCALE, +15*MONSTER_TITAN_SCALE, +32*MONSTER_TITAN_SCALE);
		break;
	default:
		VectorSet(mins, -15, -15, -24);
		VectorSet(maxs, +15, +15, +32);
		break;
	}

	for (i = 0; i < n; i++) {
		AddDischargeFlash(
			cent->lerpOrigin, NULL, &cent->flashes[i], cent->currentState.number,
			mins, maxs, cgs.media.dischargeFlashShader
		);
	}

#endif
}

/*
=================
CG_LightVerts
=================
*/
int CG_LightVerts( vec3_t normal, int numVerts, polyVert_t *verts )
{
	int				i, j;
	float			incoming;
	vec3_t			ambientLight;
	vec3_t			lightDir;
	vec3_t			directedLight;

	trap_R_LightForPoint( verts[0].xyz, ambientLight, directedLight, lightDir );

	for (i = 0; i < numVerts; i++) {
		incoming = DotProduct (normal, lightDir);
		if ( incoming <= 0 ) {
			verts[i].modulate[0] = ambientLight[0];
			verts[i].modulate[1] = ambientLight[1];
			verts[i].modulate[2] = ambientLight[2];
			verts[i].modulate[3] = 255;
			continue;
		} 
		j = ( ambientLight[0] + incoming * directedLight[0] );
		if ( j > 255 ) {
			j = 255;
		}
		verts[i].modulate[0] = j;

		j = ( ambientLight[1] + incoming * directedLight[1] );
		if ( j > 255 ) {
			j = 255;
		}
		verts[i].modulate[1] = j;

		j = ( ambientLight[2] + incoming * directedLight[2] );
		if ( j > 255 ) {
			j = 255;
		}
		verts[i].modulate[2] = j;

		verts[i].modulate[3] = 255;
	}
	return qtrue;
}

/*
===============
CG_Player
===============
*/
void CG_Player( centity_t *cent ) {
	clientInfo_t	*ci;
	refEntity_t		legs;
	refEntity_t		torso;
	refEntity_t		head;
	int				clientNum;
	int				renderfx;
	qboolean		shadow;
	float			shadowPlane;
#ifdef MISSIONPACK
	refEntity_t		skull;
	refEntity_t		powerup;
	int				t;
	float			c;
	float			angle;
	vec3_t			dir, angles;
#endif

	// the client number is stored in clientNum.  It can't be derived
	// from the entity number, because a single client may have
	// multiple corpses on the level using the same clientinfo
	clientNum = cent->currentState.clientNum;
	// JUHOX: accept EXTRA_CLIENTNUMS
#if !MONSTER_MODE
	if ( clientNum < 0 || clientNum >= MAX_CLIENTS ) {
#else
	if (clientNum < 0 || clientNum >= MAX_CLIENTS + EXTRA_CLIENTNUMS) {
#endif
		CG_Error( "Bad clientNum on player entity");
	}
	ci = &cgs.clientinfo[ clientNum ];

	//if (clientNum >= MAX_CLIENTS) CG_Printf("%d: type=%d\n", cent->currentState.number, clientNum);	// JUHOX DEBUG
	// it is possible to see corpses from disconnected players that may
	// not have valid clientinfo
	if ( !ci->infoValid ) {
		return;
	}

	// JUHOX: note death time
#if 1
	if (cent->currentState.eFlags & EF_DEAD) {
		if (!cent->deathTime) {
			cent->deathTime = cg.time;
			// NOTE: above may be slightly wrong if the player died while not in this client's snapshot
		}
	}
	else {
		cent->deathTime = 0;
	}
#endif

#if ESCAPE_MODE	// JUHOX: check if this player is in a visible segment
	if (
		cgs.gametype == GT_EFH &&
		clientNum != cg.snap->ps.clientNum &&
		(
			cent->currentState.constantLight < cg.snap->ps.persistant[PERS_MIN_SEGMENT] ||
			cent->currentState.constantLight > cg.snap->ps.persistant[PERS_MAX_SEGMENT]
		)
	) {
		return;
	}
#endif

	// JUHOX: extract tss player info
#if 1
	if (
		cgs.gametype >= GT_TEAM &&
		ci->team == cg.snap->ps.persistant[PERS_TEAM] &&
		BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_isValid)
	) {
		ci->group = BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_group);
		ci->memberStatus = BG_TSS_GetPlayerEntityInfo(&cent->currentState, TSSPI_groupMemberStatus);
	}
	else {
		ci->group = -1;
		ci->memberStatus = -1;
	}
#endif

	// JUHOX: save the pfmi
#if 1
	ci->pfmi = cent->currentState.modelindex;
#endif

	if (cent->currentState.eFlags & EF_NODRAW) return;	// JUHOX: for dead spectators

	// get the player model information
	renderfx = 0;
	if ( cent->currentState.number == cg.snap->ps.clientNum) {
		if (!cg.renderingThirdPerson) {
			renderfx = RF_THIRD_PERSON;			// only draw in mirrors
		} else {
			if (cg_cameraMode.integer) {
				return;
			}
		}
	}

	// JUHOX: add discharge beams to charged players
#if 1
	if (
		(cent->currentState.powerups & (1 << PW_CHARGE)) /*&&
		cent->dischargeTime < cg.time - 100*/
	) {
		CG_AddDischarges(cent);
	}
#endif


	memset( &legs, 0, sizeof(legs) );
	memset( &torso, 0, sizeof(torso) );
	memset( &head, 0, sizeof(head) );

	// get the rotation information
	CG_PlayerAngles( cent, legs.axis, torso.axis, head.axis );
	
	// JUHOX: make monster guard (visually) bigger
#if MONSTER_MODE
	switch (clientNum) {
	case CLIENTNUM_MONSTER_GUARD:
		VectorScale(legs.axis[0], MONSTER_GUARD_SCALE, legs.axis[0]);
		VectorScale(legs.axis[1], MONSTER_GUARD_SCALE, legs.axis[1]);
		VectorScale(legs.axis[2], MONSTER_GUARD_SCALE, legs.axis[2]);
		legs.nonNormalizedAxes = qtrue;
		break;
	case CLIENTNUM_MONSTER_TITAN:
		VectorScale(legs.axis[0], MONSTER_TITAN_SCALE * 0.95, legs.axis[0]);
		VectorScale(legs.axis[1], MONSTER_TITAN_SCALE * 0.95, legs.axis[1]);
		VectorScale(legs.axis[2], MONSTER_TITAN_SCALE * 0.95, legs.axis[2]);
		legs.nonNormalizedAxes = qtrue;
		break;
	}
#endif

	// get the animation state (after rotation, to allow feet shuffle)
	CG_PlayerAnimation( cent, &legs.oldframe, &legs.frame, &legs.backlerp,
		 &torso.oldframe, &torso.frame, &torso.backlerp );

	// add the talk baloon or disconnect icon
	CG_PlayerSprites( cent );

	// JUHOX FIXME: no dlights in EFH
#if ESCAPE_MODE
	if (cgs.gametype != GT_EFH)
#endif
	// JUHOX: add spawn effect light
#if 1
	{
		float intensity;

		if (CG_GetSpawnEffectParameters(&cent->currentState, &intensity, NULL, NULL, NULL)) {
			trap_R_AddLightToScene(cent->lerpOrigin, 200, intensity, intensity, intensity);		
		}
	}
#endif

	// add the shadow
	shadow = CG_PlayerShadow( cent, &shadowPlane );

	// add a water splash if partially in and out of water
	CG_PlayerSplash( cent );

	if ( cg_shadows.integer == 3 && shadow ) {
		renderfx |= RF_SHADOW_PLANE;
	}
	renderfx |= RF_LIGHTING_ORIGIN;			// use the same origin for all
#ifdef MISSIONPACK
	if( cgs.gametype == GT_HARVESTER ) {
		CG_PlayerTokens( cent, renderfx );
	}
#endif
	//
	// add the legs
	//
	legs.hModel = ci->legsModel;
	legs.customSkin = ci->legsSkin;

	VectorCopy( cent->lerpOrigin, legs.origin );

	// JUHOX: draw hibernation items
#if MONSTER_MODE
	if (cent->currentState.modelindex & PFMI_HIBERNATION_MODE) {	// CAUTION: don't use ci->pfmi
		if (cent->currentState.modelindex & PFMI_HIBERNATION_DRAW_SEED) {	// CAUTION: don't use ci->pfmi
			const float radius = 4;
			refEntity_t seed;

			memset(&seed, 0, sizeof(seed));

			seed.hModel = trap_R_RegisterModel("models/powerups/health/small_sphere.md3");
			seed.customShader = cgs.media.monsterSeedMetalShader;
			//seed.renderfx |= RF_NOSHADOW;

			VectorCopy(cent->lerpOrigin, seed.origin);
			if (!(cent->currentState.modelindex & PFMI_HIBERNATION_MORPHED)) {	// CAUTION: don't use ci->pfmi
				seed.origin[2] += DEFAULT_VIEWHEIGHT;
			}
			VectorCopy(seed.origin, seed.lightingOrigin);

			seed.origin[2] -= 0.5 * radius;
			seed.axis[0][0] = 0.1 * radius;
			seed.axis[1][1] = 0.1 * radius;
			seed.axis[2][2] = 0.1 * radius;
			seed.nonNormalizedAxes = qtrue;
			trap_R_AddRefEntityToScene(&seed);
		}
		
		if (cent->currentState.modelindex & PFMI_HIBERNATION_DRAW_THREAD) {	// CAUTION: don't use ci->pfmi
			refEntity_t thread;

			VectorCopy(cent->lerpOrigin, thread.origin);
			if (!(cent->currentState.modelindex & PFMI_HIBERNATION_MORPHED)) {	// CAUTION: don't use ci->pfmi
				thread.origin[2] += DEFAULT_VIEWHEIGHT;
			}
			VectorCopy(cent->currentState.origin2, thread.oldorigin);
			thread.reType = RT_LIGHTNING;
			thread.customShader = trap_R_RegisterShader("thread");
			trap_R_AddRefEntityToScene(&thread);
		}

		if (!cent->currentState.time || cent->currentState.time <= cg.time) return;
	}
#endif

	VectorCopy( cent->lerpOrigin, legs.lightingOrigin );
	legs.shadowPlane = shadowPlane;
	legs.renderfx = renderfx;

#if 1	// JUHOX: correct origin for scaled models (hack)
	switch (clientNum) {
	case CLIENTNUM_MONSTER_TITAN:
		legs.origin[2] -= 5;
		break;
	}
#endif

	VectorCopy (legs.origin, legs.oldorigin);	// don't positionally lerp at all

	CG_AddRefEntityWithPowerups( &legs, &cent->currentState, ci->team );


	// if the model failed, allow the default nullmodel to be displayed
	if (!legs.hModel) {
		return;
	}

	//
	// add the torso
	//
	torso.hModel = ci->torsoModel;
	if (!torso.hModel) {
		return;
	}

	torso.customSkin = ci->torsoSkin;

	VectorCopy( cent->lerpOrigin, torso.lightingOrigin );

	CG_PositionRotatedEntityOnTag( &torso, &legs, ci->legsModel, "tag_torso");

	torso.shadowPlane = shadowPlane;
	torso.renderfx = renderfx;

	CG_AddRefEntityWithPowerups( &torso, &cent->currentState, ci->team );

#ifdef MISSIONPACK
	if ( cent->currentState.eFlags & EF_KAMIKAZE ) {

		memset( &skull, 0, sizeof(skull) );

		VectorCopy( cent->lerpOrigin, skull.lightingOrigin );
		skull.shadowPlane = shadowPlane;
		skull.renderfx = renderfx;

		if ( cent->currentState.eFlags & EF_DEAD ) {
			// one skull bobbing above the dead body
			angle = ((cg.time / 7) & 255) * (M_PI * 2) / 255;
			if (angle > M_PI * 2)
				angle -= (float)M_PI * 2;
			dir[0] = sin(angle) * 20;
			dir[1] = cos(angle) * 20;
			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
			dir[2] = 15 + sin(angle) * 8;
			VectorAdd(torso.origin, dir, skull.origin);
			
			dir[2] = 0;
			VectorCopy(dir, skull.axis[1]);
			VectorNormalize(skull.axis[1]);
			VectorSet(skull.axis[2], 0, 0, 1);
			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);

			skull.hModel = cgs.media.kamikazeHeadModel;
			trap_R_AddRefEntityToScene( &skull );
			skull.hModel = cgs.media.kamikazeHeadTrail;
			trap_R_AddRefEntityToScene( &skull );
		}
		else {
			// three skulls spinning around the player
			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255;
			dir[0] = cos(angle) * 20;
			dir[1] = sin(angle) * 20;
			dir[2] = cos(angle) * 20;
			VectorAdd(torso.origin, dir, skull.origin);

			angles[0] = sin(angle) * 30;
			angles[1] = (angle * 180 / M_PI) + 90;
			if (angles[1] > 360)
				angles[1] -= 360;
			angles[2] = 0;
			AnglesToAxis( angles, skull.axis );

			/*
			dir[2] = 0;
			VectorInverse(dir);
			VectorCopy(dir, skull.axis[1]);
			VectorNormalize(skull.axis[1]);
			VectorSet(skull.axis[2], 0, 0, 1);
			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
			*/

			skull.hModel = cgs.media.kamikazeHeadModel;
			trap_R_AddRefEntityToScene( &skull );
			// flip the trail because this skull is spinning in the other direction
			VectorInverse(skull.axis[1]);
			skull.hModel = cgs.media.kamikazeHeadTrail;
			trap_R_AddRefEntityToScene( &skull );

			angle = ((cg.time / 4) & 255) * (M_PI * 2) / 255 + M_PI;
			if (angle > M_PI * 2)
				angle -= (float)M_PI * 2;
			dir[0] = sin(angle) * 20;
			dir[1] = cos(angle) * 20;
			dir[2] = cos(angle) * 20;
			VectorAdd(torso.origin, dir, skull.origin);

			angles[0] = cos(angle - 0.5 * M_PI) * 30;
			angles[1] = 360 - (angle * 180 / M_PI);
			if (angles[1] > 360)
				angles[1] -= 360;
			angles[2] = 0;
			AnglesToAxis( angles, skull.axis );

			/*
			dir[2] = 0;
			VectorCopy(dir, skull.axis[1]);
			VectorNormalize(skull.axis[1]);
			VectorSet(skull.axis[2], 0, 0, 1);
			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);
			*/

			skull.hModel = cgs.media.kamikazeHeadModel;
			trap_R_AddRefEntityToScene( &skull );
			skull.hModel = cgs.media.kamikazeHeadTrail;
			trap_R_AddRefEntityToScene( &skull );

			angle = ((cg.time / 3) & 255) * (M_PI * 2) / 255 + 0.5 * M_PI;
			if (angle > M_PI * 2)
				angle -= (float)M_PI * 2;
			dir[0] = sin(angle) * 20;
			dir[1] = cos(angle) * 20;
			dir[2] = 0;
			VectorAdd(torso.origin, dir, skull.origin);
			
			VectorCopy(dir, skull.axis[1]);
			VectorNormalize(skull.axis[1]);
			VectorSet(skull.axis[2], 0, 0, 1);
			CrossProduct(skull.axis[1], skull.axis[2], skull.axis[0]);

			skull.hModel = cgs.media.kamikazeHeadModel;
			trap_R_AddRefEntityToScene( &skull );
			skull.hModel = cgs.media.kamikazeHeadTrail;
			trap_R_AddRefEntityToScene( &skull );
		}
	}

	if ( cent->currentState.powerups & ( 1 << PW_GUARD ) ) {
		memcpy(&powerup, &torso, sizeof(torso));
		powerup.hModel = cgs.media.guardPowerupModel;
		powerup.frame = 0;
		powerup.oldframe = 0;
		powerup.customSkin = 0;
		trap_R_AddRefEntityToScene( &powerup );
	}
	if ( cent->currentState.powerups & ( 1 << PW_SCOUT ) ) {
		memcpy(&powerup, &torso, sizeof(torso));
		powerup.hModel = cgs.media.scoutPowerupModel;
		powerup.frame = 0;
		powerup.oldframe = 0;
		powerup.customSkin = 0;
		trap_R_AddRefEntityToScene( &powerup );
	}
	if ( cent->currentState.powerups & ( 1 << PW_DOUBLER ) ) {
		memcpy(&powerup, &torso, sizeof(torso));
		powerup.hModel = cgs.media.doublerPowerupModel;
		powerup.frame = 0;
		powerup.oldframe = 0;
		powerup.customSkin = 0;
		trap_R_AddRefEntityToScene( &powerup );
	}
	if ( cent->currentState.powerups & ( 1 << PW_AMMOREGEN ) ) {
		memcpy(&powerup, &torso, sizeof(torso));
		powerup.hModel = cgs.media.ammoRegenPowerupModel;
		powerup.frame = 0;
		powerup.oldframe = 0;
		powerup.customSkin = 0;
		trap_R_AddRefEntityToScene( &powerup );
	}
	if ( cent->currentState.powerups & ( 1 << PW_INVULNERABILITY ) ) {
		if ( !ci->invulnerabilityStartTime ) {
			ci->invulnerabilityStartTime = cg.time;
		}
		ci->invulnerabilityStopTime = cg.time;
	}
	else {
		ci->invulnerabilityStartTime = 0;
	}
	if ( (cent->currentState.powerups & ( 1 << PW_INVULNERABILITY ) ) ||
		cg.time - ci->invulnerabilityStopTime < 250 ) {

		memcpy(&powerup, &torso, sizeof(torso));
		powerup.hModel = cgs.media.invulnerabilityPowerupModel;
		powerup.customSkin = 0;
		// always draw
		powerup.renderfx &= ~RF_THIRD_PERSON;
		VectorCopy(cent->lerpOrigin, powerup.origin);

		if ( cg.time - ci->invulnerabilityStartTime < 250 ) {
			c = (float) (cg.time - ci->invulnerabilityStartTime) / 250;
		}
		else if (cg.time - ci->invulnerabilityStopTime < 250 ) {
			c = (float) (250 - (cg.time - ci->invulnerabilityStopTime)) / 250;
		}
		else {
			c = 1;
		}
		VectorSet( powerup.axis[0], c, 0, 0 );
		VectorSet( powerup.axis[1], 0, c, 0 );
		VectorSet( powerup.axis[2], 0, 0, c );
		trap_R_AddRefEntityToScene( &powerup );
	}

	t = cg.time - ci->medkitUsageTime;
	if ( ci->medkitUsageTime && t < 500 ) {
		memcpy(&powerup, &torso, sizeof(torso));
		powerup.hModel = cgs.media.medkitUsageModel;
		powerup.customSkin = 0;
		// always draw
		powerup.renderfx &= ~RF_THIRD_PERSON;
		VectorClear(angles);
		AnglesToAxis(angles, powerup.axis);
		VectorCopy(cent->lerpOrigin, powerup.origin);
		powerup.origin[2] += -24 + (float) t * 80 / 500;
		if ( t > 400 ) {
			c = (float) (t - 1000) * 0xff / 100;
			powerup.shaderRGBA[0] = 0xff - c;
			powerup.shaderRGBA[1] = 0xff - c;
			powerup.shaderRGBA[2] = 0xff - c;
			powerup.shaderRGBA[3] = 0xff - c;
		}
		else {
			powerup.shaderRGBA[0] = 0xff;
			powerup.shaderRGBA[1] = 0xff;
			powerup.shaderRGBA[2] = 0xff;
			powerup.shaderRGBA[3] = 0xff;
		}
		trap_R_AddRefEntityToScene( &powerup );
	}
#endif // MISSIONPACK

	//
	// add the head
	//
	head.hModel = ci->headModel;
	if (!head.hModel) {
		return;
	}
	head.customSkin = ci->headSkin;

	VectorCopy( cent->lerpOrigin, head.lightingOrigin );

	CG_PositionRotatedEntityOnTag( &head, &torso, ci->torsoModel, "tag_head");

	head.shadowPlane = shadowPlane;
	head.renderfx = renderfx;

	CG_AddRefEntityWithPowerups( &head, &cent->currentState, ci->team );

#ifdef MISSIONPACK
	CG_BreathPuffs(cent, &head);

	CG_DustTrail(cent);
#endif

	//
	// add the gun / barrel / flash
	//
	CG_AddPlayerWeapon( &torso, NULL, cent, ci->team );

	// add powerups floating behind the player
	CG_PlayerPowerups( cent, &torso );

	// JUHOX: add grapple sounds
#if GRAPPLE_ROPE
	switch (cent->currentState.modelindex2) {
	case GST_unused:
	case GST_silent:
	case GST_fixed:
		break;
	case GST_windoff:
		trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.grappleWindOffSound);
		break;
	case GST_rewind:
		trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.grappleRewindSound);
		break;
	case GST_pulling:
		trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.grapplePullingSound);
		break;
	case GST_blocked:
		trap_S_AddLoopingSound(cent->currentState.number, cent->lerpOrigin, vec3_origin, cgs.media.grappleBlockingSound);
		break;
	}
#endif
}


//=====================================================================

/*
===============
CG_ResetPlayerEntity

A player just came into view or teleported, so reset all animation info
===============
*/
void CG_ResetPlayerEntity( centity_t *cent ) {
	cent->errorTime = -99999;		// guarantee no error decay added
	cent->extrapolated = qfalse;	

	CG_ClearLerpFrame( &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.legs, cent->currentState.legsAnim );
	CG_ClearLerpFrame( &cgs.clientinfo[ cent->currentState.clientNum ], &cent->pe.torso, cent->currentState.torsoAnim );

	BG_EvaluateTrajectory( &cent->currentState.pos, cg.time, cent->lerpOrigin );
	BG_EvaluateTrajectory( &cent->currentState.apos, cg.time, cent->lerpAngles );

	VectorCopy( cent->lerpOrigin, cent->rawOrigin );
	VectorCopy( cent->lerpAngles, cent->rawAngles );

	memset( &cent->pe.legs, 0, sizeof( cent->pe.legs ) );
	cent->pe.legs.yawAngle = cent->rawAngles[YAW];
	cent->pe.legs.yawing = qfalse;
	cent->pe.legs.pitchAngle = 0;
	cent->pe.legs.pitching = qfalse;
	cent->pe.legs.clock = cg.time;	// JUHOX

	memset( &cent->pe.torso, 0, sizeof( cent->pe.legs ) );
	cent->pe.torso.yawAngle = cent->rawAngles[YAW];
	cent->pe.torso.yawing = qfalse;
	cent->pe.torso.pitchAngle = cent->rawAngles[PITCH];
	cent->pe.torso.pitching = qfalse;
	cent->pe.torso.clock = cg.time;	// JUHOX

	if ( cg_debugPosition.integer ) {
		CG_Printf("%i ResetPlayerEntity yaw=%i\n", cent->currentState.number, cent->pe.torso.yawAngle );
	}
}

