////////////////////////////////////////////////////////////////////////////////////////////////
//	Twin Nailgun
////////////////////////////////////////////////////////////////////////////////////////////////
.float nailgun_alternator;


float() weaponanim_twinnailgun = {
	// handled via animation loop4
	if (self.attackhold && self.attack_finished > time) {
		return FALSE;
	}

	if (self.attack_finished > time)
		return FALSE;

	SUB_CallAsSelf(player_nail1, self.animcontroller);

	if (self.nailgun_alternator == 0)	self.weaponframe = 0;
	else					self.weaponframe = 4;
		
	weaponanim_twinnailgun_loop();
	
	return TRUE;
	
}

void() weaponanim_twinnailgun_loop = {
	if (!self.attackhold && !self.attackpressed){
		weaponanim_twinnailgun_end();
		SUB_CallAsSelf(player_run, self.animcontroller);
		return;
	}

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return;
	}

	if (self.weaponframe >= 8) {
		self.weaponframe = 1;
	}
	else {
		self.weaponframe++;
	}

	// frame correction so the firing rate isn't so dependent on the server framerate
	if (time > self.nextthink1) {
		if (self.weaponframe > 5) self.weaponframe = 1;
		else if (self.weaponframe > 1) self.weaponframe = 5;
	}

	float offs;
	
	if (self.weaponframe == 1 || self.weaponframe == 5)
	{
		// fire rate timer. Don't set if on the first firing serverframe, since this will already be set by the startup animation function
		
		self.nextthink1 = time + 0.08; //speedy
		//if (self.attackhold) self.nextthink1 += 0.1;
		
		self.attack_finished = time + 0.09;

		self.currentammo = self.ammo_nails = self.ammo_nails - 1;
		self.punchangle_x = -2;
		self.effects |= EF_MUZZLEFLASH;
		
		if (self.weaponframe == 1) 	{offs = 4;	self.nailgun_alternator = 1;}
		else 				{offs = -4;	self.nailgun_alternator = 0;}
		
		SuperDamageSound();
		W_FireTwinNailgun(offs);
		
		self.cnt = cycle(self.cnt,8);
	}
	

	self.think = weaponanim_twinnailgun_loop;
	
	self.nextthink = time + 0.02;
}

void() weaponanim_twinnailgun_end = {

	if (self.weaponframe == 4 || self.weaponframe == 8) {
		self.weaponframe = 0;
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_twinnailgun_end;
	self.nextthink = time + 0.02;
}
////////////////////////////////////////////////////////////////////////////////////////////////

void(float offs) W_FireTwinNailgun =
{
	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 0.8, ATTN_NORM);	
	sound (self, CHAN_AUTO, "nail/airpuff.wav", 0.3, ATTN_NORM);	
	nailgun_sound(0.45);

	makevectors(self.v_angle);
	vector dir = aim(self, AUTOAIM_DIST);
	vector org = self.origin + self.view_ofs + v_forward*11 + v_right*offs - v_up*6;

	// default sv_maxvelocity is 2000, any higher leads to weird 
	// angular offsets caused by clamping the velocity
	
	entity spike = launch_projectile(org, dir * 1996, "nail");
	spike.touch = twinnail_touch;
	spike.alpha = 1;
	spike.dmg = 9;

	spike.nextthink = time + 4; //air lifetime
	spike.think = SUB_Remove;
	
	SUB_ChangeModel (spike, "progs/proj_nail.mdl");
}
//=============================================================================================

void(float nailgun_volume) nailgun_sound =
{
	local float r = floor(random()*5);
	if 	(r == 0)	sound (self, CHAN_AUTO, "nail/nailgun1.wav", nailgun_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "nail/nailgun2.wav", nailgun_volume, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_AUTO, "nail/nailgun3.wav", nailgun_volume, ATTN_NORM);
	else if (r == 3)	sound (self, CHAN_AUTO, "nail/nailgun4.wav", nailgun_volume, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "nail/nailgun5.wav", nailgun_volume, ATTN_NORM);
}
//=============================================================================================

void(float nailhit_volume) sound_nailgun_impact_enemy =
{
	local float r = floor(random()*4);
	if 	(r == 0)	sound (self, CHAN_AUTO, "impact/bullet_impact1.wav", nailhit_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "impact/bullet_impact2.wav", nailhit_volume, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_AUTO, "impact/bullet_impact3.wav", nailhit_volume, ATTN_NORM);
	else 			sound (self, CHAN_AUTO, "impact/bullet_impact4.wav", nailhit_volume, ATTN_NORM);
}
//=============================================================================================

void(vector org, float nailtink_volume) sound_nailgun_impact_world =
{
	local entity playspot = spawn();
	setorigin (playspot, org);
	
	local float r = floor(random()*3);
	if 	(r == 0)	sound (playspot, CHAN_AUTO, "nail/nail_tink1.wav", nailtink_volume, ATTN_NORM);
	else if (r == 1)	sound (playspot, CHAN_AUTO, "nail/nail_tink2.wav", nailtink_volume, ATTN_NORM);
	else			sound (playspot, CHAN_AUTO, "nail/nail_tink3.wav", nailtink_volume, ATTN_NORM);
	
	remove(playspot);
}
//=============================================================================================


void() TwinNailwallThink =
{
	//sound (self, CHAN_AUTO, "weapons/tink1.wav", 1, ATTN_STATIC);
	
	self.origin = self.origin - 2*normalize(self.velocity);	// move origin away from walls when stuck
								// helps prevent "void-lighting"
	self.touch = SUB_Null;
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_NOT;
	self.think = TwinNailFade;
	self.nextthink = time + 4;
}

void() TwinNailFade =
{
	// 2-second fade
	self.alpha -= 0.025;
	
	if (self.alpha <= 0)
	{
		remove(self);
		return;
	}
	self.think = TwinNailFade;
	self.nextthink = time + 0.05;
}
//=============================================================================================

void() twinnail_touch =
{
	if (!CheckValidSpikeTouch()) return;
	

	if (other.takedamage)
	{
		spawn_touchblood (other, self.dmg);
		T_Damage (other, self, self.trueowner, self.dmg);
				
		if (random() < 0.8)	sound_nailgun_impact_enemy(0.7);
		
		if (random() < 0.75)	FX_Impact(FX_BLOOD_BIG, self.origin, self.oldvelocity);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_SPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}

	if (other == world)
	{
		if (random() < 0.5)	FX_Impact(FX_NAIL, self.origin, self.oldvelocity);
		
		TwinNailwallThink();
	}	
	if (other.solid == SOLID_BSP && other.classname != "func_movewall") {
		self.movetype = MOVETYPE_NONE;
		self.solid = SOLID_NOT;
		self.owner = other;
		self.touch = SUB_Null;

		// move origin away from walls when stuck, helps prevent "void-lighting"
		setorigin(self, self.origin - 2*normalize(self.velocity));

		self.pos1 = other.absmin;

		// set state 2 to rebars attached to non-world entities (for movement and validity checks)
		if (other != world) self.state = 2;
		else self.state = 1;
		
		self.alpha = 1;
		self.think = ImpalerFade;
		self.nextthink = time + 10;
	}	
	else 
		remove(self);
}
//=============================================================================================

void() updateNails =
{
	entity e = find(world, classname, "nail");
	while (e)
	{
		if (e.state)
		{
			// hole is in a valid non-world solid entity
			if (e.owner && e.owner.solid == SOLID_BSP)
			{
				if (e.owner.absmin != e.pos1)
				{
					setorigin(e, e.origin - e.pos1 + e.owner.absmin);
					e.pos1 = e.owner.absmin;
				}
			}

			// hole was originally in a non-world entity, but it was removed or changed to non-solid
			else if (e.state == 2) { 
				remove(e);
			}
		}

		e = find(e, classname, "nail");
	}
}