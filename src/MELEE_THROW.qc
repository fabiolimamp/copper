//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	MELEE_THROW_NAME	=	"MELEE_THROW";
string	MELEE_THROW_MODEL	=	"progs/placeholder_progs/v_melee_throw.mdl";


//	ROF	COUNT * DMG	COST	SPEED		DESCRIPTION
//	0.08	1	9	1	1996		//QBJ3 Twin Nailgun (9)

//	0.15	2	13	2	1400		//Heavy Bolter	(2*13=26)

//	0.12	1	18	2	1500		//Nail Drum
//	0.2	1	25	2	1400	50	//Nail Drum


//=============================================================================================
	
	
	float	MELEE_THROW_ROF		=	0.7;		//seconds post-fire
	
	float	MELEE_THROW_DMG 	=	50;		//damage per shot

	//float	MELEE_THROW_COST	=	1;		//ammo cost to fire
	
	float	MELEE_THROW_SPEED	=	1400;		//velocity
	
	float	MELEE_THROW_GRAVITY	=	2;	//100;		//25 rebar
	float	MELEE_THROW_VUP		=	160;		//160*v_up launch angle
	
//	vector	MELEE_THROW_SPREAD	=	'100 100 0';


//=============================================================================================


float() weaponanim_MELEE_THROW =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	//self.currentammo = self.ammo_nails = self.ammo_nails - MELEE_THROW_COST;

	self.attack_finished = time + MELEE_THROW_ROF;
	
	//SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	
	//W_Fire_MELEE_THROW_Heavy();	//arc
	
	
	//self.punchangle_x = -1;
	//self.effects |= EF_MUZZLEFLASH;
	
	//sound (self, CHAN_AUTO, "placeholder_sound/tommy_fire2.wav", 0.5, ATTN_NORM);
	
	sound_MELEE_KNIFE_air_swipe(1);


	self.weaponframe = 11;
	self.think = weaponanim_MELEE_THROW_loop;
	self.nextthink = time + 0.04;
	
	return TRUE;
}

void() weaponanim_MELEE_THROW_loop =
{
	if (self.weaponframe == 15) W_Fire_MELEE_THROW_Heavy();
	
	if (self.weaponframe >= 40)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_MELEE_THROW_loop;
	self.nextthink = time + 0.04;
}

//=============================================================================================
//=============================================================================================
//=============================================================================================

void() W_Fire_MELEE_THROW_Heavy =
{
	makevectors (self.v_angle);
	//self.punchangle_x = -1;
	
	vector org = self.origin + self.view_ofs + v_forward*11 + v_right*12 + v_up*-10;
	
	vector mvel = v_forward*MELEE_THROW_SPEED + v_up*MELEE_THROW_VUP;

	launch_MELEE_THROW_Heavy (org, mvel + v_right*-12);
}

//=============================================================================================

entity(vector org, vector vel) launch_MELEE_THROW_Heavy =
{
	entity knife;
	//gunshot(org);

	knife = toss_projectile(org, vel, "knife");
	knife.lifetime_finished = time + 10;
	
	SUB_ChangeModel (knife, "progs/placeholder_progs/proj_knife.mdl");

	//knife.think = ImpalerThink_MELEE_THROW;
	
	//knife.touch = ImpalerTouch_MELEE_THROW;	//maybe pierce?
	knife.touch = MELEE_THROW_Heavy_touch;	//dont pierce with nail
	
	knife.alpha = 1;
	//knife.movetype = MOVETYPE_FLYMISSILE;
	
	knife.avelocity = '-1200 0 0';
	
	knife.gravity = MELEE_THROW_GRAVITY;

	return knife;
}
/*
void() ImpalerThink_MELEE_THROW =
{
	if (time > self.lifetime_finished)
	{
		ImpalerFade();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.velocity.z -= MELEE_THROW_GRAVITY;
	self.nextthink = time + 0.05;
	//self.angles = vectoangles(self.velocity);
}
*/
void() ImpalerFade_MELEE_THROW =
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

void() MELEE_THROW_Heavy_touch =
{
	if (!CheckValidSpikeTouch()) return;

	if (other.takedamage)
	{
		spawn_touchblood (other, MELEE_THROW_DMG);
		T_Damage (other, self, self.trueowner, MELEE_THROW_DMG);
				
		//if (random() < 0.8)	sound_bullet_hit_enemy(0.7);
		//sound_bullet_hit_enemy(1);
		
		sound_MELEE_KNIFE_hit_enemy(1);
		
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
		FX_Impact(FX_SPARK, self.origin, self.oldvelocity);
		
		sound (self, CHAN_AUTO, "placeholder_sound/knife_hitwall1.wav", 1, ATTN_NORM);
		
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

/*
void() ImpalerTouch_MELEE_THROW =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, MELEE_THROW_DMG);

		FX_Impact(FX_BLOOD_BIG, self.origin, self.oldvelocity);

		particle (self.origin, self.velocity*0.1, 73, 40);

		float chance = random();
		
		if 	(chance < 0.33)	sound (self, CHAN_AUTO, "rebar/pierce1.wav", 1, ATTN_NORM);
		else if (chance < 0.5)	sound (self, CHAN_AUTO, "rebar/pierce2.wav", 1, ATTN_NORM);
		else			sound (self, CHAN_AUTO, "rebar/pierce3.wav", 1, ATTN_NORM);
		
		sound (self, CHAN_AUTO, "rebar/pierce_impact.wav", 1, ATTN_NORM);

		// doesn't go through doors
		if (other.classname != "func_door" && other.classname != "func_door_secret"){
			projectile_passthru();
			return;
		}
	}
	
	sound (self, CHAN_AUTO, "rebar/stick1.wav", 0.2, ATTN_NORM);
	
	if (random() < 0.5)	sound (self, CHAN_AUTO, "rebar/stick_metal1.wav", 0.3, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "rebar/stick_metal2.wav", 0.3, ATTN_NORM);

	FX_Impact(FX_SPARK, self.origin, self.oldvelocity);
	
	gunshot(self.origin);

	if (other.solid == SOLID_BSP && other.classname != "func_movewall") {
		self.movetype = MOVETYPE_NONE;
		self.solid = SOLID_NOT;
		self.owner = other;
		self.touch = SUB_Null;
		// change model so that smoke doesn't appear when stuck to moving brushes
		setmodel(self, "progs/placeholder_progs/proj_nail_heavy.mdl");


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
*/
void() updateRebars_MELEE_THROW =
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
