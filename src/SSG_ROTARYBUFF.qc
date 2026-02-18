//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SSG_ROTARYBUFF_NAME	=	"SSG_ROTARYBUFF";
string	SSG_ROTARYBUFF_MODEL	=	"progs/placeholder_progs/v_ssg_rotary.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)
//	1.3	20	2	1*4	'0.1 0.02 0'		//Dwell Rotary hitscan (40*4= 160)


//=============================================================================================
	
	
	float	SSG_ROTARYBUFF_ROF	=	1.3;		//seconds post-fire
	
	float	SSG_ROTARYBUFF_COUNT	=	10;		//number of shots
	float	SSG_ROTARYBUFF_DMG 	=	5;	//=50	//damage per shot

	float	SSG_ROTARYBUFF_COST	=	1;	//*4	//ammo cost to fire
	
	vector	SSG_ROTARYBUFF_SPREAD	=	'0.1 0.02 0';	//seconds post-fire	//W_Fire_SSG_ROTARYBUFF_hitscan


//=============================================================================================

float() weaponanim_SSG_ROTARYBUFF =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	//self.currentammo = self.ammo_shells = self.ammo_shells - SSG_ROTARYBUFF_COST;
	self.attack_finished = time + SSG_ROTARYBUFF_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	W_Fire_SSG_ROTARYBUFF_hitscan();

	self.weaponframe = 11;
	self.think = weaponanim_SSG_ROTARYBUFF_loop;
	self.nextthink = time + 0.025;	
	return TRUE;
}

void() weaponanim_SSG_ROTARYBUFF_loop =
{
	if (intermission) return;

	//fires:  1,  8, 16, 24
	//+draw: 11, 18, 26, 34

	if (self.weaponframe == 18)	W_Fire_SSG_ROTARYBUFF_hitscan();
	if (self.weaponframe == 26)	W_Fire_SSG_ROTARYBUFF_hitscan();
	if (self.weaponframe == 34)	W_Fire_SSG_ROTARYBUFF_hitscan();
		
	if (self.weaponframe >= 50)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 72)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SSG_ROTARYBUFF_loop;
	self.nextthink = time + 0.025;
}

//=============================================================================================

void() W_Fire_SSG_ROTARYBUFF_hitscan =
{
	sound(self, CHAN_WEAPON, "placeholder_sound/shotgn3.wav", 1, ATTN_NORM);
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SSG_ROTARYBUFF_COST;
	Eject_BuckshotCasing();
	
	//makevectors(self.v_angle);
	//local vector dir = aim(self, AUTOAIM_DIST);
	
	makevectors (self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  4;
	vector org_eye = self.origin + self.view_ofs;
	
	
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
	
	ClearMultiDamage();
	//FireBulletsEx_SSG_ROTARYBUFF(SSG_ROTARYBUFF_COUNT, dir, SSG_ROTARYBUFF_SPREAD, SSG_ROTARYBUFF_DMG);
	
	
	//FirePistolBullets (1, 20, org_eye, org_gun + v_forward * 32 * trace_fraction, dir_eye, spread, 2, TRUE);
	FirePistolBullets(SSG_ROTARYBUFF_COUNT, SSG_ROTARYBUFF_DMG, org_eye, org_gun + v_forward * 32 * trace_fraction, dir_eye, SSG_ROTARYBUFF_SPREAD, 2, TRUE);
	
	ApplyMultiDamage();
	self.punchangle_x = -2;
}

void(float shotcount, vector dir, vector spread, float damage) FireBulletsEx_SSG_ROTARYBUFF =
{
	vector src, direction;
	entity ig;
	float s, lim;
	
	if (shotcount <= 0) return;
	
	makevectors(self.v_angle);

	if (trace_debug) dprint3("*** firing ", ftos(shotcount), " bullets *\n\n");
	for (s = 0; s < shotcount; s++)
	{
		src = self.origin + v_forward*10;
		src_z = self.absmin_z + self.size_z * 0.7;
		direction = SpreadVector(dir, spread);
		
		if (trace_debug) dprint("* firing a bullet *\n");
		
		lim = 0;
		// check for trace-through cases
		for (ig = self; ig != world; lim++)	// ig == world if we hit a wall or hit nothing
		{
			traceline2(src, src + direction*2048, ig, 0);
			
			if (trace_ent == self)
				return;	// some notrace shit happened
		
			// if we've already pelted a monster enough to kill it, let additional bullets add 
			// up for possible gibs (ala quake), but trace them again through the target for 
			// better crowd control feels (ala doom).
			// this is only noticeable with big hordes of weak guys, but it makes big hordes of
			// weak guys not feel like solid ammo-sponge walls.
			if (trace_ent.takedamage && 
				(trace_ent.flags & FL_MONSTER || trace_ent.classname == "player" ) && 
				// some id shootables are actually trigger_multiples with health and SOLID_BBOX, so this doesn't work (see e1m6):
				//( trace_ent.solid == SOLID_BBOX || trace_ent.solid == SOLID_SLIDEBOX ) &&	
				HasBeenShotToDeath(trace_ent) )
			{
				BulletImpact (2+2*random(), direction);

				// start 0.1 unit forward, or else when shooting an adjacent enemy we'll
				// just hit ourselves again
				src = trace_endpos + direction * 0.1;
				ig = trace_ent;
				if (trace_debug) dprint3("bullet hit ", ig.classname, ", continuing thru\n");
			}
			else
			{
				if (trace_debug) dprint("bullet reached world\n");
				ig = world;
			}
			if (lim > 8)
			{
				dprint("bullet pen limit exceeded\n");
				break;
			}
		}
		
		if (trace_fraction != 1.0)
		{
			BulletImpact (damage, direction);
		}
		
		if (trace_debug) dprint("bullet is over\n\n");
	}
}
