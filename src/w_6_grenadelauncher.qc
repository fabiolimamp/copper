////////////////////////////////////////////////////////////////////////////////////////////////
// Grenade Launcher
////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_qbj3grenade = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
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

void(float grenfire_volume) sound_grenade_fire =
{
	local float r = floor(random()*3);
	if 	(r == 0)	sound (self, CHAN_AUTO, "grenade/grenade_fire1.wav", grenfire_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "grenade/grenade_fire2.wav", grenfire_volume, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "grenade/grenade_fire3.wav", grenfire_volume, ATTN_NORM);
}
//=============================================================================================

void() W_FireQBJ3Grenade =
{
	entity g;
	float base;
	vector gvel;
	
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);	
	sound (self, CHAN_AUTO, "grenade/grenade_reload.wav", 0.5, ATTN_NORM);
	sound_grenade_fire(0.6);
	SuperDamageSound();
	
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
	//grenade.avelocity = '300 300 300';
	grenade.avelocity = '-600 0 0';
	//SUB_ChangeModel (grenade, "progs/proj_minigrenade.mdl");
	SUB_ChangeModel (grenade, "progs/proj_grenade.mdl");
	
	return grenade;
}
//=====================================================================================================================

void() weaponanim_drawgrenlauncher =
{		
	sound (self, CHAN_AUTO, "ammo/draw1.wav", 0.5, ATTN_NORM);
	
	self.weaponframe = 22;
	
	self.think = weaponanim_drawgrenlauncher_loop;
	self.nextthink = time + 0.025;
}

void() weaponanim_drawgrenlauncher_loop =
{
	if (self.weaponframe >= 32)
	{
		self.weaponframe = 0;
		self.think = SUB_Null;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_drawgrenlauncher_loop;
	self.nextthink = time + 0.025;
}