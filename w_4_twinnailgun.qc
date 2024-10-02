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
	self.nextthink1 = time + 0.08; //speedy
	//self.nextthink1 = time + 0.1;
	
	weaponanim_twinnailgun_loop();
	
	return TRUE;
	
}

void() weaponanim_twinnailgun_loop = {
	if (!self.attackhold && !self.attackpressed){
		self.weaponframe = 0;
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

	//float offs;
	
	if (self.weaponframe == 1 || self.weaponframe == 5) {

		// fire rate timer. Don't set if on the first firing serverframe, since this will already be set by the startup animation function
		
		self.nextthink1 = time + 0.08; //speedy
		//if (self.attackhold) self.nextthink1 += 0.1;
		
		self.attack_finished = time + 0.2;

		self.currentammo = self.ammo_nails = self.ammo_nails - 1;

		self.punchangle_x = -2;

		self.effects |= EF_MUZZLEFLASH;

		SuperDamageSound();
		W_FireTwinNailgun();

		self.cnt = cycle(self.cnt,8);
	}
	

	self.think = weaponanim_twinnailgun_loop;
	
	self.nextthink = time + 0.025;
}
////////////////////////////////////////////////////////////////////////////////////////////////

void() W_FireTwinNailgun =
{
	vector offset, v, org, dir;
	// remember sv_aim
	dir = aim( self, AUTOAIM_DIST );
	v = vectoangles( dir );
	v_x *= -1;	// pitch comes back inverted from vectoangles :|
	makevectors( v );

	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);
	//self.currentammo = self.ammo_nails = self.ammo_nails - 1;
	offset = VEC_ORIGIN;
	
	//if ( mod( self.cnt, 2 ) ) offset_x = -2.5;
	//else offset_x = 2.5;	
	if ( mod( self.cnt, 2 ) ) offset_x = -4;
	else offset_x = 4;	

	org = W_SpikeOrigin(offset);

	// default sv_maxvelocity is 2000, any higher leads to weird 
	// angular offsets caused by clamping the velocity
	launch_twinnail(org, dir * 1996);
	self.attack_finished += 0.09;
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
	self.think = SUB_Remove;
	self.nextthink = time + 10;
}


entity(vector org, vector vel) launch_twinnail =
{
	entity spike;
	
	spike = launch_projectile(org, vel, "spike");
	spike.touch = twinnail_touch;
	
	spike.nextthink = time + 10; //stick lifetime
	spike.think = SUB_Remove;
	
	SUB_ChangeModel (spike, "progs/nail.mdl");	
	
	spike.dmg = 9;
	
	return spike;
}

//=============================================================================================

void() twinnail_touch =
{
	if (!CheckValidSpikeTouch()) return;
	
	if (self.dmg)
	{
		if (other.takedamage)
		{
			spawn_touchblood (self.dmg);
			T_Damage (other, self, self.trueowner, self.dmg);
		}
		else
		{
			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			
			switch(self.classname)
			{
			case "wizspike":
				WriteByte (MSG_BROADCAST, TE_WIZSPIKE); break;
			case "knightspike":
				WriteByte (MSG_BROADCAST, TE_KNIGHTSPIKE); break;
			case "laser":
				WriteByte(MSG_BROADCAST, TE_GUNSHOT); break;
			default:
				WriteByte (MSG_BROADCAST, TE_SPIKE);
			}
			
			WriteCoord (MSG_BROADCAST, self.origin_x);
			WriteCoord (MSG_BROADCAST, self.origin_y);
			WriteCoord (MSG_BROADCAST, self.origin_z);
			
			if (other == world)
				TwinNailwallThink();
			else
			remove(self);
			
			return;
			/*
			sound (self, CHAN_AUTO, "weapons/tink1.wav", 1, ATTN_STATIC);
			self.movetype = MOVETYPE_NONE;
			self.velocity = '0 0 0';  
			*/
		}
		
		if (self.classname == "laser")
		{
			sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_STATIC);
			particle (self.origin, self.velocity*-0.01, 235, 15);
		}
	}
	// nonsense for combining quad SNG spike damage
	if (self.buddy)
		self.buddy.dmg = 0;
	remove(self);
}