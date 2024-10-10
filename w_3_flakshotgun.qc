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

	self.attack_finished = time + 1.05;
	
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
	
	
	if (self.weaponframe >= 23) {
		self.weaponframe = 0;
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_flakshotgun_loop;
	self.nextthink = time + 0.05;

}

////////////////////////////////////////////////////////////////////////////////////////////////

void() W_FireFlakShotgun =
{
	sound (self, CHAN_WEAPON, "shotgun3.wav", 1, ATTN_NORM);
	sound_flakshotgun_fire();
	
	
	local vector dir;
	dir = v_forward;
	
	self.velocity = self.velocity + (dir * -50) + '0 0 25';	// Knockback: Aim down, jump + shoot = 64 units (crate height)
	
	self.punchangle_x = -4;
	
	//RANDOM SPREAD
	//Define_Flak_Spread(10, dir, '300 80 0');
	
	Define_Flak_Spread(14, dir, '350 60 0'); //14 pellets x 8 dmg = 112 total (4 dmg on second enemy cleaved)
}
////////////////////////////////////////////////////////////////////////////////////////////////

void(float shotcount, vector dir, vector spread) Define_Flak_Spread =
{
	entity m;
	vector mvel;
	local vector	view_origin;

	makevectors (self.v_angle);
	
	view_origin = ((self.origin + self.view_ofs) + v_forward* 12 + v_up* -4); //+ v_right* 8;

	ClearMultiDamage ();
	while (shotcount > 0)
	{		
		//RANDOM SPREAD
		mvel = (v_forward * 2000) + (v_up * 100) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		

		//FIXED PATTERN
		/*
		if 	(shotcount == 10)	mvel = (v_forward * 2000) + (v_up * 100) + 300*v_right + crandom()*spread_y*v_up;
		else if (shotcount ==  9)	mvel = (v_forward * 2000) + (v_up * 100) + 233*v_right + crandom()*spread_y*v_up;
		else if (shotcount ==  8)	mvel = (v_forward * 2000) + (v_up * 100) + 166*v_right + crandom()*spread_y*v_up;
		else if (shotcount ==  7)	mvel = (v_forward * 2000) + (v_up * 100) +  99*v_right + crandom()*spread_y*v_up;
		else if (shotcount ==  6)	mvel = (v_forward * 2000) + (v_up * 100) +  33*v_right + crandom()*spread_y*v_up;
		
		else if (shotcount ==  5)	mvel = (v_forward * 2000) + (v_up * 100) + - 33*v_right + crandom()*spread_y*v_up;
		else if (shotcount ==  4)	mvel = (v_forward * 2000) + (v_up * 100) + - 99*v_right + crandom()*spread_y*v_up;
		else if (shotcount ==  3)	mvel = (v_forward * 2000) + (v_up * 100) + -166*v_right + crandom()*spread_y*v_up;
		else if (shotcount ==  2)	mvel = (v_forward * 2000) + (v_up * 100) + -233*v_right + crandom()*spread_y*v_up;
		else if (shotcount ==  1)	mvel = (v_forward * 2000) + (v_up * 100) + -300*v_right + crandom()*spread_y*v_up;
		*/
		
		m = Launch_Flak(view_origin, mvel);
		m.gravity = .5;
		m.think = FlakThink;
		m.touch = FlakTouch;
		m.th_die = SUB_Remove;
		m.buddy = self;		
		
		shotcount = shotcount - 1;
	}
	ApplyMultiDamage ();
	
}
//=============================================================================================

entity(vector org, vector vel) Launch_Flak =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "impaler");
	flak.lifetime_finished = time + 1.1;
	flak.dmg = 8;

	SUB_ChangeModel (flak, "progs/pellet.mdl");

	return flak;
}

void() FlakThink =
{
	self.angles = vectoangles(self.velocity);
	self.flags = not(self.flags, FL_ONGROUND);
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;
}
//=============================================================================================

void() FlakTouch =
{
	if (other == self.owner ) return;		// don't touch owner
	//if (CheckProjectilePassthru()) return;
	
	if ((other.takedamage == DAMAGE_AIM) || (other.takedamage == DAMAGE_YES))
	{
			T_Damage(other,self.buddy,self.buddy,self.dmg); //10x10 20x5 15x7
			//dprint3("Dealing damage, health ", ftos(other.health), "\n");
			self.dmg = 3; //to reduce cleave damage
			particle (self.origin, self.velocity*0.1, 73, 40);

			sound_flakshotgun_impact();
			projectile_passthru();
			return;
	}
	if (!other.takedamage)	//do not get stuck on wall, remove with temp effect
	{
		//sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);
	
		float chance = random();

		if 	(chance < 0.33)	sound (self, CHAN_AUTO, "weapons/ric1.wav", 0.25, ATTN_NORM);
		else if (chance < 0.5)	sound (self, CHAN_AUTO, "weapons/ric2.wav", 0.25, ATTN_NORM);
		else			sound (self, CHAN_AUTO, "weapons/ric3.wav", 0.25, ATTN_NORM);
				
		self.dmg = 3;
		self.touch = FlakTouch_Bounce_1;
	}
	
	// nonsense for combining quad SNG spike damage
	if (self.buddy)	self.buddy.dmg = 0;
	
	//remove(self);
}
//=============================================================================================

void() FlakTouch_Bounce_1 =
{
	if (other == self.owner ) return;		// don't touch owner
	if (CheckProjectilePassthru()) return;

	if ((other.takedamage == DAMAGE_AIM) || (other.takedamage == DAMAGE_YES))
	{
		T_Damage(other,self.buddy,self.buddy,self.dmg); //10x10 20x5 15x7
		//dprint3("Dealing bounce damage, health ", ftos(other.health), "\n");
		self.dmg = 4; //to reduce cleave damage
		particle (self.origin, self.velocity*0.1, 73, 40);
		sound_flakshotgun_impact();
		projectile_passthru();
		return;
	}
	if (!other.takedamage)	//do not get stuck on wall, remove with temp effect
	{
		/*
		self.velocity = '0 0 0';
		T_MissileExplode();
		BecomeExplosion();
		return;
		*/
		
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_SPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
		
		remove(self);
	}
	
	
	// nonsense for combining quad SNG spike damage
	if (self.buddy)	self.buddy.dmg = 0;
	
	//remove(self);
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
