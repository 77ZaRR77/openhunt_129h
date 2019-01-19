// Copyright (C) 1999-2000 Id Software, Inc.
//
/**********************************************************************
	UI_ATOMS.C

	User interface building blocks and support functions.
**********************************************************************/
#include "ui_local.h"

uiStatic_t		uis;
qboolean		m_entersound;		// after a frame, so caching won't disrupt the sound

// these are here so the functions in q_shared.c can link
#ifndef UI_HARD_LINKED

void QDECL Com_Error( int level, const char *error, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, error);
	vsprintf (text, error, argptr);
	va_end (argptr);

	trap_Error( va("%s", text) );
}

void QDECL Com_Printf( const char *msg, ... ) {
	va_list		argptr;
	char		text[1024];

	va_start (argptr, msg);
	vsprintf (text, msg, argptr);
	va_end (argptr);

	trap_Print( va("%s", text) );
}

#endif

/*
=================
UI_ClampCvar
=================
*/
float UI_ClampCvar( float min, float max, float value )
{
	if ( value < min ) return min;
	if ( value > max ) return max;
	return value;
}

/*
=================
UI_StartDemoLoop
=================
*/
void UI_StartDemoLoop( void ) {
	trap_Cmd_ExecuteText( EXEC_APPEND, "d1\n" );
}

/*
=================
UI_PushMenu
=================
*/
void UI_PushMenu( menuframework_s *menu )
{
	int				i;
	menucommon_s*	item;

	// avoid stacking menus invoked by hotkeys
	for (i=0 ; i<uis.menusp ; i++)
	{
		if (uis.stack[i] == menu)
		{
			uis.menusp = i;
			break;
		}
	}

	if (i == uis.menusp)
	{
		if (uis.menusp >= MAX_MENUDEPTH)
			trap_Error("UI_PushMenu: menu stack overflow");

		uis.stack[uis.menusp++] = menu;
	}

	uis.activemenu = menu;

	// default cursor position
	menu->cursor      = 0;
	menu->cursor_prev = 0;

	m_entersound = qtrue;

	trap_Key_SetCatcher( KEYCATCH_UI );

	// force first available item to have focus
	for (i=0; i<menu->nitems; i++)
	{
		item = (menucommon_s *)menu->items[i];
		if (!(item->flags & (QMF_GRAYED|QMF_MOUSEONLY|QMF_INACTIVE)))
		{
			menu->cursor_prev = -1;
			Menu_SetCursor( menu, i );
			break;
		}
	}

	uis.firstdraw = qtrue;
}

/*
=================
UI_PopMenu
=================
*/
void UI_PopMenu (void)
{
	trap_S_StartLocalSound( menu_out_sound, CHAN_LOCAL_SOUND );

	uis.menusp--;

	if (uis.menusp < 0)
		trap_Error ("UI_PopMenu: menu stack underflow");

	if (uis.menusp) {
		uis.activemenu = uis.stack[uis.menusp-1];
		uis.firstdraw = qtrue;
	}
	else {
		UI_ForceMenuOff ();
	}
}

void UI_ForceMenuOff (void)
{
	uis.menusp     = 0;
	uis.activemenu = NULL;

	trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
	trap_Key_ClearStates();
	trap_Cvar_Set( "cl_paused", "0" );
}

/*
=================
UI_LerpColor
=================
*/
void UI_LerpColor(vec4_t a, vec4_t b, vec4_t c, float t)
{
	int i;

	// lerp and clamp each component
	for (i=0; i<4; i++)
	{
		c[i] = a[i] + t*(b[i]-a[i]);
		if (c[i] < 0)
			c[i] = 0;
		else if (c[i] > 1.0)
			c[i] = 1.0;
	}
}

/*
=================
UI_DrawProportionalString2
=================
*/
static int	propMap[128][3] = {
{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},

{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},

{0, 0, PROP_SPACE_WIDTH},		// SPACE
{11, 122, 7},	// !
{154, 181, 14},	// "
{55, 122, 17},	// #
{79, 122, 18},	// $
{101, 122, 23},	// %
{153, 122, 18},	// &
{9, 93, 7},		// '
{207, 122, 8},	// (
{230, 122, 9},	// )
{177, 122, 18},	// *
{30, 152, 18},	// +
{85, 181, 7},	// ,
{34, 93, 11},	// -
{110, 181, 6},	// .
{130, 152, 14},	// /

{22, 64, 17},	// 0
{41, 64, 12},	// 1
{58, 64, 17},	// 2
{78, 64, 18},	// 3
{98, 64, 19},	// 4
{120, 64, 18},	// 5
{141, 64, 18},	// 6
{204, 64, 16},	// 7
{162, 64, 17},	// 8
{182, 64, 18},	// 9
{59, 181, 7},	// :
{35,181, 7},	// ;
{203, 152, 14},	// <
{56, 93, 14},	// =
{228, 152, 14},	// >
{177, 181, 18},	// ?

{28, 122, 22},	// @
{5, 4, 18},		// A
{27, 4, 18},	// B
{48, 4, 18},	// C
{69, 4, 17},	// D
{90, 4, 13},	// E
{106, 4, 13},	// F
{121, 4, 18},	// G
{143, 4, 17},	// H
{164, 4, 8},	// I
{175, 4, 16},	// J
{195, 4, 18},	// K
{216, 4, 12},	// L
{230, 4, 23},	// M
{6, 34, 18},	// N
{27, 34, 18},	// O

{48, 34, 18},	// P
{68, 34, 18},	// Q
{90, 34, 17},	// R
{110, 34, 18},	// S
{130, 34, 14},	// T
{146, 34, 18},	// U
{166, 34, 19},	// V
{185, 34, 29},	// W
{215, 34, 18},	// X
{234, 34, 18},	// Y
{5, 64, 14},	// Z
{60, 152, 7},	// [
{106, 151, 13},	// '\'
{83, 152, 7},	// ]
{128, 122, 17},	// ^
{4, 152, 21},	// _

{134, 181, 5},	// '
{5, 4, 18},		// A
{27, 4, 18},	// B
{48, 4, 18},	// C
{69, 4, 17},	// D
{90, 4, 13},	// E
{106, 4, 13},	// F
{121, 4, 18},	// G
{143, 4, 17},	// H
{164, 4, 8},	// I
{175, 4, 16},	// J
{195, 4, 18},	// K
{216, 4, 12},	// L
{230, 4, 23},	// M
{6, 34, 18},	// N
{27, 34, 18},	// O

{48, 34, 18},	// P
{68, 34, 18},	// Q
{90, 34, 17},	// R
{110, 34, 18},	// S
{130, 34, 14},	// T
{146, 34, 18},	// U
{166, 34, 19},	// V
{185, 34, 29},	// W
{215, 34, 18},	// X
{234, 34, 18},	// Y
{5, 64, 14},	// Z
{153, 152, 13},	// {
{11, 181, 5},	// |
{180, 152, 13},	// }
{79, 93, 17},	// ~
{0, 0, -1}		// DEL
};

static int propMapB[26][3] = {
{11, 12, 33},
{49, 12, 31},
{85, 12, 31},
{120, 12, 30},
{156, 12, 21},
{183, 12, 21},
{207, 12, 32},

{13, 55, 30},
{49, 55, 13},
{66, 55, 29},
{101, 55, 31},
{135, 55, 21},
{158, 55, 40},
{204, 55, 32},

{12, 97, 31},
{48, 97, 31},
{82, 97, 30},
{118, 97, 30},
{153, 97, 30},
{185, 97, 25},
{213, 97, 30},

{11, 139, 32},
{42, 139, 51},
{93, 139, 32},
{126, 139, 31},
{158, 139, 25},
};

#define PROPB_GAP_WIDTH		4
#define PROPB_SPACE_WIDTH	12
#define PROPB_HEIGHT		36

// bk001205 - code below duplicated in cgame/cg_drawtools.c
// bk001205 - FIXME: does this belong in ui_shared.c?
/*
=================
UI_DrawBannerString
=================
*/
static void UI_DrawBannerString2( int x, int y, const char* str, vec4_t color )
{
	const char* s;
	unsigned char	ch; // bk001204 - unsigned
	float	ax;
	float	ay;
	float	aw;
	float	ah;
	float	frow;
	float	fcol;
	float	fwidth;
	float	fheight;

	// draw the colored text
	trap_R_SetColor( color );
	
	// JUHOX: apply the new scaling
#if 0
	ax = x * uis.scale + uis.bias;
	ay = y * uis.scale;
#else
	ax = x * uis.scaleX;
	ay = y * uis.scaleY;
#endif

	s = str;
	while ( *s )
	{
		ch = *s & 127;
		if ( ch == ' ' ) {
			// JUHOX: apply the new scaling
#if 0
			ax += ((float)PROPB_SPACE_WIDTH + (float)PROPB_GAP_WIDTH)* uis.scale;
#else
			ax += ((float)PROPB_SPACE_WIDTH + (float)PROPB_GAP_WIDTH)* uis.scaleX;
#endif
		}
		else if ( ch >= 'A' && ch <= 'Z' ) {
			ch -= 'A';
			fcol = (float)propMapB[ch][0] / 256.0f;
			frow = (float)propMapB[ch][1] / 256.0f;
			fwidth = (float)propMapB[ch][2] / 256.0f;
			fheight = (float)PROPB_HEIGHT / 256.0f;
			// JUHOX: apply the new scaling
#if 0
			aw = (float)propMapB[ch][2] * uis.scale;
			ah = (float)PROPB_HEIGHT * uis.scale;
#else
			aw = (float)propMapB[ch][2] * uis.scaleX;
			ah = (float)PROPB_HEIGHT * uis.scaleY;
#endif
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, uis.charsetPropB );
			// JUHOX: apply the new scaling
#if 0
			ax += (aw + (float)PROPB_GAP_WIDTH * uis.scale);
#else
			ax += (aw + (float)PROPB_GAP_WIDTH * uis.scaleX);
#endif
		}
		s++;
	}

	trap_R_SetColor( NULL );
}

void UI_DrawBannerString( int x, int y, const char* str, int style, vec4_t color ) {
	const char *	s;
	int				ch;
	int				width;
	vec4_t			drawcolor;

	// find the width of the drawn text
	s = str;
	width = 0;
	while ( *s ) {
		ch = *s;
		if ( ch == ' ' ) {
			width += PROPB_SPACE_WIDTH;
		}
		else if ( ch >= 'A' && ch <= 'Z' ) {
			width += propMapB[ch - 'A'][2] + PROPB_GAP_WIDTH;
		}
		s++;
	}
	width -= PROPB_GAP_WIDTH;

	switch( style & UI_FORMATMASK ) {
		case UI_CENTER:
			x -= width / 2;
			break;

		case UI_RIGHT:
			x -= width;
			break;

		case UI_LEFT:
		default:
			break;
	}

	if ( style & UI_DROPSHADOW ) {
		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
		drawcolor[3] = color[3];
		UI_DrawBannerString2( x+2, y+2, str, drawcolor );
	}

	UI_DrawBannerString2( x, y, str, color );
}


int UI_ProportionalStringWidth( const char* str ) {
	const char *	s;
	int				ch;
	int				charWidth;
	int				width;

	s = str;
	width = 0;
	while ( *s ) {
		ch = *s & 127;
		charWidth = propMap[ch][2];
		if ( charWidth != -1 ) {
			width += charWidth;
			width += PROP_GAP_WIDTH;
		}
		s++;
	}

	width -= PROP_GAP_WIDTH;
	return width;
}

static void UI_DrawProportionalString2( int x, int y, const char* str, vec4_t color, float sizeScale, qhandle_t charset )
{
	const char* s;
	unsigned char	ch; // bk001204 - unsigned
	float	ax;
	float	ay;
	float	aw = 0; // bk001204 - init
	float	ah;
	float	frow;
	float	fcol;
	float	fwidth;
	float	fheight;

	// draw the colored text
	trap_R_SetColor( color );

	// JUHOX: apply the new scaling
#if 0	
	ax = x * uis.scale + uis.bias;
	ay = y * uis.scale;
#else
	ax = x * uis.scaleX;
	ay = y * uis.scaleY;
#endif

	s = str;
	while ( *s )
	{
		ch = *s & 127;
		if ( ch == ' ' ) {
			// JUHOX: apply the new scaling
#if 0
			aw = (float)PROP_SPACE_WIDTH * uis.scale * sizeScale;
#else
			aw = (float)PROP_SPACE_WIDTH * uis.scaleX * sizeScale;
#endif
		}
		else if ( propMap[ch][2] != -1 ) {
			fcol = (float)propMap[ch][0] / 256.0f;
			frow = (float)propMap[ch][1] / 256.0f;
			fwidth = (float)propMap[ch][2] / 256.0f;
			fheight = (float)PROP_HEIGHT / 256.0f;
			// JUHOX: apply the new scaling
#if 0
			aw = (float)propMap[ch][2] * uis.scale * sizeScale;
			ah = (float)PROP_HEIGHT * uis.scale * sizeScale;
#else
			aw = (float)propMap[ch][2] * uis.scaleX * sizeScale;
			ah = (float)PROP_HEIGHT * uis.scaleY * sizeScale;
#endif
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, charset );
		}

		// JUHOX: apply the new scaling
#if 0
		ax += (aw + (float)PROP_GAP_WIDTH * uis.scale * sizeScale);
#else
		ax += (aw + (float)PROP_GAP_WIDTH * uis.scaleX * sizeScale);
#endif
		s++;
	}

	trap_R_SetColor( NULL );
}

/*
=================
UI_ProportionalSizeScale
=================
*/
float UI_ProportionalSizeScale( int style ) {
	if(  style & UI_SMALLFONT ) {
		return PROP_SMALL_SIZE_SCALE;
	}

	return 1.00;
}


/*
=================
UI_DrawProportionalString
=================
*/
void UI_DrawProportionalString( int x, int y, const char* str, int style, vec4_t color ) {
	vec4_t	drawcolor;
	int		width;
	float	sizeScale;

	sizeScale = UI_ProportionalSizeScale( style );

	switch( style & UI_FORMATMASK ) {
		case UI_CENTER:
			width = UI_ProportionalStringWidth( str ) * sizeScale;
			x -= width / 2;
			break;

		case UI_RIGHT:
			width = UI_ProportionalStringWidth( str ) * sizeScale;
			x -= width;
			break;

		case UI_LEFT:
		default:
			break;
	}

	if ( style & UI_DROPSHADOW ) {
		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
		drawcolor[3] = color[3];
		UI_DrawProportionalString2( x+2, y+2, str, drawcolor, sizeScale, uis.charsetProp );
	}

	if ( style & UI_INVERSE ) {
		drawcolor[0] = color[0] * 0.7;
		drawcolor[1] = color[1] * 0.7;
		drawcolor[2] = color[2] * 0.7;
		drawcolor[3] = color[3];
		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, uis.charsetProp );
		return;
	}

	if ( style & UI_PULSE ) {
		drawcolor[0] = color[0] * 0.7;
		drawcolor[1] = color[1] * 0.7;
		drawcolor[2] = color[2] * 0.7;
		drawcolor[3] = color[3];
		UI_DrawProportionalString2( x, y, str, color, sizeScale, uis.charsetProp );

		drawcolor[0] = color[0];
		drawcolor[1] = color[1];
		drawcolor[2] = color[2];
		drawcolor[3] = 0.5 + 0.5 * sin( uis.realtime / PULSE_DIVISOR );
		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, uis.charsetPropGlow );
		return;
	}

	UI_DrawProportionalString2( x, y, str, color, sizeScale, uis.charsetProp );
}

/*
=================
UI_DrawProportionalString_Wrapped
=================
*/
void UI_DrawProportionalString_AutoWrapped( int x, int y, int xmax, int ystep, const char* str, int style, vec4_t color ) {
	int width;
	char *s1,*s2,*s3;
	char c_bcp;
	char buf[1024];
	float   sizeScale;

	if (!str || str[0]=='\0')
		return;
	
	sizeScale = UI_ProportionalSizeScale( style );
	
	Q_strncpyz(buf, str, sizeof(buf));
	s1 = s2 = s3 = buf;

	while (1) {
		do {
			s3++;
		} while (*s3!=' ' && *s3!='\0');
		c_bcp = *s3;
		*s3 = '\0';
		width = UI_ProportionalStringWidth(s1) * sizeScale;
		*s3 = c_bcp;
		if (width > xmax) {
			if (s1==s2)
			{
				// fuck, don't have a clean cut, we'll overflow
				s2 = s3;
			}
			*s2 = '\0';
			UI_DrawProportionalString(x, y, s1, style, color);
			y += ystep;
			if (c_bcp == '\0')
      {
        // that was the last word
        // we could start a new loop, but that wouldn't be much use
        // even if the word is too long, we would overflow it (see above)
        // so just print it now if needed
        s2++;
        if (*s2 != '\0') // if we are printing an overflowing line we have s2 == s3
          UI_DrawProportionalString(x, y, s2, style, color);
				break; 
      }
			s2++;
			s1 = s2;
			s3 = s2;
		}
		else
		{
			s2 = s3;
			if (c_bcp == '\0') // we reached the end
			{
				UI_DrawProportionalString(x, y, s1, style, color);
				break;
			}
		}
	}
}

/*
=================
UI_DrawString2
=================
*/
static void UI_DrawString2( int x, int y, const char* str, vec4_t color, int charw, int charh )
{
	const char* s;
	char	ch;
	int forceColor = qfalse; //APSFIXME;
	vec4_t	tempcolor;
	float	ax;
	float	ay;
	float	aw;
	float	ah;
	float	frow;
	float	fcol;

	if (y < -charh)
		// offscreen
		return;

	// draw the colored text
	trap_R_SetColor( color );

	// JUHOX: apply the new scaling
#if 0	
	ax = x * uis.scale + uis.bias;
	ay = y * uis.scale;
	aw = charw * uis.scale;
	ah = charh * uis.scale;
#else
	ax = x * uis.scaleX;
	ay = y * uis.scaleY;
	aw = charw * uis.scaleX;
	ah = charh * uis.scaleY;
#endif

	s = str;
	while ( *s )
	{
		if ( Q_IsColorString( s ) )
		{
			if ( !forceColor )
			{
				memcpy( tempcolor, g_color_table[ColorIndex(s[1])], sizeof( tempcolor ) );
				tempcolor[3] = color[3];
				trap_R_SetColor( tempcolor );
			}
			s += 2;
			continue;
		}

		ch = *s & 255;
		if (ch != ' ')
		{
			// JUHOX: we've now more than one charsetShader
#if 0
			frow = (ch>>4)*0.0625;
			fcol = (ch&15)*0.0625;
			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol + 0.0625, frow + 0.0625, uis.charset );
#else
			qhandle_t charset;
			int col, row;

			charset = uis.charsetShaders[((ch&8)>>3) + ((ch&192)>>5)];

			col = ch & 7;
			row = (ch & 48) >> 4;

			fcol = col * 0.125 + 1.0/168.0;
			frow = row * 0.25 + 1.0/192.0;

			trap_R_DrawStretchPic(
				ax, ay, aw, ah,
				fcol, frow, fcol+0.125-(2.0/168.0), frow+0.25-(2.0/192.0),
				charset
			);
#endif
		}

		ax += aw;
		s++;
	}

	trap_R_SetColor( NULL );
}

/*
=================
JUHOX: UI_DrawStrlen

Returns character count, skiping color escape codes
Exact copy of CG_DrawStrlen()
=================
*/
int UI_DrawStrlen(const char *str) {
	const char *s = str;
	int count = 0;

	while (*s) {
		if (Q_IsColorString(s)) {
			s += 2;
		} else {
			count++;
			s++;
		}
	}

	return count;
}

/*
=================
UI_DrawString
=================
*/
void UI_DrawString( int x, int y, const char* str, int style, vec4_t color )
{
	int		len;
	int		charw;
	int		charh;
	vec4_t	newcolor;
	vec4_t	lowlight;
	float	*drawcolor;
	vec4_t	dropcolor;

	if( !str ) {
		return;
	}

	if ((style & UI_BLINK) && ((uis.realtime/BLINK_DIVISOR) & 1))
		return;

	if (style & UI_SMALLFONT)
	{
		charw =	SMALLCHAR_WIDTH;
		charh =	SMALLCHAR_HEIGHT;
	}
	else if (style & UI_GIANTFONT)
	{
		charw =	GIANTCHAR_WIDTH;
		charh =	GIANTCHAR_HEIGHT;
	}
	else
	{
		charw =	BIGCHAR_WIDTH;
		charh =	BIGCHAR_HEIGHT;
	}

	if (style & UI_PULSE)
	{
		lowlight[0] = 0.8*color[0]; 
		lowlight[1] = 0.8*color[1];
		lowlight[2] = 0.8*color[2];
		lowlight[3] = 0.8*color[3];
		UI_LerpColor(color,lowlight,newcolor,0.5+0.5*sin(uis.realtime/PULSE_DIVISOR));
		drawcolor = newcolor;
	}	
	else
		drawcolor = color;

	switch (style & UI_FORMATMASK)
	{
		case UI_CENTER:
			// center justify at x
			// JUHOX: use UI_DrawStrlen() instead of strlen
#if 0
			len = strlen(str);
#else
			len = UI_DrawStrlen(str);
#endif
			x   = x - len*charw/2;
			break;

		case UI_RIGHT:
			// right justify at x
			// JUHOX: use UI_DrawStrlen() instead of strlen
#if 0
			len = strlen(str);
#else
			len = UI_DrawStrlen(str);
#endif
			x   = x - len*charw;
			break;

		default:
			// left justify at x
			break;
	}

	if ( style & UI_DROPSHADOW )
	{
		dropcolor[0] = dropcolor[1] = dropcolor[2] = 0;
		dropcolor[3] = drawcolor[3];
		UI_DrawString2(x+2,y+2,str,dropcolor,charw,charh);
	}

	UI_DrawString2(x,y,str,drawcolor,charw,charh);
}

/*
=================
UI_DrawChar
=================
*/
void UI_DrawChar( int x, int y, int ch, int style, vec4_t color )
{
	char	buff[2];

	buff[0] = ch;
	buff[1] = '\0';

	UI_DrawString( x, y, buff, style, color );
}

qboolean UI_IsFullscreen( void ) {
	if ( uis.activemenu && ( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
		return uis.activemenu->fullscreen;
	}

	return qfalse;
}

static void NeedCDAction( qboolean result ) {
	if ( !result ) {
		trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
	}
}

static void NeedCDKeyAction( qboolean result ) {
	if ( !result ) {
		trap_Cmd_ExecuteText( EXEC_APPEND, "quit\n" );
	}
}

void UI_SetActiveMenu( uiMenuCommand_t menu ) {
	// this should be the ONLY way the menu system is brought up
	// enusure minumum menu data is cached
	Menu_Cache();

	switch ( menu ) {
	case UIMENU_NONE:
		UI_ForceMenuOff();
		return;
	case UIMENU_MAIN:
		UI_MainMenu();
		return;
	case UIMENU_NEED_CD:
		UI_ConfirmMenu( "Insert the CD", (voidfunc_f)NULL, NeedCDAction );
		return;
	case UIMENU_BAD_CD_KEY:
		UI_ConfirmMenu( "Bad CD Key", (voidfunc_f)NULL, NeedCDKeyAction );
		return;
	case UIMENU_INGAME:
		/*
		//GRank
		UI_RankingsMenu();
		return;
		*/
		trap_Cvar_Set( "cl_paused", "1" );
		UI_InGameMenu();
		return;
	// bk001204
	case UIMENU_TEAM:
	case UIMENU_POSTGAME:
	default:
#ifndef NDEBUG
	  Com_Printf("UI_SetActiveMenu: bad enum %d\n", menu );
#endif
	  break;
	}
}

// JUHOX: definitions for event buffer
#if 1
typedef struct {
	int sequence;
	int data1;
	int data2;
} ui_tssiEvent_t;
#define TSSI_EVENTBUFFER_SIZE 10
typedef struct {
	const char* cvar;
	int sequenceCounter;
	ui_tssiEvent_t events[TSSI_EVENTBUFFER_SIZE];
} ui_tssiEventBuffer_t;
#endif

static ui_tssiEventBuffer_t tssiKeyEvents;	// JUHOX
static ui_tssiEventBuffer_t tssiMouseEvents;	// JUHOX

/*
=================
JUHOX: UITSSI_InitEventBuffer
=================
*/
static void UITSSI_InitEventBuffer(ui_tssiEventBuffer_t* buffer, const char* cvar) {
	buffer->cvar = cvar;
	buffer->sequenceCounter = 0;
	memset(&buffer->events, -1, sizeof(buffer->events));
	trap_Cvar_Set(cvar, "");
}

/*
=================
JUHOX: UITSSI_AddEventToBuffer
=================
*/
static void UITSSI_AddEventToBuffer(ui_tssiEventBuffer_t* buffer, int data1, int data2) {
	ui_tssiEvent_t* event;
	int i;
	char varbuf[1024];

	if (!buffer->cvar) return;

	event = &buffer->events[buffer->sequenceCounter % TSSI_EVENTBUFFER_SIZE];
	
	event->sequence = buffer->sequenceCounter;
	event->data1 = data1;
	event->data2 = data2;

	Com_sprintf(varbuf, sizeof(varbuf), "%d/", buffer->sequenceCounter);	// so the client detects the modification

	for (i = 0; i < TSSI_EVENTBUFFER_SIZE; i++) {
		char s[64];

		event = &buffer->events[(buffer->sequenceCounter + i + 1) % TSSI_EVENTBUFFER_SIZE];

		Com_sprintf(s, sizeof(s), "%d/%d/%d/", event->sequence, event->data1, event->data2);

		Q_strcat(varbuf, sizeof(varbuf), s);
	}
	trap_Cvar_Set(buffer->cvar, varbuf);
	buffer->sequenceCounter++;
}

/*
=================
JUHOX: UI_CloseTSSInterface
=================
*/
static void UI_CloseTSSInterface(void) {
	uis.tssInterfaceOpen = qfalse;
	trap_Cvar_Set("tssi_mouse", "*");
	trap_Cvar_Set("tssi_key", "*");
	if (!uis.activemenu) trap_Key_SetCatcher(trap_Key_GetCatcher() & ~KEYCATCH_UI);
}

/*
=================
JUHOX: UI_OpenTSSInterface
=================
*/
static void UI_OpenTSSInterface(void) {
	UITSSI_InitEventBuffer(&tssiMouseEvents, "tssi_mouse");
	UITSSI_InitEventBuffer(&tssiKeyEvents, "tssi_key");

	uis.tssInterfaceOpen = qtrue;
	trap_Key_SetCatcher(trap_Key_GetCatcher() | KEYCATCH_UI);
}

/*
=================
UI_KeyEvent
=================
*/
void UI_KeyEvent( int key, int down ) {
	sfxHandle_t		s;

	// JUHOX: send key events to cgame when TSS Interface open
#if 1
	if (uis.tssInterfaceOpen) {
		if (key == K_ESCAPE && down) {
			UI_CloseTSSInterface();
			return;
		}
		UITSSI_AddEventToBuffer(&tssiKeyEvents, key, down);
		return;
	}
#endif

	if (!uis.activemenu) {
		return;
	}

	if (!down) {
		return;
	}

	if (uis.activemenu->key)
		s = uis.activemenu->key( key );
	else
		s = Menu_DefaultKey( uis.activemenu, key );

	if ((s > 0) && (s != menu_null_sound))
		trap_S_StartLocalSound( s, CHAN_LOCAL_SOUND );
}

/*
=================
UI_MouseEvent
=================
*/
void UI_MouseEvent( int dx, int dy )
{
	int				i;
	menucommon_s*	m;

	// JUHOX: send mouse events to cgame when TSS Interface open
#if 1
	if (uis.tssInterfaceOpen) {
		UITSSI_AddEventToBuffer(&tssiMouseEvents, dx, dy);
		return;
	}
#endif

	if (!uis.activemenu)
		return;

	// update mouse screen position
	uis.cursorx += dx;
	if (uis.cursorx < 0)
		uis.cursorx = 0;
	else if (uis.cursorx > SCREEN_WIDTH)
		uis.cursorx = SCREEN_WIDTH;

	uis.cursory += dy;
	if (uis.cursory < 0)
		uis.cursory = 0;
	else if (uis.cursory > SCREEN_HEIGHT)
		uis.cursory = SCREEN_HEIGHT;

	// region test the active menu items
	for (i=0; i<uis.activemenu->nitems; i++)
	{
		m = (menucommon_s*)uis.activemenu->items[i];

		if (m->flags & (QMF_GRAYED|QMF_INACTIVE))
			continue;

		if ((uis.cursorx < m->left) ||
			(uis.cursorx > m->right) ||
			(uis.cursory < m->top) ||
			(uis.cursory > m->bottom))
		{
			// cursor out of item bounds
			continue;
		}

		// set focus to item at cursor
		if (uis.activemenu->cursor != i)
		{
			Menu_SetCursor( uis.activemenu, i );
			((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor_prev]))->flags &= ~QMF_HASMOUSEFOCUS;

			if ( !(((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor]))->flags & QMF_SILENT ) ) {
				trap_S_StartLocalSound( menu_move_sound, CHAN_LOCAL_SOUND );
			}
		}

		((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor]))->flags |= QMF_HASMOUSEFOCUS;
		return;
	}  

	if (uis.activemenu->nitems > 0) {
		// out of any region
		((menucommon_s*)(uis.activemenu->items[uis.activemenu->cursor]))->flags &= ~QMF_HASMOUSEFOCUS;
	}
}

char *UI_Argv( int arg ) {
	static char	buffer[MAX_STRING_CHARS];

	trap_Argv( arg, buffer, sizeof( buffer ) );

	return buffer;
}


char *UI_Cvar_VariableString( const char *var_name ) {
	static char	buffer[MAX_STRING_CHARS];

	trap_Cvar_VariableStringBuffer( var_name, buffer, sizeof( buffer ) );

	return buffer;
}


/*
=================
UI_Cache
=================
*/
void UI_Cache_f( void ) {
	MainMenu_Cache();
	InGame_Cache();
	ConfirmMenu_Cache();
	PlayerModel_Cache();
	PlayerSettings_Cache();
	Controls_Cache();
	Demos_Cache();
	UI_CinematicsMenu_Cache();
	Preferences_Cache();
	ServerInfo_Cache();
	SpecifyServer_Cache();
	ArenaServers_Cache();
	StartServer_Cache();
	ServerOptions_Cache();
	DriverInfo_Cache();
	GraphicsOptions_Cache();
	UI_DisplayOptionsMenu_Cache();
	UI_SoundOptionsMenu_Cache();
	UI_NetworkOptionsMenu_Cache();
	UI_SPLevelMenu_Cache();
	UI_SPSkillMenu_Cache();
	UI_SPPostgameMenu_Cache();
	TeamMain_Cache();
	UI_AddBots_Cache();
	UI_RemoveBots_Cache();
	UI_SetupMenu_Cache();
//	UI_LoadConfig_Cache();
//	UI_SaveConfigMenu_Cache();
	UI_BotSelectMenu_Cache();
	UI_CDKeyMenu_Cache();
	UI_ModsMenu_Cache();

}


/*
=================
JUHOX: UI_SvTemplate_f
=================
*/
static void UI_SvTemplate_f(void) {
	int number;
	int highscoreType;
	char name[64];
	char highscore[32];
	char descriptor[MAX_STRING_CHARS];

	if (trap_Argc() != 6) return;

	number = atoi(UI_Argv(1));
	trap_Argv(2, name, sizeof(name));
	highscoreType = atoi(UI_Argv(3));
	trap_Argv(4, highscore, sizeof(highscore));
	trap_Argv(5, descriptor, sizeof(descriptor));

	UI_TemplateList_SvTemplate(number, name, highscoreType, highscore, descriptor);
}

/*
=================
JUHOX: UI_TemplateList_Complete_f
=================
*/
static void UI_TemplateList_Complete_f(void) {
	int number;
	long checksum;

	if (trap_Argc() != 3) return;

	number = atoi(UI_Argv(1));
	checksum = atoi(UI_Argv(2));

	UI_TemplateList_Complete(number, checksum);
}

/*
=================
JUHOX: UI_TmplName_f
=================
*/
static void UI_TmplName_f(void) {
	int len;

	uis.templateName[0] = 0;
	uis.templateCounter = 0;

	if (!uis.loadingTemplates) return;
	if (trap_Argc() != 2) return;

	Q_strncpyz(uis.templateName, UI_Argv(1), sizeof(uis.templateName));
	len = strlen(uis.templateName);
	if (len >= 5) {
		if (!Q_stricmp(&uis.templateName[len-5], ".tmpl")) {
			uis.templateName[len-5] = 0;
		}
	}
}

/*
=================
JUHOX: UI_DefTemplate_f
=================
*/
static void UI_DefTemplate_f(void) {
	char cvarName[MAX_STRING_CHARS];
	char* tmpl;
	char* name;

	if (!uis.loadingTemplates) return;
	if (!uis.templateName[0]) return;
	if (trap_Argc() != 2) return;

	tmpl = UI_Argv(1);
	if (!Info_Validate(tmpl)) return;
	name = Info_ValueForKey(tmpl, "name");
	if (!name[0]) return;

	Com_sprintf(cvarName, sizeof(cvarName), "%s%03d", uis.templateName, uis.templateCounter);
	trap_Cvar_Register(NULL, cvarName, "", CVAR_ROM | CVAR_NORESTART);
	trap_Cvar_Set(cvarName, tmpl);
	
	uis.templateCounter++;
}

/*
=================
JUHOX: UI_TemplatesComplete_f
=================
*/
static void UI_TemplatesComplete_f(void) {
	uis.loadingTemplates = qfalse;
}

/*
=================
JUHOX: UI_LFEdit_f
=================
*/
#if MAPLENSFLARES
static void UI_LFEdit_f(void) {
	const char* mapname;

	if (trap_Argc() != 2) return;

	mapname = UI_Argv(1);
	if (!mapname) return;
	if (!mapname[0]) return;

	trap_Cvar_SetValue("sv_maxclients", 1);
	trap_Cvar_SetValue("dedicated", 0);
	trap_Cvar_SetValue("sv_pure", 0);
	trap_Cvar_SetValue("g_editmode", EM_mlf);
	trap_Cvar_SetValue("g_gametype", 0);

	// the wait commands will allow the dedicated to take effect
	trap_Cmd_ExecuteText(EXEC_APPEND, va( "wait ; wait ; devmap %s\n", mapname));
}
#endif

/*
=================
JUHOX: UI_TSSData_f
=================
*/
#if TSSINCVAR
static void UI_TSSData_f(void) {
	int index;
	char cvarName[32];

	if (trap_Argc() != 3) return;

	index = atoi(UI_Argv(1));
	if (index == 0) {
		char filename[TSS_NAME_SIZE];

		uis.numTssEntries++;
		trap_Cvar_VariableStringBuffer("tsstmp", filename, sizeof(filename));
		if (!filename[0]) return;
		Com_sprintf(cvarName, sizeof(cvarName), "tsspak%03dn", uis.numTssEntries);
		trap_Cvar_Register(NULL, cvarName, "", CVAR_ROM);
		trap_Cvar_Set(cvarName, filename);
	}

	if (uis.numTssEntries < 0) return;
	if (uis.numTssEntries >= TSS_MAX_STRATEGIES) return;

	Com_sprintf(cvarName, sizeof(cvarName), "tsspak%03d%d", uis.numTssEntries, index);
	trap_Cvar_Register(NULL, cvarName, "", CVAR_ROM);
	trap_Cvar_Set(cvarName, UI_Argv(2));
}
#endif

/*
=================
JUHOX: UI_AddTrack_f
=================
*/
#if PLAYLIST
static void UI_AddTrack_f(void) {
	char introPart[128];
	char mainPart[128];
	int rep;
	char name[16];
	char info[MAX_INFO_STRING];

	if (!uis.loadPlayList) return;
	if (uis.currentTrack >= MAX_PLAYLIST_ENTRIES) return;

	Q_strncpyz(introPart, UI_Argv(1), sizeof(introPart));
	Q_strncpyz(mainPart, UI_Argv(2), sizeof(mainPart));
	rep = atoi(UI_Argv(3));
	if (!UI_Argv(3)[0]) rep = 1;
	if (!mainPart[0]) rep = 1;
	Com_sprintf(info, sizeof(info), "intro\\%s\\main\\%s\\rep\\%d", introPart, mainPart, rep);

	Com_sprintf(name, sizeof(name), "playlist%02d", uis.currentTrack);

	trap_Cvar_Register(NULL, name, "", CVAR_ROM);
	trap_Cvar_Set(name, info);

	uis.currentTrack++;
}
#endif

/*
=================
JUHOX: UI_PlayListComplete_f
=================
*/
#if PLAYLIST
static void UI_PlayListComplete_f(void) {
	uis.loadPlayList = qfalse;
}
#endif

/*
=================
UI_ConsoleCommand
=================
*/
qboolean UI_ConsoleCommand( int realTime ) {
	char	*cmd;

	cmd = UI_Argv( 0 );

	// ensure minimum menu data is available
	Menu_Cache();

	if ( Q_stricmp (cmd, "levelselect") == 0 ) {
		UI_SPLevelMenu_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "postgame") == 0 ) {
		UI_SPPostgameMenu_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "ui_cache") == 0 ) {
		UI_Cache_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "ui_cinematics") == 0 ) {
		UI_CinematicsMenu_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "ui_teamOrders") == 0 ) {
		UI_TeamOrdersMenu_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "iamacheater") == 0 ) {
		UI_SPUnlock_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "iamamonkey") == 0 ) {
		UI_SPUnlockMedals_f();
		return qtrue;
	}

	if ( Q_stricmp (cmd, "ui_cdkey") == 0 ) {
		UI_CDKeyMenu_f();
		return qtrue;
	}

#if 1	// JUHOX: TSS Interface commands
	if (Q_stricmp(cmd, "tssiopen") == 0) {
		UI_OpenTSSInterface();
		return qtrue;
	}
	if (Q_stricmp(cmd, "tssiclose") == 0) {
		UI_CloseTSSInterface();
		return qtrue;
	}
#endif

#if 1	// JUHOX: template list commands
	if (Q_stricmp(cmd, "sv_template_ui") == 0) {
		UI_SvTemplate_f();
		return qtrue;
	}
	if (Q_stricmp(cmd, "templatelist_complete_ui") == 0) {
		UI_TemplateList_Complete_f();
		return qtrue;
	}
#endif

#if 1	// JUHOX: template load commands
	if (uis.loadingTemplates) {
		if (Q_stricmp(cmd, "tmplname") == 0) {
			UI_TmplName_f();
			return qtrue;
		}
		if (Q_stricmp(cmd, "deftemplate") == 0) {
			UI_DefTemplate_f();
			return qtrue;
		}
		if (Q_stricmp(cmd, "templatescomplete") == 0) {
			UI_TemplatesComplete_f();
			return qtrue;
		}
	}
#endif

#if MAPLENSFLARES	// JUHOX: commands for map lens flares
	if (Q_stricmp(cmd, "lfedit") == 0) {
		UI_LFEdit_f();
		return qtrue;
	}
#endif

#if TSSINCVAR	// JUHOX: commands for loading TSS files
	if (Q_stricmp(cmd, "tssdata") == 0) {
		UI_TSSData_f();
		return qtrue;
	}
#endif

#if PLAYLIST	// JUHOX: playlist commands
	if (Q_stricmp(cmd, "addtrack") == 0) {
		UI_AddTrack_f();
		return qtrue;
	}
	if (Q_stricmp(cmd, "playlistcomplete") == 0) {
		UI_PlayListComplete_f();
		return qtrue;
	}
#endif

	return qfalse;
}

/*
=================
UI_Shutdown
=================
*/
void UI_Shutdown( void ) {
}

/*
=================
JUHOX: UI_LoadGameTemplates
=================
*/
static void UI_LoadGameTemplates(void) {
	int i;
	const char* name;
	char buf[MAX_STRING_CHARS];
	char* p;

	trap_Cvar_VariableStringBuffer("tmplfiles", buf, sizeof(buf));
	//if (!trap_Cvar_VariableValue("sv_running")) {
	if (!buf[0]) {
		uis.numTemplateFiles = trap_FS_GetFileList("templates", ".tmpl", uis.templateFileList, sizeof(uis.templateFileList));

		p = buf;
		name = uis.templateFileList;
		trap_Cmd_ExecuteText(EXEC_INSERT, "templatescomplete\n");
		for (i = 0; i < uis.numTemplateFiles; i++) {
			int n;

			uis.loadingTemplates = qtrue;
			trap_Cmd_ExecuteText(EXEC_INSERT, va("tmplname %s; exec templates/%s\n", name, name));
			n = strlen(name);
			if (i > 0) *(p++) = '\\';
			strcpy(p, name);
			p += n;
			name += n + 1;
		}
		if (!buf[0]) Q_strncpyz(buf, "*", sizeof(buf));
		trap_Cvar_Set("tmplfiles", buf);
	}
	else if (buf[0] != '*') {
		//trap_Cvar_VariableStringBuffer("tmplfiles", uis.templateFileList, sizeof(uis.templateFileList));
		Q_strncpyz(uis.templateFileList, buf, sizeof(uis.templateFileList));
		p = uis.templateFileList;
		uis.numTemplateFiles = 0;
		while (*p) {
			if (*p == '\\') {
				*p = 0;
				uis.numTemplateFiles++;
			}
			p++;
		}
		if (p > uis.templateFileList) uis.numTemplateFiles++;
	}
}

/*
=================
UI_Init
=================
*/
void UI_Init( void ) {
	UI_RegisterCvars();

	// JUHOX: make sure cg_weaponOrderXXX cvars are up to date
#if MONSTER_MODE
	{
		int i;

		for (i = 0; i < 6; i++) {
			char name[32];
			char buf[32];

			Com_sprintf(name, sizeof(name), "cg_weaponOrder%d", i);
			trap_Cvar_VariableStringBuffer(name, buf, sizeof(buf));
			if (strlen(buf) < 10) {
				trap_Cvar_Reset(name);
				trap_Cvar_Reset(va("cg_weaponOrder%dName", i));
			}
		}
	}
#endif

	UI_InitGameinfo();

	// cache redundant calulations
	trap_GetGlconfig( &uis.glconfig );

	// for 640x480 virtualized screen
	// JUHOX: wide screen option not very helpful; instead scale X & Y independent from each other
#if 0
	uis.scale = uis.glconfig.vidHeight * (1.0/480.0);
	if ( uis.glconfig.vidWidth * 480 > uis.glconfig.vidHeight * 640 ) {
		// wide screen
		uis.bias = 0.5 * ( uis.glconfig.vidWidth - ( uis.glconfig.vidHeight * (640.0/480.0) ) );
	}
	else {
		// no wide screen
		uis.bias = 0;
	}
#else
	uis.scaleX = uis.glconfig.vidWidth / 640.0;
	uis.scaleY = uis.glconfig.vidHeight / 480.0;
#endif

	// initialize the menu system
	Menu_Cache();

	uis.activemenu = NULL;
	uis.menusp     = 0;

	UI_LoadGameTemplates();	// JUHOX

	// JUHOX: load playlist
#if PLAYLIST
	uis.loadPlayList = qtrue;
	uis.currentTrack = 0;
	trap_Cmd_ExecuteText(EXEC_INSERT, "exec playlist.cfg; playlistcomplete\n");
#endif
}

/*
================
UI_AdjustFrom640

Adjusted for resolution and screen aspect ratio
================
*/
void UI_AdjustFrom640( float *x, float *y, float *w, float *h ) {
	// expect valid pointers
	// JUHOX: apply the new scaling
#if 0
	*x = *x * uis.scale + uis.bias;
	*y *= uis.scale;
	*w *= uis.scale;
	*h *= uis.scale;
#else
	*x *= uis.scaleX;
	*y *= uis.scaleY;
	*w *= uis.scaleX;
	*h *= uis.scaleY;
#endif
}

void UI_DrawNamedPic( float x, float y, float width, float height, const char *picname ) {
	qhandle_t	hShader;

	hShader = trap_R_RegisterShaderNoMip( picname );
	UI_AdjustFrom640( &x, &y, &width, &height );
	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 1, 1, hShader );
}

void UI_DrawHandlePic( float x, float y, float w, float h, qhandle_t hShader ) {
	float	s0;
	float	s1;
	float	t0;
	float	t1;

	if( w < 0 ) {	// flip about vertical
		w  = -w;
		s0 = 1;
		s1 = 0;
	}
	else {
		s0 = 0;
		s1 = 1;
	}

	if( h < 0 ) {	// flip about horizontal
		h  = -h;
		t0 = 1;
		t1 = 0;
	}
	else {
		t0 = 0;
		t1 = 1;
	}
	
	UI_AdjustFrom640( &x, &y, &w, &h );
	trap_R_DrawStretchPic( x, y, w, h, s0, t0, s1, t1, hShader );
}

/*
================
UI_FillRect

Coordinates are 640*480 virtual values
=================
*/
void UI_FillRect( float x, float y, float width, float height, const float *color ) {
	trap_R_SetColor( color );

	UI_AdjustFrom640( &x, &y, &width, &height );
	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 0, 0, uis.whiteShader );

	trap_R_SetColor( NULL );
}

/*
================
UI_DrawRect

Coordinates are 640*480 virtual values
=================
*/
void UI_DrawRect( float x, float y, float width, float height, const float *color ) {
	trap_R_SetColor( color );

	UI_AdjustFrom640( &x, &y, &width, &height );

	trap_R_DrawStretchPic( x, y, width, 1, 0, 0, 0, 0, uis.whiteShader );
	trap_R_DrawStretchPic( x, y, 1, height, 0, 0, 0, 0, uis.whiteShader );
	trap_R_DrawStretchPic( x, y + height - 1, width, 1, 0, 0, 0, 0, uis.whiteShader );
	trap_R_DrawStretchPic( x + width - 1, y, 1, height, 0, 0, 0, 0, uis.whiteShader );

	trap_R_SetColor( NULL );
}

void UI_SetColor( const float *rgba ) {
	trap_R_SetColor( rgba );
}

void UI_UpdateScreen( void ) {
	trap_UpdateScreen();
}

/*
=================
JUHOX: UI_DrawBackPic
=================
*/
void UI_DrawBackPic(qboolean drawPic) {
	float x, y, w, h;

	if (!drawPic) {
		UI_FillRect(0, 0, 640, 480, colorBlack);
	}
	else {
		x = 0;
		y = 0;
		w = 640;
		h = 480;
		UI_AdjustFrom640(&x, &y, &w, &h);
		trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 768.0/1024.0, uis.menuBackShader);
	}
}

/*
=================
JUHOX: UI_LensFlare
=================
*/
static void UI_LensFlare(float pos, qhandle_t shader, float radius, float r, float g, float b, float alpha) {
	vec4_t color;
	float x, y, w, h;

	color[0] = r;
	color[1] = g;
	color[2] = b;
	color[3] = alpha / radius;
	if (color[3] > 1) color[3] = 1;
	trap_R_SetColor(color);

	radius *= 64;
	x = 320 + pos * (uis.cursorx - 320) - 0.5 * radius;
	y = 240 + pos * (uis.cursory - 240) - 0.5 * radius;
	w = radius;
	h = radius;
	UI_AdjustFrom640(&x, &y, &w, &h);
	trap_R_DrawStretchPic(x, y, w, h, 0, 0, 1, 1, shader);
}

/*
=================
JUHOX: UI_CursorLensFlares
=================
*/
static void UI_CursorLensFlares(void) {
	const float alpha = 0.09;

	UI_LensFlare(3, uis.lfRing, 1.7, 1, 1, 1, alpha);
	UI_LensFlare(1.5, uis.lfDisc, 0.9, 1, 0.667, 0.667, alpha);
	UI_LensFlare(1, uis.lfGlare, 0.5, 1, 1, 1, 2.5 * alpha);
	/*
	UI_LensFlare(1, uis.cursorCore1, 0.5, 1, 1, 1, 0.15 * alpha);
	UI_LensFlare(1, uis.cursorCore2, 0.5, 1, 1, 1, 0.15 * alpha);
	UI_LensFlare(1, uis.cursorCore3, 0.5, 1, 1, 1, 0.15 * alpha);
	*/
	UI_LensFlare(1, uis.lfGlare, 0.8, 0.5, 0.7, 1, 5 * alpha);
	UI_LensFlare(1, uis.lfGlare, 2, 1, 1, 1, 5 * alpha);
	UI_LensFlare(1, uis.lfStar, 1.5, 1, 1, 1, 5 * alpha);
	UI_LensFlare(0.5, uis.lfDisc, 1.5, 0.667, 1, 1, alpha);
	UI_LensFlare(0.3, uis.lfRing, 1, 0.75, 1, 0.75, alpha);
	UI_LensFlare(0.07, uis.lfDisc, 0.7, 0.82, 1, 0.92, alpha);
	UI_LensFlare(-0.25, uis.lfRing, 1.4, 0.9, 1, 1, alpha);
	UI_LensFlare(-0.45, uis.lfDisc, 0.2, 0.75, 1, 1, alpha);
	UI_LensFlare(-0.6, uis.lfDisc, 0.4, 1, 0.78, 1, alpha);
	UI_LensFlare(-0.72, uis.lfDisc, 1.1, 1, 0.78, 0.667, alpha);
	UI_LensFlare(-1.0, uis.lfRing, 2, 1, 1, 0.5, alpha);
	UI_LensFlare(-3.4, uis.lfDisc, 1.3, 0.92, 0.96, 1, alpha);

	trap_R_SetColor(NULL);
}

/*
=================
UI_Refresh
=================
*/
void UI_Refresh( int realtime )
{
	uis.frametime = realtime - uis.realtime;
	uis.realtime  = realtime;

	if ( !( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
		return;
	}

	// JUHOX: draw precaching pacifier
#if 1
	if (uis.precaching) {
		UI_FillRect(0, 0, 640, 480, colorBlack);
		UI_DrawString(320, 180, "PRECACHING...", UI_CENTER, colorWhite);
		switch (uis.precaching) {
		case 1:
			uis.precaching = 2;
			break;
		case 2:
			uis.precaching = 0;
			UI_Cache_f();
			break;
		}
		return;
	}
#endif

	// JUHOX: no UI drawing with TSS Interface open
#if 1
	if (uis.tssInterfaceOpen) {
		if (uis.activemenu) {
			UI_CloseTSSInterface();
		}
		return;
	}
#endif

	UI_UpdateCvars();

	if ( uis.activemenu )
	{
		if (uis.activemenu->fullscreen)
		{
			// draw the background
			// JUHOX: new background
#if 0
			if( uis.activemenu->showlogo ) {
				UI_DrawHandlePic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, uis.menuBackShader );
			}
			else {
				UI_DrawHandlePic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, uis.menuBackNoLogoShader );
			}
#else
			UI_DrawBackPic(!uis.activemenu->blackBack);

			if (uis.activemenu->showlogo) {
				UI_DrawHandlePic(30, 35, 580, 36, uis.menuBackTitleShader);	// "H U N T"
			}
			else {
				static float darken[4] = {0, 0, 0, 0.55};

				UI_FillRect(0, 0, 640, 480, darken);
			}
#endif
		}

		if (uis.activemenu->draw)
			uis.activemenu->draw();
		else
			Menu_Draw( uis.activemenu );

		if( uis.firstdraw ) {
			UI_MouseEvent( 0, 0 );
			uis.firstdraw = qfalse;
		}
	}

	// draw cursor
	// JUHOX: draw lens flare cursor
#if 0
	UI_SetColor( NULL );
	UI_DrawHandlePic( uis.cursorx-16, uis.cursory-16, 32, 32, uis.cursor);
#else
	if (uis.activemenu && uis.activemenu->noCursor) {
		// no cursor
	}
	else if (ui_lensFlare.integer) {
		UI_CursorLensFlares();
	}
	else
	{
		UI_SetColor( NULL );
		UI_DrawHandlePic( uis.cursorx-16, uis.cursory-16, 32, 32, uis.cursor);
	}
#endif

#ifndef NDEBUG
	if (uis.debug)
	{
		// cursor coordinates
		UI_DrawString( 0, 0, va("(%d,%d)",uis.cursorx,uis.cursory), UI_LEFT|UI_SMALLFONT, colorRed );
	}
#endif

	// delay playing the enter sound until after the
	// menu has been drawn, to avoid delay while
	// caching images
	if (m_entersound)
	{
		trap_S_StartLocalSound( menu_in_sound, CHAN_LOCAL_SOUND );
		m_entersound = qfalse;
	}
}

void UI_DrawTextBox (int x, int y, int width, int lines)
{
	UI_FillRect( x + BIGCHAR_WIDTH/2, y + BIGCHAR_HEIGHT/2, ( width + 1 ) * BIGCHAR_WIDTH, ( lines + 1 ) * BIGCHAR_HEIGHT, colorBlack );
	UI_DrawRect( x + BIGCHAR_WIDTH/2, y + BIGCHAR_HEIGHT/2, ( width + 1 ) * BIGCHAR_WIDTH, ( lines + 1 ) * BIGCHAR_HEIGHT, colorWhite );
}

qboolean UI_CursorInRect (int x, int y, int width, int height)
{
	if (uis.cursorx < x ||
		uis.cursory < y ||
		uis.cursorx > x+width ||
		uis.cursory > y+height)
		return qfalse;

	return qtrue;
}
