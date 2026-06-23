//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SHOTGUN_STACK_NAME	=	"SHOTGUN_STACK";
string	SHOTGUN_STACK_MODEL	=	"progs/placeholder_progs/v_shotgun_stack.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)


//=============================================================================================
	
	
	float	SHOTGUN_STACK_ROF	=	1.8;		//seconds post-fire
	
	float	SHOTGUN_STACK_COUNT	=	11;		//number of shots
	float	SHOTGUN_STACK_DMG 	=	6;	//66	//damage per shot

	float	SHOTGUN_STACK_COST	=	2;		//ammo cost to fire
	
	//vector	SHOTGUN_STACK_SPREAD	=	'0.15 0.15 0';	//seconds post-fire	//W_Fire_SHOTGUN_STACK_hitscan
	vector	SHOTGUN_STACK_SPREAD	=	'120 240 0';	//seconds post-fire	//W_Fire_SHOTGUN_STACK_hitscan


//=============================================================================================

float() weaponanim_SHOTGUN_STACK =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_STACK_COST;
	self.attack_finished = time + SHOTGUN_STACK_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	//W_Fire_SHOTGUN_STACK_hitscan();
	W_Fire_SHOTGUN_STACK_flak();

	self.weaponframe = 15;	
	self.think = weaponanim_SHOTGUN_STACK_loop;
	self.nextthink = time + 0.05;	
	return TRUE;
}

void() weaponanim_SHOTGUN_STACK_loop =
{
	if (intermission) return;
	
	//if (self.weaponframe == 20)	W_Fire_SHOTGUN_STACK_hitscan();
	if (self.weaponframe == 20)	W_Fire_SHOTGUN_STACK_flak();
	
	if (self.weaponframe == 33)
	{	
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

	self.think = weaponanim_SHOTGUN_STACK_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================
/*
void() W_Fire_SHOTGUN_STACK_hitscan =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun1.wav", 0.3, ATTN_NORM);
	
	makevectors (self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  8 + v_forward * 8;
	vector org_eye = self.origin + self.view_ofs;
	
	vector spread = SHOTGUN_STACK_SPREAD;

	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);	//aim point directly in front of the crosshair
	vector dir_eye = normalize(trace_endpos - org_eye);
		
	ClearMultiDamage ();
	FirePistolBullets (SHOTGUN_STACK_COUNT, SHOTGUN_STACK_DMG, org_eye, org_gun + v_forward * 16 * trace_fraction, dir_eye, spread, TRUE);
	
	ApplyMultiDamage ();
	self.punchangle_x = -2;	//punch AFTER makevectors
};
*/
//=============================================================================================

void() W_Fire_SHOTGUN_STACK_flak =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun1.wav", 0.3, ATTN_NORM);
	
	makevectors(self.v_angle);
	self.punchangle_x = -2;
	
	float shotcount = SHOTGUN_STACK_COUNT;
	vector spread = SHOTGUN_STACK_SPREAD;
	vector view_origin = self.origin + self.view_ofs + v_forward*12 - v_up*4 + v_right* 8;

	vector mvel;
	entity fl;
	while (shotcount > 0)
	{
		mvel = (v_forward * 2000) + (v_up * 100) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		fl = Launch_Flak_SHOTGUN_STACK(view_origin, mvel);
		fl.count = shotcount;
		shotcount = shotcount - 1;
	}
}

entity(vector org, vector vel) Launch_Flak_SHOTGUN_STACK =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "flak");
	flak.lifetime_finished = time + 0.25;
	flak.attack_finished = time + 1;
	flak.gravity = 0;
	flak.think = FlakThink;
	flak.nextthink = time + 0.05;
	flak.touch = FlakTouch_SHOTGUN_STACK;
	flak.alpha = 1;
	flak.oldvelocity = flak.velocity;

	SUB_ChangeModel (flak, "progs/proj_pellet.mdl");

	return flak;
}

void() FlakTouch_SHOTGUN_STACK =
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
		T_Damage(other, self, self.trueowner, SHOTGUN_STACK_DMG);
		
		//dprint3("Dealing damage, health ", ftos(other.health), "\n");
		SpawnBlood(self.origin, self.velocity, SHOTGUN_STACK_DMG*10);

		if (random() < 0.25)	FX_Impact(FX_BLOOD_BIG, self.origin, self.velocity);

		sound_flakshotgun_impact();

		if (other.health <= 0) projectile_passthru();
		else remove(self);
		
		return;
	}

	//FlakBounce();
	gunshot(self.origin);

	//self.touch = FlakTouch_2;
	//self.lifetime_finished = time + 0.2;
	
	float chance = random();

	if (chance < 0.33) sound(self, CHAN_AUTO, "weapons/ric1.wav", 0.25, ATTN_NORM);
	else if (chance < 0.5) sound(self, CHAN_AUTO, "weapons/ric2.wav", 0.25, ATTN_NORM);
	else sound(self, CHAN_AUTO, "weapons/ric3.wav", 0.25, ATTN_NORM);
}