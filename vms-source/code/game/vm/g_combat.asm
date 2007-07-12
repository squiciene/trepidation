export BroadCastSound
code
proc BroadCastSound 36 8
file "../g_combat.c"
line 9
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:// g_combat.c
;4:
;5:#include "g_local.h"
;6:
;7:
;8:// Shafe - Trep - Utility Function - Move this!  
;9:void BroadCastSound(char *path) {
line 12
;10:	gentity_t*te;
;11:	vec3_t origin;
;12:	if(!strlen(path))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $56
line 13
;13:	return;
ADDRGP4 $55
JUMPV
LABELV $56
line 14
;14:	origin[0] = origin[1] = origin[2] = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 20
INDIRF4
ASGNF4
line 15
;15:	te = G_TempEntity(origin, EV_GLOBAL_SOUND);
ADDRLP4 0
ARGP4
CNSTI4 48
ARGI4
ADDRLP4 24
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 24
INDIRP4
ASGNP4
line 16
;16:	te->s.eventParm = G_SoundIndex(path);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 G_SoundIndex
CALLI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 17
;17:	te->r.svFlags |= SVF_BROADCAST;
ADDRLP4 32
ADDRLP4 12
INDIRP4
CNSTI4 432
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 18
;18:}
LABELV $55
endproc BroadCastSound 36 8
export TeamCP
proc TeamCP 8 8
line 22
;19:
;20:
;21:void TeamCP(char *msg, int team)
;22:{
line 24
;23:	int			i;
;24:	for ( i = 0 ; i < level.maxclients ; i++ ) 
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $64
JUMPV
LABELV $61
line 25
;25:	{
line 26
;26:		if ( level.clients[i].pers.connected == CON_CONNECTED ) 
CNSTI4 3476
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
NEI4 $66
line 27
;27:		{
line 28
;28:			if (g_entities[i].client->sess.sessionTeam == team ) 
CNSTI4 924
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+524
ADDP4
INDIRP4
CNSTI4 2552
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $68
line 29
;29:			{
line 31
;30:				//ent = g_entities[i].client;
;31:				trap_SendServerCommand( i, va("cp \"^9%s\n\"", msg) );
ADDRGP4 $71
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 33
;32:				
;33:			}
LABELV $68
line 34
;34:		}
LABELV $66
line 35
;35:	}
LABELV $62
line 24
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $64
ADDRLP4 0
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $61
line 36
;36:}
LABELV $60
endproc TeamCP 8 8
export ScorePlum
proc ScorePlum 12 8
line 51
;37:
;38:/*====================================================
;39:
;40:		MOVE THE STUFF ABOVE TO SOME UTILITY AREA
;41:
;42:*/
;43:
;44:
;45:
;46:/*
;47:============
;48:ScorePlum
;49:============
;50:*/
;51:void ScorePlum( gentity_t *ent, vec3_t origin, int score ) {
line 54
;52:	gentity_t *plum;
;53:
;54:	plum = G_TempEntity( origin, EV_SCOREPLUM );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 71
ARGI4
ADDRLP4 4
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 56
;55:	// only send this temp entity to a single client
;56:	plum->r.svFlags |= SVF_SINGLECLIENT;
ADDRLP4 8
ADDRLP4 0
INDIRP4
CNSTI4 432
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 256
BORI4
ASGNI4
line 57
;57:	plum->r.singleClient = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 436
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 59
;58:	//
;59:	plum->s.otherEntityNum = ent->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 60
;60:	plum->s.time = score;
ADDRLP4 0
INDIRP4
CNSTI4 84
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 61
;61:}
LABELV $72
endproc ScorePlum 12 8
export AddScore
proc AddScore 12 12
line 70
;62:
;63:/*
;64:============
;65:AddScore
;66:
;67:Adds score to both the client and his team
;68:============
;69:*/
;70:void AddScore( gentity_t *ent, vec3_t origin, int score ) {
line 72
;71:
;72:		if ( !ent->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $74
line 73
;73:			return;
ADDRGP4 $73
JUMPV
LABELV $74
line 76
;74:		}
;75:		// no scoring during pre-match warmup
;76:		if ( level.warmupTime ) {
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $76
line 77
;77:			return;
ADDRGP4 $73
JUMPV
LABELV $76
line 80
;78:		}
;79:		// show score plum
;80:		ScorePlum(ent, origin, score);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 ScorePlum
CALLV
pop
line 82
;81:		//
;82:		ent->client->ps.persistant[PERS_SCORE] += score;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 248
ADDP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
line 83
;83:		ent->client->pers.TrueScore = ent->client->ps.persistant[PERS_SCORE];
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 2488
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 85
;84:
;85:	if (g_GameMode.integer != 3)
ADDRGP4 g_GameMode+12
INDIRI4
CNSTI4 3
EQI4 $79
line 86
;86:	{
line 87
;87:		if ( g_gametype.integer == GT_TEAM )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $82
line 88
;88:			level.teamScores[ ent->client->ps.persistant[PERS_TEAM] ] += score;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 260
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 level+52
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
ASGNI4
LABELV $82
line 90
;89:	
;90:	}
LABELV $79
line 91
;91:	CalculateRanks();
ADDRGP4 CalculateRanks
CALLV
pop
line 92
;92:}
LABELV $73
endproc AddScore 12 12
export TossClientItems
proc TossClientItems 32 12
line 101
;93:
;94:/*
;95:=================
;96:TossClientItems
;97:
;98:Toss the weapon and powerups for the killed player
;99:=================
;100:*/
;101:void TossClientItems( gentity_t *self ) {
line 109
;102:	gitem_t		*item;
;103:	int			weapon;
;104:	float		angle;
;105:	int			i;
;106:	gentity_t	*drop;
;107:
;108:	// drop the weapon if not a gauntlet or machinegun
;109:	weapon = self->s.weapon;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 117
;110:
;111:	// make a special check to see if they are changing to a new
;112:	// weapon that isn't the mg or gauntlet.  Without this, a client
;113:	// can pick up a weapon, be killed, and not drop the weapon because
;114:	// their weapon change hasn't completed yet and they are still holding the MG.
;115:	
;116:
;117:		if ( weapon == WP_MACHINEGUN || weapon == WP_GRAPPLING_HOOK ) 
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $89
ADDRLP4 16
INDIRI4
CNSTI4 10
NEI4 $87
LABELV $89
line 118
;118:		{
line 119
;119:			if ( self->client->ps.weaponstate == WEAPON_DROPPING ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $90
line 120
;120:				weapon = self->client->pers.cmd.weapon;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 492
ADDP4
INDIRU1
CVUI4 1
ASGNI4
line 121
;121:			}
LABELV $90
line 122
;122:			if ( !( self->client->ps.stats[STAT_WEAPONS] & ( 1 << weapon ) ) ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 16
INDIRI4
LSHI4
BANDI4
CNSTI4 0
NEI4 $92
line 123
;123:				weapon = WP_NONE;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 124
;124:			}
LABELV $92
line 125
;125:		}
LABELV $87
line 128
;126:
;127:	// Shafe - Trep - Dont drop weapons In Instagib -- 
;128:	if (g_instagib.integer == 0)
ADDRGP4 g_instagib+12
INDIRI4
CNSTI4 0
NEI4 $94
line 129
;129:	{
line 131
;130:		
;131:		if ( weapon > WP_GAUNTLET && weapon != WP_GRAPPLING_HOOK && self->client->ps.ammo[ weapon ] ) 
ADDRLP4 16
INDIRI4
CNSTI4 1
LEI4 $97
ADDRLP4 16
INDIRI4
CNSTI4 10
EQI4 $97
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $97
line 132
;132:		{
line 134
;133:			// find the item type for this weapon
;134:			item = BG_FindItemForWeapon( weapon );
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
ASGNP4
line 137
;135:	
;136:			// spawn the item
;137:			Drop_Item( self, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Drop_Item
CALLP4
pop
line 138
;138:		} else 
ADDRGP4 $98
JUMPV
LABELV $97
line 139
;139:		{
line 141
;140:			// Else if it's arsenal or survival drop it anyway.
;141:			if (g_GameMode.integer == 2 || g_GameMode.integer == 1)
ADDRGP4 g_GameMode+12
INDIRI4
CNSTI4 2
EQI4 $103
ADDRGP4 g_GameMode+12
INDIRI4
CNSTI4 1
NEI4 $99
LABELV $103
line 142
;142:			{
line 144
;143:				// find the item type for this weapon
;144:				item = BG_FindItemForWeapon( weapon );
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 BG_FindItemForWeapon
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 28
INDIRP4
ASGNP4
line 147
;145:	
;146:				// spawn the item
;147:				Drop_Item( self, item, 0 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 Drop_Item
CALLP4
pop
line 149
;148:
;149:			}
LABELV $99
line 150
;150:		}
LABELV $98
line 151
;151:	} // End Shafe - Trep instagib
LABELV $94
line 158
;152:
;153:
;154:	
;155:	// Shafe - Always drop everything
;156:	// drop all the powerups if not in teamplay
;157:	//if ( g_gametype.integer != GT_TEAM && g_GameMode.integer != 3 ) {
;158:		angle = 45;
ADDRLP4 12
CNSTF4 1110704128
ASGNF4
line 159
;159:		for ( i = 1 ; i < PW_NUM_POWERUPS ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $104
line 160
;160:			if ( self->client->ps.powerups[ i ] > level.time ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $108
line 161
;161:				item = BG_FindItemForPowerup( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 24
INDIRP4
ASGNP4
line 162
;162:				if ( !item ) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $111
line 163
;163:					continue;
ADDRGP4 $105
JUMPV
LABELV $111
line 165
;164:				}
;165:				drop = Drop_Item( self, item, angle );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 28
ADDRGP4 Drop_Item
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 28
INDIRP4
ASGNP4
line 167
;166:				// decide how many seconds it has left
;167:				drop->count = ( self->client->ps.powerups[ i ] - level.time ) / 1000;
ADDRLP4 4
INDIRP4
CNSTI4 784
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 168
;168:				if ( drop->count < 1 ) {
ADDRLP4 4
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 1
GEI4 $114
line 169
;169:					drop->count = 1;
ADDRLP4 4
INDIRP4
CNSTI4 784
ADDP4
CNSTI4 1
ASGNI4
line 170
;170:				}
LABELV $114
line 171
;171:				angle += 45;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1110704128
ADDF4
ASGNF4
line 172
;172:			}
LABELV $108
line 173
;173:		}
LABELV $105
line 159
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LTI4 $104
line 175
;174:	//}
;175:}
LABELV $86
endproc TossClientItems 32 12
export LookAtKiller
proc LookAtKiller 52 4
line 265
;176:
;177:#ifdef MISSIONPACK
;178:
;179:/*
;180:=================
;181:TossClientCubes
;182:=================
;183:*/
;184:extern gentity_t	*neutralObelisk;
;185:
;186:void TossClientCubes( gentity_t *self ) {
;187:	gitem_t		*item;
;188:	gentity_t	*drop;
;189:	vec3_t		velocity;
;190:	vec3_t		angles;
;191:	vec3_t		origin;
;192:
;193:	self->client->ps.generic1 = 0;
;194:
;195:	// this should never happen but we should never
;196:	// get the server to crash due to skull being spawned in
;197:	if (!G_EntitiesFree()) {
;198:		return;
;199:	}
;200:
;201:	if( self->client->sess.sessionTeam == TEAM_RED ) {
;202:		item = BG_FindItem( "Red Cube" );
;203:	}
;204:	else {
;205:		item = BG_FindItem( "Blue Cube" );
;206:	}
;207:
;208:	angles[YAW] = (float)(level.time % 360);
;209:	angles[PITCH] = 0;	// always forward
;210:	angles[ROLL] = 0;
;211:
;212:	AngleVectors( angles, velocity, NULL, NULL );
;213:	VectorScale( velocity, 150, velocity );
;214:	velocity[2] += 200 + crandom() * 50;
;215:
;216:	if( neutralObelisk ) {
;217:		VectorCopy( neutralObelisk->s.pos.trBase, origin );
;218:		origin[2] += 44;
;219:	} else {
;220:		VectorClear( origin ) ;
;221:	}
;222:
;223:	drop = LaunchItem( item, origin, velocity );
;224:
;225:	drop->nextthink = level.time + g_cubeTimeout.integer * 1000;
;226:	drop->think = G_FreeEntity;
;227:	drop->spawnflags = self->client->sess.sessionTeam;
;228:}
;229:
;230:
;231:/*
;232:=================
;233:TossClientPersistantPowerups
;234:=================
;235:*/
;236:void TossClientPersistantPowerups( gentity_t *ent ) {
;237:	gentity_t	*powerup;
;238:
;239:	if( !ent->client ) {
;240:		return;
;241:	}
;242:
;243:	if( !ent->client->persistantPowerup ) {
;244:		return;
;245:	}
;246:
;247:	powerup = ent->client->persistantPowerup;
;248:
;249:	powerup->r.svFlags &= ~SVF_NOCLIENT;
;250:	powerup->s.eFlags &= ~EF_NODRAW;
;251:	powerup->r.contents = CONTENTS_TRIGGER;
;252:	trap_LinkEntity( powerup );
;253:
;254:	ent->client->ps.stats[STAT_PERSISTANT_POWERUP] = 0;
;255:	ent->client->persistantPowerup = NULL;
;256:}
;257:#endif
;258:
;259:
;260:/*
;261:==================
;262:LookAtKiller
;263:==================
;264:*/
;265:void LookAtKiller( gentity_t *self, gentity_t *inflictor, gentity_t *attacker ) {
line 269
;266:	vec3_t		dir;
;267:	vec3_t		angles;
;268:
;269:	if ( attacker && attacker != self ) {
ADDRLP4 24
ADDRFP4 8
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 24
INDIRU4
CNSTU4 0
EQU4 $117
ADDRLP4 24
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $117
line 270
;270:		VectorSubtract (attacker->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 28
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 32
CNSTI4 24
ASGNI4
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 40
CNSTI4 28
ASGNI4
ADDRLP4 0+4
ADDRLP4 28
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
ADDRLP4 36
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
CNSTI4 32
ASGNI4
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 271
;271:	} else if ( inflictor && inflictor != self ) {
ADDRGP4 $118
JUMPV
LABELV $117
ADDRLP4 28
ADDRFP4 4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 28
INDIRU4
CNSTU4 0
EQU4 $121
ADDRLP4 28
INDIRU4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $121
line 272
;272:		VectorSubtract (inflictor->s.pos.trBase, self->s.pos.trBase, dir);
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 24
ASGNI4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 44
CNSTI4 28
ASGNI4
ADDRLP4 0+4
ADDRLP4 32
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 32
ASGNI4
ADDRLP4 0+8
ADDRFP4 4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 273
;273:	} else {
ADDRGP4 $122
JUMPV
LABELV $121
line 274
;274:		self->client->ps.stats[STAT_DEAD_YAW] = self->s.angles[YAW];
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 120
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 275
;275:		return;
ADDRGP4 $116
JUMPV
LABELV $122
LABELV $118
line 278
;276:	}
;277:
;278:	self->client->ps.stats[STAT_DEAD_YAW] = vectoyaw ( dir );
ADDRLP4 0
ARGP4
ADDRLP4 32
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 200
ADDP4
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 280
;279:
;280:	angles[YAW] = vectoyaw ( dir );
ADDRLP4 0
ARGP4
ADDRLP4 36
ADDRGP4 vectoyaw
CALLF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRF4
ASGNF4
line 281
;281:	angles[PITCH] = 0; 
ADDRLP4 12
CNSTF4 0
ASGNF4
line 282
;282:	angles[ROLL] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 283
;283:}
LABELV $116
endproc LookAtKiller 52 4
export GibEntity
proc GibEntity 0 12
line 291
;284:
;285:/*
;286:==================
;287:GibEntity
;288:==================
;289:*/
;290:void GibEntity( gentity_t *self, int killer ) 
;291:{
line 310
;292:
;293:	//if this entity still has kamikaze
;294:	/*
;295:	if (self->s.eFlags & EF_KAMIKAZE) {
;296:		// check if there is a kamikaze timer around for this owner
;297:		for (i = 0; i < MAX_GENTITIES; i++) {
;298:			ent = &g_entities[i];
;299:			if (!ent->inuse)
;300:				continue;
;301:			if (ent->activator != self)
;302:				continue;
;303:			if (strcmp(ent->classname, "kamikaze timer"))
;304:				continue;
;305:			G_FreeEntity(ent);
;306:			break;
;307:		}
;308:	}
;309:	*/
;310:	G_AddEvent( self, EV_GIB_PLAYER, killer );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 68
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 311
;311:	self->takedamage = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 0
ASGNI4
line 312
;312:	self->s.eType = ET_INVISIBLE;
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 10
ASGNI4
line 313
;313:	self->r.contents = 0;
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 0
ASGNI4
line 314
;314:}
LABELV $127
endproc GibEntity 0 12
export GibEntity_Headshot
proc GibEntity_Headshot 0 12
line 318
;315:
;316:
;317:// Shafe - Trep - Headshot Function
;318:void GibEntity_Headshot( gentity_t *self, int killer ) {
line 319
;319:	G_AddEvent( self, EV_GIB_PLAYER_HEADSHOT, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 69
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 320
;320:	self->client->noHead = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2716
ADDP4
CNSTI4 1
ASGNI4
line 321
;321:}
LABELV $128
endproc GibEntity_Headshot 0 12
export body_die
proc body_die 0 8
line 329
;322:// Shafe - Trep - End Headshot Function
;323:
;324:/*
;325:==================
;326:body_die
;327:==================
;328:*/
;329:void body_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
line 330
;330:	if ( self->health > GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 -40
LEI4 $130
line 331
;331:		return;
ADDRGP4 $129
JUMPV
LABELV $130
line 333
;332:	}
;333:	if ( !g_blood.integer ) {
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
NEI4 $132
line 334
;334:		self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 -39
ASGNI4
line 335
;335:		return;
ADDRGP4 $129
JUMPV
LABELV $132
line 338
;336:	}
;337:
;338:	GibEntity( self, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 339
;339:}
LABELV $129
endproc body_die 0 8
export IsOutOfWeapons
proc IsOutOfWeapons 0 0
line 342
;340:
;341:// Shafe - Trep - Arsenal Mod
;342:extern qboolean IsOutOfWeapons( gentity_t *ent ) {
line 344
;343:
;344:	if (g_GameMode.integer != 1) { return qfalse; } // Do nothing unless it's arsenal
ADDRGP4 g_GameMode+12
INDIRI4
CNSTI4 1
EQI4 $136
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $136
line 346
;345:
;346:	if (ent->client->pers.h_gauntlet) { return qfalse; }
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2448
ADDP4
INDIRI4
CNSTI4 0
EQI4 $139
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $139
line 347
;347:	if (ent->client->pers.h_mg) { return qfalse; }
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2452
ADDP4
INDIRI4
CNSTI4 0
EQI4 $141
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $141
line 348
;348:	if (ent->client->pers.h_sg) { return qfalse; }
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2456
ADDP4
INDIRI4
CNSTI4 0
EQI4 $143
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $143
line 349
;349:	if (ent->client->pers.h_grenade) { return qfalse; }
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2460
ADDP4
INDIRI4
CNSTI4 0
EQI4 $145
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $145
line 350
;350:	if (ent->client->pers.h_singcan) { return qfalse; }
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2464
ADDP4
INDIRI4
CNSTI4 0
EQI4 $147
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $147
line 351
;351:	if (ent->client->pers.h_flame) { return qfalse; }
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2468
ADDP4
INDIRI4
CNSTI4 0
EQI4 $149
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $149
line 352
;352:	if (ent->client->pers.h_gauss) { return qfalse; }
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2472
ADDP4
INDIRI4
CNSTI4 0
EQI4 $151
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $151
line 353
;353:	if (ent->client->pers.h_plasma) { return qfalse; }
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2476
ADDP4
INDIRI4
CNSTI4 0
EQI4 $153
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $153
line 354
;354:	if (ent->client->pers.h_bfg) { return qfalse; }
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2480
ADDP4
INDIRI4
CNSTI4 0
EQI4 $155
CNSTI4 0
RETI4
ADDRGP4 $135
JUMPV
LABELV $155
line 356
;355:
;356:	return qtrue;
CNSTI4 1
RETI4
LABELV $135
endproc IsOutOfWeapons 0 0
data
export modNames
align 4
LABELV modNames
address $157
address $158
address $159
address $160
address $161
address $162
address $163
address $164
address $165
address $166
address $167
address $168
address $169
address $170
address $171
address $172
address $173
address $174
address $175
address $176
address $177
address $178
address $179
address $180
address $181
address $182
export CheckAlmostCapture
code
proc CheckAlmostCapture 56 12
line 431
;357:}
;358:
;359:
;360:// these are just for logging, the client prints its own messages
;361:char	*modNames[] = {
;362:	"MOD_UNKNOWN",
;363:	"MOD_SHOTGUN",
;364:	"MOD_GAUNTLET",
;365:	"MOD_MACHINEGUN",
;366:	"MOD_GRENADE",
;367:	"MOD_GRENADE_SPLASH",
;368:	"MOD_ROCKET",
;369:	"MOD_ROCKET_SPLASH",
;370:	"MOD_PLASMA",
;371:	"MOD_PLASMA_SPLASH",
;372:	"MOD_RAILGUN",
;373:	"MOD_LIGHTNING",
;374:	"MOD_BFG",
;375:	"MOD_BFG_SPLASH",
;376:	"MOD_WATER",
;377:	"MOD_SLIME",
;378:	"MOD_LAVA",
;379:	"MOD_CRUSH",
;380:	"MOD_TELEFRAG",
;381:	"MOD_FALLING",
;382:	"MOD_SUICIDE",
;383:	"MOD_TARGET_LASER",
;384:	"MOD_TRIGGER_HURT",
;385:	"MOD_HEADSHOT",		// Shafe - Trep - Headshot
;386:	"MOD_TURRET",
;387:#ifdef MISSIONPACK
;388:	"MOD_NAIL",
;389:	"MOD_CHAINGUN",
;390:	"MOD_PROXIMITY_MINE",
;391:#endif
;392:	"MOD_GRAPPLE"
;393:};
;394:
;395:#ifdef MISSIONPACK
;396:/*
;397:==================
;398:Kamikaze_DeathActivate
;399:==================
;400:*/
;401:void Kamikaze_DeathActivate( gentity_t *ent ) {
;402:	G_StartKamikaze(ent);
;403:	G_FreeEntity(ent);
;404:}
;405:
;406:/*
;407:==================
;408:Kamikaze_DeathTimer
;409:==================
;410:*/
;411:void Kamikaze_DeathTimer( gentity_t *self ) {
;412:	gentity_t *ent;
;413:
;414:	ent = G_Spawn();
;415:	ent->classname = "kamikaze timer";
;416:	VectorCopy(self->s.pos.trBase, ent->s.pos.trBase);
;417:	ent->r.svFlags |= SVF_NOCLIENT;
;418:	ent->think = Kamikaze_DeathActivate;
;419:	ent->nextthink = level.time + 5 * 1000;
;420:
;421:	ent->activator = self;
;422:}
;423:
;424:#endif
;425:
;426:/*
;427:==================
;428:CheckAlmostCapture
;429:==================
;430:*/
;431:void CheckAlmostCapture( gentity_t *self, gentity_t *attacker ) {
line 437
;432:	gentity_t	*ent;
;433:	vec3_t		dir;
;434:	char		*classname;
;435:
;436:	// if this player was carrying a flag
;437:	if ( self->client->ps.powerups[PW_REDFLAG] ||
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $187
ADDRLP4 20
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $187
ADDRLP4 20
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $184
LABELV $187
line 439
;438:		self->client->ps.powerups[PW_BLUEFLAG] ||
;439:		self->client->ps.powerups[PW_NEUTRALFLAG] ) {
line 441
;440:		// get the goal flag this player should have been going for
;441:		if ( g_gametype.integer == GT_CTF ) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $188
line 442
;442:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2552
ADDP4
INDIRI4
CNSTI4 2
NEI4 $191
line 443
;443:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $193
ASGNP4
line 444
;444:			}
ADDRGP4 $189
JUMPV
LABELV $191
line 445
;445:			else {
line 446
;446:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $194
ASGNP4
line 447
;447:			}
line 448
;448:		}
ADDRGP4 $189
JUMPV
LABELV $188
line 449
;449:		else {
line 450
;450:			if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2552
ADDP4
INDIRI4
CNSTI4 2
NEI4 $195
line 451
;451:				classname = "team_CTF_redflag";
ADDRLP4 4
ADDRGP4 $194
ASGNP4
line 452
;452:			}
ADDRGP4 $196
JUMPV
LABELV $195
line 453
;453:			else {
line 454
;454:				classname = "team_CTF_blueflag";
ADDRLP4 4
ADDRGP4 $193
ASGNP4
line 455
;455:			}
LABELV $196
line 456
;456:		}
LABELV $189
line 457
;457:		ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
LABELV $197
line 459
;458:		do
;459:		{
line 460
;460:			ent = G_Find(ent, FOFS(classname), classname);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 532
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 461
;461:		} while (ent && (ent->flags & FL_DROPPED_ITEM));
LABELV $198
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $200
ADDRLP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $197
LABELV $200
line 463
;462:		// if we found the destination flag and it's not picked up
;463:		if (ent && !(ent->r.svFlags & SVF_NOCLIENT) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $201
ADDRLP4 0
INDIRP4
CNSTI4 432
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $201
line 465
;464:			// if the player was *very* close
;465:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ASGNP4
ADDRLP4 8
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 466
;466:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 8
ARGP4
ADDRLP4 44
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 1128792064
GEF4 $205
line 467
;467:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 468
;468:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $207
line 469
;469:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 470
;470:				}
LABELV $207
line 471
;471:			}
LABELV $205
line 472
;472:		}
LABELV $201
line 473
;473:	}
LABELV $184
line 474
;474:}
LABELV $183
endproc CheckAlmostCapture 56 12
export CheckAlmostScored
proc CheckAlmostScored 44 12
line 481
;475:
;476:/*
;477:==================
;478:CheckAlmostScored
;479:==================
;480:*/
;481:void CheckAlmostScored( gentity_t *self, gentity_t *attacker ) {
line 487
;482:	gentity_t	*ent;
;483:	vec3_t		dir;
;484:	char		*classname;
;485:
;486:	// if the player was carrying cubes
;487:	if ( self->client->ps.generic1 ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 440
ADDP4
INDIRI4
CNSTI4 0
EQI4 $210
line 488
;488:		if ( self->client->sess.sessionTeam == TEAM_BLUE ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2552
ADDP4
INDIRI4
CNSTI4 2
NEI4 $212
line 489
;489:			classname = "team_redobelisk";
ADDRLP4 16
ADDRGP4 $214
ASGNP4
line 490
;490:		}
ADDRGP4 $213
JUMPV
LABELV $212
line 491
;491:		else {
line 492
;492:			classname = "team_blueobelisk";
ADDRLP4 16
ADDRGP4 $215
ASGNP4
line 493
;493:		}
LABELV $213
line 494
;494:		ent = G_Find(NULL, FOFS(classname), classname);
CNSTP4 0
ARGP4
CNSTI4 532
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 496
;495:		// if we found the destination obelisk
;496:		if ( ent ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $216
line 498
;497:			// if the player was *very* close
;498:			VectorSubtract( self->client->ps.origin, ent->s.origin, dir );
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 92
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 28
INDIRP4
CNSTI4 96
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRF4
SUBF4
ASGNF4
line 499
;499:			if ( VectorLength(dir) < 200 ) {
ADDRLP4 4
ARGP4
ADDRLP4 32
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1128792064
GEF4 $220
line 500
;500:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 501
;501:				if ( attacker->client ) {
ADDRFP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $222
line 502
;502:					attacker->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_HOLYSHIT;
ADDRLP4 40
ADDRFP4 4
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 4
BXORI4
ASGNI4
line 503
;503:				}
LABELV $222
line 504
;504:			}
LABELV $220
line 505
;505:		}
LABELV $216
line 506
;506:	}
LABELV $210
line 507
;507:}
LABELV $209
endproc CheckAlmostScored 44 12
bss
align 4
LABELV $225
skip 4
align 4
LABELV $408
skip 4
export player_die
code
proc player_die 132 28
line 518
;508:
;509:
;510:
;511:/*
;512:==================
;513:player_die
;514:==================
;515:*/
;516:extern int CountSurvivors();
;517:
;518:void player_die( gentity_t *self, gentity_t *inflictor, gentity_t *attacker, int damage, int meansOfDeath ) {
line 531
;519:	gentity_t	*ent;
;520:	int			anim;
;521:	int			contents;
;522:	int			killer;
;523:	int			i;
;524:	char		*killerName, *obit;
;525:	// Shafe - Trep - For Arsenal
;526:	int			tmpW;
;527:	int			tmpCnt;
;528:	static		int deathNum;
;529:	//gentity_t	*xte;
;530:	
;531:	gentity_t	*grenades = NULL; // -Vincent
ADDRLP4 0
CNSTP4 0
ASGNP4
line 535
;532:
;533:
;534:
;535:	if ( self->client->ps.pm_type == PM_DEAD ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 3
NEI4 $226
line 536
;536:		return;
ADDRGP4 $224
JUMPV
LABELV $226
line 539
;537:	}
;538:
;539:	if ( level.intermissiontime ) {
ADDRGP4 level+9140
INDIRI4
CNSTI4 0
EQI4 $228
line 540
;540:		return;
ADDRGP4 $224
JUMPV
LABELV $228
line 544
;541:	}
;542:
;543:
;544:	if ((self->client->ps.eFlags & EF_TALK) && (meansOfDeath != MOD_SUICIDE) && (attacker != &g_entities[ENTITYNUM_WORLD]))
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $231
ADDRFP4 16
INDIRI4
CNSTI4 20
EQI4 $231
ADDRFP4 8
INDIRP4
CVPU4 4
ADDRGP4 g_entities+944328
CVPU4 4
EQU4 $231
line 545
;545:	{
line 546
;546:		attacker->InstaChatFrags++;
ADDRLP4 40
ADDRFP4 8
INDIRP4
CNSTI4 864
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
ADDRLP4 40
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 547
;547:	} 
LABELV $231
line 551
;548:	
;549://unlagged - backward reconciliation #2
;550:	// make sure the body shows up in the client's current position
;551:	G_UnTimeShiftClient( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 G_UnTimeShiftClient
CALLV
pop
line 555
;552://unlagged - backward reconciliation #2
;553:
;554:	// check for an almost capture
;555:	CheckAlmostCapture( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostCapture
CALLV
pop
line 557
;556:	// check for a player that almost brought in cubes
;557:	CheckAlmostScored( self, attacker );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 CheckAlmostScored
CALLV
pop
line 559
;558:
;559:	if (self->client && self->client->hook)
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
ADDRLP4 44
CNSTU4 0
ASGNU4
ADDRLP4 40
INDIRP4
CVPU4 4
ADDRLP4 44
INDIRU4
EQU4 $234
ADDRLP4 40
INDIRP4
CNSTI4 2692
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 44
INDIRU4
EQU4 $234
line 560
;560:		Weapon_HookFree(self->client->hook);
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2692
ADDP4
INDIRP4
ARGP4
ADDRGP4 Weapon_HookFree
CALLV
pop
LABELV $234
line 568
;561:#ifdef MISSIONPACK
;562:	if ((self->client->ps.eFlags & EF_TICKING) && self->activator) {
;563:		self->client->ps.eFlags &= ~EF_TICKING;
;564:		self->activator->think = G_FreeEntity;
;565:		self->activator->nextthink = level.time;
;566:	}
;567:#endif
;568:	self->client->ps.pm_type = PM_DEAD;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 3
ASGNI4
line 571
;569:
;570:	// Shafe - Trep - Clear out the PDG
;571:	self->istelepoint = 0;
ADDRFP4 0
INDIRP4
CNSTI4 840
ADDP4
CNSTI4 0
ASGNI4
line 572
;572:	VectorClear( self->teleloc ); 
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
CNSTF4 0
ASGNF4
ADDRLP4 48
INDIRP4
CNSTI4 836
ADDP4
ADDRLP4 52
INDIRF4
ASGNF4
ADDRLP4 48
INDIRP4
CNSTI4 832
ADDP4
ADDRLP4 52
INDIRF4
ASGNF4
ADDRLP4 48
INDIRP4
CNSTI4 828
ADDP4
ADDRLP4 52
INDIRF4
ASGNF4
ADDRGP4 $237
JUMPV
LABELV $236
line 575
;573:	 
;574:	while ((grenades = G_Find (grenades, FOFS(classname), "pdgrenade")) != NULL)
;575:	{
line 576
;576:		if ( self->client->pdgfired == qtrue )
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2700
ADDP4
INDIRI4
CNSTI4 1
NEI4 $240
line 577
;577:		{ // When a grenade has been fired, let it explode -Vincent
line 578
;578:			if(grenades->r.ownerNum == self->s.clientNum)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
NEI4 $242
line 579
;579:			{ // Confirm owner
line 580
;580:			grenades->nextthink = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 581
;581:			grenades->think = G_ExplodeMissile;
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 G_ExplodeMissile
ASGNP4
line 582
;582:			}
LABELV $242
line 583
;583:		self->client->pdgfired = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2700
ADDP4
CNSTI4 0
ASGNI4
line 584
;584:		}
LABELV $240
line 585
;585:	}
LABELV $237
line 574
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 532
ARGI4
ADDRGP4 $239
ARGP4
ADDRLP4 56
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $236
ADDRGP4 $246
JUMPV
LABELV $245
line 589
;586:
;587:	// Shafe - Trep Clear Out Bombs
;588:	while ((grenades = G_Find (grenades, FOFS(classname), "bomb")) != NULL)
;589:	{
line 590
;590:		if ( self->client->bombfired == qtrue )
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2704
ADDP4
INDIRI4
CNSTI4 1
NEI4 $249
line 591
;591:		{ // When a grenade has been fired, let it explode -Vincent
line 592
;592:			if(grenades->r.ownerNum == self->s.clientNum)
ADDRLP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
NEI4 $251
line 593
;593:			{ // Confirm owner
line 594
;594:			grenades->nextthink = level.time;
ADDRLP4 0
INDIRP4
CNSTI4 704
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 595
;595:			grenades->think = G_ExplodeBomb;
ADDRLP4 0
INDIRP4
CNSTI4 716
ADDP4
ADDRGP4 G_ExplodeBomb
ASGNP4
line 596
;596:			}
LABELV $251
line 597
;597:		self->client->bombfired = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2704
ADDP4
CNSTI4 0
ASGNI4
line 598
;598:		}
LABELV $249
line 599
;599:	}
LABELV $246
line 588
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 532
ARGI4
ADDRGP4 $248
ARGP4
ADDRLP4 60
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $245
line 601
;600:	
;601:	if ( attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $254
line 602
;602:		killer = attacker->s.number;
ADDRLP4 8
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 603
;603:		if ( attacker->client ) {
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $256
line 604
;604:			killerName = attacker->client->pers.netname;
ADDRLP4 24
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ASGNP4
line 605
;605:		} else {
ADDRGP4 $255
JUMPV
LABELV $256
line 606
;606:			killerName = "<non-client>";
ADDRLP4 24
ADDRGP4 $258
ASGNP4
line 607
;607:		}
line 608
;608:	} else {
ADDRGP4 $255
JUMPV
LABELV $254
line 609
;609:		killer = ENTITYNUM_WORLD;
ADDRLP4 8
CNSTI4 1022
ASGNI4
line 610
;610:		killerName = "<world>";
ADDRLP4 24
ADDRGP4 $259
ASGNP4
line 611
;611:	}
LABELV $255
line 613
;612:
;613:	if ( killer < 0 || killer >= MAX_CLIENTS ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $262
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $260
LABELV $262
line 614
;614:		killer = ENTITYNUM_WORLD;
ADDRLP4 8
CNSTI4 1022
ASGNI4
line 615
;615:		killerName = "<world>";
ADDRLP4 24
ADDRGP4 $259
ASGNP4
line 616
;616:	}
LABELV $260
line 618
;617:
;618:	if ( meansOfDeath < 0 || meansOfDeath >= sizeof( modNames ) / sizeof( modNames[0] ) ) {
ADDRLP4 68
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
LTI4 $265
ADDRLP4 68
INDIRI4
CVIU4 4
CNSTU4 26
LTU4 $263
LABELV $265
line 619
;619:		obit = "<bad obituary>";
ADDRLP4 28
ADDRGP4 $266
ASGNP4
line 620
;620:	} else {
ADDRGP4 $264
JUMPV
LABELV $263
line 621
;621:		obit = modNames[ meansOfDeath ];
ADDRLP4 28
ADDRFP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 modNames
ADDP4
INDIRP4
ASGNP4
line 622
;622:	}
LABELV $264
line 624
;623:
;624:	G_LogPrintf("Kill: %i %i %i: %s killed %s by %s\n", 
ADDRGP4 $267
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 G_LogPrintf
CALLV
pop
line 629
;625:		killer, self->s.number, meansOfDeath, killerName, 
;626:		self->client->pers.netname, obit );
;627:
;628:	// broadcast the death event to everyone
;629:	ent = G_TempEntity( self->r.currentOrigin, EV_OBITUARY );
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
ARGP4
CNSTI4 62
ARGI4
ADDRLP4 76
ADDRGP4 G_TempEntity
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 76
INDIRP4
ASGNP4
line 630
;630:	ent->s.eventParm = meansOfDeath;
ADDRLP4 12
INDIRP4
CNSTI4 184
ADDP4
ADDRFP4 16
INDIRI4
ASGNI4
line 631
;631:	ent->s.otherEntityNum = self->s.number;
ADDRLP4 12
INDIRP4
CNSTI4 140
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 632
;632:	ent->s.otherEntityNum2 = killer;
ADDRLP4 12
INDIRP4
CNSTI4 144
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 633
;633:	ent->r.svFlags = SVF_BROADCAST;	// send to everyone
ADDRLP4 12
INDIRP4
CNSTI4 432
ADDP4
CNSTI4 32
ASGNI4
line 635
;634:
;635:	self->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 637
;636:
;637:	self->client->ps.persistant[PERS_KILLED]++;
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 280
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 639
;638:
;639:	if (meansOfDeath != MOD_SUICIDE)
ADDRFP4 16
INDIRI4
CNSTI4 20
EQI4 $268
line 640
;640:	{
line 642
;641:		
;642:		if (attacker->client != self->client) 
ADDRLP4 84
CNSTI4 524
ASGNI4
ADDRFP4 8
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRP4
CVPU4 4
EQU4 $270
line 643
;643:		{
line 645
;644:
;645:			if (self->client->pers.connected == CON_CONNECTED && attacker->client->pers.connected == CON_CONNECTED)
ADDRLP4 88
CNSTI4 524
ASGNI4
ADDRLP4 92
CNSTI4 468
ASGNI4
ADDRLP4 96
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
ADDRLP4 96
INDIRI4
NEI4 $272
ADDRFP4 8
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
ADDRLP4 96
INDIRI4
NEI4 $272
line 646
;646:			{
line 648
;647:
;648:				self->InstaStreak = 0;
ADDRFP4 0
INDIRP4
CNSTI4 848
ADDP4
CNSTI4 0
ASGNI4
line 649
;649:				attacker->InstaStreak++;
ADDRLP4 100
ADDRFP4 8
INDIRP4
CNSTI4 848
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 650
;650:				self->InstaDeaths++;
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 852
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 651
;651:				self->InstaDeathStreak++;
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 856
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 652
;652:				attacker->InstaDeathStreak=0;
ADDRFP4 8
INDIRP4
CNSTI4 856
ADDP4
CNSTI4 0
ASGNI4
line 655
;653:				
;654:				// Calculating The Most Kills Without Dying
;655:				attacker->InstaKillsInRowTemp++;
ADDRLP4 112
ADDRFP4 8
INDIRP4
CNSTI4 880
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 656
;656:				if (self->InstaKillsInRowTemp > self->InstaKillsInRow)
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
ADDRLP4 116
INDIRP4
CNSTI4 876
ADDP4
INDIRI4
LEI4 $274
line 657
;657:				{
line 658
;658:					self->InstaKillsInRow = self->InstaKillsInRowTemp;
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CNSTI4 876
ADDP4
ADDRLP4 120
INDIRP4
CNSTI4 880
ADDP4
INDIRI4
ASGNI4
line 659
;659:				}
LABELV $274
line 660
;660:				self->InstaKillsInRowTemp = 0;
ADDRFP4 0
INDIRP4
CNSTI4 880
ADDP4
CNSTI4 0
ASGNI4
line 664
;661:
;662:
;663:				// Streak Of 7 Gives them a spree msg :)
;664:				if (attacker->InstaStreak == 7)
ADDRFP4 8
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 7
NEI4 $276
line 665
;665:				{
line 666
;666:						trap_SendServerCommand( -1, va( "print \"" S_COLOR_YELLOW "%s ^7IS ON A KILLING SPREE!\n\"", attacker->client->pers.netname ) );
ADDRGP4 $278
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 120
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 120
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 667
;667:						trap_SendServerCommand( -1, va("cp \"^7%s IS ON A KILLING SPREE!!\n\"", attacker->client->pers.netname ) );
ADDRGP4 $279
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 124
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 124
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 669
;668:						//attacker->client->ps.persistant[PERS_SCORE]+=1;
;669:						attacker->InstaMostKillSpree++;
ADDRLP4 128
ADDRFP4 8
INDIRP4
CNSTI4 868
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 670
;670:						attacker->InstaStreak = 0;
ADDRFP4 8
INDIRP4
CNSTI4 848
ADDP4
CNSTI4 0
ASGNI4
line 673
;671:
;672:				
;673:				}
LABELV $276
line 676
;674:
;675:				// 4 Deaths without scoring makes a Dying spree dieing
;676:				if (self->InstaDeathStreak == 4) 
ADDRFP4 0
INDIRP4
CNSTI4 856
ADDP4
INDIRI4
CNSTI4 4
NEI4 $280
line 677
;677:				{
line 678
;678:						trap_SendServerCommand( -1, va( "print \"" S_COLOR_YELLOW "%s ^7IS ON A DYING SPREE!\n\"", self->client->pers.netname ) );
ADDRGP4 $282
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 120
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 120
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 679
;679:						trap_SendServerCommand( -1, va("cp \"^7%s IS ON A DYING SPREE!!\n\"", self->client->pers.netname ) );
ADDRGP4 $283
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 124
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 124
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 680
;680:						self->InstaMostDeathSpree++;
ADDRLP4 128
ADDRFP4 0
INDIRP4
CNSTI4 872
ADDP4
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 681
;681:						self->InstaDeathStreak = 0;
ADDRFP4 0
INDIRP4
CNSTI4 856
ADDP4
CNSTI4 0
ASGNI4
line 683
;682:
;683:				}
LABELV $280
line 686
;684:				
;685:				
;686:			}
LABELV $272
line 687
;687:		}
LABELV $270
line 688
;688:	}
LABELV $268
line 691
;689:
;690:
;691:	if (attacker && attacker->client) {
ADDRLP4 84
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 88
CNSTU4 0
ASGNU4
ADDRLP4 84
INDIRP4
CVPU4 4
ADDRLP4 88
INDIRU4
EQU4 $284
ADDRLP4 84
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 88
INDIRU4
EQU4 $284
line 692
;692:		attacker->client->lastkilled_client = self->s.number;
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2652
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 694
;693:
;694:		if ( attacker == self || OnSameTeam (self, attacker ) ) {
ADDRLP4 92
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 96
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CVPU4 4
ADDRLP4 96
INDIRP4
CVPU4 4
EQU4 $288
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $286
LABELV $288
line 695
;695:			AddScore( attacker, self->r.currentOrigin, -1 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 698
;696:			
;697:
;698:		} else {
ADDRGP4 $285
JUMPV
LABELV $286
line 699
;699:			AddScore( attacker, self->r.currentOrigin, 1 );
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 701
;700:
;701:			if( meansOfDeath == MOD_GAUNTLET ) {
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $289
line 704
;702:				
;703:				// play humiliation on player
;704:				attacker->client->ps.persistant[PERS_GAUNTLET_FRAG_COUNT]++;
ADDRLP4 104
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 300
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 707
;705:
;706:				// add the sprite over the player's head
;707:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 108
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 708
;708:				attacker->client->ps.eFlags |= EF_AWARD_GAUNTLET;
ADDRLP4 112
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 709
;709:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 712
;710:
;711:				// also play humiliation on target
;712:				self->client->ps.persistant[PERS_PLAYEREVENTS] ^= PLAYEREVENT_GAUNTLETREWARD;
ADDRLP4 116
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 268
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI4
CNSTI4 2
BXORI4
ASGNI4
line 713
;713:			}
LABELV $289
line 717
;714:
;715:			// check for two kills in a short amount of time
;716:			// if this is close enough to the last kill, give a reward sound
;717:			if ( level.time - attacker->client->lastKillTime < CARNAGE_REWARD_TIME ) {
ADDRGP4 level+32
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2684
ADDP4
INDIRI4
SUBI4
CNSTI4 3000
GEI4 $292
line 719
;718:				// play excellent on player
;719:				attacker->client->ps.persistant[PERS_EXCELLENT_COUNT]++;
ADDRLP4 104
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 288
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 722
;720:
;721:				// add the sprite over the player's head
;722:				attacker->client->ps.eFlags &= ~(EF_AWARD_IMPRESSIVE | EF_AWARD_EXCELLENT | EF_AWARD_GAUNTLET | EF_AWARD_ASSIST | EF_AWARD_DEFEND | EF_AWARD_CAP );
ADDRLP4 108
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI4
CNSTI4 -231497
BANDI4
ASGNI4
line 723
;723:				attacker->client->ps.eFlags |= EF_AWARD_EXCELLENT;
ADDRLP4 112
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 104
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
line 724
;724:				attacker->client->rewardTime = level.time + REWARD_SPRITE_TIME;
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 725
;725:			}
LABELV $292
line 726
;726:			attacker->client->lastKillTime = level.time;
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2684
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 728
;727:
;728:		}
line 729
;729:	} else {
ADDRGP4 $285
JUMPV
LABELV $284
line 730
;730:		AddScore( self, self->r.currentOrigin, -1 );
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
CNSTI4 496
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRGP4 AddScore
CALLV
pop
line 731
;731:	}
LABELV $285
line 734
;732:
;733:	// Add team bonuses
;734:	Team_FragBonuses(self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_FragBonuses
CALLV
pop
line 737
;735:
;736:	// if I committed suicide, the flag does not fall, it returns.
;737:	if (meansOfDeath == MOD_SUICIDE) {
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $297
line 738
;738:		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $299
line 739
;739:			Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 740
;740:			self->client->ps.powerups[PW_NEUTRALFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 348
ADDP4
CNSTI4 0
ASGNI4
line 741
;741:		}
ADDRGP4 $300
JUMPV
LABELV $299
line 742
;742:		else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $301
line 743
;743:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 744
;744:			self->client->ps.powerups[PW_REDFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 340
ADDP4
CNSTI4 0
ASGNI4
line 745
;745:		}
ADDRGP4 $302
JUMPV
LABELV $301
line 746
;746:		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $303
line 747
;747:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 748
;748:			self->client->ps.powerups[PW_BLUEFLAG] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 344
ADDP4
CNSTI4 0
ASGNI4
line 749
;749:		}
LABELV $303
LABELV $302
LABELV $300
line 750
;750:	}
LABELV $297
line 753
;751:
;752:	// if client is in a nodrop area, don't drop anything (but return CTF flags!)
;753:	contents = trap_PointContents( self->r.currentOrigin, -1 );
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 92
ADDRGP4 trap_PointContents
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 92
INDIRI4
ASGNI4
line 754
;754:	if ( !( contents & CONTENTS_NODROP )) {
ADDRLP4 16
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $305
line 755
;755:		TossClientItems( self );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 TossClientItems
CALLV
pop
line 756
;756:	}
ADDRGP4 $306
JUMPV
LABELV $305
line 757
;757:	else {
line 758
;758:		if ( self->client->ps.powerups[PW_NEUTRALFLAG] ) {		// only happens in One Flag CTF
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 348
ADDP4
INDIRI4
CNSTI4 0
EQI4 $307
line 759
;759:			Team_ReturnFlag( TEAM_FREE );
CNSTI4 0
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 760
;760:		}
ADDRGP4 $308
JUMPV
LABELV $307
line 761
;761:		else if ( self->client->ps.powerups[PW_REDFLAG] ) {		// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 340
ADDP4
INDIRI4
CNSTI4 0
EQI4 $309
line 762
;762:			Team_ReturnFlag( TEAM_RED );
CNSTI4 1
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 763
;763:		}
ADDRGP4 $310
JUMPV
LABELV $309
line 764
;764:		else if ( self->client->ps.powerups[PW_BLUEFLAG] ) {	// only happens in standard CTF
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 344
ADDP4
INDIRI4
CNSTI4 0
EQI4 $311
line 765
;765:			Team_ReturnFlag( TEAM_BLUE );
CNSTI4 2
ARGI4
ADDRGP4 Team_ReturnFlag
CALLV
pop
line 766
;766:		}
LABELV $311
LABELV $310
LABELV $308
line 767
;767:	}
LABELV $306
line 776
;768:#ifdef MISSIONPACK
;769:	TossClientPersistantPowerups( self );
;770:	if( g_gametype.integer == GT_HARVESTER ) {
;771:		TossClientCubes( self );
;772:	}
;773:#endif
;774:
;775:	
;776:	if ((level.firstStrike == qfalse) && (!level.warmupTime))
ADDRLP4 96
CNSTI4 0
ASGNI4
ADDRGP4 level+9236
INDIRI4
ADDRLP4 96
INDIRI4
NEI4 $313
ADDRGP4 level+16
INDIRI4
ADDRLP4 96
INDIRI4
NEI4 $313
line 777
;777:	{
line 778
;778:		if (self != attacker)
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
EQU4 $317
line 779
;779:		{
line 780
;780:			level.firstStrike = qtrue;
ADDRGP4 level+9236
CNSTI4 1
ASGNI4
line 781
;781:			BroadCastSound("sound/misc/laff02.ogg");
ADDRGP4 $320
ARGP4
ADDRGP4 BroadCastSound
CALLV
pop
line 782
;782:			trap_SendServerCommand( -1, va("print \"%s Made First Strike!\n\"",attacker->client->pers.netname));
ADDRGP4 $321
ARGP4
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 100
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 100
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 783
;783:		}
LABELV $317
line 784
;784:	}
LABELV $313
line 786
;785:
;786:	if (level.warmupTime != 0)
ADDRGP4 level+16
INDIRI4
CNSTI4 0
EQI4 $322
line 787
;787:	{
line 788
;788:		level.firstStrike = qfalse;
ADDRGP4 level+9236
CNSTI4 0
ASGNI4
line 790
;789:		//trap_SendServerCommand( -1, va("print \"%s FS Is FALSE!!\n\"",attacker->client->pers.netname));	
;790:	} 
LABELV $322
line 794
;791:		
;792:	
;793:		// Shafe - Trep - Arsenal Stuff
;794:		if ( g_GameMode.integer > 0 && meansOfDeath != MOD_TELEFRAG && !level.warmupTime) 
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRGP4 g_GameMode+12
INDIRI4
ADDRLP4 100
INDIRI4
LEI4 $326
ADDRFP4 16
INDIRI4
CNSTI4 18
EQI4 $326
ADDRGP4 level+16
INDIRI4
ADDRLP4 100
INDIRI4
NEI4 $326
line 795
;795:		{
line 796
;796:			tmpW = self->s.weapon;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
line 798
;797:
;798:			if (g_GameMode.integer == 1)
ADDRGP4 g_GameMode+12
INDIRI4
CNSTI4 1
NEI4 $330
line 799
;799:			{
line 800
;800:				if (tmpW == 9) { self->client->pers.h_bfg = qfalse;  }
ADDRLP4 20
INDIRI4
CNSTI4 9
NEI4 $333
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2480
ADDP4
CNSTI4 0
ASGNI4
LABELV $333
line 801
;801:				if (tmpW == 8) { self->client->pers.h_plasma = qfalse;}
ADDRLP4 20
INDIRI4
CNSTI4 8
NEI4 $335
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2476
ADDP4
CNSTI4 0
ASGNI4
LABELV $335
line 802
;802:				if (tmpW == 7) { self->client->pers.h_gauss = qfalse; }
ADDRLP4 20
INDIRI4
CNSTI4 7
NEI4 $337
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2472
ADDP4
CNSTI4 0
ASGNI4
LABELV $337
line 803
;803:				if (tmpW == 6) { self->client->pers.h_flame = qfalse; }
ADDRLP4 20
INDIRI4
CNSTI4 6
NEI4 $339
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2468
ADDP4
CNSTI4 0
ASGNI4
LABELV $339
line 804
;804:				if (tmpW == 5) { self->client->pers.h_singcan = qfalse; }
ADDRLP4 20
INDIRI4
CNSTI4 5
NEI4 $341
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2464
ADDP4
CNSTI4 0
ASGNI4
LABELV $341
line 805
;805:				if (tmpW == 4) { self->client->pers.h_grenade = qfalse; }
ADDRLP4 20
INDIRI4
CNSTI4 4
NEI4 $343
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2460
ADDP4
CNSTI4 0
ASGNI4
LABELV $343
line 806
;806:				if (tmpW == 3) { self->client->pers.h_sg = qfalse; }
ADDRLP4 20
INDIRI4
CNSTI4 3
NEI4 $345
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2456
ADDP4
CNSTI4 0
ASGNI4
LABELV $345
line 807
;807:				if (tmpW == 2) { self->client->pers.h_mg = qfalse; }
ADDRLP4 20
INDIRI4
CNSTI4 2
NEI4 $347
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2452
ADDP4
CNSTI4 0
ASGNI4
LABELV $347
line 808
;808:				if (tmpW == 1) { self->client->pers.h_gauntlet = qfalse; }
ADDRLP4 20
INDIRI4
CNSTI4 1
NEI4 $349
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2448
ADDP4
CNSTI4 0
ASGNI4
LABELV $349
line 810
;809:
;810:			}
LABELV $330
line 813
;811:			
;812:			
;813:			if ((g_GameMode.integer == 2) || (IsOutOfWeapons(self)))
ADDRGP4 g_GameMode+12
INDIRI4
CNSTI4 2
EQI4 $354
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 IsOutOfWeapons
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $351
LABELV $354
line 814
;814:			{
line 817
;815:				
;816:				// Arsenal Message
;817:				if (g_GameMode.integer == 1)
ADDRGP4 g_GameMode+12
INDIRI4
CNSTI4 1
NEI4 $355
line 818
;818:				{
line 819
;819:					trap_SendServerCommand( -1, va("print \"%s's Arsenal Is Empty!\n\"",self->client->pers.netname));
ADDRGP4 $358
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 108
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 820
;820:					trap_SendServerCommand( -1, va("cp \"%.15s" S_COLOR_WHITE "'s Arsenal is Empty.\n\"", self->client->pers.netname) );
ADDRGP4 $359
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 821
;821:				}
LABELV $355
line 824
;822:
;823:				// LMS Message
;824:				if (g_GameMode.integer == 2)
ADDRGP4 g_GameMode+12
INDIRI4
CNSTI4 2
NEI4 $360
line 825
;825:				{
line 826
;826:					trap_SendServerCommand( -1, va("print \"%s Has Been Eliminated!!\n\"",self->client->pers.netname));
ADDRGP4 $363
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 108
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 108
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 827
;827:					trap_SendServerCommand( -1, va("cp \"%.15s" S_COLOR_WHITE " Has Been Eliminated.\n\"", self->client->pers.netname) );
ADDRGP4 $364
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 512
ADDP4
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 -1
ARGI4
ADDRLP4 112
INDIRP4
ARGP4
ADDRGP4 trap_SendServerCommand
CALLV
pop
line 828
;828:				}
LABELV $360
line 831
;829:				
;830:				// Send them to Spec
;831:				self->client->pers.TrueScore = self->client->ps.persistant[PERS_SCORE];
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
ADDRLP4 108
INDIRP4
CNSTI4 2488
ADDP4
ADDRLP4 108
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
ASGNI4
line 832
;832:				self->client->pers.Eliminated = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2484
ADDP4
CNSTI4 1
ASGNI4
line 833
;833:				SetTeam(self, "s");
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $365
ARGP4
ADDRGP4 SetTeam
CALLV
pop
line 835
;834:				// Set The Last Attacker In Case The Winner Blows Themself up on the winning shot
;835:				level.lastClient = attacker->client;
ADDRGP4 level+9244
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
line 837
;836:
;837:				tmpCnt = (CountSurvivors());
ADDRLP4 112
ADDRGP4 CountSurvivors
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 112
INDIRI4
ASGNI4
line 840
;838:
;839:						
;840:				if (tmpCnt != level.levelSurvivors)
ADDRLP4 32
INDIRI4
ADDRGP4 level+9228
INDIRI4
EQI4 $367
line 841
;841:				{
line 843
;842:
;843:					level.levelSurvivors = tmpCnt;
ADDRGP4 level+9228
ADDRLP4 32
INDIRI4
ASGNI4
line 846
;844:			
;845:			
;846:					if (tmpCnt == 5) 
ADDRLP4 32
INDIRI4
CNSTI4 5
NEI4 $371
line 847
;847:					{
line 848
;848:						BroadCastSound("sound/misc/5.ogg");
ADDRGP4 $373
ARGP4
ADDRGP4 BroadCastSound
CALLV
pop
line 849
;849:					}
LABELV $371
line 851
;850:					
;851:					if (tmpCnt == 4) 
ADDRLP4 32
INDIRI4
CNSTI4 4
NEI4 $374
line 852
;852:					{
line 853
;853:						BroadCastSound("sound/misc/4.ogg");
ADDRGP4 $376
ARGP4
ADDRGP4 BroadCastSound
CALLV
pop
line 854
;854:					}
LABELV $374
line 856
;855:
;856:					if (tmpCnt == 3) 
ADDRLP4 32
INDIRI4
CNSTI4 3
NEI4 $377
line 857
;857:					{
line 858
;858:						BroadCastSound("sound/misc/3.ogg");
ADDRGP4 $379
ARGP4
ADDRGP4 BroadCastSound
CALLV
pop
line 859
;859:					}
LABELV $377
line 861
;860:
;861:					if (tmpCnt == 2) 
ADDRLP4 32
INDIRI4
CNSTI4 2
NEI4 $380
line 862
;862:					{
line 864
;863:						
;864:						BroadCastSound("sound/misc/2.ogg");
ADDRGP4 $382
ARGP4
ADDRGP4 BroadCastSound
CALLV
pop
line 865
;865:					}
LABELV $380
line 867
;866:
;867:					if (tmpCnt == 1) 
ADDRLP4 32
INDIRI4
CNSTI4 1
NEI4 $383
line 868
;868:					{
line 869
;869:						BroadCastSound("sound/misc/laff01.ogg");
ADDRGP4 $385
ARGP4
ADDRGP4 BroadCastSound
CALLV
pop
line 871
;870:
;871:					}
LABELV $383
line 873
;872:				
;873:				}
LABELV $367
line 874
;874:			} 
LABELV $351
line 876
;875:
;876:		}
LABELV $326
line 879
;877:		// End Arsenal Stuff
;878:
;879:	Cmd_Score_f( self );		// show scores
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 882
;880:	// send updated scores to any clients that are following this one,
;881:	// or they would get stale scoreboards
;882:	for ( i = 0 ; i < level.maxclients ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $389
JUMPV
LABELV $386
line 885
;883:		gclient_t	*client;
;884:
;885:		client = &level.clients[i];
ADDRLP4 104
CNSTI4 3476
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
line 886
;886:		if ( client->pers.connected != CON_CONNECTED ) {
ADDRLP4 104
INDIRP4
CNSTI4 468
ADDP4
INDIRI4
CNSTI4 2
EQI4 $391
line 887
;887:			continue;
ADDRGP4 $387
JUMPV
LABELV $391
line 889
;888:		}
;889:		if ( client->sess.sessionTeam != TEAM_SPECTATOR ) {
ADDRLP4 104
INDIRP4
CNSTI4 2552
ADDP4
INDIRI4
CNSTI4 3
EQI4 $393
line 890
;890:			continue;
ADDRGP4 $387
JUMPV
LABELV $393
line 892
;891:		}
;892:		if ( client->sess.spectatorClient == self->s.number ) {
ADDRLP4 104
INDIRP4
CNSTI4 2564
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $395
line 893
;893:			Cmd_Score_f( g_entities + i );
CNSTI4 924
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 Cmd_Score_f
CALLV
pop
line 894
;894:		}
LABELV $395
line 895
;895:	}
LABELV $387
line 882
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $389
ADDRLP4 4
INDIRI4
ADDRGP4 level+24
INDIRI4
LTI4 $386
line 897
;896:
;897:	self->takedamage = qtrue;	// can still be gibbed
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
CNSTI4 1
ASGNI4
line 899
;898:
;899:	self->s.weapon = WP_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 192
ADDP4
CNSTI4 0
ASGNI4
line 900
;900:	self->s.powerups = 0;
ADDRFP4 0
INDIRP4
CNSTI4 188
ADDP4
CNSTI4 0
ASGNI4
line 901
;901:	self->r.contents = CONTENTS_CORPSE;
ADDRFP4 0
INDIRP4
CNSTI4 468
ADDP4
CNSTI4 67108864
ASGNI4
line 903
;902:
;903:	self->s.angles[0] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 116
ADDP4
CNSTF4 0
ASGNF4
line 904
;904:	self->s.angles[2] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 124
ADDP4
CNSTF4 0
ASGNF4
line 905
;905:	LookAtKiller (self, inflictor, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 LookAtKiller
CALLV
pop
line 907
;906:
;907:	VectorCopy( self->s.angles, self->client->ps.viewangles );
ADDRLP4 104
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 152
ADDP4
ADDRLP4 104
INDIRP4
CNSTI4 116
ADDP4
INDIRB
ASGNB 12
line 909
;908:
;909:	self->s.loopSound = 0;
ADDRFP4 0
INDIRP4
CNSTI4 156
ADDP4
CNSTI4 0
ASGNI4
line 911
;910:
;911:	self->r.maxs[2] = -8;
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
CNSTF4 3238002688
ASGNF4
line 915
;912:
;913:	// don't allow respawn until the death anim is done
;914:	// g_forcerespawn may force spawning at some later time
;915:	self->client->respawnTime = level.time + 1700;  // This is the real line
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2664
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1700
ADDI4
ASGNI4
line 920
;916:	
;917:
;918:
;919:	// remove powerups
;920:	memset( self->client->ps.powerups, 0, sizeof(self->client->ps.powerups) );
ADDRFP4 0
INDIRP4
CNSTI4 524
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
line 922
;921:
;922:	if (meansOfDeath == MOD_HEADSHOT)
ADDRFP4 16
INDIRI4
CNSTI4 23
NEI4 $398
line 923
;923:	{
line 924
;924:			BroadCastSound("sound/misc/headshot.ogg");
ADDRGP4 $400
ARGP4
ADDRGP4 BroadCastSound
CALLV
pop
line 925
;925:	}
LABELV $398
line 930
;926:
;927:
;928:
;929:	// never gib in a nodrop
;930:	if ( (self->health <= GIB_HEALTH && !(contents & CONTENTS_NODROP) && g_blood.integer && meansOfDeath != MOD_HEADSHOT) || meansOfDeath == MOD_SUICIDE) {
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $407
ADDRLP4 16
INDIRI4
CVIU4 4
CNSTU4 2147483648
BANDU4
CNSTU4 0
NEU4 $407
ADDRGP4 g_blood+12
INDIRI4
CNSTI4 0
EQI4 $407
ADDRFP4 16
INDIRI4
CNSTI4 23
NEI4 $404
LABELV $407
ADDRFP4 16
INDIRI4
CNSTI4 20
NEI4 $401
LABELV $404
line 932
;931:		// gib death
;932:		GibEntity( self, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 GibEntity
CALLV
pop
line 933
;933:	} else {
ADDRGP4 $402
JUMPV
LABELV $401
line 937
;934:		// normal death
;935:		static int i;
;936:
;937:		switch ( i ) {
ADDRLP4 108
ADDRGP4 $408
INDIRI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $411
ADDRLP4 108
INDIRI4
CNSTI4 1
EQI4 $412
ADDRLP4 108
INDIRI4
CNSTI4 2
EQI4 $413
ADDRGP4 $409
JUMPV
LABELV $411
line 939
;938:		case 0:
;939:			anim = BOTH_DEATH1;
ADDRLP4 36
CNSTI4 0
ASGNI4
line 940
;940:			break;
ADDRGP4 $410
JUMPV
LABELV $412
line 942
;941:		case 1:
;942:			anim = BOTH_DEATH2;
ADDRLP4 36
CNSTI4 2
ASGNI4
line 943
;943:			break;
ADDRGP4 $410
JUMPV
LABELV $413
LABELV $409
line 946
;944:		case 2:
;945:		default:
;946:			anim = BOTH_DEATH3;
ADDRLP4 36
CNSTI4 4
ASGNI4
line 947
;947:			break;
LABELV $410
line 952
;948:		}
;949:
;950:		// for the no-blood option, we need to prevent the health
;951:		// from going to gib level
;952:		if ( self->health <= GIB_HEALTH ) {
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 -40
GTI4 $414
line 953
;953:			self->health = GIB_HEALTH+1;
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 -39
ASGNI4
line 954
;954:		}
LABELV $414
line 956
;955:
;956:		self->client->ps.legsAnim = 
ADDRLP4 112
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 76
ADDP4
ASGNP4
ADDRLP4 116
CNSTI4 128
ASGNI4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI4
ADDRLP4 116
INDIRI4
BANDI4
ADDRLP4 116
INDIRI4
BXORI4
ADDRLP4 36
INDIRI4
BORI4
ASGNI4
line 958
;957:			( ( self->client->ps.legsAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;958:		self->client->ps.torsoAnim = 
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 84
ADDP4
ASGNP4
ADDRLP4 124
CNSTI4 128
ASGNI4
ADDRLP4 120
INDIRP4
ADDRLP4 120
INDIRP4
INDIRI4
ADDRLP4 124
INDIRI4
BANDI4
ADDRLP4 124
INDIRI4
BXORI4
ADDRLP4 36
INDIRI4
BORI4
ASGNI4
line 961
;959:			( ( self->client->ps.torsoAnim & ANIM_TOGGLEBIT ) ^ ANIM_TOGGLEBIT ) | anim;
;960:
;961:		G_AddEvent( self, EV_DEATH1 + i, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $408
INDIRI4
CNSTI4 59
ADDI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 964
;962:
;963:		// Shafe - Trep Headshot //////////////////////////////////////////
;964:		if(meansOfDeath == MOD_HEADSHOT)
ADDRFP4 16
INDIRI4
CNSTI4 23
NEI4 $416
line 965
;965:			GibEntity_Headshot( self, killer );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 GibEntity_Headshot
CALLV
pop
ADDRGP4 $417
JUMPV
LABELV $416
line 967
;966:		else
;967:			self->client->noHead = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2716
ADDP4
CNSTI4 0
ASGNI4
LABELV $417
line 971
;968:		// Shafe - Trep - End Headshot /////////////////////////////
;969:
;970:		// the body can still be gibbed
;971:		self->die = body_die;
ADDRFP4 0
INDIRP4
CNSTI4 740
ADDP4
ADDRGP4 body_die
ASGNP4
line 974
;972:
;973:		// globally cycle through the different death animations
;974:		i = ( i + 1 ) % 3;
ADDRLP4 128
ADDRGP4 $408
ASGNP4
ADDRLP4 128
INDIRP4
ADDRLP4 128
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
CNSTI4 3
MODI4
ASGNI4
line 983
;975:
;976:
;977:
;978:#ifdef MISSIONPACK
;979:		if (self->s.eFlags & EF_KAMIKAZE) {
;980:			Kamikaze_DeathTimer( self );
;981:		}
;982:#endif
;983:	}
LABELV $402
line 988
;984:
;985:	
;986:
;987:
;988:	trap_LinkEntity (self);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 trap_LinkEntity
CALLV
pop
line 990
;989:
;990:}
LABELV $224
endproc player_die 132 28
export CheckArmor
proc CheckArmor 20 4
line 999
;991:
;992:
;993:/*
;994:================
;995:CheckArmor
;996:================
;997:*/
;998:int CheckArmor (gentity_t *ent, int damage, int dflags)
;999:{
line 1004
;1000:	gclient_t	*client;
;1001:	int			save;
;1002:	int			count;
;1003:
;1004:	if (!damage)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $419
line 1005
;1005:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $418
JUMPV
LABELV $419
line 1007
;1006:
;1007:	client = ent->client;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
line 1009
;1008:
;1009:	if (!client)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $421
line 1010
;1010:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $418
JUMPV
LABELV $421
line 1012
;1011:
;1012:	if (dflags & DAMAGE_NO_ARMOR)
ADDRFP4 8
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $423
line 1013
;1013:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $418
JUMPV
LABELV $423
line 1016
;1014:
;1015:	// armor
;1016:	count = client->ps.stats[STAT_ARMOR];
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 1017
;1017:	save = ceil( damage * ARMOR_PROTECTION );
CNSTF4 1059648963
ADDRFP4 4
INDIRI4
CVIF4 4
MULF4
ARGF4
ADDRLP4 12
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 1018
;1018:	if (save >= count)
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $425
line 1019
;1019:		save = count;
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
LABELV $425
line 1021
;1020:
;1021:	if (!save)
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $427
line 1022
;1022:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $418
JUMPV
LABELV $427
line 1024
;1023:
;1024:	client->ps.stats[STAT_ARMOR] -= save;
ADDRLP4 16
ADDRLP4 4
INDIRP4
CNSTI4 196
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 1026
;1025:
;1026:	return save;
ADDRLP4 0
INDIRI4
RETI4
LABELV $418
endproc CheckArmor 20 4
export RaySphereIntersections
proc RaySphereIntersections 96 4
line 1034
;1027:}
;1028:
;1029:/*
;1030:================
;1031:RaySphereIntersections
;1032:================
;1033:*/
;1034:int RaySphereIntersections( vec3_t origin, float radius, vec3_t point, vec3_t dir, vec3_t intersections[2] ) {
line 1043
;1035:	float b, c, d, t;
;1036:
;1037:	//	| origin - (point + t * dir) | = radius
;1038:	//	a = dir[0]^2 + dir[1]^2 + dir[2]^2;
;1039:	//	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
;1040:	//	c = (point[0] - origin[0])^2 + (point[1] - origin[1])^2 + (point[2] - origin[2])^2 - radius^2;
;1041:
;1042:	// normalize dir so a = 1
;1043:	VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1044
;1044:	b = 2 * (dir[0] * (point[0] - origin[0]) + dir[1] * (point[1] - origin[1]) + dir[2] * (point[2] - origin[2]));
ADDRLP4 16
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 20
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
CNSTI4 4
ASGNI4
ADDRLP4 32
CNSTI4 8
ASGNI4
ADDRLP4 4
CNSTF4 1073741824
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 20
INDIRP4
INDIRF4
ADDRLP4 24
INDIRP4
INDIRF4
SUBF4
MULF4
ADDRLP4 16
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
ADDRLP4 16
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
INDIRF4
SUBF4
MULF4
ADDF4
MULF4
ASGNF4
line 1045
;1045:	c = (point[0] - origin[0]) * (point[0] - origin[0]) +
ADDRLP4 36
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
ADDRLP4 36
INDIRP4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48
CNSTI4 4
ASGNI4
ADDRLP4 52
ADDRLP4 36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 56
CNSTI4 8
ASGNI4
ADDRLP4 60
ADDRLP4 36
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
ADDRFP4 4
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 44
INDIRF4
ADDRLP4 44
INDIRF4
MULF4
ADDRLP4 52
INDIRF4
ADDRLP4 52
INDIRF4
MULF4
ADDF4
ADDRLP4 60
INDIRF4
ADDRLP4 60
INDIRF4
MULF4
ADDF4
ADDRLP4 64
INDIRF4
ADDRLP4 64
INDIRF4
MULF4
SUBF4
ASGNF4
line 1050
;1046:		(point[1] - origin[1]) * (point[1] - origin[1]) +
;1047:		(point[2] - origin[2]) * (point[2] - origin[2]) -
;1048:		radius * radius;
;1049:
;1050:	d = b * b - 4 * c;
ADDRLP4 8
ADDRLP4 4
INDIRF4
ADDRLP4 4
INDIRF4
MULF4
CNSTF4 1082130432
ADDRLP4 12
INDIRF4
MULF4
SUBF4
ASGNF4
line 1051
;1051:	if (d > 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $430
line 1052
;1052:		t = (- b + sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 72
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 72
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 1053
;1053:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 80
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 1054
;1054:		t = (- b - sqrt(d)) / 2;
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 84
ADDRGP4 sqrt
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
ADDRLP4 84
INDIRF4
SUBF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 1055
;1055:		VectorMA(point, t, dir, intersections[1]);
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 88
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
CNSTI4 16
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 88
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 92
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 1056
;1056:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $429
JUMPV
LABELV $430
line 1058
;1057:	}
;1058:	else if (d == 0) {
ADDRLP4 8
INDIRF4
CNSTF4 0
NEF4 $432
line 1059
;1059:		t = (- b ) / 2;
ADDRLP4 0
ADDRLP4 4
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 1060
;1060:		VectorMA(point, t, dir, intersections[0]);
ADDRFP4 16
INDIRP4
ADDRFP4 8
INDIRP4
INDIRF4
ADDRFP4 12
INDIRP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 72
CNSTI4 4
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 76
CNSTI4 8
ASGNI4
ADDRFP4 16
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
ADDRFP4 8
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRFP4 12
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 1061
;1061:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $429
JUMPV
LABELV $432
line 1063
;1062:	}
;1063:	return 0;
CNSTI4 0
RETI4
LABELV $429
endproc RaySphereIntersections 96 4
export G_Damage
proc G_Damage 96 24
line 1130
;1064:}
;1065:
;1066:#ifdef MISSIONPACK
;1067:/*
;1068:================
;1069:G_InvulnerabilityEffect
;1070:================
;1071:*/
;1072:int G_InvulnerabilityEffect( gentity_t *targ, vec3_t dir, vec3_t point, vec3_t impactpoint, vec3_t bouncedir ) {
;1073:	gentity_t	*impact;
;1074:	vec3_t		intersections[2], vec;
;1075:	int			n;
;1076:
;1077:	if ( !targ->client ) {
;1078:		return qfalse;
;1079:	}
;1080:	VectorCopy(dir, vec);
;1081:	VectorInverse(vec);
;1082:	// sphere model radius = 42 units
;1083:	n = RaySphereIntersections( targ->client->ps.origin, 42, point, vec, intersections);
;1084:	if (n > 0) {
;1085:		impact = G_TempEntity( targ->client->ps.origin, EV_INVUL_IMPACT );
;1086:		VectorSubtract(intersections[0], targ->client->ps.origin, vec);
;1087:		vectoangles(vec, impact->s.angles);
;1088:		impact->s.angles[0] += 90;
;1089:		if (impact->s.angles[0] > 360)
;1090:			impact->s.angles[0] -= 360;
;1091:		if ( impactpoint ) {
;1092:			VectorCopy( intersections[0], impactpoint );
;1093:		}
;1094:		if ( bouncedir ) {
;1095:			VectorCopy( vec, bouncedir );
;1096:			VectorNormalize( bouncedir );
;1097:		}
;1098:		return qtrue;
;1099:	}
;1100:	else {
;1101:		return qfalse;
;1102:	}
;1103:}
;1104:#endif
;1105:/*
;1106:============
;1107:T_Damage
;1108:
;1109:targ		entity that is being damaged
;1110:inflictor	entity that is causing the damage
;1111:attacker	entity that caused the inflictor to damage targ
;1112:	example: targ=monster, inflictor=rocket, attacker=player
;1113:
;1114:dir			direction of the attack for knockback
;1115:point		point at which the damage is being inflicted, used for headshots
;1116:damage		amount of damage being inflicted
;1117:knockback	force to be applied against targ as a result of the damage
;1118:
;1119:inflictor, attacker, dir, and point can be NULL for environmental effects
;1120:
;1121:dflags		these flags are used to control how T_Damage works
;1122:	DAMAGE_RADIUS			damage was indirect (from a nearby explosion)
;1123:	DAMAGE_NO_ARMOR			armor does not protect from this damage
;1124:	DAMAGE_NO_KNOCKBACK		do not affect velocity, just view angles
;1125:	DAMAGE_NO_PROTECTION	kills godmode, armor, everything
;1126:============
;1127:*/
;1128:
;1129:void G_Damage( gentity_t *targ, gentity_t *inflictor, gentity_t *attacker,
;1130:			   vec3_t dir, vec3_t point, int damage, int dflags, int mod ) {
line 1148
;1131:	gclient_t	*client;
;1132:	int			take;
;1133:	int			save;
;1134:	int			asave;
;1135:	int			knockback;
;1136:	int			max;
;1137:	// Shafe - Trep - Headshot
;1138:	float		z_ratio;
;1139:	float		z_rel;
;1140:	int			height;
;1141:	float		targ_maxs2;
;1142:	// Shafe - Trep - End Headshot
;1143:
;1144:#ifdef MISSIONPACK
;1145:	vec3_t		bouncedir, impactpoint;
;1146:#endif
;1147:
;1148:	if (!targ->takedamage) {
ADDRFP4 0
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
NEI4 $435
line 1149
;1149:		return;
ADDRGP4 $434
JUMPV
LABELV $435
line 1154
;1150:	}
;1151:
;1152:	// the intermission has allready been qualified for, so don't
;1153:	// allow any extra scoring
;1154:	if ( level.intermissionQueued ) {
ADDRGP4 level+9136
INDIRI4
CNSTI4 0
EQI4 $437
line 1155
;1155:		return;
ADDRGP4 $434
JUMPV
LABELV $437
line 1159
;1156:	}
;1157:
;1158:	// Grapple hook cannot be used to damage a buildable
;1159:	if (targ->s.eType ==ET_BUILDABLE && mod == MOD_GRAPPLE && g_GrappleMode.integer == 1)
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
NEI4 $440
ADDRFP4 28
INDIRI4
CNSTI4 25
NEI4 $440
ADDRGP4 g_GrappleMode+12
INDIRI4
CNSTI4 1
NEI4 $440
line 1160
;1160:	{
line 1161
;1161:		return;
ADDRGP4 $434
JUMPV
LABELV $440
line 1177
;1162:	}
;1163:
;1164:
;1165:	
;1166:
;1167:#ifdef MISSIONPACK
;1168:	if ( targ->client && mod != MOD_JUICED) {
;1169:		if ( targ->client->invulnerabilityTime > level.time) {
;1170:			if ( dir && point ) {
;1171:				G_InvulnerabilityEffect( targ, dir, point, impactpoint, bouncedir );
;1172:			}
;1173:			return;
;1174:		}
;1175:	}
;1176:#endif
;1177:	if ( !inflictor ) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $443
line 1178
;1178:		inflictor = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 4
ADDRGP4 g_entities+944328
ASGNP4
line 1179
;1179:	}
LABELV $443
line 1180
;1180:	if ( !attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $446
line 1181
;1181:		attacker = &g_entities[ENTITYNUM_WORLD];
ADDRFP4 8
ADDRGP4 g_entities+944328
ASGNP4
line 1182
;1182:	}
LABELV $446
line 1187
;1183:
;1184:	
;1185:
;1186:	// shootable doors / buttons don't actually have any health
;1187:	if ( targ->s.eType == ET_MOVER ) {
ADDRLP4 40
CNSTI4 4
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
NEI4 $449
line 1188
;1188:		if ( targ->use && targ->moverState == MOVER_POS1 || targ->moverState == ROTATOR_POS1) {
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 732
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $454
ADDRLP4 44
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
CNSTI4 0
EQI4 $453
LABELV $454
ADDRFP4 0
INDIRP4
CNSTI4 584
ADDP4
INDIRI4
CNSTI4 4
NEI4 $434
LABELV $453
line 1189
;1189:			targ->use( targ, inflictor, attacker );
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
CNSTI4 732
ADDP4
INDIRP4
CALLV
pop
line 1190
;1190:		}
line 1191
;1191:		return;
ADDRGP4 $434
JUMPV
LABELV $449
line 1195
;1192:	}
;1193:
;1194:	// If we shot a breakable item subtract the damage from its health and try to break it
;1195: 	if ( targ->s.eType == ET_BREAKABLE ) {
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 15
NEI4 $455
line 1196
;1196:         targ->health -= damage;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
ADDRFP4 20
INDIRI4
SUBI4
ASGNI4
line 1197
;1197: 		G_BreakGlass( targ, point, mod );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 28
INDIRI4
ARGI4
ADDRGP4 G_BreakGlass
CALLV
pop
line 1198
;1198: 		return;
ADDRGP4 $434
JUMPV
LABELV $455
line 1207
;1199: 	}
;1200:#ifdef MISSIONPACK
;1201:	if( g_gametype.integer == GT_OBELISK && CheckObeliskAttack( targ, attacker ) ) {
;1202:		return;
;1203:	}
;1204:#endif
;1205:	// reduce damage by the attacker's handicap value
;1206:	// unless they are rocket jumping
;1207:	if ( attacker->client && attacker != targ ) {
ADDRLP4 44
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $457
ADDRLP4 44
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
EQU4 $457
line 1208
;1208:		max = attacker->client->ps.stats[STAT_MAX_HEALTH];
ADDRLP4 20
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ASGNI4
line 1214
;1209:#ifdef MISSIONPACK
;1210:		if( bg_itemlist[attacker->client->ps.stats[STAT_PERSISTANT_POWERUP]].giTag == PW_GUARD ) {
;1211:			max /= 2;
;1212:		}
;1213:#endif
;1214:		damage = damage * max / 100;
ADDRFP4 20
ADDRFP4 20
INDIRI4
ADDRLP4 20
INDIRI4
MULI4
CNSTI4 100
DIVI4
ASGNI4
line 1215
;1215:	}
LABELV $457
line 1217
;1216:
;1217:	client = targ->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
ASGNP4
line 1219
;1218:
;1219:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $459
line 1220
;1220:		if ( client->noclip ) {
ADDRLP4 0
INDIRP4
CNSTI4 2584
ADDP4
INDIRI4
CNSTI4 0
EQI4 $461
line 1221
;1221:			return;
ADDRGP4 $434
JUMPV
LABELV $461
line 1223
;1222:		}
;1223:	}
LABELV $459
line 1225
;1224:
;1225:	if ( !dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $463
line 1226
;1226:		dflags |= DAMAGE_NO_KNOCKBACK;
ADDRFP4 24
ADDRFP4 24
INDIRI4
CNSTI4 4
BORI4
ASGNI4
line 1227
;1227:	} else {
ADDRGP4 $464
JUMPV
LABELV $463
line 1228
;1228:		VectorNormalize(dir);
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1229
;1229:	}
LABELV $464
line 1231
;1230:
;1231:	knockback = damage;
ADDRLP4 4
ADDRFP4 20
INDIRI4
ASGNI4
line 1232
;1232:	if ( knockback > 200 ) {
ADDRLP4 4
INDIRI4
CNSTI4 200
LEI4 $465
line 1233
;1233:		knockback = 200;
ADDRLP4 4
CNSTI4 200
ASGNI4
line 1234
;1234:	}
LABELV $465
line 1235
;1235:	if ( targ->flags & FL_NO_KNOCKBACK ) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $467
line 1236
;1236:		knockback = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1237
;1237:	}
LABELV $467
line 1238
;1238:	if ( dflags & DAMAGE_NO_KNOCKBACK ) {
ADDRFP4 24
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $469
line 1239
;1239:		knockback = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1240
;1240:	}
LABELV $469
line 1243
;1241:
;1242:	// figure momentum add, even if the damage won't be taken
;1243:	if ( knockback && targ->client ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $471
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $471
line 1247
;1244:		vec3_t	kvel;
;1245:		float	mass;
;1246:
;1247:		mass = 200;
ADDRLP4 60
CNSTF4 1128792064
ASGNF4
line 1249
;1248:
;1249:		VectorScale (dir, g_knockback.value * (float)knockback / mass, kvel);
ADDRLP4 64
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 4
INDIRI4
CVIF4 4
ASGNF4
ADDRLP4 72
ADDRLP4 60
INDIRF4
ASGNF4
ADDRLP4 48
ADDRLP4 64
INDIRP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 68
INDIRF4
MULF4
ADDRLP4 72
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 48+4
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 68
INDIRF4
MULF4
ADDRLP4 72
INDIRF4
DIVF4
MULF4
ASGNF4
ADDRLP4 48+8
ADDRFP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRGP4 g_knockback+8
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
MULF4
ADDRLP4 60
INDIRF4
DIVF4
MULF4
ASGNF4
line 1250
;1250:		VectorAdd (targ->client->ps.velocity, kvel, targ->client->ps.velocity);
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRF4
ADDRLP4 48
INDIRF4
ADDF4
ASGNF4
ADDRLP4 80
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 36
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
ADDRLP4 48+4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRF4
ADDRLP4 48+8
INDIRF4
ADDF4
ASGNF4
line 1254
;1251:
;1252:		// set the timer so that the other client can't cancel
;1253:		// out the movement immediately
;1254:		if ( !targ->client->ps.pm_time ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $480
line 1257
;1255:			int		t;
;1256:
;1257:			t = knockback * 2;
ADDRLP4 88
ADDRLP4 4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1258
;1258:			if ( t < 50 ) {
ADDRLP4 88
INDIRI4
CNSTI4 50
GEI4 $482
line 1259
;1259:				t = 50;
ADDRLP4 88
CNSTI4 50
ASGNI4
line 1260
;1260:			}
LABELV $482
line 1261
;1261:			if ( t > 200 ) {
ADDRLP4 88
INDIRI4
CNSTI4 200
LEI4 $484
line 1262
;1262:				t = 200;
ADDRLP4 88
CNSTI4 200
ASGNI4
line 1263
;1263:			}
LABELV $484
line 1264
;1264:			targ->client->ps.pm_time = t;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 16
ADDP4
ADDRLP4 88
INDIRI4
ASGNI4
line 1265
;1265:			targ->client->ps.pm_flags |= PMF_TIME_KNOCKBACK;
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 92
INDIRP4
ADDRLP4 92
INDIRP4
INDIRI4
CNSTI4 64
BORI4
ASGNI4
line 1266
;1266:		}
LABELV $480
line 1267
;1267:	}
LABELV $471
line 1270
;1268:
;1269:	// check for completely getting out of the damage
;1270:	if ( !(dflags & DAMAGE_NO_PROTECTION) ) {
ADDRFP4 24
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
NEI4 $486
line 1277
;1271:
;1272:		// if TF_NO_FRIENDLY_FIRE is set, don't do damage to the target
;1273:		// if the attacker was on the same team
;1274:#ifdef MISSIONPACK
;1275:		if ( mod != MOD_JUICED && targ != attacker && !(dflags & DAMAGE_NO_TEAM_PROTECTION) && OnSameTeam (targ, attacker)  ) {
;1276:#else	
;1277:		if ( targ != attacker && OnSameTeam (targ, attacker)  ) {
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CVPU4 4
ADDRLP4 52
INDIRP4
CVPU4 4
EQU4 $488
ADDRLP4 48
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $488
line 1279
;1278:#endif
;1279:			if ( !g_friendlyFire.integer ) {
ADDRGP4 g_friendlyFire+12
INDIRI4
CNSTI4 0
NEI4 $490
line 1280
;1280:				return;
ADDRGP4 $434
JUMPV
LABELV $490
line 1282
;1281:			}
;1282:		}
LABELV $488
line 1296
;1283:
;1284:
;1285:	/*
;1286:	if (mod == MOD_GRAPPLE && g_GrappleMode.integer == 2)
;1287:	{
;1288:		//targ->client->ps.speed = 0;
;1289:		targ->immobilized == qtrue;
;1290:		return;
;1291:	}
;1292:	*/
;1293:
;1294:	
;1295:	// No Team Killing Of MC -  Make this a cvar
;1296:	if ((targ->s.eType ==ET_BUILDABLE) && (targ->s.team == attacker->client->sess.sessionTeam))
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
NEI4 $493
ADDRLP4 60
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2552
ADDP4
INDIRI4
NEI4 $493
line 1297
;1297:	{
line 1298
;1298:		if ((!strcmp(targ->classname, "mc")) && (g_PCTeamkills.integer == 0))
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRP4
ARGP4
ADDRGP4 $497
ARGP4
ADDRLP4 64
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $495
ADDRGP4 g_PCTeamkills+12
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $495
line 1299
;1299:		{
line 1300
;1300:			return;
ADDRGP4 $434
JUMPV
LABELV $495
line 1302
;1301:		}
;1302:	}
LABELV $493
line 1305
;1303:
;1304:	
;1305:	if ((targ->s.eType ==ET_BUILDABLE) && (targ->health < 1000))
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 13
NEI4 $499
ADDRLP4 64
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 1000
GEI4 $499
line 1306
;1306:	{
line 1307
;1307:		if (!strcmp(targ->classname, "mc"))
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRP4
ARGP4
ADDRGP4 $497
ARGP4
ADDRLP4 68
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $501
line 1308
;1308:		{	
line 1309
;1309:				TeamCP("^9Power Core is Under Attack!",targ->s.team);
ADDRGP4 $503
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 208
ADDP4
INDIRI4
ARGI4
ADDRGP4 TeamCP
CALLV
pop
line 1310
;1310:		}
LABELV $501
line 1311
;1311:	}
LABELV $499
line 1314
;1312:	
;1313:	// Debug
;1314:	if (trep_debug.integer) { G_Printf("Class : %s Taking Damage\n", targ->classname ); }
ADDRGP4 trep_debug+12
INDIRI4
CNSTI4 0
EQI4 $504
ADDRGP4 $507
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRP4
ARGP4
ADDRGP4 G_Printf
CALLV
pop
LABELV $504
line 1329
;1315:	
;1316:
;1317:#ifdef MISSIONPACK
;1318:		if (mod == MOD_PROXIMITY_MINE) {
;1319:			if (inflictor && inflictor->parent && OnSameTeam(targ, inflictor->parent)) {
;1320:				return;
;1321:			}
;1322:			if (targ == attacker) {
;1323:				return;
;1324:			}
;1325:		}
;1326:#endif
;1327:
;1328:		// check for godmode
;1329:		if ( targ->flags & FL_GODMODE ) {
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $508
line 1330
;1330:			return;
ADDRGP4 $434
JUMPV
LABELV $508
line 1332
;1331:		}
;1332:	}
LABELV $486
line 1336
;1333:
;1334:	// battlesuit protects from all radius damage (but takes knockback)
;1335:	// and protects 50% against all damage
;1336:	if ( client && client->ps.powerups[PW_BATTLESUIT] ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $510
ADDRLP4 0
INDIRP4
CNSTI4 320
ADDP4
INDIRI4
CNSTI4 0
EQI4 $510
line 1337
;1337:		G_AddEvent( targ, EV_POWERUP_BATTLESUIT, 0 );
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 G_AddEvent
CALLV
pop
line 1338
;1338:		if ( ( dflags & DAMAGE_RADIUS ) || ( mod == MOD_FALLING ) ) {
ADDRFP4 24
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $514
ADDRFP4 28
INDIRI4
CNSTI4 19
NEI4 $512
LABELV $514
line 1339
;1339:			return;
ADDRGP4 $434
JUMPV
LABELV $512
line 1341
;1340:		}
;1341:		damage *= 0.5;
ADDRFP4 20
CNSTF4 1056964608
ADDRFP4 20
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 1342
;1342:	}
LABELV $510
line 1345
;1343:
;1344:	// add to the attacker's hit counter (if the target isn't a general entity like a prox mine)
;1345:	if ( attacker->client && targ != attacker && targ->health > 0
ADDRLP4 52
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $515
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CVPU4 4
ADDRLP4 52
INDIRP4
CVPU4 4
EQU4 $515
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
LEI4 $515
ADDRLP4 64
ADDRLP4 56
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 3
EQI4 $515
ADDRLP4 64
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $515
ADDRLP4 64
INDIRI4
CNSTI4 13
EQI4 $515
line 1348
;1346:			&& targ->s.eType != ET_MISSILE
;1347:			&& targ->s.eType != ET_GENERAL
;1348:			&& targ->s.eType != ET_BUILDABLE ) {
line 1349
;1349:		if ( OnSameTeam( targ, attacker ) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $517
line 1350
;1350:			attacker->client->ps.persistant[PERS_HITS]--;
ADDRLP4 72
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1351
;1351:		} else {
ADDRGP4 $518
JUMPV
LABELV $517
line 1352
;1352:			attacker->client->ps.persistant[PERS_HITS]++;
ADDRLP4 72
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 252
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1353
;1353:		}
LABELV $518
line 1354
;1354:		attacker->client->ps.persistant[PERS_ATTACKEE_ARMOR] = (targ->health<<8)|(client->ps.stats[STAT_ARMOR]);
ADDRFP4 8
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 276
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 8
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
BORI4
ASGNI4
line 1355
;1355:	}
LABELV $515
line 1359
;1356:
;1357:	// always give half damage if hurting self
;1358:	// calculated after knockback, so rocket jumping works
;1359:	if ( targ == attacker) {
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRFP4 8
INDIRP4
CVPU4 4
NEU4 $519
line 1360
;1360:		damage *= 0.5;
ADDRFP4 20
CNSTF4 1056964608
ADDRFP4 20
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ASGNI4
line 1361
;1361:	}
LABELV $519
line 1363
;1362:
;1363:	if ( damage < 1 ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
GEI4 $521
line 1364
;1364:		damage = 1;
ADDRFP4 20
CNSTI4 1
ASGNI4
line 1365
;1365:	}
LABELV $521
line 1366
;1366:	take = damage;
ADDRLP4 8
ADDRFP4 20
INDIRI4
ASGNI4
line 1367
;1367:	save = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1370
;1368:
;1369:	// save some from armor
;1370:	asave = CheckArmor (targ, take, dflags);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 CheckArmor
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 68
INDIRI4
ASGNI4
line 1371
;1371:	take -= asave;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
SUBI4
ASGNI4
line 1373
;1372:
;1373:	if ( g_debugDamage.integer ) {
ADDRGP4 g_debugDamage+12
INDIRI4
CNSTI4 0
EQI4 $523
line 1374
;1374:		G_Printf( "%i: client:%i health:%i damage:%i armor:%i\n", level.time, targ->s.number,
ADDRGP4 $526
ARGP4
ADDRGP4 level+32
INDIRI4
ARGI4
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
INDIRI4
ARGI4
ADDRLP4 72
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 G_Printf
CALLV
pop
line 1376
;1375:			targ->health, take, asave );
;1376:	}
LABELV $523
line 1381
;1377:
;1378:	// add to the damage inflicted on a player this frame
;1379:	// the total will be turned into screen blends and view angle kicks
;1380:	// at the end of the frame
;1381:	if ( client ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $528
line 1382
;1382:		if ( attacker ) {
ADDRFP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $530
line 1383
;1383:			client->ps.persistant[PERS_ATTACKER] = attacker->s.number;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1384
;1384:		} else {
ADDRGP4 $531
JUMPV
LABELV $530
line 1385
;1385:			client->ps.persistant[PERS_ATTACKER] = ENTITYNUM_WORLD;
ADDRLP4 0
INDIRP4
CNSTI4 272
ADDP4
CNSTI4 1022
ASGNI4
line 1386
;1386:		}
LABELV $531
line 1387
;1387:		client->damage_armor += asave;
ADDRLP4 72
ADDRLP4 0
INDIRP4
CNSTI4 2612
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
ADDRLP4 72
INDIRP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDI4
ASGNI4
line 1388
;1388:		client->damage_blood += take;
ADDRLP4 76
ADDRLP4 0
INDIRP4
CNSTI4 2616
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDI4
ASGNI4
line 1389
;1389:		client->damage_knockback += knockback;
ADDRLP4 80
ADDRLP4 0
INDIRP4
CNSTI4 2620
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 1390
;1390:		if ( dir ) {
ADDRFP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $532
line 1391
;1391:			VectorCopy ( dir, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 2624
ADDP4
ADDRFP4 12
INDIRP4
INDIRB
ASGNB 12
line 1392
;1392:			client->damage_fromWorld = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 2636
ADDP4
CNSTI4 0
ASGNI4
line 1393
;1393:		} else {
ADDRGP4 $533
JUMPV
LABELV $532
line 1394
;1394:			VectorCopy ( targ->r.currentOrigin, client->damage_from );
ADDRLP4 0
INDIRP4
CNSTI4 2624
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRB
ASGNB 12
line 1395
;1395:			client->damage_fromWorld = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 2636
ADDP4
CNSTI4 1
ASGNI4
line 1396
;1396:		}
LABELV $533
line 1397
;1397:	}
LABELV $528
line 1403
;1398:
;1399:	// See if it's the player hurting the emeny flag carrier
;1400:#ifdef MISSIONPACK
;1401:	if( g_gametype.integer == GT_CTF || g_gametype.integer == GT_1FCTF ) {
;1402:#else	
;1403:	if( g_gametype.integer == GT_CTF) {
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 4
NEI4 $534
line 1405
;1404:#endif
;1405:		Team_CheckHurtCarrier(targ, attacker);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 Team_CheckHurtCarrier
CALLV
pop
line 1406
;1406:	}
LABELV $534
line 1408
;1407:
;1408:	if (targ->client) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $537
line 1410
;1409:		// set the last client who damaged the target
;1410:		targ->client->lasthurt_client = attacker->s.number;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2656
ADDP4
ADDRFP4 8
INDIRP4
INDIRI4
ASGNI4
line 1411
;1411:		targ->client->lasthurt_mod = mod;
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 2660
ADDP4
ADDRFP4 28
INDIRI4
ASGNI4
line 1412
;1412:	}
LABELV $537
line 1415
;1413:
;1414:	// Shafe - Trep - Headshots
;1415:	if (targ->client && attacker->client && targ->health > 0)
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
CNSTI4 524
ASGNI4
ADDRLP4 80
CNSTU4 0
ASGNU4
ADDRLP4 72
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 80
INDIRU4
EQU4 $539
ADDRFP4 8
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 80
INDIRU4
EQU4 $539
ADDRLP4 72
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 0
LEI4 $539
line 1416
;1416:	{   
line 1418
;1417:		// let's say only railgun can do head shots
;1418:		if(inflictor->s.weapon==WP_RAILGUN){
ADDRFP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 7
NEI4 $541
line 1419
;1419:			targ_maxs2 = targ->r.maxs[2];
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 464
ADDP4
INDIRF4
ASGNF4
line 1422
;1420:	
;1421:			// handling crouching
;1422:			if(targ->client->ps.pm_flags & PMF_DUCKED){
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $543
line 1423
;1423:				height = (abs(targ->r.mins[2]) + targ_maxs2)*(0.75);
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 84
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 32
CNSTF4 1061158912
ADDRLP4 84
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
ADDF4
MULF4
CVFI4 4
ASGNI4
line 1424
;1424:			}
ADDRGP4 $544
JUMPV
LABELV $543
line 1426
;1425:			else
;1426:				height = abs(targ->r.mins[2]) + targ_maxs2; 
ADDRFP4 0
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 84
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 84
INDIRI4
CVIF4 4
ADDRLP4 36
INDIRF4
ADDF4
CVFI4 4
ASGNI4
LABELV $544
line 1431
;1427:				
;1428:			// project the z component of point 
;1429:			// onto the z component of the model's origin
;1430:			// this results in the z component from the origin at 0
;1431:			z_rel = point[2] - targ->r.currentOrigin[2] + abs(targ->r.mins[2]);
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 452
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 92
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 28
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 504
ADDP4
INDIRF4
SUBF4
ADDRLP4 92
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 1432
;1432:			z_ratio = z_rel / height;
ADDRLP4 24
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 1434
;1433:		
;1434:			if (z_ratio > 0.90){
ADDRLP4 24
INDIRF4
CNSTF4 1063675494
LEF4 $545
line 1435
;1435:				take=9999; // head shot is a sure kill
ADDRLP4 8
CNSTI4 9999
ASGNI4
line 1436
;1436:				mod=MOD_HEADSHOT;
ADDRFP4 28
CNSTI4 23
ASGNI4
line 1437
;1437:			}
LABELV $545
line 1438
;1438:		}
LABELV $541
line 1439
;1439:	}
LABELV $539
line 1444
;1440:	// Shafe - Trep - End Headshot Code
;1441:
;1442:
;1443:	// do the damage
;1444:	if (take) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $547
line 1445
;1445:		targ->health = targ->health - take;
ADDRLP4 84
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
ASGNP4
ADDRLP4 84
INDIRP4
ADDRLP4 84
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 1446
;1446:		if ( targ->client ) {
ADDRFP4 0
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $549
line 1447
;1447:			targ->client->ps.stats[STAT_HEALTH] = targ->health;
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 524
ADDP4
INDIRP4
CNSTI4 184
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
ASGNI4
line 1448
;1448:		}
LABELV $549
line 1450
;1449:			
;1450:		if ( targ->health <= 0 ) {
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 0
GTI4 $551
line 1451
;1451:			if ( client )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $553
line 1452
;1452:				targ->flags |= FL_NO_KNOCKBACK;
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 544
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 2048
BORI4
ASGNI4
LABELV $553
line 1454
;1453:
;1454:			if (targ->health < -999)
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
INDIRI4
CNSTI4 -999
GEI4 $555
line 1455
;1455:				targ->health = -999;
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
CNSTI4 -999
ASGNI4
LABELV $555
line 1457
;1456:
;1457:			targ->enemy = attacker;
ADDRFP4 0
INDIRP4
CNSTI4 792
ADDP4
ADDRFP4 8
INDIRP4
ASGNP4
line 1458
;1458:			targ->die (targ, inflictor, attacker, take, mod);
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 92
INDIRP4
CNSTI4 740
ADDP4
INDIRP4
CALLV
pop
line 1459
;1459:			return;
ADDRGP4 $434
JUMPV
LABELV $551
line 1460
;1460:		} else if ( targ->pain ) {
ADDRFP4 0
INDIRP4
CNSTI4 736
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $557
line 1461
;1461:			targ->pain (targ, attacker, take);
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 88
INDIRP4
CNSTI4 736
ADDP4
INDIRP4
CALLV
pop
line 1462
;1462:		}
LABELV $557
line 1463
;1463:	}
LABELV $547
line 1465
;1464:
;1465:}
LABELV $434
endproc G_Damage 96 24
export CanDamage
proc CanDamage 112 28
line 1476
;1466:
;1467:
;1468:/*
;1469:============
;1470:CanDamage
;1471:
;1472:Returns qtrue if the inflictor can directly damage the target.  Used for
;1473:explosions and melee attacks.
;1474:============
;1475:*/
;1476:qboolean CanDamage (gentity_t *targ, vec3_t origin) {
line 1483
;1477:	vec3_t	dest;
;1478:	trace_t	tr;
;1479:	vec3_t	midpoint;
;1480:
;1481:	// use the midpoint of the bounds instead of the origin, because
;1482:	// bmodels may have their origin is 0,0,0
;1483:	VectorAdd (targ->r.absmin, targ->r.absmax, midpoint);
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 80
INDIRP4
CNSTI4 472
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 484
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 80
INDIRP4
CNSTI4 476
ADDP4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 488
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12+8
ADDRLP4 84
INDIRP4
CNSTI4 480
ADDP4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 492
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1484
;1484:	VectorScale (midpoint, 0.5, midpoint);
ADDRLP4 88
CNSTF4 1056964608
ASGNF4
ADDRLP4 12
ADDRLP4 88
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 88
INDIRF4
ADDRLP4 12+4
INDIRF4
MULF4
ASGNF4
ADDRLP4 12+8
CNSTF4 1056964608
ADDRLP4 12+8
INDIRF4
MULF4
ASGNF4
line 1486
;1485:
;1486:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1487
;1487:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1488
;1488:	if (tr.fraction == 1.0 || tr.entityNum == targ->s.number)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
EQF4 $570
ADDRLP4 24+52
INDIRI4
ADDRFP4 0
INDIRP4
INDIRI4
NEI4 $566
LABELV $570
line 1489
;1489:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $559
JUMPV
LABELV $566
line 1493
;1490:
;1491:	// this should probably check in the plane of projection, 
;1492:	// rather than in world coordinate, and also include Z
;1493:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1494
;1494:	dest[0] += 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1495
;1495:	dest[1] += 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1496
;1496:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 96
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1497
;1497:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $572
line 1498
;1498:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $559
JUMPV
LABELV $572
line 1500
;1499:
;1500:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1501
;1501:	dest[0] += 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1502
;1502:	dest[1] -= 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1503
;1503:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 100
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 100
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1504
;1504:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $576
line 1505
;1505:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $559
JUMPV
LABELV $576
line 1507
;1506:
;1507:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1508
;1508:	dest[0] -= 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1509
;1509:	dest[1] += 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
ADDF4
ASGNF4
line 1510
;1510:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1511
;1511:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $580
line 1512
;1512:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $559
JUMPV
LABELV $580
line 1514
;1513:
;1514:	VectorCopy (midpoint, dest);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 1515
;1515:	dest[0] -= 15.0;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1516
;1516:	dest[1] -= 15.0;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1097859072
SUBF4
ASGNF4
line 1517
;1517:	trap_Trace ( &tr, origin, vec3_origin, vec3_origin, dest, ENTITYNUM_NONE, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRLP4 108
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 1023
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1518
;1518:	if (tr.fraction == 1.0)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $584
line 1519
;1519:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $559
JUMPV
LABELV $584
line 1522
;1520:
;1521:
;1522:	return qfalse;
CNSTI4 0
RETI4
LABELV $559
endproc CanDamage 112 28
export G_RadiusDamage
proc G_RadiusDamage 4196 32
line 1532
;1523:}
;1524:
;1525:
;1526:/*
;1527:============
;1528:G_RadiusDamage
;1529:============
;1530:*/
;1531:qboolean G_RadiusDamage ( vec3_t origin, gentity_t *attacker, float damage, float radius,
;1532:					 gentity_t *ignore, int mod) {
line 1541
;1533:	float		points, dist;
;1534:	gentity_t	*ent;
;1535:	int			entityList[MAX_GENTITIES];
;1536:	int			numListedEntities;
;1537:	vec3_t		mins, maxs;
;1538:	vec3_t		v;
;1539:	vec3_t		dir;
;1540:	int			i, e;
;1541:	qboolean	hitClient = qfalse;
ADDRLP4 4168
CNSTI4 0
ASGNI4
line 1543
;1542:
;1543:	if ( radius < 1 ) {
ADDRFP4 12
INDIRF4
CNSTF4 1065353216
GEF4 $588
line 1544
;1544:		radius = 1;
ADDRFP4 12
CNSTF4 1065353216
ASGNF4
line 1545
;1545:	}
LABELV $588
line 1547
;1546:
;1547:	for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $590
line 1548
;1548:		mins[i] = origin[i] - radius;
ADDRLP4 4172
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4172
INDIRI4
ADDRLP4 4144
ADDP4
ADDRLP4 4172
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
SUBF4
ASGNF4
line 1549
;1549:		maxs[i] = origin[i] + radius;
ADDRLP4 4176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4176
INDIRI4
ADDRLP4 4156
ADDP4
ADDRLP4 4176
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ASGNF4
line 1550
;1550:	}
LABELV $591
line 1547
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $590
line 1552
;1551:
;1552:	numListedEntities = trap_EntitiesInBox( mins, maxs, entityList, MAX_GENTITIES );
ADDRLP4 4144
ARGP4
ADDRLP4 4156
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4172
ADDRGP4 trap_EntitiesInBox
CALLI4
ASGNI4
ADDRLP4 4140
ADDRLP4 4172
INDIRI4
ASGNI4
line 1554
;1553:
;1554:	for ( e = 0 ; e < numListedEntities ; e++ ) {
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRGP4 $597
JUMPV
LABELV $594
line 1555
;1555:		ent = &g_entities[entityList[ e ]];
ADDRLP4 4
CNSTI4 924
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 44
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1557
;1556:
;1557:		if (ent == ignore)
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRFP4 16
INDIRP4
CVPU4 4
NEU4 $598
line 1558
;1558:			continue;
ADDRGP4 $595
JUMPV
LABELV $598
line 1559
;1559:		if (!ent->takedamage)
ADDRLP4 4
INDIRP4
CNSTI4 760
ADDP4
INDIRI4
CNSTI4 0
NEI4 $600
line 1560
;1560:			continue;
ADDRGP4 $595
JUMPV
LABELV $600
line 1563
;1561:
;1562:		// find the distance from the edge of the bounding box
;1563:		for ( i = 0 ; i < 3 ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $602
line 1564
;1564:			if ( origin[i] < ent->r.absmin[i] ) {
ADDRLP4 4176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4176
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4176
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 472
ADDP4
ADDP4
INDIRF4
GEF4 $606
line 1565
;1565:				v[i] = ent->r.absmin[i] - origin[i];
ADDRLP4 4180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4180
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4180
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 472
ADDP4
ADDP4
INDIRF4
ADDRLP4 4180
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1566
;1566:			} else if ( origin[i] > ent->r.absmax[i] ) {
ADDRGP4 $607
JUMPV
LABELV $606
ADDRLP4 4180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4180
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4180
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
ADDP4
INDIRF4
LEF4 $608
line 1567
;1567:				v[i] = origin[i] - ent->r.absmax[i];
ADDRLP4 4184
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4184
INDIRI4
ADDRLP4 8
ADDP4
ADDRLP4 4184
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ADDRLP4 4184
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 484
ADDP4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1568
;1568:			} else {
ADDRGP4 $609
JUMPV
LABELV $608
line 1569
;1569:				v[i] = 0;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTF4 0
ASGNF4
line 1570
;1570:			}
LABELV $609
LABELV $607
line 1571
;1571:		}
LABELV $603
line 1563
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $602
line 1573
;1572:
;1573:		dist = VectorLength( v );
ADDRLP4 8
ARGP4
ADDRLP4 4176
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 4176
INDIRF4
ASGNF4
line 1574
;1574:		if ( dist >= radius ) {
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
LTF4 $610
line 1575
;1575:			continue;
ADDRGP4 $595
JUMPV
LABELV $610
line 1578
;1576:		}
;1577:
;1578:		points = damage * ( 1.0 - dist / radius );
ADDRLP4 40
ADDRFP4 8
INDIRF4
CNSTF4 1065353216
ADDRLP4 24
INDIRF4
ADDRFP4 12
INDIRF4
DIVF4
SUBF4
MULF4
ASGNF4
line 1580
;1579:
;1580:		if( CanDamage (ent, origin) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4180
ADDRGP4 CanDamage
CALLI4
ASGNI4
ADDRLP4 4180
INDIRI4
CNSTI4 0
EQI4 $612
line 1581
;1581:			if( LogAccuracyHit( ent, attacker ) ) {
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 4184
ADDRGP4 LogAccuracyHit
CALLI4
ASGNI4
ADDRLP4 4184
INDIRI4
CNSTI4 0
EQI4 $614
line 1582
;1582:				hitClient = qtrue;
ADDRLP4 4168
CNSTI4 1
ASGNI4
line 1583
;1583:			}
LABELV $614
line 1584
;1584:			VectorSubtract (ent->r.currentOrigin, origin, dir);
ADDRLP4 4192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 4
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 4
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
ADDRLP4 4192
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+8
ADDRLP4 4
INDIRP4
CNSTI4 504
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1587
;1585:			// push the center of mass higher than the origin so players
;1586:			// get knocked into the air more
;1587:			dir[2] += 24;
ADDRLP4 28+8
ADDRLP4 28+8
INDIRF4
CNSTF4 1103101952
ADDF4
ASGNF4
line 1588
;1588:			G_Damage (ent, NULL, attacker, dir, origin, (int)points, DAMAGE_RADIUS, mod);
ADDRLP4 4
INDIRP4
ARGP4
CNSTP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 28
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
INDIRF4
CVFI4 4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 G_Damage
CALLV
pop
line 1589
;1589:		}
LABELV $612
line 1590
;1590:	}
LABELV $595
line 1554
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $597
ADDRLP4 20
INDIRI4
ADDRLP4 4140
INDIRI4
LTI4 $594
line 1592
;1591:
;1592:	return hitClient;
ADDRLP4 4168
INDIRI4
RETI4
LABELV $587
endproc G_RadiusDamage 4196 32
import CountSurvivors
import CheckPlayerPostions
import G_SendCommandToClient
import visible
import findradius
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
import trap_AAS_AreaLadder
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
import trep_debug
import g_PCTeamkills
import g_GrappleMode
import g_Turrets
import g_StartBFG
import g_StartPlasma
import g_StartGauss
import g_StartFlame
import g_StartSingCan
import g_StartGrenade
import g_StartSG
import g_StartMG
import g_StartGauntlet
import g_MultiJumps
import g_RedMC
import g_BlueMC
import g_GameMode
import g_instagib
import sv_fps
import g_lightningDamage
import g_truePing
import g_unlaggedVersion
import g_delagHitscan
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
import Team_DropFlags
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
import Team_Point
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
import FireWeapon2
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import PlaceMC
import SpotWouldTelefrag
import CalculateRanks
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
import BalanceTeams
import TeamCount
import BuildDisplacer
import BuildMC
import BuildGenerator
import BuildTurret
import G_PredictPlayerMove
import G_UnTimeShiftClient
import G_UndoTimeShiftFor
import G_DoTimeShiftFor
import G_UnTimeShiftAllClients
import G_TimeShiftAllClients
import G_StoreHistory
import G_ResetHistory
import Weapon_HookThink
import Weapon_HookFree
import CheckGauntletAttack
import CalcMuzzlePoint
import LogAccuracyHit
import G_BreakGlass
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import fire_mg
import fire_turret
import fire_grapple
import fire_bfg
import fire_rocket
import fire_flame
import fire_alt_rocket
import fire_altgrenade
import fire_bomb
import fire_pdgrenade
import fire_grenade
import fire_plasma
import fire_blaster
import G_RunMissile
import TossClientCubes
import G_InvulnerabilityEffect
import G_ExplodeBomb
import G_ExplodeMissile
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
import irandom
import flrandom
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
LABELV $526
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 58
byte 1 37
byte 1 105
byte 1 10
byte 1 0
align 1
LABELV $507
byte 1 67
byte 1 108
byte 1 97
byte 1 115
byte 1 115
byte 1 32
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 84
byte 1 97
byte 1 107
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 68
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 10
byte 1 0
align 1
LABELV $503
byte 1 94
byte 1 57
byte 1 80
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 32
byte 1 67
byte 1 111
byte 1 114
byte 1 101
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 85
byte 1 110
byte 1 100
byte 1 101
byte 1 114
byte 1 32
byte 1 65
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 33
byte 1 0
align 1
LABELV $497
byte 1 109
byte 1 99
byte 1 0
align 1
LABELV $400
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 46
byte 1 111
byte 1 103
byte 1 103
byte 1 0
align 1
LABELV $385
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 108
byte 1 97
byte 1 102
byte 1 102
byte 1 48
byte 1 49
byte 1 46
byte 1 111
byte 1 103
byte 1 103
byte 1 0
align 1
LABELV $382
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 50
byte 1 46
byte 1 111
byte 1 103
byte 1 103
byte 1 0
align 1
LABELV $379
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 51
byte 1 46
byte 1 111
byte 1 103
byte 1 103
byte 1 0
align 1
LABELV $376
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 52
byte 1 46
byte 1 111
byte 1 103
byte 1 103
byte 1 0
align 1
LABELV $373
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 53
byte 1 46
byte 1 111
byte 1 103
byte 1 103
byte 1 0
align 1
LABELV $365
byte 1 115
byte 1 0
align 1
LABELV $364
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 46
byte 1 49
byte 1 53
byte 1 115
byte 1 94
byte 1 55
byte 1 32
byte 1 72
byte 1 97
byte 1 115
byte 1 32
byte 1 66
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 69
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $363
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
byte 1 72
byte 1 97
byte 1 115
byte 1 32
byte 1 66
byte 1 101
byte 1 101
byte 1 110
byte 1 32
byte 1 69
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 110
byte 1 97
byte 1 116
byte 1 101
byte 1 100
byte 1 33
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $359
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 37
byte 1 46
byte 1 49
byte 1 53
byte 1 115
byte 1 94
byte 1 55
byte 1 39
byte 1 115
byte 1 32
byte 1 65
byte 1 114
byte 1 115
byte 1 101
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 105
byte 1 115
byte 1 32
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 46
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $358
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 37
byte 1 115
byte 1 39
byte 1 115
byte 1 32
byte 1 65
byte 1 114
byte 1 115
byte 1 101
byte 1 110
byte 1 97
byte 1 108
byte 1 32
byte 1 73
byte 1 115
byte 1 32
byte 1 69
byte 1 109
byte 1 112
byte 1 116
byte 1 121
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $321
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
byte 1 77
byte 1 97
byte 1 100
byte 1 101
byte 1 32
byte 1 70
byte 1 105
byte 1 114
byte 1 115
byte 1 116
byte 1 32
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 107
byte 1 101
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $320
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 108
byte 1 97
byte 1 102
byte 1 102
byte 1 48
byte 1 50
byte 1 46
byte 1 111
byte 1 103
byte 1 103
byte 1 0
align 1
LABELV $283
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 32
byte 1 73
byte 1 83
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 65
byte 1 32
byte 1 68
byte 1 89
byte 1 73
byte 1 78
byte 1 71
byte 1 32
byte 1 83
byte 1 80
byte 1 82
byte 1 69
byte 1 69
byte 1 33
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $282
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 73
byte 1 83
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 65
byte 1 32
byte 1 68
byte 1 89
byte 1 73
byte 1 78
byte 1 71
byte 1 32
byte 1 83
byte 1 80
byte 1 82
byte 1 69
byte 1 69
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $279
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 94
byte 1 55
byte 1 37
byte 1 115
byte 1 32
byte 1 73
byte 1 83
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 65
byte 1 32
byte 1 75
byte 1 73
byte 1 76
byte 1 76
byte 1 73
byte 1 78
byte 1 71
byte 1 32
byte 1 83
byte 1 80
byte 1 82
byte 1 69
byte 1 69
byte 1 33
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $278
byte 1 112
byte 1 114
byte 1 105
byte 1 110
byte 1 116
byte 1 32
byte 1 34
byte 1 94
byte 1 51
byte 1 37
byte 1 115
byte 1 32
byte 1 94
byte 1 55
byte 1 73
byte 1 83
byte 1 32
byte 1 79
byte 1 78
byte 1 32
byte 1 65
byte 1 32
byte 1 75
byte 1 73
byte 1 76
byte 1 76
byte 1 73
byte 1 78
byte 1 71
byte 1 32
byte 1 83
byte 1 80
byte 1 82
byte 1 69
byte 1 69
byte 1 33
byte 1 10
byte 1 34
byte 1 0
align 1
LABELV $267
byte 1 75
byte 1 105
byte 1 108
byte 1 108
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 32
byte 1 37
byte 1 105
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 101
byte 1 100
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 98
byte 1 121
byte 1 32
byte 1 37
byte 1 115
byte 1 10
byte 1 0
align 1
LABELV $266
byte 1 60
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 111
byte 1 98
byte 1 105
byte 1 116
byte 1 117
byte 1 97
byte 1 114
byte 1 121
byte 1 62
byte 1 0
align 1
LABELV $259
byte 1 60
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 62
byte 1 0
align 1
LABELV $258
byte 1 60
byte 1 110
byte 1 111
byte 1 110
byte 1 45
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 62
byte 1 0
align 1
LABELV $248
byte 1 98
byte 1 111
byte 1 109
byte 1 98
byte 1 0
align 1
LABELV $239
byte 1 112
byte 1 100
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $215
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $214
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 111
byte 1 98
byte 1 101
byte 1 108
byte 1 105
byte 1 115
byte 1 107
byte 1 0
align 1
LABELV $194
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $193
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 67
byte 1 84
byte 1 70
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $182
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 65
byte 1 80
byte 1 80
byte 1 76
byte 1 69
byte 1 0
align 1
LABELV $181
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 85
byte 1 82
byte 1 82
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $180
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 72
byte 1 69
byte 1 65
byte 1 68
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 0
align 1
LABELV $179
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 82
byte 1 73
byte 1 71
byte 1 71
byte 1 69
byte 1 82
byte 1 95
byte 1 72
byte 1 85
byte 1 82
byte 1 84
byte 1 0
align 1
LABELV $178
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 65
byte 1 82
byte 1 71
byte 1 69
byte 1 84
byte 1 95
byte 1 76
byte 1 65
byte 1 83
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $177
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 85
byte 1 73
byte 1 67
byte 1 73
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $176
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 70
byte 1 65
byte 1 76
byte 1 76
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $175
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 84
byte 1 69
byte 1 76
byte 1 69
byte 1 70
byte 1 82
byte 1 65
byte 1 71
byte 1 0
align 1
LABELV $174
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 67
byte 1 82
byte 1 85
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $173
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 65
byte 1 86
byte 1 65
byte 1 0
align 1
LABELV $172
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 76
byte 1 73
byte 1 77
byte 1 69
byte 1 0
align 1
LABELV $171
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 87
byte 1 65
byte 1 84
byte 1 69
byte 1 82
byte 1 0
align 1
LABELV $170
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $169
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 66
byte 1 70
byte 1 71
byte 1 0
align 1
LABELV $168
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 76
byte 1 73
byte 1 71
byte 1 72
byte 1 84
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $167
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 65
byte 1 73
byte 1 76
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $166
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $165
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 77
byte 1 65
byte 1 0
align 1
LABELV $164
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $163
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 82
byte 1 79
byte 1 67
byte 1 75
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $162
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 95
byte 1 83
byte 1 80
byte 1 76
byte 1 65
byte 1 83
byte 1 72
byte 1 0
align 1
LABELV $161
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 82
byte 1 69
byte 1 78
byte 1 65
byte 1 68
byte 1 69
byte 1 0
align 1
LABELV $160
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 77
byte 1 65
byte 1 67
byte 1 72
byte 1 73
byte 1 78
byte 1 69
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $159
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 71
byte 1 65
byte 1 85
byte 1 78
byte 1 84
byte 1 76
byte 1 69
byte 1 84
byte 1 0
align 1
LABELV $158
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 83
byte 1 72
byte 1 79
byte 1 84
byte 1 71
byte 1 85
byte 1 78
byte 1 0
align 1
LABELV $157
byte 1 77
byte 1 79
byte 1 68
byte 1 95
byte 1 85
byte 1 78
byte 1 75
byte 1 78
byte 1 79
byte 1 87
byte 1 78
byte 1 0
align 1
LABELV $71
byte 1 99
byte 1 112
byte 1 32
byte 1 34
byte 1 94
byte 1 57
byte 1 37
byte 1 115
byte 1 10
byte 1 34
byte 1 0
