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

	if (self.pistol_ammo_count >= 10)
	{
		weaponanim_reloadpistol();
		return FALSE;
	}

	self.pistol_ammo_count++;

	if (self.pistol_ammo_count >= 10)
	{
		self.pistol_lastreload_time = time;
	}
	
	self.attack_finished = time + 0.3;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
			
	W_FirePistolRecoil(); //fancy tracers and all that
	
	// --------------------------------
	// Low Ammo Alert
	if 	(self.pistol_ammo_count ==  10) sound (self, CHAN_AUTO, "ammo_rattle.wav", 1, ATTN_NORM);
	else if (self.pistol_ammo_count ==  9) sound (self, CHAN_AUTO, "ammo_rattle.wav", 0.8, ATTN_NORM);
	else if (self.pistol_ammo_count ==  8) sound (self, CHAN_AUTO, "ammo_rattle.wav", 0.6, ATTN_NORM);	
	// --------------------------------

	self.weaponframe = 1;
	self.think = weaponanim_pistol_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_pistol_loop = {

	
	if (self.weaponframe == 2) Eject_BulletCasing();
	

	if (self.pistol_ammo_count >= 10 && time > (self.attack_finished - 0.1)) {
		
			weaponanim_reloadpistol(); 
			return;
		}

	
	if (self.weaponframe >= 21) {

			self.weaponframe = 0;
			return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_pistol_loop;
	self.nextthink = time + 0.025;
}
////////////////////////////////////////////////////////////////////////////////////////////////

void() weaponanim_reloadpistol = {
	if (self.think == weaponanim_reloadpistol_loop) { 
		return;
	}
	
	Drop_PistolMag();
	
	self.pistol_lastreload_time = time;

	self.nextthink1 = time + 1.5;
	
	sound (self, CHAN_AUTO, "gun_click.wav", 1, ATTN_NORM);

	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	
	self.weaponframe = 25;
	self.think = weaponanim_reloadpistol_loop;
	self.nextthink = time + 0.05;

}

void() weaponanim_reloadpistol_loop = {
	
	
	//if (self.weaponframe == 37) sound (self, CHAN_AUTO, "pistol_reload.wav", 1, ATTN_NORM);		
	if (self.weaponframe == 37) sound (self, CHAN_AUTO, "deadlock_reload.wav", 1, ATTN_NORM);		
	
	if (self.weaponframe >= 49)	self.pistol_ammo_count = 0; //RESET ammo
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
////////////////////////////////////////////////////////////////////////////////////////////////

void(float shotcount, vector dir, vector spread) FirePistolBullets =
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
			BulletImpact (20, direction);
		}
		
		if (trace_debug) dprint("bullet is over\n\n");
	}
}
//=============================================================================================

void() W_FirePistol =
{
	local vector dir;
	
	// for ai_nav:
	/*if (nav_w_nodeLink())
	{
		self.attack_finished = time + 0.5;
		return;
	}*/
	
	sound (self, CHAN_WEAPON, "pistol_shoot.wav", 1, ATTN_NORM);	

	self.punchangle_x = -1;
	makevectors(self.v_angle);
	
	dir = aim (self, AUTOAIM_DIST);

	ClearMultiDamage ();
	FirePistolBullets (1, dir, '0.02 0.02 0');
	
	ApplyMultiDamage ();
}
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

void() W_FirePistolRecoil =
{
	sound (self, CHAN_WEAPON, "pistol_shoot.wav", 1, ATTN_NORM);	
	
	makevectors (self.v_angle);
	
	vector org = self.origin + self.view_ofs - v_up * 8 + v_right *  8;
	
	vector dir = aim (self, 100000);
	vector spread;

	spread_x = 0.015; // horizontal
	spread_y = 0.015; // vertical
	spread_z = 0;
	
	traceline(org, org + v_forward * 16, FALSE, self);
		
	FireBullets2 (1, 20, org + v_forward * 16 * trace_fraction, dir, spread, 2, FALSE, 1);
		
		
	//----------------------------------------------------------------------------
	//bloodsnipe Q2 machinegun aimkick code
	/*
	makevectors(self.v_angle);
	
	local vector aimkick;	//player must re-aim each shot
	
	aimkick_x = -1 + (random() * -2);	//up
	aimkick_y = -0.5 + (random() * 2);	//right
	
	aimkick_z =  0;
	aimkick = aimkick + self.v_angle;
	
	msg_entity = self;
	WriteByte ( MSG_ONE, 10 );
	WriteAngle( MSG_ONE, aimkick_x );
	WriteAngle( MSG_ONE, aimkick_y );
	WriteAngle( MSG_ONE, aimkick_z );
	*/
	self.punchangle_x = -2;	//punch AFTER makevectors	
	
	//----------------------------------------------------------------------------
};

vector(float shotcount, float dmg, vector org, vector dir, vector spread, float centerbias, float penetrate, float showtracer) FireBullets2 =
{
	local	vector direction;
	//local vector plane_normal;
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
			
			if (showtracer == 1)		
						
			{drawTracer(org, direction, endpoint);}
			
		
		if (trace_fraction != 1.0) 
		{
			//plane_normal = trace_plane_normal;
			
			TraceAttack(dmg, direction, penetrate);
			
			//sound_bullet_woosh();

			//placebullethole(endpoint, plane_normal, ent_hit);
		}	
		shotcount = shotcount - 1;	
	}
	ApplyMultiDamage ();

	return direction;
};
//=============================================================================================

void() tracer_think = {
	if (time > self.attack_finished || self.frame >= 4) {
		remove(self);
		return;
	}
	self.frame++;
	self.nextthink = time + 0.02;
};

entity newmis;	//used for Alkaline style bullet tracer

void(vector org, vector direction, vector dest) drawTracer = {
	
	//if ((self.flags & FL_CLIENT) && !playertracers)
	//	return;
	float dist = vlen(org - dest);
	newmis = spawn();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_NOT;

	newmis.angles = vectoangles(direction);
	
	newmis.classname = "tracer";
	newmis.think = tracer_think;
	newmis.nextthink = time + 0.02;
	newmis.alpha = 0.4;
	
	newmis.velocity = direction * 1024;
	newmis.attack_finished = time + dist/7500;

	//setmodel (newmis, "progs/tracer_big_yellow.mdl");  //Precache model in WORLD.QC
	setmodel (newmis, "progs/tracer_long_yellow.mdl");
	setsize (newmis, '0 0 0', '0 0 0');
	setorigin (newmis, org);
};
////////////////////////////////////////////////////////////////////////////////////////////////
/*
void() sound_bullet_woosh =
{
	float r = random();
	if 	(r < 0.03)	sound (self, CHAN_AUTO, "bullet_woosh1.wav", 1, ATTN_NORM);
	else if (r < 0.06)	sound (self, CHAN_AUTO, "bullet_woosh2.wav", 1, ATTN_NORM);
	else if (r < 0.09)	sound (self, CHAN_AUTO, "bullet_woosh3.wav", 1, ATTN_NORM);
	else if (r < 0.12)	sound (self, CHAN_AUTO, "bullet_woosh4.wav", 1, ATTN_NORM);
	else if (r < 0.15)	sound (self, CHAN_AUTO, "bullet_woosh5.wav", 1, ATTN_NORM);
	else if (r < 0.18)	sound (self, CHAN_AUTO, "bullet_woosh6.wav", 1, ATTN_NORM);
	else if (r < 0.21)	sound (self, CHAN_AUTO, "bullet_woosh7.wav", 1, ATTN_NORM);
	else if (r < 0.24)	sound (self, CHAN_AUTO, "bullet_woosh8.wav", 1, ATTN_NORM);
	else if (r < 0.27)	sound (self, CHAN_AUTO, "bullet_woosh9.wav", 1, ATTN_NORM);
	else if (r < 0.30)	sound (self, CHAN_AUTO, "bullet_woosh10.wav", 1, ATTN_NORM);
	else if (r < 0.33)	sound (self, CHAN_AUTO, "bullet_woosh11.wav", 1, ATTN_NORM);
	else if (r < 0.36)	sound (self, CHAN_AUTO, "bullet_woosh12.wav", 1, ATTN_NORM);
}
*/
////////////////////////////////////////////////////////////////////////////////////////////////

void(float damage, vector dir, float penetrate) TraceAttack =
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
			TraceAttack(damage, dir, FALSE);
			//placebullethole(trace_endpos, trace_plane_normal, trace_ent);
		}
		//else dprint("Trace penetrated\n");
	}
		
};
////////////////////////////////////////////////////////////////////////////////////////////////

float(float runs) weighted_crandom = {
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

void() DropMagTouch2 =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	self.avelocity = '0 0 0';
}
void() DropMagTouch1 =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	sound (self, CHAN_AUTO, "mag_drop.wav", 0.1, ATTN_NORM);	// drop sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
	self.touch = DropMagTouch2;
}
entity(vector org, vector vel) launch_dropmag =
{
	entity grenade;
	
	grenade = toss_projectile(org, vel, "grenade");
	grenade.lifetime_finished = time + 2;
	
	grenade.avelocity = '0 -300 0'; //'0 -200 0'
	
	SUB_ChangeModel (grenade, "progs/pistol_mag.mdl");
	
	return grenade;
}
void() Drop_PistolMag =
{
	entity g;
	vector gvel;
		
	makevectors (self.v_angle);
	if (self.v_angle_x)
		
		gvel = (v_forward * 120) +(v_right * 240) + (v_up * 40);

	else
	{
		gvel = aim(self, AUTOAIM_DIST);
		gvel = gvel * 120;
		gvel_z = 40;
	}
	
	
	vector drop_mag;
	drop_mag = self.origin + self.view_ofs + (v_forward * 8) + (v_right * 12) + (v_up * -24);
	
	
	g = launch_dropmag(drop_mag, gvel);
	g.touch = DropMagTouch1;
	g.th_die = SUB_Remove;
}
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

void() BulletCasingTouch2 =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	self.avelocity = '0 0 0';
}
void() BulletCasingTouch1 =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	//sound (self, CHAN_AUTO, "tink.wav", 0.1, ATTN_NORM);	// drop sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
	self.touch = BulletCasingTouch2;
}
entity(vector org, vector vel) launch_bulletcasing =
{
	entity grenade;
	
	grenade = toss_projectile(org, vel, "grenade");
	grenade.lifetime_finished = time + 2;
	
	grenade.avelocity = '-200 -400 0'; //'0 -200 0'
	
	SUB_ChangeModel (grenade, "progs/bullet_casing.mdl");
	
	return grenade;
}
void() Eject_BulletCasing =
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
	
	
	g = launch_bulletcasing(eject_org, gvel);
	g.touch = BulletCasingTouch1;
	g.th_die = SUB_Remove;
}
