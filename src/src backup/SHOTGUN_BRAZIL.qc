//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SHOTGUN_BRAZIL_NAME	=	"SHOTGUN_BRAZIL";
string	SHOTGUN_BRAZIL_MODEL	=	"progs/placeholder_progs/v_shotgun_brazil.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)
//	0.8	11	5	1	'220 180 0'		//fade flak (55)
//	0.8	13	4	1	'220 180 0'		//fade flak (52)


//=============================================================================================
	
	
	float	SHOTGUN_BRAZIL_ROF	=	0.8;		//seconds post-fire
	
	float	SHOTGUN_BRAZIL_COUNT	=	11;		//number of shots
	float	SHOTGUN_BRAZIL_DMG 	=	5;	//55	//damage per shot

	float	SHOTGUN_BRAZIL_COST	=	1;		//ammo cost to fire
	
	//vector	SHOTGUN_BRAZIL_SPREAD	=	'0.1 0.1 0';	//seconds post-fire	//W_Fire_SHOTGUN_BRAZIL_hitscan
	vector	SHOTGUN_BRAZIL_SPREAD	=	'160 240 0';	//seconds post-fire	//W_Fire_SHOTGUN_BRAZIL_flak


//=============================================================================================

float() weaponanim_SHOTGUN_BRAZIL =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_BRAZIL_COST;
	self.attack_finished = time + SHOTGUN_BRAZIL_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	//self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	//W_Fire_SHOTGUN_BRAZIL_hitscan();
	W_Fire_SHOTGUN_BRAZIL_flak();

	self.weaponframe = 11;	
	self.think = weaponanim_SHOTGUN_BRAZIL_loop;
	self.nextthink = time + 0.05;	
	return TRUE;
}

void() weaponanim_SHOTGUN_BRAZIL_loop =
{
	if (intermission) return;

	if (self.weaponframe == 21) 
	{
		Eject_BuckshotCasing();
		sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	}
	
	//if (self.weaponframe >= 40)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SHOTGUN_BRAZIL_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================
/*
void() W_Fire_SHOTGUN_BRAZIL_hitscan =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun1.wav", 0.3, ATTN_NORM);
	
	makevectors (self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  8 + v_forward * 8;
	vector org_eye = self.origin + self.view_ofs;
	
	vector spread = SHOTGUN_BRAZIL_SPREAD;
	
	//self.velocity = self.velocity + (v_forward * -100) + '0 0 25';	//shotgun jump +64 units
	//self.velocity = self.velocity + (v_forward * -150);		//shotgun knockback

	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);	//aim point directly in front of the crosshair
	vector dir_eye = normalize(trace_endpos - org_eye);
		
	ClearMultiDamage ();
	FirePistolBullets (SHOTGUN_BRAZIL_COUNT, SHOTGUN_BRAZIL_DMG, org_eye, org_gun + v_forward * 16 * trace_fraction, dir_eye, spread, TRUE);
	
	ApplyMultiDamage ();	
	self.punchangle_x = -2;	//punch AFTER makevectors
};
*/
//=============================================================================================

void() W_Fire_SHOTGUN_BRAZIL_flak =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun1.wav", 0.3, ATTN_NORM);
	
	makevectors(self.v_angle);
	self.punchangle_x = -2;
	
	float shotcount = SHOTGUN_BRAZIL_COUNT;
	vector spread = SHOTGUN_BRAZIL_SPREAD;
	vector view_origin = self.origin + self.view_ofs + v_forward*12 - v_up*4 + v_right* 8;

	vector mvel;
	entity fl;
	while (shotcount > 0)
	{
		mvel = (v_forward * 2000) + (v_up * 100) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		fl = Launch_Flak_SHOTGUN_BRAZIL(view_origin, mvel);
		fl.count = shotcount;
		shotcount = shotcount - 1;
	}
}

entity(vector org, vector vel) Launch_Flak_SHOTGUN_BRAZIL =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "flak");
	flak.lifetime_finished = time + 0.2;
	flak.attack_finished = time + 1;
	flak.gravity = 0;
	flak.think = FlakThink;
	flak.nextthink = time + 0.05;
	flak.touch = FlakTouch_SHOTGUN_BRAZIL;
	flak.alpha = 1;
	flak.oldvelocity = flak.velocity;

	SUB_ChangeModel (flak, "progs/proj_pellet.mdl");

	return flak;
}
/*
void() FlakTouch_SHOTGUN_BRAZIL =
{
	if (CheckProjectilePassthru()) return;

	if (self.attack_finished < time) {
		remove(self);
		return;
	}

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}

	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, SHOTGUN_BRAZIL_DMG);
		
		//dprint3("Dealing damage, health ", ftos(other.health), "\n");
		SpawnBlood(self.origin, self.velocity, SHOTGUN_BRAZIL_DMG*10);

		if (random() < 0.25)	FX_Impact(FX_BLOOD_BIG, self.origin, self.velocity);

		sound_flakshotgun_impact();

		if (other.health <= 0) projectile_passthru();
		else remove(self);
		
		return;
	}

	FlakBounce();
	gunshot(self.origin);

	//self.touch = FlakTouch_2;
	self.lifetime_finished = time + 0.5;
	
	float chance = random();

	if (chance < 0.33) sound(self, CHAN_AUTO, "weapons/ric1.wav", 0.25, ATTN_NORM);
	else if (chance < 0.5) sound(self, CHAN_AUTO, "weapons/ric2.wav", 0.25, ATTN_NORM);
	else sound(self, CHAN_AUTO, "weapons/ric3.wav", 0.25, ATTN_NORM);
}
*/
void() FlakTouch_SHOTGUN_BRAZIL =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, SHOTGUN_BRAZIL_DMG);

		if (other.solid != SOLID_BSP) {
			//ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(SHOTGUN_BRAZIL_DMG));
		}

		FX_Impact(FX_BLOOD_BIG, self.origin, self.oldvelocity);

		particle (self.origin, self.velocity*0.1, 73, 40);

		float chance = random();
		
		if 	(chance < 0.33)	sound (self, CHAN_AUTO, "rebar/pierce1.wav", 0.2, ATTN_NORM);
		else if (chance < 0.5)	sound (self, CHAN_AUTO, "rebar/pierce2.wav", 0.2, ATTN_NORM);
		else			sound (self, CHAN_AUTO, "rebar/pierce3.wav", 0.2, ATTN_NORM);
		
		//sound (self, CHAN_AUTO, "rebar/pierce_impact.wav", 1, ATTN_NORM);

		// doesn't go through doors
		if (other.classname != "func_door" && other.classname != "func_door_secret"){
			projectile_passthru();
			return;
		}
	}
	else
		remove(self);	
}