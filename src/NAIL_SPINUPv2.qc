//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	NAIL_SPINUPv2_NAME	=	"NAIL_SPINUPv2";
string	NAIL_SPINUPv2_MODEL	=	"progs/placeholder_progs/v_nail_drum.mdl";


//	ROF	COUNT * DMG	COST	SPEED		DESCRIPTION
//	0.08	1	9	1	1996		//QBJ3 Twin Nailgun (9)

//	0.15	2	13	2	1400		//Heavy Bolter	(2*13=26)

//	0.12	1	18	2	1500		//Nail Drum
//	0.2	1	25	2	1400	50	//Nail Drum

//	0.2	1	18	2	1200		//Nail SPINUP
//	0.12	1	18	2	1600		//Nail SPINUP MAX


//=============================================================================================
	
	
	float	NAIL_SPINUPv2_ROF	=	0.2;		//seconds post-fire
	
	float	NAIL_SPINUPv2_DMG 	=	18;		//damage per shot

	float	NAIL_SPINUPv2_COST	=	2;		//ammo cost to fire
	
	float	NAIL_SPINUPv2_SPEED	=	1200;		//velocity
	
	float	NAIL_SPINUPv2_VUP	=	0;		//v_up launch angle
	
	float	NAIL_SPINUPv2_GRAVITY	=	-0.001;		//base gravity

	
	
	vector	NAIL_SPINUPv2_SPREAD	=	'200 100 0';	//NAIL_SPINUPv2_SPREAD_x	//NAIL_SPINUPv2_SPREAD_y	//weighted_crandom(4);



	.float	NAIL_SPINUPv2_LEVEL;				//0 ~ MAX
	
	float	NAIL_SPINUPv2_MAX_LEVEL		=	4;	//number of shots to reach MAX
	
	float	NAIL_SPINUPv2_MAX_ROF		=	0.12;	//max firerate
	
	float	NAIL_SPINUPv2_MAX_SPEED		=	1600;	//max nail speed
	
	float	NAIL_SPINUPv2_MAX_VUP		=	30;	//max v_up angle
	
	
	
	// MAX STAT # - BASE STAT # / MAX LEVEL # = SUM amount to increase each level
	
	// 0.2 - 0.12 = 0.08 / 8 = 0.01 sec per level
	
	
	
	float	NAIL_SPINUPv2_SUM_ROF	=	(NAIL_SPINUPv2_ROF - NAIL_SPINUPv2_MAX_ROF) / NAIL_SPINUPv2_MAX_LEVEL;
	
	float	NAIL_SPINUPv2_SUM_SPEED	=	(NAIL_SPINUPv2_MAX_SPEED - NAIL_SPINUPv2_SPEED) / NAIL_SPINUPv2_MAX_LEVEL;
	
	float	NAIL_SPINUPv2_SUM_VUP	=	(NAIL_SPINUPv2_MAX_VUP - NAIL_SPINUPv2_VUP) / NAIL_SPINUPv2_MAX_LEVEL;
	


//=============================================================================================


float() weaponanim_NAIL_SPINUPv2 =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}
	
	self.currentammo = self.ammo_nails = self.ammo_nails - NAIL_SPINUPv2_COST;

	
	self.attack_finished = time + (NAIL_SPINUPv2_ROF - (self.NAIL_SPINUPv2_LEVEL * NAIL_SPINUPv2_SUM_ROF));
	
	
	if 	(self.NAIL_SPINUPv2_LEVEL == 0)	sprint(self, "spinup 0  [    ]\n");
	else if (self.NAIL_SPINUPv2_LEVEL == 1)	sprint(self, "spinup 1  [-   ]\n");
	else if (self.NAIL_SPINUPv2_LEVEL == 2)	sprint(self, "spinup 2  [--  ]\n");
	else if (self.NAIL_SPINUPv2_LEVEL == 3)	sprint(self, "spinup 3  [--- ]\n");
	else if (self.NAIL_SPINUPv2_LEVEL == 4)	sprint(self, "spinup 4  [++++] MAX\n");
	else					sprint(self, "???");
	
	
	if (self.NAIL_SPINUPv2_LEVEL < NAIL_SPINUPv2_MAX_LEVEL)	self.NAIL_SPINUPv2_LEVEL++;

	else	self.NAIL_SPINUPv2_LEVEL = NAIL_SPINUPv2_MAX_LEVEL;

	
	//SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
		
	W_Fire_NAIL_SPINUPv2_Heavy();	//arc
		
	
	self.effects |= EF_MUZZLEFLASH;
	
	sound (self, CHAN_AUTO, "placeholder_sound/tommy_fire2.wav", 0.5, ATTN_NORM);
	sound (self, CHAN_AUTO, "nail/airpuff.wav", 0.5, ATTN_NORM);	
	
	
	nailgun_sound(0.45);


	self.weaponframe = 11;
	self.think = weaponanim_NAIL_SPINUPv2_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_NAIL_SPINUPv2_loop =
{
	if (self.weaponframe == 13) Eject_BulletCasing();
	
	if (self.weaponframe >= 20)
	{
		self.weaponframe = 10;
		self.NAIL_SPINUPv2_LEVEL = 0;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_NAIL_SPINUPv2_loop;
	self.nextthink = time + 0.025;
}

//=============================================================================================
//=============================================================================================

void() W_Fire_NAIL_SPINUPv2_Heavy =
{
	self.punchangle_x = -1;
	makevectors (self.v_angle);
	
	vector org = self.origin + self.view_ofs + v_forward*11 + v_right*8 + v_up*-10;
	
	
	
	float spread_spreader = ((NAIL_SPINUPv2_MAX_LEVEL * NAIL_SPINUPv2_MAX_LEVEL) + NAIL_SPINUPv2_MAX_LEVEL) - (self.NAIL_SPINUPv2_LEVEL * NAIL_SPINUPv2_MAX_LEVEL);	
	
	//spread_spreader ((4 * 4 = 16) + 4 = 20) - (0~4 * 4) = 0,4,8,12,16,20 MAX
	
		
	
	vector mvel = (v_forward*(NAIL_SPINUPv2_SPEED + (self.NAIL_SPINUPv2_LEVEL*NAIL_SPINUPv2_SUM_SPEED)))
	
		+ (weighted_crandom(spread_spreader)*NAIL_SPINUPv2_SPREAD_x*v_right)
	
		+ (v_up*(NAIL_SPINUPv2_VUP + (self.NAIL_SPINUPv2_LEVEL*NAIL_SPINUPv2_SUM_VUP)))
	
		+ (weighted_crandom(spread_spreader)*NAIL_SPINUPv2_SPREAD_y*v_up);



	launch_NAIL_SPINUPv2_Heavy (org, mvel + v_right*-13);
}

//=============================================================================================

entity(vector org, vector vel) launch_NAIL_SPINUPv2_Heavy =
{
	entity nail;
	
	nail = toss_projectile(org, vel, "nail");
	nail.lifetime_finished = time + 10;
	
	SUB_ChangeModel (nail, "progs/placeholder_progs/proj_nail_heavy.mdl");

		
	nail.touch = NAIL_SPINUPv2_Heavy_touch;	//dont pierce with nail
	
	nail.alpha = 1;
	//nail.movetype = MOVETYPE_FLYMISSILE;	//point vs bbox


	//nail.avelocity = '0 0 -3000';

	nail.gravity = NAIL_SPINUPv2_GRAVITY;
	
	//nail.gravity = NAIL_SPINUPv2_MAX_GRAVITY - (self.NAIL_SPINUPv2_LEVEL * NAIL_SPINUPv2_SUM_GRAVITY);

	return nail;
}

void() ImpalerFade_NAIL_SPINUPv2 =
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

void() NAIL_SPINUPv2_Heavy_touch =
{
	if (!CheckValidSpikeTouch()) return;

	if (other.takedamage)
	{
		spawn_touchblood (other, NAIL_SPINUPv2_DMG);
		T_Damage (other, self, self.trueowner, NAIL_SPINUPv2_DMG);
				
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

void() updateRebars_NAIL_SPINUPv2 =
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
