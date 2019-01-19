// Copyright (C) 1999-2000 Id Software, Inc.
//
#include "../game/q_shared.h"
#include "tr_types.h"
#include "../game/bg_public.h"
#include "cg_public.h"


// The entire cgame module is unloaded and reloaded on each level change,
// so there is NO persistant data between levels on the client side.
// If you absolutely need something stored, it can either be kept
// by the server in the server stored userinfos, or stashed in a cvar.

#ifdef MISSIONPACK
#define CG_FONT_THRESHOLD 0.1
#endif

#define	POWERUP_BLINKS		5

#define	POWERUP_BLINK_TIME	1000
#define	FADE_TIME			200
#define	PULSE_TIME			200
#define	DAMAGE_DEFLECT_TIME	100
#define	DAMAGE_RETURN_TIME	400
#define DAMAGE_TIME			500
#define	LAND_DEFLECT_TIME	150
#define	LAND_RETURN_TIME	300
#define	STEP_TIME			200
#define	DUCK_TIME			100
#define	PAIN_TWITCH_TIME	200
#define	WEAPON_SELECT_TIME	1400
#define	ITEM_SCALEUP_TIME	1000
#define	ZOOM_TIME			150
#define	ITEM_BLOB_TIME		200
#define	MUZZLE_FLASH_TIME	20
#define	SINK_TIME			1000		// time for fragments to sink into ground before going away
#define	ATTACKER_HEAD_TIME	10000
#define	REWARD_TIME			3000
#define DISCHARGE_MAX_DURATION		500		// JUHOX
#define DISCHARGE_MAX_ANGLE_DIFF	40.0	// JUHOX
#define DISCHARGE_MIN_LEN			15.0	// JUHOX
#define DISCHARGE_MAX_ADD			30.0	// JUHOX

#define	PULSE_SCALE			1.5			// amount to scale up the icons when activating

#define	MAX_STEP_CHANGE		32

#define	MAX_VERTS_ON_POLY	10
#define	MAX_MARK_POLYS		256

#define STAT_MINUS			10	// num frame for '-' stats digit

#define	ICON_SIZE			48
#define	CHAR_WIDTH			32
#define	CHAR_HEIGHT			48
#define	TEXT_ICON_SPACE		4

#define	TEAMCHAT_WIDTH		80
#define TEAMCHAT_HEIGHT		8

// very large characters
#define	GIANT_WIDTH			32
#define	GIANT_HEIGHT		48

#define	NUM_CROSSHAIRS		10

#define TEAM_OVERLAY_MAXNAME_WIDTH	12
#define TEAM_OVERLAY_MAXLOCATION_WIDTH	16

#define	DEFAULT_MODEL			"sarge"
#ifdef MISSIONPACK
#define	DEFAULT_TEAM_MODEL		"james"
#define	DEFAULT_TEAM_HEAD		"*james"
#else
#define	DEFAULT_TEAM_MODEL		"sarge"
#define	DEFAULT_TEAM_HEAD		"sarge"
#endif

#define DEFAULT_REDTEAM_NAME		"Stroggs"
#define DEFAULT_BLUETEAM_NAME		"Pagans"

#define NUM_WEAPONORDERS	6	// JUHOX: should match the #define in ui_local.h
#define GLASSCLOAKINGSPECSHADER_MAXDISTANCE 200.0	// JUHOX
#define GLASSCLOAKINGSPECSHADER_MAXALPHA 150		// JUHOX

typedef enum {
	FOOTSTEP_NORMAL,
	FOOTSTEP_BOOT,
	FOOTSTEP_FLESH,
	FOOTSTEP_MECH,
	FOOTSTEP_ENERGY,
	FOOTSTEP_METAL,
	FOOTSTEP_SPLASH,

	FOOTSTEP_TOTAL
} footstep_t;

typedef enum {
	IMPACTSOUND_DEFAULT,
	IMPACTSOUND_METAL,
	IMPACTSOUND_FLESH
} impactSound_t;

//=================================================

// player entities need to track more information
// than any other type of entity.

// note that not every player entity is a client entity,
// because corpses after respawn are outside the normal
// client numbering range

// when changing animation, set animationTime to frameTime + lerping time
// The current lerp will finish out, then it will lerp to the new animation
typedef struct {
	int			oldFrame;
	int			oldFrameTime;		// time when ->oldFrame was exactly on

	int			frame;
	int			frameTime;			// time when ->frame will be exactly on

	float		backlerp;

	float		yawAngle;
	qboolean	yawing;
	float		pitchAngle;
	qboolean	pitching;

	int			animationNumber;	// may include ANIM_TOGGLEBIT
	animation_t	*animation;
	int			animationTime;		// time when the first frame of the animation will be exact

	int			clock;	// JUHOX: for speed scaling
} lerpFrame_t;


typedef struct {
	lerpFrame_t		legs, torso, flag;
	int				painTime;
	int				painDirection;	// flip from 0 to 1
	int				lightningFiring;

	// railgun trail spawning
	vec3_t			railgunImpact;
	qboolean		railgunFlash;

	// machinegun spinning
	float			barrelAngle;
	int				barrelTime;
	qboolean		barrelSpinning;
	// JUHOX: new machinegun spinning
#if 1
	float			mgAngle;
	int				mgTime;
	int				mgPhase;	// 0=stopped, 1=wind up, 2=spinning, 3=wind off
#endif
} playerEntity_t;

//=================================================


#if 1	// JUHOX: discharge flash definitions
#define MAX_DISCHARGE_FLASHES_PER_ENTITY 8

typedef struct {
	unsigned long seed;
	int lastChangeTime;
	int nextChangeTime;
} dischargeFlash_t;
#endif

// centity_t have a direct corespondence with gentity_t in the game, but
// only the entityState_t is directly communicated to the cgame
typedef struct centity_s {
	entityState_t	currentState;	// from cg.frame
	entityState_t	nextState;		// from cg.nextFrame, if available
	qboolean		interpolate;	// true if next is valid to interpolate to
	qboolean		currentValid;	// true if cg.frame holds this entity

	int				muzzleFlashTime;	// move to playerEntity?
	int				previousEvent;
	int				teleportFlag;

	int				trailTime;		// so missile trails can handle dropped initial packets
	int				dustTrailTime;
	int				miscTime;

	int				snapShotTime;	// last time this entity was found in a snapshot

	playerEntity_t	pe;

	int				errorTime;		// decay the error from this time
	vec3_t			errorOrigin;
	vec3_t			errorAngles;

	qboolean		extrapolated;	// false if origin / angles is an interpolation
	vec3_t			rawOrigin;
	vec3_t			rawAngles;

	vec3_t			beamEnd;

	// exact interpolated position of entity on this frame
	vec3_t			lerpOrigin;
	vec3_t			lerpAngles;

	int				dischargeTime;	// JUHOX
	int				deathTime;		// JUHOX

	dischargeFlash_t flashes[MAX_DISCHARGE_FLASHES_PER_ENTITY];	// JUHOX
	dischargeFlash_t gunFlash1;	// JUHOX
	dischargeFlash_t gunFlash2;	// JUHOX
} centity_t;


//======================================================================

// local entities are created as a result of events or predicted actions,
// and live independantly from all server transmitted entities

typedef struct markPoly_s {
	struct markPoly_s	*prevMark, *nextMark;
	int			time;
	qhandle_t	markShader;
	qboolean	alphaFade;		// fade alpha instead of rgb
	float		color[4];
	poly_t		poly;
	polyVert_t	verts[MAX_VERTS_ON_POLY];
} markPoly_t;


typedef enum {
	LE_MARK,
	LE_EXPLOSION,
	LE_SPRITE_EXPLOSION,
	LE_FRAGMENT,
	LE_MOVE_SCALE_FADE,
	LE_FALL_SCALE_FADE,
	LE_FADE_RGB,
	LE_SCALE_FADE,
	LE_SCOREPLUM,
	LE_BFGEXPL	// JUHOX
	,LE_TRAIL_PARTICLE	// JUHOX
#if MONSTER_MODE
	,LE_MOVE_SCALE_RGBFADE		// JUHOX
	,LE_FIREBALL_TRAIL_PARTICLE	// JUHOX
#endif
#ifdef MISSIONPACK
	LE_KAMIKAZE,
	LE_INVULIMPACT,
	LE_INVULJUICED,
	LE_SHOWREFENTITY
#endif
} leType_t;

typedef enum {
	LEF_PUFF_DONT_SCALE  = 0x0001,			// do not scale size over time
	LEF_TUMBLE			 = 0x0002,			// tumble over time, used for ejecting shells
	LEF_SOUND1			 = 0x0004,			// sound 1 for kamikaze
	LEF_SOUND2			 = 0x0008			// sound 2 for kamikaze
} leFlag_t;

typedef enum {
	LEMT_NONE,
	LEMT_BURN,
	LEMT_BLOOD
	// JUHOX: monster blood mark definition
#if MONSTER_MODE
	,LEMT_MONSTER_BLOOD
#endif
} leMarkType_t;			// fragment local entities can leave marks on walls

typedef enum {
	LEBS_NONE,
	LEBS_BLOOD,
	LEBS_BRASS
} leBounceSoundType_t;	// fragment local entities can make sounds on impacts

typedef struct localEntity_s {
	struct localEntity_s	*prev, *next;
	leType_t		leType;
	int				leFlags;

	int				startTime;
	int				endTime;
	int				fadeInTime;

	float			lifeRate;			// 1.0 / (endTime - startTime)

	trajectory_t	pos;
	trajectory_t	angles;

	// JUHOX: variables for EFH
#if ESCAPE_MODE
	centity_t*		lightingBase;
	vec3_t			baseMins;
	vec3_t			baseMaxs;
#endif

	float			bounceFactor;		// 0.0 = no bounce, 1.0 = perfect

	float			color[4];

	float			radius;

	float			light;
	vec3_t			lightColor;

	leMarkType_t		leMarkType;		// mark to leave on fragment impact
	leBounceSoundType_t	leBounceSoundType;

	refEntity_t		refEntity;
} localEntity_t;

//======================================================================


typedef struct {
	int				client;
	int				score;
	int				killed;	// JUHOX
	int				ping;
	int				time;
	int				scoreFlags;
	int				powerUps;
	int				accuracy;
	int				impressiveCount;
	int				excellentCount;
	int				guantletCount;
	int				defendCount;
	int				assistCount;
	int				captures;
	qboolean	perfect;
	int				team;
} score_t;

// each client has an associated clientInfo_t
// that contains media references necessary to present the
// client model and other color coded effects
// this is regenerated each time a client's configstring changes,
// usually as a result of a userinfo (name, model, etc) change
#define	MAX_CUSTOM_SOUNDS	32

typedef struct {
	qboolean		infoValid;

	char			name[MAX_QPATH];
	team_t			team;
	int				group;			// JUHOX
	tss_groupMemberStatus_t memberStatus;	// JUHOX
	int				pfmi;	// JUHOX: player flags stored in the modelindex
	qboolean		usesGlassCloaking;	// JUHOX
#if ESCAPE_MODE
	long			wayLength;	// JUHOX
#endif

	int				botSkill;		// 0 = not bot, 1-5 = bot

	vec3_t			color1;
	vec3_t			color2;

	int				score;			// updated by score servercmds
	int				location;		// location index for team mode
	int				health;			// you only get this info about your teammates
	int				armor;
	int				curWeapon;

	int				handicap;
	int				wins, losses;	// in tourney mode

	int				teamTask;		// task in teamplay (offence/defence)
	qboolean		teamLeader;		// true when this is a team leader

	int				powerups;		// so can display quad/flag status

	int				medkitUsageTime;
	int				invulnerabilityStartTime;
	int				invulnerabilityStopTime;

	int				breathPuffTime;

	// when clientinfo is changed, the loading of models/skins/sounds
	// can be deferred until you are dead, to prevent hitches in
	// gameplay
	char			modelName[MAX_QPATH];
	char			skinName[MAX_QPATH];
	char			headModelName[MAX_QPATH];
	char			headSkinName[MAX_QPATH];
	char			redTeam[MAX_TEAMNAME];
	char			blueTeam[MAX_TEAMNAME];
	qboolean		deferred;

	qboolean		newAnims;		// true if using the new mission pack animations
	qboolean		fixedlegs;		// true if legs yaw is always the same as torso yaw
	qboolean		fixedtorso;		// true if torso never changes yaw

	vec3_t			headOffset;		// move head in icon views
	footstep_t		footsteps;
	gender_t		gender;			// from model

	qhandle_t		legsModel;
	qhandle_t		legsSkin;

	qhandle_t		torsoModel;
	qhandle_t		torsoSkin;

	qhandle_t		headModel;
	qhandle_t		headSkin;

	qhandle_t		modelIcon;

	animation_t		animations[MAX_TOTALANIMATIONS];

	sfxHandle_t		sounds[MAX_CUSTOM_SOUNDS];
} clientInfo_t;


// each WP_* weapon enum has an associated weaponInfo_t
// that contains media references necessary to present the
// weapon and its effects
typedef struct weaponInfo_s {
	qboolean		registered;
	gitem_t			*item;

	qhandle_t		handsModel;			// the hands don't actually draw, they just position the weapon
	qhandle_t		weaponModel;
	qhandle_t		barrelModel;
	qhandle_t		flashModel;

	vec3_t			weaponMidpoint;		// so it will rotate centered instead of by tag

	float			flashDlight;
	vec3_t			flashDlightColor;
	sfxHandle_t		flashSound[4];		// fast firing weapons randomly choose

	qhandle_t		weaponIcon;
	qhandle_t		ammoIcon;

	qhandle_t		ammoModel;

	qhandle_t		missileModel;
	sfxHandle_t		missileSound;
	void			(*missileTrailFunc)( centity_t *, const struct weaponInfo_s *wi );
	float			missileDlight;
	vec3_t			missileDlightColor;
	int				missileRenderfx;

	void			(*ejectBrassFunc)( centity_t * );

	float			trailRadius;
	float			wiTrailTime;

	sfxHandle_t		readySound;
	sfxHandle_t		firingSound;
	qboolean		loopFireSound;
} weaponInfo_t;


// each IT_* item has an associated itemInfo_t
// that constains media references necessary to present the
// item and its effects
typedef struct {
	qboolean		registered;
	qhandle_t		models[MAX_ITEM_MODELS];
	qhandle_t		icon;
} itemInfo_t;


typedef struct {
	int				itemNum;
} powerupInfo_t;


#define MAX_SKULLTRAIL		10

typedef struct {
	vec3_t positions[MAX_SKULLTRAIL];
	int numpositions;
} skulltrail_t;


#define MAX_REWARDSTACK		10
#define MAX_SOUNDBUFFER		20

// JUHOX: definitions used for map lens flares
#if MAPLENSFLARES
#define MAX_LENSFLARE_EFFECTS 200
#define MAX_LENSFLARES_PER_EFFECT 32
typedef enum {
	LFM_reflexion,
	LFM_glare,
	LFM_star
} lensFlareMode_t;
typedef struct {
	qhandle_t shader;
	lensFlareMode_t mode;
	float pos;	// position at light axis
	float size;
	float rgba[4];
	float rotationOffset;
	float rotationYawFactor;
	float rotationPitchFactor;
	float rotationRollFactor;
	float fadeAngleFactor;		// for spotlights
	float entityAngleFactor;	// for spotlights
	float intensityThreshold;
} lensFlare_t;
typedef struct {
	char name[64];
	float range;
	float rangeSqr;
	float fadeAngle;	// for spotlights
	int numLensFlares;
	lensFlare_t lensFlares[MAX_LENSFLARES_PER_EFFECT];
} lensFlareEffect_t;

#define MAX_LIGHTS_PER_MAP 1024
#define LIGHT_INTEGRATION_BUFFER_SIZE 8	// must be a power of 2
typedef struct {
	float light;
	vec3_t origin;
} lightSample_t;
typedef struct {
	vec3_t origin;
	centity_t* lock;
	float radius;
	float lightRadius;
	vec3_t dir;		// for spotlights
	float angle;	// for spotlights
	float maxVisAngle;
	const lensFlareEffect_t* lfeff;
	int libPos;
	int libNumEntries;
	lightSample_t lib[LIGHT_INTEGRATION_BUFFER_SIZE];	// lib = light integration buffer
} lensFlareEntity_t;

typedef enum {
	LFEEM_none,
	LFEEM_pos,
	LFEEM_target,
	LFEEM_radius
} lfeEditMode_t;
typedef enum {
	LFEDM_normal,
	LFEDM_marks,
	LFEDM_none
} lfeDrawMode_t;
typedef enum {
	LFEMM_coarse,
	LFEMM_fine
} lfeMoveMode_t;
typedef enum {
	LFECS_small,
	LFECS_lightRadius,
	LFECS_visRadius
} lfeCursorSize_t;
typedef enum {
	LFECM_main,
	LFECM_copyOptions
} lfeCommandMode_t;

#define LFECO_EFFECT		1
#define LFECO_VISRADIUS		2
#define LFECO_LIGHTRADIUS	4
#define LFECO_SPOT_DIR		8
#define LFECO_SPOT_ANGLE	16

typedef struct {
	lensFlareEntity_t* selectedLFEnt;	// NULL = none
	lfeDrawMode_t drawMode;
	lfeEditMode_t editMode;
	lfeMoveMode_t moveMode;
	lfeCursorSize_t cursorSize;
	float fmm_distance;	// fmm = fine move mode
	vec3_t fmm_offset;	// fmm = fine move mode
	qboolean delAck;
	int selectedEffect;
	int markedLFEnt;	// -1 = none
	lensFlareEntity_t originalLFEnt;	// backup for undo
	int oldButtons;
	int lastClick;
	qboolean editTarget;
	vec3_t targetPosition;
	lfeCommandMode_t cmdMode;
	int copyOptions;
	lensFlareEntity_t copiedLFEnt;	// for copy / paste
	qboolean moversStopped;
	centity_t* selectedMover;
} lfEditor_t;
#endif

//======================================================================

// JUHOX: definitions used by the TSS client part
#if 1
#define TSSGROUPCOLOR_BLACK 0x000000
#define TSSGROUPCOLOR_WHITE 0xffffff
#define TSSGROUPCOLOR_YELLOW 0xffb821
#define TSSGROUPCOLOR_MINT 0xc0ffc0

typedef enum {
	TSSTM_no,
	TSSTM_YTS,	// your team size
	TSSTM_OTS,	// opp. team size
	TSSTM_BTS,	// team size balance [YTS - OTS]
	TSSTM_RSPD,	// respawn delay [0 ... 999]
	TSSTM_YAP,	// your team players alive, percentage [YAQ / YTS]
	TSSTM_YAQ,	// your team players alive, quantity
	TSSTM_OAP,	// opp. team players alive, percentage [OAQ / OTS]
	TSSTM_OAQ,	// opp. team players alive, quantity
	TSSTM_BAP,	// team alive balance, percentage [YAP - OAP]
	TSSTM_BAQ,	// team alive balance, quantity   [YAQ - OAQ]
	TSSTM_YAMP,	// your team players who may be alive for the medium-term future, percentage [YAMQ / YTS]
	TSSTM_YAMQ,	// your team players who may be alive for the medium-term future, quantity (may be fractional!)
	TSSTM_OAMP,	// opp. team players who may be alive for the medium-term future, percentage [OAMQ / OTS]
	TSSTM_OAMQ,	// opp. team players who may be alive for the medium-term future, quantity (may be fractional!)
	TSSTM_BAMP,	// team alive balance for the medium-term future, percentage [YAMP - OAMP]
	TSSTM_BAMQ,	// team alive balance for the medium-term future, quantity [YAMQ - OAMQ]
	TSSTM_YALP,	// your team players who may be alive for the long-term future, percentage [YALQ / YTS]
	TSSTM_YALQ,	// your team players who may be alive for the long-term future, quantity (may be fractional!)
	TSSTM_OALP,	// opp. team players who may be alive for the long-term future, percentage [OALQ / OTS]
	TSSTM_OALQ,	// opp. team players who may be alive for the long-term future, quantity (may be fractional!)
	TSSTM_BALP,	// team alive balance for the long-term future, percentage [YALP - OALP]
	TSSTM_BALQ,	// team alive balance for the long-term future, quantity [YALQ - OALQ]
	TSSTM_BAMT,	// team alive balance medium-term tendency [(BAMQ - BAQ) / (YTS + OTS)]	[-100% ... +100%]
	TSSTM_BALT,	// team alive balance long-term tendency [(BALQ - BAQ) / (YTS + OTS)]		[-100% ... +100%]
	TSSTM_RFAP,	// readiness for attack (of your team), percentage [RFAQ / YTS]
	TSSTM_RFAQ,	// readiness for attack (of your team), quantity
	TSSTM_RFDP,	// readiness for defence (of your team), percentage [RFDQ / YTS]
	TSSTM_RFDQ,	// readiness for defence (of your team), quantity
	TSSTM_FIN,	// fight intensity (of your team) [# of players involved in fighting / YAQ]
	TSSTM_TIDY,	// tidiness (of your team)
	TSSTM_AVST,	// average stamina (of your team)
	TSSTM_TIME,	// time left (in minutes) (max. 100, or 999 if no time limit)
	TSSTM_YRS,	// your team remaining score (max. 100, or 999 if no score limit)
	TSSTM_ORS,	// opp. team remaining score (max. 100, or 999 if no score limit)
	TSSTM_SCB,	// score balance (your score minus opp. score)
	TSSTM_YFS,	// your team flag status (not allowed for TDM strategies)
	TSSTM_OFS,	// opp. team flag status (not allowed for TDM strategies)
	TSSTM_YFP,	// your flag position (not allowed for TDM strategies) [-100% ... +100%], -100=at enemy base, +100=at home base
	TSSTM_OFP,	// opp. flag position (not allowed for TDM strategies) [-100% ... +100%], -100=at enemy base, +100=at home base
	TSSTM_num_magnitudes
} tss_tacticalMagnitude_t;

typedef struct {
	int var[TSSTM_num_magnitudes];
} tss_tacticalMeasures_t;

typedef enum {
	TSSPROP_varLowerThanLimit,
	TSSPROP_varLowerThanOrEqualToLimit,
	TSSPROP_varHigherThanOrEqualToLimit,
	TSSPROP_varHigherThanLimit,
	TSSPROP_varEqualToLimit,
	TSSPROP_varUnequalToLimit,
	TSSPROP_num_operators
} tss_tacticalPredicate_operator_t;

typedef enum {
	TSSFS_atBase,
	TSSFS_dropped,
	TSSFS_taken
} tss_flagStatus_t;

typedef struct tss_tacticalPredicate_s {
	tss_tacticalMagnitude_t magnitude;
	tss_tacticalPredicate_operator_t op;
	int limit;
} tss_tacticalPredicate_t;

typedef struct tss_clause_s {
	qboolean inUse;
	tss_tacticalPredicate_t predicate[TSS_PREDICATES_PER_CLAUSE];
} tss_clause_t;

typedef struct tss_occasion_s {
	tss_clause_t clause[TSS_CLAUSES_PER_OCCASION];
} tss_occasion_t;

typedef enum {
	DM_quantity = 1,
	DM_percentage
} tss_divisionMode_t;

typedef struct tss_directive_s {
	qboolean inUse;
	char name[TSS_NAME_SIZE];
	tss_occasion_t occasion;
	tss_instructions_t instr;
} tss_directive_t;

#define TSS_STRATEGY_VERSION 1
typedef struct tss_strategy_s {
	char id[4];							// 'HUNT'
	int version;						// TSS_STRATEGY_VERSION
	int gametype;
	char generic[16];
	char name[TSS_NAME_SIZE];
	char comment[64];
	int autoCondition;
	int rfa_dangerLimit;				// -100 ... +100
	int rfd_dangerLimit;				// -100 ... +100
	int short_term;						// % of respawn delay, currently unused
	int medium_term;					// % of respawn delay
	int long_term;						// % of respawn delay
	tss_directive_t directives[27];
} tss_strategy_t;

typedef enum {
	SSO_creationTime,
	SSO_accessTime,
	SSO_name_creationTime,
	SSO_name_accessTime,
	SSO_searchResult,

	SSO_num_orders
} tss_strategySortOrder_t;

typedef struct {
	qboolean isChanged;
	tss_strategySlot_t* slot;
	tss_strategy_t* strategy;
	int strategyBufHandle;
	int condition;	// for utilized strategy
	int directive;	// for selected strategy
} tss_strategyPaletteSlot_t;

#define TSS_MAX_STRATEGIES_PER_PALETTE 26
typedef struct {
	int numEntries;
	tss_strategyPaletteSlot_t slots[TSS_MAX_STRATEGIES_PER_PALETTE];
} tss_strategyPalette_t;

typedef struct {
	int utilizedStrategy;
	int selectedStrategy;
	int numEntries;
	int palette[TSS_MAX_STRATEGIES_PER_PALETTE];
} tss_savedPalette_t;

#if TSSINCVAR
typedef struct {
	unsigned int creationTime;
	unsigned int accessTime;
	char filename[TSS_NAME_SIZE];
} tss_packedStrategySlot_t;
typedef struct {
	tss_savedPalette_t palette;
	tss_packedStrategySlot_t slots[TSS_MAX_STRATEGIES];
} tss_packedStrategyStock_t;
#endif

typedef enum {
	TSSFS_success,
	TSSFS_not_found,
	TSSFS_too_large
} tssfs_status_t;
typedef void (*tssfs_callback_t)(const char* path, void* buffer, int len, tssfs_status_t status);
#endif

// all cg.stepTime, cg.duckTime, cg.landTime, etc are set to cg.time when the action
// occurs, and they will have visible effects for #define STEP_TIME or whatever msec after

#define MAX_PREDICTED_EVENTS	16

#if EARTHQUAKE_SYSTEM	// JUHOX: definitions
typedef struct {
	vec3_t origin;
	float radius;	// negative for global earthquakes
	float amplitude;
	int startTime;
	int endTime;
	int fadeInTime;
	int fadeOutTime;
} earthquake_t;
#define MAX_EARTHQUAKES 64
#endif

typedef struct {
	int			clientFrame;		// incremented each frame

	int			clientNum;

	qboolean	demoPlayback;
	qboolean	levelShot;			// taking a level menu screenshot
	int			deferredPlayerLoading;
	qboolean	loading;			// don't defer players at initial startup
	qboolean	intermissionStarted;	// don't play voice rewards, because game will end shortly

	// there are only one or two snapshot_t that are relevent at a time
	int			latestSnapshotNum;	// the number of snapshots the client system has received
	int			latestSnapshotTime;	// the time from latestSnapshotNum, so we don't need to read the snapshot yet

	snapshot_t	*snap;				// cg.snap->serverTime <= cg.time
	snapshot_t	*nextSnap;			// cg.nextSnap->serverTime > cg.time, or NULL
	snapshot_t	activeSnapshots[2];

#if ESCAPE_MODE	// JUHOX: variables for EFH
	int			currentReferenceX;
	int			currentReferenceY;
	int			currentReferenceZ;
	int			nextReferenceX;
	int			nextReferenceY;
	int			nextReferenceZ;
	vec3_t		referenceDelta;		// JUHOX: from nextSnap to snap origins
	int			countDown;
#endif

#if SPECIAL_VIEW_MODES	// JUHOX: variables
	viewMode_t	viewMode;
	int			viewModeSwitchingTime;	// start time
	int			scannerActivationTime;
#endif

	float		frameInterpolation;	// (float)( cg.time - cg.frame->serverTime ) / (cg.nextFrame->serverTime - cg.frame->serverTime)

	qboolean	thisFrameTeleport;
	qboolean	nextFrameTeleport;

	int			frametime;		// cg.time - cg.oldTime

	int			time;			// this is the time value that the client
								// is rendering at.
	int			oldTime;		// time at last frame, used for missile trails and prediction checking

	int			physicsTime;	// either cg.snap->time or cg.nextSnap->time

	int			timelimitWarnings;	// 5 min, 1 min, overtime
	int			fraglimitWarnings;

	qboolean	mapRestart;			// set on a map restart to set back the weapon

	qboolean	renderingThirdPerson;		// during deaths, chasecams, etc

	// prediction state
	qboolean	hyperspace;				// true if prediction has hit a trigger_teleport
	playerState_t	predictedPlayerState;
	centity_t		predictedPlayerEntity;
	qboolean	validPPS;				// clear until the first call to CG_PredictPlayerState
	int			predictedErrorTime;
	vec3_t		predictedError;

	int			eventSequence;
	int			predictableEvents[MAX_PREDICTED_EVENTS];

	float		stepChange;				// for stair up smoothing
	int			stepTime;

	float		duckChange;				// for duck viewheight smoothing
	int			duckTime;

	float		landChange;				// for landing hard
	int			landTime;

	// input state sent to server
	int			weaponSelect;

	qboolean	weaponManuallySet;		// JUHOX: if qtrue, don't auto switch weapon
	qboolean	weaponOrderActive;		// JUHOX: if qfalse, don't use weapon orders
	int			currentWeaponOrder;		// JUHOX

	// auto rotating items
	vec3_t		autoAngles;
	vec3_t		autoAxis[3];
	vec3_t		autoAnglesFast;
	vec3_t		autoAxisFast[3];

	// view rendering
	refdef_t	refdef;
	vec3_t		refdefViewAngles;		// will be converted to refdef.viewaxis

#if MAPLENSFLARES	// JUHOX: variables for map lens flares
	vec3_t		lastViewOrigin;
	float		viewMovement;
	int			numFramesWithoutViewMovement;
#endif

#if MAPLENSFLARES	// JUHOX: lens flare editor variables
	lfEditor_t lfEditor;
#endif

#if MONSTER_MODE	// JUHOX: earthquake variables (STU)
	int earthquakeStartedTime;
	int earthquakeEndTime;
	float earthquakeAmplitude;
	int earthquakeFadeInTime;
	int earthquakeFadeOutTime;
	int earthquakeSoundCounter;
	int lastEarhquakeSoundStartedTime;
#endif

#if EARTHQUAKE_SYSTEM	// JUHOX: earthquake variables
	earthquake_t earthquakes[MAX_EARTHQUAKES];
	float additionalTremble;
#endif

#if MONSTER_MODE	// JUHOX: STU end sequence script variables
	int endPhaseTime;
	int endPhaseLastDischargeSoundTime;
#endif

#if MONSTER_MODE	// JUHOX: STU artefact detector variables
	int lastDetectorCheckTime;
	float detector;
	int detectorBeepTime;
#endif

	// zoom key
	qboolean	zoomed;
	int			zoomTime;
	float		zoomSensitivity;

	// information screen text during loading
	char		infoScreenText[MAX_STRING_CHARS];

	// scoreboard
	int			scoresRequestTime;
	int			numScores;
	int			selectedScore;
	int			teamScores[2];
	score_t		scores[MAX_CLIENTS];
	qboolean	showScores;
	qboolean	scoreBoardShowing;
	int			scoreFadeTime;
	char		killerName[MAX_NAME_LENGTH];
	char			spectatorList[MAX_STRING_CHARS];		// list of names
	int				spectatorLen;												// length of list
	float			spectatorWidth;											// width in device units
	int				spectatorTime;											// next time to offset
	int				spectatorPaintX;										// current paint x
	int				spectatorPaintX2;										// current paint x
	int				spectatorOffset;										// current offset from start
	int				spectatorPaintLen; 									// current offset from start
	qboolean	intermissionMusicStarted;	// JUHOX
	int			oldRespawnTimer;			// JUHOX

	// skull trails
	skulltrail_t	skulltrails[MAX_CLIENTS];

	// centerprinting
	int			centerPrintTime;
	int			centerPrintCharWidth;
	int			centerPrintY;
	char		centerPrint[1024];
	int			centerPrintLines;

	// low ammo warning state
	int			lowAmmoWarning;		// 1 = low, 2 = empty

	// kill timers for carnage reward
	int			lastKillTime;

	// crosshair client ID
	int			crosshairClientNum;
	int			crosshairClientTime;

	// powerup active flashing
	int			powerupActive;
	int			powerupTime;

	// attacking player
	int			attackerTime;
	int			voiceTime;

	// reward medals
	int			rewardStack;
	int			rewardTime;
	int			rewardCount[MAX_REWARDSTACK];
	qhandle_t	rewardShader[MAX_REWARDSTACK];
	qhandle_t	rewardSound[MAX_REWARDSTACK];

	// sound buffer mainly for announcer sounds
	int			soundBufferIn;
	int			soundBufferOut;
	int			soundTime;
	qhandle_t	soundBuffer[MAX_SOUNDBUFFER];

	// for voice chat buffer
	int			voiceChatTime;
	int			voiceChatBufferIn;
	int			voiceChatBufferOut;

	// warmup countdown
	int			warmup;
	int			warmupCount;

	//==========================

	int			itemPickup;
	int			itemPickupTime;
	int			itemPickupBlendTime;	// the pulse around the crosshair is timed seperately

	int			weaponSelectTime;
	int			weaponAnimation;
	int			weaponAnimationTime;

	// blend blobs
	float		damageTime;
	float		damageX, damageY, damageValue;

	// status bar head
	float		headYaw;
	float		headEndPitch;
	float		headEndYaw;
	int			headEndTime;
	float		headStartPitch;
	float		headStartYaw;
	int			headStartTime;

	// view movement
	float		v_dmg_time;
	float		v_dmg_pitch;
	float		v_dmg_roll;

	vec3_t		kick_angles;	// weapon kicks
	vec3_t		kick_origin;

	// temp working variables for player view
	float		bobfracsin;
	int			bobcycle;
	float		xyspeed;
	int     nextOrbitTime;

	// JUHOX: variables for the TSS interface
#if 1
	int tssGametype;
#if !TSSINCVAR
	qboolean tssPureServer;
#endif
	qboolean tssInterfaceOn;
	int tssLastUpdate;
	int tssPrintCol;
	int tssPrintLine;
	int tssCursorCol;
	int tssCursorLine;
	int tssCursorLineEnd;
	char* tssCurrentTextField;
	int* tssCurrentValue;
	qboolean* tssCurrentValueChanged;
	qboolean* tssCurrentTextFieldChanged;
	int tssButtonID;
	int tssCurrentValueMin;	// lowest valid value
	int tssCurrentValueMax;	// highest valid value
	qboolean tssCurrentValueReversedHome;
	int tssCurrentParStartCol;
	int tssCurrentParWidth;
	int tssNextValueCol;
	int tssNextValueLine;
	int tssPrevValueCol;
	int tssPrevValueLine;
	int tssMouseX;
	int tssMouseY;

	int tssKeyEventSeq;
	int tssMouseEventSeq;

	int tssCallVoteLeader;
	char tssTeamLeaderName[16];
	qboolean tssOnline;	// only valid for mission leader
	qboolean tssActivated;
	qboolean tssNavAid;
	qboolean tssGroupLeaderAuthorization;
	tss_groupFormation_t tssGroupFormation;
	qboolean tssInspectMagnitude[TSSTM_num_magnitudes];	// add this magnitude to the HUD

	int tssNumTeamMates;
	char tssTeamMateNames[MAX_CLIENTS][16];
	const char* tssTeamMateList[MAX_CLIENTS];
	int tssTeamMatesClientNum[MAX_CLIENTS];
	int tssNumEnemies;
	int tssNumTeamMatesAlive;	// only valid for mission leader
	int tssNumEnemiesAlive;		// only valid for mission leader

	int tssGroupLeader[3][MAX_GROUPS];
	qboolean tssMultiMandate[3][MAX_GROUPS];

	// values received from tss server update
	int tssYFP;
	int tssOFP;
	int tssTidiness;
	int tssAvgStamina;
	int tssFightIntensity;
	int tssRespawnDelay;
	int tssRFAQ;
	int tssRFDQ;
	float tssYAMQ;
	float tssYALQ;
	float tssOAMQ;
	float tssOALQ;
	int tssCurrentLeader[MAX_GROUPS];
	int tssCurrentTotal[MAX_GROUPS];
	int tssCurrentAlive[MAX_GROUPS];
	int tssCurrentReady[MAX_GROUPS];

	tss_tacticalMeasures_t tssMeasures;
	tss_directive_t tssDirectiveClipboard;
	tss_strategyPaletteSlot_t* tssUtilizedStrategy;	// may be NULL
	tss_strategyPaletteSlot_t* tssSelectedStrategy;	// NULL if tssPalette empty
	tss_strategyPalette_t tssPalette;	// may be empty
	int tssStrategyStockScrollOffset;
	tss_strategySortOrder_t tssStrategyStockSortOrder;
	tss_tacticalMagnitude_t tssCurrentMagnitude;
	int tssGroupOrderController[MAX_GROUPS];
	tss_divisionMode_t tssDivisionMode;
	tss_division_t tssAbsoluteDivision;
	tss_strategy_t tssStrategyWorkCopy;
	qboolean tssStrategyWorkCopyChanged;
	int tssServerUpdateTime;
	qboolean tssSavingNeeded;

	int tssCreationClock;
	int tssAccessClock;

	int tssAutoGLCUpdateTime;
#endif

	// JUHOX: variables for the nav aid
#if 1
	int navAidStopTime;	// 0 if no nav aid to draw
	int navAidLatestUpdateTime;
	qboolean navAidRetreat;
	int navAidPacketTime[NAVAID_PACKETS];
	int navAidPacketNumPos[NAVAID_PACKETS];
	vec3_t navAidPacketPos[NAVAID_PACKETS][8];
	vec3_t navAidGoal;
	qboolean navAidGoalAvailable;
	int navAidGoalEntityNum;
	centity_t* navAidGoalEntity;
#endif

	//qboolean cameraMode;		// if rendering from a loaded camera

	// development tool
	refEntity_t		testModelEntity;
	char			testModelName[MAX_QPATH];
	qboolean		testGun;

#if SCREENSHOT_TOOLS
	int stopTime;	// JUHOX
	int timeOffset;	// JUHOX
	int serverOffset;	// JUHOX
#endif
} cg_t;


// all of the model, shader, and sound references that are
// loaded at gamestate time are stored in cgMedia_t
// Other media that can be tied to clients, weapons, or items are
// stored in the clientInfo_t, itemInfo_t, weaponInfo_t, and powerupInfo_t
typedef struct {
	// JUHOX: new charsetShader
#if 0
	qhandle_t	charsetShader;
#else
	qhandle_t	oldCharsetShader;
	qhandle_t	charsetShaders[8];
#endif
	qhandle_t	charsetProp;
	qhandle_t	charsetPropGlow;
	qhandle_t	charsetPropB;
	qhandle_t	whiteShader;

	// JUHOX: nearbox shaders
#if 1
	//qhandle_t	nearbox_up;
	qhandle_t	nearbox_dn;
	qhandle_t	nearbox_ft;
	qhandle_t	nearbox_bk;
	qhandle_t	nearbox_lf;
	qhandle_t	nearbox_rt;
#endif

	qhandle_t	redCubeModel;
	qhandle_t	blueCubeModel;
	qhandle_t	redCubeIcon;
	qhandle_t	blueCubeIcon;
	qhandle_t	redFlagModel;
	qhandle_t	blueFlagModel;
	qhandle_t	neutralFlagModel;
	qhandle_t	redFlagShader[3];
	qhandle_t	blueFlagShader[3];
	qhandle_t	flagShader[4];

	qhandle_t	flagPoleModel;
	qhandle_t	flagFlapModel;

	qhandle_t	redFlagFlapSkin;
	qhandle_t	blueFlagFlapSkin;
	qhandle_t	neutralFlagFlapSkin;

	qhandle_t	redFlagBaseModel;
	qhandle_t	blueFlagBaseModel;
	qhandle_t	neutralFlagBaseModel;

#ifdef MISSIONPACK
	qhandle_t	overloadBaseModel;
	qhandle_t	overloadTargetModel;
	qhandle_t	overloadLightsModel;
	qhandle_t	overloadEnergyModel;

	qhandle_t	harvesterModel;
	qhandle_t	harvesterRedSkin;
	qhandle_t	harvesterBlueSkin;
	qhandle_t	harvesterNeutralModel;
#endif

	qhandle_t	armorModel;
	qhandle_t	armorIcon;

	qhandle_t	teamStatusBar;

	qhandle_t	deferShader;

	// gib explosions
	qhandle_t	gibAbdomen;
	qhandle_t	gibArm;
	qhandle_t	gibChest;
	qhandle_t	gibFist;
	qhandle_t	gibFoot;
	qhandle_t	gibForearm;
	qhandle_t	gibIntestine;
	qhandle_t	gibLeg;
	qhandle_t	gibSkull;
	qhandle_t	gibBrain;
#if MONSTER_MODE
	qhandle_t	monsterGibsShader;	// JUHOX
#endif

	qhandle_t	smoke2;

	qhandle_t	machinegunBrassModel;
	qhandle_t	shotgunBrassModel;

	qhandle_t	railRingsShader;
	qhandle_t	railCoreShader;

	qhandle_t	lightningShader;
	qhandle_t	grappleShader;			// JUHOX
	qhandle_t	dischargeFlashShader;	// JUHOX
	qhandle_t	navaidShader;			// JUHOX
	qhandle_t	navaid2Shader;			// JUHOX
	qhandle_t	navaidTargetShader;		// JUHOX
	qhandle_t	navaidGoalShader;		// JUHOX
	qhandle_t	glassCloakingShader;	// JUHOX
	qhandle_t	glassCloakingSpecShader;// JUHOX
	// JUHOX: shaders for new spawn effect
#if 1
	qhandle_t	spawnHullShader;
	qhandle_t	spawnHullGlow1Shader;
	qhandle_t	spawnHullGlow2Shader;
	qhandle_t	spawnHullGlow3Shader;
	qhandle_t	spawnHullGlow4Shader;
	qhandle_t	spawnHullWeaponShader;
	qhandle_t	spawnHullGlow1WeaponShader;
	qhandle_t	spawnHullGlow2WeaponShader;
	qhandle_t	spawnHullGlow3WeaponShader;
	qhandle_t	spawnHullGlow4WeaponShader;
#endif

	// JUHOX: HUD shaders
#if 1
	qhandle_t	fightInProgressShader;
#if MONSTER_MODE
	qhandle_t	artefactsShader;
	qhandle_t	lifesShader;
	qhandle_t	clockShader;
	qhandle_t	detectorShader;
#endif
#endif

	qhandle_t	huntNameShader;	// JUHOX

	qhandle_t	deathBlurryShader;	// JUHOX
	qhandle_t	podSkullSkin;			// JUHOX
#if SPECIAL_VIEW_MODES
	qhandle_t	scannerShader;		// JUHOX
	qhandle_t	amplifierShader;	// JUHOX
#endif

	qhandle_t	friendShader;

	qhandle_t	balloonShader;
	qhandle_t	connectionShader;

	qhandle_t	selectShader;
	qhandle_t	viewBloodShader;
	qhandle_t	tracerShader;
	qhandle_t	crosshairShader[NUM_CROSSHAIRS];
	qhandle_t	lagometerShader;
	qhandle_t	backTileShader;
	qhandle_t	noammoShader;

	qhandle_t	smokePuffShader;
	qhandle_t	smokePuffRageProShader;
	qhandle_t	shotgunSmokePuffShader;
	qhandle_t	plasmaBallShader;
	qhandle_t	waterBubbleShader;
	qhandle_t	bloodTrailShader;
	qhandle_t	monsterBloodTrail1Shader;	// JUHOX
	qhandle_t	monsterBloodTrail2Shader;	// JUHOX
	qhandle_t	monsterBloodExplosionShader;	// JUHOX
#ifdef MISSIONPACK
	qhandle_t	nailPuffShader;
	qhandle_t	blueProxMine;
#endif
	qhandle_t	bfgLFGlareShader;	// JUHOX
	qhandle_t	bfgLFDiscShader;	// JUHOX
	qhandle_t	bfgLFRingShader;	// JUHOX
	qhandle_t	bfgLFLineShader;	// JUHOX
	qhandle_t	bfgLFStarShader;	// JUHOX
	qhandle_t	bfgSuperExplShader;	// JUHOX
#if MONSTER_MODE
	qhandle_t	hotAirShader;		// JUHOX
#endif

	qhandle_t	numberShaders[11];

	qhandle_t	shadowMarkShader;

	qhandle_t	botSkillShaders[5];

	// wall mark shaders
	qhandle_t	wakeMarkShader;
	qhandle_t	bloodMarkShader;
	qhandle_t	monsterBloodMarkShader;	// JUHOX
	qhandle_t	bulletMarkShader;
	qhandle_t	burnMarkShader;
	qhandle_t	holeMarkShader;
	qhandle_t	energyMarkShader;

	// powerup shaders
	qhandle_t	quadShader;
	qhandle_t	redQuadShader;
	qhandle_t	quadWeaponShader;
	qhandle_t	invisShader;
	qhandle_t	regenShader;
	qhandle_t	battleSuitShader;
	qhandle_t	battleWeaponShader;
	qhandle_t	hastePuffShader;
	qhandle_t	redKamikazeShader;
	qhandle_t	blueKamikazeShader;
	qhandle_t	chargeShader;		// JUHOX
	qhandle_t	chargeWeaponShader;	// JUHOX
	qhandle_t	blueInvis;			// JUHOX
	qhandle_t	redInvis;			// JUHOX
	qhandle_t	targetMarker;		// JUHOX
	qhandle_t	bfgReloadingShader;	// JUHOX
	qhandle_t	shieldShader;		// JUHOX
	qhandle_t	shieldWeaponShader;	// JUHOX

	// weapon effect models
	qhandle_t	bulletFlashModel;
	qhandle_t	ringFlashModel;
	qhandle_t	dishFlashModel;
	qhandle_t	lightningExplosionModel;

	// weapon effect shaders
	qhandle_t	railExplosionShader;
	qhandle_t	plasmaExplosionShader;
	qhandle_t	bulletExplosionShader;
	qhandle_t	rocketExplosionShader;
	qhandle_t	grenadeExplosionShader;
	qhandle_t	bfgExplosionShader;
	qhandle_t	bloodExplosionShader;
#if MONSTER_MODE
	qhandle_t	monsterSeedMetalShader;	// JUHOX
	qhandle_t	monsterLauncherShader;	// JUHOX
#endif

	// special effects models
	qhandle_t	teleportEffectModel;
	qhandle_t	teleportEffectShader;
#ifdef MISSIONPACK
	qhandle_t	kamikazeEffectModel;
	qhandle_t	kamikazeShockWave;
	qhandle_t	kamikazeHeadModel;
	qhandle_t	kamikazeHeadTrail;
	qhandle_t	guardPowerupModel;
	qhandle_t	scoutPowerupModel;
	qhandle_t	doublerPowerupModel;
	qhandle_t	ammoRegenPowerupModel;
	qhandle_t	invulnerabilityImpactModel;
	qhandle_t	invulnerabilityJuicedModel;
	qhandle_t	medkitUsageModel;
	qhandle_t	dustPuffShader;
	qhandle_t	heartShader;
#endif
	qhandle_t	invulnerabilityPowerupModel;

	// scoreboard headers
	qhandle_t	scoreboardName;
	qhandle_t	scoreboardPing;
	qhandle_t	scoreboardScore;
	qhandle_t	scoreboardTime;

	// medals shown during gameplay
	qhandle_t	medalImpressive;
	qhandle_t	medalExcellent;
	qhandle_t	medalGauntlet;
	qhandle_t	medalDefend;
	qhandle_t	medalAssist;
	qhandle_t	medalCapture;

	// JUHOX: sprites used to mark group members
#if 1
	qhandle_t	groupTemporary;
	qhandle_t	groupDesignated;
	qhandle_t	groupMarks[MAX_GROUPS];
#endif

	// sounds
	sfxHandle_t	silence;	// JUHOX
	sfxHandle_t	quadSound;
	sfxHandle_t	tracerSound;
	sfxHandle_t	selectSound;
	sfxHandle_t	useNothingSound;
	sfxHandle_t	wearOffSound;
	sfxHandle_t	footsteps[FOOTSTEP_TOTAL][4];
	sfxHandle_t	sfx_lghit1;
	sfxHandle_t	sfx_lghit2;
	sfxHandle_t	sfx_lghit3;
	sfxHandle_t	sfx_ric1;
	sfxHandle_t	sfx_ric2;
	sfxHandle_t	sfx_ric3;
	sfxHandle_t	sfx_railg;
	sfxHandle_t	sfx_rockexp;
	sfxHandle_t	sfx_plasmaexp;
#ifdef MISSIONPACK
	sfxHandle_t	sfx_proxexp;
	sfxHandle_t	sfx_nghit;
	sfxHandle_t	sfx_nghitflesh;
	sfxHandle_t	sfx_nghitmetal;
	sfxHandle_t	sfx_chghit;
	sfxHandle_t	sfx_chghitflesh;
	sfxHandle_t	sfx_chghitmetal;
	sfxHandle_t kamikazeExplodeSound;
	sfxHandle_t kamikazeImplodeSound;
	sfxHandle_t kamikazeFarSound;
	sfxHandle_t useInvulnerabilitySound;
	sfxHandle_t invulnerabilityImpactSound1;
	sfxHandle_t invulnerabilityImpactSound2;
	sfxHandle_t invulnerabilityImpactSound3;
	sfxHandle_t invulnerabilityJuicedSound;
	sfxHandle_t obeliskHitSound1;
	sfxHandle_t obeliskHitSound2;
	sfxHandle_t obeliskHitSound3;
	sfxHandle_t	obeliskRespawnSound;
	sfxHandle_t	winnerSound;
	sfxHandle_t	loserSound;
	sfxHandle_t	youSuckSound;
#endif
	sfxHandle_t	gibSound;
	sfxHandle_t	gibBounce1Sound;
	sfxHandle_t	gibBounce2Sound;
	sfxHandle_t	gibBounce3Sound;
	sfxHandle_t	teleInSound;
	sfxHandle_t	teleOutSound;
	sfxHandle_t	noAmmoSound;
	sfxHandle_t	respawnSound;
	sfxHandle_t talkSound;
	sfxHandle_t landSound;
	sfxHandle_t fallSound;
	sfxHandle_t jumpPadSound;
	sfxHandle_t overkillSound;			// JUHOX
	sfxHandle_t exterminatedSound;		// JUHOX
	// JUHOX: the respawn warn sound handle (also used for EFH)
#if RESPAWN_DELAY || ESCAPE_MODE
	sfxHandle_t respawnWarnSound;
#endif
	sfxHandle_t tssBeepSound;			// JUHOX
	sfxHandle_t dischargeFlashSound;	// JUHOX
	sfxHandle_t malePantSound;			// JUHOX
	sfxHandle_t femalePantSound;		// JUHOX
	sfxHandle_t neuterPantSound;		// JUHOX
	sfxHandle_t bounceArmorSoundA1;		// JUHOX
	sfxHandle_t bounceArmorSoundA2;		// JUHOX
	sfxHandle_t bounceArmorSoundA3;		// JUHOX
	sfxHandle_t bounceArmorSoundB1;		// JUHOX
	sfxHandle_t bounceArmorSoundB2;		// JUHOX
	sfxHandle_t bounceArmorSoundB3;		// JUHOX
#if GRAPPLE_ROPE
	sfxHandle_t grappleShotSound;		// JUHOX
	sfxHandle_t grappleThrowSound;		// JUHOX
	sfxHandle_t ropeExplosionSound;		// JUHOX
	sfxHandle_t grappleWindOffSound;	// JUHOX
	sfxHandle_t	grappleRewindSound;		// JUHOX
	sfxHandle_t grapplePullingSound;	// JUHOX
	sfxHandle_t grappleBlockingSound;	// JUHOX
#endif
	// JUHOX: monster sounds
#if MONSTER_MODE
	sfxHandle_t	earthquakeSound;
	sfxHandle_t	lastArtefactSound;
	sfxHandle_t guardStartSound;
	sfxHandle_t detectorBeepSound;
	sfxHandle_t seedBounceSound[3][8];
	sfxHandle_t titanFootstepSound;		// JUHOX
#endif

	sfxHandle_t oneMinuteSound;
	sfxHandle_t fiveMinuteSound;
	sfxHandle_t suddenDeathSound;

	sfxHandle_t threeFragSound;
	sfxHandle_t twoFragSound;
	sfxHandle_t oneFragSound;

	sfxHandle_t hitSound;
	sfxHandle_t hitSoundHighArmor;
	sfxHandle_t hitSoundLowArmor;
	sfxHandle_t hitTeamSound;
	sfxHandle_t impressiveSound;
	sfxHandle_t excellentSound;
	sfxHandle_t deniedSound;
	sfxHandle_t humiliationSound;
	sfxHandle_t assistSound;
	sfxHandle_t defendSound;
	sfxHandle_t firstImpressiveSound;
	sfxHandle_t firstExcellentSound;
	sfxHandle_t firstHumiliationSound;

	sfxHandle_t takenLeadSound;
	sfxHandle_t tiedLeadSound;
	sfxHandle_t lostLeadSound;

	sfxHandle_t voteNow;
	sfxHandle_t votePassed;
	sfxHandle_t voteFailed;

	sfxHandle_t watrInSound;
	sfxHandle_t watrOutSound;
	sfxHandle_t watrUnSound;

	sfxHandle_t flightSound;
	sfxHandle_t medkitSound;

	sfxHandle_t weaponHoverSound;

	// teamplay sounds
	sfxHandle_t captureAwardSound;
	sfxHandle_t redScoredSound;
	sfxHandle_t blueScoredSound;
	sfxHandle_t redLeadsSound;
	sfxHandle_t blueLeadsSound;
	sfxHandle_t teamsTiedSound;

	sfxHandle_t	captureYourTeamSound;
	sfxHandle_t	captureOpponentSound;
	sfxHandle_t	returnYourTeamSound;
	sfxHandle_t	returnOpponentSound;
	sfxHandle_t	takenYourTeamSound;
	sfxHandle_t	takenOpponentSound;

	sfxHandle_t redFlagReturnedSound;
	sfxHandle_t blueFlagReturnedSound;
	sfxHandle_t neutralFlagReturnedSound;
	sfxHandle_t	enemyTookYourFlagSound;
	sfxHandle_t	enemyTookTheFlagSound;
	sfxHandle_t yourTeamTookEnemyFlagSound;
	sfxHandle_t yourTeamTookTheFlagSound;
	sfxHandle_t	youHaveFlagSound;
	sfxHandle_t yourBaseIsUnderAttackSound;
	sfxHandle_t holyShitSound;

	// tournament sounds
	sfxHandle_t	count3Sound;
	sfxHandle_t	count2Sound;
	sfxHandle_t	count1Sound;
	sfxHandle_t	countFightSound;
	sfxHandle_t	countPrepareSound;

#ifdef MISSIONPACK
	// new stuff
	qhandle_t patrolShader;
	qhandle_t assaultShader;
	qhandle_t campShader;
	qhandle_t followShader;
	qhandle_t defendShader;
	qhandle_t teamLeaderShader;
	qhandle_t retrieveShader;
	qhandle_t escortShader;
	qhandle_t flagShaders[3];
	sfxHandle_t	countPrepareTeamSound;

	sfxHandle_t ammoregenSound;
	sfxHandle_t doublerSound;
	sfxHandle_t guardSound;
	sfxHandle_t scoutSound;
#endif
	qhandle_t cursor;
	qhandle_t selectCursor;
	qhandle_t sizeCursor;

	sfxHandle_t	regenSound;
	sfxHandle_t	protectSound;
	sfxHandle_t	n_healthSound;
	sfxHandle_t	hgrenb1aSound;
	sfxHandle_t	hgrenb2aSound;
	// JUHOX: the following sounds only needed for missionpack
#if 0
	sfxHandle_t	wstbimplSound;
	sfxHandle_t	wstbimpmSound;
	sfxHandle_t	wstbimpdSound;
	sfxHandle_t	wstbactvSound;
#endif

} cgMedia_t;


// The client game static (cgs) structure hold everything
// loaded or calculated from the gamestate.  It will NOT
// be cleared when a tournement restart is done, allowing
// all clients to begin playing instantly
typedef struct {
	gameState_t		gameState;			// gamestate from server
	glconfig_t		glconfig;			// rendering configuration
	float			screenXScale;		// derived from glconfig
	float			screenYScale;
	float			screenXBias;

	int				serverCommandSequence;	// reliable command stream counter
	int				processedSnapshotNum;// the number of snapshots cgame has requested

	qboolean		localServer;		// detected on startup by checking sv_running

	// parsed from serverinfo
	gametype_t		gametype;
	int				dmflags;
	int				teamflags;
	int				fraglimit;
	int				capturelimit;
	int				timelimit;
	int				maxclients;
	char			mapname[MAX_QPATH];
	char			redTeam[MAX_QPATH];
	char			blueTeam[MAX_QPATH];
	int				record;		// JUHOX: for templated games with hiscore
	gameChallenge_t	recordType;	// JUHOX
#if MAPLENSFLARES	// JUHOX: serverinfo cvars for map lens flares
	editMode_t		editMode;
	char			sunFlareEffect[128];
	float			sunFlareYaw;
	float			sunFlarePitch;
	float			sunFlareDistance;
#endif
#if 1	// JUHOX: additional serverinfo cvars
	int				baseHealth;
	qboolean		stamina;
	qboolean		tss;
	qboolean		tssSafetyMode;
	int				weaponLimit;
#endif
#if MONSTER_MODE	// JUHOX: serverinfo cvars used in STU
	qboolean		artefacts;
	qboolean		monsterLauncher;
	int				maxMonsters;
#endif
#if ESCAPE_MODE	// JUHOX: serverinfo cvars used in EFH
	long			distanceLimit;
	qboolean		debugEFH;
#endif
#if GRAPPLE_ROPE	// JUHOX: serverinfo cvars used for the hook
	hookMode_t		hookMode;
#endif

#if 1	// JUHOX: nearbox info
	char			nearboxShaderName[128];
#endif

	int				voteTime;
	int				voteYes;
	int				voteNo;
	qboolean		voteModified;			// beep whenever changed
	char			voteString[MAX_STRING_TOKENS];

	int				teamVoteTime[2];
	int				teamVoteYes[2];
	int				teamVoteNo[2];
	qboolean		teamVoteModified[2];	// beep whenever changed
	char			teamVoteString[2][MAX_STRING_TOKENS];

	int				levelStartTime;

	int				scores1, scores2;		// from configstrings
	int				redflag, blueflag;		// flag status from configstrings
	int				flagStatus;

	qboolean  newHud;

	//
	// locally derived information from gamestate
	//
	qhandle_t		gameModels[MAX_MODELS];
	sfxHandle_t		gameSounds[MAX_SOUNDS];

	int				numInlineModels;
	qhandle_t		inlineDrawModel[MAX_MODELS];
	vec3_t			inlineModelMidpoints[MAX_MODELS];

	vec3_t			smallArmorFragmentMidpoint;	// JUHOX: needed to correctly rotate armor fragment
	vec3_t			largeArmorFragmentMidpoint;	// JUHOX: needed to correctly rotate armor fragment

#if !MONSTER_MODE	// JUHOX: make room for extra client numbers
	clientInfo_t	clientinfo[MAX_CLIENTS];
#else
	clientInfo_t	clientinfo[MAX_CLIENTS+EXTRA_CLIENTNUMS];
#endif

	// teamchat width is *3 because of embedded color codes
	char			teamChatMsgs[TEAMCHAT_HEIGHT][TEAMCHAT_WIDTH*3+1];
	int				teamChatMsgTimes[TEAMCHAT_HEIGHT];
	int				teamChatPos;
	int				teamLastChatPos;

	int cursorX;
	int cursorY;
	qboolean eventHandling;
	qboolean mouseCaptured;
	qboolean sizingHud;
	void *capturedItem;
	qhandle_t activeCursor;

	// orders
	int currentOrder;
	qboolean orderPending;
	int orderTime;
	int currentVoiceClient;
	int acceptOrderTime;
	int acceptTask;
	int acceptLeader;
	char acceptVoice[MAX_NAME_LENGTH];

#if MAPLENSFLARES	// JUHOX: variables for map lens flares
	int numLensFlareEffects;
	lensFlareEffect_t lensFlareEffects[MAX_LENSFLARE_EFFECTS];

	int numLensFlareEntities;
	lensFlareEntity_t sunFlare;
	lensFlareEntity_t lensFlareEntities[MAX_LIGHTS_PER_MAP];
#endif

#if MEETING
	qboolean meeting;	// JUHOX
#endif

	// media
	cgMedia_t		media;
} cgs_t;

//==============================================================================

extern	cgs_t			cgs;
extern	cg_t			cg;
extern	centity_t		cg_entities[MAX_GENTITIES];
extern	weaponInfo_t	cg_weapons[MAX_WEAPONS];
extern	itemInfo_t		cg_items[MAX_ITEMS];
extern	markPoly_t		cg_markPolys[MAX_MARK_POLYS];

extern	vmCvar_t		cg_centertime;
extern	vmCvar_t		cg_runpitch;
extern	vmCvar_t		cg_runroll;
extern	vmCvar_t		cg_bobup;
extern	vmCvar_t		cg_bobpitch;
extern	vmCvar_t		cg_bobroll;
extern	vmCvar_t		cg_swingSpeed;
extern	vmCvar_t		cg_shadows;
extern	vmCvar_t		cg_gibs;
extern	vmCvar_t		cg_drawTimer;
extern	vmCvar_t		cg_drawFPS;
extern	vmCvar_t		cg_drawSnapshot;
extern	vmCvar_t		cg_draw3dIcons;
extern	vmCvar_t		cg_drawIcons;
extern	vmCvar_t		cg_drawAmmoWarning;
extern	vmCvar_t		cg_drawCrosshair;
extern	vmCvar_t		cg_drawCrosshairNames;
extern	vmCvar_t		cg_drawRewards;
extern	vmCvar_t		cg_drawTeamOverlay;
extern	vmCvar_t		cg_teamOverlayUserinfo;
extern	vmCvar_t		cg_crosshairX;
extern	vmCvar_t		cg_crosshairY;
extern	vmCvar_t		cg_crosshairSize;
extern	vmCvar_t		cg_crosshairHealth;
extern	vmCvar_t		cg_drawStatus;
extern	vmCvar_t		cg_draw2D;
extern	vmCvar_t		cg_animSpeed;
extern	vmCvar_t		cg_debugAnim;
extern	vmCvar_t		cg_debugPosition;
extern	vmCvar_t		cg_debugEvents;
extern	vmCvar_t		cg_railTrailTime;
extern	vmCvar_t		cg_errorDecay;
extern	vmCvar_t		cg_nopredict;
extern	vmCvar_t		cg_noPlayerAnims;
extern	vmCvar_t		cg_showmiss;
extern	vmCvar_t		cg_footsteps;
extern	vmCvar_t		cg_addMarks;
extern	vmCvar_t		cg_brassTime;
extern	vmCvar_t		cg_gun_frame;
extern	vmCvar_t		cg_gun_x;
extern	vmCvar_t		cg_gun_y;
extern	vmCvar_t		cg_gun_z;
extern	vmCvar_t		cg_drawGun;
extern	vmCvar_t		cg_viewsize;
extern	vmCvar_t		cg_tracerChance;
extern	vmCvar_t		cg_tracerWidth;
extern	vmCvar_t		cg_tracerLength;
extern	vmCvar_t		cg_autoswitch;
extern	vmCvar_t		cg_autoswitchAmmoLimit;	// JUHOX
extern	vmCvar_t		cg_weaponOrder[];	// JUHOX
extern	vmCvar_t		cg_weaponOrderName[];	// JUHOX
extern	vmCvar_t		cg_ignore;
#if MONSTER_MODE	// JUHOX: STU cvars
extern	vmCvar_t		cg_drawNumMonsters;
extern	vmCvar_t		cg_fireballTrail;
#endif
#if ESCAPE_MODE	// JUHOX: EFH cvars
extern	vmCvar_t		cg_drawSegment;
#endif
extern	vmCvar_t		cg_tssiMouse;	// JUHOX
extern	vmCvar_t		cg_tssiKey;		// JUHOX
extern	vmCvar_t		cg_noTrace;		// JUHOX
extern	vmCvar_t		cg_simpleItems;
extern	vmCvar_t		cg_fov;
extern	vmCvar_t		cg_zoomFov;
extern	vmCvar_t		cg_thirdPersonRange;
extern	vmCvar_t		cg_thirdPersonAngle;
extern	vmCvar_t		cg_thirdPerson;
extern	vmCvar_t		cg_stereoSeparation;
extern	vmCvar_t		cg_lagometer;
extern	vmCvar_t		cg_drawAttacker;
extern	vmCvar_t		cg_synchronousClients;
extern	vmCvar_t		cg_teamChatTime;
extern	vmCvar_t		cg_teamChatHeight;
extern	vmCvar_t		cg_stats;
extern	vmCvar_t 		cg_forceModel;
extern	vmCvar_t 		cg_buildScript;
extern	vmCvar_t		cg_paused;
extern	vmCvar_t		cg_blood;
extern	vmCvar_t		cg_predictItems;
extern	vmCvar_t		cg_deferPlayers;
extern	vmCvar_t		cg_drawFriend;
extern	vmCvar_t		cg_teamChatsOnly;
extern	vmCvar_t		cg_noVoiceChats;
extern	vmCvar_t		cg_noVoiceText;
extern  vmCvar_t		cg_scorePlum;
extern	vmCvar_t		cg_smoothClients;
extern	vmCvar_t		pmove_fixed;
extern	vmCvar_t		pmove_msec;
//extern	vmCvar_t		cg_pmove_fixed;
extern	vmCvar_t		cg_cameraOrbit;
extern	vmCvar_t		cg_cameraOrbitDelay;
extern	vmCvar_t		cg_timescaleFadeEnd;
extern	vmCvar_t		cg_timescaleFadeSpeed;
extern	vmCvar_t		cg_timescale;
extern	vmCvar_t		cg_cameraMode;
extern  vmCvar_t		cg_smallFont;
extern  vmCvar_t		cg_bigFont;
extern	vmCvar_t		cg_noTaunt;
extern	vmCvar_t		cg_noProjectileTrail;
extern	vmCvar_t		cg_oldRail;
extern	vmCvar_t		cg_oldRocket;
extern	vmCvar_t		cg_oldPlasma;
extern	vmCvar_t		cg_trueLightning;
extern	vmCvar_t		cg_glassCloaking;	// JUHOX
extern	vmCvar_t		cg_lensFlare;		// JUHOX
#if MAPLENSFLARES
extern	vmCvar_t		cg_mapFlare;		// JUHOX
extern	vmCvar_t		cg_sunFlare;		// JUHOX
extern	vmCvar_t		cg_missileFlare;	// JUHOX
#endif
extern	vmCvar_t		cg_BFGsuperExpl;	// JUHOX
extern	vmCvar_t		cg_nearbox;			// JUHOX
extern	vmCvar_t		cg_autoGLC;			// JUHOX
#if PLAYLIST
extern	vmCvar_t		cg_music;			// JUHOX
#endif
/*
extern	vmCvar_t		cg_tssFileService;	// JUHOX
extern	vmCvar_t		cg_tssFileLen;		// JUHOX
extern	vmCvar_t		cg_tssPacketLen;	// JUHOX
*/
#ifdef MISSIONPACK
extern	vmCvar_t		cg_redTeamName;
extern	vmCvar_t		cg_blueTeamName;
extern	vmCvar_t		cg_currentSelectedPlayer;
extern	vmCvar_t		cg_currentSelectedPlayerName;
extern	vmCvar_t		cg_singlePlayer;
extern	vmCvar_t		cg_enableDust;
extern	vmCvar_t		cg_enableBreath;
extern	vmCvar_t		cg_singlePlayerActive;
extern  vmCvar_t		cg_recordSPDemo;
extern  vmCvar_t		cg_recordSPDemoName;
extern	vmCvar_t		cg_obeliskRespawnDelay;
#endif

//
// cg_main.c
//
const char *CG_ConfigString( int index );
const char *CG_Argv( int arg );

void QDECL CG_Printf( const char *msg, ... );
void QDECL CG_Error( const char *msg, ... );

void CG_StartMusic( void );

void CG_UpdateCvars( void );

int CG_CrosshairPlayer( void );
int CG_LastAttacker( void );
void CG_LoadMenus(const char *menuFile);
void CG_KeyEvent(int key, qboolean down);
void CG_MouseEvent(int x, int y);
void CG_EventHandling(int type);
void CG_RankRunFrame( void );
void CG_SetScoreSelection(void *menu);
score_t *CG_GetSelectedScore();
void CG_BuildSpectatorString();
#if MAPLENSFLARES	// JUHOX: prototypes
void CG_LFEntOrigin(const lensFlareEntity_t* lfent, vec3_t origin);
void CG_SetLFEntOrigin(lensFlareEntity_t* lfent, const vec3_t origin);
void CG_SetLFEdMoveMode(lfeMoveMode_t mode);
void CG_SelectLFEnt(int lfentnum);
void CG_LoadLensFlares(void);
void CG_ComputeMaxVisAngle(lensFlareEntity_t* lfent);
void CG_LoadLensFlareEntities(void);
#endif


//
// cg_view.c
//
void CG_TestModel_f (void);
void CG_TestGun_f (void);
void CG_TestModelNextFrame_f (void);
void CG_TestModelPrevFrame_f (void);
void CG_TestModelNextSkin_f (void);
void CG_TestModelPrevSkin_f (void);
void CG_ZoomDown_f( void );
void CG_ZoomUp_f( void );
void CG_AddBufferedSound( sfxHandle_t sfx);

void CG_DrawActiveFrame( int serverTime, stereoFrame_t stereoView, qboolean demoPlayback );

#if EARTHQUAKE_SYSTEM	// JUHOX: prototypes
void CG_AddEarthquake(
	const vec3_t origin, float radius,
	float duration, float fadeIn, float fadeOut,	// in seconds
	float amplitude
);
void CG_AdjustEarthquakes(const vec3_t delta);
#endif

#if MAPLENSFLARES	// JUHOX: prototypes
void CG_AddLFEditorCursor(void);
#endif

//
// cg_drawtools.c
//
qboolean CG_GetScreenCoordinates(const vec3_t origin, float* x, float* y);	// JUHOX
void CG_AdjustFrom640( float *x, float *y, float *w, float *h );
void CG_FillRect( float x, float y, float width, float height, const float *color );
void CG_DrawPic( float x, float y, float width, float height, qhandle_t hShader );
void CG_DrawString( float x, float y, const char *string,
				   float charWidth, float charHeight, const float *modulate );


void CG_DrawStringExt( int x, int y, const char *string, const float *setColor,
		qboolean forceColor, qboolean shadow, int charWidth, int charHeight, int maxChars );
void CG_DrawBigString( int x, int y, const char *s, float alpha );
void CG_DrawBigStringColor( int x, int y, const char *s, vec4_t color );
void CG_DrawSmallString( int x, int y, const char *s, float alpha );
void CG_DrawSmallStringColor( int x, int y, const char *s, vec4_t color );

int CG_DrawStrlen( const char *str );

float	*CG_FadeColor( int startMsec, int totalMsec );
float *CG_TeamColor( int team );
void CG_TileClear( void );
void CG_ColorForHealth( vec4_t hcolor );
// JUHOX: new parameter for CG_GetColorForHealth()
#if 0
void CG_GetColorForHealth( int health, int armor, vec4_t hcolor );
#else
void CG_GetColorForHealth(int health, int armor, int maxhealth, vec4_t hcolor);
#endif

void UI_DrawProportionalString( int x, int y, const char* str, int style, vec4_t color );
void CG_DrawRect( float x, float y, float width, float height, float size, const float *color );
void CG_DrawSides(float x, float y, float w, float h, float size);
void CG_DrawTopBottom(float x, float y, float w, float h, float size);


//
// cg_draw.c, cg_newDraw.c
//
extern	int sortedTeamPlayers[TEAM_MAXOVERLAY];
extern	int	numSortedTeamPlayers;
extern	int drawTeamOverlayModificationCount;
extern  char systemChat[256];
extern  char teamChat1[256];
extern  char teamChat2[256];

void CG_AddLagometerFrameInfo( void );
void CG_AddLagometerSnapshotInfo( snapshot_t *snap );
void CG_CenterPrint( const char *str, int y, int charWidth );
void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles );
void CG_DrawActive( stereoFrame_t stereoView );
void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D );
void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team );
void CG_OwnerDraw(float x, float y, float w, float h, float text_x, float text_y, int ownerDraw, int ownerDrawFlags, int align, float special, float scale, vec4_t color, qhandle_t shader, int textStyle);
void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style);
int CG_Text_Width(const char *text, float scale, int limit);
int CG_Text_Height(const char *text, float scale, int limit);
void CG_SelectPrevPlayer();
void CG_SelectNextPlayer();
float CG_GetValue(int ownerDraw);
qboolean CG_OwnerDrawVisible(int flags);
void CG_RunMenuScript(char **args);
void CG_ShowResponseHead();
void CG_SetPrintString(int type, const char *p);
void CG_InitTeamChat();
void CG_GetTeamColor(vec4_t *color);
const char *CG_GetGameStatusText();
const char *CG_GetKillerText();
#if 0	// JUHOX: new parameter for CG_Draw3DModel()
void CG_Draw3DModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles );
#else
void CG_Draw3DModel(float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles, qhandle_t shader);	// JUHOX: added 'shader'
#endif
void CG_Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader);
void CG_CheckOrderPending();
const char *CG_GameTypeString();
qboolean CG_YourTeamHasFlag();
qboolean CG_OtherTeamHasFlag();
qhandle_t CG_StatusHandle(int task);
#if MEETING	// prototypes
void CG_DrawVote(void);
void CG_DrawTeamVote(void);
#endif



//
// cg_player.c
//
void AddDischargeFlash(	// JUHOX
	const vec3_t origin, const vec3_t startAngles, dischargeFlash_t* flash, int entnum,
	const vec3_t mins, const vec3_t maxs, qhandle_t shader
);
void CG_Player( centity_t *cent );
void CG_ResetPlayerEntity( centity_t *cent );
void CG_AddRefEntityWithPowerups( refEntity_t *ent, entityState_t *state, int team );
void CG_NewClientInfo( int clientNum );
sfxHandle_t	CG_CustomSound( int clientNum, const char *soundName );
// JUHOX: cg_player.c monster prototypes
#if MONSTER_MODE
void CG_InitMonsterClientInfo(int clientNum);
#endif
#if 1	// JUHOX: prototype for CG_GetSpawnEffectParameters()
qboolean CG_GetSpawnEffectParameters(
	entityState_t* state,
	float* intensity, qboolean* skipOthers, int* powerups,
	refEntity_t* refEnt
);
#endif

//
// cg_predict.c
//
void CG_BuildSolidList( void );
int	CG_PointContents( const vec3_t point, int passEntityNum );
void CG_Trace( trace_t *result, const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end,
					 int skipNumber, int mask );
#if 1	// JUHOX: prototype for CG_SmoothTrace()
void CG_SmoothTrace(
	trace_t *result,
	const vec3_t start, const vec3_t mins, const vec3_t maxs, const vec3_t end,
	int skipNumber, int mask
);
#endif
void CG_PredictPlayerState( void );
void CG_LoadDeferredPlayers( void );


//
// cg_events.c
//
void CG_CheckEvents( centity_t *cent );
const char	*CG_PlaceString( int rank );
void CG_EntityEvent( centity_t *cent, vec3_t position );
void CG_PainEvent( centity_t *cent, int health );


//
// cg_ents.c
//
void CG_SetEntitySoundPosition( centity_t *cent );
void CG_AddPacketEntities( void );
void CG_Beam( centity_t *cent );
#if 1	// JUHOX: prototype for CG_DrawLineSegment()
float CG_DrawLineSegment(
	const vec3_t start, const vec3_t end,
	float totalLength, float segmentSize, float scrollspeed,
	qhandle_t shader
);
#endif
void CG_AdjustPositionForMover( const vec3_t in, int moverNum, int fromTime, int toTime, vec3_t out );

void CG_PositionEntityOnTag( refEntity_t *entity, const refEntity_t *parent,
							qhandle_t parentModel, char *tagName );
void CG_PositionRotatedEntityOnTag( refEntity_t *entity, const refEntity_t *parent,
							qhandle_t parentModel, char *tagName );
void CG_AddPacketEntitiesForGlassLook(void);	// JUHOX
#if MAPLENSFLARES	// JUHOX: prototypes
void CG_Mover(centity_t *cent);
#endif
void CG_CalcEntityLerpPositions( centity_t *cent );	// JUHOX


//
// cg_weapons.c
//
void CG_AutoSwitchToBestWeapon(void);	// JUHOX
void CG_BestWeapon_f(void);				// JUHOX
void CG_SkipWeapon_f(void);				// JUHOX
void CG_NextWeaponOrder_f(void);		// JUHOX
void CG_PrevWeaponOrder_f(void);		// JUHOX
void CG_NextWeapon_f( void );
void CG_PrevWeapon_f( void );
void CG_Weapon_f( void );

void CG_RegisterWeapon( int weaponNum );
void CG_RegisterItemVisuals( int itemNum );

void CG_FireWeapon( centity_t *cent );
void CG_MissileHitWall( int weapon, int clientNum, vec3_t origin, vec3_t dir, impactSound_t soundType );
void CG_MissileHitPlayer( int weapon, vec3_t origin, vec3_t dir, int entityNum );
void CG_ShotgunFire( entityState_t *es );
void CG_Bullet( vec3_t origin, int sourceEntityNum, vec3_t normal, qboolean flesh, int fleshEntityNum );
void CG_Draw3DLine(const vec3_t start, const vec3_t end, qhandle_t shader);	// JUHOX

void CG_RailTrail( clientInfo_t *ci, vec3_t start, vec3_t end );
void CG_GrappleTrail( centity_t *ent, const weaponInfo_t *wi );
void CG_AddViewWeapon (playerState_t *ps);
void CG_AddPlayerWeapon( refEntity_t *parent, playerState_t *ps, centity_t *cent, int team );
void CG_DrawWeaponSelect( void );

void CG_OutOfAmmoChange( void );	// should this be in pmove?

//
// cg_marks.c
//
void	CG_InitMarkPolys( void );
void	CG_AddMarks( void );
void	CG_ImpactMark( qhandle_t markShader,
				    const vec3_t origin, const vec3_t dir,
					float orientation,
				    float r, float g, float b, float a,
					qboolean alphaFade,
					float radius, qboolean temporary );
void CG_AddNearbox(void);	// JUHOX
// JUHOX: CG_AddLightningMarks() prototype
#if MONSTER_MODE
void CG_AddLightningMarks(int numMarks);
#endif
void CG_CheckStrongLight(const vec3_t origin, float intensity, const vec3_t color);	// JUHOX
void CG_DrawLightBlobs(void);	// JUHOX

//
// cg_localents.c
//
void	CG_InitLocalEntities( void );
localEntity_t	*CG_AllocLocalEntity( void );
void	CG_AddLocalEntities( void );
// JUHOX: prototypes for EFH
#if ESCAPE_MODE
void CG_AdjustLocalEntities(const vec3_t delta);
#endif

//
// cg_effects.c
//
localEntity_t *CG_SmokePuff( const vec3_t p,
				   const vec3_t vel,
				   float radius,
				   float r, float g, float b, float a,
				   float duration,
				   int startTime,
				   int fadeInTime,
				   int leFlags,
				   qhandle_t hShader );
void CG_BubbleTrail( vec3_t start, vec3_t end, float spacing );
void CG_SpawnEffect( vec3_t org );
#ifdef MISSIONPACK
void CG_KamikazeEffect( vec3_t org );
void CG_ObeliskExplode( vec3_t org, int entityNum );
void CG_ObeliskPain( vec3_t org );
void CG_InvulnerabilityImpact( vec3_t org, vec3_t angles );
void CG_InvulnerabilityJuiced( vec3_t org );
void CG_LightningBoltBeam( vec3_t start, vec3_t end );
#endif
void CG_ScorePlum( int client, vec3_t org, int score );

// JUHOX: new parameter for CG_GibPlayer()
#if !MONSTER_MODE
void CG_GibPlayer( vec3_t playerOrigin );
#else
void CG_GibPlayer(vec3_t playerOrigin, centity_t* cent);
#endif
void CG_BFGsuperExpl(vec3_t origin);	// JUHOX
void CG_BigExplode( vec3_t playerOrigin );

void CG_Bleed( vec3_t origin, int entityNum );

localEntity_t *CG_MakeExplosion( vec3_t origin, vec3_t dir,
								qhandle_t hModel, qhandle_t shader, int msec,
								qboolean isSprite );

//
// cg_snapshot.c
//
void CG_ProcessSnapshots( void );

//
// cg_info.c
//
void CG_LoadingString( const char *s );
void CG_LoadingItem( int itemNum );
void CG_LoadingClient( int clientNum );
void CG_DrawInformation( void );

//
// cg_scoreboard.c
//
qboolean CG_DrawOldScoreboard( void );
void CG_DrawOldTourneyScoreboard( void );

//
// cg_consolecmds.c
//
qboolean CG_ConsoleCommand( void );
void CG_InitConsoleCommands( void );

//
// cg_servercmds.c
//
void CG_ExecuteNewServerCommands( int latestSequence );
void CG_ParseServerinfo( void );
void CG_SetConfigValues( void );
void CG_LoadVoiceChats( void );
void CG_ShaderStateChanged(void);
void CG_VoiceChatLocal( int mode, qboolean voiceOnly, int clientNum, int color, const char *cmd );
void CG_PlayBufferedVoiceChats( void );

//
// cg_playerstate.c
//
void CG_Respawn( void );
void CG_TransitionPlayerState( playerState_t *ps, playerState_t *ops );
void CG_CheckChangedPredictableEvents( playerState_t *ps );

#if 1	// JUHOX: cg_tssfile.c prototypes
#if !TSSINCVAR
qboolean CG_TSS_LoadStrategy(const char* filename, tss_strategy_t* strategy);
qboolean CG_TSS_SaveStrategy(const char* filename, const tss_strategy_t* strategy);
void CG_TSS_LoadStrategyStock(void);
void CG_TSS_SaveStrategyStock(void);
#else
qboolean TSSFS_SaveStrategy(const char* filename, const char* cvarbase, const tss_strategy_t* strategy);
qboolean TSSFS_LoadStrategy(const char* cvarBase, tss_strategy_t* strategy);
void TSSFS_LoadStrategyStock(void);
void TSSFS_SaveStrategyStock(void);
#endif
int CG_TSS_NumStrategiesInStock(tss_strategySortOrder_t order);
tss_strategySlot_t* CG_TSS_GetSlotByID(int id);
tss_strategySlot_t* CG_TSS_GetSlotByName(const char* name);
tss_strategySlot_t* CG_TSS_GetSortedSlot(int sortIndex, tss_strategySortOrder_t order);
int CG_TSS_GetSortIndexByID(int id, tss_strategySortOrder_t order);
qboolean CG_TSS_LoadPaletteSlot(tss_strategySlot_t* sslot, tss_strategyPaletteSlot_t* pslot);
void CG_TSS_SavePaletteSlotIfNeeded(tss_strategyPaletteSlot_t* pslot);
void CG_TSS_FreePaletteSlot(tss_strategyPaletteSlot_t* pslot);
qboolean CG_TSS_CreateNewStrategy(tss_strategyPaletteSlot_t* pslot);
void CG_TSS_SetSearchPattern(const char* pattern);
int CG_TSS_StrategyNameChanged(int sortIndex, tss_strategySortOrder_t order);
#endif

#if 1	// JUHOX: cg_tss.c prototypes
void TSS_GetPalette(tss_savedPalette_t* palette);
void TSS_SetPalette(const tss_savedPalette_t* palette);
void CG_TSS_InitInterface(void);
void CG_TSS_LoadInterface(void);
void CG_TSS_SaveInterface(void);
void CG_TSS_Update(void);
void CG_TSS_SPrintTacticalMeasure(
	char* buf, int size,
	tss_tacticalMagnitude_t magnitude, tss_tacticalMeasures_t* measures
);
void CG_TSS_DrawInterface(void);
void CG_TSS_OpenInterface(void);
void CG_TSS_CloseInterface(void);
void CG_TSS_KeyEvent(int key, qboolean down);
void CG_TSS_MouseEvent(int dx, int dy);
void CG_TSS_CheckKeyEvents(void);
void CG_TSS_CheckMouseEvents(void);
#endif

#if PLAYLIST	// JUHOX: prototypes for cg_playlist.c
void CG_InitPlayList(void);
void CG_ParsePlayList(void);
void CG_StopPlayList(void);
void CG_ContinuePlayList(void);
void CG_ResetPlayList(void);
void CG_RunPlayListFrame(void);
#endif

//===============================================

//
// system traps
// These functions are how the cgame communicates with the main game system
//

// print message on the local console
void		trap_Print( const char *fmt );

// abort the game
void		trap_Error( const char *fmt );

// milliseconds should only be used for performance tuning, never
// for anything game related.  Get time from the CG_DrawActiveFrame parameter
int			trap_Milliseconds( void );

// console variable interaction
void		trap_Cvar_Register( vmCvar_t *vmCvar, const char *varName, const char *defaultValue, int flags );
void		trap_Cvar_Update( vmCvar_t *vmCvar );
void		trap_Cvar_Set( const char *var_name, const char *value );
void		trap_Cvar_VariableStringBuffer( const char *var_name, char *buffer, int bufsize );

// ServerCommand and ConsoleCommand parameter access
int			trap_Argc( void );
void		trap_Argv( int n, char *buffer, int bufferLength );
void		trap_Args( char *buffer, int bufferLength );

// filesystem access
// returns length of file
int			trap_FS_FOpenFile( const char *qpath, fileHandle_t *f, fsMode_t mode );
void		trap_FS_Read( void *buffer, int len, fileHandle_t f );
void		trap_FS_Write( const void *buffer, int len, fileHandle_t f );
void		trap_FS_FCloseFile( fileHandle_t f );
int			trap_FS_Seek( fileHandle_t f, long offset, int origin ); // fsOrigin_t

// add commands to the local console as if they were typed in
// for map changing, etc.  The command is not executed immediately,
// but will be executed in order the next time console commands
// are processed
void		trap_SendConsoleCommand( const char *text );

// register a command name so the console can perform command completion.
// FIXME: replace this with a normal console command "defineCommand"?
void		trap_AddCommand( const char *cmdName );

// send a string to the server over the network
void		trap_SendClientCommand( const char *s );

// force a screen update, only used during gamestate load
void		trap_UpdateScreen( void );

// model collision
void		trap_CM_LoadMap( const char *mapname );
int			trap_CM_NumInlineModels( void );
clipHandle_t trap_CM_InlineModel( int index );		// 0 = world, 1+ = bmodels
clipHandle_t trap_CM_TempBoxModel( const vec3_t mins, const vec3_t maxs );
int			trap_CM_PointContents( const vec3_t p, clipHandle_t model );
int			trap_CM_TransformedPointContents( const vec3_t p, clipHandle_t model, const vec3_t origin, const vec3_t angles );
void		trap_CM_BoxTrace( trace_t *results, const vec3_t start, const vec3_t end,
					  const vec3_t mins, const vec3_t maxs,
					  clipHandle_t model, int brushmask );
void		trap_CM_TransformedBoxTrace( trace_t *results, const vec3_t start, const vec3_t end,
					  const vec3_t mins, const vec3_t maxs,
					  clipHandle_t model, int brushmask,
					  const vec3_t origin, const vec3_t angles );

// Returns the projection of a polygon onto the solid brushes in the world
int			trap_CM_MarkFragments( int numPoints, const vec3_t *points,
			const vec3_t projection,
			int maxPoints, vec3_t pointBuffer,
			int maxFragments, markFragment_t *fragmentBuffer );

// normal sounds will have their volume dynamically changed as their entity
// moves and the listener moves
void		trap_S_StartSound( vec3_t origin, int entityNum, int entchannel, sfxHandle_t sfx );
void		trap_S_StopLoopingSound(int entnum);

// a local sound is always played full volume
void		trap_S_StartLocalSound( sfxHandle_t sfx, int channelNum );
void		trap_S_ClearLoopingSounds( qboolean killall );
void		trap_S_AddLoopingSound( int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx );
void		trap_S_AddRealLoopingSound( int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx );
void		trap_S_UpdateEntityPosition( int entityNum, const vec3_t origin );

// respatialize recalculates the volumes of sound as they should be heard by the
// given entityNum and position
void		trap_S_Respatialize( int entityNum, const vec3_t origin, vec3_t axis[3], int inwater );
sfxHandle_t	trap_S_RegisterSound( const char *sample, qboolean compressed );		// returns buzz if not found
void		trap_S_StartBackgroundTrack( const char *intro, const char *loop );	// empty name stops music
void	trap_S_StopBackgroundTrack( void );


#if ESCAPE_MODE	// JUHOX: sound fix for EFH
//
// NOTE: the calls to trap_S_Respatialize() and trap_S_UpdateEntityPosition()
//       have been fixed manually
//
extern vec3_t currentReference;

void trap_S_StartSound_fixed(vec3_t origin, int entityNum, int entchannel, sfxHandle_t sfx);
#define trap_S_StartSound trap_S_StartSound_fixed

void trap_S_AddLoopingSound_fixed(int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx);
#define trap_S_AddLoopingSound trap_S_AddLoopingSound_fixed

void trap_S_AddRealLoopingSound_fixed(int entityNum, const vec3_t origin, const vec3_t velocity, sfxHandle_t sfx);
#define trap_S_AddRealLoopingSound trap_S_AddRealLoopingSound_fixed
#endif


void		trap_R_LoadWorldMap( const char *mapname );

// all media should be registered during level startup to prevent
// hitches during gameplay
qhandle_t	trap_R_RegisterModel( const char *name );			// returns rgb axis if not found
qhandle_t	trap_R_RegisterSkin( const char *name );			// returns all white if not found
qhandle_t	trap_R_RegisterShader( const char *name );			// returns all white if not found
qhandle_t	trap_R_RegisterShaderNoMip( const char *name );			// returns all white if not found

// a scene is built up by calls to R_ClearScene and the various R_Add functions.
// Nothing is drawn until R_RenderScene is called.
void		trap_R_ClearScene( void );
void		trap_R_AddRefEntityToScene( const refEntity_t *re );

// polys are intended for simple wall marks, not really for doing
// significant construction
void		trap_R_AddPolyToScene( qhandle_t hShader , int numVerts, const polyVert_t *verts );
void		trap_R_AddPolysToScene( qhandle_t hShader , int numVerts, const polyVert_t *verts, int numPolys );
void		trap_R_AddLightToScene( const vec3_t org, float intensity, float r, float g, float b );
int			trap_R_LightForPoint( vec3_t point, vec3_t ambientLight, vec3_t directedLight, vec3_t lightDir );
void		trap_R_RenderScene( const refdef_t *fd );
void		trap_R_SetColor( const float *rgba );	// NULL = 1,1,1,1
void		trap_R_DrawStretchPic( float x, float y, float w, float h,
			float s1, float t1, float s2, float t2, qhandle_t hShader );
void		trap_R_ModelBounds( clipHandle_t model, vec3_t mins, vec3_t maxs );
int			trap_R_LerpTag( orientation_t *tag, clipHandle_t mod, int startFrame, int endFrame,
					   float frac, const char *tagName );
void		trap_R_RemapShader( const char *oldShader, const char *newShader, const char *timeOffset );

// The glconfig_t will not change during the life of a cgame.
// If it needs to change, the entire cgame will be restarted, because
// all the qhandle_t are then invalid.
void		trap_GetGlconfig( glconfig_t *glconfig );

// the gamestate should be grabbed at startup, and whenever a
// configstring changes
void		trap_GetGameState( gameState_t *gamestate );

// cgame will poll each frame to see if a newer snapshot has arrived
// that it is interested in.  The time is returned seperately so that
// snapshot latency can be calculated.
void		trap_GetCurrentSnapshotNumber( int *snapshotNumber, int *serverTime );

// a snapshot get can fail if the snapshot (or the entties it holds) is so
// old that it has fallen out of the client system queue
qboolean	trap_GetSnapshot( int snapshotNumber, snapshot_t *snapshot );

// retrieve a text command from the server stream
// the current snapshot will hold the number of the most recent command
// qfalse can be returned if the client system handled the command
// argc() / argv() can be used to examine the parameters of the command
qboolean	trap_GetServerCommand( int serverCommandNumber );

// returns the most recent command number that can be passed to GetUserCmd
// this will always be at least one higher than the number in the current
// snapshot, and it may be quite a few higher if it is a fast computer on
// a lagged connection
int			trap_GetCurrentCmdNumber( void );

qboolean	trap_GetUserCmd( int cmdNumber, usercmd_t *ucmd );

// used for the weapon select and zoom
void		trap_SetUserCmdValue( int stateValue, float sensitivityScale );

// aids for VM testing
void		testPrintInt( char *string, int i );
void		testPrintFloat( char *string, float f );

int			trap_MemoryRemaining( void );
void		trap_R_RegisterFont(const char *fontName, int pointSize, fontInfo_t *font);
qboolean	trap_Key_IsDown( int keynum );
int			trap_Key_GetCatcher( void );
void		trap_Key_SetCatcher( int catcher );
int			trap_Key_GetKey( const char *binding );


typedef enum {
  SYSTEM_PRINT,
  CHAT_PRINT,
  TEAMCHAT_PRINT
} q3print_t; // bk001201 - warning: useless keyword or type name in empty declaration


int trap_CIN_PlayCinematic( const char *arg0, int xpos, int ypos, int width, int height, int bits);
e_status trap_CIN_StopCinematic(int handle);
e_status trap_CIN_RunCinematic (int handle);
void trap_CIN_DrawCinematic (int handle);
void trap_CIN_SetExtents (int handle, int x, int y, int w, int h);

void trap_SnapVector( float *v );

qboolean	trap_loadCamera(const char *name);
void		trap_startCamera(int time);
qboolean	trap_getCameraInfo(int time, vec3_t *origin, vec3_t *angles);

qboolean	trap_GetEntityToken( char *buffer, int bufferSize );

void	CG_ClearParticles (void);
void	CG_AddParticles (void);
void	CG_ParticleSnow (qhandle_t pshader, vec3_t origin, vec3_t origin2, int turb, float range, int snum);
void	CG_ParticleSmoke (qhandle_t pshader, centity_t *cent);
void	CG_AddParticleShrapnel (localEntity_t *le);
void	CG_ParticleSnowFlurry (qhandle_t pshader, centity_t *cent);
void	CG_ParticleBulletDebris (vec3_t	org, vec3_t vel, int duration);
void	CG_ParticleSparks (vec3_t org, vec3_t vel, int duration, float x, float y, float speed);
void	CG_ParticleDust (centity_t *cent, vec3_t origin, vec3_t dir);
void	CG_ParticleMisc (qhandle_t pshader, vec3_t origin, int size, int duration, float alpha);
void	CG_ParticleExplosion (char *animStr, vec3_t origin, vec3_t vel, int duration, int sizeStart, int sizeEnd);
extern qboolean		initparticles;
int CG_NewParticleArea ( int num );

#if ESCAPE_MODE
void CG_AdjustParticles(const vec3_t delta);	// JUHOX
#endif
