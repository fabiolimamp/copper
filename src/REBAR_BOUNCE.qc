//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	REBAR_BOUNCE_NAME	=	"REBAR_BOUNCE";
string	REBAR_BOUNCE_MODEL	=	"progs/placeholder_progs/v_rebar_bounce.mdl";


//	ROF	COUNT * DMG	COST	SPREAD		DESCRIPTION
//	1	1	100	10	'0 0 0'		//QBJ3 Rebar Cannon (100+)

//	1	1	140	10	'0 0 0'		//REBAR CANNON BUFF (140+)

//	1.2	1	100	10	'0 0 0'		//REBAR RIFLE ()

//	0.3	1	50	5	'0 0 0'		//REBAR REPEATER ()

//	0.6	1	80	10	'0 0 0'		//REBAR BOUNCE ()



//=============================================================================================
	
	
	float	REBAR_BOUNCE_ROF	=	0.5;		//seconds post-fire
	
	float	REBAR_BOUNCE_DMG 	=	60;	// 	//damage per shot

	float	REBAR_BOUNCE_COST	=	5;		//ammo cost to fire
	
	float	REBAR_BOUNCE_SPEED	=	2000;		//arc velocity

//=============================================================================================


float() weaponanim_REBAR_BOUNCE =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - REBAR_BOUNCE_COST;

	self.attack_finished = time + REBAR_BOUNCE_ROF;
	
	//SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	
	W_Fire_REBAR_BOUNCE();
	
	
	self.punchangle_x = -1;
	//self.effects |= EF_MUZZLEFLASH;


	self.weaponframe = 11;
	self.think = weaponanim_REBAR_BOUNCE_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_REBAR_BOUNCE_loop =
{
	if (self.weaponframe >= 40)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_REBAR_BOUNCE_loop;
	self.nextthink = time + 0.025;
}
//=============================================================================================

void() W_Fire_REBAR_BOUNCE =
{
	sound (self, CHAN_WEAPON, "rebar/penfire.wav", 0.8, ATTN_NORM);
	sound (self, CHAN_AUTO, "placeholder_sound/buzz_shoot.wav", 1, ATTN_NORM);
	//sound (self, CHAN_AUTO, "rebar/bow_reload1.wav", 1, ATTN_NORM);
	//sound (self, CHAN_AUTO, "placeholder_sound/sniper.wav", 1, ATTN_NORM);
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = REBAR_BOUNCE_SPEED;
	
	vector org = self.origin + self.view_ofs - v_up*8 + v_forward*15 + v_right*8;
	//vector mvel = v_forward*base + v_up*160;
	vector mvel = v_forward*base;
	
	
	
	launch_impaler_REBAR_BOUNCE(org, mvel);
	
	
	
	//HIP_LaunchLaser(org, mvel);
	
}
//=============================================================================================

entity(vector org, vector vel) launch_impaler_REBAR_BOUNCE =
{
	entity impaler;
	gunshot(org);

	impaler = toss_projectile(org, vel, "impaler");
	impaler.lifetime_finished = time + 10;
	
	
	SUB_ChangeModel (impaler, "progs/placeholder_progs/proj_buzz_small.mdl");

	//impaler.gravity = .75;
	impaler.gravity = 0;
	impaler.think = ImpalerThink_REBAR_BOUNCE;	//dont sink
	impaler.touch = ImpalerTouch_REBAR_BOUNCE;
	impaler.alpha = 1;
	impaler.movetype = MOVETYPE_FLYMISSILE;
	
	return impaler;
}

void() ImpalerThink_REBAR_BOUNCE =
{
	if (time > self.lifetime_finished)
	{
		ImpalerFade();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	//self.velocity.z -= 25;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

//=============================================================================================

void() ImpalerTouch_REBAR_BOUNCE =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		if (other.classname == "monster_zombie")
			T_Damage(other, self, self.trueowner, 59);
		else
			T_Damage(other, self, self.trueowner, REBAR_BOUNCE_DMG);

		if (other.solid != SOLID_BSP) {
			ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(20));
			ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(20));
		}

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
	
	sound (self, CHAN_AUTO, "rebar/stick1.wav", 0.5, ATTN_NORM);
	
	if (random() < 0.5)	sound (self, CHAN_AUTO, "rebar/stick_metal1.wav", 0.7, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "rebar/stick_metal2.wav", 0.7, ATTN_NORM);

	FX_Impact(FX_SPARK, self.origin, self.oldvelocity);
	
	gunshot(self.origin);
		
	
	if (other.solid == SOLID_BSP && other.classname != "func_movewall") {
		/*
		self.movetype = MOVETYPE_NONE;
		self.solid = SOLID_NOT;
		self.owner = other;
		self.touch = SUB_Null;
		// change model so that smoke doesn't appear when stuck to moving brushes
		//setmodel(self, "progs/proj_rebar_nosmoke.mdl");
		setmodel (self, "progs/placeholder_progs/proj_buzz_small.mdl");


		// move origin away from walls when stuck, helps prevent "void-lighting"
		setorigin(self, self.origin - 2*normalize(self.velocity));

		self.pos1 = other.absmin;

		// set state 2 to rebars attached to non-world entities (for movement and validity checks)
		if (other != world) self.state = 2;
		else self.state = 1;
		
		self.alpha = 1;
		self.think = ImpalerFade;
		self.nextthink = time + 10;
		*/
	}
	else
		remove(self);	
}