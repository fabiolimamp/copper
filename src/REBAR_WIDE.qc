//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	REBAR_WIDE_NAME		=	"REBAR_WIDE";
string	REBAR_WIDE_MODEL	=	"progs/placeholder_progs/v_rebar_wide.mdl";


//	ROF	COUNT * DMG	COST	SPREAD		DESCRIPTION
//	1	1	100	10	'0 0 0'		//QBJ3 Rebar Cannon (100+)
//	1.6	4	50	20	500, 25		//REBAR MULTI (4*50=200+)
//	0.8	4	20	10	700, 25		//REBAR WIDE (4*20=80+)
//	0.8	4	25	10	600, 25		//REBAR WIDE (4*20=80+)
//	0.8	8	15	10	500, 25		//REBAR WIDE (8*15=120+)


//=============================================================================================
	
	
	float	REBAR_WIDE_ROF		=	0.8;		//seconds post-fire
	
	float	REBAR_WIDE_COUNT	=	8;		//number of shots
	float	REBAR_WIDE_DMG 		=	15;	// 120	//damage per shot

	float	REBAR_WIDE_COST		=	10;		//ammo cost to fire
	
	float	REBAR_WIDE_SPEED	=	1400;		//arc velocity
	float	REBAR_WIDE_GRAVITY	=	0.75;		//arc sinkage
	
	float	REBAR_WIDE_SPREAD_ORIGIN	=	5;	//projectile need BIG numbers vs tracers!
	float	REBAR_WIDE_SPREAD_WIDTH		=	500;	//projectile need BIG numbers vs tracers!
	float	REBAR_WIDE_SPREAD_RISE		=	25;

//=============================================================================================

float() weaponanim_REBAR_WIDE =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - REBAR_WIDE_COST;

	self.attack_finished = time + REBAR_WIDE_ROF;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	//self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	W_Fire_REBAR_WIDE();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK

	self.weaponframe = 11;
	self.think = weaponanim_REBAR_WIDE_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_REBAR_WIDE_loop =
{
	if (self.weaponframe == 28)	sound (self, CHAN_AUTO, "rebar/bow_reload2.wav", 0.3, ATTN_NORM);
	if (self.weaponframe == 30)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	if (self.weaponframe == 32)	sound (self, CHAN_AUTO, "rebar/bow_clank.wav", 0.4, ATTN_NORM);
	if (self.weaponframe == 36)	sound (self, CHAN_AUTO, "rebar/bow_reload3.wav", 0.3, ATTN_NORM);
	if (self.weaponframe == 40)	sound (self, CHAN_AUTO, "rebar/bow_reload4.wav", 0.4, ATTN_NORM);
	
	
		
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_REBAR_WIDE_loop;
	self.nextthink = time + 0.033;

}
//=============================================================================================

void() W_Fire_REBAR_WIDE =
{
	sound (self, CHAN_WEAPON, "rebar/penfire.wav", 0.5, ATTN_NORM);
	sound (self, CHAN_AUTO, "rebar/bow_reload1.wav", 1, ATTN_NORM);
	
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = REBAR_WIDE_SPEED;
	
	//vector org = self.origin + self.view_ofs - v_up*8 + v_forward*15;
	vector mvel = v_forward*base + v_up*160;
	
			
	float shotcount = REBAR_WIDE_COUNT;
	float spread_width = REBAR_WIDE_SPREAD_WIDTH;
	float spread_rise = REBAR_WIDE_SPREAD_RISE;
	float pellet_count = REBAR_WIDE_COUNT;

	float origin_width = REBAR_WIDE_SPREAD_ORIGIN;



	while (shotcount > 0)
	{
		float pellet_spacing = spread_width / (pellet_count - 1);
		
		float spread_result = ((spread_width / 2) + pellet_spacing) - (pellet_spacing * shotcount);	
		
		mvel = v_forward*base + v_up*160 + spread_result*v_right + crandom()*REBAR_WIDE_SPREAD_RISE*v_up;	
		
		
		
		
		float origin_spacing = origin_width / (pellet_count - 1);
		
		float origin_result = ((origin_width / 2) + origin_spacing) - (origin_spacing * shotcount);	
		
		vector org = self.origin + self.view_ofs - v_up*8 + v_forward*15 + origin_result*v_right;
			
		
		
		
		launch_impaler_REBAR_WIDE(org, mvel);

		shotcount--;
	}	
}
//=============================================================================================

entity(vector org, vector vel) launch_impaler_REBAR_WIDE =
{
	entity impaler;
	gunshot(org);

	impaler = toss_projectile(org, vel, "impaler");
	impaler.lifetime_finished = time + 10;
	
	//SUB_ChangeModel (impaler, "progs/placeholder_progs/proj_stake_smoke.mdl");
	SUB_ChangeModel (impaler, "progs/placeholder_progs/proj_stake.mdl");

	impaler.gravity = REBAR_WIDE_GRAVITY;
	impaler.think = ImpalerThink_REBAR_WIDE;
	impaler.touch = ImpalerTouch_REBAR_WIDE;
	impaler.alpha = 1;

	return impaler;
}

void() ImpalerThink_REBAR_WIDE =
{
	if (time > self.lifetime_finished)
	{
		ImpalerFade();
		return;
	}

	self.angles = vectoangles(self.velocity);
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;
}

void() ImpalerFade_REBAR_WIDE =
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

void() ImpalerTouch_REBAR_WIDE =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, REBAR_WIDE_DMG);
		/*
		if (other.solid != SOLID_BSP) {
			ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(20));
			ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(20));
		}
		*/
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
		setmodel(self, "progs/placeholder_progs/proj_stake.mdl");


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

void() updateRebars_REBAR_WIDE =
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