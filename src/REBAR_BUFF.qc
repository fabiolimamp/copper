//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	REBAR_BUFF_NAME		=	"REBAR_BUFF";
string	REBAR_BUFF_MODEL	=	"progs/placeholder_progs/v_rebar_buff.mdl";


//	ROF	COUNT * DMG	COST	SPREAD		DESCRIPTION
//	1	1	100	10	'0 0 0'		//QBJ3 Rebar Cannon (100+)

//	1	1	150	15	'0 0 0'		//REBAR CANNON BUFF (150+)

//	1.6	4	50	20	500, 25		//REBAR MULTI (4*50=200+)
//	0.8	4	20	10	700, 25		//REBAR WIDE (4*20=80+)
//	1	3	30	10	500, 50		//REBAR TALL (3*30=90+)
//	0.7	1	50	5			//REBAR FAST (50+)
//	0.8	1	60	5			//REBAR FAST (60+)
//	0.5	1	50	5			//REBAR FAST (40+)


//=============================================================================================
	
	float	REBAR_BUFF_ROF		=	1;		//seconds post-fire
	
	float	REBAR_BUFF_COUNT	=	1;		//number of shots
	float	REBAR_BUFF_DMG 		=	140;	// 14	//damage per shot

	float	REBAR_BUFF_COST		=	10;		//ammo cost to fire
	
	//float	REBAR_BUFF_SPEED	=	1400;		//arc velocity
	//float	REBAR_BUFF_GRAVITY	=	0.75;		//arc sinkage

//=============================================================================================

float() weaponanim_REBAR_BUFF =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - REBAR_BUFF_COST;

	self.attack_finished = time + REBAR_BUFF_ROF;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	W_Fire_REBAR_BUFF();

	self.weaponframe = 11;
	self.think = weaponanim_REBAR_BUFF_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_REBAR_BUFF_loop =
{
	if (self.weaponframe == 18)	sound (self, CHAN_AUTO, "rebar/bow_reload2.wav", 0.3, ATTN_NORM);
	if (self.weaponframe == 20)	sound (self, CHAN_AUTO, "rebar/bow_clank.wav", 0.4, ATTN_NORM);
	if (self.weaponframe == 23)	sound (self, CHAN_AUTO, "rebar/bow_reload3.wav", 0.3, ATTN_NORM);
	if (self.weaponframe == 26)	sound (self, CHAN_AUTO, "rebar/bow_reload4.wav", 0.4, ATTN_NORM);
	
		
	if (self.weaponframe >= 30)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_REBAR_BUFF_loop;
	self.nextthink = time + 0.05;

}
//=============================================================================================

void() W_Fire_REBAR_BUFF =
{
	sound (self, CHAN_WEAPON, "rebar/penfire.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "rebar/bow_reload1.wav", 0.5, ATTN_NORM);
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = 1400;
	
	vector org = self.origin + self.view_ofs - v_up*8 + v_forward*15;
	vector mvel = v_forward*base + v_up*160;
	
	launch_impaler_REBAR_BUFF(org, mvel);
}
//=============================================================================================

entity(vector org, vector vel) launch_impaler_REBAR_BUFF =
{
	entity impaler;
	gunshot(org);

	impaler = toss_projectile(org, vel, "impaler");
	impaler.lifetime_finished = time + 10;
	
	SUB_ChangeModel (impaler, "progs/proj_rebar.mdl");

	impaler.gravity = .75;
	impaler.think = ImpalerThink;
	impaler.touch = ImpalerTouch_REBAR_BUFF;
	impaler.alpha = 1;
	setsize(impaler, '-12 -12 -12', '12 12 12');
	impaler.movetype = MOVETYPE_BOUNCEMISSILE;

	return impaler;
}

//=============================================================================================

void() ImpalerTouch_REBAR_BUFF =
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
			T_Damage(other, self, self.trueowner, REBAR_BUFF_DMG);

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
		self.movetype = MOVETYPE_NONE;
		self.solid = SOLID_NOT;
		self.owner = other;
		self.touch = SUB_Null;
		// change model so that smoke doesn't appear when stuck to moving brushes
		setmodel(self, "progs/proj_rebar_nosmoke.mdl");


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
