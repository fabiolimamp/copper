////////////////////////////////////////////////////////////////////////////////////////////////
// piercing projectile Impaler code by Fairweather, edits by Kebby
////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_flakshotgun = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon());
		return FALSE;
	}

	self.currentammo = self.ammo_shells = self.ammo_shells - 1;

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
	if (intermission) return;
	
	if (self.weaponframe == 8) sound (self, CHAN_AUTO, "flak/pump_reload.wav", 0.7, ATTN_NORM); //extra pump sfx
	
	if (self.weaponframe == 11) Eject_BuckshotCasing();
	
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
	sound(self, CHAN_WEAPON, "flak/shotgun3.wav", 1, ATTN_NORM);
	//sound(self, CHAN_AUTO, "flak/shotgun2.wav", 0.5, ATTN_NORM);	
	
	sound_shotgun_shoot(0.8);
	
	float r = random();
	if 	(r < 0.33)	sound (self, CHAN_AUTO, "flak/volley_fire1.wav", 1, ATTN_NORM);
	else if (r < 0.66)	sound (self, CHAN_AUTO, "flak/volley_fire2.wav", 1, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "flak/volley_fire3.wav", 1, ATTN_NORM);
	
	makevectors(self.v_angle);
	//self.velocity = self.velocity + (v_forward * -100) + '0 0 25';
	self.punchangle_x = -4;
	
	float shotcount = 22;
	vector spread = '280 60 0';
	vector view_origin = self.origin + self.view_ofs + v_forward*12 - v_up*4; //+ v_right* 8;

	vector mvel;
	entity fl;
	while (shotcount > 0)
	{
		mvel = (v_forward * 2000) + (v_up * 100) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		fl = Launch_Flak(view_origin, mvel);
		//fl.customflags &~= CFL_PROJECTILE;
		fl.count = shotcount;
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
	flak.gravity = .5;
	flak.think = FlakThink;
	flak.nextthink = time + 0.05;
	flak.touch = FlakTouch;
	flak.alpha = 1;
	flak.oldvelocity = flak.velocity;

	SUB_ChangeModel (flak, "progs/proj_pellet.mdl");

	return flak;
}

//=====================================================================================================================

void() FlakThink =
{
	
	self.angles = vectoangles(self.velocity);
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;

	self.think = FlakThink;
	self.nextthink = time + 0.05;

	float fadetime = 0.4;

	float fadestart = self.lifetime_finished - fadetime;

	if (fadestart < time)
	{
		self.alpha = 1 - ((time - fadestart) / (self.lifetime_finished - fadestart));
		if (self.alpha == 0) self.alpha = -1;
	}

	if (self.lifetime_finished < time)
		remove(self);
}


void() FlakBounce =
{
	vector dir = normalize(self.oldvelocity);
	vector spot1 = self.origin - (4*dir);
	vector spot2 = self.origin + (4*dir);
	traceline (spot1, spot2, FALSE, self); 
	self.flags &~= FL_ONGROUND;

	/*
	Vector reflection around normal
	r = d − 2(d*n)n
	r => reflected vector, d => entrance vector, n => surface normal, d*n => dot product

	1.5 => "overbounce", same calculation applied by the engine to reduce velocity depending on impact angle on MOVETYPE_BOUNCE ents
	*/
	vector newdir = self.oldvelocity - (2 * (self.oldvelocity * trace_plane_normal / 1.5)) * trace_plane_normal;
	//self.velocity = newdir * vlen(self.oldvelocity);
	self.velocity = newdir;

	setorigin(self, self.origin + normalize(newdir));

	self.oldvelocity = self.velocity;
	self.angles = vectoangles(self.velocity);

	// physics loop clips velocity only after this touch function runs, so it needs to be set again at the next frame
	self.think = Flak_setvelocity;
	self.nextthink = time + 0.01;
}

void() Flak_setvelocity = {
	self.velocity = self.oldvelocity;
	self.think = FlakThink;
	self.nextthink = time + 0.01;
}


void() FlakTouch =
{
	if (CheckProjectilePassthru()) return;
	
	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, 4);
		
		//dprint3("Dealing damage, health ", ftos(other.health), "\n");
		SpawnBlood(self.origin, self.velocity, 40);

		sound_flakshotgun_impact();

		if (other.health <= 0) projectile_passthru();
		else remove(self);
		
		return;
	}

	FlakBounce();
	gunshot(self.origin);

	self.touch = FlakTouch_2;
	self.lifetime_finished = time + 0.5;
	
	float chance = random();

	if (chance < 0.33) sound(self, CHAN_AUTO, "weapons/ric1.wav", 0.25, ATTN_NORM);
	else if (chance < 0.5) sound(self, CHAN_AUTO, "weapons/ric2.wav", 0.25, ATTN_NORM);
	else sound(self, CHAN_AUTO, "weapons/ric3.wav", 0.25, ATTN_NORM);
}
//=============================================================================================

void() FlakTouch_2 =
{
	if (CheckProjectilePassthru()) return;

	FlakBounce();

	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, 4);
		
		SpawnBlood(self.origin, self.velocity, 40);
		sound_flakshotgun_impact();
		return;
	}
	
	gunshot(self.origin);
}
//=============================================================================================

void() BuckshotCasingTouch2 =
{
	if (CheckProjectilePassthru()) return;

	self.avelocity = '0 0 0';
}

void() BuckshotCasingTouch1 =
{
	if (CheckProjectilePassthru()) return;

	sound_shell_casing(0.3);
	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
	self.touch = BulletCasingTouch2;
}

void() Eject_BuckshotCasing =
{
	if (intermission) return;

	makevectors(self.v_angle);
	vector vel = v_forward * 160 + v_right * (200 + 60*random()) + v_up * (60 + 30 * random());
	vector org = self.origin + self.view_ofs + (v_forward * 20) + (v_right * 12) + (v_up * -12);
	
	entity casing = toss_projectile(org, vel, "casing");
	casing.owner = self;
	casing.lifetime_finished = time + 2;
	casing.touch = BuckshotCasingTouch1;
	casing.th_die = SUB_Remove;
	//casing.avelocity = '-200 -400 0'; //'0 -200 0'
	casing.avelocity = [-170 - crandom()*60, -370 - crandom() * 60, 0];
	SUB_ChangeModel (casing, "progs/buckshot_casing.mdl");
}
////////////////////////////////////////////////////////////////////////////////////////////////

void(float flakfire_volume) sound_shotgun_shoot =
{
	local float r = floor(random()*4);
	if 	(r == 0)	sound (self, CHAN_AUTO, "flak/shotgun_fire1.wav", flakfire_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "flak/shotgun_fire2.wav", flakfire_volume, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_AUTO, "flak/shotgun_fire3.wav", flakfire_volume, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "flak/shotgun_fire4.wav", flakfire_volume, ATTN_NORM);
}
//=============================================================================================

void(float shellcase_volume) sound_shell_casing =
{
	local float r = floor(random()*3);
	if 	(r == 0)	sound (self, CHAN_AUTO, "flak/shell_casing1.wav", shellcase_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "flak/shell_casing2.wav", shellcase_volume, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "flak/shell_casing3.wav", shellcase_volume, ATTN_NORM);
}
//=============================================================================================

void() sound_flakshotgun_impact =
{
	if (random() < 0.33){
		
	local float r = floor(random()*4);
	if 	(r == 0)	sound (self, CHAN_AUTO, "impact/bullet_impact1.wav", 1, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "impact/bullet_impact2.wav", 1, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_AUTO, "impact/bullet_impact3.wav", 1, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "impact/bullet_impact4.wav", 1, ATTN_NORM);
	
	}else	return;
}
////////////////////////////////////////////////////////////////////////////////////////////////