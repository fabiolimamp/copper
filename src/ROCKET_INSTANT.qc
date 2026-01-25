//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	ROCKET_INSTANT_NAME	=	"ROCKET_INSTANT";
string	ROCKET_INSTANT_MODEL	=	"progs/placeholder_progs/v_rocket_instant.mdl";

//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION
//	0.8	1	120	1	1000		//ID RL (120+)

//=============================================================================================
	
	
	float	ROCKET_INSTANT_ROF	=	1.5;		//seconds post-fire
	
	float	ROCKET_INSTANT_DMG	=	120;		//damage per shot
	
	float	ROCKET_INSTANT_COST	=	2;		//ammo cost to fire
	
	float	ROCKET_INSTANT_SPEED	=	20;		//arc velocity
	

//=============================================================================================	

float() weaponanim_ROCKET_INSTANT =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - ROCKET_INSTANT_COST;

	self.attack_finished = time + ROCKET_INSTANT_ROF;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;



	W_Fire_ROCKET_INSTANT_hitscan();



	self.weaponframe = 11;
	
	self.think = weaponanim_ROCKET_INSTANT_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_ROCKET_INSTANT_loop =
{
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_ROCKET_INSTANT_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void() W_Fire_ROCKET_INSTANT_hitscan =
{
	vector	source, org;
	
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "placeholder_sound/sniper.wav", 1, ATTN_NORM);
	
	makevectors (self.v_angle);
	source = self.origin + self.view_ofs;
	traceline2(source, source + v_forward * (4000), self, 0);
	
	if (trace_ent == self)
		return;	// some notrace shit happened
	if (trace_fraction == 1.0) 
		return;
	
	self.show_hostile = time + 1;	// wake monsters up
	
	org = trace_endpos - v_forward*16;


	//hit anything
	
	//gunshot(org);
	
	
	W_Fire_ROCKET_INSTANT(org);
	
	
	Start_Smoketrail_ROCKET_INSTANT();
	
	
	self.punchangle_x = -4;
}

//=============================================================================================

void(vector loc) W_Fire_ROCKET_INSTANT =
{
	local entity missile;
	
	makevectors (self.v_angle);
	
	missile = launch_ROCKET_INSTANT( loc, v_forward * ROCKET_INSTANT_SPEED );
}

entity(vector org, vector vel) launch_ROCKET_INSTANT =
{
	entity missile;
	
	missile = launch_projectile(org, vel, "rocket");	// FLYMISSILE
	//missile.dmg = ROCKET_INSTANT_DMG;
	missile.touch = T_ROCKET_INSTANT_Touch;
	missile.type = "missile";
	
	SUB_ChangeModel (missile, "progs/proj_missile.mdl");
	
	return missile;
}

//=============================================================================================

void() T_ROCKET_INSTANT_Touch =
{
	if (other == self.owner) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
				
		return;
	}

	T_ROCKET_INSTANT_Explode();
	
	self.origin = self.origin - 8*normalize(self.velocity);
	T_ROCKET_INSTANT_ExplosiveTouch();
}

//=============================================================================================

void() T_ROCKET_INSTANT_ExplosiveTouch =
{
	if (other.classname == "monster_shambler")
		BecomeWeakExplosion();
	else
		//BecomeExplosion();
		BecomeBoxExplosion();	//big
}

void() T_ROCKET_INSTANT_Explode =
{
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, ROCKET_INSTANT_DMG, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );	// so ogre rockets kill zombies despite being too weak
	}

	// don't do radius damage to other, because all damage will be done in the impact
	T_RadiusDamage (self, self.trueowner, ROCKET_INSTANT_DMG, other, DMGTYPE_EXPLOSION);
}

////////////////////////////////////////////////////////////////////////////////////////////////
// Railgun code from EE by bmFbr, edits by Kebby

void() Start_Smoketrail_ROCKET_INSTANT = 
{
	vector 	org;

	if (self.t_width < time)
		self.t_width = time + 0.6;

	makevectors(self.v_angle);

	org = self.origin + self.view_ofs + v_up * -8 + v_right * 10;
	
	traceline(org, org + v_forward * 16, FALSE, self);
	
	org = org + v_forward*16*trace_fraction;

	vector dir = aim(self, 0);

	vector endpos = Smoketrail_Direction(org, dir);
	
	Draw_Smoketrail(self, org, endpos, 0);
};

vector(vector org, vector dir) Smoketrail_Direction = 
{
	traceline (org, org + dir*4000, FALSE, self);
	vector endpoint = trace_endpos;
	return endpoint;
}

.entity	sibling;

float 	FL_PROJECTILE	= 32768;	// ???

void(entity pl, vector org, vector dest, float hit) Draw_Smoketrail = 
{
	float len = vlen(dest - org);
	vector dir = normalize(dest - org);
	vector ang = vectoangles(dest - org);

	float ct = floor(len/30);
	entity sg;
	entity prevsg;
	for (float i = 0; i < ct; i++) {
		sg = spawn();
		if (prevsg) prevsg.sibling = sg;

		
		setmodel (sg, "progs/placeholder_progs/railtrail_smoke.mdl");
		
			
		setsize(sg, VEC_ORIGIN, VEC_ORIGIN);
		setorigin(sg, org + dir * 30 * i);

		sg.flags |= FL_PROJECTILE;
		sg.classname = "lgsegment";
		sg.angles = ang;
		sg.angles_z = random()*360;
		sg.owner = pl;
		sg.think = Smoketrail_Segment_Think;
		sg.attack_finished = time + 0.5 + 0.005*i;
		sg.nextthink = time + 0.02;
		sg.alpha = 1;
		sg.state = hit;
		sg.cnt = i;
		prevsg = sg;
	}
	if (sg) sg.effects |= EF_MUZZLEFLASH;
}

void() Smoketrail_Segment_Think = 
{
	self.alpha = clamp(lerpCosine(1, 0, 1 - (self.attack_finished - time)/0.5), 0.0001, 1);

	if (time > self.attack_finished)
		remove(self);
	else
		self.nextthink = time + 0.025;
}

////////////////////////////////////////////////////////////////////////////////////////////////