//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	ash_NAME	=	"ASh-12";
string	ash_MODEL	=	"progs/placeholder_progs/wish/v_ash.mdl";

//=============================================================================================
	
	
	float	ash_ROF		=	0.12;	//0.06;		//seconds post-fire
	
	float	ash_DMG 	=	25;	//15;	// 9	//damage per shot

	float	ash_COST	=	2;		//ammo cost to fire
	
	
	// UNUSED WITH THE MUZZLE BLOOM CODE... SCROLL TO BOTTOM!!!
	/*
	vector	ASh_SPREAD		=	'0.01 0.01 0';
	float	ASh_SPREAD_WIDTH	=	0.02;
	float	ASh_SPREAD_RISE		=	0.08;
	*/

//=============================================================================================


float() weaponanim_ash =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}
	
	self.currentammo = self.ammo_nails = self.ammo_nails - ash_COST;

	self.attack_finished = time + ash_ROF;
	
	//SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	

	W_Fire_ash();
	
	
	self.punchangle_x = -1;
	self.effects |= EF_MUZZLEFLASH;
	

	self.weaponframe = 11;
	self.think = weaponanim_ash_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_ash_loop =
{
	if (self.weaponframe == 12)	Eject_BulletCasing_ash();
	
	if (self.weaponframe >= 30)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_ash_loop;
	self.nextthink = time + 0.025;
}
////////////////////////////////////////////////////////////////////////////////////////////////

.float 	shotcount, lastshot;


void() W_Fire_ash =
{
	vector dir, finaldir, org, definespread;
	makevectors (self.v_angle);


	org = self.origin + self.view_ofs - v_up* 8 + v_right* 6;	// HIP	
		
	local float r = floor(random()*3);
	if 	(r == 0)	sound (self, CHAN_WEAPON, "placeholder_sound/ash_fire.wav", 1, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_WEAPON, "placeholder_sound/ash_fire2.wav", 1, ATTN_NORM);
	else 			sound (self, CHAN_WEAPON, "placeholder_sound/ash_fire3.wav", 1, ATTN_NORM);	

	local float r2 = floor(random()*3);
	if 	(r2 == 0)	sound (self, CHAN_AUTO, "placeholder_sound/ash_fire4.wav", 1, ATTN_NORM);
	else if (r2 == 1)	sound (self, CHAN_AUTO, "placeholder_sound/ash_fire5.wav", 1, ATTN_NORM);
	else 			sound (self, CHAN_AUTO, "placeholder_sound/ash_fire6.wav", 1, ATTN_NORM);	

	sound_pistol_fire(1);

	dir = aim (self, 10000);
	traceline(org, org + v_forward* 16, FALSE, self);
		
		
		if (time < self.lastshot + 0.2) self.shotcount = min(self.shotcount + 1, 8);						// larger # = higher max shotcount multiplier	+ 1, #); 
		else self.shotcount = max(0, self.shotcount - rint((time - self.lastshot - 0.01)/0.01));				// smaller # = faster time to reduce shotcount	- 0.#)/0.#));
				
		definespread = [self.shotcount* 0.04 + 0.02, self.shotcount* 0.08 + 0.06, 0]* (0.2);					// ['+right, +up, 0'] * (adjustment multiplier)
			
		vector dir_skew = dir + v_right* ((self.shotcount* -0.005) +0.005) + v_up* ((self.shotcount* 0.01) + 0.01);		// (right, up) muzzle rise * shotcount


	finaldir = FireBullets_ash (1, ash_DMG, org + v_forward* 8 *trace_fraction + (v_up * -0.2 * self.shotcount), dir_skew, definespread, 8);
	
				
	//--------------------------------------- MUZZLE RISER
		self.lastshot = time;
	if 	(self.shotcount <= 8) 	self.punchangle_x = -1;
	else if (self.shotcount >  8) 	self.punchangle_x = -2;

	float initialang = vectoyaw2(dir);
	float finalang = vectoyaw2(finaldir);
	float dif = anglemod180(initialang) - anglemod180(finalang);
	if (dif > 180) dif -= 360;
	else if (dif < -180) dif += 360;
	
	
	//--------------------------------------- CAMERA KICK
	makevectors(self.v_angle);
	local vector aimkick;

		aimkick_x = ( -0.8 );		// up
		aimkick_y = ( 0.5 *random());	// right
	
	aimkick = aimkick + self.v_angle;
	msg_entity = self;
	WriteByte ( MSG_ONE, 10 );
	WriteAngle( MSG_ONE, aimkick_x );
	WriteAngle( MSG_ONE, aimkick_y );
	WriteAngle( MSG_ONE, aimkick_z );
	makevectors(self.v_angle);
};

////////////////////////////////////////////////////////////////////////////////////////////////
/*
void() W_Fire_ASh =	//OLD
{
	vector dir, finaldir, org, definespread;
	makevectors (self.v_angle);


		org = self.origin + self.view_ofs - v_up* 8 + v_right* 6;	// HIP	
			
		sound (self, CHAN_AUTO, "wish/tommy_fire2.wav", 1, ATTN_NORM);
		

	dir = aim (self, 10000);
	traceline(org, org + v_forward* 16, FALSE, self);
		
	
	
		if (time < self.lastshot + 0.2) self.shotcount = min(self.shotcount + 1, 30);						// larger # = higher max shotcount multiplier	+ 1, #); 
		else self.shotcount = max(0, self.shotcount - rint((time - self.lastshot - 0.01)/0.01));				// smaller # = faster time to reduce shotcount	- 0.#)/0.#));
		
		
		definespread = [self.shotcount* 0.075 + 0.05, self.shotcount* 0.05 + 0.05, 0]* (0.25);					// ['+right, +up, 0'] * (adjustment multiplier)
			
	
		vector dir_skew = dir + v_right* ((self.shotcount* -0.001) -0.001) + v_up* ((self.shotcount* 0.01) + 0.01);		// (right, up) muzzle rise * shotcount



	finaldir = FireBullets_ASh (1, ASh_DMG, org + v_forward* 8 *trace_fraction, dir_skew, definespread, 8);
	
	
		
	//--------------------------------------- MUZZLE RISER
		self.lastshot = time;
	if 	(self.shotcount <= 8) 	self.punchangle_x = -1;
	else if (self.shotcount >  8) 	self.punchangle_x = -2;

	float initialang = vectoyaw2(dir);
	float finalang = vectoyaw2(finaldir);
	float dif = anglemod180(initialang) - anglemod180(finalang);
	if (dif > 180) dif -= 360;
	else if (dif < -180) dif += 360;
	
	
	//--------------------------------------- CAMERA KICK
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
};
*/
////////////////////////////////////////////////////////////////////////////////////////////////

vector(float shotcount, float dmg, vector org, vector dir, vector spread, float centerbias) FireBullets_ash =
{
	local vector direction;
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

		//if (!(vlen(org - trace_endpos) < 128 && ent_hit.solid == SOLID_BSP))
			//drawTracer(org, endpoint);
				
		
		if (trace_fraction != 1.0) {
			
			//TraceAttack(dmg, direction, penetrate);
			BulletImpact (dmg, direction);

			placebullethole(trace_endpos, trace_plane_normal, trace_ent);
		}
		shotcount = shotcount - 1;
	}
	ApplyMultiDamage ();
	
	Draw_Tracertrail(self, org + v_forward * 24 + v_right * 4 + v_up * -4, trace_endpos, 0);

	return direction;
};
////////////////////////////////////////////////////////////////////////////////////////////////

void() Eject_BulletCasing_ash =
{
	if (intermission) return;	
	
	makevectors(self.v_angle);
	vector vel = v_forward * 120 + v_right * (200 + 70*random()) + v_up * (80 + 50 * random());
	vector org = self.origin + self.view_ofs + (v_forward * 16) + (v_right * 16) + (v_up * -16);
	
	entity casing = toss_projectile(org, vel, "casing");
	casing.owner = self;
	casing.lifetime_finished = time + 2;
	casing.touch = BulletCasingTouch1_ash;
	casing.th_die = CasingFade;
	casing.alpha = 1;
	casing.avelocity = [-800 - crandom()*60, -800 - crandom() * 60, 0];
	SUB_ChangeModel (casing, "progs/placeholder_progs/wish/casing_big.mdl");
	
}

void() BulletCasingTouch1_ash =
{
	if (CheckProjectilePassthru()) return;

	local float r = floor(random()*3);
	if 	(r == 0)	sound (self, CHAN_ITEM, "placeholder_sound/ash_casing.wav", 0, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_ITEM, "placeholder_sound/ash_casing2.wav", 0.2, ATTN_NORM);
	else 			sound (self, CHAN_ITEM, "placeholder_sound/ash_casing3.wav", 0.5, ATTN_NORM);
	
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
	self.touch = BulletCasingTouch2_ash;
}

void() BulletCasingTouch2_ash =
{
	if (CheckProjectilePassthru()) return;

	self.avelocity = '0 0 0';
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

.entity	sibling;

float 	FL_PROJECTILE	= 32768;	// ???

void(entity pl, vector org, vector dest, float hit) Draw_Tracertrail = 
{
	float len = vlen(dest - org);
	vector dir = normalize(dest - org);
	vector ang = vectoangles(dest - org);

	float ct = floor(len/30);
	entity sg;
	entity prevsg;
	for (float i = 0; i < ct; i++) {
		sg = spawn();
		if (prevsg) prevsg.sibling = sg;

		
		setmodel (sg, "progs/placeholder_progs/railtrail_tracer.mdl");
		
			
		setsize(sg, VEC_ORIGIN, VEC_ORIGIN);
		setorigin(sg, org + dir * 30 * i);

		sg.flags |= FL_PROJECTILE;
		sg.classname = "lgsegment";
		sg.angles = ang;
		//sg.angles_z = random()*360;
		sg.owner = pl;
		sg.think = Draw_Tracertrail_Segment_Think;
		sg.attack_finished = time + 0.2 + 0.005*i;
		sg.nextthink = time + 0.02;
		sg.alpha = 1;
		sg.state = hit;
		sg.cnt = i;
		prevsg = sg;
	}
	if (sg) sg.effects |= EF_MUZZLEFLASH;
}

void() Draw_Tracertrail_Segment_Think = 
{
	self.alpha = clamp(lerpCosine(1, 0, 1 - (self.attack_finished - time)/0.5), 0.0001, 1);

	if (time > self.attack_finished)
		remove(self);
	else
		self.nextthink = time + 0.02;
}
////////////////////////////////////////////////////////////////////////////////////////////////
void() weaponanim_draw_ash =
{		
	sound (self, CHAN_AUTO, "misc/draw1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "placeholder_sound/ash_click.wav", 1, ATTN_NORM);
	
	self.weaponframe = 1;
	
	self.think = weaponanim_draw_ash_loop;
	self.nextthink = time + 0.025;
}

void() weaponanim_draw_ash_loop =
{
	if (self.weaponframe >= 10)
		return;
	else 
		self.weaponframe++;

	self.think = weaponanim_draw_ash_loop;
	self.nextthink = time + 0.05;
}

////////////////////////////////////////////////////////////////////////////////////////////////
void() weaponanim_inspect_ash =
{		
	sound (self, CHAN_AUTO, "placeholder_sound/ash_reload.wav", 1, ATTN_NORM);
	
	self.weaponframe = 31;
	
	self.think = weaponanim_inspect_ash_loop;
	self.nextthink = time + 0.05;
}

void() weaponanim_inspect_ash_loop =
{
	if (self.weaponframe >= 120)
		return;
	else 
		self.weaponframe++;

	self.think = weaponanim_inspect_ash_loop;
	self.nextthink = time + 0.05;
}