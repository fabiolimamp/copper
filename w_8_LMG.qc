////////////////////////////////////////////////////////////////////////////////////////////////
// LMG_tracers and LMGbullet code by bmFbr, edits by Kebby
////////////////////////////////////////////////////////////////////////////////////////////////

//used in W_WeaponFrame, couldn't figure out a way to handle it from here
//TODO: cleanup
void() LMG_reset = {

	if (self.LMG_rof > 1)
		self.LMG_rof -= 0.01;
	else
		self.LMG_rof = 1;

	if (self.LMG_spread > 0)
		self.LMG_spread -= 0.05;
	else
		self.LMG_spread = 0;

	if (self.lip > 15)
		self.lip -= 0.05;
	else
		self.lip = 15;
	
	//dprint5("\bDamage\b: ",ftos(self.lip), "\n\bROF\b: ", ftos(self.LMG_rof), "\n");
	
}

float() weaponanim_LMG = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon());
		return FALSE;
	}

	self.currentammo = self.ammo_cells = self.ammo_cells - 1;

	dprint("\bDamage\b: ");
	dprint(ftos(self.lip));
	dprint("\n\bROF\b: ");
	dprint(ftos(self.LMG_rof));
	dprint("\n");

	if (!self.LMG_rof)
		self.LMG_rof = 1;

	self.attack_finished = time + (0.3 / self.LMG_rof);
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	W_FireLMGRecoil(); //fancy LMG_tracers and all that

	self.weaponframe = 1;
	self.think = weaponanim_LMG_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

float(float rof) LMG_increaserof = {
	if (rof <= 3.6)
		return rof + 0.1;
	else
		return 3.6;
}

float(float spread) LMG_increasespread = {
	if (spread <= 0.1)
		return spread + 0.003;
	else
		return 0.1;
}

float(float dmg) LMG_increasedamage = {
	if (dmg <= 40)
		return dmg + 1.2;
	else
		return 40;
}

void() weaponanim_LMG_loop = {

	
	if (self.weaponframe == 2) Eject_LMGbulletCasing();

	if (self.weaponframe == 2) {
		self.LMG_rof = LMG_increaserof(self.LMG_rof);
		self.LMG_spread = LMG_increasespread(self.LMG_spread);
		self.lip = LMG_increasedamage(self.lip);
	}
	
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
////////////////////////////////////////////////////////////////////////////////////////////////

void(float shotcount, vector dir, vector spread) FireLMGLMGbullets =
{
	vector src, direction;
	entity ig;
	float s, lim;
	
	if (shotcount <= 0) return;
	
	makevectors(self.v_angle);

	if (trace_debug) dprint3("*** firing ", ftos(shotcount), " LMGbullets *\n\n");
	for (s = 0; s < shotcount; s++)
	{
		src = self.origin + v_forward*10;
		src_z = self.absmin_z + self.size_z * 0.7;
		direction = SpreadVector(dir, spread);
		
		if (trace_debug) dprint("* firing a LMGbullet *\n");
		
		lim = 0;
		// check for trace-through cases
		for (ig = self; ig != world; lim++)	// ig == world if we hit a wall or hit nothing
		{
			traceline2(src, src + direction*2048, ig, 0);
			
			if (trace_ent == self)
				return;	// some notrace shit happened
		
			// if we've already pelted a monster enough to kill it, let additional LMGbullets add 
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
				if (trace_debug) dprint3("LMGbullet hit ", ig.classname, ", continuing thru\n");
			}
			else
			{
				if (trace_debug) dprint("LMGbullet reached world\n");
				ig = world;
			}
			if (lim > 8)
			{
				dprint("LMGbullet pen limit exceeded\n");
				break;
			}
		}
		
		if (trace_fraction != 1.0)
		{
			BulletImpact (20, direction);
		}
		
		if (trace_debug) dprint("LMGbullet is over\n\n");
	}
}
//=============================================================================================

void() W_FireLMGRecoil =
{
	sound (self, CHAN_WEAPON, "pistol_shoot.wav", 1, ATTN_NORM);	
	
	makevectors (self.v_angle);
	
	vector org = self.origin + self.view_ofs - v_up * 8;
	
	vector dir = aim (self, 100000);
	vector spread;

	spread = [self.LMG_spread, self.LMG_spread, 0];
	
	traceline(org, org + v_forward * 16, FALSE, self);
		
	FireLMGbullets2 (1, self.lip, org + v_forward * 16 * trace_fraction, dir, spread, 2, FALSE, 1);
	self.punchangle_x = -1;	//punch AFTER makevectors	
	
	//----------------------------------------------------------------------------
};

vector(float shotcount, float dmg, vector org, vector dir, vector spread, float centerbias, float penetrate, float showLMG_tracer) FireLMGbullets2 =
{
	local	vector direction;
	//local vector plane_normal;
	vector endpoint;
	entity ent_hit;
	//float LMGbullet;

	vector angs = vectoangles(dir);
	makevectors([-angs_x, angs_y, angs_z]);

	vector rt = v_right;
	vector up = v_up;


	//ClearMultiDamage();
	while (shotcount > 0)
	{
		direction = dir + weighted_crandom_lmg(centerbias)*spread_x*rt + weighted_crandom_lmg(centerbias)*spread_y*up;

		traceline (org, org + direction*2048, FALSE, self);
		endpoint = trace_endpos;
		ent_hit = trace_ent;

		if (!(vlen(org - trace_endpos) < 128 && ent_hit.solid == SOLID_BSP))
			
			if (showLMG_tracer == 1)		
						
			{drawLMG_tracer(org, direction, endpoint);}
			
		
		if (trace_fraction != 1.0) 
		{
			//plane_normal = trace_plane_normal;
			
			LMGTraceAttack(dmg, direction, penetrate);
			
			//sound_LMGbullet_woosh();

			//placeLMGbullethole(endpoint, plane_normal, ent_hit);
		}	
		shotcount = shotcount - 1;	
	}
	ApplyMultiDamage ();

	return direction;
};
//=============================================================================================

void() LMG_tracer_think = {
	if (time > self.attack_finished || self.frame >= 4) {
		remove(self);
		return;
	}
	self.frame++;
	self.nextthink = time + 0.02;
};

entity newmis;	//used for Alkaline style LMGbullet LMG_tracer

void(vector org, vector direction, vector dest) drawLMG_tracer = {
	
	//if ((self.flags & FL_CLIENT) && !playerLMG_tracers)
	//	return;
	float dist = vlen(org - dest);
	newmis = spawn();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_NOT;

	newmis.angles = vectoangles(direction);
	
	newmis.classname = "LMG_tracer";
	newmis.think = LMG_tracer_think;
	newmis.nextthink = time + 0.02;
	newmis.alpha = 0.4;
	
	newmis.velocity = direction * 1024;
	newmis.attack_finished = time + dist/7500;

	//setmodel (newmis, "progs/LMG_tracer_big_yellow.mdl");  //Precache model in WORLD.QC
	setmodel (newmis, "progs/tracer_long_yellow.mdl");
	setsize (newmis, '0 0 0', '0 0 0');
	setorigin (newmis, org);
};

void(float damage, vector dir, float penetrate) LMGTraceAttack =
{
	local	vector	vel, org;
	
	org = trace_endpos - dir*4;
	//dprint3("Trace hit: ", trace_ent.classname, "\n");
	


	if ((trace_ent.flags & (FL_MONSTER + FL_CLIENT) && trace_ent.deadflag > 0) || trace_ent.takedamage)	
	{
		vel = normalize(dir + v_up*crandom() + v_right*crandom());
		vel = vel + 2*trace_plane_normal;
		vel = vel * 200;

		ImpactSpawn(org, vel*0.2, damage);
	}
	else
		gunshot(org);
	

	if (trace_ent.takedamage) 
		AddMultiDamage (trace_ent, damage);
		
	if (
		penetrate &&
		trace_ent.flags & (FL_MONSTER + FL_CLIENT) &&
		(
			( trace_ent.health - trace_ent.multi_dmg <= 0)
			|| trace_ent.deadflag > 0
		)
	){
		//dprint2(ftos(trace_ent.flags & (FL_MONSTER + FL_CLIENT)), "\n");
		traceline (trace_endpos + dir*4, trace_endpos + dir*2048, FALSE, trace_ent);
		if (trace_fraction != 1.0) {
			//dprint3("Trace penetrated hit: ", trace_ent.classname, "\n");
			LMGTraceAttack(damage, dir, FALSE);
			//placeLMGbullethole(trace_endpos, trace_plane_normal, trace_ent);
		}
		//else dprint("Trace penetrated\n");
	}
		
};
////////////////////////////////////////////////////////////////////////////////////////////////

float(float runs) weighted_crandom_lmg = {
    float ret = 0;
    for (float i = 0; i < runs; i++) {
        ret += random() * 1/runs;
    }
    return 2*(ret - 0.5);
}
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

void() LMGbulletCasingTouch2 =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	self.avelocity = '0 0 0';
}
void() LMGbulletCasingTouch1 =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	//sound (self, CHAN_AUTO, "tink.wav", 0.1, ATTN_NORM);	// drop sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
	self.touch = LMGbulletCasingTouch2;
}
entity(vector org, vector vel) launch_LMGbulletcasing =
{
	entity grenade;
	
	grenade = toss_projectile(org, vel, "grenade");
	grenade.lifetime_finished = time + 2;
	
	grenade.avelocity = '-200 -400 0'; //'0 -200 0'
	
	SUB_ChangeModel (grenade, "progs/bullet_casing.mdl");
	
	return grenade;
}
void() Eject_LMGbulletCasing =
{
	entity g;
	vector gvel;
		
	makevectors (self.v_angle);
	if (self.v_angle_x)
		
		gvel = (v_forward * 100) + (v_right * 240) + (v_up * 80);

	else
	{
		gvel = aim(self, AUTOAIM_DIST);
		gvel = gvel * 200;
		gvel_z = 40;
	}
	
	
	vector eject_org;
	eject_org = self.origin + self.view_ofs + (v_forward * 32) + (v_right * 12) + (v_up * -12);
	
	
	g = launch_LMGbulletcasing(eject_org, gvel);
	g.touch = LMGbulletCasingTouch1;
	g.th_die = SUB_Remove;
}