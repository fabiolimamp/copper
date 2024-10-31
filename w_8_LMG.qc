////////////////////////////////////////////////////////////////////////////////////////////////
// LMG_tracers and LMGbullet code by bmFbr, edits by Kebby
////////////////////////////////////////////////////////////////////////////////////////////////


float() weaponanim_LMG = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon());
		return FALSE;
	}

	self.currentammo = self.ammo_cells = self.ammo_cells - 1;

	/*dprint("\bDamage\b: ");
	dprint(ftos(self.lip));
	dprint("\n\bROF\b: ");
	dprint(ftos(self.LMG_rof));
	dprint("\n");
	*/

	self.attack_finished = time + (0.3 / lmg_getROF());
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	W_FireLMG(); //fancy LMG_tracers and all that

	self.weaponframe = 1;
	self.think = weaponanim_LMG_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}


void() weaponanim_LMG_loop = {

	
	if (self.weaponframe == 2) Eject_LMGbulletCasing();

	if (self.weaponframe == 2) lmg_increaseShot();

	
	if (self.weaponframe >= 4) {
			self.weaponframe = 0;
			return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_LMG_loop;
	self.nextthink = time + 0.025;
}

//=====================================================================================================================

//used in W_WeaponFrame, couldn't figure out a way to handle it from here
//TODO: cleanup
/*void() LMG_reset = {
	self.LMG_rof = max(self.LMG_rof - 0.01, 1);
	self.LMG_spread = max(self.LMG_spread - 0.05, 0);
	self.lip = max(self.lip - 0.05, 15);

	//dprint5("\bDamage\b: ",ftos(self.lip), "\n\bROF\b: ", ftos(self.LMG_rof), "\n");
}
*/

// number of shots it takes to get to max stats
float LMG_MAXCOUNT = 24;

void() lmg_reset = {
	if (time > self.lmg_cooldown_finished){

		// ROF/damage stay more sustained in between bursts
		self.lmg_rof = max(self.lmg_rof - 0.8, 0);
		// spread reduces at a way faster rate
		self.lmg_spread = max(self.lmg_rof - 2, 0);

		self.lmg_cooldown_finished = time + 0.05;
	}
}

void() lmg_increaseShot = {
	self.lmg_rof = min(self.lmg_rof + 1, LMG_MAXCOUNT);
	// spread increases faster
	self.lmg_spread = min(self.lmg_spread + 1.3, LMG_MAXCOUNT);
}

float() lmg_getROF = {
	return lerp(1, 3.6, self.lmg_rof/LMG_MAXCOUNT);
}

vector() lmg_getSpread = {
	float spread = lerp(0, 0.2, self.lmg_spread/LMG_MAXCOUNT);
	return [spread, spread, 0];
}

// damage follows ROF variation
float() lmg_getDamage = {
	return lerp(15, 40, self.lmg_rof/LMG_MAXCOUNT);
}


/*
float(float rof) LMG_increaserof = {
	rof += 0.1;
	if (rof > 3.6) return 3.6;
	else return rof;
}

float(float spread) LMG_increasespread = {
	spread += 0.01;
	if (spread > 0.2) return 0.2;
	else return spread;
}

float(float dmg) LMG_increasedamage = {
	dmg += 1.2;
	if (dmg > 40) return 40;
	else return dmg;
}
*/
//=====================================================================================================================
void() W_FireLMG =
{
	sound (self, CHAN_WEAPON, "pistol_shoot.wav", 1, ATTN_NORM);	
	
	makevectors(self.v_angle);
	
	
	vector org = self.origin + self.view_ofs - v_up * 8;
	vector dir = aim(self, 100000);
	//vector spread = [self.LMG_spread, self.LMG_spread, 0];

	vector spread = lmg_getSpread();
	float dmg = lmg_getDamage();
	
	traceline(org, org + v_forward * 16, FALSE, self);
		
	ClearMultiDamage ();
	FireLmgBullets (1, dmg, org + v_forward * 16 * trace_fraction, dir, spread);
	ApplyMultiDamage ();

	self.punchangle_x = -1;	//punch AFTER makevectors	
	
};

void(float shotcount, float dmg, vector org, vector dir, vector spread) FireLmgBullets =
{
	vector src, direction;
	entity ig;
	float s, lim;
	
	if (shotcount <= 0) return;
	
	makevectors(self.v_angle);
	vector up = v_up;
	vector rt = v_right;

	if (trace_debug) dprint3("*** firing ", ftos(shotcount), " bullets *\n\n");
	for (s = 0; s < shotcount; s++)
	{
		src = org;
		direction = dir + weighted_crandom(2)*spread_x*rt + weighted_crandom(2)*spread_y*up;
		
		if (trace_debug) dprint("* firing a bullet *\n");
		
		lim = 0;
		// check for trace-through cases
		for (ig = self; ig != world; lim++)	// ig == world if we hit a wall or hit nothing
		{
			traceline2(src, src + direction*2048, ig, 0);
			
			if (trace_ent == self)
				return;	// some notrace shit happened

			if (!(vlen(org - trace_endpos) < 128 && trace_ent.solid == SOLID_BSP))
			{
				drawTracer(org, direction, trace_endpos);
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



//=============================================================================================

void() LMGbulletCasingTouch2 =
{
	if (CheckProjectilePassthru()) return;

	self.avelocity = '0 0 0';
}

void() LMGbulletCasingTouch1 =
{
	if (CheckProjectilePassthru()) return;

	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
	self.touch = LMGbulletCasingTouch2;
}

void() Eject_LMGbulletCasing =
{
	makevectors(self.v_angle);
	vector vel = v_forward * 100 + v_right * (200 + 60*random()) + v_up * (60 + 30 * random());
	vector org = self.origin + self.view_ofs + (v_forward * 32) + (v_right * 12) + (v_up * -12);
	
	entity casing = toss_projectile(org, vel, "casing");
	casing.owner = self;
	casing.lifetime_finished = time + 2;
	casing.touch = LMGbulletCasingTouch1;
	casing.th_die = SUB_Remove;
	casing.avelocity = '-200 -400 0'; //'0 -200 0'
	SUB_ChangeModel (casing, "progs/bullet_casing.mdl");
	
}