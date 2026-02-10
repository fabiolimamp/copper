//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SHOTGUN_QUAKEY_NAME	=	"SHOTGUN_QUAKEY";
string	SHOTGUN_QUAKEY_MODEL	=	"progs/placeholder_progs/v_shotgun_cowboy.mdl";


//	ROF	COUNT * DMG	COST	SPREAD		DESCRIPTION
//	1.05	22	4	1	'280 60 0'	//QBJ3 flak (88)
//	0.8	11	5	1	'220 180 0'	//fade flak (55)
//	0.8	13	4	1	'220 180 0'	//fade flak (52)
//	0.8	13	4	1	'220 180 0'	//fade flak (52)
//	0.8	10	5	1	'160 240 0'	//Cowbow maresleg (50*)
//	0.8	11	5	1	'0.16 0.1 0'	//Cowbow Quakey (55) hitscan, no pierce


//	90 / 1 = 90 DPS
//	50 / 0.7 = 71 DPS
//	55 / 0.8 = 68 DPS*
//	60 / 0.9 = 67 DPS
//	66 / 1 = 66 DPS

//=============================================================================================
	
	
	float	SHOTGUN_QUAKEY_ROF	=	0.8;		//seconds post-fire
	
	float	SHOTGUN_QUAKEY_COUNT	=	11;		//number of shots
	float	SHOTGUN_QUAKEY_DMG 	=	5;	//55	//damage per shot

	float	SHOTGUN_QUAKEY_COST	=	1;		//ammo cost to fire
	
	vector	SHOTGUN_QUAKEY_SPREAD	=	'0.16 0.1 0';	//0.14 0.08 0' ID1 spread amount


//=============================================================================================

float() weaponanim_SHOTGUN_QUAKEY =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_QUAKEY_COST;
	self.attack_finished = time + SHOTGUN_QUAKEY_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	//self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	
	W_Fire_SHOTGUN_QUAKEY();


	self.weaponframe = 11;	
	self.think = weaponanim_SHOTGUN_QUAKEY_loop;
	self.nextthink = time + 0.05;	
	return TRUE;
}

void() weaponanim_SHOTGUN_QUAKEY_loop =
{
	if (intermission) return;

	if (self.weaponframe == 21) 
	{
		Eject_BuckshotCasing();
		sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	}
	
	//if (self.weaponframe >= 40)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 30)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SHOTGUN_QUAKEY_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void() W_Fire_SHOTGUN_QUAKEY =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun1.wav", 0.8, ATTN_NORM);
	sound (self, CHAN_AUTO, "flak/volley_fire1.wav", 1, ATTN_NORM);
	//sound_shotgun_shoot(0.5);
	
		
	makevectors(self.v_angle);
	vector org_gun = self.origin + self.view_ofs + v_forward*12 + v_up*-4 + v_right*4;
	vector org_eye = self.origin + self.view_ofs;
	
	// aim point directly in front of the crosshair
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
	
	self.punchangle_x = -1;
	local vector dir = aim(self, AUTOAIM_DIST);
	
	ClearMultiDamage();
	
	FirePistolBullets(SHOTGUN_QUAKEY_COUNT, SHOTGUN_QUAKEY_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_QUAKEY_SPREAD, TRUE);                        
	
	ApplyMultiDamage();
}
