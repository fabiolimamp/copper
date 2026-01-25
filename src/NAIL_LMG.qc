//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	NAIL_LMG_NAME	=	"NAIL_LMG";
string	NAIL_LMG_MODEL	=	"progs/placeholder_progs/v_nail_lmg.mdl";


//	ROF	COUNT * DMG	COST	SPEED		DESCRIPTION
//	0.08	1	9	1	1996		//QBJ3 Twin Nailgun (9)

//	0.15	2	13	2	1400		//QBJ3 Twin Nailgun (2*13=26)

//	0.1	1	9	1	hitscan		//Nail LMG 


//=============================================================================================
	
	
	float	NAIL_LMG_ROF		=	0.1;		//seconds post-fire
	
	float	NAIL_LMG_COUNT		=	1;		//number of shots
	float	NAIL_LMG_DMG 		=	10;	// 9	//damage per shot

	float	NAIL_LMG_COST		=	1;		//ammo cost to fire
	
	//float	NAIL_LMG_SPEED		=	2000;		//arc velocity
	
	
	
	
	// UNUSED WITH THE MUZZLE BLOOM CODE... SCROLL TO BOTTOM!!!
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
	
	
	//W_Fire_NAIL_LMG_hitscan();
	
	
	W_FireThompson();
	
	
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
	if (self.weaponframe == 12)	Eject_BulletCasing();
	
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


////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Thompson
//
////////////////////////////////////////////////////////////////////////////////////////////////


.float 		shotcount, lastshot;


void() W_FireThompson =
{
	vector dir, finaldir, org, definespread;
	makevectors (self.v_angle);


		org = self.origin + self.view_ofs - v_up* 8 + v_right* 6;	// HIP	
			
		sound (self, CHAN_AUTO, "placeholder_sound/tommy_fire2.wav", 0.6, ATTN_NORM);
		

	dir = aim (self, 10000);
	traceline(org, org + v_forward* 16, FALSE, self);
		
	
	
		if (time < self.lastshot + 0.2) self.shotcount = min(self.shotcount + 1, 12);			// larger # = higher max shotcount multiplier	+ 1, #); 
		else self.shotcount = max(0, self.shotcount - rint((time - self.lastshot - 0.01)/0.01));	// smaller # = faster time to reduce shotcount	- 0.#)/0.#));
		
		
		definespread = [self.shotcount* 0.075 + 0.05, self.shotcount* 0.05 + 0.05, 0]* (0.35);			// ['+right, +up, 0'] * (adjustment multiplier)
			
	
		vector dir_skew = dir + v_right* ((self.shotcount* -0.002) -0.002) + v_up* ((self.shotcount* 0) + 0);	// (right, up) muzzle rise * shotcount



	finaldir = FireBulletsEE (NAIL_LMG_COUNT, NAIL_LMG_DMG, org + v_forward* 8 *trace_fraction, dir_skew, definespread, 8);
	
	
		
	//--------------------------------------- MUZZLE RISER
		self.lastshot = time;
	if 	(self.shotcount <= 5) 	self.punchangle_x = -1;
	else if (self.shotcount >  5) 	self.punchangle_x = -2;

	float initialang = vectoyaw2(dir);
	float finalang = vectoyaw2(finaldir);
	float dif = anglemod180(initialang) - anglemod180(finalang);
	if (dif > 180) dif -= 360;
	else if (dif < -180) dif += 360;
	
	
	//--------------------------------------- CAMERA KICK
	/*
	makevectors(self.v_angle);
	local vector aimkick;

		aimkick_x = ( -0.5 );		// up
		aimkick_y = ( 0.5 *random());	// right
	
	aimkick = aimkick + self.v_angle;
	msg_entity = self;
	WriteByte ( MSG_ONE, 10 );
	WriteAngle( MSG_ONE, aimkick_x );
	WriteAngle( MSG_ONE, aimkick_y );
	WriteAngle( MSG_ONE, aimkick_z );
	makevectors(self.v_angle);
	*/
};

////////////////////////////////////////////////////////////////////////////////////////////////

vector(float shotcount, float dmg, vector org, vector dir, vector spread, float centerbias) FireBulletsEE =
{
	local vector direction;
	local vector plane_normal;
	vector endpoint;
	entity ent_hit;
	//float bullet;

	vector angs = vectoangles(dir);
	makevectors([-angs_x, angs_y, angs_z]);

	vector rt = v_right;
	vector up = v_up;

	//ClearMultiDamage();
	while (shotcount > 0)
	{
		direction = dir + weighted_crandom(centerbias)*spread_x*rt + weighted_crandom(centerbias)*spread_y*up;

		traceline (org, org + direction*2048, FALSE, self);
		endpoint = trace_endpos;
		ent_hit = trace_ent;

		if (!(vlen(org - trace_endpos) < 128 && ent_hit.solid == SOLID_BSP))
			drawTracer(org, endpoint);
		
		if (trace_fraction != 1.0) {
			plane_normal = trace_plane_normal;
			
			//TraceAttack(dmg, direction, penetrate);
			BulletImpact (dmg, direction);

			//placebullethole(endpoint, plane_normal, ent_hit);
		}
		shotcount = shotcount - 1;
	}
	ApplyMultiDamage ();

	return direction;
};