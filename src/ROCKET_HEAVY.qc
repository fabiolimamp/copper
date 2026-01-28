//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	ROCKET_HEAVY_NAME	=	"ROCKET_HEAVY";
string	ROCKET_HEAVY_MODEL	=	"progs/placeholder_progs/v_rocket_heavy.mdl";

//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION
//	0.8	1	120	1	1000		//ID RL (120+)
//	1.2	1	160	1	700		//RPG (160)

//=============================================================================================
	
	
	float	ROCKET_HEAVY_ROF	=	1.2;		//seconds post-fire
	
	float	ROCKET_HEAVY_DMG_MAIN	=	100;		//damage per shot
	float	ROCKET_HEAVY_DMG_ADD	=	60;	 	//damage per shot
	
	float	ROCKET_HEAVY_COST	=	1;		//ammo cost to fire
	
	float	ROCKET_HEAVY_SPEED	=	800;		//rocket speed
	float	ROCKET_HEAVY_GRAVITY	=	20;		//25 grav
	

//=============================================================================================	

float() weaponanim_ROCKET_HEAVY =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - ROCKET_HEAVY_COST;

	self.attack_finished = time + ROCKET_HEAVY_ROF;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;



	W_Fire_ROCKET_HEAVY();



	self.weaponframe = 11;
	
	self.think = weaponanim_ROCKET_HEAVY_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_ROCKET_HEAVY_loop =
{
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_ROCKET_HEAVY_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void() W_Fire_ROCKET_HEAVY =
{
	local entity missile;
	local vector loc;
	
	//self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;
	
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);

	self.punchangle_x = -4;
	
	makevectors (self.v_angle);
	loc = self.origin + v_forward * 8 + '0 0 16' + v_right*8;
	
	missile = launch_ROCKET_HEAVY( loc, v_forward * ROCKET_HEAVY_SPEED );
	//self.attack_finished = time + 0.8;
}

entity(vector org, vector vel) launch_ROCKET_HEAVY =
{
	entity missile;
	
	missile = launch_projectile(org, vel, "rocket");	// FLYMISSILE

	missile.touch = T_ROCKET_HEAVY_Touch;
	missile.type = "missile";
	
	missile.nextthink = time + 0.05;
	missile.think = ROCKET_HEAVY_think;
	
	//SUB_ChangeModel (missile, "progs/proj_missile.mdl");
	SUB_ChangeModel (missile, "progs/placeholder_progs/proj_missile_heavy.mdl");
	
	return missile;
}
//=============================================================================================

void() ROCKET_HEAVY_think =
{
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.velocity.z -= ROCKET_HEAVY_GRAVITY;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

//=============================================================================================

void() T_ROCKET_HEAVY_Touch =
{
	if (other == self.owner) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	T_ROCKET_HEAVY_Explode();

	self.origin = self.origin - 8*normalize(self.velocity);
	T_ROCKET_HEAVY_ExplosiveTouch();
}
//=============================================================================================

void() T_ROCKET_HEAVY_ExplosiveTouch =
{
	if (other.classname == "monster_shambler")
		BecomeWeakExplosion();
	else
		//BecomeExplosion();
		BecomeBoxExplosion();	//big
}

void() T_ROCKET_HEAVY_Explode =
{
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, ROCKET_HEAVY_DMG_MAIN + ROCKET_HEAVY_DMG_ADD, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );	// so ogre rockets kill zombies despite being too weak
	}

	// don't do radius damage to other, because all damage will be done in the impact
	T_RadiusDamage (self, self.trueowner, ROCKET_HEAVY_DMG_MAIN, other, DMGTYPE_EXPLOSION);
	T_RadiusDamage (self, self.trueowner, ROCKET_HEAVY_DMG_ADD, other, DMGTYPE_EXPLOSION);
}
