//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	ROCKET_RPG_NAME		=	"ROCKET_RPG";
string	ROCKET_RPG_MODEL	=	"progs/placeholder_progs/v_rocket_halflife.mdl";

//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION
//	0.8	1	120	1	1000		//ID RL (120+)
//	1.2	1	160	1	700		//RPG (160)

//=============================================================================================
	
	
	float	ROCKET_RPG_ROF		=	1.2;		//seconds post-fire
	
	float	ROCKET_RPG_DMG_MAIN	=	100;		//damage per shot
	float	ROCKET_RPG_DMG_ADD	=	60;	 	//damage per shot
	
	float	ROCKET_RPG_COST		=	1;		//ammo cost to fire
	
	float	ROCKET_RPG_SPEED_BASE	=	200;		//rocket speed start
	float	ROCKET_RPG_SPEED_MULTI	=	1.5;		//accelerator
	
	
	float	ROCKET_RPG_SPEED_MAX	=	2000;		//rocket speed limit
	

//=============================================================================================

float() weaponanim_ROCKET_RPG =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - ROCKET_RPG_COST;

	self.attack_finished = time + ROCKET_RPG_ROF;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;



	W_Fire_ROCKET_RPG();



	self.weaponframe = 11;
	
	self.think = weaponanim_ROCKET_RPG_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_ROCKET_RPG_loop =
{
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_ROCKET_RPG_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void() W_Fire_ROCKET_RPG =
{
	//entity g;
	vector gvel;
	
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);
	SuperDamageSound();
	
	self.punchangle_x = -4;

	// set grenade speed	
	makevectors (self.v_angle);
	
	gvel = v_forward * 400 + '0 0 250';
		

	//vector	source;
	
	//makevectors (self.v_angle);
	//source = self.origin + self.view_ofs;
	//traceline2(source, source + v_forward, self, 0);
	
	//if (trace_ent == self)	return;

	//g.v_angle = trace_endpos;
	
	//launch_ROCKET_RPG_toss (self.origin + v_forward * 8 + v_right * 12 + v_up * 16, gvel, trace_endpos);
	launch_ROCKET_RPG_toss (self.origin + v_forward * 8 + v_right * 12 + v_up * 16, gvel);
	
	
	
	//  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
	/*
	local entity missile;
	local vector loc;
		
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);

	self.punchangle_x = -4;
	
	makevectors (self.v_angle);
	loc = self.origin + v_forward * 8 + '0 0 16' + v_right*8;
	
	missile = launch_ROCKET_RPG( loc, v_forward * 1 );
	//self.attack_finished = time + 0.8;
	*/
}
//=============================================================================================

//void(vector org, vector vel, vector endpos_angle) launch_ROCKET_RPG_toss =
void(vector org, vector vel) launch_ROCKET_RPG_toss =
{
	entity grenade;
	
	grenade = toss_projectile(org, vel, "grenade");

	grenade.avelocity = '-100 0 0';
	
	SUB_ChangeModel (grenade, "progs/placeholder_progs/proj_missile_nosmoke.mdl");
	
	//grenade.nextthink = 0.4;
	
	
	
	
	/*
	vector	player_aim_source;
	
	//makevectors (self.v_angle);
	player_aim_source = self.owner.origin + self.owner.view_ofs;
	traceline2(player_aim_source, player_aim_source + v_forward, self.owner, 0);
	
	if (trace_ent == self.owner)
		return;
	*/
		
	//grenade.go_that_way = trace_endpos;
	
	
	
	grenade.lifetime_finished = time + 0.4;
	grenade.th_die = launch_ROCKET_RPG_at_endpos;
	
	
	//grenade.think = launch_ROCKET_RPG_at_endpos;
	
	grenade.touch = T_ROCKET_RPG_Touch;
}
//=============================================================================================

void() launch_ROCKET_RPG_at_endpos =
{
	vector	source;
	
	makevectors (self.owner.v_angle);
	source = self.owner.origin + self.owner.view_ofs;
	traceline2(source, source + v_forward * 4000, self.owner, 0);
	
	

	if (trace_ent == self.owner)
		return;	// some notrace shit happened

	//vector go_that_way = trace_endpos;
	
	
	//FX_Impact(FX_SPARK, trace_endpos, 0);

	
	self.movetype = MOVETYPE_FLYMISSILE;
	self.solid = SOLID_BBOX;
	
	self.touch = T_ROCKET_RPG_Touch;
	self.type = "missile";
	

	//self.avelocity = self.v_angle;
	self.avelocity = trace_endpos;
	

	launch_ROCKET_RPG (self.origin, trace_endpos);
	
	
	SUB_ChangeModel (self, "progs/proj_missile.mdl");
	
	
	FX_Impact(FX_CHAINS, trace_endpos, 0);
	
	remove(self);
}
//=============================================================================================

entity(vector org, vector vel) launch_ROCKET_RPG =
{
	entity missile;
	
	missile = launch_projectile(org, vel, "rocket");	// FLYMISSILE

	missile.touch = T_ROCKET_RPG_Touch;
	missile.type = "missile";
	
	missile.nextthink = time;
	missile.velocity = v_forward * ROCKET_RPG_SPEED_BASE;
	missile.think = ROCKET_RPG_think;
	
	SUB_ChangeModel (missile, "progs/proj_missile.mdl");
	
	return missile;
}
//=============================================================================================

void() ROCKET_RPG_think =
{
	float spd = vlen(self.velocity);
	spd *= ROCKET_RPG_SPEED_MULTI;
	if (spd > ROCKET_RPG_SPEED_MAX) spd = ROCKET_RPG_SPEED_MAX;
	self.velocity = normalize(self.velocity) * spd;

	
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

//=============================================================================================

void() T_ROCKET_RPG_Touch =
{
	if (other == self.owner) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	T_ROCKET_RPG_Explode();

	self.origin = self.origin - 8*normalize(self.velocity);
	T_ROCKET_RPG_ExplosiveTouch();
}
//=============================================================================================

void() T_ROCKET_RPG_ExplosiveTouch =
{
	if (other.classname == "monster_shambler")
		BecomeWeakExplosion();
	else
		//BecomeExplosion();
		BecomeBoxExplosion();	//big
}

void() T_ROCKET_RPG_Explode =
{
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, ROCKET_RPG_DMG_MAIN + ROCKET_RPG_DMG_ADD, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );	// so ogre rockets kill zombies despite being too weak
	}

	// don't do radius damage to other, because all damage will be done in the impact
	T_RadiusDamage (self, self.trueowner, ROCKET_RPG_DMG_MAIN, other, DMGTYPE_EXPLOSION);
	T_RadiusDamage (self, self.trueowner, ROCKET_RPG_DMG_ADD, other, DMGTYPE_EXPLOSION);
}
