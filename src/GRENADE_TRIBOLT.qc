//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	GRENADE_TRIBOLT_NAME	=	"GRENADE_TRIBOLT";
//string	GRENADE_TRIBOLT_MODEL	=	"progs/placeholder_progs/v_grenade_crossbow.mdl";
//string	GRENADE_TRIBOLT_MODEL	=	"progs/placeholder_progs/v_grenade_tribolt.mdl";
string	GRENADE_TRIBOLT_MODEL	=	"progs/placeholder_progs/v_grenade_triple.mdl";


//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION

//	0.8	1	85	1	1400		//Grenade DIRECT	0.4 timer (85) contact

//	1.2	3	60	2	1000		//Grenade TRIBOLT	0.4 timer (165) contact

//=============================================================================================
	
	
	float	GRENADE_TRIBOLT_ROF	=	1.2;		//seconds post-fire
	
	float	GRENADE_TRIBOLT_DMG 	=	60;	// 60*3=180	//damage per shot

	float	GRENADE_TRIBOLT_COST	=	2;		//ammo cost to fire
	
	float	GRENADE_TRIBOLT_TIMER	=	0.4;		//sec before explodey
	
	float	GRENADE_TRIBOLT_SPEED	=	1000;		//arc velocity
	float	GRENADE_TRIBOLT_GRAVITY	=	50;		//arc sinkage
	

//=============================================================================================

float() weaponanim_GRENADE_TRIBOLT =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - GRENADE_TRIBOLT_COST;

	self.attack_finished = time + GRENADE_TRIBOLT_ROF;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	//self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	W_Fire_GRENADE_TRIBOLT();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK

	self.weaponframe = 11;
	self.think = weaponanim_GRENADE_TRIBOLT_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_GRENADE_TRIBOLT_loop =
{
	if (self.weaponframe == 12)	W_Fire_GRENADE_TRIBOLT();
	
	if (self.weaponframe == 14)	W_Fire_GRENADE_TRIBOLT();
	
	
	if (self.weaponframe == 20)	{
		//sound (self, CHAN_AUTO, "rebar/bow_reload2.wav", 0.3, ATTN_NORM);
		sound (self, CHAN_AUTO, "grenade/grenade_reload.wav", 1, ATTN_NORM);
		self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	}
	if (self.weaponframe == 25)	sound (self, CHAN_AUTO, "rebar/bow_clank.wav", 0.4, ATTN_NORM);
	
	
		
	if (self.weaponframe >= 30)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_GRENADE_TRIBOLT_loop;
	self.nextthink = time + 0.05;

}
//=============================================================================================

void() W_Fire_GRENADE_TRIBOLT =
{
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);	
	//sound (self, CHAN_AUTO, "grenade/grenade_reload.wav", 0.5, ATTN_NORM);
	sound_grenade_fire(1);
	SuperDamageSound();
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = GRENADE_TRIBOLT_SPEED;
	
	vector org = self.origin + self.view_ofs + v_up*-8 + v_forward*15 + v_right*8;
	vector mvel = v_forward*base + v_up*160;
	
	launch_impaler_GRENADE_TRIBOLT (org, mvel + v_right*-8);
}
//=============================================================================================

entity(vector org, vector vel) launch_impaler_GRENADE_TRIBOLT =
{
	entity grenade;
	//gunshot(org);

	grenade = toss_projectile(org, vel, "grenade");
	grenade.lifetime_finished = time + GRENADE_TRIBOLT_TIMER;
	
	SUB_ChangeModel (grenade, "progs/placeholder_progs/proj_grenade_mini_nosmoke.mdl");
	
	
	grenade.think = GRENADE_TRIBOLT_Think;
	grenade.movetype = MOVETYPE_FLYMISSILE;
	

	grenade.touch = GRENADE_TRIBOLT_Touch;
	grenade.th_die = GRENADE_TRIBOLT_Explode;
	
	return grenade;
}
//=============================================================================================

void() GRENADE_TRIBOLT_Think =
{
	if (time > self.lifetime_finished)
	{
		GRENADE_TRIBOLT_Explode();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.velocity.z -= GRENADE_TRIBOLT_GRAVITY;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

//=============================================================================================

void() GRENADE_TRIBOLT_Explode =
{
	T_RadiusDamage (self, self.trueowner, GRENADE_TRIBOLT_DMG, world, DMGTYPE_EXPLOSION);
	//T_GibDownedZombies (self, 120);
	
	//BecomeMiniBlast(0); //normal, no TE_effects
	BecomeTarExplosion();
	//BecomeExplosion();
}

void() GRENADE_TRIBOLT_Touch =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

		self.velocity = '0 0 0';
		T_GRENADE_TRIBOLT_MissileExplode();
		T_GRENADE_TRIBOLT_ExplosiveTouch();
		return;
}
//=============================================================================================

void() T_GRENADE_TRIBOLT_ExplosiveTouch =
{
	if (other.classname == "monster_shambler")
		BecomeMiniBlast(2); //weak, no TE_effects
		//BecomeWeakExplosion();
	else
		//BecomeMiniBlast(0); //normal, no TE_effects
		BecomeTarExplosion();
		//BecomeExplosion();
}

void() T_GRENADE_TRIBOLT_MissileExplode =
{
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, GRENADE_TRIBOLT_DMG, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );	// so ogre rockets kill zombies despite being too weak
	}

	// don't do radius damage to other, because all damage will be done in the impact
	T_RadiusDamage (self, self.trueowner, GRENADE_TRIBOLT_DMG, other, DMGTYPE_EXPLOSION);
}
//=============================================================================================