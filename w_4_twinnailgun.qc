// lol it's the nailgun  :)

// should probably give it a different name...

// would be fun if the nails stuck in the walls tho!

// could reuse my Nerve Blaster code from the Toy Pak?

// -Kebs

////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_twinnailgun = {
	// handled via animation loop4
	if (self.attackhold && self.attack_finished > time) {
		return FALSE;
	}

	if (self.attack_finished > time)
		return FALSE;

	SUB_CallAsSelf(player_nail1, self.animcontroller);

	self.weaponframe = 0;
		
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
		W_ChangeWeapon(W_BestWeapon());
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
	
	if (self.weaponframe == 1 || self.weaponframe == 5) {

		// fire rate timer. Don't set if on the first firing serverframe, since this will already be set by the startup animation function
		
		self.nextthink1 = time + 0.08; //speedy
		//if (self.attackhold) self.nextthink1 += 0.1;
		
		self.attack_finished = time + 0.09;

		self.currentammo = self.ammo_nails = self.ammo_nails - 1;

		self.punchangle_x = -2;

		self.effects |= EF_MUZZLEFLASH;
		
		if (self.weaponframe == 1) offs = 4;
		else offs = -4;
		
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
	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);

	vector dir = aim(self, AUTOAIM_DIST);
	vector org = self.origin + self.view_ofs + v_forward*11 + v_right*offs - v_up*6;

	// default sv_maxvelocity is 2000, any higher leads to weird 
	// angular offsets caused by clamping the velocity
	
	entity spike = launch_projectile(org, dir * 1996, "spike");
	spike.touch = twinnail_touch;
	spike.alpha = 1;
	spike.dmg = 9;

	spike.nextthink = time + 4; //air lifetime
	spike.think = SUB_Remove;
	
	SUB_ChangeModel (spike, "progs/proj_nail.mdl");	
	

}
//=============================================================================================

void() TwinNailwallThink =
{
	sound (self, CHAN_AUTO, "weapons/tink1.wav", 1, ATTN_STATIC);
	
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
		spawn_touchblood (self.dmg);
		T_Damage (other, self, self.trueowner, self.dmg);
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
		TwinNailwallThink();
	else 
		remove(self);
}