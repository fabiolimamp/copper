////////////////////////////////////////////////////////////////////////////////////////////////
// awaiting cluster code
////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_qbj3grenade = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon());
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;

	self.attack_finished = time + 0.6;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	W_FireQBJ3Grenade(); //<<<

	self.weaponframe = 1;
	
	self.think = weaponanim_qbj3grenade_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_qbj3grenade_loop = {
	
	if (self.weaponframe >= 20) {
		self.weaponframe = 0;
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_qbj3grenade_loop;
	self.nextthink = time + 0.05;

}
////////////////////////////////////////////////////////////////////////////////////////////////
void() W_FireQBJ3Grenade =
{
	entity g;
	float base;
	vector gvel;
	
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);
	
	sound (self, CHAN_AUTO, "grenade/grenade_reload.wav", 0.5, ATTN_NORM);
	
	self.punchangle_x = -2;

	// set grenade speed	
	makevectors (self.v_angle);
	base = 200;
	if (self.v_angle_x)
		gvel = v_forward * base * 3 + v_up * base + crandom() * v_right * 10 + crandom() * v_up * 10;
	else
	{
		gvel = aim(self, AUTOAIM_DIST);
		gvel = gvel * base * 3;
		gvel_z = base;
	}
	
	g = launch_qbj3grenade(self.origin, gvel);
	g.touch = GrenadeTouch;
	g.th_die = GrenadeExplode;
}

entity(vector org, vector vel) launch_qbj3grenade =
{
	entity grenade;
	
	grenade = toss_projectile(org, vel, "grenade");
	grenade.lifetime_finished = time + 2.5;
	grenade.avelocity = '300 300 300';
	SUB_ChangeModel (grenade, "progs/proj_minigrenade.mdl");
	
	return grenade;
}


/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////


//=============================================================================

void() MiniGrenadeExplode =
{
	T_RadiusDamage (self, self.trueowner, 60, world, DMGTYPE_EXPLOSION);
	//T_GibDownedZombies (self, 120);
	
	BecomeExplosion ();
}

void() MiniGrenadeTouch =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;
	if (other.takedamage == DAMAGE_AIM)
	{
		self.velocity = '0 0 0';
		T_MiniMissileExplode();
		T_MiniExplosiveTouch();
		return;
	}
	sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);	// bounce sound
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
}
//=============================================================================
void(float blasttype) BecomeMiniBlast = 
{
	// no extra explosion effects for minis, too much spam
	/*
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	if (blasttype == 1)
		WriteByte (MSG_BROADCAST, TE_TAREXPLOSION);
	else
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);
	*/
	
	if (blasttype == 2)
		setmodel (self, "progs/s_explo2.spr");
	else
		setmodel (self, "progs/s_explod.spr");
	
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	self.solid = SOLID_NOT;
	s_explode1 ();
}
//=============================================================================
void() T_MiniExplosiveTouch =
{
	if (other.classname == "monster_shambler")
		BecomeMiniBlast(2); //weak, no TE_effects
	else
		BecomeMiniBlast(0); //normal, no TE_effects
}

void() T_MiniMissileExplode =
{
	local float	damg;
	damg = 50 + random()*10;
	
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, damg, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );	// so ogre rockets kill zombies despite being too weak
	}

	// don't do radius damage to other, because all damage will be done in the impact
	T_RadiusDamage (self, self.trueowner, 60, other, DMGTYPE_EXPLOSION);
}
//=============================================================================

void() W_FireMiniGrenade =
{
	entity g;
	float base;
	vector gvel;
	
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);
	self.punchangle_x = -2;

	// set grenade speed	
	makevectors (self.v_angle);
	base = 200;
	if (self.v_angle_x)
		gvel = v_forward * base * 3 + v_up * base + crandom() * v_right * 10 + crandom() * v_up * 10;
	else
	{
		gvel = aim(self, AUTOAIM_DIST);
		gvel = gvel * base * 3;
		gvel_z = base;
	}
	
	g = launch_minigrenade(self.origin, gvel);
	g.touch = MiniGrenadeTouch;
	g.th_die = MiniGrenadeExplode;
}

entity(vector org, vector vel) launch_minigrenade =
{
	entity grenade;
	
	grenade = toss_projectile(org, vel, "grenade");
	grenade.lifetime_finished = time + 2.5;
	grenade.avelocity = '300 300 300';
	SUB_ChangeModel (grenade, "progs/proj_minigrenade.mdl");
	
	return grenade;
}
