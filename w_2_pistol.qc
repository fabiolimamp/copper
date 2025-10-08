////////////////////////////////////////////////////////////////////////////////////////////////
// tracers and bullet code by bmFbr, edits by Kebby
////////////////////////////////////////////////////////////////////////////////////////////////



float() weaponanim_pistol = {
		
	if (self.attack_finished > time)
		return FALSE;

	// detects if a reload is still happening without having to rely on attack_finished
	if (self.think == weaponanim_reloadpistol_loop) { 
		return FALSE;
	}

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon());
		return FALSE;
	}

	if (self.pistol_ammo_count <= 0)
	{
		weaponanim_reloadpistol();
		return FALSE;
	}
	
	self.weaponreload_perc = 0;
	self.pistol_ammo_count--;

	self.currentammo = self.pistol_ammo_count;

	if (self.pistol_ammo_count <= 0)
	{
		self.pistol_lastreload_time = time;
	}
	
	self.attack_finished = time + 0.3;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
			
	W_FirePistol(); //fancy tracers and all that
	
	// --------------------------------
	// Low Ammo Alert
	if 	(self.pistol_ammo_count ==  0) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 1, ATTN_NORM);
	else if (self.pistol_ammo_count ==  1) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.8, ATTN_NORM);
	else if (self.pistol_ammo_count ==  2) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.6, ATTN_NORM);	
	// --------------------------------

	self.weaponframe = 1;
	self.think = weaponanim_pistol_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_pistol_loop = {	
	if (self.weaponframe == 2) Eject_BulletCasing();
	
	if (self.pistol_ammo_count <= 0 && time > (self.attack_finished - 0.1))
	{
		weaponanim_reloadpistol(); 
		return;
	}

	
	if (self.weaponframe >= 21)
	{
		self.weaponframe = 0;
		return;
	}
	else
	{
		self.weaponframe++;
	}

	self.think = weaponanim_pistol_loop;
	self.nextthink = time + 0.025;
}

//=====================================================================================================================

void() weaponanim_reloadpistol = {
	if (self.think == weaponanim_reloadpistol_loop) { 
		return;
	}
	
	Drop_PistolMag();
	
	self.pistol_lastreload_time = time;

	self.nextthink1 = time + 1.5;
	
	sound (self, CHAN_AUTO, "pistol/gun_click.wav", 1, ATTN_NORM);

	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.weaponreload_perc = 1/24;

	self.weaponframe = 25;
	self.think = weaponanim_reloadpistol_loop;
	self.nextthink = time + 0.05;

}

void() weaponanim_reloadpistol_loop = {
	
	
	if (self.weaponframe == 37) sound (self, CHAN_AUTO, "pistol/deadlock_reload.wav", 1, ATTN_NORM);		
	
	
	if (self.weaponframe >= 49)
	{
		self.pistol_ammo_count = 10; //RESET ammo
		self.weaponreload_perc = 0;
	}
	else
		self.weaponreload_perc = min(self.weaponreload_perc + 1/24, 1);



	self.currentammo = self.pistol_ammo_count;
	//if (time >= self.attack_finished - 0.05) self.pistol_ammo_count = 0; //RESET ammo

	if (self.weaponframe >= 54) {
		self.weaponframe = 0;
		self.think = SUB_Null;
		return;
	}
	else {
		self.weaponframe++;
	}

	if (time >= self.nextthink1) {
		self.weaponframe = 54;
	}

	self.think = weaponanim_reloadpistol_loop;
	self.nextthink = time + 0.05;

}

//=====================================================================================================================

void() W_FirePistol =
{
	sound (self, CHAN_WEAPON, "pistol/pistol_shoot.wav", 1, ATTN_NORM);	
	
	makevectors (self.v_angle);
	
	vector org = self.origin + self.view_ofs - v_up * 8 + v_right *  8;
	
	vector spread;

	spread_x = 0.015; // horizontal
	spread_y = 0.015; // vertical
	spread_z = 0;
	
	// aim point directly in front of the crosshair
	traceline(self.origin + self.view_ofs, self.origin + self.view_ofs + v_forward * 10000, FALSE, self);

	vector dir = normalize(trace_endpos - org);
		
	ClearMultiDamage ();
	FirePistolBullets (1, 20, org + v_forward * 16 * trace_fraction, dir, spread);
	
	ApplyMultiDamage ();
		
	self.punchangle_x = -2;	//punch AFTER makevectors
	
};

void(float shotcount, float dmg, vector org, vector dir, vector spread) FirePistolBullets =
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

//=====================================================================================================================

void() tracer_think = {
	if (time > self.attack_finished || self.frame >= 4) {
		remove(self);
		return;
	}
	self.frame++;
	self.nextthink = time + 0.02;
};

void(vector org, vector direction, vector dest) drawTracer = {
	
	float dist = vlen(org - dest);
	entity tracer = spawn();
	tracer.owner = self;
	tracer.movetype = MOVETYPE_FLY;
	tracer.solid = SOLID_NOT;

	tracer.angles = vectoangles(direction);
	
	tracer.classname = "tracer";
	tracer.think = tracer_think;
	tracer.nextthink = time + 0.02;
	tracer.alpha = 0.4;
	
	tracer.velocity = direction * 1024;
	tracer.attack_finished = time + dist/7500;

	//setmodel (tracer, "progs/tracer_big_yellow.mdl");  //Precache model in WORLD.QC
	setmodel (tracer, "progs/tracer_long_yellow.mdl");
	setsize (tracer, '0 0 0', '0 0 0');
	setorigin (tracer, org);
};

//=====================================================================================================================

void() DropMagTouch2 =
{
	if (CheckProjectilePassthru()) return;

	self.avelocity = '0 0 0';
}

void() DropMagTouch1 =
{
	if (CheckProjectilePassthru()) return;

	sound (self, CHAN_AUTO, "pistol/mag_drop.wav", 0.1, ATTN_NORM);	// drop sound

	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';

	self.touch = DropMagTouch2;
}

void() Drop_PistolMag =
{
	makevectors (self.v_angle);

	vector vel = (v_forward * 120) + (v_right * 240) + (v_up * 40);
	vector org = self.origin + self.view_ofs + (v_forward * 8) + (v_right * 12) + (v_up * -24);
	
	entity mag = toss_projectile(org, vel, "pistolmag");
	mag.lifetime_finished = time + 2;
	mag.touch = DropMagTouch1;
	mag.th_die = SUB_Remove;
	mag.owner = self;
	mag.avelocity = '0 -300 0'; //'0 -200 0'
	
	SUB_ChangeModel (mag, "progs/pistol_mag.mdl");
}

//=====================================================================================================================

void() BulletCasingTouch2 =
{
	if (CheckProjectilePassthru()) return;

	self.avelocity = '0 0 0';
}

void() BulletCasingTouch1 =
{
	if (CheckProjectilePassthru()) return;

	//sound (self, CHAN_AUTO, "tink.wav", 0.1, ATTN_NORM);	// drop sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
	self.touch = BulletCasingTouch2;
}


void() Eject_BulletCasing =
{
	makevectors(self.v_angle);
	vector vel = v_forward * 100 + v_right * (200 + 60*random()) + v_up * (60 + 30 * random());
	vector org = self.origin + self.view_ofs + (v_forward * 32) + (v_right * 12) + (v_up * -12);
	
	entity casing = toss_projectile(org, vel, "casing");
	casing.owner = self;
	casing.lifetime_finished = time + 2;
	casing.touch = BulletCasingTouch1;
	casing.th_die = SUB_Remove;
	//casing.avelocity = '-200 -400 0'; //'0 -200 0'
	casing.avelocity = [-170 - crandom()*60, -370 - crandom() * 60, 0];
	SUB_ChangeModel (casing, "progs/bullet_casing.mdl");
	
}
