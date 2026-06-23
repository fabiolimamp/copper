//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	NAIL_HEAVY_NAME		=	"NAIL_HEAVY";
string	NAIL_HEAVY_MODEL	=	"progs/placeholder_progs/v_nail_heavy.mdl";


//	ROF	COUNT * DMG	COST	SPEED		DESCRIPTION
//	0.08	1	9	1	1996		//QBJ3 Twin Nailgun (9)

//	0.15	2	13	2	1400		//QBJ3 Twin Nailgun (2*13=26)


//=============================================================================================
	
	
	float	NAIL_HEAVY_ROF		=	0.15;		//seconds post-fire
	
	//float	NAIL_HEAVY_COUNT	=	1;		//number of shots
	float	NAIL_HEAVY_DMG 		=	13;	//26	//damage per shot

	float	NAIL_HEAVY_COST		=	2;		//ammo cost to fire
	
	float	NAIL_HEAVY_SPEED	=	1400;		//arc velocity
	
	//float	NAIL_HEAVY_SPREAD_ORIGIN	=	0;	//projectile need BIG numbers vs tracers!
	//float	NAIL_HEAVY_SPREAD_HEIGHT	=	200;	//projectile need BIG numbers vs tracers!
	//float	NAIL_HEAVY_SPREAD_RAND		=	50;

//=============================================================================================


float() weaponanim_NAIL_HEAVY =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - NAIL_HEAVY_COST;

	self.attack_finished = time + NAIL_HEAVY_ROF;
	
	//SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	
	W_Fire_NAIL_HEAVY(8);
	W_Fire_NAIL_HEAVY(20);
	
	
	self.punchangle_x = -1;
	self.effects |= EF_MUZZLEFLASH;
	
	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 0.8, ATTN_NORM);	
	sound (self, CHAN_AUTO, "nail/airpuff.wav", 1, ATTN_NORM);	
	nailgun_sound(0.45);


	self.weaponframe = 11;
	self.think = weaponanim_NAIL_HEAVY_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_NAIL_HEAVY_loop =
{
	if (self.weaponframe >= 20)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_NAIL_HEAVY_loop;
	self.nextthink = time + 0.025;
}
//=============================================================================================

void(float off_set) W_Fire_NAIL_HEAVY =
{
	//self.currentammo = self.ammo_nails = self.ammo_nails - NAIL_HEAVY_COST;
	//self.punchangle_x = -1;
	//self.effects |= EF_MUZZLEFLASH;
	
	//sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 0.8, ATTN_NORM);	
	//sound (self, CHAN_AUTO, "nail/airpuff.wav", 1, ATTN_NORM);	
	//nailgun_sound(0.45);

	makevectors(self.v_angle);
	vector dir = aim(self, AUTOAIM_DIST);
	vector org = self.origin + self.view_ofs + v_forward*11 + v_right*8 - v_up*off_set;

	// default sv_maxvelocity is 2000, any higher leads to weird 
	// angular offsets caused by clamping the velocity
	
	entity spike = launch_projectile(org, dir * NAIL_HEAVY_SPEED, "nail");
	spike.touch = NAIL_HEAVY_touch;
	spike.alpha = 1;
	spike.dmg = NAIL_HEAVY_DMG;

	spike.nextthink = time + 4; //air lifetime
	spike.think = SUB_Remove;
	
	//SUB_ChangeModel (spike, "progs/proj_nail.mdl");
	SUB_ChangeModel (spike, "progs/placeholder_progs/proj_stake.mdl");
}
//=============================================================================================

void() NAIL_HEAVY_touch =
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