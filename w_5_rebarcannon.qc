////////////////////////////////////////////////////////////////////////////////////////////////
// piercing projectile Impaler code by Fairweather, edits by Kebby
////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_rebarcannon = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon());
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - 10;

	self.attack_finished = time + 1;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	W_FireRebarCannon();

	self.weaponframe = 1;
	self.think = weaponanim_rebarcannon_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_rebarcannon_loop = {

	if (self.weaponframe >= 24) {
		self.weaponframe = 0;
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_rebarcannon_loop;
	self.nextthink = time + 0.05;

}

////////////////////////////////////////////////////////////////////////////////////////////////

void() W_FireRebarCannon =
{
	entity m;
	float base;
	vector mvel;
	
	sound (self, CHAN_WEAPON, "penfire.wav", 1, ATTN_NORM);
	self.punchangle_x = -2;

	makevectors (self.v_angle);
	base = 1400;
	
	mvel = (v_forward * base) + (v_up * 150) + (v_right * 10) + (v_up * 10);

	m = launch_impaler(self.origin, mvel);
	m.gravity = .75;
	m.think = ImpalerThink;
	m.touch = ImpalerTouch;
	m.th_die = SUB_Remove;
	m.buddy = self;
}
////////////////////////////////////////////////////////////////////////////////////////////////

void() ImpalerInwallThink =
{
	self.origin = self.origin - 2*normalize(self.velocity);	// move origin away from walls when stuck
								// helps prevent "void-lighting"
	self.touch = SUB_Null;
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_NOT;
	self.think = SUB_Remove;
	self.nextthink = time + 15;
}

void() ImpalerThink =
{
	self.angles = vectoangles(self.velocity);
	self.flags = not(self.flags, FL_ONGROUND);
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;
}
//=============================================================================================

entity(vector org, vector vel) launch_impaler =
{
	entity impaler;
	gunshot(org);
	impaler = toss_projectile(org, vel, "impaler");
	impaler.lifetime_finished = time + 2.5;

	SUB_ChangeModel (impaler, "progs/rebar.mdl");

	return impaler;
}

void(float dm) GibSprayHeadless =
{
	ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(dm));
	ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(dm));
}

//=============================================================================================

void() ImpalerTouch =
{
	if (other == self.owner ) return;		// don't touch owner
	if (CheckProjectilePassthru()) return;
	if ((other.takedamage == DAMAGE_AIM) || (other.takedamage == DAMAGE_YES))
	{
			if (other.classname == "monster_zombie")
				T_Damage(other,self.buddy,self.buddy,59);
			else
				T_Damage(other,self.buddy,self.buddy,100);

			GibSprayHeadless(20);
			particle (self.origin, self.velocity*0.1, 73, 40);

			float chance = random();

			if 	(chance < 0.33)	sound (self, CHAN_AUTO, "pierce1.wav", 1, ATTN_NORM);
			else if (chance < 0.5)	sound (self, CHAN_AUTO, "pierce2.wav", 1, ATTN_NORM);
			else			sound (self, CHAN_AUTO, "pierce3.wav", 1, ATTN_NORM);

			projectile_passthru();

			return;
	}

	if (!other.takedamage)
	{
		sound (self, CHAN_AUTO, "stick1.wav", 0.5, ATTN_NORM);
		gunshot(self.origin);

		//stick in the wall if we hit worldspawn as we know that won't move
		if (other == world)
		{
		ImpalerInwallThink();
		}
		else
		remove(self);
	}
}