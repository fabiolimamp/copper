//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	REBAR_BUZZSAW2_NAME	=	"Buzzsaw Cannon";
string	REBAR_BUZZSAW2_MODEL	=	"progs/placeholder_progs/v_rebar_buzzsaw_charge.mdl";

.float	buzzsaw_charge;

//	ROF	COUNT * DMG	COST	SPREAD		DESCRIPTION
//	1	1	100	10	'0 0 0'		//QBJ3 Rebar Cannon (100+)

//	1	1	140	10	'0 0 0'		//REBAR CANNON BUFF (140+)

//	1.2	1	100	10	'0 0 0'		//REBAR RIFLE ()

//	0.3	1	50	5	'0 0 0'		//REBAR REPEATER ()

//	0.6	1	80	10	'0 0 0'		//REBAR BOUNCE ()
//	0.5	1	60	5	'0 0 0'		//REBAR BOUNCE ()



//=============================================================================================
	
	
	float	REBAR_BUZZSAW2_COOLDOWN	=	0.5;			//seconds post-fire
	
	float	REBAR_BUZZSAW2_DMG 	=	50;	//250;	 	//damage per charge level: (BASE)  x1,    x2,    x3,     x4    x5 (MAX)	
									//frames: 11-51		         (11-20, 21-30, 31-40, 41-50, 51+)	
									//total refire at 40fps = 1 second charge + 0.5 cooldown

	float	REBAR_BUZZSAW2_COST	=	20;	//5;		//ammo cost to fire
	
	float	REBAR_BUZZSAW2_SPEED	=	2000;			//arc velocity

//=============================================================================================


float() weaponanim_REBAR_BUZZSAW2 =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	//self.currentammo = self.ammo_nails = self.ammo_nails - REBAR_BUZZSAW2_COST;

	self.attack_finished = time + 0.05;	//must get past 1st frame into loop before releasing attack and firing
	
	//self.buzzsaw_charge = 1;
	
	//self.weaponframe = 11;
	//self.think = weaponanim_REBAR_BUZZSAW2_loop_charge;
	//self.nextthink = time + 0.025;
	
	if (self.attackpressed && self.attackhold)
	{
		dprint("\nheld");
			
		self.weaponframe = 11;
		self.think = weaponanim_REBAR_BUZZSAW2_loop_charge;
		self.nextthink = time + 0.025;
	}
	else
	{
		dprint("\nrelease");
		
		self.buzzsaw_charge = 1;
	
		self.weaponframe = 51;
		self.think = weaponanim_REBAR_BUZZSAW2_loop_charge;
		self.nextthink = time + 0.025;
	}
	
	return TRUE;
}

void() weaponanim_REBAR_BUZZSAW2_loop_charge =
{
	local float swf = self.weaponframe;
		
	if (self.attackpressed && self.attackhold)
	{
		if 	(swf > 10 && swf <= 20)	
		{
			self.buzzsaw_charge = 1;
			dprint2("\nbuzzsaw_charge = ", ftos(self.buzzsaw_charge));
		}
		else if (swf > 20 && swf <= 30)
		{
			self.buzzsaw_charge = 2;
			dprint2("\nbuzzsaw_charge = ", ftos(self.buzzsaw_charge));
		}
		else if (swf > 30 && swf <= 40)
		{
			self.buzzsaw_charge = 3;
			dprint2("\nbuzzsaw_charge = ", ftos(self.buzzsaw_charge));
		}
		else if (swf > 40 && swf <= 50)
		{
			self.buzzsaw_charge = 4;
			dprint2("\nbuzzsaw_charge = ", ftos(self.buzzsaw_charge));
		}
		else if (swf >= 51)
		{
			self.buzzsaw_charge = 5;
			dprint2("\nbuzzsaw_charge = ", ftos(self.buzzsaw_charge));
			
			swf = 51;
			
			weaponanim_REBAR_BUZZSAW2_loop_fire();
			
			self.attack_finished = time + REBAR_BUZZSAW2_COOLDOWN;
			
			return;
		}
		self.attack_finished = time + 0.1;
	}
	else
	{
		swf = 51;
		
		weaponanim_REBAR_BUZZSAW2_loop_fire();
		
		self.attack_finished = time + REBAR_BUZZSAW2_COOLDOWN;
		
		return;
	}
	
	swf++;
	
	self.think = weaponanim_REBAR_BUZZSAW2_loop_charge;
	self.nextthink = time + 0.025;
}

void() weaponanim_REBAR_BUZZSAW2_loop_fire =
{
	if (self.weaponframe >= 80)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_REBAR_BUZZSAW2_loop_fire;
	self.nextthink = time + 0.025;
}
//=============================================================================================

void() W_Fire_REBAR_BUZZSAW2_CHARGE =
{
	sound (self, CHAN_WEAPON, "rebar/penfire.wav", 0.8, ATTN_NORM);
	sound (self, CHAN_AUTO, "placeholder_sound/buzz_shoot.wav", 1, ATTN_NORM);
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = REBAR_BUZZSAW2_SPEED;
	
	vector org = self.origin + self.view_ofs - v_up*8 + v_forward*15 + v_right*8;
	vector mvel = v_forward*base + v_up*160;
	
	Launch_REBAR_BUZZSAW2_Buzzsaw (org, mvel);
	
	dprint5("\n\bBUZZSAW TOTAL ", ftos(self.buzzsaw_charge), " * ", ftos(REBAR_BUZZSAW2_DMG), " = ");
	dprint(ftos(self.buzzsaw_charge * REBAR_BUZZSAW2_DMG));
	
	
	
	self.currentammo = self.ammo_nails = self.ammo_nails - REBAR_BUZZSAW2_COST;
	
	SuperDamageSound();
	
	self.effects = self.effects | EF_MUZZLEFLASH;
	
	//self.attack_finished = time + REBAR_BUZZSAW2_COOLDOWN;
		
	self.buzzsaw_charge = 1;		
}

//=============================================================================================

void() ImpalerTouch_REBAR_BUZZSAW2_Buzzsaw =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		if (!(other.customflags & CFL_GIBBED))
		{
			if (other.model == "progs/soldier_pistol_qbj.mdl")
								
				FX_Split_Half(other.splithalftorso, other.splithalflegs, other.enemydropgun, other.origin, other.oldvelocity);
		}		
		
		//if ((other.health < REBAR_BUZZSAW2_DMG) && (other.model == "progs/soldier_pistol_qbj.mdl"))
		//	FX_Split_Half(other.splithalftorso, other.splithalflegs, other.enemydropgun, other.origin, other.oldvelocity);
		
		
		
		
		if (other.classname == "monster_zombie")
			T_Damage(other, self, self.trueowner, 59);
		else
			T_Damage(other, self, self.trueowner, self.buzzsaw_charge * REBAR_BUZZSAW2_DMG);

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
		//setmodel(self, "progs/proj_rebar_nosmoke.mdl");
		
		//setmodel (self, "progs/placeholder_progs/proj_buzz_small.mdl");
		setmodel (self, "progs/placeholder_progs/proj_buzz_large.mdl");


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



////////////////////////////////////////////////////////////////////////////////////////////////
// piercing projectile Impaler code by Fairweather, edits by Kebby
////////////////////////////////////////////////////////////////////////////////////////////////

entity(vector org, vector vel) Launch_REBAR_BUZZSAW2_Buzzsaw =
{
	
	entity buzzsaw;
	buzzsaw = toss_projectile(org, vel, "impaler");
	buzzsaw.lifetime_finished = time + 10;
	
	buzzsaw.gravity = 0;
	buzzsaw.think = REBAR_BUZZSAW2_Buzzsaw_Think;
	buzzsaw.touch = ImpalerTouch_REBAR_BUZZSAW2_Buzzsaw_1;
	buzzsaw.th_die = ImpalerFade;
	buzzsaw.buddy = self;
	
	buzzsaw.alpha = 1;
	//buzzsaw.movetype = MOVETYPE_FLYMISSILE;	//doesnt like this for some reason?

	//SUB_ChangeModel (buzzsaw, "progs/placeholder_progs/proj_buzz_small.mdl");
	SUB_ChangeModel (buzzsaw, "progs/placeholder_progs/proj_buzz_large_hot.mdl");	//_hot leaves trail + glowing


	return buzzsaw;
}

void() REBAR_BUZZSAW2_Buzzsaw_Think =
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
//=============================================================================================
//=============================================================================================
//=============================================================================================
void() ImpalerTouch_REBAR_BUZZSAW2_Buzzsaw_1 =
{
	self.gravity = 1;
	
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
			T_Damage(other, self, self.trueowner, self.buzzsaw_charge * REBAR_BUZZSAW2_DMG);

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
		
		
	self.touch = ImpalerTouch_REBAR_BUZZSAW2_Buzzsaw_2;
}
//=============================================================================================
void() ImpalerTouch_REBAR_BUZZSAW2_Buzzsaw_2 =
{
	self.gravity = 2;
	
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
			T_Damage(other, self, self.trueowner, self.buzzsaw_charge * REBAR_BUZZSAW2_DMG);

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
		
		
	self.touch = ImpalerTouch_REBAR_BUZZSAW2_Buzzsaw_3;
}
//=============================================================================================
void() ImpalerTouch_REBAR_BUZZSAW2_Buzzsaw_3 =
{
	self.gravity = 4;
	
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
			T_Damage(other, self, self.trueowner, self.buzzsaw_charge * REBAR_BUZZSAW2_DMG);

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
		//setmodel(self, "progs/proj_rebar_nosmoke.mdl");
		
		//setmodel (self, "progs/placeholder_progs/proj_buzz_small.mdl");
		setmodel (self, "progs/placeholder_progs/proj_buzz_large.mdl");


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