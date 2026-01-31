//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SHOTGUN_COWBOYv2_NAME	=	"SHOTGUN_COWBOYv2";
string	SHOTGUN_COWBOYv2_MODEL	=	"progs/placeholder_progs/v_shotgun_cowboy.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)
//	0.8	11	5	1	'220 180 0'		//fade flak (55)
//	0.8	13	4	1	'220 180 0'		//fade flak (52)
//	0.8	13	4	1	'220 180 0'		//fade flak (52)
//	0.8	10	5	1	'160 240 0'		//Cowbow maresleg (50*)
//	0.8	10	5	1	'160 240 0'		//COWBOYv2	(50*)


//=============================================================================================
	
	
	float	SHOTGUN_COWBOYv2_ROF	=	0.8;		//seconds post-fire
	
	float	SHOTGUN_COWBOYv2_COUNT	=	10;		//number of shots
	float	SHOTGUN_COWBOYv2_DMG 	=	5;	//60	//damage per shot

	float	SHOTGUN_COWBOYv2_COST	=	1;		//ammo cost to fire
	float	SHOTGUN_COWBOYv2_LIFE	=	0.5;		//seconds for pellet
	
	float	SHOTGUN_COWBOYv2_SPEED	=	1400;		//2000 ups
	
	vector	SHOTGUN_COWBOYv2_SPREAD	=	'180 120 0';	//seconds post-fire	//W_Fire_SHOTGUN_COWBOYv2_flak


//=============================================================================================

float() weaponanim_SHOTGUN_COWBOYv2 =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_COWBOYv2_COST;
	self.attack_finished = time + SHOTGUN_COWBOYv2_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	//self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	W_Fire_SHOTGUN_COWBOYv2_flak();

	self.weaponframe = 11;	
	self.think = weaponanim_SHOTGUN_COWBOYv2_loop;
	self.nextthink = time + 0.04;	
	return TRUE;
}

void() weaponanim_SHOTGUN_COWBOYv2_loop =
{
	if (intermission) return;

	if (self.weaponframe == 21) 
	{
		Eject_BuckshotCasing();
		sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	}
	
	//if (self.weaponframe >= 40)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 30)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SHOTGUN_COWBOYv2_loop;
	self.nextthink = time + 0.04;
}

//=============================================================================================

void() W_Fire_SHOTGUN_COWBOYv2_flak =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun1.wav", 0.4, ATTN_NORM);
	sound_shotgun_shoot(0.5);
	
	makevectors(self.v_angle);
	self.punchangle_x = -2;
	
	float shotcount = SHOTGUN_COWBOYv2_COUNT;
	vector spread = SHOTGUN_COWBOYv2_SPREAD;
	vector view_origin = self.origin + self.view_ofs + v_forward*12 + v_up*-4 + v_right*4;

	vector mvel;
	entity fl;
	while (shotcount > 0)
	{
		mvel = (v_forward * SHOTGUN_COWBOYv2_SPEED) + (v_up * 40) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		fl = Launch_Flak_SHOTGUN_COWBOYv2(view_origin, mvel);

		fl.count = shotcount;
		shotcount = shotcount - 1;
	}
}


entity(vector org, vector vel) Launch_Flak_SHOTGUN_COWBOYv2 =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "flak");
	flak.lifetime_finished = time + SHOTGUN_COWBOYv2_LIFE;
	flak.attack_finished = time + 1;
	flak.gravity = 0;
	flak.think = FlakThink;
	flak.nextthink = time + 0.05;
	flak.touch = FlakTouch_SHOTGUN_COWBOYv2;
	flak.alpha = 1;
	flak.oldvelocity = flak.velocity;
	flak.movetype = MOVETYPE_FLYMISSILE;

	SUB_ChangeModel (flak, "progs/proj_pellet.mdl");

	return flak;
}

void() FlakTouch_SHOTGUN_COWBOYv2 =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, SHOTGUN_COWBOYv2_DMG);

		if (other.solid != SOLID_BSP) {
			//ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(SHOTGUN_COWBOYv2_DMG));
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