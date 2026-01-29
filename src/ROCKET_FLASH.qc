//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	ROCKET_FLASH_NAME	=	"ROCKET_FLASH";
string	ROCKET_FLASH_MODEL	=	"progs/placeholder_progs/v_rocket_flash.mdl";

//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION
//	0.8	1	120	1	1000		//ID RL (120+)
//	1.2	1	160	1	700		//RPG (160)

//=============================================================================================
	
	
	float	ROCKET_FLASH_ROF		=	2;		//seconds post-fire
	
	float	ROCKET_FLASH_DMG_MAIN		=	40;		//damage per shot
	float	ROCKET_FLASH_DMG_ADD		=	80;	 	//damage per shot
	
	float	ROCKET_FLASH_COST		=	4;		//ammo cost to fire
		
	float	ROCKET_FLASH_SPEED_BASE		=	40;		//rocket speed start
	float	ROCKET_FLASH_SPEED_MULTI	=	1.6;		//accelerator	
	
	float	ROCKET_FLASH_SPEED_MAX		=	2000;		//rocket speed limit
	

//=============================================================================================

float() weaponanim_ROCKET_FLASH =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - ROCKET_FLASH_COST;

	self.attack_finished = time + ROCKET_FLASH_ROF;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;



	W_Fire_ROCKET_FLASH(0);
	W_Fire_ROCKET_FLASH(1);
	W_Fire_ROCKET_FLASH(2);
	W_Fire_ROCKET_FLASH(3);



	self.weaponframe = 11;
	
	self.think = weaponanim_ROCKET_FLASH_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_ROCKET_FLASH_loop =
{
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_ROCKET_FLASH_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void(float offset) W_Fire_ROCKET_FLASH =
{
	local entity missile;
	local vector loc;
		
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);

	self.punchangle_x = -4;
	
	makevectors (self.v_angle);
	
	if 	(offset == 0)	loc = self.origin + v_forward * 8 + '0 0 24' + v_right*10;
	else if (offset == 1)	loc = self.origin + v_forward * 8 + '0 0 10' + v_right*10;
	else if (offset == 2)	loc = self.origin + v_forward * 8 + '0 0 24' + v_right*22;
	else			loc = self.origin + v_forward * 8 + '0 0 10' + v_right*22;
	
	missile = launch_ROCKET_FLASH( loc, v_forward * 1 );
	self.attack_finished = time + 1.2;
}
//=============================================================================================

entity(vector org, vector vel) launch_ROCKET_FLASH =
{
	entity missile;
	
	missile = launch_projectile(org, vel, "rocket");	// FLYMISSILE

	missile.touch = T_ROCKET_FLASH_Touch;
	missile.type = "missile";
	
	missile.nextthink = time;
	missile.velocity = v_forward * ROCKET_FLASH_SPEED_BASE;
	missile.think = ROCKET_FLASH_think;
	
	SUB_ChangeModel (missile, "progs/proj_missile.mdl");
	
	return missile;
}
//=============================================================================================

void() ROCKET_FLASH_think =
{
	float spd = vlen(self.velocity);
	spd *= ROCKET_FLASH_SPEED_MULTI;
	if (spd > ROCKET_FLASH_SPEED_MAX) spd = ROCKET_FLASH_SPEED_MAX;
	self.velocity = normalize(self.velocity) * spd;

	
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

//=============================================================================================

void() T_ROCKET_FLASH_Touch =
{
	if (other == self.owner) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	T_ROCKET_FLASH_Explode();

	self.origin = self.origin - 8*normalize(self.velocity);
	T_ROCKET_FLASH_ExplosiveTouch();
}
//=============================================================================================

void() T_ROCKET_FLASH_ExplosiveTouch =
{
	if (other.classname == "monster_shambler")
		BecomeWeakExplosion();
	else
		//BecomeExplosion();
		BecomeBoxExplosion();	//big
}

void() T_ROCKET_FLASH_Explode =
{
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, ROCKET_FLASH_DMG_MAIN + ROCKET_FLASH_DMG_ADD, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );	// so ogre rockets kill zombies despite being too weak
	}

	// don't do radius damage to other, because all damage will be done in the impact
	T_RadiusDamage (self, self.trueowner, ROCKET_FLASH_DMG_MAIN, other, DMGTYPE_EXPLOSION);
	T_RadiusDamage (self, self.trueowner, ROCKET_FLASH_DMG_ADD, other, DMGTYPE_EXPLOSION);
}
