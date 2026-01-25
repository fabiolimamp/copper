//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	NAIL_DRUM_NAME	=	"NAIL_DRUM";
string	NAIL_DRUM_MODEL	=	"progs/placeholder_progs/v_nail_drum.mdl";


//	ROF	COUNT * DMG	COST	SPEED		DESCRIPTION
//	0.08	1	9	1	1996		//QBJ3 Twin Nailgun (9)

//	0.15	2	13	2	1400		//QBJ3 Twin Nailgun (2*13=26)


//=============================================================================================
	
	
	float	NAIL_DRUM_ROF		=	0.12;		//seconds post-fire
	
	//float	NAIL_DRUM_COUNT		=	1;		//number of shots
	float	NAIL_DRUM_DMG 		=	18;		//damage per shot

	float	NAIL_DRUM_COST		=	2;		//ammo cost to fire
	
	float	NAIL_DRUM_SPEED		=	1500;		//velocity
	
	vector	NAIL_DRUM_SPREAD	=	'500 200 0';


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
	
	
	W_Fire_NAIL_DRUM();
	
	
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
	

	float spread_x = crandom()*crandom()*crandom()*crandom()*NAIL_DRUM_SPREAD_x;
	float spread_y = crandom()*crandom()*crandom()*crandom()*NAIL_DRUM_SPREAD_y;
	
	
	//vector dir = aim(self, AUTOAIM_DIST);
	
	vector org = self.origin + self.view_ofs + v_forward*11 + v_right*8 - v_up*8;
	
	
	entity spike = launch_projectile(org, (v_forward * NAIL_DRUM_SPEED) + (spread_x*v_right) + (spread_y*v_up), "nail");
	
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