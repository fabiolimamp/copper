//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	TRIDENT_NAME	=	"TRIDENT";
string	TRIDENT_MODEL	=	"progs/placeholder_progs/v_grenade_triboltqc.mdl";


//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION

//	0.8	1	85	1	1400		//Grenade DIRECT	0.4 timer (85) contact

//	1.2	3	60	2	1000		//Grenade TRIBOLT	0.4 timer (165) contact

//=============================================================================================

													
	//1.3 total  1st on 0, 2nd on 0.11,  3rd on 0.25 (timer = 0.6 sec)
	//1.3 total  1st on 0, 2nd on 0.125, 3rd on 0.25 (timer = 0.6 sec) 40 FPS*
	
	
	//52  total  1st on 0, 2nd on 5,     3rd on 10   (timer = 24 frames) 40 FPS*
	
	
	//63  total  1st on 11, 2nd on 16,   3rd on 21   (timer = 24 frames) 40 FPS* (add + 11 for draw!)
	
	
	/*
	frames = seconds
	---------------- 
	40 = 1
	20 = 0.5
	10 = 0.25
	5 = 0.125
	2 = 0.05
	1 = 0.025
	*/

//=============================================================================================
	
	
	float	TRIDENT_COOLDOWN		=	1.3;		//seconds post-fire

	
	float	TRIDENT_DAMAGE 		=	90;	// 90*3=270	//damage per shot

	float	TRIDENT_COST		=	3;		//ammo cost to fire
	
	float	TRIDENT_TIMER		=	0.6;		//sec before explodey
	
	float	TRIDENT_VELOCITY		=	1000;		//arc velocity
	float	TRIDENT_GRAVITY	=	50;		//arc sinkage
	

//=============================================================================================

float() weaponanim_TRIDENT =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - TRIDENT_COST;

	self.attack_finished = time + TRIDENT_COOLDOWN;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	//self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	W_Fire_TRIDENT();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK

	self.weaponframe = 11;
	self.think = weaponanim_TRIDENT_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_TRIDENT_loop =
{
	if (self.weaponframe == 16)	W_Fire_TRIDENT();
	
	if (self.weaponframe == 21)	W_Fire_TRIDENT();
	
	
	if (self.weaponframe == 40)
	{
		sound (self, CHAN_AUTO, "grenade/grenade_reload.wav", 1, ATTN_NORM);
		self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	}
	
	if (self.weaponframe == 50)	sound (self, CHAN_AUTO, "rebar/bow_clank.wav", 0.4, ATTN_NORM);
	
	
		
	if (self.weaponframe >= 70)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_TRIDENT_loop;
	self.nextthink = time + 0.025;

}
//=============================================================================================

void() W_Fire_TRIDENT =
{
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);	
	sound_grenade_fire(1);
	SuperDamageSound();
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = TRIDENT_VELOCITY;
	
	vector org = self.origin + self.view_ofs + v_up*-8 + v_forward*15 + v_right*8;
	vector mvel = v_forward*base + v_up*160;
	
	launch_impaler_TRIDENT (org, mvel + v_right*-8);
}
//=============================================================================================

entity(vector org, vector vel) launch_impaler_TRIDENT =
{
	entity grenade;
	//gunshot(org);

	grenade = toss_projectile(org, vel, "grenade");
	grenade.lifetime_finished = time + TRIDENT_TIMER;
	
	SUB_ChangeModel (grenade, "progs/placeholder_progs/proj_grenade_mini_nosmoke.mdl");
	
	
	grenade.think = TRIDENT_Think;
	grenade.movetype = MOVETYPE_FLYMISSILE;
	

	
	grenade.touch = TRIDENT_BoltTouch;		//grenade.touch = TRIDENT_Touch;
	
	grenade.th_die = TRIDENT_BoltExplode;		//grenade.th_die = TRIDENT_Explode;
	
	
	
	return grenade;
}
//=============================================================================================

void() TRIDENT_Think =
{
	if (time > self.lifetime_finished)
	{
		TRIDENT_BoltExplode();			//TRIDENT_Explode();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.velocity.z -= TRIDENT_GRAVITY;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}
//=============================================================================================
//=============================================================================================
// h4724


void() TRIDENT_BoltExplode =
{
	T_RadiusDamage (self, self.trueowner, TRIDENT_DAMAGE, other, DMGTYPE_EXPLOSION);
	
	BecomeExplosion();		//after timer ends
}


void() TRIDENT_BoltTouchExplode =
{
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, TRIDENT_DAMAGE, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );
	}
	
	T_RadiusDamage (self, self.trueowner, TRIDENT_DAMAGE, other, DMGTYPE_EXPLOSION);
	
	//T_GibDownedZombies (self, TRIDENT_DAMAGE);
}
//=============================================================================================

void() TRIDENT_BoltTouch =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	self.velocity = '0 0 0';
	TRIDENT_ExplosiveTouch();
	return;
}
//=============================================================================================

void() TRIDENT_ExplosiveTouch =
{	
	if (other == self.owner ) return;        	// don't explode on owner
	if (CheckProjectilePassthru()) return;
	if (other.takedamage == DAMAGE_AIM)
	{
		if (other.classname == "monster_shambler")
			BecomeWeakExplosion();			//BecomeMiniBlast(2); //weak, no TE_effects
		else
			BecomeExplosion();			//BecomeMiniBlast(0); //normal, no TE_effects
	
		TRIDENT_BoltTouchExplode();
		self.velocity = '0 0 0';
		return;
	}
	else
	{    
		// stop moving, stop turning and don't move again.
		self.velocity = '0 0 0';
		self.avelocity = '0 0 0';
		self.movetype = MOVETYPE_NONE;
	}
	
	sound_nailgun_impact_world(self.origin, 1);		// placeholder stick sound
	FX_Impact(FX_SPARK, self.origin + v_forward*-4, 0);	// placeholder stick effect
}