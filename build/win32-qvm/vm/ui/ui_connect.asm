data
export passwordNeeded
align 4
LABELV passwordNeeded
byte 4 1
code
proc UI_ReadableSize 12 16
file "..\..\..\..\code\q3_ui\ui_connect.c"
line 20
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:#include "ui_local.h"
;4:
;5:/*
;6:===============================================================================
;7:
;8:CONNECTION SCREEN
;9:
;10:===============================================================================
;11:*/
;12:
;13:qboolean	passwordNeeded = qtrue;
;14:menufield_s passwordField;
;15:
;16:static connstate_t	lastConnState;
;17:static char			lastLoadingText[MAX_INFO_VALUE];
;18:
;19:static void UI_ReadableSize ( char *buf, int bufsize, int value )
;20:{
line 21
;21:	if (value > 1024*1024*1024 ) { // gigs
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
LEI4 $97
line 22
;22:		Com_sprintf( buf, bufsize, "%d", value / (1024*1024*1024) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $99
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 23
;23:		Com_sprintf( buf+strlen(buf), bufsize-strlen(buf), ".%02d GB", 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRGP4 $100
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
MODI4
CNSTI4 100
MULI4
CNSTI4 1073741824
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 25
;24:			(value % (1024*1024*1024))*100 / (1024*1024*1024) );
;25:	} else if (value > 1024*1024 ) { // megs
ADDRGP4 $98
JUMPV
LABELV $97
ADDRFP4 8
INDIRI4
CNSTI4 1048576
LEI4 $101
line 26
;26:		Com_sprintf( buf, bufsize, "%d", value / (1024*1024) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $99
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1048576
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 27
;27:		Com_sprintf( buf+strlen(buf), bufsize-strlen(buf), ".%02d MB", 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRGP4 $103
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1048576
MODI4
CNSTI4 100
MULI4
CNSTI4 1048576
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 29
;28:			(value % (1024*1024))*100 / (1024*1024) );
;29:	} else if (value > 1024 ) { // kilos
ADDRGP4 $102
JUMPV
LABELV $101
ADDRFP4 8
INDIRI4
CNSTI4 1024
LEI4 $104
line 30
;30:		Com_sprintf( buf, bufsize, "%d KB", value / 1024 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $106
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1024
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 31
;31:	} else { // bytes
ADDRGP4 $105
JUMPV
LABELV $104
line 32
;32:		Com_sprintf( buf, bufsize, "%d bytes", value );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $107
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 33
;33:	}
LABELV $105
LABELV $102
LABELV $98
line 34
;34:}
LABELV $96
endproc UI_ReadableSize 12 16
proc UI_PrintTime 4 20
line 37
;35:
;36:// Assumes time is in msec
;37:static void UI_PrintTime ( char *buf, int bufsize, int time ) {
line 38
;38:	time /= 1000;  // change to seconds
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 40
;39:
;40:	if (time > 3600) { // in the hours range
ADDRFP4 8
INDIRI4
CNSTI4 3600
LEI4 $109
line 41
;41:		Com_sprintf( buf, bufsize, "%d hr %d min", time / 3600, (time % 3600) / 60 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $111
ARGP4
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3600
DIVI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 3600
MODI4
CNSTI4 60
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 42
;42:	} else if (time > 60) { // mins
ADDRGP4 $110
JUMPV
LABELV $109
ADDRFP4 8
INDIRI4
CNSTI4 60
LEI4 $112
line 43
;43:		Com_sprintf( buf, bufsize, "%d min %d sec", time / 60, time % 60 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $114
ARGP4
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 60
MODI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 44
;44:	} else  { // secs
ADDRGP4 $113
JUMPV
LABELV $112
line 45
;45:		Com_sprintf( buf, bufsize, "%d sec", time );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $115
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 46
;46:	}
LABELV $113
LABELV $110
line 47
;47:}
LABELV $108
endproc UI_PrintTime 4 20
lit
align 1
LABELV $117
byte 1 68
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 0
align 1
LABELV $118
byte 1 69
byte 1 115
byte 1 116
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 32
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 32
byte 1 108
byte 1 101
byte 1 102
byte 1 116
byte 1 58
byte 1 0
align 1
LABELV $119
byte 1 84
byte 1 114
byte 1 97
byte 1 110
byte 1 115
byte 1 102
byte 1 101
byte 1 114
byte 1 32
byte 1 114
byte 1 97
byte 1 116
byte 1 101
byte 1 58
byte 1 0
code
proc UI_DisplayDownloadInfo 340 20
line 49
;48:
;49:static void UI_DisplayDownloadInfo( const char *downloadName ) {
line 58
;50:	static char dlText[]	= "Downloading:";
;51:	static char etaText[]	= "Estimated time left:";
;52:	static char xferText[]	= "Transfer rate:";
;53:
;54:	int downloadSize, downloadCount, downloadTime;
;55:	char dlSizeBuf[64], totalSizeBuf[64], xferRateBuf[64], dlTimeBuf[64];
;56:	int xferRate;
;57:	int width, leftWidth;
;58:	int style = UI_LEFT|UI_SMALLFONT|UI_DROPSHADOW;
ADDRLP4 0
CNSTI4 2064
ASGNI4
line 61
;59:	const char *s;
;60:
;61:	downloadSize = trap_Cvar_VariableValue( "cl_downloadSize" );
ADDRGP4 $120
ARGP4
ADDRLP4 288
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 288
INDIRF4
CVFI4 4
ASGNI4
line 62
;62:	downloadCount = trap_Cvar_VariableValue( "cl_downloadCount" );
ADDRGP4 $121
ARGP4
ADDRLP4 292
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 292
INDIRF4
CVFI4 4
ASGNI4
line 63
;63:	downloadTime = trap_Cvar_VariableValue( "cl_downloadTime" );
ADDRGP4 $122
ARGP4
ADDRLP4 296
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 148
ADDRLP4 296
INDIRF4
CVFI4 4
ASGNI4
line 74
;64:
;65:#if 0 // bk010104
;66:	fprintf( stderr, "\n\n-----------------------------------------------\n");
;67:	fprintf( stderr, "DB: downloadSize:  %16d\n", downloadSize );
;68:	fprintf( stderr, "DB: downloadCount: %16d\n", downloadCount );
;69:	fprintf( stderr, "DB: downloadTime:  %16d\n", downloadTime );  
;70:  	fprintf( stderr, "DB: UI realtime:   %16d\n", uis.realtime );	// bk
;71:	fprintf( stderr, "DB: UI frametime:  %16d\n", uis.frametime );	// bk
;72:#endif
;73:
;74:	leftWidth = width = UI_ProportionalStringWidth( dlText ) * UI_ProportionalSizeScale( style );
ADDRGP4 $117
ARGP4
ADDRLP4 300
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 304
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 308
ADDRLP4 300
INDIRI4
CVIF4 4
ADDRLP4 304
INDIRF4
MULF4
CVFI4 4
ASGNI4
ADDRLP4 8
ADDRLP4 308
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 308
INDIRI4
ASGNI4
line 75
;75:	width = UI_ProportionalStringWidth( etaText ) * UI_ProportionalSizeScale( style );
ADDRGP4 $118
ARGP4
ADDRLP4 312
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 316
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 312
INDIRI4
CVIF4 4
ADDRLP4 316
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 76
;76:	if (width > leftWidth) leftWidth = width;
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $123
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $123
line 77
;77:	width = UI_ProportionalStringWidth( xferText ) * UI_ProportionalSizeScale( style );
ADDRGP4 $119
ARGP4
ADDRLP4 320
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 324
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 320
INDIRI4
CVIF4 4
ADDRLP4 324
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 78
;78:	if (width > leftWidth) leftWidth = width;
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $125
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $125
line 79
;79:	leftWidth += 16;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 81
;80:
;81:	UI_DrawProportionalString( 8, 128, dlText, style, color_white );
CNSTI4 8
ARGI4
CNSTI4 128
ARGI4
ADDRGP4 $117
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 82
;82:	UI_DrawProportionalString( 8, 160, etaText, style, color_white );
CNSTI4 8
ARGI4
CNSTI4 160
ARGI4
ADDRGP4 $118
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 83
;83:	UI_DrawProportionalString( 8, 224, xferText, style, color_white );
CNSTI4 8
ARGI4
CNSTI4 224
ARGI4
ADDRGP4 $119
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 85
;84:
;85:	if (downloadSize > 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
LEI4 $127
line 86
;86:		s = va( "%s (%d%%)", downloadName, downloadCount * 100 / downloadSize );
ADDRGP4 $129
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
CNSTI4 100
MULI4
ADDRLP4 12
INDIRI4
DIVI4
ARGI4
ADDRLP4 328
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 156
ADDRLP4 328
INDIRP4
ASGNP4
line 87
;87:	} else {
ADDRGP4 $128
JUMPV
LABELV $127
line 88
;88:		s = downloadName;
ADDRLP4 156
ADDRFP4 0
INDIRP4
ASGNP4
line 89
;89:	}
LABELV $128
line 91
;90:
;91:	UI_DrawProportionalString( leftWidth, 128, s, style, color_white );
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 128
ARGI4
ADDRLP4 156
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 93
;92:
;93:	UI_ReadableSize( dlSizeBuf,		sizeof dlSizeBuf,		downloadCount );
ADDRLP4 20
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 94
;94:	UI_ReadableSize( totalSizeBuf,	sizeof totalSizeBuf,	downloadSize );
ADDRLP4 84
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 96
;95:
;96:	if (downloadCount < 4096 || !downloadTime) {
ADDRLP4 16
INDIRI4
CNSTI4 4096
LTI4 $132
ADDRLP4 148
INDIRI4
CNSTI4 0
NEI4 $130
LABELV $132
line 97
;97:		UI_DrawProportionalString( leftWidth, 160, "estimating", style, color_white );
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 160
ARGI4
ADDRGP4 $133
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 98
;98:		UI_DrawProportionalString( leftWidth, 192, 
ADDRGP4 $134
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 328
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 192
ARGI4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 100
;99:			va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), style, color_white );
;100:	} else {
ADDRGP4 $131
JUMPV
LABELV $130
line 105
;101:	  // bk010108
;102:	  //float elapsedTime = (float)(uis.realtime - downloadTime); // current - start (msecs)
;103:	  //elapsedTime = elapsedTime * 0.001f; // in seconds
;104:	  //if ( elapsedTime <= 0.0f ) elapsedTime == 0.0f;
;105:		if ((uis.realtime - downloadTime) / 1000) {
ADDRGP4 uis+4
INDIRI4
ADDRLP4 148
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
CNSTI4 0
EQI4 $135
line 106
;106:			xferRate = downloadCount / ((uis.realtime - downloadTime) / 1000);
ADDRLP4 152
ADDRLP4 16
INDIRI4
ADDRGP4 uis+4
INDIRI4
ADDRLP4 148
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
DIVI4
ASGNI4
line 108
;107:		  //xferRate = (int)( ((float)downloadCount) / elapsedTime);
;108:		} else {
ADDRGP4 $136
JUMPV
LABELV $135
line 109
;109:			xferRate = 0;
ADDRLP4 152
CNSTI4 0
ASGNI4
line 110
;110:		}
LABELV $136
line 115
;111:
;112:	  //fprintf( stderr, "DB: elapsedTime:  %16.8f\n", elapsedTime );	// bk
;113:	  //fprintf( stderr, "DB: xferRate:   %16d\n", xferRate );	// bk
;114:
;115:		UI_ReadableSize( xferRateBuf, sizeof xferRateBuf, xferRate );
ADDRLP4 160
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 152
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 118
;116:
;117:		// Extrapolate estimated completion time
;118:		if (downloadSize && xferRate) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $139
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $139
line 119
;119:			int n = downloadSize / xferRate; // estimated time for entire d/l in secs
ADDRLP4 328
ADDRLP4 12
INDIRI4
ADDRLP4 152
INDIRI4
DIVI4
ASGNI4
line 122
;120:
;121:			// We do it in K (/1024) because we'd overflow around 4MB
;122:			n = (n - (((downloadCount/1024) * n) / (downloadSize/1024))) * 1000;
ADDRLP4 332
ADDRLP4 328
INDIRI4
ASGNI4
ADDRLP4 328
ADDRLP4 332
INDIRI4
ADDRLP4 16
INDIRI4
CNSTI4 1024
DIVI4
ADDRLP4 332
INDIRI4
MULI4
ADDRLP4 12
INDIRI4
CNSTI4 1024
DIVI4
DIVI4
SUBI4
CNSTI4 1000
MULI4
ASGNI4
line 124
;123:			
;124:			UI_PrintTime ( dlTimeBuf, sizeof dlTimeBuf, n ); // bk010104
ADDRLP4 224
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 328
INDIRI4
ARGI4
ADDRGP4 UI_PrintTime
CALLV
pop
line 127
;125:				//(n - (((downloadCount/1024) * n) / (downloadSize/1024))) * 1000);
;126:
;127:			UI_DrawProportionalString( leftWidth, 160, 
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 160
ARGI4
ADDRLP4 224
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 129
;128:				dlTimeBuf, style, color_white );
;129:			UI_DrawProportionalString( leftWidth, 192, 
ADDRGP4 $134
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 336
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 192
ARGI4
ADDRLP4 336
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 131
;130:				va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), style, color_white );
;131:		} else {
ADDRGP4 $140
JUMPV
LABELV $139
line 132
;132:			UI_DrawProportionalString( leftWidth, 160, 
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 160
ARGI4
ADDRGP4 $133
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 134
;133:				"estimating", style, color_white );
;134:			if (downloadSize) {
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $141
line 135
;135:				UI_DrawProportionalString( leftWidth, 192, 
ADDRGP4 $134
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 84
ARGP4
ADDRLP4 328
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 192
ARGI4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 137
;136:					va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), style, color_white );
;137:			} else {
ADDRGP4 $142
JUMPV
LABELV $141
line 138
;138:				UI_DrawProportionalString( leftWidth, 192, 
ADDRGP4 $143
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 328
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 192
ARGI4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 140
;139:					va("(%s copied)", dlSizeBuf), style, color_white );
;140:			}
LABELV $142
line 141
;141:		}
LABELV $140
line 143
;142:
;143:		if (xferRate) {
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $144
line 144
;144:			UI_DrawProportionalString( leftWidth, 224, 
ADDRGP4 $146
ARGP4
ADDRLP4 160
ARGP4
ADDRLP4 328
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 224
ARGI4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 146
;145:				va("%s/Sec", xferRateBuf), style, color_white );
;146:		}
LABELV $144
line 147
;147:	}
LABELV $131
line 148
;148:}
LABELV $116
endproc UI_DisplayDownloadInfo 340 20
export UI_DrawConnectScreen
proc UI_DrawConnectScreen 5164 28
line 158
;149:
;150:/*
;151:========================
;152:UI_DrawConnectScreen
;153:
;154:This will also be overlaid on the cgame info screen during loading
;155:to prevent it from blinking away too rapidly on local or lan games.
;156:========================
;157:*/
;158:void UI_DrawConnectScreen( qboolean overlay ) {
line 163
;159:	char			*s;
;160:	uiClientState_t	cstate;
;161:	char			info[MAX_INFO_VALUE];
;162:
;163:	Menu_Cache();
ADDRGP4 Menu_Cache
CALLV
pop
line 165
;164:
;165:	if ( !overlay ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $148
line 167
;166:		// draw the dialog background
;167:		UI_SetColor( color_white );
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 171
;168:#if 0	// JUHOX: draw background picture for connect screen
;169:		UI_DrawHandlePic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, uis.menuBackShader );
;170:#else
;171:		UI_DrawBackPic(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawBackPic
CALLV
pop
line 172
;172:		UI_DrawHandlePic(30, 35, 580, 36, uis.menuBackTitleShader);	// "H U N T"
CNSTF4 1106247680
ARGF4
CNSTF4 1108082688
ARGF4
CNSTF4 1141964800
ARGF4
CNSTF4 1108344832
ARGF4
ADDRGP4 uis+11400
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 174
;173:#endif
;174:	}
LABELV $148
line 177
;175:
;176:	// see what information we should display
;177:	trap_GetClientState( &cstate );
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetClientState
CALLV
pop
line 179
;178:
;179:	info[0] = '\0';
ADDRLP4 3084
CNSTI1 0
ASGNI1
line 180
;180:	if( trap_GetConfigString( CS_SERVERINFO, info, sizeof(info) ) ) {
CNSTI4 0
ARGI4
ADDRLP4 3084
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4112
ADDRGP4 trap_GetConfigString
CALLI4
ASGNI4
ADDRLP4 4112
INDIRI4
CNSTI4 0
EQI4 $151
line 181
;181:		UI_DrawProportionalString( 320, 16, va( "Loading %s", Info_ValueForKey( info, "mapname" ) ), UI_BIGFONT|UI_CENTER|UI_DROPSHADOW, color_white );
ADDRLP4 3084
ARGP4
ADDRGP4 $154
ARGP4
ADDRLP4 4116
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $153
ARGP4
ADDRLP4 4116
INDIRP4
ARGP4
ADDRLP4 4120
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 4120
INDIRP4
ARGP4
CNSTI4 2081
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 182
;182:	}
LABELV $151
line 184
;183:
;184:	UI_DrawProportionalString( 320, /*64*/96, va("Connecting to %s", cstate.servername), UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, menu_text_color );	// JUHOX
ADDRGP4 $155
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 4116
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
CNSTI4 96
ARGI4
ADDRLP4 4116
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 menu_text_color
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 188
;185:	//UI_DrawProportionalString( 320, 96, "Press Esc to abort", UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, menu_text_color );
;186:
;187:	// display global MOTD at bottom
;188:	UI_DrawProportionalString( SCREEN_WIDTH/2, SCREEN_HEIGHT-32, 
ADDRLP4 0+1036
ARGP4
ADDRGP4 $158
ARGP4
ADDRLP4 4120
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
CNSTI4 320
ARGI4
CNSTI4 448
ARGI4
ADDRLP4 4120
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 menu_text_color
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 192
;189:		Info_ValueForKey( cstate.updateInfoString, "motd" ), UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, menu_text_color );
;190:	
;191:	// print any server info (server full, bad version, etc)
;192:	if ( cstate.connState < CA_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 5
GEI4 $159
line 193
;193:		UI_DrawProportionalString_AutoWrapped( 320, 192, 630, 20, cstate.messageString, UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, menu_text_color );
CNSTI4 320
ARGI4
CNSTI4 192
ARGI4
CNSTI4 630
ARGI4
CNSTI4 20
ARGI4
ADDRLP4 0+2060
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 menu_text_color
ARGP4
ADDRGP4 UI_DrawProportionalString_AutoWrapped
CALLV
pop
line 194
;194:	}
LABELV $159
line 220
;195:
;196:#if 0
;197:	// display password field
;198:	if ( passwordNeeded ) {
;199:		s_ingame_menu.x = SCREEN_WIDTH * 0.50 - 128;
;200:		s_ingame_menu.nitems = 0;
;201:		s_ingame_menu.wrapAround = qtrue;
;202:
;203:		passwordField.generic.type = MTYPE_FIELD;
;204:		passwordField.generic.name = "Password:";
;205:		passwordField.generic.callback = 0;
;206:		passwordField.generic.x		= 10;
;207:		passwordField.generic.y		= 180;
;208:		Field_Clear( &passwordField.field );
;209:		passwordField.width = 256;
;210:		passwordField.field.widthInChars = 16;
;211:		Q_strncpyz( passwordField.field.buffer, Cvar_VariableString("password"), 
;212:			sizeof(passwordField.field.buffer) );
;213:
;214:		Menu_AddItem( &s_ingame_menu, ( void * ) &s_customize_player_action );
;215:
;216:		MField_Draw( &passwordField );
;217:	}
;218:#endif
;219:
;220:	if ( lastConnState > cstate.connState ) {
ADDRGP4 lastConnState
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $162
line 221
;221:		lastLoadingText[0] = '\0';
ADDRGP4 lastLoadingText
CNSTI1 0
ASGNI1
line 222
;222:	}
LABELV $162
line 223
;223:	lastConnState = cstate.connState;
ADDRGP4 lastConnState
ADDRLP4 0
INDIRI4
ASGNI4
line 225
;224:
;225:	switch ( cstate.connState ) {
ADDRLP4 4124
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 4124
INDIRI4
CNSTI4 3
LTI4 $147
ADDRLP4 4124
INDIRI4
CNSTI4 7
GTI4 $147
ADDRLP4 4124
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $180-12
ADDP4
INDIRP4
JUMPV
data
align 4
LABELV $180
address $167
address $170
address $173
address $147
address $147
code
LABELV $167
line 227
;226:	case CA_CONNECTING:
;227:		s = va("Awaiting challenge...%i", cstate.connectPacketCount);
ADDRGP4 $168
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 4132
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4108
ADDRLP4 4132
INDIRP4
ASGNP4
line 228
;228:		break;
ADDRGP4 $165
JUMPV
LABELV $170
line 230
;229:	case CA_CHALLENGING:
;230:		s = va("Awaiting connection...%i", cstate.connectPacketCount);
ADDRGP4 $171
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 4136
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4108
ADDRLP4 4136
INDIRP4
ASGNP4
line 231
;231:		break;
ADDRGP4 $165
JUMPV
LABELV $173
line 232
;232:	case CA_CONNECTED: {
line 235
;233:		char downloadName[MAX_INFO_VALUE];
;234:
;235:			trap_Cvar_VariableStringBuffer( "cl_downloadName", downloadName, sizeof(downloadName) );
ADDRGP4 $174
ARGP4
ADDRLP4 4140
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 236
;236:			if (*downloadName) {
ADDRLP4 4140
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $175
line 237
;237:				UI_DisplayDownloadInfo( downloadName );
ADDRLP4 4140
ARGP4
ADDRGP4 UI_DisplayDownloadInfo
CALLV
pop
line 238
;238:				return;
ADDRGP4 $147
JUMPV
LABELV $175
line 240
;239:			}
;240:		}
line 241
;241:		s = "Awaiting gamestate...";
ADDRLP4 4108
ADDRGP4 $177
ASGNP4
line 242
;242:		break;
line 244
;243:	case CA_LOADING:
;244:		return;
line 246
;245:	case CA_PRIMED:
;246:		return;
line 248
;247:	default:
;248:		return;
LABELV $165
line 251
;249:	}
;250:
;251:	UI_DrawProportionalString( 320, 128, s, UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, color_white );
CNSTI4 320
ARGI4
CNSTI4 128
ARGI4
ADDRLP4 4108
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 color_white
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 254
;252:
;253:	// password required / connection rejected information goes here
;254:}
LABELV $147
endproc UI_DrawConnectScreen 5164 28
export UI_KeyConnect
proc UI_KeyConnect 0 8
line 262
;255:
;256:
;257:/*
;258:===================
;259:UI_KeyConnect
;260:===================
;261:*/
;262:void UI_KeyConnect( int key ) {
line 263
;263:	if ( key == K_ESCAPE ) {
ADDRFP4 0
INDIRI4
CNSTI4 27
NEI4 $183
line 264
;264:		trap_Cmd_ExecuteText( EXEC_APPEND, "disconnect\n" );
CNSTI4 2
ARGI4
ADDRGP4 $185
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 265
;265:		return;
LABELV $183
line 267
;266:	}
;267:}
LABELV $182
endproc UI_KeyConnect 0 8
bss
align 1
LABELV lastLoadingText
skip 1024
align 4
LABELV lastConnState
skip 4
export passwordField
align 4
LABELV passwordField
skip 332
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
LABELV $185
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 10
byte 1 0
align 1
LABELV $177
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $174
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $171
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 46
byte 1 46
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $168
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 99
byte 1 104
byte 1 97
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 46
byte 1 46
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $158
byte 1 109
byte 1 111
byte 1 116
byte 1 100
byte 1 0
align 1
LABELV $155
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $154
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $153
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $146
byte 1 37
byte 1 115
byte 1 47
byte 1 83
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $143
byte 1 40
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 112
byte 1 105
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $134
byte 1 40
byte 1 37
byte 1 115
byte 1 32
byte 1 111
byte 1 102
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 99
byte 1 111
byte 1 112
byte 1 105
byte 1 101
byte 1 100
byte 1 41
byte 1 0
align 1
LABELV $133
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 109
byte 1 97
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $129
byte 1 37
byte 1 115
byte 1 32
byte 1 40
byte 1 37
byte 1 100
byte 1 37
byte 1 37
byte 1 41
byte 1 0
align 1
LABELV $122
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $121
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 67
byte 1 111
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $120
byte 1 99
byte 1 108
byte 1 95
byte 1 100
byte 1 111
byte 1 119
byte 1 110
byte 1 108
byte 1 111
byte 1 97
byte 1 100
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $115
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $114
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $111
byte 1 37
byte 1 100
byte 1 32
byte 1 104
byte 1 114
byte 1 32
byte 1 37
byte 1 100
byte 1 32
byte 1 109
byte 1 105
byte 1 110
byte 1 0
align 1
LABELV $107
byte 1 37
byte 1 100
byte 1 32
byte 1 98
byte 1 121
byte 1 116
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $106
byte 1 37
byte 1 100
byte 1 32
byte 1 75
byte 1 66
byte 1 0
align 1
LABELV $103
byte 1 46
byte 1 37
byte 1 48
byte 1 50
byte 1 100
byte 1 32
byte 1 77
byte 1 66
byte 1 0
align 1
LABELV $100
byte 1 46
byte 1 37
byte 1 48
byte 1 50
byte 1 100
byte 1 32
byte 1 71
byte 1 66
byte 1 0
align 1
LABELV $99
byte 1 37
byte 1 100
byte 1 0
