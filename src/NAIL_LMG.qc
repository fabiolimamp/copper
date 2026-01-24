//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	NAIL_LMG_NAME	=	"NAIL_LMG";
string	NAIL_LMG_MODEL	=	"progs/placeholder_progs/v_nail_lmg.mdl";


//	ROF	COUNT * DMG	COST	SPEED		DESCRIPTION
//	0.08	1	9	1	1996		//QBJ3 Twin Nailgun (9)

//	0.15	2	13	2	1400		//QBJ3 Twin Nailgun (2*13=26)


//=============================================================================================
	
	
	float	NAIL_LMG_ROF		=	0.08;		//seconds post-fire
	
	float	NAIL_LMG_COUNT		=	2;		//number of shots
	float	NAIL_LMG_DMG 		=	5;	// 8	//damage per shot

	float	NAIL_LMG_COST		=	1;		//ammo cost to fire
	
	//float	NAIL_LMG_SPEED		=	2000;		//arc velocity
	
	vector	NAIL_LMG_SPREAD		=	'0.01 0.01 0';
	float	NAIL_LMG_SPREAD_WIDTH	=	0.02;
	float	NAIL_LMG_SPREAD_RISE	=	0.08;

//=============================================================================================


float() weaponanim_NAIL_LMG =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - NAIL_LMG_COST;

	self.attack_finished = time + NAIL_LMG_ROF;
	
	//SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	
	W_Fire_NAIL_LMG_hitscan();
	
	
	self.punchangle_x = -1;
	self.effects |= EF_MUZZLEFLASH;
	
	//sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 0.4, ATTN_NORM);	
	//sound (self, CHAN_AUTO, "nail/airpuff.wav", 1, ATTN_NORM);	
	nailgun_sound(0.45);


	self.weaponframe = 11;
	self.think = weaponanim_NAIL_LMG_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_NAIL_LMG_loop =
{
	if (self.weaponframe >= 20)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_NAIL_LMG_loop;
	self.nextthink = time + 0.025;
}
//=============================================================================================

void() W_Fire_NAIL_LMG_hitscan =
{
	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 0.4, ATTN_NORM);
	sound_pistol_fire(0.4);	
	//sound (self, CHAN_AUTO, "nail/airpuff.wav", 1, ATTN_NORM);
	
	makevectors (self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  8 + v_forward * 8;
	vector org_eye = self.origin + self.view_ofs;
	
	vector spread = NAIL_LMG_SPREAD;

	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);	//aim point directly in front of the crosshair
	vector dir_eye = normalize(trace_endpos - org_eye);
		
	ClearMultiDamage ();
	
	
	//FirePistolBullets (NAIL_LMG_COUNT, NAIL_LMG_DMG, org_eye, org_gun + v_forward * 16 * trace_fraction, dir_eye, spread, TRUE);
	
	
	FirePistolBullets_SHOTGUN_ROTARYv2(NAIL_LMG_COUNT, NAIL_LMG_DMG, org_eye, org_gun + v_forward * 16 * trace_fraction, dir_eye, NAIL_LMG_SPREAD_WIDTH, NAIL_LMG_SPREAD_RISE, NAIL_LMG_COUNT, TRUE);
	
	
	ApplyMultiDamage ();
	self.punchangle_x = -2;	//punch AFTER makevectors
};