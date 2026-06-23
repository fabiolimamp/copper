//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	RIVETER_NAME	=	"Riveter";
string	RIVETER_MODEL	=	"progs/placeholder_progs/v_nail_drum.mdl";


//	ROF	COUNT * DMG	COST	SPEED		DESCRIPTION
//	0.08	1	9	1	1996		//QBJ3 Twin Nailgun (9)

//	0.15	2	13	2	1400		//Heavy Bolter	(2*13=26)

//	0.12	1	18	2	1500		//Nail Drum
//	0.2	1	25	2	1400	50	//Nail Drum

//	0.2	1	18	2	1200		//Nail SPINUP
//	0.12	1	18	2	1600		//Nail SPINUP MAX


//=============================================================================================
	
	
	float	RIVETER_COOLDOWN	=	0.2;		//seconds post-fire
	
	float	RIVETER_DAMAGE 	=	20;		//damage per shot

	float	RIVETER_COST	=	2;		//ammo cost to fire
	
	float	RIVETER_VELOCITY	=	1200;		//velocity
	
	float	RIVETER_VUP	=	0;		//v_up launch angle
	
	float	RIVETER_GRAVITY	=	-0.001;		//base gravity

	
	
	vector	RIVETER_SPREAD	=	'200 100 0';	//RIVETER_SPREAD_x	//RIVETER_SPREAD_y	//weighted_crandom(4);



	.float	RIVETER_LEVEL;				//0 ~ MAX
	
	float	RIVETER_MAX_LEVEL		=	4;	//number of shots to reach MAX
	
	float	RIVETER_MAX_COOLDOWN		=	0.12;	//max firerate
	
	float	RIVETER_MAX_VELOCITY		=	1600;	//max nail speed
	
	float	RIVETER_MAX_VUP		=	30;	//max v_up angle
	
	
	
	// MAX STAT # - BASE STAT # / MAX LEVEL # = SUM amount to increase each level
	
	// 0.2 - 0.12 = 0.08 / 8 = 0.01 sec per level
	
	
	
	float	RIVETER_SUM_ROF	=	(RIVETER_COOLDOWN - RIVETER_MAX_COOLDOWN) / RIVETER_MAX_LEVEL;
	
	float	RIVETER_SUM_VELOCITY	=	(RIVETER_MAX_VELOCITY - RIVETER_VELOCITY) / RIVETER_MAX_LEVEL;
	
	float	RIVETER_SUM_VUP	=	(RIVETER_MAX_VUP - RIVETER_VUP) / RIVETER_MAX_LEVEL;
	


//=============================================================================================


float() weaponanim_RIVETER =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}
	
	self.currentammo = self.ammo_nails = self.ammo_nails - RIVETER_COST;

	
	self.attack_finished = time + (RIVETER_COOLDOWN - (self.RIVETER_LEVEL * RIVETER_SUM_ROF));
	
	/*
	if 	(self.RIVETER_LEVEL == 0)	dprint("spinup 0  [    ]\n");
	else if (self.RIVETER_LEVEL == 1)	dprint("spinup 1  [\b-\b   ]\n");
	else if (self.RIVETER_LEVEL == 2)	dprint("spinup 2  [\b--\b  ]\n");
	else if (self.RIVETER_LEVEL == 3)	dprint("spinup 3  [\b---\b ]\n");
	else if (self.RIVETER_LEVEL == 4)	dprint("spinup 4  [\b++++\b] MAX\n");
	else					dprint("???");
	*/
	
	if (self.RIVETER_LEVEL < RIVETER_MAX_LEVEL)	self.RIVETER_LEVEL++;

	else	self.RIVETER_LEVEL = RIVETER_MAX_LEVEL;

	
	//SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
		
	W_Fire_RIVETER_Heavy();	//arc
		
	
	self.effects |= EF_MUZZLEFLASH;
	
	sound (self, CHAN_AUTO, "placeholder_sound/tommy_fire2.wav", 0.5, ATTN_NORM);
	sound (self, CHAN_AUTO, "nail/airpuff.wav", 0.5, ATTN_NORM);	
	
	
	nailgun_sound(0.45);


	self.weaponframe = 11;
	self.think = weaponanim_RIVETER_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_RIVETER_loop =
{
	if (self.weaponframe == 13) Eject_BulletCasing();
	
	if (self.weaponframe >= 20)
	{
		self.weaponframe = 10;
		self.RIVETER_LEVEL = 0;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_RIVETER_loop;
	self.nextthink = time + 0.025;
}

//=============================================================================================
//=============================================================================================

void() W_Fire_RIVETER_Heavy =
{
	self.punchangle_x = -1;
	makevectors (self.v_angle);
	
	vector org = self.origin + self.view_ofs + v_forward*11 + v_right*8 + v_up*-10;
	
	
	
	float spread_spreader = ((RIVETER_MAX_LEVEL * RIVETER_MAX_LEVEL) + RIVETER_MAX_LEVEL) - (self.RIVETER_LEVEL * RIVETER_MAX_LEVEL);	
	
	//spread_spreader ((4 * 4 = 16) + 4 = 20) - (0~4 * 4) = 0,4,8,12,16,20 MAX
	
		
	
	vector mvel = (v_forward*(RIVETER_VELOCITY + (self.RIVETER_LEVEL*RIVETER_SUM_VELOCITY)))
	
		+ (weighted_crandom(spread_spreader)*RIVETER_SPREAD_x*v_right)
	
		+ (v_up*(RIVETER_VUP + (self.RIVETER_LEVEL*RIVETER_SUM_VUP)))
	
		+ (weighted_crandom(spread_spreader)*RIVETER_SPREAD_y*v_up);



	launch_RIVETER_Heavy (org, mvel + v_right*-13);
}

//=============================================================================================

entity(vector org, vector vel) launch_RIVETER_Heavy =
{
	entity nail;
	
	nail = toss_projectile(org, vel, "nail");
	nail.lifetime_finished = time + 10;
	
	SUB_ChangeModel (nail, "progs/placeholder_progs/proj_nail_heavy.mdl");

		
	nail.touch = RIVETER_Heavy_touch;	//dont pierce with nail
	
	nail.alpha = 1;
	//nail.movetype = MOVETYPE_FLYMISSILE;	//point vs bbox


	//nail.avelocity = '0 0 -3000';

	nail.gravity = RIVETER_GRAVITY;
	
	//nail.gravity = RIVETER_MAX_GRAVITY - (self.RIVETER_LEVEL * RIVETER_SUM_GRAVITY);

	return nail;
}

void() ImpalerFade_RIVETER =
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

void() RIVETER_Heavy_touch =
{
	if (!CheckValidSpikeTouch()) return;

	if (other.takedamage)
	{
		spawn_touchblood (other, RIVETER_DAMAGE);
		T_Damage (other, self, self.trueowner, RIVETER_DAMAGE);
				
		sound_bullet_hit_enemy(1);
		
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

void() updateRebars_RIVETER =
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
