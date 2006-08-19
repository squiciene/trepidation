data
export drawTeamOverlayModificationCount
align 4
LABELV drawTeamOverlayModificationCount
byte 4 -1
code
proc CG_DrawField 64 20
file "../cg_draw.c"
line 192
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// cg_draw.c -- draw all of the graphical elements during
;4:// active (after loading) gameplay
;5:
;6:#include "cg_local.h"
;7:
;8:#ifdef MISSIONPACK
;9:#include "../ui/ui_shared.h"
;10:
;11:// used for scoreboard
;12:extern displayContextDef_t cgDC;
;13:menuDef_t *menuScoreboard = NULL;
;14:#else
;15:int drawTeamOverlayModificationCount = -1;
;16:#endif
;17:
;18:int sortedTeamPlayers[TEAM_MAXOVERLAY];
;19:int	numSortedTeamPlayers;
;20:
;21:char systemChat[256];
;22:char teamChat1[256];
;23:char teamChat2[256];
;24:
;25:#ifdef MISSIONPACK
;26:
;27:int CG_Text_Width(const char *text, float scale, int limit) {
;28:  int count,len;
;29:	float out;
;30:	glyphInfo_t *glyph;
;31:	float useScale;
;32:// FIXME: see ui_main.c, same problem
;33://	const unsigned char *s = text;
;34:	const char *s = text;
;35:	fontInfo_t *font = &cgDC.Assets.textFont;
;36:	if (scale <= cg_smallFont.value) {
;37:		font = &cgDC.Assets.smallFont;
;38:	} else if (scale > cg_bigFont.value) {
;39:		font = &cgDC.Assets.bigFont;
;40:	}
;41:	useScale = scale * font->glyphScale;
;42:  out = 0;
;43:  if (text) {
;44:    len = strlen(text);
;45:		if (limit > 0 && len > limit) {
;46:			len = limit;
;47:		}
;48:		count = 0;
;49:		while (s && *s && count < len) {
;50:			if ( Q_IsColorString(s) ) {
;51:				s += 2;
;52:				continue;
;53:			} else {
;54:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;55:				out += glyph->xSkip;
;56:				s++;
;57:				count++;
;58:			}
;59:    }
;60:  }
;61:  return out * useScale;
;62:}
;63:
;64:int CG_Text_Height(const char *text, float scale, int limit) {
;65:  int len, count;
;66:	float max;
;67:	glyphInfo_t *glyph;
;68:	float useScale;
;69:// TTimo: FIXME
;70://	const unsigned char *s = text;
;71:	const char *s = text;
;72:	fontInfo_t *font = &cgDC.Assets.textFont;
;73:	if (scale <= cg_smallFont.value) {
;74:		font = &cgDC.Assets.smallFont;
;75:	} else if (scale > cg_bigFont.value) {
;76:		font = &cgDC.Assets.bigFont;
;77:	}
;78:	useScale = scale * font->glyphScale;
;79:  max = 0;
;80:  if (text) {
;81:    len = strlen(text);
;82:		if (limit > 0 && len > limit) {
;83:			len = limit;
;84:		}
;85:		count = 0;
;86:		while (s && *s && count < len) {
;87:			if ( Q_IsColorString(s) ) {
;88:				s += 2;
;89:				continue;
;90:			} else {
;91:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;92:	      if (max < glyph->height) {
;93:		      max = glyph->height;
;94:			  }
;95:				s++;
;96:				count++;
;97:			}
;98:    }
;99:  }
;100:  return max * useScale;
;101:}
;102:
;103:void CG_Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
;104:  float w, h;
;105:  w = width * scale;
;106:  h = height * scale;
;107:  CG_AdjustFrom640( &x, &y, &w, &h );
;108:  trap_R_DrawStretchPic( x, y, w, h, s, t, s2, t2, hShader );
;109:}
;110:
;111:void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
;112:  int len, count;
;113:	vec4_t newColor;
;114:	glyphInfo_t *glyph;
;115:	float useScale;
;116:	fontInfo_t *font = &cgDC.Assets.textFont;
;117:	if (scale <= cg_smallFont.value) {
;118:		font = &cgDC.Assets.smallFont;
;119:	} else if (scale > cg_bigFont.value) {
;120:		font = &cgDC.Assets.bigFont;
;121:	}
;122:	useScale = scale * font->glyphScale;
;123:  if (text) {
;124:// TTimo: FIXME
;125://		const unsigned char *s = text;
;126:		const char *s = text;
;127:		trap_R_SetColor( color );
;128:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
;129:    len = strlen(text);
;130:		if (limit > 0 && len > limit) {
;131:			len = limit;
;132:		}
;133:		count = 0;
;134:		while (s && *s && count < len) {
;135:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;136:      //int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;137:      //float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;138:			if ( Q_IsColorString( s ) ) {
;139:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
;140:				newColor[3] = color[3];
;141:				trap_R_SetColor( newColor );
;142:				s += 2;
;143:				continue;
;144:			} else {
;145:				float yadj = useScale * glyph->top;
;146:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
;147:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
;148:					colorBlack[3] = newColor[3];
;149:					trap_R_SetColor( colorBlack );
;150:					CG_Text_PaintChar(x + ofs, y - yadj + ofs, 
;151:														glyph->imageWidth,
;152:														glyph->imageHeight,
;153:														useScale, 
;154:														glyph->s,
;155:														glyph->t,
;156:														glyph->s2,
;157:														glyph->t2,
;158:														glyph->glyph);
;159:					colorBlack[3] = 1.0;
;160:					trap_R_SetColor( newColor );
;161:				}
;162:				CG_Text_PaintChar(x, y - yadj, 
;163:													glyph->imageWidth,
;164:													glyph->imageHeight,
;165:													useScale, 
;166:													glyph->s,
;167:													glyph->t,
;168:													glyph->s2,
;169:													glyph->t2,
;170:													glyph->glyph);
;171:				// CG_DrawPic(x, y - yadj, scale * cgDC.Assets.textFont.glyphs[text[i]].imageWidth, scale * cgDC.Assets.textFont.glyphs[text[i]].imageHeight, cgDC.Assets.textFont.glyphs[text[i]].glyph);
;172:				x += (glyph->xSkip * useScale) + adjust;
;173:				s++;
;174:				count++;
;175:			}
;176:    }
;177:	  trap_R_SetColor( NULL );
;178:  }
;179:}
;180:
;181:
;182:#endif
;183:
;184:/*
;185:==============
;186:CG_DrawField
;187:
;188:Draws large numbers for status bar and powerups
;189:==============
;190:*/
;191:#ifndef MISSIONPACK
;192:static void CG_DrawField (int x, int y, int width, int value) {
line 197
;193:	char	num[16], *ptr;
;194:	int		l;
;195:	int		frame;
;196:
;197:	if ( width < 1 ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $73
line 198
;198:		return;
ADDRGP4 $72
JUMPV
LABELV $73
line 202
;199:	}
;200:
;201:	// draw number string
;202:	if ( width > 5 ) {
ADDRFP4 8
INDIRI4
CNSTI4 5
LEI4 $75
line 203
;203:		width = 5;
ADDRFP4 8
CNSTI4 5
ASGNI4
line 204
;204:	}
LABELV $75
line 206
;205:
;206:	switch ( width ) {
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
LTI4 $77
ADDRLP4 28
INDIRI4
CNSTI4 4
GTI4 $77
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $107-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $107
address $79
address $86
address $93
address $100
code
LABELV $79
line 208
;207:	case 1:
;208:		value = value > 9 ? 9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9
LEI4 $81
ADDRLP4 32
CNSTI4 9
ASGNI4
ADDRGP4 $82
JUMPV
LABELV $81
ADDRLP4 32
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $82
ADDRFP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 209
;209:		value = value < 0 ? 0 : value;
ADDRFP4 12
INDIRI4
CNSTI4 0
GEI4 $84
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 $85
JUMPV
LABELV $84
ADDRLP4 36
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $85
ADDRFP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 210
;210:		break;
ADDRGP4 $78
JUMPV
LABELV $86
line 212
;211:	case 2:
;212:		value = value > 99 ? 99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 99
LEI4 $88
ADDRLP4 40
CNSTI4 99
ASGNI4
ADDRGP4 $89
JUMPV
LABELV $88
ADDRLP4 40
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $89
ADDRFP4 12
ADDRLP4 40
INDIRI4
ASGNI4
line 213
;213:		value = value < -9 ? -9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -9
GEI4 $91
ADDRLP4 44
CNSTI4 -9
ASGNI4
ADDRGP4 $92
JUMPV
LABELV $91
ADDRLP4 44
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $92
ADDRFP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 214
;214:		break;
ADDRGP4 $78
JUMPV
LABELV $93
line 216
;215:	case 3:
;216:		value = value > 999 ? 999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 999
LEI4 $95
ADDRLP4 48
CNSTI4 999
ASGNI4
ADDRGP4 $96
JUMPV
LABELV $95
ADDRLP4 48
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $96
ADDRFP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 217
;217:		value = value < -99 ? -99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -99
GEI4 $98
ADDRLP4 52
CNSTI4 -99
ASGNI4
ADDRGP4 $99
JUMPV
LABELV $98
ADDRLP4 52
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $99
ADDRFP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 218
;218:		break;
ADDRGP4 $78
JUMPV
LABELV $100
line 220
;219:	case 4:
;220:		value = value > 9999 ? 9999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9999
LEI4 $102
ADDRLP4 56
CNSTI4 9999
ASGNI4
ADDRGP4 $103
JUMPV
LABELV $102
ADDRLP4 56
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $103
ADDRFP4 12
ADDRLP4 56
INDIRI4
ASGNI4
line 221
;221:		value = value < -999 ? -999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -999
GEI4 $105
ADDRLP4 60
CNSTI4 -999
ASGNI4
ADDRGP4 $106
JUMPV
LABELV $105
ADDRLP4 60
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $106
ADDRFP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 222
;222:		break;
LABELV $77
LABELV $78
line 225
;223:	}
;224:
;225:	Com_sprintf (num, sizeof(num), "%i", value);
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $109
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 226
;226:	l = strlen(num);
ADDRLP4 12
ARGP4
ADDRLP4 32
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 227
;227:	if (l > width)
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
LEI4 $110
line 228
;228:		l = width;
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
LABELV $110
line 229
;229:	x += 2 + CHAR_WIDTH*(width - l);
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 5
LSHI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 231
;230:
;231:	ptr = num;
ADDRLP4 0
ADDRLP4 12
ASGNP4
ADDRGP4 $113
JUMPV
LABELV $112
line 233
;232:	while (*ptr && l)
;233:	{
line 234
;234:		if (*ptr == '-')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $115
line 235
;235:			frame = STAT_MINUS;
ADDRLP4 8
CNSTI4 10
ASGNI4
ADDRGP4 $116
JUMPV
LABELV $115
line 237
;236:		else
;237:			frame = *ptr -'0';
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
LABELV $116
line 239
;238:
;239:		CG_DrawPic( x,y, CHAR_WIDTH/2, CHAR_HEIGHT/2, cgs.media.numberShaders[frame] );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1098907648
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+153876+308
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 240
;240:		x += CHAR_WIDTH;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 241
;241:		ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 242
;242:		l--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 243
;243:	}
LABELV $113
line 232
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
EQI4 $119
ADDRLP4 4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $112
LABELV $119
line 244
;244:}
LABELV $72
endproc CG_DrawField 64 20
export CG_Draw3DModel
proc CG_Draw3DModel 512 16
line 253
;245:#endif // MISSIONPACK
;246:
;247:/*
;248:================
;249:CG_Draw3DModel
;250:
;251:================
;252:*/
;253:void CG_Draw3DModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles ) {
line 257
;254:	refdef_t		refdef;
;255:	refEntity_t		ent;
;256:
;257:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
ADDRLP4 508
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 508
INDIRI4
EQI4 $125
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 508
INDIRI4
NEI4 $121
LABELV $125
line 258
;258:		return;
ADDRGP4 $120
JUMPV
LABELV $121
line 261
;259:	}
;260:
;261:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 263
;262:
;263:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 265
;264:
;265:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 266
;266:	AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 267
;267:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 268
;268:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 269
;269:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 270
;270:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 272
;271:
;272:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 274
;273:
;274:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 276
;275:
;276:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 277
;277:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 279
;278:
;279:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 280
;280:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 281
;281:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 282
;282:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 284
;283:
;284:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 286
;285:
;286:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 287
;287:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 288
;288:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 289
;289:}
LABELV $120
endproc CG_Draw3DModel 512 16
export CG_DrawHead
proc CG_DrawHead 56 32
line 298
;290:
;291:/*
;292:================
;293:CG_DrawHead
;294:
;295:Used for both the status bar and the scoreboard
;296:================
;297:*/
;298:void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles ) {
line 305
;299:	clipHandle_t	cm;
;300:	clientInfo_t	*ci;
;301:	float			len;
;302:	vec3_t			origin;
;303:	vec3_t			mins, maxs;
;304:
;305:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
CNSTI4 1732
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 307
;306:
;307:	if ( cg_draw3dIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $142
line 308
;308:		cm = ci->headModel;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ASGNI4
line 309
;309:		if ( !cm ) {
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $145
line 310
;310:			return;
ADDRGP4 $140
JUMPV
LABELV $145
line 314
;311:		}
;312:
;313:		// offset the origin y and z to center the head
;314:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 316
;315:
;316:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 4+8
CNSTF4 3204448256
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 317
;317:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 4+4
CNSTF4 1056964608
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 321
;318:
;319:		// calculate distance so the head nearly fills the box
;320:		// assume heads are taller than wide
;321:		len = 0.7 * ( maxs[2] - mins[2] );		
ADDRLP4 44
CNSTF4 1060320051
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 322
;322:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 4
ADDRLP4 44
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 325
;323:
;324:		// allow per-model tweaking
;325:		VectorAdd( origin, ci->headOffset, origin );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRF4
ADDF4
ASGNF4
line 327
;326:
;327:		CG_Draw3DModel( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 328
;328:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $143
JUMPV
LABELV $142
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $159
line 329
;329:		CG_DrawPic( x, y, w, h, ci->modelIcon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 330
;330:	}
LABELV $159
LABELV $143
line 333
;331:
;332:	// if they are deferred, draw a cross out
;333:	if ( ci->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
CNSTI4 0
EQI4 $162
line 334
;334:		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 cgs+153876+132
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 335
;335:	}
LABELV $162
line 336
;336:}
LABELV $140
endproc CG_DrawHead 56 32
export CG_DrawFlagModel
proc CG_DrawFlagModel 72 32
line 345
;337:
;338:/*
;339:================
;340:CG_DrawFlagModel
;341:
;342:Used for both the status bar and the scoreboard
;343:================
;344:*/
;345:void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D ) {
line 352
;346:	qhandle_t		cm;
;347:	float			len;
;348:	vec3_t			origin, angles;
;349:	vec3_t			mins, maxs;
;350:	qhandle_t		handle;
;351:
;352:	if ( !force2D && cg_draw3dIcons.integer ) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $167
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $167
line 354
;353:
;354:		VectorClear( angles );
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 64
INDIRF4
ASGNF4
line 356
;355:
;356:		cm = cgs.media.redFlagModel;
ADDRLP4 48
ADDRGP4 cgs+153876+36
INDIRI4
ASGNI4
line 359
;357:
;358:		// offset the origin y and z to center the flag
;359:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 361
;360:
;361:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 12+8
CNSTF4 3204448256
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 362
;362:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 12+4
CNSTF4 1056964608
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 366
;363:
;364:		// calculate distance so the flag nearly fills the box
;365:		// assume heads are taller than wide
;366:		len = 0.5 * ( maxs[2] - mins[2] );		
ADDRLP4 52
CNSTF4 1056964608
ADDRLP4 36+8
INDIRF4
ADDRLP4 24+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 367
;367:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 12
ADDRLP4 52
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 369
;368:
;369:		angles[YAW] = 60 * sin( cg.time / 2000.0 );;
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1157234688
DIVF4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+4
CNSTF4 1114636288
ADDRLP4 68
INDIRF4
MULF4
ASGNF4
line 371
;370:
;371:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $184
line 372
;372:			handle = cgs.media.redFlagModel;
ADDRLP4 56
ADDRGP4 cgs+153876+36
INDIRI4
ASGNI4
line 373
;373:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $185
JUMPV
LABELV $184
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $188
line 374
;374:			handle = cgs.media.blueFlagModel;
ADDRLP4 56
ADDRGP4 cgs+153876+40
INDIRI4
ASGNI4
line 375
;375:		} else if( team == TEAM_FREE ) {
ADDRGP4 $189
JUMPV
LABELV $188
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $166
line 376
;376:			handle = cgs.media.neutralFlagModel;
ADDRLP4 56
ADDRGP4 cgs+153876+44
INDIRI4
ASGNI4
line 377
;377:		} else {
line 378
;378:			return;
LABELV $193
LABELV $189
LABELV $185
line 380
;379:		}
;380:		CG_Draw3DModel( x, y, w, h, handle, 0, origin, angles );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 381
;381:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $168
JUMPV
LABELV $167
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $196
line 384
;382:		gitem_t *item;
;383:
;384:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $199
line 385
;385:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 386
;386:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $200
JUMPV
LABELV $199
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $201
line 387
;387:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 388
;388:		} else if( team == TEAM_FREE ) {
ADDRGP4 $202
JUMPV
LABELV $201
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $166
line 389
;389:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 390
;390:		} else {
line 391
;391:			return;
LABELV $204
LABELV $202
LABELV $200
line 393
;392:		}
;393:		if (item) {
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $205
line 394
;394:		  CG_DrawPic( x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 395
;395:		}
LABELV $205
line 396
;396:	}
LABELV $196
LABELV $168
line 397
;397:}
LABELV $166
endproc CG_DrawFlagModel 72 32
proc CG_DrawStatusBarHead 56 24
line 407
;398:
;399:/*
;400:================
;401:CG_DrawStatusBarHead
;402:
;403:================
;404:*/
;405:#ifndef MISSIONPACK
;406:
;407:static void CG_DrawStatusBarHead( float x ) {
line 412
;408:	vec3_t		angles;
;409:	float		size, stretch;
;410:	float		frac;
;411:
;412:	VectorClear( angles );
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 4+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 414
;413:
;414:	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
ADDRGP4 cg+124700
INDIRF4
CNSTF4 0
EQF4 $211
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+124700
INDIRF4
SUBF4
CNSTF4 1140457472
GEF4 $211
line 415
;415:		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+124700
INDIRF4
SUBF4
CNSTF4 1140457472
DIVF4
ASGNF4
line 416
;416:		size = ICON_SIZE * 1.25 * ( 1.5 - frac * 0.5 );
ADDRLP4 16
CNSTF4 1114636288
CNSTF4 1069547520
CNSTF4 1056964608
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 418
;417:
;418:		stretch = size - ICON_SIZE * 1.25;
ADDRLP4 20
ADDRLP4 16
INDIRF4
CNSTF4 1114636288
SUBF4
ASGNF4
line 420
;419:		// kick in the direction of damage
;420:		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;
ADDRLP4 28
CNSTF4 1056964608
ASGNF4
ADDRLP4 32
ADDRLP4 20
INDIRF4
ASGNF4
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
ADDRGP4 cg+124704
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
MULF4
ADDF4
SUBF4
ASGNF4
line 422
;421:
;422:		cg.headStartYaw = 180 + cg.damageX * 45;
ADDRGP4 cg+124736
CNSTF4 1110704128
ADDRGP4 cg+124704
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 424
;423:
;424:		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 36
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 40
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+124724
CNSTF4 1101004800
ADDRLP4 40
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 425
;425:		cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 44
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 48
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+124720
CNSTF4 1084227584
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 427
;426:
;427:		cg.headStartTime = cg.time;
ADDRGP4 cg+124740
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 428
;428:		cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+124728
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
CNSTF4 1157234688
ADDRLP4 52
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 429
;429:	} else {
ADDRGP4 $212
JUMPV
LABELV $211
line 430
;430:		if ( cg.time >= cg.headEndTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124728
INDIRI4
LTI4 $227
line 432
;431:			// select a new head angle
;432:			cg.headStartYaw = cg.headEndYaw;
ADDRGP4 cg+124736
ADDRGP4 cg+124724
INDIRF4
ASGNF4
line 433
;433:			cg.headStartPitch = cg.headEndPitch;
ADDRGP4 cg+124732
ADDRGP4 cg+124720
INDIRF4
ASGNF4
line 434
;434:			cg.headStartTime = cg.headEndTime;
ADDRGP4 cg+124740
ADDRGP4 cg+124728
INDIRI4
ASGNI4
line 435
;435:			cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+124728
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
CNSTF4 1157234688
ADDRLP4 28
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 437
;436:
;437:			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+124724
CNSTF4 1101004800
ADDRLP4 36
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 438
;438:			cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 40
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 44
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+124720
CNSTF4 1084227584
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
line 439
;439:		}
LABELV $227
line 441
;440:
;441:		size = ICON_SIZE * 1.25;
ADDRLP4 16
CNSTF4 1114636288
ASGNF4
line 442
;442:	}
LABELV $212
line 445
;443:
;444:	// if the server was frozen for a while we may have a bad head start time
;445:	if ( cg.headStartTime > cg.time ) {
ADDRGP4 cg+124740
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $241
line 446
;446:		cg.headStartTime = cg.time;
ADDRGP4 cg+124740
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 447
;447:	}
LABELV $241
line 449
;448:
;449:	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124740
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+124728
INDIRI4
ADDRGP4 cg+124740
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 450
;450:	frac = frac * frac * ( 3 - 2 * frac );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1077936128
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 451
;451:	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
ADDRLP4 4+4
ADDRGP4 cg+124736
INDIRF4
ADDRGP4 cg+124724
INDIRF4
ADDRGP4 cg+124736
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 452
;452:	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;
ADDRLP4 4
ADDRGP4 cg+124732
INDIRF4
ADDRGP4 cg+124720
INDIRF4
ADDRGP4 cg+124732
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 454
;453:
;454:	CG_DrawHead( x, 480 - size, size, size, 
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1139802112
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 456
;455:				cg.snap->ps.clientNum, angles );
;456:}
LABELV $208
endproc CG_DrawStatusBarHead 56 24
proc CG_DrawStatusBarFlag 4 24
line 466
;457:#endif // MISSIONPACK
;458:
;459:/*
;460:================
;461:CG_DrawStatusBarFlag
;462:
;463:================
;464:*/
;465:#ifndef MISSIONPACK
;466:static void CG_DrawStatusBarFlag( float x, int team ) {
line 467
;467:	CG_DrawFlagModel( x, 480 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse );
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 0
CNSTF4 1111490560
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 468
;468:}
LABELV $259
endproc CG_DrawStatusBarFlag 4 24
export CG_DrawTeamBackground
proc CG_DrawTeamBackground 16 20
line 478
;469:#endif // MISSIONPACK
;470:
;471:/*
;472:================
;473:CG_DrawTeamBackground
;474:
;475:================
;476:*/
;477:void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team )
;478:{
line 481
;479:	vec4_t		hcolor;
;480:
;481:	hcolor[3] = alpha;
ADDRLP4 0+12
ADDRFP4 16
INDIRF4
ASGNF4
line 482
;482:	if ( team == TEAM_RED ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
NEI4 $262
line 483
;483:		hcolor[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 484
;484:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 485
;485:		hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 486
;486:	} else if ( team == TEAM_BLUE ) {
ADDRGP4 $263
JUMPV
LABELV $262
ADDRFP4 20
INDIRI4
CNSTI4 2
NEI4 $260
line 487
;487:		hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 488
;488:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 489
;489:		hcolor[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 490
;490:	} else {
line 491
;491:		return;
LABELV $267
LABELV $263
line 493
;492:	}
;493:	trap_R_SetColor( hcolor );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 494
;494:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+153876+128
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 495
;495:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 496
;496:}
LABELV $260
endproc CG_DrawTeamBackground 16 20
data
align 4
LABELV $273
byte 4 1065353216
byte 4 1060152279
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1056964608
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
code
proc CG_DrawStatusBar 80 32
line 505
;497:
;498:/*
;499:================
;500:CG_DrawStatusBar
;501:
;502:================
;503:*/
;504:#ifndef MISSIONPACK
;505:static void CG_DrawStatusBar( void ) {
line 523
;506:	int			color;
;507:	centity_t	*cent;
;508:	playerState_t	*ps;
;509:	int			value;
;510:	vec4_t		hcolor;
;511:	vec3_t		angles;
;512:	vec3_t		origin;
;513:#ifdef MISSIONPACK
;514:	qhandle_t	handle;
;515:#endif
;516:	static float colors[4][4] = { 
;517://		{ 0.2, 1.0, 0.2, 1.0 } , { 1.0, 0.2, 0.2, 1.0 }, {0.5, 0.5, 0.5, 1} };
;518:		{ 1.0f, 0.69f, 0.0f, 1.0f },    // normal
;519:		{ 1.0f, 0.2f, 0.2f, 1.0f },     // low health
;520:		{ 0.5f, 0.5f, 0.5f, 1.0f },     // weapon firing
;521:		{ 1.0f, 1.0f, 1.0f, 1.0f } };   // health > 100
;522:
;523:	if ( cg_drawStatus.integer == 0 ) {
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
NEI4 $274
line 524
;524:		return;
ADDRGP4 $272
JUMPV
LABELV $274
line 528
;525:	}
;526:
;527:	// draw the team background
;528:	CG_DrawTeamBackground( 0, 420, 640, 60, 0.33f, cg.snap->ps.persistant[PERS_TEAM] );
CNSTI4 0
ARGI4
CNSTI4 420
ARGI4
CNSTI4 640
ARGI4
CNSTI4 60
ARGI4
CNSTF4 1051260355
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
line 530
;529:
;530:	cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 4
CNSTI4 732
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 531
;531:	ps = &cg.snap->ps;
ADDRLP4 20
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 533
;532:
;533:	VectorClear( angles );
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 8+8
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 56
INDIRF4
ASGNF4
line 536
;534:
;535:	// draw any 3D icons first, so the changes back to 2D are minimized
;536:	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $282
CNSTI4 136
ADDRLP4 60
INDIRI4
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $282
line 537
;537:		origin[0] = 70;
ADDRLP4 24
CNSTF4 1116471296
ASGNF4
line 538
;538:		origin[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 539
;539:		origin[2] = 0;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 540
;540:		angles[YAW] = 90 + 20 * sin( cg.time / 1000.0 );
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 8+4
CNSTF4 1101004800
ADDRLP4 68
INDIRF4
MULF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 541
;541:		CG_Draw3DModel( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, 32, 32,
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 72
CNSTF4 1107296256
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
CNSTI4 136
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 543
;542:					   cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles );
;543:	}
LABELV $282
line 545
;544:
;545:	CG_DrawStatusBarHead( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE );
CNSTF4 1133412352
ARGF4
ADDRGP4 CG_DrawStatusBarHead
CALLV
pop
line 547
;546:
;547:	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
ADDRGP4 cg+107636+312+28
INDIRI4
CNSTI4 0
EQI4 $290
line 548
;548:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED );
CNSTF4 1134985216
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 549
;549:	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
ADDRGP4 $291
JUMPV
LABELV $290
ADDRGP4 cg+107636+312+32
INDIRI4
CNSTI4 0
EQI4 $295
line 550
;550:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE );
CNSTF4 1134985216
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 551
;551:	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
ADDRGP4 $296
JUMPV
LABELV $295
ADDRGP4 cg+107636+312+36
INDIRI4
CNSTI4 0
EQI4 $300
line 552
;552:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE );
CNSTF4 1134985216
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 553
;553:	}
LABELV $300
LABELV $296
LABELV $291
line 555
;554:
;555:	if ( ps->stats[ STAT_ARMOR ] ) {
ADDRLP4 20
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
EQI4 $305
line 556
;556:		origin[0] = 90;
ADDRLP4 24
CNSTF4 1119092736
ASGNF4
line 557
;557:		origin[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 558
;558:		origin[2] = -10;
ADDRLP4 24+8
CNSTF4 3240099840
ASGNF4
line 559
;559:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRLP4 8+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
MULI4
CVIF4 4
CNSTF4 1157627904
DIVF4
ASGNF4
line 561
;560:		// Shafe was ICON_SIZE instead of 32
;561:		CG_Draw3DModel( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, 32, 32,
CNSTF4 1139474432
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 68
CNSTF4 1107296256
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRGP4 cgs+153876+120
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 563
;562:					   cgs.media.armorModel, 0, origin, angles );
;563:	}
LABELV $305
line 581
;564:#ifdef MISSIONPACK
;565:	if( cgs.gametype == GT_HARVESTER ) {
;566:		origin[0] = 90;
;567:		origin[1] = 0;
;568:		origin[2] = -10;
;569:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
;570:		if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;571:			handle = cgs.media.redCubeModel;
;572:		} else {
;573:			handle = cgs.media.blueCubeModel;
;574:		}
;575:		CG_Draw3DModel( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 416, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles );
;576:	}
;577:#endif
;578:	//
;579:	// ammo
;580:	//
;581:	if ( cent->currentState.weapon ) {
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $313
line 582
;582:		value = ps->ammo[cent->currentState.weapon];
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ASGNI4
line 583
;583:		if ( value > -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
LEI4 $315
line 584
;584:			if ( cg.predictedPlayerState.weaponstate == WEAPON_FIRING
ADDRGP4 cg+107636+148
INDIRI4
CNSTI4 3
NEI4 $317
ADDRGP4 cg+107636+44
INDIRI4
CNSTI4 100
LEI4 $317
line 585
;585:				&& cg.predictedPlayerState.weaponTime > 100 ) {
line 587
;586:				// draw as dark grey when reloading
;587:				color = 2;	// dark grey
ADDRLP4 52
CNSTI4 2
ASGNI4
line 588
;588:			} else {
ADDRGP4 $318
JUMPV
LABELV $317
line 589
;589:				if ( value >= 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $323
line 590
;590:					color = 0;	// green
ADDRLP4 52
CNSTI4 0
ASGNI4
line 591
;591:				} else {
ADDRGP4 $324
JUMPV
LABELV $323
line 592
;592:					color = 1;	// red
ADDRLP4 52
CNSTI4 1
ASGNI4
line 593
;593:				}
LABELV $324
line 594
;594:			}
LABELV $318
line 595
;595:			trap_R_SetColor( colors[color] );
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $273
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 597
;596:			
;597:			CG_DrawField (0, 432, 3, value);
CNSTI4 0
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 598
;598:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 601
;599:
;600:			// if we didn't draw a 3D icon, draw a 2D icon for ammo
;601:			if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $325
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $325
line 604
;602:				qhandle_t	icon;
;603:
;604:				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
ADDRLP4 72
CNSTI4 136
ADDRGP4 cg+107636+144
INDIRI4
MULI4
ADDRGP4 cg_weapons+72
ADDP4
INDIRI4
ASGNI4
line 605
;605:				if ( icon ) {
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $332
line 606
;606:					CG_DrawPic( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, 32, 32, icon );
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 76
CNSTF4 1107296256
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 607
;607:				}
LABELV $332
line 608
;608:			}
LABELV $325
line 609
;609:		}
LABELV $315
line 610
;610:	}
LABELV $313
line 615
;611:
;612:	//
;613:	// health
;614:	//
;615:	value = ps->stats[STAT_HEALTH];
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 616
;616:	if ( value > 100 ) {
ADDRLP4 0
INDIRI4
CNSTI4 100
LEI4 $334
line 617
;617:		trap_R_SetColor( colors[3] );		// white
ADDRGP4 $273+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 618
;618:	} else if (value > 25) {
ADDRGP4 $335
JUMPV
LABELV $334
ADDRLP4 0
INDIRI4
CNSTI4 25
LEI4 $337
line 619
;619:		trap_R_SetColor( colors[0] );	// green
ADDRGP4 $273
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 620
;620:	} else if (value > 0) {
ADDRGP4 $338
JUMPV
LABELV $337
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $339
line 621
;621:		color = (cg.time >> 8) & 1;	// flash
ADDRLP4 52
ADDRGP4 cg+107604
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 622
;622:		trap_R_SetColor( colors[color] );
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $273
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 623
;623:	} else {
ADDRGP4 $340
JUMPV
LABELV $339
line 624
;624:		trap_R_SetColor( colors[1] );	// red
ADDRGP4 $273+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 625
;625:	}
LABELV $340
LABELV $338
LABELV $335
line 628
;626:
;627:	// stretch the health up when taking damage
;628:	CG_DrawField ( 185, 432, 3, value);
CNSTI4 185
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 629
;629:	CG_ColorForHealth( hcolor );
ADDRLP4 36
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 630
;630:	trap_R_SetColor( hcolor );
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 636
;631:
;632:
;633:	//
;634:	// armor
;635:	//
;636:	value = ps->stats[STAT_ARMOR];
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 637
;637:	if (value > 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $343
line 638
;638:		trap_R_SetColor( colors[0] );
ADDRGP4 $273
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 639
;639:		CG_DrawField (370, 432, 3, value);
CNSTI4 370
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 640
;640:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 642
;641:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;642:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $345
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $345
line 643
;643:			CG_DrawPic( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, 32, 32, cgs.media.armorIcon );
CNSTF4 1139474432
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 72
CNSTF4 1107296256
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRGP4 cgs+153876+124
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 644
;644:		}
LABELV $345
line 646
;645:
;646:	}
LABELV $343
line 670
;647:#ifdef MISSIONPACK
;648:	//
;649:	// cubes
;650:	//
;651:	if( cgs.gametype == GT_HARVESTER ) {
;652:		value = ps->generic1;
;653:		if( value > 99 ) {
;654:			value = 99;
;655:		}
;656:		trap_R_SetColor( colors[0] );
;657:		CG_DrawField (640 - (CHAR_WIDTH*2 + TEXT_ICON_SPACE + ICON_SIZE), 432, 2, value);
;658:		trap_R_SetColor( NULL );
;659:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;660:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;661:			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;662:				handle = cgs.media.redCubeIcon;
;663:			} else {
;664:				handle = cgs.media.blueCubeIcon;
;665:			}
;666:			CG_DrawPic( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 432, ICON_SIZE, ICON_SIZE, handle );
;667:		}
;668:	}
;669:#endif
;670:}
LABELV $272
endproc CG_DrawStatusBar 80 32
proc CG_DrawAttacker 52 24
line 687
;671:#endif
;672:
;673:/*
;674:===========================================================================================
;675:
;676:  UPPER RIGHT CORNER
;677:
;678:===========================================================================================
;679:*/
;680:
;681:/*
;682:================
;683:CG_DrawAttacker
;684:
;685:================
;686:*/
;687:static float CG_DrawAttacker( float y ) {
line 695
;688:	int			t;
;689:	float		size;
;690:	vec3_t		angles;
;691:	const char	*info;
;692:	const char	*name;
;693:	int			clientNum;
;694:
;695:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $352
line 696
;696:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $351
JUMPV
LABELV $352
line 699
;697:	}
;698:
;699:	if ( !cg.attackerTime ) {
ADDRGP4 cg+124428
INDIRI4
CNSTI4 0
NEI4 $356
line 700
;700:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $351
JUMPV
LABELV $356
line 703
;701:	}
;702:
;703:	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
ADDRLP4 0
ADDRGP4 cg+107636+248+24
INDIRI4
ASGNI4
line 704
;704:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $366
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $366
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $362
LABELV $366
line 705
;705:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $351
JUMPV
LABELV $362
line 708
;706:	}
;707:
;708:	t = cg.time - cg.attackerTime;
ADDRLP4 24
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124428
INDIRI4
SUBI4
ASGNI4
line 709
;709:	if ( t > ATTACKER_HEAD_TIME ) {
ADDRLP4 24
INDIRI4
CNSTI4 10000
LEI4 $369
line 710
;710:		cg.attackerTime = 0;
ADDRGP4 cg+124428
CNSTI4 0
ASGNI4
line 711
;711:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $351
JUMPV
LABELV $369
line 714
;712:	}
;713:
;714:	size = ICON_SIZE * 1.25;
ADDRLP4 4
CNSTF4 1114636288
ASGNF4
line 716
;715:
;716:	angles[PITCH] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 717
;717:	angles[YAW] = 180;
ADDRLP4 8+4
CNSTF4 1127481344
ASGNF4
line 718
;718:	angles[ROLL] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 719
;719:	CG_DrawHead( 640 - size, y, size, size, clientNum, angles );
CNSTF4 1142947840
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 721
;720:
;721:	info = CG_ConfigString( CS_PLAYERS + clientNum );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 40
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 40
INDIRP4
ASGNP4
line 722
;722:	name = Info_ValueForKey(  info, "n" );
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $374
ARGP4
ADDRLP4 44
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 44
INDIRP4
ASGNP4
line 723
;723:	y += size;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 724
;724:	CG_DrawBigString( 640 - ( Q_PrintStrlen( name ) * BIGCHAR_WIDTH), y, name, 0.5 );
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Q_PrintStrlen
CALLI4
ASGNI4
CNSTI4 640
ADDRLP4 48
INDIRI4
CNSTI4 4
LSHI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1056964608
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 726
;725:
;726:	return y + BIGCHAR_HEIGHT + 2;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1073741824
ADDF4
RETF4
LABELV $351
endproc CG_DrawAttacker 52 24
proc CG_DrawSnapshot 16 16
line 734
;727:}
;728:
;729:/*
;730:==================
;731:CG_DrawSnapshot
;732:==================
;733:*/
;734:static float CG_DrawSnapshot( float y ) {
line 738
;735:	char		*s;
;736:	int			w;
;737:
;738:	s = va( "time:%i snap:%i cmd:%i", cg.snap->serverTime, 
ADDRGP4 $376
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+31444
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 740
;739:		cg.latestSnapshotNum, cgs.serverCommandSequence );
;740:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 742
;741:
;742:	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 744
;743:
;744:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $375
endproc CG_DrawSnapshot 16 16
bss
align 4
LABELV $381
skip 16
align 4
LABELV $382
skip 4
align 4
LABELV $383
skip 4
code
proc CG_DrawFPS 44 16
line 753
;745:}
;746:
;747:/*
;748:==================
;749:CG_DrawFPS
;750:==================
;751:*/
;752:#define	FPS_FRAMES	4
;753:static float CG_DrawFPS( float y ) {
line 765
;754:	char		*s;
;755:	int			w;
;756:	static int	previousTimes[FPS_FRAMES];
;757:	static int	index;
;758:	int		i, total;
;759:	int		fps;
;760:	static	int	previous;
;761:	int		t, frameTime;
;762:
;763:	// don't use serverTime, because that will be drifting to
;764:	// correct for internet lag changes, timescales, timedemos, etc
;765:	t = trap_Milliseconds();
ADDRLP4 28
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
line 766
;766:	frameTime = t - previous;
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 $383
INDIRI4
SUBI4
ASGNI4
line 767
;767:	previous = t;
ADDRGP4 $383
ADDRLP4 8
INDIRI4
ASGNI4
line 769
;768:
;769:	previousTimes[index % FPS_FRAMES] = frameTime;
ADDRGP4 $382
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $381
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 770
;770:	index++;
ADDRLP4 32
ADDRGP4 $382
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
;771:	if ( index > FPS_FRAMES ) {
ADDRGP4 $382
INDIRI4
CNSTI4 4
LEI4 $384
line 773
;772:		// average multiple frames together to smooth changes out a bit
;773:		total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 774
;774:		for ( i = 0 ; i < FPS_FRAMES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $386
line 775
;775:			total += previousTimes[i];
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $381
ADDP4
INDIRI4
ADDI4
ASGNI4
line 776
;776:		}
LABELV $387
line 774
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $386
line 777
;777:		if ( !total ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $390
line 778
;778:			total = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 779
;779:		}
LABELV $390
line 780
;780:		fps = 1000 * FPS_FRAMES / total;
ADDRLP4 24
CNSTI4 4000
ADDRLP4 4
INDIRI4
DIVI4
ASGNI4
line 782
;781:
;782:		s = va( "%ifps", fps );
ADDRGP4 $392
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 783
;783:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 786
;784:
;785:		//CG_DrawBigString( 50 - w, y + 2, s, 1.0F); // Shafe -  Drawfps 635
;786:		CG_DrawSmallString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 20
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 787
;787:	}
LABELV $384
line 789
;788:
;789:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $380
endproc CG_DrawFPS 44 16
proc CG_DrawTimer 32 16
line 797
;790:}
;791:
;792:/*
;793:=================
;794:CG_DrawTimer
;795:=================
;796:*/
;797:static float CG_DrawTimer( float y ) {
line 803
;798:	char		*s;
;799:	int			w;
;800:	int			mins, seconds, tens;
;801:	int			msec;
;802:
;803:	msec = cg.time - cgs.levelStartTime;
ADDRLP4 20
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+34796
INDIRI4
SUBI4
ASGNI4
line 805
;804:
;805:	seconds = msec / 1000;
ADDRLP4 0
ADDRLP4 20
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 806
;806:	mins = seconds / 60;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 807
;807:	seconds -= mins * 60;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDRLP4 8
INDIRI4
MULI4
SUBI4
ASGNI4
line 808
;808:	tens = seconds / 10;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 809
;809:	seconds -= tens * 10;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 10
ADDRLP4 12
INDIRI4
MULI4
SUBI4
ASGNI4
line 811
;810:
;811:	s = va( "%i:%i%i", mins, tens, seconds );
ADDRGP4 $396
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 812
;812:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 28
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 814
;813:
;814:	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 816
;815:
;816:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $393
endproc CG_DrawTimer 32 16
proc CG_DrawTeamOverlay 148 36
line 826
;817:}
;818:
;819:
;820:/*
;821:=================
;822:CG_DrawTeamOverlay
;823:=================
;824:*/
;825:
;826:static float CG_DrawTeamOverlay( float y, qboolean right, qboolean upper ) {
line 838
;827:	int x, w, h, xx;
;828:	int i, j, len;
;829:	const char *p;
;830:	vec4_t		hcolor;
;831:	int pwidth, lwidth;
;832:	int plyrs;
;833:	char st[16];
;834:	clientInfo_t *ci;
;835:	gitem_t	*item;
;836:	int ret_y, count;
;837:
;838:	if ( !cg_drawTeamOverlay.integer ) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
NEI4 $398
line 839
;839:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $397
JUMPV
LABELV $398
line 842
;840:	}
;841:
;842:	if ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE ) {
ADDRLP4 92
CNSTI4 304
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $401
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $401
line 843
;843:		return y; // Not on any team
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $397
JUMPV
LABELV $401
line 846
;844:	}
;845:
;846:	plyrs = 0;
ADDRLP4 76
CNSTI4 0
ASGNI4
line 849
;847:
;848:	// max player name width
;849:	pwidth = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 850
;850:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
ADDRGP4 numSortedTeamPlayers
INDIRI4
CNSTI4 8
LEI4 $406
ADDRLP4 96
CNSTI4 8
ASGNI4
ADDRGP4 $407
JUMPV
LABELV $406
ADDRLP4 96
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
LABELV $407
ADDRLP4 48
ADDRLP4 96
INDIRI4
ASGNI4
line 851
;851:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $411
JUMPV
LABELV $408
line 852
;852:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 1732
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 853
;853:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $413
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $413
line 854
;854:			plyrs++;
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 855
;855:			len = CG_DrawStrlen(ci->name);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 104
INDIRI4
ASGNI4
line 856
;856:			if (len > pwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $416
line 857
;857:				pwidth = len;
ADDRLP4 56
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $416
line 858
;858:		}
LABELV $413
line 859
;859:	}
LABELV $409
line 851
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $411
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $408
line 861
;860:
;861:	if (!plyrs)
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $418
line 862
;862:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $397
JUMPV
LABELV $418
line 864
;863:
;864:	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
ADDRLP4 56
INDIRI4
CNSTI4 12
LEI4 $420
line 865
;865:		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;
ADDRLP4 56
CNSTI4 12
ASGNI4
LABELV $420
line 868
;866:
;867:	// max location name width
;868:	lwidth = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 869
;869:	for (i = 1; i < MAX_LOCATIONS; i++) {
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $422
line 870
;870:		p = CG_ConfigString(CS_LOCATIONS + i);
ADDRLP4 8
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 100
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 100
INDIRP4
ASGNP4
line 871
;871:		if (p && *p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $426
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $426
line 872
;872:			len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 108
INDIRI4
ASGNI4
line 873
;873:			if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $428
line 874
;874:				lwidth = len;
ADDRLP4 44
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $428
line 875
;875:		}
LABELV $426
line 876
;876:	}
LABELV $423
line 869
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $422
line 878
;877:
;878:	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
ADDRLP4 44
INDIRI4
CNSTI4 16
LEI4 $430
line 879
;879:		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;
ADDRLP4 44
CNSTI4 16
ASGNI4
LABELV $430
line 881
;880:
;881:	w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;
ADDRLP4 80
ADDRLP4 56
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
CNSTI4 3
LSHI4
CNSTI4 32
ADDI4
CNSTI4 56
ADDI4
ASGNI4
line 883
;882:
;883:	if ( right )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $432
line 884
;884:		x = 640 - w;
ADDRLP4 52
CNSTI4 640
ADDRLP4 80
INDIRI4
SUBI4
ASGNI4
ADDRGP4 $433
JUMPV
LABELV $432
line 886
;885:	else
;886:		x = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
LABELV $433
line 888
;887:
;888:	h = plyrs * TINYCHAR_HEIGHT;
ADDRLP4 84
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 890
;889:
;890:	if ( upper ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $434
line 891
;891:		ret_y = y + h;
ADDRLP4 88
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ASGNI4
line 892
;892:	} else {
ADDRGP4 $435
JUMPV
LABELV $434
line 893
;893:		y -= h;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 894
;894:		ret_y = y;
ADDRLP4 88
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 895
;895:	}
LABELV $435
line 897
;896:
;897:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $436
line 898
;898:		hcolor[0] = 1.0f;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 899
;899:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 900
;900:		hcolor[2] = 0.0f;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 901
;901:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 902
;902:	} else { // if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 $437
JUMPV
LABELV $436
line 903
;903:		hcolor[0] = 0.0f;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 904
;904:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 905
;905:		hcolor[2] = 1.0f;
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 906
;906:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 907
;907:	}
LABELV $437
line 908
;908:	trap_R_SetColor( hcolor );
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 909
;909:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRLP4 52
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 84
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+153876+128
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 910
;910:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 912
;911:
;912:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $450
JUMPV
LABELV $447
line 913
;913:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 1732
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 914
;914:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $452
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $452
line 916
;915:
;916:			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
ADDRLP4 104
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 104
INDIRF4
ASGNF4
line 918
;917:
;918:			xx = x + TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 920
;919:
;920:			CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 112
CNSTI4 8
ASGNI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
CNSTI4 12
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 924
;921:				ci->name, hcolor, qfalse, qfalse,
;922:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH);
;923:
;924:			if (lwidth) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $458
line 925
;925:				p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 116
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 116
INDIRP4
ASGNP4
line 926
;926:				if (!p || !*p)
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $462
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $460
LABELV $462
line 927
;927:					p = "unknown";
ADDRLP4 20
ADDRGP4 $463
ASGNP4
LABELV $460
line 928
;928:				len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 124
INDIRI4
ASGNI4
line 929
;929:				if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $464
line 930
;930:					len = lwidth;
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
LABELV $464
line 934
;931:
;932://				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth + 
;933://					((lwidth/2 - len/2) * TINYCHAR_WIDTH);
;934:				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 16
ADDI4
ADDRLP4 56
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 935
;935:				CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 938
;936:					p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
;937:					TEAM_OVERLAY_MAXLOCATION_WIDTH);
;938:			}
LABELV $458
line 940
;939:
;940:			CG_GetColorForHealth( ci->health, ci->armor, hcolor );
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 942
;941:
;942:			Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);
ADDRLP4 60
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $466
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 944
;943:
;944:			xx = x + TINYCHAR_WIDTH * 3 + 
ADDRLP4 124
CNSTI4 3
ASGNI4
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 24
ADDI4
ADDRLP4 56
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ADDRLP4 44
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ASGNI4
line 947
;945:				TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;
;946:
;947:			CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 952
;948:				st, hcolor, qfalse, qfalse,
;949:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0 );
;950:
;951:			// draw weapon icon
;952:			xx += TINYCHAR_WIDTH * 3;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 954
;953:
;954:			if ( cg_weapons[ci->curWeapon].weaponIcon ) {
CNSTI4 136
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $467
line 955
;955:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 136
CNSTF4 1090519040
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
CNSTI4 136
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 957
;956:					cg_weapons[ci->curWeapon].weaponIcon );
;957:			} else {
ADDRGP4 $468
JUMPV
LABELV $467
line 958
;958:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 136
CNSTF4 1090519040
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRGP4 cgs+153876+132
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 960
;959:					cgs.media.deferShader );
;960:			}
LABELV $468
line 963
;961:
;962:			// Draw powerup icons
;963:			if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $473
line 964
;964:				xx = x;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 965
;965:			} else {
ADDRGP4 $474
JUMPV
LABELV $473
line 966
;966:				xx = x + w - TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
CNSTI4 8
SUBI4
ASGNI4
line 967
;967:			}
LABELV $474
line 968
;968:			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $475
line 969
;969:				if (ci->powerups & (1 << j)) {
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $479
line 971
;970:
;971:					item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 136
INDIRP4
ASGNP4
line 973
;972:
;973:					if (item) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $481
line 974
;974:						CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 144
CNSTF4 1090519040
ASGNF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 976
;975:						trap_R_RegisterShader( item->icon ) );
;976:						if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $483
line 977
;977:							xx -= TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 978
;978:						} else {
ADDRGP4 $484
JUMPV
LABELV $483
line 979
;979:							xx += TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 980
;980:						}
LABELV $484
line 981
;981:					}
LABELV $481
line 982
;982:				}
LABELV $479
line 983
;983:			}
LABELV $476
line 968
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LEI4 $475
line 985
;984:
;985:			y += TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 986
;986:		}
LABELV $452
line 987
;987:	}
LABELV $448
line 912
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $450
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $447
line 989
;988:
;989:	return ret_y;
ADDRLP4 88
INDIRI4
CVIF4 4
RETF4
LABELV $397
endproc CG_DrawTeamOverlay 148 36
proc CG_DrawUpperRight 12 12
line 1000
;990://#endif
;991:}
;992:
;993:
;994:/*
;995:=====================
;996:CG_DrawUpperRight
;997:
;998:=====================
;999:*/
;1000:static void CG_DrawUpperRight( void ) {
line 1003
;1001:	float	y;
;1002:
;1003:	y = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1005
;1004:
;1005:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 1 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $486
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 1
NEI4 $486
line 1006
;1006:		y = CG_DrawTeamOverlay( y, qtrue, qtrue );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1007
;1007:	} 
LABELV $486
line 1008
;1008:	if ( cg_drawSnapshot.integer ) {
ADDRGP4 cg_drawSnapshot+12
INDIRI4
CNSTI4 0
EQI4 $490
line 1009
;1009:		y = CG_DrawSnapshot( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawSnapshot
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1010
;1010:	}
LABELV $490
line 1011
;1011:	if ( cg_drawFPS.integer ) {
ADDRGP4 cg_drawFPS+12
INDIRI4
CNSTI4 0
EQI4 $493
line 1012
;1012:		y = CG_DrawFPS( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawFPS
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1013
;1013:	}
LABELV $493
line 1014
;1014:	if ( cg_drawTimer.integer ) {
ADDRGP4 cg_drawTimer+12
INDIRI4
CNSTI4 0
EQI4 $496
line 1015
;1015:		y = CG_DrawTimer( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawTimer
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1016
;1016:	}
LABELV $496
line 1017
;1017:	if ( cg_drawAttacker.integer ) {
ADDRGP4 cg_drawAttacker+12
INDIRI4
CNSTI4 0
EQI4 $499
line 1018
;1018:		y = CG_DrawAttacker( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawAttacker
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1019
;1019:	}
LABELV $499
line 1021
;1020:
;1021:}
LABELV $485
endproc CG_DrawUpperRight 12 12
proc CG_DrawScores 76 20
line 1039
;1022:
;1023:/*
;1024:===========================================================================================
;1025:
;1026:  LOWER RIGHT CORNER
;1027:
;1028:===========================================================================================
;1029:*/
;1030:
;1031:/*
;1032:=================
;1033:CG_DrawScores
;1034:
;1035:Draw the small two score display
;1036:=================
;1037:*/
;1038:#ifndef MISSIONPACK
;1039:static float CG_DrawScores( float y ) {
line 1048
;1040:	const char	*s;
;1041:	int			s1, s2, score;
;1042:	int			x, w;
;1043:	int			v;
;1044:	vec4_t		color;
;1045:	float		y1;
;1046:	gitem_t		*item;
;1047:
;1048:	s1 = cgs.scores1;
ADDRLP4 28
ADDRGP4 cgs+34800
INDIRI4
ASGNI4
line 1049
;1049:	s2 = cgs.scores2;
ADDRLP4 32
ADDRGP4 cgs+34804
INDIRI4
ASGNI4
line 1051
;1050:
;1051:	y -=  BIGCHAR_HEIGHT + 8;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 1053
;1052:
;1053:	y1 = y;
ADDRLP4 36
ADDRFP4 0
INDIRF4
ASGNF4
line 1056
;1054:
;1055:	// draw from the right side to left
;1056:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $505
line 1057
;1057:		x = 640;
ADDRLP4 16
CNSTI4 640
ASGNI4
line 1058
;1058:		color[0] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1059
;1059:		color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1060
;1060:		color[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 1061
;1061:		color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1062
;1062:		s = va( "%2i", s2 );
ADDRGP4 $511
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 52
INDIRP4
ASGNP4
line 1063
;1063:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 56
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1064
;1064:		x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1065
;1065:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1066
;1066:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $512
line 1067
;1067:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+153876+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1068
;1068:		}
LABELV $512
line 1069
;1069:		CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1071
;1070:
;1071:		if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $517
line 1073
;1072:			// Display flag status
;1073:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 60
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 60
INDIRP4
ASGNP4
line 1075
;1074:
;1075:			if (item) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $520
line 1076
;1076:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 36
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1077
;1077:				if( cgs.blueflag >= 0 && cgs.blueflag <= 2 ) {
ADDRGP4 cgs+34812
INDIRI4
CNSTI4 0
LTI4 $522
ADDRGP4 cgs+34812
INDIRI4
CNSTI4 2
GTI4 $522
line 1078
;1078:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.blueflag] );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34812
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+153876+60
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1079
;1079:				}
LABELV $522
line 1080
;1080:			}
LABELV $520
line 1081
;1081:		}
LABELV $517
line 1082
;1082:		color[0] = 1.0f;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1083
;1083:		color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1084
;1084:		color[2] = 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1085
;1085:		color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1086
;1086:		s = va( "%2i", s1 );
ADDRGP4 $511
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1087
;1087:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1088
;1088:		x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1089
;1089:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1090
;1090:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $532
line 1091
;1091:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+153876+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1092
;1092:		}
LABELV $532
line 1093
;1093:		CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1095
;1094:
;1095:		if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $537
line 1097
;1096:			// Display flag status
;1097:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 68
INDIRP4
ASGNP4
line 1099
;1098:
;1099:			if (item) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $540
line 1100
;1100:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 36
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1101
;1101:				if( cgs.redflag >= 0 && cgs.redflag <= 2 ) {
ADDRGP4 cgs+34808
INDIRI4
CNSTI4 0
LTI4 $542
ADDRGP4 cgs+34808
INDIRI4
CNSTI4 2
GTI4 $542
line 1102
;1102:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.redFlagShader[cgs.redflag] );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34808
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+153876+48
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1103
;1103:				}
LABELV $542
line 1104
;1104:			}
LABELV $540
line 1105
;1105:		}
LABELV $537
line 1120
;1106:
;1107:#ifdef MISSIONPACK
;1108:		if ( cgs.gametype == GT_1FCTF ) {
;1109:			// Display flag status
;1110:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;1111:
;1112:			if (item) {
;1113:				y1 = y - BIGCHAR_HEIGHT - 8;
;1114:				if( cgs.flagStatus >= 0 && cgs.flagStatus <= 3 ) {
;1115:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.flagShader[cgs.flagStatus] );
;1116:				}
;1117:			}
;1118:		}
;1119:#endif
;1120:		if ( cgs.gametype >= GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
LTI4 $549
line 1121
;1121:			v = cgs.capturelimit;
ADDRLP4 44
ADDRGP4 cgs+31472
INDIRI4
ASGNI4
line 1122
;1122:		} else {
ADDRGP4 $550
JUMPV
LABELV $549
line 1123
;1123:			v = cgs.fraglimit;
ADDRLP4 44
ADDRGP4 cgs+31468
INDIRI4
ASGNI4
line 1124
;1124:		}
LABELV $550
line 1125
;1125:		if ( v ) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $506
line 1126
;1126:			s = va( "%2i", v );
ADDRGP4 $511
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 68
INDIRP4
ASGNP4
line 1127
;1127:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 72
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1128
;1128:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1129
;1129:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1130
;1130:		}
line 1132
;1131:
;1132:	} else {
ADDRGP4 $506
JUMPV
LABELV $505
line 1135
;1133:		qboolean	spectator;
;1134:
;1135:		x = 640;
ADDRLP4 16
CNSTI4 640
ASGNI4
line 1136
;1136:		score = cg.snap->ps.persistant[PERS_SCORE];
ADDRLP4 40
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ASGNI4
line 1137
;1137:		spectator = ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR );
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $559
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRGP4 $560
JUMPV
LABELV $559
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $560
ADDRLP4 52
ADDRLP4 56
INDIRI4
ASGNI4
line 1140
;1138:
;1139:		// always show your score in the second box if not in first place
;1140:		if ( s1 != score ) {
ADDRLP4 28
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $561
line 1141
;1141:			s2 = score;
ADDRLP4 32
ADDRLP4 40
INDIRI4
ASGNI4
line 1142
;1142:		}
LABELV $561
line 1143
;1143:		if ( s2 != SCORE_NOT_PRESENT ) {
ADDRLP4 32
INDIRI4
CNSTI4 -9999
EQI4 $563
line 1144
;1144:			s = va( "%2i", s2 );
ADDRGP4 $511
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1145
;1145:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1146
;1146:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1147
;1147:			if ( !spectator && score == s2 && score != s1 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $565
ADDRLP4 68
ADDRLP4 40
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $565
ADDRLP4 68
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $565
line 1148
;1148:				color[0] = 1.0f;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1149
;1149:				color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1150
;1150:				color[2] = 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1151
;1151:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1152
;1152:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1153
;1153:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+153876+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1154
;1154:			} else {
ADDRGP4 $566
JUMPV
LABELV $565
line 1155
;1155:				color[0] = 0.5f;
ADDRLP4 0
CNSTF4 1056964608
ASGNF4
line 1156
;1156:				color[1] = 0.5f;
ADDRLP4 0+4
CNSTF4 1056964608
ASGNF4
line 1157
;1157:				color[2] = 0.5f;
ADDRLP4 0+8
CNSTF4 1056964608
ASGNF4
line 1158
;1158:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1159
;1159:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1160
;1160:			}	
LABELV $566
line 1161
;1161:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1162
;1162:		}
LABELV $563
line 1165
;1163:
;1164:		// first place
;1165:		if ( s1 != SCORE_NOT_PRESENT ) {
ADDRLP4 28
INDIRI4
CNSTI4 -9999
EQI4 $575
line 1166
;1166:			s = va( "%2i", s1 );
ADDRGP4 $511
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1167
;1167:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1168
;1168:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1169
;1169:			if ( !spectator && score == s1 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $577
ADDRLP4 40
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $577
line 1170
;1170:				color[0] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1171
;1171:				color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1172
;1172:				color[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 1173
;1173:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1174
;1174:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1175
;1175:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+153876+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1176
;1176:			} else {
ADDRGP4 $578
JUMPV
LABELV $577
line 1177
;1177:				color[0] = 0.5f;
ADDRLP4 0
CNSTF4 1056964608
ASGNF4
line 1178
;1178:				color[1] = 0.5f;
ADDRLP4 0+4
CNSTF4 1056964608
ASGNF4
line 1179
;1179:				color[2] = 0.5f;
ADDRLP4 0+8
CNSTF4 1056964608
ASGNF4
line 1180
;1180:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1181
;1181:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1182
;1182:			}	
LABELV $578
line 1183
;1183:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1184
;1184:		}
LABELV $575
line 1186
;1185:
;1186:		if ( cgs.fraglimit ) {
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 0
EQI4 $587
line 1187
;1187:			s = va( "%2i", cgs.fraglimit );
ADDRGP4 $511
ARGP4
ADDRGP4 cgs+31468
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1188
;1188:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1189
;1189:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1190
;1190:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1191
;1191:		}
LABELV $587
line 1193
;1192:
;1193:	}
LABELV $506
line 1195
;1194:
;1195:	return y1 - 8;
ADDRLP4 36
INDIRF4
CNSTF4 1090519040
SUBF4
RETF4
LABELV $502
endproc CG_DrawScores 76 20
data
align 4
LABELV $592
byte 4 1045220557
byte 4 1065353216
byte 4 1045220557
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
code
proc CG_DrawPowerups 208 20
line 1205
;1196:}
;1197:#endif // MISSIONPACK
;1198:
;1199:/*
;1200:================
;1201:CG_DrawPowerups
;1202:================
;1203:*/
;1204:#ifndef MISSIONPACK
;1205:static float CG_DrawPowerups( float y ) {
line 1222
;1206:	int		sorted[MAX_POWERUPS];
;1207:	int		sortedTime[MAX_POWERUPS];
;1208:	int		i, j, k;
;1209:	int		active;
;1210:	playerState_t	*ps;
;1211:	int		t;
;1212:	gitem_t	*item;
;1213:	int		x;
;1214:	int		color;
;1215:	float	size;
;1216:	float	f;
;1217:	static float colors[2][4] = { 
;1218:    { 0.2f, 1.0f, 0.2f, 1.0f } , 
;1219:    { 1.0f, 0.2f, 0.2f, 1.0f } 
;1220:  };
;1221:
;1222:	ps = &cg.snap->ps;
ADDRLP4 148
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 1224
;1223:
;1224:	if ( ps->stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 148
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $594
line 1225
;1225:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $591
JUMPV
LABELV $594
line 1229
;1226:	}
;1227:
;1228:	// sort the list by time remaining
;1229:	active = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 1230
;1230:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $596
line 1231
;1231:		if ( !ps->powerups[ i ] ) {
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $600
line 1232
;1232:			continue;
ADDRGP4 $597
JUMPV
LABELV $600
line 1234
;1233:		}
;1234:		t = ps->powerups[ i ] - cg.time;
ADDRLP4 140
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 1237
;1235:		// ZOID--don't draw if the power up has unlimited time (999 seconds)
;1236:		// This is true of the CTF flags
;1237:		if ( t < 0 || t > 999000) {
ADDRLP4 140
INDIRI4
CNSTI4 0
LTI4 $605
ADDRLP4 140
INDIRI4
CNSTI4 999000
LEI4 $603
LABELV $605
line 1238
;1238:			continue;
ADDRGP4 $597
JUMPV
LABELV $603
line 1242
;1239:		}
;1240:
;1241:		// insert into the list
;1242:		for ( j = 0 ; j < active ; j++ ) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $609
JUMPV
LABELV $606
line 1243
;1243:			if ( sortedTime[j] >= t ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $610
line 1244
;1244:				for ( k = active - 1 ; k >= j ; k-- ) {
ADDRLP4 0
ADDRLP4 136
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $615
JUMPV
LABELV $612
line 1245
;1245:					sorted[k+1] = sorted[k];
ADDRLP4 176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 176
INDIRI4
ADDRLP4 68+4
ADDP4
ADDRLP4 176
INDIRI4
ADDRLP4 68
ADDP4
INDIRI4
ASGNI4
line 1246
;1246:					sortedTime[k+1] = sortedTime[k];
ADDRLP4 180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 180
INDIRI4
ADDRLP4 4+4
ADDP4
ADDRLP4 180
INDIRI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 1247
;1247:				}
LABELV $613
line 1244
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $615
ADDRLP4 0
INDIRI4
ADDRLP4 132
INDIRI4
GEI4 $612
line 1248
;1248:				break;
ADDRGP4 $608
JUMPV
LABELV $610
line 1250
;1249:			}
;1250:		}
LABELV $607
line 1242
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $609
ADDRLP4 132
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $606
LABELV $608
line 1251
;1251:		sorted[j] = i;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 1252
;1252:		sortedTime[j] = t;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 1253
;1253:		active++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1254
;1254:	}
LABELV $597
line 1230
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 16
LTI4 $596
line 1257
;1255:
;1256:	// draw the icons and timers
;1257:	x = 640 - ICON_SIZE - CHAR_WIDTH * 2;
ADDRLP4 168
CNSTI4 528
ASGNI4
line 1258
;1258:	for ( i = 0 ; i < active ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRGP4 $621
JUMPV
LABELV $618
line 1259
;1259:		item = BG_FindItemForPowerup( sorted[i] );
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 152
ADDRLP4 172
INDIRP4
ASGNP4
line 1261
;1260:
;1261:    if (item) {
ADDRLP4 152
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $622
line 1263
;1262:
;1263:		  color = 1;
ADDRLP4 164
CNSTI4 1
ASGNI4
line 1265
;1264:
;1265:		  y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1111490560
SUBF4
ASGNF4
line 1267
;1266:
;1267:		  trap_R_SetColor( colors[color] );
ADDRLP4 164
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $592
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1268
;1268:		  CG_DrawField( x, y, 2, sortedTime[ i ] / 1000 );
ADDRLP4 168
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 176
CNSTI4 2
ASGNI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ADDRLP4 176
INDIRI4
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 1270
;1269:
;1270:		  t = ps->powerups[ sorted[i] ];
ADDRLP4 180
CNSTI4 2
ASGNI4
ADDRLP4 140
ADDRLP4 144
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1271
;1271:		  if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $624
line 1272
;1272:			  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1273
;1273:		  } else {
ADDRGP4 $625
JUMPV
LABELV $624
line 1276
;1274:			  vec4_t	modulate;
;1275:
;1276:			  f = (float)( t - cg.time ) / POWERUP_BLINK_TIME;
ADDRLP4 160
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 1277
;1277:			  f -= (int)f;
ADDRLP4 160
ADDRLP4 160
INDIRF4
ADDRLP4 160
INDIRF4
CVFI4 4
CVIF4 4
SUBF4
ASGNF4
line 1278
;1278:			  modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
ADDRLP4 184+12
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184+8
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184
ADDRLP4 160
INDIRF4
ASGNF4
line 1279
;1279:			  trap_R_SetColor( modulate );
ADDRLP4 184
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1280
;1280:		  }
LABELV $625
line 1282
;1281:
;1282:		  if ( cg.powerupActive == sorted[i] && 
ADDRGP4 cg+124420
INDIRI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
NEI4 $631
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124424
INDIRI4
SUBI4
CNSTI4 200
GEI4 $631
line 1283
;1283:			  cg.time - cg.powerupTime < PULSE_TIME ) {
line 1284
;1284:			  f = 1.0 - ( ( (float)cg.time - cg.powerupTime ) / PULSE_TIME );
ADDRLP4 160
CNSTF4 1065353216
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+124424
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 1285
;1285:			  size = ICON_SIZE * ( 1.0 + ( PULSE_SCALE - 1.0 ) * f );
ADDRLP4 156
CNSTF4 1111490560
CNSTF4 1056964608
ADDRLP4 160
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1286
;1286:		  } else {
ADDRGP4 $632
JUMPV
LABELV $631
line 1287
;1287:			  size = ICON_SIZE;
ADDRLP4 156
CNSTF4 1111490560
ASGNF4
line 1288
;1288:		  }
LABELV $632
line 1290
;1289:
;1290:		  CG_DrawPic( 640 - size, y + ICON_SIZE / 2 - size / 2, 
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
CNSTF4 1142947840
ADDRLP4 156
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
ADDF4
ADDRLP4 156
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1292
;1291:			  size, size, trap_R_RegisterShader( item->icon ) );
;1292:    }
LABELV $622
line 1293
;1293:	}
LABELV $619
line 1258
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $621
ADDRLP4 144
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $618
line 1294
;1294:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1296
;1295:
;1296:	return y;
ADDRFP4 0
INDIRF4
RETF4
LABELV $591
endproc CG_DrawPowerups 208 20
proc CG_DrawLowerRight 12 12
line 1307
;1297:}
;1298:#endif // MISSIONPACK
;1299:
;1300:/*
;1301:=====================
;1302:CG_DrawLowerRight
;1303:
;1304:=====================
;1305:*/
;1306:#ifndef MISSIONPACK
;1307:static void CG_DrawLowerRight( void ) {
line 1310
;1308:	float	y;
;1309:
;1310:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 1312
;1311:
;1312:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 2 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $639
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 2
NEI4 $639
line 1313
;1313:		y = CG_DrawTeamOverlay( y, qtrue, qfalse );
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1314
;1314:	} 
LABELV $639
line 1316
;1315:
;1316:	y = CG_DrawScores( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawScores
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1317
;1317:	y = CG_DrawPowerups( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawPowerups
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1318
;1318:}
LABELV $638
endproc CG_DrawLowerRight 12 12
proc CG_DrawPickupItem 16 20
line 1327
;1319:#endif // MISSIONPACK
;1320:
;1321:/*
;1322:===================
;1323:CG_DrawPickupItem
;1324:===================
;1325:*/
;1326:#ifndef MISSIONPACK
;1327:static int CG_DrawPickupItem( int y ) {
line 1331
;1328:	int		value;
;1329:	float	*fadeColor;
;1330:
;1331:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $644
line 1332
;1332:		return y;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $643
JUMPV
LABELV $644
line 1335
;1333:	}
;1334:
;1335:	y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 48
SUBI4
ASGNI4
line 1337
;1336:
;1337:	value = cg.itemPickup;
ADDRLP4 0
ADDRGP4 cg+124676
INDIRI4
ASGNI4
line 1338
;1338:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $648
line 1339
;1339:		fadeColor = CG_FadeColor( cg.itemPickupTime, 3000 );
ADDRGP4 cg+124680
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 8
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1340
;1340:		if ( fadeColor ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $651
line 1341
;1341:			CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1342
;1342:			trap_R_SetColor( fadeColor );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1343
;1343:			CG_DrawPic( 8, y, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
CNSTF4 1090519040
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1344
;1344:			CG_DrawBigString( ICON_SIZE + 16, y + (ICON_SIZE/2 - BIGCHAR_HEIGHT/2), bg_itemlist[ value ].pickup_name, fadeColor[0] );
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 16
ADDI4
ARGI4
CNSTI4 52
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+28
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1345
;1345:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1346
;1346:		}
LABELV $651
line 1347
;1347:	}
LABELV $648
line 1349
;1348:	
;1349:	return y;
ADDRFP4 0
INDIRI4
RETI4
LABELV $643
endproc CG_DrawPickupItem 16 20
proc CG_DrawLowerLeft 16 12
line 1360
;1350:}
;1351:#endif // MISSIONPACK
;1352:
;1353:/*
;1354:=====================
;1355:CG_DrawLowerLeft
;1356:
;1357:=====================
;1358:*/
;1359:#ifndef MISSIONPACK
;1360:static void CG_DrawLowerLeft( void ) {
line 1363
;1361:	float	y;
;1362:
;1363:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 1365
;1364:
;1365:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 3 ) {
ADDRLP4 4
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $656
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $656
line 1366
;1366:		y = CG_DrawTeamOverlay( y, qfalse, qfalse );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1367
;1367:	} 
LABELV $656
line 1370
;1368:
;1369:
;1370:	y = CG_DrawPickupItem( y );
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawPickupItem
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
line 1371
;1371:}
LABELV $655
endproc CG_DrawLowerLeft 16 12
proc CG_DrawTeamInfo 56 36
line 1383
;1372:#endif // MISSIONPACK
;1373:
;1374:
;1375://===========================================================================================
;1376:
;1377:/*
;1378:=================
;1379:CG_DrawTeamInfo
;1380:=================
;1381:*/
;1382:#ifndef MISSIONPACK
;1383:static void CG_DrawTeamInfo( void ) {
line 1392
;1384:	int w, h;
;1385:	int i, len;
;1386:	vec4_t		hcolor;
;1387:	int		chatHeight;
;1388:
;1389:#define CHATLOC_Y 420 // bottom end
;1390:#define CHATLOC_X 0
;1391:
;1392:	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
ADDRGP4 cg_teamChatHeight+12
INDIRI4
CNSTI4 8
GEI4 $661
line 1393
;1393:		chatHeight = cg_teamChatHeight.integer;
ADDRLP4 8
ADDRGP4 cg_teamChatHeight+12
INDIRI4
ASGNI4
ADDRGP4 $662
JUMPV
LABELV $661
line 1395
;1394:	else
;1395:		chatHeight = TEAMCHAT_HEIGHT;
ADDRLP4 8
CNSTI4 8
ASGNI4
LABELV $662
line 1396
;1396:	if (chatHeight <= 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $665
line 1397
;1397:		return; // disabled
ADDRGP4 $660
JUMPV
LABELV $665
line 1399
;1398:
;1399:	if (cgs.teamLastChatPos != cgs.teamChatPos) {
ADDRGP4 cgs+153784
INDIRI4
ADDRGP4 cgs+153780
INDIRI4
EQI4 $667
line 1400
;1400:		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+153784
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+153748
ADDP4
INDIRI4
SUBI4
ADDRGP4 cg_teamChatTime+12
INDIRI4
LEI4 $671
line 1401
;1401:			cgs.teamLastChatPos++;
ADDRLP4 36
ADDRGP4 cgs+153784
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1402
;1402:		}
LABELV $671
line 1404
;1403:
;1404:		h = (cgs.teamChatPos - cgs.teamLastChatPos) * TINYCHAR_HEIGHT;
ADDRLP4 32
ADDRGP4 cgs+153780
INDIRI4
ADDRGP4 cgs+153784
INDIRI4
SUBI4
CNSTI4 3
LSHI4
ASGNI4
line 1406
;1405:
;1406:		w = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 1408
;1407:
;1408:		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
ADDRLP4 0
ADDRGP4 cgs+153784
INDIRI4
ASGNI4
ADDRGP4 $683
JUMPV
LABELV $680
line 1409
;1409:			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
CNSTI4 241
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+151820
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 36
INDIRI4
ASGNI4
line 1410
;1410:			if (len > w)
ADDRLP4 4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $687
line 1411
;1411:				w = len;
ADDRLP4 28
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $687
line 1412
;1412:		}
LABELV $681
line 1408
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $683
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+153780
INDIRI4
LTI4 $680
line 1413
;1413:		w *= TINYCHAR_WIDTH;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1414
;1414:		w += TINYCHAR_WIDTH * 2;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1416
;1415:
;1416:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $689
line 1417
;1417:			hcolor[0] = 1.0f;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1418
;1418:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1419
;1419:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1420
;1420:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1421
;1421:		} else if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 $690
JUMPV
LABELV $689
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $695
line 1422
;1422:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1423
;1423:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1424
;1424:			hcolor[2] = 1.0f;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 1425
;1425:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1426
;1426:		} else {
ADDRGP4 $696
JUMPV
LABELV $695
line 1427
;1427:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1428
;1428:			hcolor[1] = 1.0f;
ADDRLP4 12+4
CNSTF4 1065353216
ASGNF4
line 1429
;1429:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1430
;1430:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1431
;1431:		}
LABELV $696
LABELV $690
line 1433
;1432:
;1433:		trap_R_SetColor( hcolor );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1434
;1434:		CG_DrawPic( CHATLOC_X, CHATLOC_Y - h, 640, h, cgs.media.teamStatusBar );
CNSTF4 0
ARGF4
ADDRLP4 36
ADDRLP4 32
INDIRI4
ASGNI4
CNSTI4 420
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1142947840
ARGF4
ADDRLP4 36
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+153876+128
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1435
;1435:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1437
;1436:
;1437:		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 12+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
line 1438
;1438:		hcolor[3] = 1.0f;
ADDRLP4 12+12
CNSTF4 1065353216
ASGNF4
line 1440
;1439:
;1440:		for (i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i--) {
ADDRLP4 0
ADDRGP4 cgs+153780
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $712
JUMPV
LABELV $709
line 1441
;1441:			CG_DrawStringExt( CHATLOC_X + TINYCHAR_WIDTH, 
ADDRLP4 44
CNSTI4 8
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 420
ADDRGP4 cgs+153780
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 3
LSHI4
SUBI4
ARGI4
CNSTI4 241
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+151820
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1445
;1442:				CHATLOC_Y - (cgs.teamChatPos - i)*TINYCHAR_HEIGHT, 
;1443:				cgs.teamChatMsgs[i % chatHeight], hcolor, qfalse, qfalse,
;1444:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0 );
;1445:		}
LABELV $710
line 1440
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $712
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+153784
INDIRI4
GEI4 $709
line 1446
;1446:	}
LABELV $667
line 1447
;1447:}
LABELV $660
endproc CG_DrawTeamInfo 56 36
proc CG_DrawHoldableItem 8 20
line 1456
;1448:#endif // MISSIONPACK
;1449:
;1450:/*
;1451:===================
;1452:CG_DrawHoldableItem
;1453:===================
;1454:*/
;1455:#ifndef MISSIONPACK
;1456:static void CG_DrawHoldableItem( void ) { 
line 1459
;1457:	int		value;
;1458:
;1459:	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 1460
;1460:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $719
line 1461
;1461:		CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1462
;1462:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
CNSTF4 1142161408
ARGF4
CNSTF4 1129840640
ARGF4
ADDRLP4 4
CNSTF4 1111490560
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1463
;1463:	}
LABELV $719
line 1465
;1464:
;1465:}
LABELV $717
endproc CG_DrawHoldableItem 8 20
proc CG_DrawReward 68 36
line 1493
;1466:#endif // MISSIONPACK
;1467:
;1468:#ifdef MISSIONPACK
;1469:/*
;1470:===================
;1471:CG_DrawPersistantPowerup
;1472:===================
;1473:*/
;1474:#if 0 // sos001208 - DEAD
;1475:static void CG_DrawPersistantPowerup( void ) { 
;1476:	int		value;
;1477:
;1478:	value = cg.snap->ps.stats[STAT_PERSISTANT_POWERUP];
;1479:	if ( value ) {
;1480:		CG_RegisterItemVisuals( value );
;1481:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2 - ICON_SIZE, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
;1482:	}
;1483:}
;1484:#endif
;1485:#endif // MISSIONPACK
;1486:
;1487:
;1488:/*
;1489:===================
;1490:CG_DrawReward
;1491:===================
;1492:*/
;1493:static void CG_DrawReward( void ) { 
line 1499
;1494:	float	*color;
;1495:	int		i, count;
;1496:	float	x, y;
;1497:	char	buf[32];
;1498:
;1499:	if ( !cg_drawRewards.integer ) {
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 0
NEI4 $723
line 1500
;1500:		return;
ADDRGP4 $722
JUMPV
LABELV $723
line 1503
;1501:	}
;1502:
;1503:	color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+124440
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 52
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 52
INDIRP4
ASGNP4
line 1504
;1504:	if ( !color ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $727
line 1505
;1505:		if (cg.rewardStack > 0) {
ADDRGP4 cg+124436
INDIRI4
CNSTI4 0
LEI4 $722
line 1506
;1506:			for(i = 0; i < cg.rewardStack; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $735
JUMPV
LABELV $732
line 1507
;1507:				cg.rewardSound[i] = cg.rewardSound[i+1];
ADDRLP4 56
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
INDIRI4
ADDRGP4 cg+124524
ADDP4
ADDRLP4 56
INDIRI4
ADDRGP4 cg+124524+4
ADDP4
INDIRI4
ASGNI4
line 1508
;1508:				cg.rewardShader[i] = cg.rewardShader[i+1];
ADDRLP4 60
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 60
INDIRI4
ADDRGP4 cg+124484
ADDP4
ADDRLP4 60
INDIRI4
ADDRGP4 cg+124484+4
ADDP4
INDIRI4
ASGNI4
line 1509
;1509:				cg.rewardCount[i] = cg.rewardCount[i+1];
ADDRLP4 64
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRGP4 cg+124444
ADDP4
ADDRLP4 64
INDIRI4
ADDRGP4 cg+124444+4
ADDP4
INDIRI4
ASGNI4
line 1510
;1510:			}
LABELV $733
line 1506
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $735
ADDRLP4 0
INDIRI4
ADDRGP4 cg+124436
INDIRI4
LTI4 $732
line 1511
;1511:			cg.rewardTime = cg.time;
ADDRGP4 cg+124440
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1512
;1512:			cg.rewardStack--;
ADDRLP4 56
ADDRGP4 cg+124436
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1513
;1513:			color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+124440
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 60
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 60
INDIRP4
ASGNP4
line 1514
;1514:			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
ADDRGP4 cg+124524
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1515
;1515:		} else {
line 1516
;1516:			return;
LABELV $730
line 1518
;1517:		}
;1518:	}
LABELV $727
line 1520
;1519:
;1520:	trap_R_SetColor( color );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1537
;1521:
;1522:	/*
;1523:	count = cg.rewardCount[0]/10;				// number of big rewards to draw
;1524:
;1525:	if (count) {
;1526:		y = 4;
;1527:		x = 320 - count * ICON_SIZE;
;1528:		for ( i = 0 ; i < count ; i++ ) {
;1529:			CG_DrawPic( x, y, (ICON_SIZE*2)-4, (ICON_SIZE*2)-4, cg.rewardShader[0] );
;1530:			x += (ICON_SIZE*2);
;1531:		}
;1532:	}
;1533:
;1534:	count = cg.rewardCount[0] - count*10;		// number of small rewards to draw
;1535:	*/
;1536:
;1537:	if ( cg.rewardCount[0] >= 10 ) {
ADDRGP4 cg+124444
INDIRI4
CNSTI4 10
LTI4 $751
line 1538
;1538:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 1539
;1539:		x = 320 - ICON_SIZE/2;
ADDRLP4 4
CNSTF4 1133772800
ASGNF4
line 1540
;1540:		CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1110441984
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cg+124484
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1541
;1541:		Com_sprintf(buf, sizeof(buf), "%d", cg.rewardCount[0]);
ADDRLP4 20
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $755
ARGP4
ADDRGP4 cg+124444
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1542
;1542:		x = ( SCREEN_WIDTH - SMALLCHAR_WIDTH * CG_DrawStrlen( buf ) ) / 2;
ADDRLP4 20
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
CNSTI4 640
ADDRLP4 60
INDIRI4
CNSTI4 3
LSHI4
SUBI4
CNSTI4 2
DIVI4
CVIF4 4
ASGNF4
line 1543
;1543:		CG_DrawStringExt( x, y+ICON_SIZE, buf, color, qfalse, qtrue,
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRF4
CNSTF4 1111490560
ADDF4
CVFI4 4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1545
;1544:								SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0 );
;1545:	}
ADDRGP4 $752
JUMPV
LABELV $751
line 1546
;1546:	else {
line 1548
;1547:
;1548:		count = cg.rewardCount[0];
ADDRLP4 12
ADDRGP4 cg+124444
INDIRI4
ASGNI4
line 1550
;1549:
;1550:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 1551
;1551:		x = 320 - count * ICON_SIZE/2;
ADDRLP4 4
CNSTI4 320
CNSTI4 48
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ASGNF4
line 1552
;1552:		for ( i = 0 ; i < count ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $761
JUMPV
LABELV $758
line 1553
;1553:			CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1110441984
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cg+124484
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1554
;1554:			x += ICON_SIZE;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 1555
;1555:		}
LABELV $759
line 1552
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $761
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $758
line 1556
;1556:	}
LABELV $752
line 1557
;1557:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1558
;1558:}
LABELV $722
endproc CG_DrawReward 68 36
export CG_AddLagometerFrameInfo
proc CG_AddLagometerFrameInfo 8 0
line 1589
;1559:
;1560:
;1561:/*
;1562:===============================================================================
;1563:
;1564:LAGOMETER
;1565:
;1566:===============================================================================
;1567:*/
;1568:
;1569:#define	LAG_SAMPLES		128
;1570:
;1571:
;1572:typedef struct {
;1573:	int		frameSamples[LAG_SAMPLES];
;1574:	int		frameCount;
;1575:	int		snapshotFlags[LAG_SAMPLES];
;1576:	int		snapshotSamples[LAG_SAMPLES];
;1577:	int		snapshotCount;
;1578:} lagometer_t;
;1579:
;1580:lagometer_t		lagometer;
;1581:
;1582:/*
;1583:==============
;1584:CG_AddLagometerFrameInfo
;1585:
;1586:Adds the current interpolate / extrapolate bar for this frame
;1587:==============
;1588:*/
;1589:void CG_AddLagometerFrameInfo( void ) {
line 1592
;1590:	int			offset;
;1591:
;1592:	offset = cg.time - cg.latestSnapshotTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+32
INDIRI4
SUBI4
ASGNI4
line 1593
;1593:	lagometer.frameSamples[ lagometer.frameCount & ( LAG_SAMPLES - 1) ] = offset;
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1594
;1594:	lagometer.frameCount++;
ADDRLP4 4
ADDRGP4 lagometer+512
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1595
;1595:}
LABELV $764
endproc CG_AddLagometerFrameInfo 8 0
export CG_AddLagometerSnapshotInfo
proc CG_AddLagometerSnapshotInfo 4 0
line 1607
;1596:
;1597:/*
;1598:==============
;1599:CG_AddLagometerSnapshotInfo
;1600:
;1601:Each time a snapshot is received, log its ping time and
;1602:the number of snapshots that were dropped before it.
;1603:
;1604:Pass NULL for a dropped packet.
;1605:==============
;1606:*/
;1607:void CG_AddLagometerSnapshotInfo( snapshot_t *snap ) {
line 1609
;1608:	// dropped packet
;1609:	if ( !snap ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $770
line 1610
;1610:		lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = -1;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
CNSTI4 -1
ASGNI4
line 1611
;1611:		lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1612
;1612:		return;
ADDRGP4 $769
JUMPV
LABELV $770
line 1616
;1613:	}
;1614:
;1615:	// add this snapshot's info
;1616:	lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->ping;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1617
;1617:	lagometer.snapshotFlags[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->snapFlags;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1618
;1618:	lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1619
;1619:}
LABELV $769
endproc CG_AddLagometerSnapshotInfo 4 0
proc CG_DrawDisconnect 64 20
line 1628
;1620:
;1621:/*
;1622:==============
;1623:CG_DrawDisconnect
;1624:
;1625:Should we draw something differnet for long lag vs no packets?
;1626:==============
;1627:*/
;1628:static void CG_DrawDisconnect( void ) {
line 1636
;1629:	float		x, y;
;1630:	int			cmdNum;
;1631:	usercmd_t	cmd;
;1632:	const char		*s;
;1633:	int			w;  // bk010215 - FIXME char message[1024];
;1634:
;1635:	// draw the phone jack if we are completely past our buffers
;1636:	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
ADDRLP4 44
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 44
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1637
;1637:	trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 1638
;1638:	if ( cmd.serverTime <= cg.snap->ps.commandTime
ADDRLP4 48
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $785
ADDRLP4 48
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $781
LABELV $785
line 1639
;1639:		|| cmd.serverTime > cg.time ) {	// special check for map_restart // bk 0102165 - FIXME
line 1640
;1640:		return;
ADDRGP4 $780
JUMPV
LABELV $781
line 1644
;1641:	}
;1642:
;1643:	// also add text in center of screen
;1644:	s = "Connection Interrupted"; // bk 010215 - FIXME
ADDRLP4 24
ADDRGP4 $786
ASGNP4
line 1645
;1645:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1646
;1646:	CG_DrawBigString( 320 - w/2, 100, s, 1.0F);
CNSTI4 320
ADDRLP4 40
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1649
;1647:
;1648:	// blink the icon
;1649:	if ( ( cg.time >> 9 ) & 1 ) {
ADDRGP4 cg+107604
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $787
line 1650
;1650:		return;
ADDRGP4 $780
JUMPV
LABELV $787
line 1653
;1651:	}
;1652:
;1653:	x = 640 - 48;
ADDRLP4 28
CNSTF4 1142161408
ASGNF4
line 1654
;1654:	y = 480 - 48;
ADDRLP4 32
CNSTF4 1138229248
ASGNF4
line 1656
;1655:
;1656:	CG_DrawPic( x, y, 48, 48, trap_R_RegisterShader("gfx/2d/net.tga" ) );
ADDRGP4 $790
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 1111490560
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1657
;1657:}
LABELV $780
endproc CG_DrawDisconnect 64 20
proc CG_DrawLagometer 64 36
line 1668
;1658:
;1659:
;1660:#define	MAX_LAGOMETER_PING	900
;1661:#define	MAX_LAGOMETER_RANGE	300
;1662:
;1663:/*
;1664:==============
;1665:CG_DrawLagometer
;1666:==============
;1667:*/
;1668:static void CG_DrawLagometer( void ) {
line 1676
;1669:	int		a, x, y, i;
;1670:	float	v;
;1671:	float	ax, ay, aw, ah, mid, range;
;1672:	int		color;
;1673:	float	vscale;
;1674:
;1675://unlagged - misc
;1676:	if ( !cg_lagometer.integer /* || cgs.localServer */) {
ADDRGP4 cg_lagometer+12
INDIRI4
CNSTI4 0
NEI4 $792
line 1678
;1677://unlagged - misc
;1678:		CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 1679
;1679:		return;
ADDRGP4 $791
JUMPV
LABELV $792
line 1689
;1680:	}
;1681:
;1682:	//
;1683:	// draw the graph
;1684:	//
;1685:#ifdef MISSIONPACK
;1686:	x = 640 - 48;
;1687:	y = 480 - 144;
;1688:#else
;1689:	x = 640 - 48;
ADDRLP4 44
CNSTI4 592
ASGNI4
line 1690
;1690:	y = 48;//480 - 48; // Shafe - Changed
ADDRLP4 48
CNSTI4 48
ASGNI4
line 1693
;1691:#endif
;1692:
;1693:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1694
;1694:	CG_DrawPic( x, y, 48, 48, cgs.media.lagometerShader );
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 48
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 52
CNSTF4 1111490560
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRGP4 cgs+153876+264
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1696
;1695:
;1696:	ax = x;
ADDRLP4 24
ADDRLP4 44
INDIRI4
CVIF4 4
ASGNF4
line 1697
;1697:	ay = y;
ADDRLP4 36
ADDRLP4 48
INDIRI4
CVIF4 4
ASGNF4
line 1698
;1698:	aw = 48;
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
line 1699
;1699:	ah = 48;
ADDRLP4 32
CNSTF4 1111490560
ASGNF4
line 1700
;1700:	CG_AdjustFrom640( &ax, &ay, &aw, &ah );
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 1702
;1701:
;1702:	color = -1;
ADDRLP4 20
CNSTI4 -1
ASGNI4
line 1703
;1703:	range = ah / 3;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1077936128
DIVF4
ASGNF4
line 1704
;1704:	mid = ay + range;
ADDRLP4 40
ADDRLP4 36
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
line 1706
;1705:
;1706:	vscale = range / MAX_LAGOMETER_RANGE;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 1133903872
DIVF4
ASGNF4
line 1709
;1707:
;1708:	// draw the frame interpoalte / extrapolate graph
;1709:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $800
JUMPV
LABELV $797
line 1710
;1710:		i = ( lagometer.frameCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 1711
;1711:		v = lagometer.frameSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1712
;1712:		v *= vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1713
;1713:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $802
line 1714
;1714:			if ( color != 1 ) {
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $804
line 1715
;1715:				color = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 1716
;1716:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1717
;1717:			}
LABELV $804
line 1718
;1718:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $807
line 1719
;1719:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1720
;1720:			}
LABELV $807
line 1721
;1721:			trap_R_DrawStretchPic ( ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+153876+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1722
;1722:		} else if ( v < 0 ) {
ADDRGP4 $803
JUMPV
LABELV $802
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $811
line 1723
;1723:			if ( color != 2 ) {
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $813
line 1724
;1724:				color = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 1725
;1725:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_BLUE)] );
ADDRGP4 g_color_table+64
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1726
;1726:			}
LABELV $813
line 1727
;1727:			v = -v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
line 1728
;1728:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $816
line 1729
;1729:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1730
;1730:			}
LABELV $816
line 1731
;1731:			trap_R_DrawStretchPic( ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cgs+153876+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1732
;1732:		}
LABELV $811
LABELV $803
line 1733
;1733:	}
LABELV $798
line 1709
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $800
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $797
line 1736
;1734:
;1735:	// draw the snapshot latency / drop graph
;1736:	range = ah / 2;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 1737
;1737:	vscale = range / MAX_LAGOMETER_PING;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 1147207680
DIVF4
ASGNF4
line 1739
;1738:
;1739:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $823
JUMPV
LABELV $820
line 1740
;1740:		i = ( lagometer.snapshotCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 1741
;1741:		v = lagometer.snapshotSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1742
;1742:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $826
line 1743
;1743:			if ( lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED ) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $828
line 1744
;1744:				if ( color != 5 ) {
ADDRLP4 20
INDIRI4
CNSTI4 5
EQI4 $829
line 1745
;1745:					color = 5;	// YELLOW for rate delay
ADDRLP4 20
CNSTI4 5
ASGNI4
line 1746
;1746:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1747
;1747:				}
line 1748
;1748:			} else {
ADDRGP4 $829
JUMPV
LABELV $828
line 1749
;1749:				if ( color != 3 ) {
ADDRLP4 20
INDIRI4
CNSTI4 3
EQI4 $834
line 1750
;1750:					color = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 1751
;1751:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_GREEN)] );
ADDRGP4 g_color_table+32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1752
;1752:				}
LABELV $834
line 1753
;1753:			}
LABELV $829
line 1754
;1754:			v = v * vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1755
;1755:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $837
line 1756
;1756:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1757
;1757:			}
LABELV $837
line 1758
;1758:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+153876+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1759
;1759:		} else if ( v < 0 ) {
ADDRGP4 $827
JUMPV
LABELV $826
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $841
line 1760
;1760:			if ( color != 4 ) {
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $843
line 1761
;1761:				color = 4;		// RED for dropped snapshots
ADDRLP4 20
CNSTI4 4
ASGNI4
line 1762
;1762:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_RED)] );
ADDRGP4 g_color_table+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1763
;1763:			}
LABELV $843
line 1764
;1764:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+153876+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1765
;1765:		}
LABELV $841
LABELV $827
line 1766
;1766:	}
LABELV $821
line 1739
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $823
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $820
line 1768
;1767:
;1768:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1770
;1769:
;1770:	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
ADDRLP4 56
CNSTI4 0
ASGNI4
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 56
INDIRI4
NEI4 $852
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 56
INDIRI4
EQI4 $848
LABELV $852
line 1771
;1771:		CG_DrawBigString( ax, ay, "snc", 1.0 );
ADDRLP4 24
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 $853
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1772
;1772:	}
LABELV $848
line 1774
;1773:
;1774:	CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 1775
;1775:}
LABELV $791
endproc CG_DrawLagometer 64 36
export CG_CenterPrint
proc CG_CenterPrint 8 12
line 1796
;1776:
;1777:
;1778:
;1779:/*
;1780:===============================================================================
;1781:
;1782:CENTER PRINTING
;1783:
;1784:===============================================================================
;1785:*/
;1786:
;1787:
;1788:/*
;1789:==============
;1790:CG_CenterPrint
;1791:
;1792:Called for important messages that should stay in the center of the screen
;1793:for a few moments
;1794:==============
;1795:*/
;1796:void CG_CenterPrint( const char *str, int y, int charWidth ) {
line 1799
;1797:	char	*s;
;1798:
;1799:	Q_strncpyz( cg.centerPrint, str, sizeof(cg.centerPrint) );
ADDRGP4 cg+123376
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1801
;1800:
;1801:	cg.centerPrintTime = cg.time;
ADDRGP4 cg+123364
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1802
;1802:	cg.centerPrintY = y;
ADDRGP4 cg+123372
ADDRFP4 4
INDIRI4
ASGNI4
line 1803
;1803:	cg.centerPrintCharWidth = charWidth;
ADDRGP4 cg+123368
ADDRFP4 8
INDIRI4
ASGNI4
line 1806
;1804:
;1805:	// count the number of lines for centering
;1806:	cg.centerPrintLines = 1;
ADDRGP4 cg+124400
CNSTI4 1
ASGNI4
line 1807
;1807:	s = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+123376
ASGNP4
ADDRGP4 $864
JUMPV
LABELV $863
line 1808
;1808:	while( *s ) {
line 1809
;1809:		if (*s == '\n')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $866
line 1810
;1810:			cg.centerPrintLines++;
ADDRLP4 4
ADDRGP4 cg+124400
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $866
line 1811
;1811:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1812
;1812:	}
LABELV $864
line 1808
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $863
line 1813
;1813:}
LABELV $854
endproc CG_CenterPrint 8 12
proc CG_DrawCenterString 1064 36
line 1821
;1814:
;1815:
;1816:/*
;1817:===================
;1818:CG_DrawCenterString
;1819:===================
;1820:*/
;1821:static void CG_DrawCenterString( void ) {
line 1830
;1822:	char	*start;
;1823:	int		l;
;1824:	int		x, y, w;
;1825:#ifdef MISSIONPACK // bk010221 - unused else
;1826:  int h;
;1827:#endif
;1828:	float	*color;
;1829:
;1830:	if ( !cg.centerPrintTime ) {
ADDRGP4 cg+123364
INDIRI4
CNSTI4 0
NEI4 $870
line 1831
;1831:		return;
ADDRGP4 $869
JUMPV
LABELV $870
line 1834
;1832:	}
;1833:
;1834:	color = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value );
ADDRGP4 cg+123364
INDIRI4
ARGI4
CNSTF4 1148846080
ADDRGP4 cg_centertime+8
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRLP4 24
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 1835
;1835:	if ( !color ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $875
line 1836
;1836:		return;
ADDRGP4 $869
JUMPV
LABELV $875
line 1839
;1837:	}
;1838:
;1839:	trap_R_SetColor( color );
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1841
;1840:
;1841:	start = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+123376
ASGNP4
line 1843
;1842:
;1843:	y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;
ADDRLP4 8
ADDRGP4 cg+123372
INDIRI4
ADDRGP4 cg+124400
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
ADDRGP4 $881
JUMPV
LABELV $880
line 1845
;1844:
;1845:	while ( 1 ) {
line 1848
;1846:		char linebuffer[1024];
;1847:
;1848:		for ( l = 0; l < 50; l++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $883
line 1849
;1849:			if ( !start[l] || start[l] == '\n' ) {
ADDRLP4 1052
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $889
ADDRLP4 1052
INDIRI4
CNSTI4 10
NEI4 $887
LABELV $889
line 1850
;1850:				break;
ADDRGP4 $885
JUMPV
LABELV $887
line 1852
;1851:			}
;1852:			linebuffer[l] = start[l];
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 1853
;1853:		}
LABELV $884
line 1848
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 50
LTI4 $883
LABELV $885
line 1854
;1854:		linebuffer[l] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
CNSTI1 0
ASGNI1
line 1863
;1855:
;1856:#ifdef MISSIONPACK
;1857:		w = CG_Text_Width(linebuffer, 0.5, 0);
;1858:		h = CG_Text_Height(linebuffer, 0.5, 0);
;1859:		x = (SCREEN_WIDTH - w) / 2;
;1860:		CG_Text_Paint(x, y + h, 0.5, color, linebuffer, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;1861:		y += h + 6;
;1862:#else
;1863:		w = cg.centerPrintCharWidth * CG_DrawStrlen( linebuffer );
ADDRLP4 28
ARGP4
ADDRLP4 1052
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRGP4 cg+123368
INDIRI4
ADDRLP4 1052
INDIRI4
MULI4
ASGNI4
line 1865
;1864:
;1865:		x = ( SCREEN_WIDTH - w ) / 2;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 1867
;1866:
;1867:		CG_DrawStringExt( x, y, linebuffer, color, qfalse, qtrue,
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1056
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cg+123368
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRGP4 cg+123368
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1870
;1868:			cg.centerPrintCharWidth, (int)(cg.centerPrintCharWidth * 1.5), 0 );
;1869:
;1870:		y += cg.centerPrintCharWidth * 1.5;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1069547520
ADDRGP4 cg+123368
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
ADDRGP4 $895
JUMPV
LABELV $894
line 1872
;1871:#endif
;1872:		while ( *start && ( *start != '\n' ) ) {
line 1873
;1873:			start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1874
;1874:		}
LABELV $895
line 1872
ADDRLP4 1060
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $897
ADDRLP4 1060
INDIRI4
CNSTI4 10
NEI4 $894
LABELV $897
line 1875
;1875:		if ( !*start ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $898
line 1876
;1876:			break;
ADDRGP4 $882
JUMPV
LABELV $898
line 1878
;1877:		}
;1878:		start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1879
;1879:	}
LABELV $881
line 1845
ADDRGP4 $880
JUMPV
LABELV $882
line 1881
;1880:
;1881:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1882
;1882:}
LABELV $869
endproc CG_DrawCenterString 1064 36
proc CG_DrawCrosshair 56 36
line 1900
;1883:
;1884:
;1885:
;1886:/*
;1887:================================================================================
;1888:
;1889:CROSSHAIR
;1890:
;1891:================================================================================
;1892:*/
;1893:
;1894:
;1895:/*
;1896:=================
;1897:CG_DrawCrosshair
;1898:=================
;1899:*/
;1900:static void CG_DrawCrosshair(void) {
line 1907
;1901:	float		w, h;
;1902:	qhandle_t	hShader;
;1903:	float		f;
;1904:	float		x, y;
;1905:	int			ca;
;1906:
;1907:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $901
line 1908
;1908:		return;
ADDRGP4 $900
JUMPV
LABELV $901
line 1911
;1909:	}
;1910:
;1911:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $904
line 1912
;1912:		return;
ADDRGP4 $900
JUMPV
LABELV $904
line 1915
;1913:	}
;1914:
;1915:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $907
line 1916
;1916:		return;
ADDRGP4 $900
JUMPV
LABELV $907
line 1920
;1917:	}
;1918:
;1919:	// set color based on health
;1920:	if ( cg_crosshairHealth.integer ) {
ADDRGP4 cg_crosshairHealth+12
INDIRI4
CNSTI4 0
EQI4 $910
line 1923
;1921:		vec4_t		hcolor;
;1922:
;1923:		CG_ColorForHealth( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 1924
;1924:		trap_R_SetColor( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1925
;1925:	} else {
ADDRGP4 $911
JUMPV
LABELV $910
line 1926
;1926:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1927
;1927:	}
LABELV $911
line 1929
;1928:
;1929:	w = h = cg_crosshairSize.value;
ADDRLP4 28
ADDRGP4 cg_crosshairSize+8
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ASGNF4
line 1932
;1930:
;1931:	// pulse the size of the crosshair when picking up items
;1932:	f = cg.time - cg.itemPickupBlendTime;
ADDRLP4 8
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124684
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 1933
;1933:	if ( f > 0 && f < ITEM_BLOB_TIME ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $916
ADDRLP4 8
INDIRF4
CNSTF4 1128792064
GEF4 $916
line 1934
;1934:		f /= ITEM_BLOB_TIME;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 1935
;1935:		w *= ( 1 + f );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1936
;1936:		h *= ( 1 + f );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1937
;1937:	}
LABELV $916
line 1939
;1938:
;1939:	x = cg_crosshairX.integer;
ADDRLP4 16
ADDRGP4 cg_crosshairX+12
INDIRI4
CVIF4 4
ASGNF4
line 1940
;1940:	y = cg_crosshairY.integer;
ADDRLP4 20
ADDRGP4 cg_crosshairY+12
INDIRI4
CVIF4 4
ASGNF4
line 1941
;1941:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 1943
;1942:
;1943:	ca = cg_drawCrosshair.integer;
ADDRLP4 12
ADDRGP4 cg_drawCrosshair+12
INDIRI4
ASGNI4
line 1944
;1944:	if (ca < 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $921
line 1945
;1945:		ca = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1946
;1946:	}
LABELV $921
line 1947
;1947:	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];
ADDRLP4 24
ADDRLP4 12
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+153876+224
ADDP4
INDIRI4
ASGNI4
line 1949
;1948:
;1949:	trap_R_DrawStretchPic( x + cg.refdef.x + 0.5 * (cg.refdef.width - w), 
ADDRLP4 36
CNSTF4 1056964608
ASGNF4
ADDRLP4 40
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109048
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg+109048+8
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 44
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRGP4 cg+109048+4
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg+109048+12
INDIRI4
CVIF4 4
ADDRLP4 44
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
CNSTF4 1065353216
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1952
;1950:		y + cg.refdef.y + 0.5 * (cg.refdef.height - h), 
;1951:		w, h, 0, 0, 1, 1, hShader );
;1952:}
LABELV $900
endproc CG_DrawCrosshair 56 36
proc CG_ScanForCrosshairEntity 96 28
line 1961
;1953:
;1954:
;1955:
;1956:/*
;1957:=================
;1958:CG_ScanForCrosshairEntity
;1959:=================
;1960:*/
;1961:static void CG_ScanForCrosshairEntity( void ) {
line 1966
;1962:	trace_t		trace;
;1963:	vec3_t		start, end;
;1964:	int			content;
;1965:
;1966:	VectorCopy( cg.refdef.vieworg, start );
ADDRLP4 0
ADDRGP4 cg+109048+24
INDIRB
ASGNB 12
line 1967
;1967:	VectorMA( start, 131072, cg.refdef.viewaxis[0], end );
ADDRLP4 84
CNSTF4 1207959552
ASGNF4
ADDRLP4 68
ADDRLP4 0
INDIRF4
ADDRLP4 84
INDIRF4
ADDRGP4 cg+109048+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRGP4 cg+109048+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1207959552
ADDRGP4 cg+109048+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1969
;1968:
;1969:	CG_Trace( &trace, start, vec3_origin, vec3_origin, end, 
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 88
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 33554433
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 1978
;1970:		cg.snap->ps.clientNum, CONTENTS_SOLID|CONTENTS_BODY );
;1971:	/*
;1972:	if ( trace.entityNum >= MAX_CLIENTS ) {
;1973:		return;
;1974:	}
;1975:	*/
;1976:
;1977:	// if the player is in fog, don't show it
;1978:	content = trap_CM_PointContents( trace.endpos, 0 );
ADDRLP4 12+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 92
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 92
INDIRI4
ASGNI4
line 1979
;1979:	if ( content & CONTENTS_FOG ) {
ADDRLP4 80
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $949
line 1980
;1980:		return;
ADDRGP4 $932
JUMPV
LABELV $949
line 1984
;1981:	}
;1982:
;1983:	// if the player is invisible, don't show it
;1984:	if ( cg_entities[ trace.entityNum ].currentState.powerups & ( 1 << PW_INVIS ) ) {
CNSTI4 732
ADDRLP4 12+52
INDIRI4
MULI4
ADDRGP4 cg_entities+188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $951
line 1985
;1985:		return;
ADDRGP4 $932
JUMPV
LABELV $951
line 1989
;1986:	}
;1987:
;1988:	// update the fade timer
;1989:	cg.crosshairClientNum = trace.entityNum;
ADDRGP4 cg+124412
ADDRLP4 12+52
INDIRI4
ASGNI4
line 1990
;1990:	cg.crosshairClientTime = cg.time;
ADDRGP4 cg+124416
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1991
;1991:}
LABELV $932
endproc CG_ScanForCrosshairEntity 96 28
proc CG_DrawCrosshairNames 36 16
line 1999
;1992:
;1993:
;1994:/*
;1995:=====================
;1996:CG_DrawCrosshairNames
;1997:=====================
;1998:*/
;1999:static void CG_DrawCrosshairNames( void ) {
line 2006
;2000:	float		*color;
;2001:	char		*name;
;2002:	char		*s;
;2003:	int			health;
;2004:	float		w;
;2005:
;2006:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $960
line 2007
;2007:		return;
ADDRGP4 $959
JUMPV
LABELV $960
line 2009
;2008:	}
;2009:	if ( !cg_drawCrosshairNames.integer ) {
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
CNSTI4 0
NEI4 $963
line 2010
;2010:		return;
ADDRGP4 $959
JUMPV
LABELV $963
line 2012
;2011:	}
;2012:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $966
line 2013
;2013:		return;
ADDRGP4 $959
JUMPV
LABELV $966
line 2017
;2014:	}
;2015:
;2016:	// scan the known entities to see if the crosshair is sighted on one
;2017:	CG_ScanForCrosshairEntity();
ADDRGP4 CG_ScanForCrosshairEntity
CALLV
pop
line 2020
;2018:
;2019:	// draw the name of the player being looked at
;2020:	color = CG_FadeColor( cg.crosshairClientTime, 1000 );
ADDRGP4 cg+124416
INDIRI4
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 20
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 2021
;2021:	if ( !color ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $970
line 2022
;2022:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2023
;2023:		return;
ADDRGP4 $959
JUMPV
LABELV $970
line 2026
;2024:	}
;2025:
;2026:	name = cgs.clientinfo[ cg.crosshairClientNum ].name;
ADDRLP4 4
CNSTI4 1732
ADDRGP4 cg+124412
INDIRI4
MULI4
ADDRGP4 cgs+40972+4
ADDP4
ASGNP4
line 2027
;2027:	health = cgs.clientinfo[ cg.crosshairClientNum ].health;
ADDRLP4 8
CNSTI4 1732
ADDRGP4 cg+124412
INDIRI4
MULI4
ADDRGP4 cgs+40972+108
ADDP4
INDIRI4
ASGNI4
line 2034
;2028:
;2029:#ifdef MISSIONPACK
;2030:	color[3] *= 0.5f;
;2031:	w = CG_Text_Width(name, 0.3f, 0);
;2032:	CG_Text_Paint( 320 - w / 2, 190, 0.3f, color, name, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
;2033:#else
;2034:	w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
CNSTI4 4
LSHI4
CVIF4 4
ASGNF4
line 2035
;2035:	CG_DrawBigString( 320 - w / 2, 170, name, color[3] * 0.5f );
CNSTF4 1134559232
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
CVFI4 4
ARGI4
CNSTI4 170
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2036
;2036:	s = va( "%i", health);
ADDRGP4 $109
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 28
INDIRP4
ASGNP4
line 2037
;2037:	if (health != 0) 
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $978
line 2038
;2038:	{
line 2039
;2039:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 32
INDIRI4
CNSTI4 4
LSHI4
CVIF4 4
ASGNF4
line 2040
;2040:		CG_DrawSmallString( 320 - w / 2, 190, s, color[3] * 0.5f );
CNSTF4 1134559232
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
CVFI4 4
ARGI4
CNSTI4 190
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 2041
;2041:	}
LABELV $978
line 2044
;2042:
;2043:#endif
;2044:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2045
;2045:}
LABELV $959
endproc CG_DrawCrosshairNames 36 16
proc CG_DrawSpectator 0 16
line 2055
;2046:
;2047:
;2048://==============================================================================
;2049:
;2050:/*
;2051:=================
;2052:CG_DrawSpectator
;2053:=================
;2054:*/
;2055:static void CG_DrawSpectator(void) {
line 2056
;2056:	CG_DrawBigString(320 - 9 * 8, 440, "SPECTATOR", 1.0F);
CNSTI4 248
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $981
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2057
;2057:	if ( cgs.gametype == GT_TOURNAMENT ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $982
line 2058
;2058:		CG_DrawBigString(320 - 15 * 8, 460, "waiting to play", 1.0F);
CNSTI4 200
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $985
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2059
;2059:	}
ADDRGP4 $983
JUMPV
LABELV $982
line 2060
;2060:	else if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $986
line 2061
;2061:		CG_DrawBigString(320 - 39 * 8, 460, "press ESC and use the JOIN menu to play", 1.0F);
CNSTI4 8
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $989
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2062
;2062:	}
LABELV $986
LABELV $983
line 2063
;2063:}
LABELV $980
endproc CG_DrawSpectator 0 16
proc CG_DrawVote 12 20
line 2070
;2064:
;2065:/*
;2066:=================
;2067:CG_DrawVote
;2068:=================
;2069:*/
;2070:static void CG_DrawVote(void) {
line 2074
;2071:	char	*s;
;2072:	int		sec;
;2073:
;2074:	if ( !cgs.voteTime ) {
ADDRGP4 cgs+31676
INDIRI4
CNSTI4 0
NEI4 $991
line 2075
;2075:		return;
ADDRGP4 $990
JUMPV
LABELV $991
line 2079
;2076:	}
;2077:
;2078:	// play a talk beep whenever it is modified
;2079:	if ( cgs.voteModified ) {
ADDRGP4 cgs+31688
INDIRI4
CNSTI4 0
EQI4 $994
line 2080
;2080:		cgs.voteModified = qfalse;
ADDRGP4 cgs+31688
CNSTI4 0
ASGNI4
line 2081
;2081:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+153876+756
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2082
;2082:	}
LABELV $994
line 2084
;2083:
;2084:	sec = ( VOTE_TIME - ( cg.time - cgs.voteTime ) ) / 1000;
ADDRLP4 0
CNSTI4 30000
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+31676
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2085
;2085:	if ( sec < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1002
line 2086
;2086:		sec = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2087
;2087:	}
LABELV $1002
line 2094
;2088:#ifdef MISSIONPACK
;2089:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
;2090:	CG_DrawSmallString( 0, 58, s, 1.0F );
;2091:	s = "or press ESC then click Vote";
;2092:	CG_DrawSmallString( 0, 58 + SMALLCHAR_HEIGHT + 2, s, 1.0F );
;2093:#else
;2094:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo );
ADDRGP4 $1004
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cgs+31692
ARGP4
ADDRGP4 cgs+31680
INDIRI4
ARGI4
ADDRGP4 cgs+31684
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 2095
;2095:	CG_DrawSmallString( 0, 58, s, 1.0F );
CNSTI4 0
ARGI4
CNSTI4 58
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 2097
;2096:#endif
;2097:}
LABELV $990
endproc CG_DrawVote 12 20
proc CG_DrawTeamVote 24 20
line 2104
;2098:
;2099:/*
;2100:=================
;2101:CG_DrawTeamVote
;2102:=================
;2103:*/
;2104:static void CG_DrawTeamVote(void) {
line 2108
;2105:	char	*s;
;2106:	int		sec, cs_offset;
;2107:
;2108:	if ( cgs.clientinfo->team == TEAM_RED )
ADDRGP4 cgs+40972+68
INDIRI4
CNSTI4 1
NEI4 $1009
line 2109
;2109:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1010
JUMPV
LABELV $1009
line 2110
;2110:	else if ( cgs.clientinfo->team == TEAM_BLUE )
ADDRGP4 cgs+40972+68
INDIRI4
CNSTI4 2
NEI4 $1008
line 2111
;2111:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 2113
;2112:	else
;2113:		return;
LABELV $1014
LABELV $1010
line 2115
;2114:
;2115:	if ( !cgs.teamVoteTime[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32716
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1017
line 2116
;2116:		return;
ADDRGP4 $1008
JUMPV
LABELV $1017
line 2120
;2117:	}
;2118:
;2119:	// play a talk beep whenever it is modified
;2120:	if ( cgs.teamVoteModified[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1020
line 2121
;2121:		cgs.teamVoteModified[cs_offset] = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32740
ADDP4
CNSTI4 0
ASGNI4
line 2122
;2122:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+153876+756
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2123
;2123:	}
LABELV $1020
line 2125
;2124:
;2125:	sec = ( VOTE_TIME - ( cg.time - cgs.teamVoteTime[cs_offset] ) ) / 1000;
ADDRLP4 4
CNSTI4 30000
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32716
ADDP4
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2126
;2126:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1028
line 2127
;2127:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2128
;2128:	}
LABELV $1028
line 2129
;2129:	s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
ADDRGP4 $1030
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+32748
ADDP4
ARGP4
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 cgs+32724
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ADDRGP4 cgs+32732
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 2131
;2130:							cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;2131:	CG_DrawSmallString( 0, 90, s, 1.0F );
CNSTI4 0
ARGI4
CNSTI4 90
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 2132
;2132:}
LABELV $1008
endproc CG_DrawTeamVote 24 20
proc CG_DrawScoreboard 4 0
line 2135
;2133:
;2134:
;2135:static qboolean CG_DrawScoreboard() {
line 2200
;2136:#ifdef MISSIONPACK
;2137:	static qboolean firstTime = qtrue;
;2138:	float fade, *fadeColor;
;2139:
;2140:	if (menuScoreboard) {
;2141:		menuScoreboard->window.flags &= ~WINDOW_FORCED;
;2142:	}
;2143:	if (cg_paused.integer) {
;2144:		cg.deferredPlayerLoading = 0;
;2145:		firstTime = qtrue;
;2146:		return qfalse;
;2147:	}
;2148:
;2149:	// should never happen in Team Arena
;2150:	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;2151:		cg.deferredPlayerLoading = 0;
;2152:		firstTime = qtrue;
;2153:		return qfalse;
;2154:	}
;2155:
;2156:	// don't draw scoreboard during death while warmup up
;2157:	if ( cg.warmup && !cg.showScores ) {
;2158:		return qfalse;
;2159:	}
;2160:
;2161:	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;2162:		fade = 1.0;
;2163:		fadeColor = colorWhite;
;2164:	} else {
;2165:		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );
;2166:		if ( !fadeColor ) {
;2167:			// next time scoreboard comes up, don't print killer
;2168:			cg.deferredPlayerLoading = 0;
;2169:			cg.killerName[0] = 0;
;2170:			firstTime = qtrue;
;2171:			return qfalse;
;2172:		}
;2173:		fade = *fadeColor;
;2174:	}																					  
;2175:
;2176:
;2177:	if (menuScoreboard == NULL) {
;2178:		if ( cgs.gametype >= GT_TEAM ) {
;2179:			menuScoreboard = Menus_FindByName("teamscore_menu");
;2180:		} else {
;2181:			menuScoreboard = Menus_FindByName("score_menu");
;2182:		}
;2183:	}
;2184:
;2185:	if (menuScoreboard) {
;2186:		if (firstTime) {
;2187:			CG_SetScoreSelection(menuScoreboard);
;2188:			firstTime = qfalse;
;2189:		}
;2190:		Menu_Paint(menuScoreboard, qtrue);
;2191:	}
;2192:
;2193:	// load any models that have been deferred
;2194:	if ( ++cg.deferredPlayerLoading > 10 ) {
;2195:		CG_LoadDeferredPlayers();
;2196:	}
;2197:
;2198:	return qtrue;
;2199:#else
;2200:	return CG_DrawOldScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawOldScoreboard
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $1034
endproc CG_DrawScoreboard 4 0
proc CG_DrawIntermission 4 0
line 2209
;2201:#endif
;2202:}
;2203:
;2204:/*
;2205:=================
;2206:CG_DrawIntermission
;2207:=================
;2208:*/
;2209:static void CG_DrawIntermission( void ) {
line 2217
;2210://	int key;
;2211:#ifdef MISSIONPACK
;2212:	//if (cg_singlePlayer.integer) {
;2213:	//	CG_DrawCenterString();
;2214:	//	return;
;2215:	//}
;2216:#else
;2217:	if ( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $1036
line 2218
;2218:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 2219
;2219:		return;
ADDRGP4 $1035
JUMPV
LABELV $1036
line 2222
;2220:	}
;2221:#endif
;2222:	cg.scoreFadeTime = cg.time;
ADDRGP4 cg+114340
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2223
;2223:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+114336
ADDRLP4 0
INDIRI4
ASGNI4
line 2224
;2224:}
LABELV $1035
endproc CG_DrawIntermission 4 0
proc CG_DrawFollow 32 36
line 2231
;2225:
;2226:/*
;2227:=================
;2228:CG_DrawFollow
;2229:=================
;2230:*/
;2231:static qboolean CG_DrawFollow( void ) {
line 2236
;2232:	float		x;
;2233:	vec4_t		color;
;2234:	const char	*name;
;2235:
;2236:	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $1043
line 2237
;2237:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1042
JUMPV
LABELV $1043
line 2239
;2238:	}
;2239:	color[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 2240
;2240:	color[1] = 1;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 2241
;2241:	color[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 2242
;2242:	color[3] = 1;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 2245
;2243:
;2244:
;2245:	CG_DrawBigString( 320 - 9 * 8, 24, "following", 1.0F );
CNSTI4 248
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 $1049
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2247
;2246:
;2247:	name = cgs.clientinfo[ cg.snap->ps.clientNum ].name;
ADDRLP4 16
CNSTI4 1732
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40972+4
ADDP4
ASGNP4
line 2249
;2248:
;2249:	x = 0.5 * ( 640 - GIANT_WIDTH * CG_DrawStrlen( name ) );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
CNSTF4 1056964608
CNSTI4 640
ADDRLP4 24
INDIRI4
CNSTI4 5
LSHI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 2251
;2250:
;2251:	CG_DrawStringExt( x, 40, name, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );
ADDRLP4 20
INDIRF4
CVFI4 4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2253
;2252:
;2253:	return qtrue;
CNSTI4 1
RETI4
LABELV $1042
endproc CG_DrawFollow 32 36
proc CG_DrawAmmoWarning 12 16
line 2263
;2254:}
;2255:
;2256:
;2257:
;2258:/*
;2259:=================
;2260:CG_DrawAmmoWarning
;2261:=================
;2262:*/
;2263:static void CG_DrawAmmoWarning( void ) {
line 2267
;2264:	const char	*s;
;2265:	int			w;
;2266:
;2267:	if ( cg_drawAmmoWarning.integer == 0 ) {
ADDRGP4 cg_drawAmmoWarning+12
INDIRI4
CNSTI4 0
NEI4 $1054
line 2268
;2268:		return;
ADDRGP4 $1053
JUMPV
LABELV $1054
line 2271
;2269:	}
;2270:
;2271:	if ( !cg.lowAmmoWarning ) {
ADDRGP4 cg+124404
INDIRI4
CNSTI4 0
NEI4 $1057
line 2272
;2272:		return;
ADDRGP4 $1053
JUMPV
LABELV $1057
line 2275
;2273:	}
;2274:
;2275:	if ( cg.lowAmmoWarning == 2 ) {
ADDRGP4 cg+124404
INDIRI4
CNSTI4 2
NEI4 $1060
line 2276
;2276:		s = "OUT OF AMMO";
ADDRLP4 0
ADDRGP4 $1063
ASGNP4
line 2277
;2277:	} else {
ADDRGP4 $1061
JUMPV
LABELV $1060
line 2278
;2278:		s = "LOW AMMO WARNING";
ADDRLP4 0
ADDRGP4 $1064
ASGNP4
line 2279
;2279:	}
LABELV $1061
line 2280
;2280:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2281
;2281:	CG_DrawSmallString(320 - w / 2, 64, s, 1.0F);
CNSTI4 320
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 2282
;2282:}
LABELV $1053
endproc CG_DrawAmmoWarning 12 16
proc CG_DrawWarmup 56 36
line 2331
;2283:
;2284:
;2285:#ifdef MISSIONPACK
;2286:/*
;2287:=================
;2288:CG_DrawProxWarning
;2289:=================
;2290:*/
;2291:static void CG_DrawProxWarning( void ) {
;2292:	char s [32];
;2293:	int			w;
;2294:  static int proxTime;
;2295:  static int proxCounter;
;2296:  static int proxTick;
;2297:
;2298:	if( !(cg.snap->ps.eFlags & EF_TICKING ) ) {
;2299:    proxTime = 0;
;2300:		return;
;2301:	}
;2302:
;2303:  if (proxTime == 0) {
;2304:    proxTime = cg.time + 5000;
;2305:    proxCounter = 5;
;2306:    proxTick = 0;
;2307:  }
;2308:
;2309:  if (cg.time > proxTime) {
;2310:    proxTick = proxCounter--;
;2311:    proxTime = cg.time + 1000;
;2312:  }
;2313:
;2314:  if (proxTick != 0) {
;2315:    Com_sprintf(s, sizeof(s), "INTERNAL COMBUSTION IN: %i", proxTick);
;2316:  } else {
;2317:    Com_sprintf(s, sizeof(s), "YOU HAVE BEEN MINED");
;2318:  }
;2319:
;2320:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
;2321:	CG_DrawBigStringColor( 320 - w / 2, 64 + BIGCHAR_HEIGHT, s, g_color_table[ColorIndex(COLOR_RED)] );
;2322:}
;2323:#endif
;2324:
;2325:
;2326:/*
;2327:=================
;2328:CG_DrawWarmup
;2329:=================
;2330:*/
;2331:static void CG_DrawWarmup( void ) {
line 2340
;2332:	int			w;
;2333:	int			sec;
;2334:	int			i;
;2335:	float scale;
;2336:	clientInfo_t	*ci1, *ci2;
;2337:	int			cw;
;2338:	const char	*s;
;2339:
;2340:	sec = cg.warmup;
ADDRLP4 4
ADDRGP4 cg+124668
INDIRI4
ASGNI4
line 2341
;2341:	if ( !sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1067
line 2342
;2342:		return;
ADDRGP4 $1065
JUMPV
LABELV $1067
line 2345
;2343:	}
;2344:
;2345:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1069
line 2346
;2346:		s = "Waiting for players";		
ADDRLP4 8
ADDRGP4 $1071
ASGNP4
line 2347
;2347:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2348
;2348:		CG_DrawBigString(320 - w / 2, 24, s, 1.0F);
CNSTI4 320
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2349
;2349:		cg.warmupCount = 0;
ADDRGP4 cg+124672
CNSTI4 0
ASGNI4
line 2350
;2350:		return;
ADDRGP4 $1065
JUMPV
LABELV $1069
line 2353
;2351:	}
;2352:
;2353:	if (cgs.gametype == GT_TOURNAMENT) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $1073
line 2355
;2354:		// find the two active players
;2355:		ci1 = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 2356
;2356:		ci2 = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 2357
;2357:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1079
JUMPV
LABELV $1076
line 2358
;2358:			if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE ) {
ADDRLP4 32
CNSTI4 1732
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+40972
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $1081
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1081
line 2359
;2359:				if ( !ci1 ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1086
line 2360
;2360:					ci1 = &cgs.clientinfo[i];
ADDRLP4 20
CNSTI4 1732
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 2361
;2361:				} else {
ADDRGP4 $1087
JUMPV
LABELV $1086
line 2362
;2362:					ci2 = &cgs.clientinfo[i];
ADDRLP4 24
CNSTI4 1732
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 2363
;2363:				}
LABELV $1087
line 2364
;2364:			}
LABELV $1081
line 2365
;2365:		}
LABELV $1077
line 2357
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1079
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $1076
line 2367
;2366:
;2367:		if ( ci1 && ci2 ) {
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1074
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1074
line 2368
;2368:			s = va( "%s vs %s", ci1->name, ci2->name );
ADDRGP4 $1092
ARGP4
ADDRLP4 36
CNSTI4 4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
ASGNP4
line 2373
;2369:#ifdef MISSIONPACK
;2370:			w = CG_Text_Width(s, 0.6f, 0);
;2371:			CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2372:#else
;2373:			w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 44
INDIRI4
ASGNI4
line 2374
;2374:			if ( w > 640 / GIANT_WIDTH ) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $1093
line 2375
;2375:				cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 2376
;2376:			} else {
ADDRGP4 $1094
JUMPV
LABELV $1093
line 2377
;2377:				cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 2378
;2378:			}
LABELV $1094
line 2379
;2379:			CG_DrawStringExt( 320 - w * cw/2, 20,s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 20
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2383
;2380:					qfalse, qtrue, cw, (int)(cw * 1.5f), 0 );
;2381:			
;2382:#endif
;2383:		}
line 2384
;2384:	} else {
ADDRGP4 $1074
JUMPV
LABELV $1073
line 2385
;2385:		if ( cgs.g_GameMode == 1) {
ADDRGP4 cgs+154960
INDIRI4
CNSTI4 1
NEI4 $1095
line 2386
;2386:			s = "Arsenal";
ADDRLP4 8
ADDRGP4 $1098
ASGNP4
line 2387
;2387:		} else if ( cgs.gametype == GT_FFA && cgs.g_GameMode == 0) {
ADDRGP4 $1096
JUMPV
LABELV $1095
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1099
ADDRGP4 cgs+154960
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $1099
line 2388
;2388:			s = "Free For All";
ADDRLP4 8
ADDRGP4 $1103
ASGNP4
line 2389
;2389:		} else if ( cgs.g_GameMode == 2) {
ADDRGP4 $1100
JUMPV
LABELV $1099
ADDRGP4 cgs+154960
INDIRI4
CNSTI4 2
NEI4 $1104
line 2390
;2390:			s = "Survival";
ADDRLP4 8
ADDRGP4 $1107
ASGNP4
line 2391
;2391:		} else if ( cgs.gametype == GT_TEAM ) {
ADDRGP4 $1105
JUMPV
LABELV $1104
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
NEI4 $1108
line 2392
;2392:			if ( cgs.g_GameMode == 2) 
ADDRGP4 cgs+154960
INDIRI4
CNSTI4 2
NEI4 $1111
line 2393
;2393:			{
line 2394
;2394:				s = "Team Survival";
ADDRLP4 8
ADDRGP4 $1114
ASGNP4
line 2395
;2395:			} else {
ADDRGP4 $1109
JUMPV
LABELV $1111
line 2396
;2396:				s = "Team Deathmatch";
ADDRLP4 8
ADDRGP4 $1115
ASGNP4
line 2397
;2397:			}
line 2398
;2398:		} else if ( cgs.gametype == GT_CTF ) {
ADDRGP4 $1109
JUMPV
LABELV $1108
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $1116
line 2399
;2399:			s = "Capture the Flag";
ADDRLP4 8
ADDRGP4 $1119
ASGNP4
line 2408
;2400:#ifdef MISSIONPACK
;2401:		} else if ( cgs.gametype == GT_1FCTF ) {
;2402:			s = "One Flag CTF";
;2403:		} else if ( cgs.gametype == GT_OBELISK ) {
;2404:			s = "Overload";
;2405:		} else if ( cgs.gametype == GT_HARVESTER ) {
;2406:			s = "Harvester";
;2407:#endif
;2408:		} else {
ADDRGP4 $1117
JUMPV
LABELV $1116
line 2409
;2409:			s = "";
ADDRLP4 8
ADDRGP4 $1120
ASGNP4
line 2410
;2410:		}
LABELV $1117
LABELV $1109
LABELV $1105
LABELV $1100
LABELV $1096
line 2415
;2411:#ifdef MISSIONPACK
;2412:		w = CG_Text_Width(s, 0.6f, 0);
;2413:		CG_Text_Paint(320 - w / 2, 90, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2414:#else
;2415:		w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 36
INDIRI4
ASGNI4
line 2416
;2416:		if ( w > 640 / GIANT_WIDTH ) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $1121
line 2417
;2417:			cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 2418
;2418:		} else {
ADDRGP4 $1122
JUMPV
LABELV $1121
line 2419
;2419:			cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 2420
;2420:		}
LABELV $1122
line 2421
;2421:		CG_DrawStringExt( 320 - w * cw/2, 25,s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 25
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1066192077
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2424
;2422:				qfalse, qtrue, cw, (int)(cw * 1.1f), 0 );
;2423:#endif
;2424:	}
LABELV $1074
line 2426
;2425:
;2426:	sec = ( sec - cg.time ) / 1000;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2427
;2427:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1124
line 2428
;2428:		cg.warmup = 0;
ADDRGP4 cg+124668
CNSTI4 0
ASGNI4
line 2429
;2429:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2430
;2430:	}
LABELV $1124
line 2432
;2431:	
;2432:	if(cgs.g_GameMode == 1)
ADDRGP4 cgs+154960
INDIRI4
CNSTI4 1
NEI4 $1127
line 2433
;2433:	{
line 2434
;2434:		s = va( "You Have %i Seconds To Join This Round", sec + 1 );
ADDRGP4 $1130
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 2435
;2435:	} else
ADDRGP4 $1128
JUMPV
LABELV $1127
line 2436
;2436:	{
line 2437
;2437:		s = va( "Starts in: %i", sec + 1 );
ADDRGP4 $1131
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 2438
;2438:	}
LABELV $1128
line 2441
;2439:	
;2440:
;2441:	if ( sec != cg.warmupCount ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+124672
INDIRI4
EQI4 $1132
line 2442
;2442:		cg.warmupCount = sec;
ADDRGP4 cg+124672
ADDRLP4 4
INDIRI4
ASGNI4
line 2443
;2443:		switch ( sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1138
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $1141
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $1144
ADDRGP4 $1137
JUMPV
LABELV $1138
line 2445
;2444:		case 0:
;2445:			trap_S_StartLocalSound( cgs.media.count1Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+153876+992
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2446
;2446:			break;
ADDRGP4 $1137
JUMPV
LABELV $1141
line 2448
;2447:		case 1:
;2448:			trap_S_StartLocalSound( cgs.media.count2Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+153876+988
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2449
;2449:			break;
ADDRGP4 $1137
JUMPV
LABELV $1144
line 2451
;2450:		case 2:
;2451:			trap_S_StartLocalSound( cgs.media.count3Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+153876+984
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2452
;2452:			break;
line 2454
;2453:		default:
;2454:			break;
LABELV $1137
line 2456
;2455:		}
;2456:	}
LABELV $1132
line 2457
;2457:	scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 2458
;2458:	switch ( cg.warmupCount ) {
ADDRLP4 32
ADDRGP4 cg+124672
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $1150
ADDRLP4 32
INDIRI4
CNSTI4 1
EQI4 $1151
ADDRLP4 32
INDIRI4
CNSTI4 2
EQI4 $1152
ADDRGP4 $1147
JUMPV
LABELV $1150
line 2460
;2459:	case 0:
;2460:		cw = 28;
ADDRLP4 12
CNSTI4 28
ASGNI4
line 2461
;2461:		scale = 0.54f;
ADDRLP4 28
CNSTF4 1057635697
ASGNF4
line 2462
;2462:		break;
ADDRGP4 $1148
JUMPV
LABELV $1151
line 2464
;2463:	case 1:
;2464:		cw = 24;
ADDRLP4 12
CNSTI4 24
ASGNI4
line 2465
;2465:		scale = 0.51f;
ADDRLP4 28
CNSTF4 1057132380
ASGNF4
line 2466
;2466:		break;
ADDRGP4 $1148
JUMPV
LABELV $1152
line 2468
;2467:	case 2:
;2468:		cw = 20;
ADDRLP4 12
CNSTI4 20
ASGNI4
line 2469
;2469:		scale = 0.48f;
ADDRLP4 28
CNSTF4 1056293519
ASGNF4
line 2470
;2470:		break;
ADDRGP4 $1148
JUMPV
LABELV $1147
line 2472
;2471:	default:
;2472:		cw = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
line 2473
;2473:		scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 2474
;2474:		break;
LABELV $1148
line 2481
;2475:	}
;2476:
;2477:#ifdef MISSIONPACK
;2478:		w = CG_Text_Width(s, scale, 0);
;2479:		CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2480:#else
;2481:	w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 36
INDIRI4
ASGNI4
line 2482
;2482:	CG_DrawStringExt( 320 - w * cw/2, 70, s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 70
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2485
;2483:			qfalse, qtrue, cw, (int)(cw * 1.5), 0 );
;2484:#endif
;2485:}
LABELV $1065
endproc CG_DrawWarmup 56 36
proc CG_Draw2D 8 0
line 2510
;2486:
;2487://==================================================================================
;2488:#ifdef MISSIONPACK
;2489:/* 
;2490:=================
;2491:CG_DrawTimedMenus
;2492:=================
;2493:*/
;2494:void CG_DrawTimedMenus() {
;2495:	if (cg.voiceTime) {
;2496:		int t = cg.time - cg.voiceTime;
;2497:		if ( t > 2500 ) {
;2498:			Menus_CloseByName("voiceMenu");
;2499:			trap_Cvar_Set("cl_conXOffset", "0");
;2500:			cg.voiceTime = 0;
;2501:		}
;2502:	}
;2503:}
;2504:#endif
;2505:/*
;2506:=================
;2507:CG_Draw2D
;2508:=================
;2509:*/
;2510:static void CG_Draw2D( void ) {
line 2517
;2511:#ifdef MISSIONPACK
;2512:	if (cgs.orderPending && cg.time > cgs.orderTime) {
;2513:		CG_CheckOrderPending();
;2514:	}
;2515:#endif
;2516:	// if we are taking a levelshot for the menu, don't draw anything
;2517:	if ( cg.levelShot ) {
ADDRGP4 cg+12
INDIRI4
CNSTI4 0
EQI4 $1154
line 2518
;2518:		return;
ADDRGP4 $1153
JUMPV
LABELV $1154
line 2521
;2519:	}
;2520:
;2521:	if ( cg_draw2D.integer == 0 ) {
ADDRGP4 cg_draw2D+12
INDIRI4
CNSTI4 0
NEI4 $1157
line 2522
;2522:		return;
ADDRGP4 $1153
JUMPV
LABELV $1157
line 2525
;2523:	}
;2524:
;2525:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1160
line 2526
;2526:		CG_DrawIntermission();
ADDRGP4 CG_DrawIntermission
CALLV
pop
line 2527
;2527:		return;
ADDRGP4 $1153
JUMPV
LABELV $1160
line 2535
;2528:	}
;2529:
;2530:/*
;2531:	if (cg.cameraMode) {
;2532:		return;
;2533:	}
;2534:*/
;2535:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1163
line 2536
;2536:		CG_DrawSpectator();
ADDRGP4 CG_DrawSpectator
CALLV
pop
line 2537
;2537:		CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 2538
;2538:		CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 2539
;2539:	} else {
ADDRGP4 $1164
JUMPV
LABELV $1163
line 2541
;2540:		// don't draw any status if dead or the scoreboard is being explicitly shown
;2541:		if ( !cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0 ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 cg+114332
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1166
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $1166
line 2549
;2542:
;2543:#ifdef MISSIONPACK
;2544:			if ( cg_drawStatus.integer ) {
;2545:				Menu_PaintAll();
;2546:				CG_DrawTimedMenus();
;2547:			}
;2548:#else
;2549:			CG_DrawStatusBar();
ADDRGP4 CG_DrawStatusBar
CALLV
pop
line 2552
;2550:#endif
;2551:      
;2552:			CG_DrawAmmoWarning();
ADDRGP4 CG_DrawAmmoWarning
CALLV
pop
line 2557
;2553:
;2554:#ifdef MISSIONPACK
;2555:			CG_DrawProxWarning();
;2556:#endif      
;2557:			CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 2558
;2558:			CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 2559
;2559:			CG_DrawWeaponSelect();
ADDRGP4 CG_DrawWeaponSelect
CALLV
pop
line 2562
;2560:
;2561:#ifndef MISSIONPACK
;2562:			CG_DrawHoldableItem();
ADDRGP4 CG_DrawHoldableItem
CALLV
pop
line 2566
;2563:#else
;2564:			//CG_DrawPersistantPowerup();
;2565:#endif
;2566:			CG_DrawReward();
ADDRGP4 CG_DrawReward
CALLV
pop
line 2567
;2567:			CG_DrawScanner();  // Shafe - Trep - Radar
ADDRGP4 CG_DrawScanner
CALLV
pop
line 2568
;2568:		}
LABELV $1166
line 2570
;2569:    
;2570:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1170
line 2572
;2571:#ifndef MISSIONPACK
;2572:			CG_DrawTeamInfo();
ADDRGP4 CG_DrawTeamInfo
CALLV
pop
line 2574
;2573:#endif
;2574:		}
LABELV $1170
line 2575
;2575:	}
LABELV $1164
line 2577
;2576:
;2577:	CG_DrawVote();
ADDRGP4 CG_DrawVote
CALLV
pop
line 2578
;2578:	CG_DrawTeamVote();
ADDRGP4 CG_DrawTeamVote
CALLV
pop
line 2580
;2579:
;2580:	CG_DrawLagometer();
ADDRGP4 CG_DrawLagometer
CALLV
pop
line 2587
;2581:
;2582:#ifdef MISSIONPACK
;2583:	if (!cg_paused.integer) {
;2584:		CG_DrawUpperRight();
;2585:	}
;2586:#else
;2587:	CG_DrawUpperRight();
ADDRGP4 CG_DrawUpperRight
CALLV
pop
line 2591
;2588:#endif
;2589:
;2590:#ifndef MISSIONPACK
;2591:	CG_DrawLowerRight();
ADDRGP4 CG_DrawLowerRight
CALLV
pop
line 2592
;2592:	CG_DrawLowerLeft();
ADDRGP4 CG_DrawLowerLeft
CALLV
pop
line 2595
;2593:#endif
;2594:
;2595:	if ( !CG_DrawFollow() ) {
ADDRLP4 0
ADDRGP4 CG_DrawFollow
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1173
line 2596
;2596:		CG_DrawWarmup();
ADDRGP4 CG_DrawWarmup
CALLV
pop
line 2597
;2597:	}
LABELV $1173
line 2600
;2598:
;2599:	// don't draw center string if scoreboard is up
;2600:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 4
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+114336
ADDRLP4 4
INDIRI4
ASGNI4
line 2601
;2601:	if ( !cg.scoreBoardShowing) {
ADDRGP4 cg+114336
INDIRI4
CNSTI4 0
NEI4 $1176
line 2602
;2602:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 2603
;2603:	}
LABELV $1176
line 2604
;2604:}
LABELV $1153
endproc CG_Draw2D 8 0
proc CG_DrawTourneyScoreboard 0 0
line 2607
;2605:
;2606:
;2607:static void CG_DrawTourneyScoreboard() {
line 2610
;2608:#ifdef MISSIONPACK
;2609:#else
;2610:	CG_DrawOldTourneyScoreboard();
ADDRGP4 CG_DrawOldTourneyScoreboard
CALLV
pop
line 2612
;2611:#endif
;2612:}
LABELV $1179
endproc CG_DrawTourneyScoreboard 0 0
export CG_DrawActive
proc CG_DrawActive 24 4
line 2621
;2613:
;2614:/*
;2615:=====================
;2616:CG_DrawActive
;2617:
;2618:Perform all drawing needed to completely fill the screen
;2619:=====================
;2620:*/
;2621:void CG_DrawActive( stereoFrame_t stereoView ) {
line 2626
;2622:	float		separation;
;2623:	vec3_t		baseOrg;
;2624:
;2625:	// optionally draw the info screen instead
;2626:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1181
line 2627
;2627:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 2628
;2628:		return;
ADDRGP4 $1180
JUMPV
LABELV $1181
line 2632
;2629:	}
;2630:
;2631:	// optionally draw the tournement scoreboard instead
;2632:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1184
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1184
line 2633
;2633:		( cg.snap->ps.pm_flags & PMF_SCOREBOARD ) ) {
line 2634
;2634:		CG_DrawTourneyScoreboard();
ADDRGP4 CG_DrawTourneyScoreboard
CALLV
pop
line 2635
;2635:		return;
ADDRGP4 $1180
JUMPV
LABELV $1184
line 2638
;2636:	}
;2637:
;2638:	switch ( stereoView ) {
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1191
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $1192
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $1194
ADDRGP4 $1188
JUMPV
LABELV $1191
line 2640
;2639:	case STEREO_CENTER:
;2640:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2641
;2641:		break;
ADDRGP4 $1189
JUMPV
LABELV $1192
line 2643
;2642:	case STEREO_LEFT:
;2643:		separation = -cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2644
;2644:		break;
ADDRGP4 $1189
JUMPV
LABELV $1194
line 2646
;2645:	case STEREO_RIGHT:
;2646:		separation = cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2647
;2647:		break;
ADDRGP4 $1189
JUMPV
LABELV $1188
line 2649
;2648:	default:
;2649:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2650
;2650:		CG_Error( "CG_DrawActive: Undefined stereoView" );
ADDRGP4 $1196
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2651
;2651:	}
LABELV $1189
line 2655
;2652:
;2653:
;2654:	// clear around the rendered view if sized down
;2655:	CG_TileClear();
ADDRGP4 CG_TileClear
CALLV
pop
line 2658
;2656:
;2657:	// offset vieworg appropriately if we're doing stereo separation
;2658:	VectorCopy( cg.refdef.vieworg, baseOrg );
ADDRLP4 4
ADDRGP4 cg+109048+24
INDIRB
ASGNB 12
line 2659
;2659:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $1199
line 2660
;2660:		VectorMA( cg.refdef.vieworg, -separation, cg.refdef.viewaxis[1], cg.refdef.vieworg );
ADDRGP4 cg+109048+24
ADDRGP4 cg+109048+24
INDIRF4
ADDRGP4 cg+109048+36+12
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109048+24+4
ADDRGP4 cg+109048+24+4
INDIRF4
ADDRGP4 cg+109048+36+12+4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109048+24+8
ADDRGP4 cg+109048+24+8
INDIRF4
ADDRGP4 cg+109048+36+12+8
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 2661
;2661:	}
LABELV $1199
line 2664
;2662:
;2663:	// draw 3D view
;2664:	trap_R_RenderScene( &cg.refdef );
ADDRGP4 cg+109048
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 2667
;2665:
;2666:	// restore original viewpoint if running stereo
;2667:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $1229
line 2668
;2668:		VectorCopy( baseOrg, cg.refdef.vieworg );
ADDRGP4 cg+109048+24
ADDRLP4 4
INDIRB
ASGNB 12
line 2669
;2669:	}
LABELV $1229
line 2672
;2670:
;2671:	// draw status bar and other floating elements
;2672: 	CG_Draw2D();
ADDRGP4 CG_Draw2D
CALLV
pop
line 2673
;2673:}
LABELV $1180
endproc CG_DrawActive 24 4
bss
export lagometer
align 4
LABELV lagometer
skip 1544
import CG_DrawScanner
import CG_ScannerOff_f
import CG_ScannerOn_f
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
import CG_TransitionEntity
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayerHeadshot
import CG_GibPlayer
import CG_ScorePlum
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon2
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
export teamChat2
align 1
LABELV teamChat2
skip 256
export teamChat1
align 1
LABELV teamChat1
skip 256
export systemChat
align 1
LABELV systemChat
skip 256
export numSortedTeamPlayers
align 4
LABELV numSortedTeamPlayers
skip 4
export sortedTeamPlayers
align 4
LABELV sortedTeamPlayers
skip 128
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawString
import CG_DrawPic
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_BuildSpectatorString
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import CG_Cvar_ClampInt
import CG_AddBoundingBox
import CG_PredictWeaponEffects
import cg_playerOrigins
import cg_plOut
import cg_latentCmds
import cg_latentSnaps
import cl_timeNudge
import cg_optimizePrediction
import cg_projectileNudge
import sv_fps
import cg_cmdTimeNudge
import cg_drawBBox
import cg_debugDelag
import cg_delag
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_cameraMode
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import pmove_msec
import pmove_fixed
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawAttacker
import cg_lagometer
import cg_stereoSeparation
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_ignore
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import Max_Ammo
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
import SnapVectorTowards
import tonextint
import init_tonextint
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
LABELV $1196
byte 1 67
byte 1 71
byte 1 95
byte 1 68
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 58
byte 1 32
byte 1 85
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 111
byte 1 86
byte 1 105
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $1131
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1130
byte 1 89
byte 1 111
byte 1 117
byte 1 32
byte 1 72
byte 1 97
byte 1 118
byte 1 101
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 83
byte 1 101
byte 1 99
byte 1 111
byte 1 110
byte 1 100
byte 1 115
byte 1 32
byte 1 84
byte 1 111
byte 1 32
byte 1 74
byte 1 111
byte 1 105
byte 1 110
byte 1 32
byte 1 84
byte 1 104
byte 1 105
byte 1 115
byte 1 32
byte 1 82
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $1120
byte 1 0
align 1
LABELV $1119
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1115
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $1114
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 83
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1107
byte 1 83
byte 1 117
byte 1 114
byte 1 118
byte 1 105
byte 1 118
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1103
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $1098
byte 1 65
byte 1 114
byte 1 115
byte 1 101
byte 1 110
byte 1 97
byte 1 108
byte 1 0
align 1
LABELV $1092
byte 1 37
byte 1 115
byte 1 32
byte 1 118
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1071
byte 1 87
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1064
byte 1 76
byte 1 79
byte 1 87
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 32
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $1063
byte 1 79
byte 1 85
byte 1 84
byte 1 32
byte 1 79
byte 1 70
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 0
align 1
LABELV $1049
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1030
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1004
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $989
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 83
byte 1 67
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 74
byte 1 79
byte 1 73
byte 1 78
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $985
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $981
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $853
byte 1 115
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $790
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 101
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $786
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 114
byte 1 117
byte 1 112
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $755
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $511
byte 1 37
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $466
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 0
align 1
LABELV $463
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $396
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $392
byte 1 37
byte 1 105
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $376
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $374
byte 1 110
byte 1 0
align 1
LABELV $109
byte 1 37
byte 1 105
byte 1 0
