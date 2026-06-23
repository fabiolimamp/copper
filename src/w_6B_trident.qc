//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	GRENADE_TRIBOLTqc_NAME	=	"GRENADE_TRIBOLTqc";
string	GRENADE_TRIBOLTqc_MODEL	=	"progs/placeholder_progs/v_grenade_triboltqc.mdl";


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
	
	
	float	GRENADE_TRIBOLTqc_ROF		=	1.3;		//seconds post-fire

	
	float	GRENADE_TRIBOLTqc_DMG 		=	90;	// 90*3=270	//damage per shot

	float	GRENADE_TRIBOLTqc_COST		=	3;		//ammo cost to fire
	
	float	GRENADE_TRIBOLTqc_TIMER		=	0.6;		//sec before explodey
	
	float	GRENADE_TRIBOLTqc_SPEED		=	1000;		//arc velocity
	float	GRENADE_TRIBOLTqc_GRAVITY	=	50;		//arc sinkage
	

//=============================================================================================

float() weaponanim_GRENADE_TRIBOLTqc =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - GRENADE_TRIBOLTqc_COST;

	self.attack_finished = time + GRENADE_TRIBOLTqc_ROF;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	//self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	W_Fire_GRENADE_TRIBOLTqc();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK

	self.weaponframe = 11;
	self.think = weaponanim_GRENADE_TRIBOLTqc_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_GRENADE_TRIBOLTqc_loop =
{
	if (self.weaponframe == 16)	W_Fire_GRENADE_TRIBOLTqc();
	
	if (self.weaponframe == 21)	W_Fire_GRENADE_TRIBOLTqc();
	
	
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

	self.think = weaponanim_GRENADE_TRIBOLTqc_loop;
	self.nextthink = time + 0.025;

}
//=============================================================================================

void() W_Fire_GRENADE_TRIBOLTqc =
{
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);	
	sound_grenade_fire(1);
	SuperDamageSound();
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = GRENADE_TRIBOLTqc_SPEED;
	
	vector org = self.origin + self.view_ofs + v_up*-8 + v_forward*15 + v_right*8;
	vector mvel = v_forward*base + v_up*160;
	
	launch_impaler_GRENADE_TRIBOLTqc (org, mvel + v_right*-8);
}
//=============================================================================================

entity(vector org, vector vel) launch_impaler_GRENADE_TRIBOLTqc =
{
	entity grenade;
	//gunshot(org);

	grenade = toss_projectile(org, vel, "grenade");
	grenade.lifetime_finished = time + GRENADE_TRIBOLTqc_TIMER;
	
	SUB_ChangeModel (grenade, "progs/placeholder_progs/proj_grenade_mini_nosmoke.mdl");
	
	
	grenade.think = GRENADE_TRIBOLTqc_Think;
	grenade.movetype = MOVETYPE_FLYMISSILE;
	

	
	grenade.touch = GRENADE_TRIBOLTqc_BoltTouch;		//grenade.touch = GRENADE_TRIBOLTqc_Touch;
	
	grenade.th_die = GRENADE_TRIBOLTqc_BoltExplode;		//grenade.th_die = GRENADE_TRIBOLTqc_Explode;
	
	
	
	return grenade;
}
//=============================================================================================

void() GRENADE_TRIBOLTqc_Think =
{
	if (time > self.lifetime_finished)
	{
		GRENADE_TRIBOLTqc_BoltExplode();			//GRENADE_TRIBOLTqc_Explode();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.velocity.z -= GRENADE_TRIBOLTqc_GRAVITY;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}
//=============================================================================================
//=============================================================================================
// h4724


void() GRENADE_TRIBOLTqc_BoltExplode =
{
	T_RadiusDamage (self, self.trueowner, GRENADE_TRIBOLTqc_DMG, other, DMGTYPE_EXPLOSION);
	
	BecomeExplosion();		//after timer ends
}


void() GRENADE_TRIBOLTqc_BoltTouchExplode =
{
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, GRENADE_TRIBOLTqc_DMG, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );
	}
	
	T_RadiusDamage (self, self.trueowner, GRENADE_TRIBOLTqc_DMG, other, DMGTYPE_EXPLOSION);
	
	//T_GibDownedZombies (self, GRENADE_TRIBOLTqc_DMG);
}
//=============================================================================================

void() GRENADE_TRIBOLTqc_BoltTouch =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	self.velocity = '0 0 0';
	GRENADE_TRIBOLTqc_ExplosiveTouch();
	return;
}
//=============================================================================================

void() GRENADE_TRIBOLTqc_ExplosiveTouch =
{	
	if (other == self.owner ) return;        	// don't explode on owner
	if (CheckProjectilePassthru()) return;
	if (other.takedamage == DAMAGE_AIM)
	{
		if (other.classname == "monster_shambler")
			BecomeWeakExplosion();			//BecomeMiniBlast(2); //weak, no TE_effects
		else
			BecomeExplosion();			//BecomeMiniBlast(0); //normal, no TE_effects
	
		GRENADE_TRIBOLTqc_BoltTouchExplode();
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