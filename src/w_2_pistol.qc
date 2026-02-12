//=============================================================================================
// tracers and bullet code by bmFbr, edits by Kebby
//=============================================================================================
/*
	Stechkin Pistol
	{0-91}
	v_pistol
	
	0  idle
	1-10  draw > idle
	11-30  fire > idle
	34-64  reload > idle
	65-91  twirl > idle
	
	MD3
	v_pistol_gloves
	v_pistol
	v_pistol_muzz
*/
//=============================================================================================

float() weaponanim_pistol =
{
	if (self.attack_finished > time)
		return FALSE;

	// detects if a reload is still happening without having to rely on attack_finished
	if (self.think == weaponanim_reloadpistol_loop) 
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
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
	else if (self.pistol_ammo_count ==  1) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.85, ATTN_NORM);
	else if (self.pistol_ammo_count ==  2) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.7, ATTN_NORM);	
	else if (self.pistol_ammo_count ==  3) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.55, ATTN_NORM);	
	// --------------------------------

	self.weaponframe = 11;
	
	self.think = weaponanim_pistol_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_pistol_loop =
{	
	if (self.weaponframe == 12) Eject_BulletCasing();
	
	if (self.pistol_ammo_count <= 0 && time > (self.attack_finished - 0.1))
	{
		weaponanim_reloadpistol(); 
		return;
	}
	
	if (self.weaponframe >= 31)
	{
		self.weaponframe = 10;
		return;
	}
	else	self.weaponframe++;

	self.think = weaponanim_pistol_loop;
	self.nextthink = time + 0.025;
}
//=====================================================================================================================

void() weaponanim_draw_pistol =
{		
	sound (self, CHAN_AUTO, "pistol/gun_click.wav", 0.25, ATTN_NORM);	// Pistol draw sfx
	
	sound (self, CHAN_AUTO, "misc/draw1.wav", 0.1, ATTN_NORM);
	
	self.weaponframe = 1;
	
	self.think = weaponanim_draw_loop; // weapons_use.qc
	self.nextthink = time + 0.033;
}


//=====================================================================================================================

void() weaponanim_reloadpistol =
{
	if (self.think == weaponanim_reloadpistol_loop) 
		return;
	
	Drop_PistolMag();
	
	self.pistol_lastreload_time = time;

	self.nextthink1 = time + 1.5;
	
	sound (self, CHAN_AUTO, "pistol/gun_click.wav", 1, ATTN_NORM);

	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.weaponreload_perc = 1/24;

	self.weaponframe = 35;
	
	self.think = weaponanim_reloadpistol_loop;
	self.nextthink = time + 0.05;
}

void() weaponanim_reloadpistol_loop =
{	
	if (self.weaponframe == 47) sound (self, CHAN_AUTO, "pistol/deadlock_reload.wav", 1, ATTN_NORM);		
		
	if (self.weaponframe >= 59)
	{
		self.pistol_ammo_count = 10; //RESET ammo
		self.weaponreload_perc = 0;
	}
	else	self.weaponreload_perc = min(self.weaponreload_perc + 1/24, 1);

	self.currentammo = self.pistol_ammo_count;

	if (self.weaponframe >= 64) {
		self.weaponframe = 0;
		self.think = SUB_Null;
		return;
	}
	else 	self.weaponframe++;

	if (time >= self.nextthink1)
		self.weaponframe = 64;

	self.think = weaponanim_reloadpistol_loop;
	self.nextthink = time + 0.05;
}

//=====================================================================================================================

void() W_FirePistol =
{
	sound (self, CHAN_AUTO, "pistol/pistol_fire.wav", 0.6, ATTN_NORM);
	sound_pistol_fire(0.3);
	
	makevectors (self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  8;
	vector org_eye = self.origin + self.view_ofs;
	vector spread;

	spread_x = 0.015; // horizontal
	spread_y = 0.015; // vertical
	spread_z = 0;
	
	// aim point directly in front of the crosshair
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
		
	ClearMultiDamage ();
	FirePistolBullets (1, 20, org_eye, org_gun + v_forward * 32 * trace_fraction, dir_eye, spread, 2, TRUE);
	
	ApplyMultiDamage ();
	self.punchangle_x = -2;	//punch AFTER makevectors
};

//=====================================================================================================================

void(float pistolfire_volume) sound_pistol_fire =
{
	local float r = floor(random()*4);
	if 	(r == 0)	sound (self, CHAN_AUTO, "pistol/pistol_fire1.wav", pistolfire_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "pistol/pistol_fire2.wav", pistolfire_volume, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_AUTO, "pistol/pistol_fire3.wav", pistolfire_volume, ATTN_NORM);
	else 			sound (self, CHAN_AUTO, "pistol/pistol_fire4.wav", pistolfire_volume, ATTN_NORM);
}
//=============================================================================================

void(float shotcount, float dmg, vector shot_org, vector tracer_org, vector dir, vector spread, float centerbias, float tracer) FirePistolBullets =
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
		src = shot_org;
		direction = dir + weighted_crandom(centerbias)*spread_x*rt + weighted_crandom(centerbias)*spread_y*up;
		
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
				//drawTracer(tracer_org, trace_endpos);
				
				Draw_Tracertrail(self, tracer_org + v_forward * 24 + v_right * 4 + v_up * -4, trace_endpos, 0);
								
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
				
				placebullethole(trace_endpos, trace_plane_normal, trace_ent);

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

void(float pistolhit_volume) sound_bullet_hit_enemy =
{
	local float r = floor(random()*4);
	if 	(r == 0)	sound (self, CHAN_AUTO, "impact/bullet_impact1.wav", pistolhit_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "impact/bullet_impact2.wav", pistolhit_volume, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_AUTO, "impact/bullet_impact3.wav", pistolhit_volume, ATTN_NORM);
	else 			sound (self, CHAN_AUTO, "impact/bullet_impact4.wav", pistolhit_volume, ATTN_NORM);
}
//=============================================================================================

void(float pistolhitmetal_volume) sound_bullet_hit_metal =
{
	local float r = floor(random()*4);
	if 	(r == 0)	sound (self, CHAN_AUTO, "impact/bullet_metal1.wav", pistolhitmetal_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "impact/bullet_metal2.wav", pistolhitmetal_volume, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_AUTO, "impact/bullet_metal3.wav", pistolhitmetal_volume, ATTN_NORM);
	else 			sound (self, CHAN_AUTO, "impact/bullet_metal4.wav", pistolhitmetal_volume, ATTN_NORM);
}
//=============================================================================================

void(vector org, float pistolric_volume) sound_pistol_ricochet =
{
	local entity playspot = spawn();
	setorigin (playspot, org);

	local float r = floor(random()*5);
	if 	(r == 0)	sound (playspot, CHAN_AUTO, "impact/ric1.wav", pistolric_volume, ATTN_NORM);
	else if (r == 1)	sound (playspot, CHAN_AUTO, "impact/ric2.wav", pistolric_volume, ATTN_NORM);
	else if (r == 2)	sound (playspot, CHAN_AUTO, "impact/ric3.wav", pistolric_volume, ATTN_NORM);
	else if (r == 3)	sound (playspot, CHAN_AUTO, "impact/ric4.wav", pistolric_volume, ATTN_NORM);
	else 			sound (playspot, CHAN_AUTO, "impact/ric5.wav", pistolric_volume, ATTN_NORM);
	
	remove(playspot);
}
//=============================================================================================

void() tracer_think = {
	if (time > self.attack_finished || self.frame >= 4) {
		remove(self);
		return;
	}
	self.frame++;
	self.nextthink = time + 0.02;
};

void(vector org, vector dest) drawTracer = {
	
	float dist = vlen(org - dest);
	vector direction = normalize(dest - org);

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

	sound (self, CHAN_AUTO, "pistol/mag_drop.wav", 0.3, ATTN_NORM);	// drop sound

	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';

	self.touch = DropMagTouch2;
}

void() Drop_PistolMag =
{
	if (intermission) return;
	
	makevectors (self.v_angle);

	vector vel = (v_forward * 120) + (v_right * 240) + (v_up * 40);
	vector org = self.origin + self.view_ofs + (v_forward * 8) + (v_right * 12) + (v_up * -24);
	
	entity mag = toss_projectile(org, vel, "pistolmag");
	mag.lifetime_finished = time + 2;
	mag.touch = DropMagTouch1;
	mag.th_die = CasingFade;
	mag.alpha = 1;
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

	sound (self, CHAN_AUTO, "pistol/casing.wav", 0.8, ATTN_NORM);	// drop sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
	self.touch = BulletCasingTouch2;
}

void() Eject_BulletCasing =
{
	if (intermission) return;	
	
	makevectors(self.v_angle);
	vector vel = v_forward * 100 + v_right * (200 + 60*random()) + v_up * (60 + 30 * random());
	vector org = self.origin + self.view_ofs + (v_forward * 32) + (v_right * 12) + (v_up * -12);
	
	entity casing = toss_projectile(org, vel, "casing");
	casing.owner = self;
	casing.lifetime_finished = time + 2;
	casing.touch = BulletCasingTouch1;
	casing.th_die = CasingFade;
	casing.alpha = 1;
	//casing.avelocity = '-200 -400 0'; //'0 -200 0'
	casing.avelocity = [-170 - crandom()*60, -370 - crandom() * 60, 0];
	SUB_ChangeModel (casing, "progs/bullet_casing.mdl");
	
}

void() CasingFade =
{
	self.alpha -= 0.025;
	
	if (self.alpha <= 0)
	{
		remove(self);
		return;
	}

	self.think = CasingFade;
	self.nextthink = time + 0.05;
}

//=====================================================================================================================
void() weaponanim_twirlpistol =
{	
	if (self.attack_finished > time)
		return;
	
	sound (self, CHAN_OTHER, "weapons/ax1.wav", 1, ATTN_NORM);
	//sound (self, CHAN_OTHER, "impact/wrench_swing.wav", 1, ATTN_NORM);

	if (self.weaponframe >= 66 && self.weaponframe <= 80)
		self.weaponframe = 68;
	
	else	self.weaponframe = 66;
	
	self.attack_finished = time + 0.1;
	
	self.think = weaponanim_twirlpistol_loop;
	self.nextthink = time + 0.05;
}

void() weaponanim_twirlpistol_loop =
{
	if (self.weaponframe == 82) sound (self, CHAN_AUTO, "pistol/gun_click.wav", 0.5, ATTN_NORM);

	if (self.weaponframe >= 91)
	{
		self.weaponframe = 0;
		self.think = SUB_Null;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_twirlpistol_loop;
	self.nextthink = time + 0.05;
}