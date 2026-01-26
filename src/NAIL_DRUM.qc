//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	NAIL_DRUM_NAME	=	"NAIL_DRUM";
string	NAIL_DRUM_MODEL	=	"progs/placeholder_progs/v_nail_drum.mdl";


//	ROF	COUNT * DMG	COST	SPEED		DESCRIPTION
//	0.08	1	9	1	1996		//QBJ3 Twin Nailgun (9)

//	0.15	2	13	2	1400		//Heavy Bolter	(2*13=26)

//	0.12	1	18	2	1500		//Nail Drum


//=============================================================================================
	
	
	float	NAIL_DRUM_ROF		=	0.16;		//seconds post-fire
	
//	float	NAIL_DRUM_COUNT		=	1;		//number of shots
	float	NAIL_DRUM_DMG 		=	18;		//damage per shot

	float	NAIL_DRUM_COST		=	2;		//ammo cost to fire
	
	float	NAIL_DRUM_SPEED		=	1400;		//velocity
	
	float	NAIL_DRUM_GRAVITY	=	25;		//25 rebar
	
//	vector	NAIL_DRUM_SPREAD	=	'100 100 0';


//=============================================================================================


float() weaponanim_NAIL_DRUM =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - NAIL_DRUM_COST;

	self.attack_finished = time + NAIL_DRUM_ROF;
	
	//SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	
	//W_Fire_NAIL_DRUM();		//linear
	
	W_Fire_NAIL_DRUM_Heavy();	//arc
	
	
	self.punchangle_x = -1;
	self.effects |= EF_MUZZLEFLASH;
	
	sound (self, CHAN_AUTO, "placeholder_sound/tommy_fire2.wav", 0.5, ATTN_NORM);
	//sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 0.8, ATTN_NORM);	
	sound (self, CHAN_AUTO, "nail/airpuff.wav", 0.5, ATTN_NORM);	
	nailgun_sound(0.45);


	self.weaponframe = 11;
	self.think = weaponanim_NAIL_DRUM_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_NAIL_DRUM_loop =
{
	if (self.weaponframe == 13) Eject_BulletCasing();
	
	if (self.weaponframe >= 20)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_NAIL_DRUM_loop;
	self.nextthink = time + 0.025;
}
//=============================================================================================

void() W_Fire_NAIL_DRUM =
{
	makevectors(self.v_angle);
	

	//float spread_x = crandom()*crandom()*crandom()*crandom()*NAIL_DRUM_SPREAD_x;
	//float spread_y = crandom()*crandom()*crandom()*crandom()*NAIL_DRUM_SPREAD_y;
	
	
	//vector dir = aim(self, AUTOAIM_DIST);
	
	vector org = self.origin + self.view_ofs + v_forward*11 + v_right*8 + v_up*-8;
	
	
	//entity spike = launch_projectile(org, (v_forward * NAIL_DRUM_SPEED) + (spread_x*v_right) + (spread_y*v_up), "nail");
	
	entity spike = launch_projectile(org, (v_forward * NAIL_DRUM_SPEED), "nail");
	
	spike.touch = NAIL_DRUM_touch;
	spike.alpha = 1;
	spike.dmg = NAIL_DRUM_DMG;

	spike.nextthink = time + 4; //air lifetime
	spike.think = SUB_Remove;
	
	//SUB_ChangeModel (spike, "progs/proj_nail.mdl");
	//SUB_ChangeModel (spike, "progs/placeholder_progs/proj_stake.mdl");
	SUB_ChangeModel (spike, "progs/placeholder_progs/proj_nail_heavy.mdl");
}
//=============================================================================================

void() NAIL_DRUM_touch =
{
	if (!CheckValidSpikeTouch()) return;

	if (other.takedamage)
	{
		spawn_touchblood (other, self.dmg);
		T_Damage (other, self, self.trueowner, self.dmg);
				
		sound_bullet_hit_enemy(0.7);
		
		FX_Impact(FX_BLOOD_BIG, self.origin, self.oldvelocity);
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
		if (random() < 0.5)	FX_Impact(FX_NAIL, self.origin, self.oldvelocity);
		
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
//=============================================================================================
//=============================================================================================
//=============================================================================================
//=============================================================================================
//=============================================================================================

void() W_Fire_NAIL_DRUM_Heavy =
{
	self.punchangle_x = -1;
	makevectors (self.v_angle);
	float base = REBAR_FAST_SPEED;
	
	vector org = self.origin + self.view_ofs + v_forward*11 + v_right*8 + v_up*-10;
	
	vector mvel = v_forward*base + v_up*160;

	launch_NAIL_DRUM_Heavy (org, mvel + v_right*-12);
}

//=============================================================================================

entity(vector org, vector vel) launch_NAIL_DRUM_Heavy =
{
	entity nail;
	//gunshot(org);

	nail = toss_projectile(org, vel, "nail");
	nail.lifetime_finished = time + 10;
	
	SUB_ChangeModel (nail, "progs/placeholder_progs/proj_nail_heavy.mdl");

	nail.think = ImpalerThink_NAIL_DRUM;
	//nail.touch = ImpalerTouch_NAIL_DRUM;
	nail.touch = NAIL_DRUM_Heavy_touch;	//dont pierce with nail
	nail.alpha = 1;
	nail.movetype = MOVETYPE_FLYMISSILE;

	return nail;
}

void() ImpalerThink_NAIL_DRUM =
{
	if (time > self.lifetime_finished)
	{
		ImpalerFade();
		return;
	}
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.velocity.z -= NAIL_DRUM_GRAVITY;
	self.nextthink = time + 0.05;
	self.angles = vectoangles(self.velocity);
}

void() ImpalerFade_NAIL_DRUM =
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

void() NAIL_DRUM_Heavy_touch =
{
	if (!CheckValidSpikeTouch()) return;

	if (other.takedamage)
	{
		spawn_touchblood (other, NAIL_DRUM_DMG);
		T_Damage (other, self, self.trueowner, NAIL_DRUM_DMG);
				
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

/*
void() ImpalerTouch_NAIL_DRUM =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, NAIL_DRUM_DMG);

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

void() updateRebars_NAIL_DRUM =
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
*/