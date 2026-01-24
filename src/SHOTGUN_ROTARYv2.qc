//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SHOTGUN_ROTARYv2_NAME	=	"SHOTGUN_ROTARYv2";
string	SHOTGUN_ROTARYv2_MODEL	=	"progs/placeholder_progs/v_shotgun_rotary.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)
//	1.3	20	2	1*4	'0.1 0.02 0'		//Dwell Rotary hitscan (40*4= 160)

//	1.3	20	2	1*4	'0.1 0.02 0'		//Dwell Rotary hitscan v2 (40*4= 160)


//=============================================================================================
	
	
	float	SHOTGUN_ROTARYv2_ROF	=	1.2;		//seconds post-fire
	
	float	SHOTGUN_ROTARYv2_COUNT	=	5;		//number of shots
	float	SHOTGUN_ROTARYv2_DMG 	=	10;	//50	//damage per shot

	float	SHOTGUN_ROTARYv2_COST	=	2;		//ammo cost to fire
	
	//vector	SHOTGUN_ROTARYv2_SPREAD	=	'0.1 0.02 0';	//seconds post-fire	//W_Fire_SHOTGUN_ROTARYv2_hitscan
	float	SHOTGUN_ROTARYv2_SPREAD_WIDTH	=	0.2;
	float	SHOTGUN_ROTARYv2_SPREAD_RISE	=	0.02;


//=============================================================================================

float() weaponanim_SHOTGUN_ROTARYv2 =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_ROTARYv2_COST;
	self.attack_finished = time + SHOTGUN_ROTARYv2_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	W_Fire_SHOTGUN_ROTARYv2_hitscan();
	
	//W_Fire_SHOTGUN_ROTARYv2_flak();

	self.weaponframe = 11;
	self.think = weaponanim_SHOTGUN_ROTARYv2_loop;
	self.nextthink = time + 0.025;	
	return TRUE;
}

void() weaponanim_SHOTGUN_ROTARYv2_loop =
{
	if (intermission) return;

	//fires:  1,  8, 16, 24
	//+draw: 11, 18, 26, 34

	if (self.weaponframe == 15)	W_Fire_SHOTGUN_ROTARYv2_hitscan();
	if (self.weaponframe == 20)	W_Fire_SHOTGUN_ROTARYv2_hitscan();
	if (self.weaponframe == 25)	W_Fire_SHOTGUN_ROTARYv2_hitscan();
		
	if (self.weaponframe >= 50)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 72)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SHOTGUN_ROTARYv2_loop;
	self.nextthink = time + 0.025;
}

//=============================================================================================

void() W_Fire_SHOTGUN_ROTARYv2_hitscan =
{
	sound(self, CHAN_WEAPON, "placeholder_sound/shotgn3.wav", 1, ATTN_NORM);
	
	//self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_ROTARYv2_COST;

	makevectors(self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  6;
	vector org_eye = self.origin + self.view_ofs;
	
	// aim point directly in front of the crosshair
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
	
	self.punchangle_x = -1;
	local vector dir = aim(self, AUTOAIM_DIST);
	
	ClearMultiDamage();
	
	//FireBulletsEx_SHOTGUN_ROTARYv2(SHOTGUN_ROTARYv2_COUNT, dir, SHOTGUN_ROTARYv2_SPREAD, SHOTGUN_ROTARYv2_DMG);
	
	FirePistolBullets_SHOTGUN_ROTARYv2(SHOTGUN_ROTARYv2_COUNT, SHOTGUN_ROTARYv2_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_ROTARYv2_SPREAD_WIDTH, SHOTGUN_ROTARYv2_SPREAD_RISE, SHOTGUN_ROTARYv2_COUNT, TRUE);    
	
	ApplyMultiDamage();
}
/*
void(float shotcount, vector dir, vector spread, float damage) FireBulletsEx_SHOTGUN_ROTARYv2 =
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
*/
void(float shotcount, float dmg, vector shot_org, vector tracer_org, vector dir, float spread_width, float spread_rise, float pellet_count, float tracer) FirePistolBullets_SHOTGUN_ROTARYv2 =
{
	vector src, direction;
	entity ig;
	//float s;
	float lim;
	
	//if (shotcount <= 0) return;
	
	makevectors(self.v_angle);
	vector up = v_up;
	vector rt = v_right;
	
	while (shotcount > 0)
	
	//if (trace_debug) dprint3("*** firing ", ftos(shotcount), " bullets *\n\n");
	//for (s = 0; s < shotcount; s++)
	{
		src = shot_org;
		
		float pellet_spacing = spread_width / (pellet_count - 1);
		
		float spread_result = ((spread_width / 2) + pellet_spacing) - (pellet_spacing * shotcount);
		
		direction = dir + spread_result*rt + weighted_crandom(2)*spread_rise*up;
		
		
		shotcount--;
			
		
		if (trace_debug) dprint("* firing a bullet *\n");
		
		lim = 0;
		// check for trace-through cases
		for (ig = self; ig != world; lim++)	// ig == world if we hit a wall or hit nothing
		{
			traceline2(src, src + direction*2048, ig, 0);
			
			if (trace_ent == self)
				return;	// some notrace shit happened

			if (tracer && !(vlen(tracer_org - trace_endpos) < 128 && trace_ent.solid == SOLID_BSP))
			{
				drawTracer(tracer_org, trace_endpos);
			}
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
			BulletImpact (dmg, direction);
		}
		
		if (trace_debug) dprint("bullet is over\n\n");
	}
}
