//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SSG_SWEEPER_NAME	=	"SSG_SWEEPER";
string	SSG_SWEEPER_MODEL	=	"progs/placeholder_progs/v_ssg_sweeper.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)
//	1.3	20	2	1*4	'0.1 0.02 0'		//Dwell Rotary hitscan (40*4= 160)
//	2	8	5	1*3	'0.2 0.02 0';		//Dwell Rotary hitscan (40*6= 240)
//	0.5	8	5	1	'0.2 0.02 0';		//SWEEPER (40*2= 80) 160 DPS


//=============================================================================================
	
	
	float	SSG_SWEEPER_ROF	=	0.5;		//seconds post-fire
	float	SSG_SWEEPER_LOCK	=	0.6;		//seconds post-fire
	
	float	SSG_SWEEPER_COUNT	=	8;		//number of shots
	float	SSG_SWEEPER_DMG 	=	5;	//40	//damage per shot

	float	SSG_SWEEPER_COST	=	1;		//ammo cost to fire
	
	//vector	SSG_SWEEPER_SPREAD	=	'0.2 	0.02 	0';	//W_Fire_SSG_SWEEPER_hitscan	
	float	SSG_SWEEPER_SPREAD_WIDTH	=	0.3;
	float	SSG_SWEEPER_SPREAD_RISE	=	0.02;

//=============================================================================================

float() weaponanim_SSG_SWEEPER =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	//self.currentammo = self.ammo_shells = self.ammo_shells - SSG_SWEEPER_COST;
	self.attack_finished = time + SSG_SWEEPER_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	W_Fire_SSG_SWEEPER_hitscan();
	//W_Fire_SSG_SWEEPER_flak();
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SSG_SWEEPER_COST;
	Eject_BuckshotCasing();


	self.weaponframe = 11;
	self.think = weaponanim_SSG_SWEEPER_loop;
	self.nextthink = time + 0.025;
	return TRUE;
}

void() weaponanim_SSG_SWEEPER_loop =
{
	if (intermission) return;
	
	if (self.weaponframe == 21)	{W_Fire_SSG_SWEEPER_hitscan();}
		
	if (self.weaponframe == 32)	self.attack_finished = time + SSG_SWEEPER_LOCK;
	
	if (self.weaponframe > 50)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
		
	if (self.weaponframe >= 60)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SSG_SWEEPER_loop;
	self.nextthink = time + 0.025;
}

//=============================================================================================

void() W_Fire_SSG_SWEEPER_hitscan =
{
	sound(self, CHAN_WEAPON, "placeholder_sound/shotgn3.wav", 1, ATTN_NORM);
	
	//self.currentammo = self.ammo_shells = self.ammo_shells - SSG_SWEEPER_COST;
	Eject_BuckshotCasing();
		
	makevectors(self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  6;
	vector org_eye = self.origin + self.view_ofs;
	
	// aim point directly in front of the crosshair
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
	
	self.punchangle_x = -1;
	local vector dir = aim(self, AUTOAIM_DIST);
	
	ClearMultiDamage();
	
	//FirePistolBullets(SSG_SWEEPER_COUNT, SSG_SWEEPER_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SSG_SWEEPER_SPREAD, TRUE);              
	
	FirePistolBullets_SSG_SWEEPER(SSG_SWEEPER_COUNT, SSG_SWEEPER_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SSG_SWEEPER_SPREAD_WIDTH, SSG_SWEEPER_SPREAD_RISE, SSG_SWEEPER_COUNT, TRUE);              
	
	ApplyMultiDamage();
}

void(float shotcount, float dmg, vector shot_org, vector tracer_org, vector dir, float spread_width, float spread_rise, float pellet_count, float tracer) FirePistolBullets_SSG_SWEEPER =
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
		
		//direction = dir + weighted_crandom(2)*spread_width*rt + weighted_crandom(2)*spread_rise*up;
			
		/*
		---------------------------------
		
		Spread formula with even spacing

		oC = L / (n-1)
				
		oC = on Center spacing
		L = Length
		n = Number of objects
		
		---------------------------------
				
		ex:  2.5 = 10 / (5-1)
				
		2.5 = pellet_spacing
		10 = spread_width
		5 = pellet_count
		
		---------------------------------
				
		0   2.5   5   7.5   10   add pellet_spacing for each pellet_count starting with 0...
		
		*0  *1   *2   *3   *4   = multiplied by shotcount...
		
		Then subtract half the spread_width from each space to get it centered again...
		
		-5  -2.5  0  +2.5  +5   = spread_result!
		
		((spread_width / 2) + pellet_spacing) offset?
		
		Number of shotcount == Pellet count
		
		---------------------------------
		*/
		
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