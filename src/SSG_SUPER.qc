//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SSG_SUPER_NAME	=	"SSG_SUPER";
string	SSG_SUPER_MODEL	=	"progs/placeholder_progs/v_ssg_super3.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)
//	1.4	16	8	2	'420 180 0'		//W_Fire_SSG_SUPER_flak (128)
//	1.5	20	10	3	'0.30 0.15 0'		//W_Fire_SSG_SUPER_hitscan (200)
//	1.9	20	10	3	'0.30 0.15 0'		//W_Fire_SSG_SUPER_hitscan (200)
//	1.9	25	10	3	'0.25 0.05 0'		//W_Fire_SSG_SUPER_hitscan (250)
//	1.9	18	14	4	'0.25 0.05 0'		//W_Fire_SSG_SUPER_hitscan (252)
//	2	16	16	4	'0.2 0.05 0'		//W_Fire_SSG_SUPER_hitscan (256)


//=============================================================================================
	
	
	float	SSG_SUPER_ROF	=	2;		//seconds post-fire
	
	float	SSG_SUPER_COUNT	=	16;		//number of shots
	float	SSG_SUPER_DMG 	=	16;	//256	//damage per shot

	float	SSG_SUPER_COST	=	4;		//ammo cost to fire
	
	vector	SSG_SUPER_SPREAD	=	'0.2 0.05 0';	//seconds post-fire	//W_Fire_SSG_SUPER_hitscan


//=============================================================================================

float() weaponanim_SSG_SUPER =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SSG_SUPER_COST;
	self.attack_finished = time + SSG_SUPER_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	W_Fire_SSG_SUPER_hitscan();
	//W_Fire_SSG_SUPER_flak();

	self.weaponframe = 11;	
	self.think = weaponanim_SSG_SUPER_loop;
	self.nextthink = time + 0.05;	
	return TRUE;
}

void() weaponanim_SSG_SUPER_loop =
{
	if (intermission) return;

	if (self.weaponframe == 25)
	{	
		Eject_BuckshotCasing();
		Eject_BuckshotCasing();
		Eject_BuckshotCasing();
		Eject_BuckshotCasing();
		sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	}
	
	if (self.weaponframe >= 40)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SSG_SUPER_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void() W_Fire_SSG_SUPER_hitscan =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun2.wav", 0.3, ATTN_NORM);
	
	makevectors (self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  8 + v_forward * 8;
	vector org_eye = self.origin + self.view_ofs;
	
	vector spread = SSG_SUPER_SPREAD;
	
	//self.velocity = self.velocity + (v_forward * -100) + '0 0 25';	//shotgun jump +64 units
	self.velocity = self.velocity + (v_forward * -150);		//shotgun knockback

	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);	//aim point directly in front of the crosshair
	vector dir_eye = normalize(trace_endpos - org_eye);
		
	ClearMultiDamage ();
	FirePistolBullets (SSG_SUPER_COUNT, SSG_SUPER_DMG, org_eye, org_gun + v_forward * 16 * trace_fraction, dir_eye, spread, TRUE);
	
	ApplyMultiDamage ();
	self.punchangle_x = -4;	//punch AFTER makevectors
};

//=============================================================================================

void() W_Fire_SSG_SUPER_flak =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun2.wav", 0.3, ATTN_NORM);
	
	makevectors(self.v_angle);
	self.punchangle_x = -4;
	
	float shotcount = SSG_SUPER_COUNT;
	vector spread = SSG_SUPER_SPREAD;
	vector view_origin = self.origin + self.view_ofs + v_forward*12 - v_up*4 + v_right* 8;

	vector mvel;
	entity fl;
	while (shotcount > 0)
	{
		mvel = (v_forward * 2000) + (v_up * 100) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		fl = Launch_Flak_SSG_SUPER(view_origin, mvel);
		fl.count = shotcount;
		shotcount = shotcount - 1;
	}
}

entity(vector org, vector vel) Launch_Flak_SSG_SUPER =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "flak");
	flak.lifetime_finished = time + 0.25;
	flak.attack_finished = time + 1;
	flak.gravity = 0;
	flak.think = FlakThink;
	flak.nextthink = time + 0.05;
	flak.touch = FlakTouch_SSG_SUPER;
	flak.alpha = 1;
	flak.oldvelocity = flak.velocity;

	SUB_ChangeModel (flak, "progs/proj_pellet.mdl");

	return flak;
}

void() FlakTouch_SSG_SUPER =
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
		T_Damage(other, self, self.trueowner, SSG_SUPER_DMG);
		
		//dprint3("Dealing damage, health ", ftos(other.health), "\n");
		SpawnBlood(self.origin, self.velocity, SSG_SUPER_DMG*10);

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
