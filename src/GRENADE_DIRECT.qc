//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	GRENADE_DIRECT_NAME	=	"GRENADE_DIRECT";
string	GRENADE_DIRECT_MODEL	=	"progs/placeholder_progs/v_grenade_direct.mdl";


//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION
//	0.6	1	120	1	200*3=600	//QBJ3 Rebar Cannon (100+)

//=============================================================================================
	
	
	float	GRENADE_DIRECT_ROF	=	0.8;		//seconds post-fire
	
	float	GRENADE_DIRECT_DMG 	=	85;	// 	//damage per shot
	
	float	GRENADE_DIRECT_COST	=	1;		//ammo cost to fire
	
	float	GRENADE_DIRECT_TIMER	=	0.4;		//seconds before explode 2.5 default
	
	float	GRENADE_DIRECT_SPEED	=	1400;		//arc velocity
	

//=============================================================================================	

float() weaponanim_GRENADE_DIRECT =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - GRENADE_DIRECT_COST;

	self.attack_finished = time + GRENADE_DIRECT_ROF;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;



	W_Fire_GRENADE_DIRECT();



	self.weaponframe = 11;
	
	self.think = weaponanim_GRENADE_DIRECT_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_GRENADE_DIRECT_loop =
{
	if (self.weaponframe >= 30)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_GRENADE_DIRECT_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void() W_Fire_GRENADE_DIRECT =
{
	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);	
	//sound (self, CHAN_AUTO, "grenade/grenade_reload.wav", 0.5, ATTN_NORM);
	sound_grenade_fire(1);
	SuperDamageSound();
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = GRENADE_DIRECT_SPEED;
	
	vector org = self.origin + self.view_ofs + v_up*-8 + v_forward*15 + v_right*8;
	vector mvel = v_forward*base + v_up*160;
	
	launch_impaler_GRENADE_DIRECT (org, mvel + v_right*-8);
}
//=============================================================================================

entity(vector org, vector vel) launch_impaler_GRENADE_DIRECT =
{
	entity grenade;
	//gunshot(org);

	grenade = toss_projectile(org, vel, "grenade");
	grenade.lifetime_finished = time + GRENADE_DIRECT_TIMER;
	
	SUB_ChangeModel (grenade, "progs/proj_grenade.mdl");
	
	
	grenade.think = GRENADE_DIRECT_Think;
	grenade.movetype = MOVETYPE_FLYMISSILE;
	

	grenade.touch = GRENADE_DIRECT_Touch;
	grenade.th_die = GRENADE_DIRECT_Explode;
	
	return grenade;
}
//=============================================================================================

void() GRENADE_DIRECT_Think =
{
	if (time > self.lifetime_finished)
	{
		GRENADE_DIRECT_Explode();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.velocity.z -= 25;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

//=============================================================================================

void() GRENADE_DIRECT_Explode =
{
	T_RadiusDamage (self, self.trueowner, GRENADE_DIRECT_DMG, world, DMGTYPE_EXPLOSION);
	//T_GibDownedZombies (self, 120);
	
	BecomeExplosion ();
}

void() GRENADE_DIRECT_Touch =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;
	//if (other.takedamage == DAMAGE_AIM)
	//{
		self.velocity = '0 0 0';
		T_GRENADE_DIRECT_MissileExplode();
		T_GRENADE_DIRECT_ExplosiveTouch();
		return;
	//}
	//sound (self, CHAN_WEAPON, "weapons/bounce.wav", 1, ATTN_NORM);	// bounce sound
	//if (self.velocity == '0 0 0')
	//	self.avelocity = '0 0 0';
}
//=============================================================================================

void() T_GRENADE_DIRECT_ExplosiveTouch =
{
	if (other.classname == "monster_shambler")
		BecomeWeakExplosion();
	else
		//BecomeBoxExplosion();
		BecomeExplosion();
}

void() T_GRENADE_DIRECT_MissileExplode =
{
	local float	damg;
	damg = GRENADE_DIRECT_DMG;
	
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, damg, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );	// so ogre rockets kill zombies despite being too weak
	}

	// don't do radius damage to other, because all damage will be done in the impact
	T_RadiusDamage (self, self.trueowner, GRENADE_DIRECT_DMG, other, DMGTYPE_EXPLOSION);
}
//=============================================================================================