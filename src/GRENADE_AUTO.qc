//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	GRENADE_AUTO_NAME	=	"GRENADE_AUTO";
string	GRENADE_AUTO_MODEL	=	"progs/placeholder_progs/v_grenade_auto2.mdl";


//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION

//	0.8	1	85	1	1400		//Grenade DIRECT	0.4 timer (85) contact

//=============================================================================================
	
	
	float	GRENADE_AUTO_ROF	=	0.8;		//seconds post-fire
	
	float	GRENADE_AUTO_DMG 	=	65;	// 	//damage per shot
	
	float	GRENADE_AUTO_COST	=	1;		//ammo cost to fire
	
	float	GRENADE_AUTO_TIMER	=	0.5;		//seconds before explode 2.5 default
	
	float	GRENADE_AUTO_SPEED	=	800;		//arc velocity
	float	GRENADE_AUTO_GRAVITY	=	25;		//25 = rebar
	

//=============================================================================================	

float() weaponanim_GRENADE_AUTO =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - GRENADE_AUTO_COST;

	self.attack_finished = time + GRENADE_AUTO_ROF;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;



	W_Fire_GRENADE_AUTO(0);



	self.weaponframe = 11;
	
	self.think = weaponanim_GRENADE_AUTO_loop;
	self.nextthink = time + 0.04;
	
	return TRUE;
}

void() weaponanim_GRENADE_AUTO_loop =
{
	if (self.weaponframe == 21)	W_Fire_GRENADE_AUTO(1);
	
	
	if (self.weaponframe >= 30)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_GRENADE_AUTO_loop;
	self.nextthink = time + 0.04;
}

//=============================================================================================

void(float offset) W_Fire_GRENADE_AUTO =
{
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);	
	//sound (self, CHAN_AUTO, "grenade/grenade_reload.wav", 0.5, ATTN_NORM);
	sound_grenade_fire(1);
	SuperDamageSound();
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = GRENADE_AUTO_SPEED;
	
	vector org;
	
	if (offset == 0 )	org = self.origin + self.view_ofs + v_up*-4 + v_forward*15 + v_right*8;
	else			org = self.origin + self.view_ofs + v_up*-12 + v_forward*15 + v_right*8;
	
	vector mvel = v_forward*base + v_up*160;
	
	launch_impaler_GRENADE_AUTO (org, mvel + v_right*-8);
}
//=============================================================================================

entity(vector org, vector vel) launch_impaler_GRENADE_AUTO =
{
	entity grenade;
	//gunshot(org);

	grenade = toss_projectile(org, vel, "grenade");
	grenade.lifetime_finished = time + GRENADE_AUTO_TIMER;
	
	//SUB_ChangeModel (grenade, "progs/proj_grenade.mdl");
	//SUB_ChangeModel (grenade, "progs/placeholder_progs/proj_grenade_mini.mdl");
	SUB_ChangeModel (grenade, "progs/placeholder_progs/proj_grenade_mini_nosmoke.mdl");
	
	
	grenade.think = GRENADE_AUTO_Think;
	grenade.movetype = MOVETYPE_FLYMISSILE;
	

	grenade.touch = GRENADE_AUTO_Touch;
	grenade.th_die = GRENADE_AUTO_Explode;
	
	return grenade;
}
//=============================================================================================

void() GRENADE_AUTO_Think =
{
	if (time > self.lifetime_finished)
	{
		GRENADE_AUTO_Explode();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.velocity.z -= GRENADE_AUTO_GRAVITY;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

//=============================================================================================

void() GRENADE_AUTO_Explode =
{
	T_RadiusDamage (self, self.trueowner, GRENADE_AUTO_DMG, world, DMGTYPE_EXPLOSION);
	//T_GibDownedZombies (self, 120);
	
	//BecomeExplosion ();
	BecomeTarExplosion();
}

void() GRENADE_AUTO_Touch =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;
	//if (other.takedamage == DAMAGE_AIM)
	//{
		self.velocity = '0 0 0';
		T_GRENADE_AUTO_MissileExplode();
		T_GRENADE_AUTO_ExplosiveTouch();
		return;
	//}
	//sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);	// bounce sound
	//if (self.velocity == '0 0 0')
	//	self.avelocity = '0 0 0';
}
//=============================================================================================

void() T_GRENADE_AUTO_ExplosiveTouch =
{
	if (other.classname == "monster_shambler")
		//BecomeWeakExplosion();
		BecomeMiniBlast(2); //weak, no TE_effects
	else
		//BecomeBoxExplosion();
		//BecomeExplosion();
		BecomeTarExplosion();
}

void() T_GRENADE_AUTO_MissileExplode =
{
	local float	damg;
	damg = GRENADE_AUTO_DMG;
	
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, damg, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );	// so ogre rockets kill zombies despite being too weak
	}

	// don't do radius damage to other, because all damage will be done in the impact
	T_RadiusDamage (self, self.trueowner, GRENADE_AUTO_DMG, other, DMGTYPE_EXPLOSION);
}
//=============================================================================================