////////////////////////////////////////////////////////////////////////////////////////////////
// piercing projectile Impaler code by Fairweather, edits by Kebby
////////////////////////////////////////////////////////////////////////////////////////////////

/*
	Shell pickup values have been reduced by half (from 40/20 -> 20/10)
	Soldier shell drops reduced (from 5 -> 4)
	Starting shell ammo reduced (from 25 -> 24)
	
	
			
	TO REVERT OR ADJUST CHANGES: 
	
	Grep search for "//FlakTax"
*/

////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_flakshotgun = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon());
		return FALSE;
	}

	self.currentammo = self.ammo_shells = self.ammo_shells - 2; //2 shells to fire

	self.attack_finished = time + 1.2;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	W_FireFlakShotgun();

	self.weaponframe = 1;
	self.think = weaponanim_flakshotgun_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_flakshotgun_loop = {

	
	if (self.weaponframe == 10) sound (self, CHAN_AUTO, "pump_reload.wav", 0.5, ATTN_NORM); //extra pump sfx
	
	
	if (self.weaponframe >= 22) {
		self.weaponframe = 0;
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_flakshotgun_loop;
	self.nextthink = time + 0.05;

}

//=====================================================================================================================

void() W_FireFlakShotgun =
{
	sound(self, CHAN_WEAPON, "shotgun3.wav", 1, ATTN_NORM);
	sound_flakshotgun_fire();
	
	makevectors(self.v_angle);
	
	self.velocity = self.velocity + (v_forward * -50) + '0 0 25';	// Knockback: Aim down, jump + shoot = 64 units (crate height)
	
	self.punchangle_x = -4;
	
	//RANDOM SPREAD
	
	float shotcount = 14;
	vector spread = '260 60 0';
	vector view_origin = self.origin + self.view_ofs + v_forward*12 - v_up*4; //+ v_right* 8;

	vector mvel;
	while (shotcount > 0)
	{		
		//RANDOM SPREAD
		mvel = (v_forward * 2000) + (v_up * 100) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		Launch_Flak(view_origin, mvel);
		shotcount = shotcount - 1;
	}

}

//=====================================================================================================================

entity(vector org, vector vel) Launch_Flak =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "flak");
	flak.lifetime_finished = time + 1.1;
	flak.dmg = 7;
	flak.gravity = .5;
	flak.think = FlakThink;
	flak.touch = FlakTouch;
	flak.th_die = SUB_Remove;
	flak.owner = self;

	SUB_ChangeModel (flak, "progs/pellet.mdl");

	return flak;
}

//=====================================================================================================================

void() FlakThink =
{
	self.angles = vectoangles(self.velocity);
	self.flags = not(self.flags, FL_ONGROUND);
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;
}

void() FlakTouch =
{
	//if (other == self.owner ) return;		// don't touch owner
	//if (CheckProjectilePassthru()) return;



	if (other.takedamage)
	{
		T_Damage(other, self, self.owner, self.dmg); //10x10 20x5 15x7
		//dprint3("Dealing damage, health ", ftos(other.health), "\n");
		self.dmg = 3; //to reduce cleave damage
		particle (self.origin, self.velocity*0.1, 73, 40);

		sound_flakshotgun_impact();

		if (other.health <= 0) projectile_passthru();
		else remove(self);
		
		return;
	}

	self.dmg = 3;
	self.touch = FlakTouch_Bounce_1;
	
	float chance = random();

	if (chance < 0.33) sound(self, CHAN_AUTO, "weapons/ric1.wav", 0.25, ATTN_NORM);
	else if (chance < 0.5) sound(self, CHAN_AUTO, "weapons/ric2.wav", 0.25, ATTN_NORM);
	else sound(self, CHAN_AUTO, "weapons/ric3.wav", 0.25, ATTN_NORM);
}
//=============================================================================================

void() FlakTouch_Bounce_1 =
{
	if (other == self.owner ) return;		// don't touch owner
	if (CheckProjectilePassthru()) return;

	if ((other.takedamage == DAMAGE_AIM) || (other.takedamage == DAMAGE_YES))
	{
		T_Damage(other, self, self.owner, self.dmg); //10x10 20x5 15x7
		particle(self.origin, self.velocity*0.1, 73, 40);
		sound_flakshotgun_impact();
		//projectile_passthru();
	}
	else
		gunshot(self.origin);

	remove(self);
}
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

void() sound_flakshotgun_impact =
{
	float r = random();
	if 	(r < 0.03)	sound (self, CHAN_AUTO, "bullet_impact1.wav", 1, ATTN_NORM);
	else if (r < 0.06)	sound (self, CHAN_AUTO, "bullet_impact2.wav", 1, ATTN_NORM);
	else if (r < 0.09)	sound (self, CHAN_AUTO, "bullet_impact3.wav", 1, ATTN_NORM);
	else if (r < 0.12)	sound (self, CHAN_AUTO, "bullet_impact4.wav", 1, ATTN_NORM);
	else if (r < 0.15)	sound (self, CHAN_AUTO, "bullet_impact5.wav", 1, ATTN_NORM);
	else if (r < 0.18)	sound (self, CHAN_AUTO, "bullet_impact6.wav", 1, ATTN_NORM);
	else if (r < 0.21)	sound (self, CHAN_AUTO, "bullet_impact7.wav", 1, ATTN_NORM);
	else if (r < 0.24)	sound (self, CHAN_AUTO, "bullet_impact8.wav", 1, ATTN_NORM);
	else if (r < 0.27)	sound (self, CHAN_AUTO, "bullet_impact9.wav", 1, ATTN_NORM);
	else if (r < 0.30)	sound (self, CHAN_AUTO, "bullet_impact10.wav", 1, ATTN_NORM);
	else if (r < 0.33)	sound (self, CHAN_AUTO, "bullet_impact11.wav", 1, ATTN_NORM);
	else if (r < 0.36)	sound (self, CHAN_AUTO, "bullet_impact12.wav", 1, ATTN_NORM);
}
////////////////////////////////////////////////////////////////////////////////////////////////

void() sound_flakshotgun_fire =
{
	float r = random();
	if 	(r < 0.33)	sound (self, CHAN_AUTO, "volley_fire1.wav", 1, ATTN_NORM);
	else if (r < 0.66)	sound (self, CHAN_AUTO, "volley_fire2.wav", 1, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "volley_fire3.wav", 1, ATTN_NORM);
}
