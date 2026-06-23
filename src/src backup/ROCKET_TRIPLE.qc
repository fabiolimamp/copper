//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	ROCKET_TRIPLE_NAME	=	"ROCKET_TRIPLE";
string	ROCKET_TRIPLE_MODEL	=	"progs/placeholder_progs/v_rocket_triple.mdl";

//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION
//	0.8	1	120	1	1000		//ID RL (120+)
//	1.2	1	160	1	700		//RPG (160)

//=============================================================================================
	
	
	float	ROCKET_TRIPLE_ROF		=	1.6;		//seconds post-fire
	
	float	ROCKET_TRIPLE_DMG		=	45;	//(*2)*3=270	//damage per shot
	
	float	ROCKET_TRIPLE_COST		=	3;		//ammo cost to fire
		
	float	ROCKET_TRIPLE_SPEED_BASE	=	30;		//rocket speed start
	float	ROCKET_TRIPLE_SPEED_MULTI	=	3;		//accelerator	
	
	float	ROCKET_TRIPLE_SPEED_MAX		=	2000;		//rocket speed limit
	
	//vector	ROCKET_TRIPLE_SPREAD		=	'10 10 0';		//rocket speed limit
	

//=============================================================================================

float() weaponanim_ROCKET_TRIPLE =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - ROCKET_TRIPLE_COST;

	self.attack_finished = time + ROCKET_TRIPLE_ROF;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;



	W_Fire_ROCKET_TRIPLE(0);


	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);

	makevectors (self.v_angle);
	self.punchangle_x = -4;
	

	self.weaponframe = 11;
	
	self.think = weaponanim_ROCKET_TRIPLE_loop;
	self.nextthink = time + 0.02;
	
	return TRUE;
}

void() weaponanim_ROCKET_TRIPLE_loop =
{
	if (self.weaponframe == 12)	W_Fire_ROCKET_TRIPLE(1);	
	if (self.weaponframe == 13)	W_Fire_ROCKET_TRIPLE(2);	
	
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_ROCKET_TRIPLE_loop;
	self.nextthink = time + 0.02;
}

//=============================================================================================

void(float offset) W_Fire_ROCKET_TRIPLE =
{
	local entity missile;
	local vector loc;
		

	
	makevectors (self.v_angle);
	
	if 	(offset == 0)	loc = self.origin + v_forward * 8 + v_up*32 + v_right*16;
	else if (offset == 1)	loc = self.origin + v_forward * 8 + v_up*16 + v_right*16;
	else			loc = self.origin + v_forward * 8 + v_up*0 + v_right*16;
	
	
	missile = launch_ROCKET_TRIPLE( loc, v_forward * ROCKET_TRIPLE_SPEED_BASE );
}
//=============================================================================================

entity(vector org, vector vel) launch_ROCKET_TRIPLE =
{
	entity missile;
	
	missile = launch_projectile(org, vel, "rocket");	// FLYMISSILE

	missile.touch = T_ROCKET_TRIPLE_Touch;
	missile.type = "missile";
	
	missile.nextthink = time;
	missile.velocity = v_forward * ROCKET_TRIPLE_SPEED_BASE;
	missile.think = ROCKET_TRIPLE_think;
	
	SUB_ChangeModel (missile, "progs/proj_missile.mdl");
	
	return missile;
}
//=============================================================================================

void() ROCKET_TRIPLE_think =
{
	float spd = vlen(self.velocity);
	spd *= ROCKET_TRIPLE_SPEED_MULTI;
	if (spd > ROCKET_TRIPLE_SPEED_MAX) spd = ROCKET_TRIPLE_SPEED_MAX;
	self.velocity = normalize(self.velocity) * spd;

	
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

//=============================================================================================

void() T_ROCKET_TRIPLE_Touch =
{
	if (other == self.owner) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	T_ROCKET_TRIPLE_Explode();

	self.origin = self.origin - 8*normalize(self.velocity);
	T_ROCKET_TRIPLE_ExplosiveTouch();
}
//=============================================================================================

void() T_ROCKET_TRIPLE_ExplosiveTouch =
{
	if (other.classname == "monster_shambler")
		//BecomeWeakExplosion();
		BecomeMiniBlast(2); //weak, no TE_effects
	else
		BecomeExplosion();
		//BecomeBoxExplosion();	//big
		//BecomeMiniBlast(0); //normal, no TE_effects
}

void() T_ROCKET_TRIPLE_Explode =
{
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, ROCKET_TRIPLE_DMG*2, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );	// so ogre rockets kill zombies despite being too weak
	}

	// don't do radius damage to other, because all damage will be done in the impact
	T_RadiusDamage (self, self.trueowner, ROCKET_TRIPLE_DMG, other, DMGTYPE_EXPLOSION);
	T_RadiusDamage (self, self.trueowner, ROCKET_TRIPLE_DMG, other, DMGTYPE_EXPLOSION);
}
