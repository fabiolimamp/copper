//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	ROCKET_DOUBLE_NAME	=	"ROCKET_DOUBLE";
string	ROCKET_DOUBLE_MODEL	=	"progs/placeholder_progs/v_rocket_double.mdl";

//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION
//	0.8	1	120	1	1000		//ID RL (120+)
//	1.2	1	160	1	700		//RPG (160)

//=============================================================================================
	
	
	float	ROCKET_DOUBLE_ROF		=	1.6;		//seconds post-fire
	
	float	ROCKET_DOUBLE_DMG_MAIN		=	60;		//damage per shot
	float	ROCKET_DOUBLE_DMG_ADD		=	60;	 	//damage per shot
	
	float	ROCKET_DOUBLE_COST		=	2;		//ammo cost to fire
		
	float	ROCKET_DOUBLE_SPEED_BASE	=	40;		//rocket speed start
	float	ROCKET_DOUBLE_SPEED_MULTI	=	1.6;		//accelerator	
	
	float	ROCKET_DOUBLE_SPEED_MAX		=	2000;		//rocket speed limit
	

//=============================================================================================

float() weaponanim_ROCKET_DOUBLE =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - ROCKET_DOUBLE_COST;

	self.attack_finished = time + ROCKET_DOUBLE_ROF;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;



	W_Fire_ROCKET_DOUBLE(0);
	W_Fire_ROCKET_DOUBLE(1);



	self.weaponframe = 11;
	
	self.think = weaponanim_ROCKET_DOUBLE_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_ROCKET_DOUBLE_loop =
{
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_ROCKET_DOUBLE_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void(float offset) W_Fire_ROCKET_DOUBLE =
{
	local entity missile;
	local vector loc;
		
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);

	self.punchangle_x = -4;
	
	makevectors (self.v_angle);
	
	if (offset == 0)	loc = self.origin + v_forward * 8 + '0 0 22' + v_right*12;
	else			loc = self.origin + v_forward * 8 + '0 0 10' + v_right*12;
	
	missile = launch_ROCKET_DOUBLE( loc, v_forward * 1 );
	self.attack_finished = time + 1.2;
}
//=============================================================================================

entity(vector org, vector vel) launch_ROCKET_DOUBLE =
{
	entity missile;
	
	missile = launch_projectile(org, vel, "rocket");	// FLYMISSILE

	missile.touch = T_ROCKET_DOUBLE_Touch;
	missile.type = "missile";
	
	missile.nextthink = time;
	missile.velocity = v_forward * ROCKET_DOUBLE_SPEED_BASE;
	missile.think = ROCKET_DOUBLE_think;
	
	SUB_ChangeModel (missile, "progs/proj_missile.mdl");
	
	return missile;
}
//=============================================================================================

void() ROCKET_DOUBLE_think =
{
	float spd = vlen(self.velocity);
	spd *= ROCKET_DOUBLE_SPEED_MULTI;
	if (spd > ROCKET_DOUBLE_SPEED_MAX) spd = ROCKET_DOUBLE_SPEED_MAX;
	self.velocity = normalize(self.velocity) * spd;

	
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

//=============================================================================================

void() T_ROCKET_DOUBLE_Touch =
{
	if (other == self.owner) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	T_ROCKET_DOUBLE_Explode();

	self.origin = self.origin - 8*normalize(self.velocity);
	T_ROCKET_DOUBLE_ExplosiveTouch();
}
//=============================================================================================

void() T_ROCKET_DOUBLE_ExplosiveTouch =
{
	if (other.classname == "monster_shambler")
		BecomeWeakExplosion();
	else
		//BecomeExplosion();
		BecomeBoxExplosion();	//big
}

void() T_ROCKET_DOUBLE_Explode =
{
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, ROCKET_DOUBLE_DMG_MAIN + ROCKET_DOUBLE_DMG_ADD, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );	// so ogre rockets kill zombies despite being too weak
	}

	// don't do radius damage to other, because all damage will be done in the impact
	T_RadiusDamage (self, self.trueowner, ROCKET_DOUBLE_DMG_MAIN, other, DMGTYPE_EXPLOSION);
	T_RadiusDamage (self, self.trueowner, ROCKET_DOUBLE_DMG_ADD, other, DMGTYPE_EXPLOSION);
}
