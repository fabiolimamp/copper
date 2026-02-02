//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	NAIL_SPINUP_NAME	=	"NAIL_SPINUP";
string	NAIL_SPINUP_MODEL	=	"progs/placeholder_progs/v_nail_drum.mdl";


//	ROF	COUNT * DMG	COST	SPEED		DESCRIPTION
//	0.08	1	9	1	1996		//QBJ3 Twin Nailgun (9)

//	0.15	2	13	2	1400		//Heavy Bolter	(2*13=26)

//	0.12	1	18	2	1500		//Nail Drum
//	0.2	1	25	2	1400	50	//Nail Drum

//	0.2	1	20	2	1000		//Nail SPINUP
//	0.12	1	20	2	1400		//Nail SPINUP MAX


//=============================================================================================
	
	
	float	NAIL_SPINUP_ROF		=	0.2;		//seconds post-fire
	
	float	NAIL_SPINUP_DMG 	=	20;		//damage per shot

	float	NAIL_SPINUP_COST	=	2;		//ammo cost to fire
	
	float	NAIL_SPINUP_SPEED	=	800;		//velocity
	
	float	NAIL_SPINUP_VUP		=	80;		//160*v_up launch angle
	
	float	NAIL_SPINUP_GRAVITY	=	25;		//25 rebar

	
	
//	vector	NAIL_SPINUP_SPREAD	=	'100 100 0';



	.float	NAIL_SPINUP_LEVEL;			//0 ~ MAX
	
	float	NAIL_SPINUP_MAX_LEVEL	=	8;	//number of shots to reach MAX
	
	float	NAIL_SPINUP_MAX_ROF	=	0.12;	//max firerate
	
	float	NAIL_SPINUP_MAX_SPEED	=	1600;	//max nail speed
	
	float	NAIL_SPINUP_MAX_VUP	=	120;	//max v_up angle
	
	
	
	// MAX STAT # - BASE STAT # / MAX LEVEL # = SUM amount to increase each level
	
	// 0.2 - 0.12 = 0.08 / 8 = 0.01 sec per level
	
	
	
	float	NAIL_SPINUP_SUM_ROF	=	(NAIL_SPINUP_ROF - NAIL_SPINUP_MAX_ROF) / NAIL_SPINUP_MAX_LEVEL;
	
	float	NAIL_SPINUP_SUM_SPEED	=	(NAIL_SPINUP_MAX_SPEED - NAIL_SPINUP_SPEED) / NAIL_SPINUP_MAX_LEVEL;
	
	float	NAIL_SPINUP_SUM_VUP	=	(NAIL_SPINUP_MAX_VUP - NAIL_SPINUP_VUP) / NAIL_SPINUP_MAX_LEVEL;
	



//=============================================================================================


float() weaponanim_NAIL_SPINUP =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}
	
	self.currentammo = self.ammo_nails = self.ammo_nails - NAIL_SPINUP_COST;


	
	
	self.attack_finished = time + (NAIL_SPINUP_ROF - (self.NAIL_SPINUP_LEVEL * NAIL_SPINUP_SUM_ROF));
	
	
	if (self.NAIL_SPINUP_LEVEL > NAIL_SPINUP_MAX_LEVEL)	self.NAIL_SPINUP_LEVEL = NAIL_SPINUP_MAX_LEVEL;
	
	else	self.NAIL_SPINUP_LEVEL++;


	
	//SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	
	
	W_Fire_NAIL_SPINUP_Heavy();	//arc
	
	
	
	self.effects |= EF_MUZZLEFLASH;
	
	sound (self, CHAN_AUTO, "placeholder_sound/tommy_fire2.wav", 0.6, ATTN_NORM);
	sound (self, CHAN_AUTO, "nail/airpuff.wav", 0.5, ATTN_NORM);	
	
	//sound (self, CHAN_WEAPON, "rebar/penfire.wav", 0.2, ATTN_NORM);
	
	nailgun_sound(0.45);


	self.weaponframe = 11;
	self.think = weaponanim_NAIL_SPINUP_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_NAIL_SPINUP_loop =
{
	if (self.weaponframe == 13) Eject_BulletCasing();
	
	if (self.weaponframe >= 20)
	{
		self.weaponframe = 10;
		self.NAIL_SPINUP_LEVEL = 0;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_NAIL_SPINUP_loop;
	self.nextthink = time + 0.025;
}

//=============================================================================================
//=============================================================================================

void() W_Fire_NAIL_SPINUP_Heavy =
{
	self.punchangle_x = -1;
	makevectors (self.v_angle);
	
	vector org = self.origin + self.view_ofs + v_forward*11 + v_right*8 + v_up*-10;
	
	vector mvel = (v_forward*(NAIL_SPINUP_SPEED + (self.NAIL_SPINUP_LEVEL*NAIL_SPINUP_SUM_SPEED))) + (v_up*(NAIL_SPINUP_VUP + (self.NAIL_SPINUP_LEVEL*NAIL_SPINUP_SUM_VUP)));

	launch_NAIL_SPINUP_Heavy (org, mvel + v_right*-12);
}

//=============================================================================================

entity(vector org, vector vel) launch_NAIL_SPINUP_Heavy =
{
	entity nail;
	//gunshot(org);

	nail = toss_projectile(org, vel, "nail");
	nail.lifetime_finished = time + 10;
	
	SUB_ChangeModel (nail, "progs/placeholder_progs/proj_nail_heavy.mdl");

	nail.think = ImpalerThink_NAIL_SPINUP;
	
	nail.touch = NAIL_SPINUP_Heavy_touch;	//dont pierce with nail
	
	nail.alpha = 1;
	nail.movetype = MOVETYPE_FLYMISSILE;	//point vs bbox

	return nail;
}

void() ImpalerThink_NAIL_SPINUP =
{
	if (time > self.lifetime_finished)
	{
		ImpalerFade();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.velocity.z -= NAIL_SPINUP_GRAVITY;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

void() ImpalerFade_NAIL_SPINUP =
{
	self.alpha -= 0.025;
	
	if (self.alpha <= 0)
	{
		remove(self);
		return;
	}

	if (!self.state)
	{
		self.angles = vectoangles(self.velocity);
		self.flags &~= FL_ONGROUND;
		self.oldvelocity = self.velocity;
	}

	self.think = ImpalerFade;
	self.nextthink = time + 0.05;
}
//=============================================================================================

void() NAIL_SPINUP_Heavy_touch =
{
	if (!CheckValidSpikeTouch()) return;

	if (other.takedamage)
	{
		spawn_touchblood (other, NAIL_SPINUP_DMG);
		T_Damage (other, self, self.trueowner, NAIL_SPINUP_DMG);
				
		//if (random() < 0.8)	sound_bullet_hit_enemy(0.7);
		sound_bullet_hit_enemy(1);
		
		//if (random() < 0.75)	FX_Impact(FX_BLOOD_BIG, self.origin, self.oldvelocity);
		FX_Impact(FX_BLOOD_BIG, self.origin, self.oldvelocity);
		
		//always play hit sound and show blood with slower heavy nails
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_SPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}

	if (other == world)
	{
		//if (random() < 0.5)	FX_Impact(FX_NAIL, self.origin, self.oldvelocity);
		FX_Impact(FX_NAIL, self.origin, self.oldvelocity);
		
		TwinNailwallThink();
	}	
	if (other.solid == SOLID_BSP && other.classname != "func_movewall") {
		self.movetype = MOVETYPE_NONE;
		self.solid = SOLID_NOT;
		self.owner = other;
		self.touch = SUB_Null;

		// move origin away from walls when stuck, helps prevent "void-lighting"
		setorigin(self, self.origin - 2*normalize(self.velocity));

		self.pos1 = other.absmin;

		// set state 2 to rebars attached to non-world entities (for movement and validity checks)
		if (other != world) self.state = 2;
		else self.state = 1;
		
		self.alpha = 1;
		self.think = ImpalerFade;
		self.nextthink = time + 10;
	}	
	else 
		remove(self);
}

void() updateRebars_NAIL_SPINUP =
{
	entity e = find(world, classname, "impaler");
	while (e)
	{
		if (e.state)
		{
			// hole is in a valid non-world solid entity
			if (e.owner && e.owner.solid == SOLID_BSP)
			{
				if (e.owner.absmin != e.pos1)
				{
					setorigin(e, e.origin - e.pos1 + e.owner.absmin);
					e.pos1 = e.owner.absmin;
				}
			}

			// hole was originally in a non-world entity, but it was removed or changed to non-solid
			else if (e.state == 2) { 
				remove(e);
			}
		}

		e = find(e, classname, "impaler");
	}
}
