//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	REBAR_MULTI_NAME	=	"REBAR_MULTI";
string	REBAR_MULTI_MODEL	=	"progs/placeholder_progs/v_rebar_multi.mdl";


//	ROF	COUNT * DMG	COST	SPREAD		DESCRIPTION
//	1	1	100	10	'0 0 0'		//QBJ3 Rebar Cannon (100+)
//	1.6	4	50	20	500, 25		//REBAR MULTI (4*50=200+)


//=============================================================================================
	
	
	float	REBAR_MULTI_ROF		=	1.6;		//seconds post-fire
	
	float	REBAR_MULTI_COUNT	=	4;		//number of shots
	float	REBAR_MULTI_DMG 	=	50;	//200	//damage per shot

	float	REBAR_MULTI_COST	=	20;		//ammo cost to fire
	
	float	REBAR_MULTI_SPREAD_WIDTH	=	500;	//projectile need BIG numbers vs tracers!
	float	REBAR_MULTI_SPREAD_RISE		=	25;

//=============================================================================================

float() weaponanim_REBAR_MULTI =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - REBAR_MULTI_COST;

	self.attack_finished = time + REBAR_MULTI_ROF;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	W_Fire_REBAR_MULTI();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK

	self.weaponframe = 11;
	self.think = weaponanim_REBAR_MULTI_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_REBAR_MULTI_loop =
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

	self.think = weaponanim_REBAR_MULTI_loop;
	self.nextthink = time + 0.05;

}
//=============================================================================================

void() W_Fire_REBAR_MULTI =
{
	sound (self, CHAN_WEAPON, "rebar/penfire.wav", 0.5, ATTN_NORM);
	sound (self, CHAN_AUTO, "rebar/bow_reload1.wav", 1, ATTN_NORM);
	
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = 1400;
	
	vector org = self.origin + self.view_ofs - v_up*8 + v_forward*15;
	vector mvel = v_forward*base + v_up*160;
	
			
	float shotcount = REBAR_MULTI_COUNT;
	float spread_width = REBAR_MULTI_SPREAD_WIDTH;
	float spread_rise = REBAR_MULTI_SPREAD_RISE;
	float pellet_count = REBAR_MULTI_COUNT;

	while (shotcount > 0)
	{
		float pellet_spacing = spread_width / (pellet_count - 1);
		
		float spread_result = ((spread_width / 2) + pellet_spacing) - (pellet_spacing * shotcount);	
		
		mvel = v_forward*base + v_up*160 + spread_result*v_right + crandom()*REBAR_MULTI_SPREAD_RISE*v_up;	
			
		launch_impaler_REBAR_MULTI(org, mvel);

		shotcount--;
	}	
}
//=============================================================================================

entity(vector org, vector vel) launch_impaler_REBAR_MULTI =
{
	entity impaler;
	gunshot(org);

	impaler = toss_projectile(org, vel, "impaler");
	impaler.lifetime_finished = time + 10;
	
	SUB_ChangeModel (impaler, "progs/placeholder_progs/proj_stake_smoke.mdl");

	impaler.gravity = .75;
	impaler.think = ImpalerThink_REBAR_MULTI;
	impaler.touch = ImpalerTouch_REBAR_MULTI;
	impaler.alpha = 1;

	return impaler;
}

void() ImpalerThink_REBAR_MULTI =
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

void() ImpalerFade_REBAR_MULTI =
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

void() ImpalerTouch_REBAR_MULTI =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, REBAR_MULTI_DMG);
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

void() updateRebars_REBAR_MULTI =
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