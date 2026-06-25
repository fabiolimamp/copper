//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SAW_CANNON_NAME		=	"Saw Cannon";
string	SAW_CANNON_MODEL	=	"progs/placeholder_progs/v_rebar_buzzsaw_charge_1.mdl";

.float	buzzsaw_charge;

//=============================================================================================
	
	float	SAW_CANNON_COOLDOWN	=	0.5;		//seconds post-fire
	float	SAW_CANNON_DAMAGE	=	50;	//250; 	//damage per charge level: (BASE)  x1,    x2,    x3,     x4    x5 (MAX)	
								//frames: 11-51		         (11-20, 21-30, 31-40, 41-50, 51+)	
								//total refire at 40fps = 1 second charge + 0.5 cooldown
	float	SAW_CANNON_COST		=	5;		//ammo cost to fire, drains per charge level
	float	SAW_CANNON_VELOCITY	=	2000;		//arc velocity
	
//=============================================================================================

float() weaponanim_SAW_CANNON =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.attack_finished = time + 0.1;
	
	self.buzzsaw_charge = 0;
	self.weaponframe = 11;
	self.weaponmodel = "progs/placeholder_progs/v_rebar_buzzsaw_charge_1.mdl";
	
	self.think = weaponanim_SAW_CANNON_loop_charge;
	self.nextthink = time + 0.025;

	//self.currentammo = self.ammo_nails = self.ammo_nails - SAW_CANNON_COST;
	
	return TRUE;
}

void() weaponanim_SAW_CANNON_loop_charge =
{
	local float swf = self.weaponframe;
	local float new_charge;
	
	if (self.button0)
	{
		if 	(swf > 10 && swf <= 20)	new_charge = 1;
		else if (swf > 20 && swf <= 30)	new_charge = 2;
		else if (swf > 30 && swf <= 40)	new_charge = 3;
		else if (swf > 40 && swf <= 50)	new_charge = 4;
		else if (swf >= 51)		new_charge = 5;

		if (new_charge > self.buzzsaw_charge)
		{
			self.buzzsaw_charge = new_charge;
			self.currentammo = self.ammo_nails = self.ammo_nails - SAW_CANNON_COST;

			if (self.buzzsaw_charge == 2)
			{ self.weaponmodel = "progs/placeholder_progs/v_rebar_buzzsaw_charge_2.mdl"; sound (self, CHAN_WEAPON, "placeholder_sound/beep_tone_1.wav", 1, ATTN_NORM); }
			else if (self.buzzsaw_charge == 3)
			{ self.weaponmodel = "progs/placeholder_progs/v_rebar_buzzsaw_charge_3.mdl"; sound (self, CHAN_WEAPON, "placeholder_sound/beep_tone_2.wav", 1, ATTN_NORM); }
			else if (self.buzzsaw_charge == 4)
			{ self.weaponmodel = "progs/placeholder_progs/v_rebar_buzzsaw_charge_4.mdl"; sound (self, CHAN_WEAPON, "placeholder_sound/beep_tone_3.wav", 1, ATTN_NORM); }
			else if (self.buzzsaw_charge == 5)
			{
				self.weaponmodel = "progs/placeholder_progs/v_rebar_buzzsaw_charge_5.mdl";
				sound (self, CHAN_WEAPON, "placeholder_sound/beep_tone_5.wav", 1, ATTN_NORM);

				swf = 51;
				self.weaponframe = 51;

				W_Fire_SAW_CANNON_CHARGE();
				weaponanim_SAW_CANNON_loop_fire();

				self.attack_finished = time + SAW_CANNON_COOLDOWN;

				return;
			}

			// fire early if ammo emptied out mid-charge
			if (self.ammo_nails < SAW_CANNON_COST)
			{
				swf = 51;
				self.weaponframe = 51;

				W_Fire_SAW_CANNON_CHARGE();
				weaponanim_SAW_CANNON_loop_fire();

				self.attack_finished = time + SAW_CANNON_COOLDOWN;

				return;
			}
		}

		self.attack_finished = time + 0.1;
	}
	else
	{
		swf = 51;
		self.weaponframe = 51;
		
		W_Fire_SAW_CANNON_CHARGE();
		weaponanim_SAW_CANNON_loop_fire();
		
		self.attack_finished = time + SAW_CANNON_COOLDOWN;
		
		return;
	}
	
	swf++;
	self.weaponframe = swf;
	
	self.think = weaponanim_SAW_CANNON_loop_charge;
	self.nextthink = time + 0.05;
}

void() weaponanim_SAW_CANNON_loop_fire =
{
	if (self.weaponframe >= 80)
	{
		self.weaponframe = 10;
		self.weaponmodel = "progs/placeholder_progs/v_rebar_buzzsaw_charge_1.mdl";
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SAW_CANNON_loop_fire;
	self.nextthink = time + 0.025;
}
//=============================================================================================

void() W_Fire_SAW_CANNON_CHARGE =
{
	sound (self, CHAN_WEAPON, "rebar/penfire.wav", 0.8, ATTN_NORM);
	sound (self, CHAN_AUTO, "placeholder_sound/buzz_shoot.wav", 1, ATTN_NORM);
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = SAW_CANNON_VELOCITY;
	
	//vector org = self.origin + self.view_ofs - v_up*8 + v_forward*15 + v_right*8;
	vector org = self.origin + self.view_ofs - v_up*8 + v_forward*15;			//let's try firing buzzsaws from center like Rebar Cannon
	vector mvel = v_forward*base + v_up*160;
	
	Launch_SAW_CANNON_Buzzsaw (org, mvel);

	dprint5("\n\bBUZZSAW TOTAL ", ftos(self.buzzsaw_charge), " * ", ftos(SAW_CANNON_DAMAGE), " = ");
	dprint(ftos(self.buzzsaw_charge * SAW_CANNON_DAMAGE));

	SuperDamageSound();
	
	self.effects = self.effects | EF_MUZZLEFLASH;
			
	self.buzzsaw_charge = 1;		
}

////////////////////////////////////////////////////////////////////////////////////////////////
// piercing projectile Impaler code by Fairweather, edits by Kebby
////////////////////////////////////////////////////////////////////////////////////////////////

entity(vector org, vector vel) Launch_SAW_CANNON_Buzzsaw =
{
	
	entity buzzsaw;
	buzzsaw = toss_projectile(org, vel, "impaler");
	buzzsaw.lifetime_finished = time + 10;
	
	buzzsaw.gravity = 0;
	buzzsaw.think = SAW_CANNON_Buzzsaw_Think;
	buzzsaw.touch = SAW_CANNON_Buzzsaw_Touch_1;
	buzzsaw.th_die = ImpalerFade;
	buzzsaw.buddy = self;
	
	buzzsaw.alpha = 1;
	//buzzsaw.movetype = MOVETYPE_FLYMISSILE;	//doesnt like this for some reason?

	if 	(buzzsaw.trueowner.buzzsaw_charge == 1)	SUB_ChangeModel (buzzsaw, "progs/placeholder_progs/proj_buzz_hot_1.mdl");	
	else if (buzzsaw.trueowner.buzzsaw_charge == 2)	SUB_ChangeModel (buzzsaw, "progs/placeholder_progs/proj_buzz_hot_2.mdl");	
	else if (buzzsaw.trueowner.buzzsaw_charge == 3)	SUB_ChangeModel (buzzsaw, "progs/placeholder_progs/proj_buzz_hot_3.mdl");
	else if (buzzsaw.trueowner.buzzsaw_charge == 4)	SUB_ChangeModel (buzzsaw, "progs/placeholder_progs/proj_buzz_hot_4.mdl");
	else if (buzzsaw.trueowner.buzzsaw_charge == 5)	SUB_ChangeModel (buzzsaw, "progs/placeholder_progs/proj_buzz_hot_5.mdl");	//_hot leaves trail + glowing
	else	SUB_ChangeModel (buzzsaw, "progs/placeholder_progs/proj_buzz_hot_1.mdl");

	return buzzsaw;
}

void() SAW_CANNON_Buzzsaw_Think =
{
	if (time > self.lifetime_finished)
	{
		ImpalerFade();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	//self.velocity.z -= 25;
	self.nextthink = time + 0.05;			//<--- delay prevents trail from showing up in players face when firing
	self.think = SAW_CANNON_Buzzsaw_Think_Trail;
	self.angles = vectoangles(self.velocity);
}

void() SAW_CANNON_Buzzsaw_Think_Trail =
{
	if (time > self.lifetime_finished)
	{
		ImpalerFade();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	//self.velocity.z -= 25;
	self.nextthink = time + 0.01;			//<--- very fast nextthink so trail gaps are spaced closer
	self.think = SAW_CANNON_Buzzsaw_Think_Trail;
	self.angles = vectoangles(self.velocity);
	
	if 	(self.model == "progs/placeholder_progs/proj_buzz_hot_1.mdl")	Draw_Projectiletrail(self.angles, "progs/placeholder_progs/proj_buzz_trail_1.mdl");
	else if (self.model == "progs/placeholder_progs/proj_buzz_hot_2.mdl")	Draw_Projectiletrail(self.angles, "progs/placeholder_progs/proj_buzz_trail_2.mdl");
	else if (self.model == "progs/placeholder_progs/proj_buzz_hot_3.mdl")	Draw_Projectiletrail(self.angles, "progs/placeholder_progs/proj_buzz_trail_3.mdl");
	else if (self.model == "progs/placeholder_progs/proj_buzz_hot_4.mdl")	Draw_Projectiletrail(self.angles, "progs/placeholder_progs/proj_buzz_trail_4.mdl");
	else if (self.model == "progs/placeholder_progs/proj_buzz_hot_5.mdl")	Draw_Projectiletrail(self.angles, "progs/placeholder_progs/proj_buzz_trail_5.mdl");
	else	Draw_Projectiletrail(self.angles, "progs/placeholder_progs/proj_buzz_trail_1.mdl");
}

//=============================================================================================
//=============================================================================================
//=============================================================================================
//=============================================================================================

void() SAW_CANNON_Buzzsaw_Touch_1 =
{
	self.gravity = 1;
	
	local float buzzsaw_damage_total;	// = self.buzzsaw_charge * SAW_CANNON_DAMAGE
	
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
		{
			if 	(self.model == "progs/placeholder_progs/proj_buzz_hot_1.mdl")	buzzsaw_damage_total = 1 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_2.mdl")	buzzsaw_damage_total = 2 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_3.mdl")	buzzsaw_damage_total = 3 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_4.mdl")	buzzsaw_damage_total = 4 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_5.mdl")	buzzsaw_damage_total = 5 * SAW_CANNON_DAMAGE;
			else	T_Damage(other, self, self.trueowner, 0);
			
			T_Damage(other, self, self.trueowner, buzzsaw_damage_total);
		}
		
		
		//------------------------------------------------------------------------------------------
		// TEMP/WIP... makes every gibbed enemy a soldier_p lol
		if (other.customflags & CFL_GIBBED)
		{
			//if (other.model == "progs/soldier_pistol_qbj.mdl")	//why doesn't this work???
			{			
				dprint("/n/bSoldier_p got gibbed...");
				
				setmodel (other, "progs/placeholder_progs/splithalf_soldier_p_legs.mdl");
				other.frame = 0;
				setorigin(other, other.origin + '0 0 24');
				other.movetype = MOVETYPE_NONE;
				other.solid = SOLID_NOT;
				other.think = anim_split_half_legs;
				other.nextthink = time + 0.1;
				
				GoopBlood(0);
												
				Throw_Split_Half_Torso("progs/placeholder_progs/splithalf_soldier_p_torso.mdl", (self.oldvelocity * -0.05) + v_up*(buzzsaw_damage_total*1.5));
				
				//FX_Split_Half(other.splithalftorso, other.splithalflegs, other.enemydropgun, other.origin, other.oldvelocity);
				//TODO ^^^ this needs some work so we don't have raw other. calls inside the Touch function
			}
		}
		//------------------------------------------------------------------------------------------
		
		
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
			
	self.touch = SAW_CANNON_Buzzsaw_Touch_2;
}

//=============================================================================================

void() SAW_CANNON_Buzzsaw_Touch_2 =
{
	self.gravity = 2;
	
	local float buzzsaw_damage_total;	// = self.buzzsaw_charge * SAW_CANNON_DAMAGE
	
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
		{
			if 	(self.model == "progs/placeholder_progs/proj_buzz_hot_1.mdl")	buzzsaw_damage_total = 1 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_2.mdl")	buzzsaw_damage_total = 2 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_3.mdl")	buzzsaw_damage_total = 3 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_4.mdl")	buzzsaw_damage_total = 4 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_5.mdl")	buzzsaw_damage_total = 5 * SAW_CANNON_DAMAGE;
			else	T_Damage(other, self, self.trueowner, 0);
			
			T_Damage(other, self, self.trueowner, buzzsaw_damage_total);
		}


		//------------------------------------------------------------------------------------------
		// TEMP/WIP... makes every gibbed enemy a soldier_p lol
		if (other.customflags & CFL_GIBBED)
		{
			//if (other.model == "progs/soldier_pistol_qbj.mdl")	//why doesn't this work???
			{			
				dprint("/n/bSoldier_p got gibbed...");
				
				setmodel (other, "progs/placeholder_progs/splithalf_soldier_p_legs.mdl");
				other.frame = 0;
				setorigin(other, other.origin + '0 0 24');
				other.movetype = MOVETYPE_NONE;
				other.solid = SOLID_NOT;
				other.think = anim_split_half_legs;
				other.nextthink = time + 0.1;
				
				GoopBlood(0);
												
				Throw_Split_Half_Torso("progs/placeholder_progs/splithalf_soldier_p_torso.mdl", (self.oldvelocity * -0.05) + v_up*(buzzsaw_damage_total*1.25));
				
				//FX_Split_Half(other.splithalftorso, other.splithalflegs, other.enemydropgun, other.origin, other.oldvelocity);
				//TODO ^^^ this needs some work so we don't have raw other. calls inside the Touch function
			}
		}
		//------------------------------------------------------------------------------------------


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
			
	self.touch = SAW_CANNON_Buzzsaw_Touch_3;
}

//=============================================================================================

void() SAW_CANNON_Buzzsaw_Touch_3 =
{
	self.gravity = 4;
	
	local float buzzsaw_damage_total;	// = self.buzzsaw_charge * SAW_CANNON_DAMAGE
	
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
		{
			if 	(self.model == "progs/placeholder_progs/proj_buzz_hot_1.mdl")	buzzsaw_damage_total = 1 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_2.mdl")	buzzsaw_damage_total = 2 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_3.mdl")	buzzsaw_damage_total = 3 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_4.mdl")	buzzsaw_damage_total = 4 * SAW_CANNON_DAMAGE;
			else if (self.model == "progs/placeholder_progs/proj_buzz_hot_5.mdl")	buzzsaw_damage_total = 5 * SAW_CANNON_DAMAGE;
			else	T_Damage(other, self, self.trueowner, 0);
			
			T_Damage(other, self, self.trueowner, buzzsaw_damage_total);
		}
		
		
		//------------------------------------------------------------------------------------------
		// TEMP/WIP... makes every gibbed enemy a soldier_p lol
		if (other.customflags & CFL_GIBBED)
		{
			//if (other.model == "progs/soldier_pistol_qbj.mdl")	//why doesn't this work???
			{			
				dprint("/n/bSoldier_p got gibbed...");
				
				setmodel (other, "progs/placeholder_progs/splithalf_soldier_p_legs.mdl");
				other.frame = 0;
				setorigin(other, other.origin + '0 0 24');
				other.movetype = MOVETYPE_NONE;
				other.solid = SOLID_NOT;
				other.think = anim_split_half_legs;
				other.nextthink = time + 0.1;
				
				GoopBlood(0);
												
				Throw_Split_Half_Torso("progs/placeholder_progs/splithalf_soldier_p_torso.mdl", (self.oldvelocity * -0.05) + v_up*(buzzsaw_damage_total*1));
				
				//FX_Split_Half(other.splithalftorso, other.splithalflegs, other.enemydropgun, other.origin, other.oldvelocity);
				//TODO ^^^ this needs some work so we don't have raw other. calls inside the Touch function
			}
		}
		//------------------------------------------------------------------------------------------
		
		
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
		if 	(self.model == "progs/placeholder_progs/proj_buzz_hot_1.mdl")	setmodel (self, "progs/placeholder_progs/proj_buzz_1.mdl");
		else if (self.model == "progs/placeholder_progs/proj_buzz_hot_2.mdl")	setmodel (self, "progs/placeholder_progs/proj_buzz_2.mdl");
		else if (self.model == "progs/placeholder_progs/proj_buzz_hot_3.mdl")	setmodel (self, "progs/placeholder_progs/proj_buzz_3.mdl");
		else if (self.model == "progs/placeholder_progs/proj_buzz_hot_4.mdl")	setmodel (self, "progs/placeholder_progs/proj_buzz_4.mdl");
		else if (self.model == "progs/placeholder_progs/proj_buzz_hot_5.mdl")	setmodel (self, "progs/placeholder_progs/proj_buzz_5.mdl");
		else	setmodel (self, "progs/null.mdl");

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