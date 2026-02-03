//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SHOTGUN_SAWED_NAME	=	"SHOTGUN_SAWED";
string	SHOTGUN_SAWED_MODEL	=	"progs/placeholder_progs/v_shotgun_sawed.mdl";


//	ROF	COUNT * DMG	COST	SPREAD		LIFETIME	DESCRIPTION
//	1	18	5	1	'270 60 0'	1++		//QBJ3 flak 	(90)	point
//	0.8	10	5	1	'160 240 0'	0.5		//COWBOYv2	(50*)	bbox
//	1.5	20	5	2	'300 200 0'	0.5		//SAWED OFF	(100)	bbox
//	1.7	25	5	2	'300 200 0'	0.5		//SAWED OFF	(125)	point
//	1.6	20	6	2	'300 200 0'	0.5		//SAWED OFF	(120)	point


//=============================================================================================
	
	
	float	SHOTGUN_SAWED_ROF	=	1.6;		//seconds post-fire
	
	float	SHOTGUN_SAWED_COUNT	=	20;		//number of shots
	float	SHOTGUN_SAWED_DMG 	=	6;	//60	//damage per shot

	float	SHOTGUN_SAWED_COST	=	2;		//ammo cost to fire
	float	SHOTGUN_SAWED_LIFE	=	0.5;		//seconds for pellet
	
	float	SHOTGUN_SAWED_SPEED	=	1400;		//2000 ups
	
	vector	SHOTGUN_SAWED_SPREAD	=	'300 200 0';	//seconds post-fire	//W_Fire_SHOTGUN_SAWED_flak


//=============================================================================================

float() weaponanim_SHOTGUN_SAWED =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_SAWED_COST;
	self.attack_finished = time + SHOTGUN_SAWED_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	//self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	W_Fire_SHOTGUN_SAWED_flak();

	self.weaponframe = 11;	
	self.think = weaponanim_SHOTGUN_SAWED_loop;
	self.nextthink = time + 0.05;	
	return TRUE;
}

void() weaponanim_SHOTGUN_SAWED_loop =
{
	if (intermission) return;

	if (self.weaponframe == 22) 
	{
		Eject_BuckshotCasing();
		Eject_BuckshotCasing();
		sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	}

	//if (self.weaponframe >= 40)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe == 34) sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SHOTGUN_SAWED_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void() W_Fire_SHOTGUN_SAWED_flak =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun1.wav", 0.5, ATTN_NORM);
	sound_shotgun_shoot(0.5);
	
	makevectors(self.v_angle);
	self.punchangle_x = -3;
	
	float shotcount = SHOTGUN_SAWED_COUNT;
	vector spread = SHOTGUN_SAWED_SPREAD;
	vector view_origin = self.origin + self.view_ofs + v_forward*12 + v_up*-4 + v_right*4;

	vector mvel;
	entity fl;
	while (shotcount > 0)
	{
		mvel = (v_forward * SHOTGUN_SAWED_SPEED) + (v_up * 40) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		fl = Launch_Flak_SHOTGUN_SAWED(view_origin, mvel);

		fl.count = shotcount;
		shotcount = shotcount - 1;
	}
}


entity(vector org, vector vel) Launch_Flak_SHOTGUN_SAWED =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "flak");
	flak.lifetime_finished = time + SHOTGUN_SAWED_LIFE;
	flak.attack_finished = time + 1;
	flak.gravity = -0.1;
	flak.think = FlakThink;
	flak.nextthink = time + 0.05;
	//flak.touch = FlakTouch_SHOTGUN_SAWED_pierce;
	flak.touch = FlakTouch_SHOTGUN_SAWED;
	flak.alpha = 1;
	flak.oldvelocity = flak.velocity;
	//flak.movetype = MOVETYPE_FLYMISSILE;

	SUB_ChangeModel (flak, "progs/proj_pellet.mdl");

	return flak;
}
//=============================================================================================
//=============================================================================================
//=============================================================================================


void() FlakTouch_SHOTGUN_SAWED_pierce =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, SHOTGUN_SAWED_DMG);

		if (other.solid != SOLID_BSP) {
			//ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(SHOTGUN_SAWED_DMG));
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
		FX_Impact(FX_SPARK, self.origin, self.origin);
		remove(self);	
}

//=============================================================================================
//=============================================================================================
//=============================================================================================
void() FlakTouch_SHOTGUN_SAWED =
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

		T_Damage(other, self, self.trueowner, SHOTGUN_SAWED_DMG);
		
		//dprint3("Dealing damage, health ", ftos(other.health), "\n");
		SpawnBlood(self.origin, self.velocity, 50);

		if (random() < 0.25)	FX_Impact(FX_BLOOD_BIG, self.origin, self.velocity);

		sound_flakshotgun_impact();

		if (other.health <= 0) projectile_passthru();
		else remove(self);
		
		return;
	}
	FX_Impact(FX_SPARK, self.origin, self.origin);
	remove(self);
	
	/*
	if (CheckProjectilePassthru()) return;
	
	if (self.attack_finished < time) {
		remove(self);
		return;
	}
	
	//FlakBounce();

	if (other.takedamage)
	{
		if (other.classname == "monster_swarmer" || other.classname == "monster_fish")
			if (other.health <= 5)
				if (random() < 0.5)
					T_Damage(other, self, self.trueowner, 50);	//gib anything about to die from 1 pellet
		
		//T_Damage(other, self, self.trueowner, 4);
		T_Damage(other, self, self.trueowner, SHOTGUN_SAWED_DMG);
		
		//SpawnBlood(self.origin, self.velocity, 40);
		SpawnBlood(self.origin, self.velocity, 50);
		sound_flakshotgun_impact();

		if (other.health <= 0) projectile_passthru();
		else remove(self);

		return;
	}
	FX_Impact(FX_SPARK, self.origin, self.origin);
	remove(self);
	//gunshot(self.origin);
	*/
}