//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	ROCKET_REMOTE_NAME	=	"ROCKET_REMOTE";
string	ROCKET_REMOTE_MODEL	=	"progs/placeholder_progs/v_rocket_remote.mdl";

//	ROF	COUNT * DMG	COST	SPEED_BASE	DESCRIPTION
//	0.8	1	120	1	1000		//ID RL (120+)
//	1.2	1	160	1	700		//RPG (160)

//=============================================================================================
	
	
	float	ROCKET_REMOTE_ROF		=	0.8;		//seconds post-fire
		
	float	ROCKET_REMOTE_DMG		=	40;	//dmg*3 = 120
		
	float	ROCKET_REMOTE_TIMER		=	10;	//set to 0 by [reload]?
		
	float	ROCKET_REMOTE_COST		=	1;		//ammo cost to fire
		
	float	ROCKET_REMOTE_SPEED		=	2000;		//rocket speed
	

//=============================================================================================

float() weaponanim_ROCKET_REMOTE =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - ROCKET_REMOTE_COST;

	self.attack_finished = time + ROCKET_REMOTE_ROF;
	
	//SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;



	W_Fire_ROCKET_REMOTE();



	self.weaponframe = 11;
	
	self.think = weaponanim_ROCKET_REMOTE_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_ROCKET_REMOTE_loop =
{
	if (self.weaponframe >= 30)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_ROCKET_REMOTE_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void() W_Fire_ROCKET_REMOTE =
{
	local entity missile;
	local vector loc;
		
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);

	self.punchangle_x = -3;
	
	makevectors (self.v_angle);
	loc = self.origin + v_forward * 8 + '0 0 16' + v_right*8;
	
	//missile = launch_ROCKET_REMOTE( loc, v_forward * ROCKET_REMOTE_SPEED);
	
	missile = launch_impaler_ROCKET_REMOTE( loc, v_forward * ROCKET_REMOTE_SPEED);
	
	FLOAT_Active_Mine++;
}

//=============================================================================================
//=============================================================================================

entity(vector org, vector vel) launch_impaler_ROCKET_REMOTE =
{
	entity mine;

	//mine = toss_projectile(org, vel, "mine");
	
	mine = launch_projectile(org, vel, "mine");
	
	mine.lifetime_finished = time + ROCKET_REMOTE_TIMER;
	
	
	SUB_ChangeModel (mine, "progs/placeholder_progs/proj_mine.mdl");
	
	mine.movetype = MOVETYPE_FLYMISSILE;
	
	mine.avelocity = '0 1200 0';
	
	mine.angles = vectoangles(mine.velocity);

	
	mine.touch = Mine_Touch; 			//mine will STICK to enemies, bounce off walls
	mine.think = Mine_Detonated; 			//when detonated

	setmodel (mine, "progs/placeholder_progs/proj_mine.mdl");

	return mine;
}

//=============================================================================================
// h4724

/*
void() ROCKET_REMOTE_BoltExplode =
{
	T_RadiusDamage (self, self.trueowner, ROCKET_REMOTE_DMG, other, DMGTYPE_EXPLOSION);
	T_RadiusDamage (self, self.trueowner, ROCKET_REMOTE_DMG, other, DMGTYPE_EXPLOSION);
	T_RadiusDamage (self, self.trueowner, ROCKET_REMOTE_DMG, other, DMGTYPE_EXPLOSION);
	
	BecomeExplosion();		//after timer ends
}


void() ROCKET_REMOTE_BoltTouchExplode =
{
	if (other.health)
	{
		T_Damage (other, self, self.trueowner, ROCKET_REMOTE_DMG*3, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );
	}
	
	T_RadiusDamage (self, self.trueowner, ROCKET_REMOTE_DMG, other, DMGTYPE_EXPLOSION);
	T_RadiusDamage (self, self.trueowner, ROCKET_REMOTE_DMG, other, DMGTYPE_EXPLOSION);
	T_RadiusDamage (self, self.trueowner, ROCKET_REMOTE_DMG, other, DMGTYPE_EXPLOSION);
	
	//T_GibDownedZombies (self, GRENADE_TRIBOLTqc_DMG);
}
//=============================================================================================

void() ROCKET_REMOTE_BoltTouch =
{
	if (other == self.owner ) return;		// don't explode on owner
	if (CheckProjectilePassthru()) return;

	self.velocity = '0 0 0';
	ROCKET_REMOTE_ExplosiveTouch();
	return;
}
//=============================================================================================

void() ROCKET_REMOTE_ExplosiveTouch =
{	
	if (other == self.owner ) return;        	// don't explode on owner
	if (CheckProjectilePassthru()) return;
	if (other.takedamage == DAMAGE_AIM)
	{
		if (other.classname == "monster_shambler")
			BecomeWeakExplosion();			//BecomeMiniBlast(2); //weak, no TE_effects
		else
			BecomeExplosion();			//BecomeMiniBlast(0); //normal, no TE_effects
	
		ROCKET_REMOTE_BoltTouchExplode();
		self.velocity = '0 0 0';
		return;
	}
	else
	{    
		SUB_ChangeModel (self, "progs/placeholder_progs/proj_mine_armed.mdl");
		
		// stop moving, stop turning and don't move again.
		self.velocity = '0 0 0';
		self.avelocity = '0 0 0';
		self.movetype = MOVETYPE_NONE;
	}
	
	sound_nailgun_impact_world(self.origin, 1);		// placeholder stick sound
	FX_Impact(FX_SPARK, self.origin + v_forward*-4, 0);	// placeholder stick effect
}
*/
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////



float FLOAT_Active_Mine;	//0=none active   1=at least one active


//=============================================================================================

void() Mine_Touch =
{
	self.enemy = other; //check for enemy
	
	{
		if (other == self.owner) return; 					//don't explode on owner
		if (self.velocity == '0 0 0') self.avelocity = '0 0 0';
	}

	if ( ((self.enemy != world) && (self.enemy.health > 1)) )			//if enemy & alive:
	{
		sound (self, CHAN_AUTO, "placeholder_sound/beep1.wav", 1, ATTN_NORM); 	//stick sound enemy
		//self.frame = 1;
		
		self.touch = Mine_Stick;
		self.velocity = (self.velocity * 0);
		self.avelocity = VEC_ORIGIN;
				
		self.origin = self.enemy.origin;	
		if ( (self.velocity == VEC_ORIGIN) ) {self.avelocity = VEC_ORIGIN;}
	}
	else
	{    
		sound (self, CHAN_AUTO, "placeholder_sound/beep1.wav", 1, ATTN_NORM); 	//stick sound
		
		// stop moving, stop turning and don't move again.
		self.velocity = '0 0 0';
		self.avelocity = '0 0 0';
		self.movetype = MOVETYPE_NONE;
	}
	
	//sound_nailgun_impact_world(self.origin, 1);		// placeholder stick sound
	FX_Impact(FX_SPARK, self.origin + v_forward*-4, 0);	// placeholder stick effect
};

//=============================================================================================

//mine  will NOT explode on enemy contact (will stick instead)
//mine  will NOT stick to walls

void() Mine_Stick = 	//updates position of stuck satchel charge on enemy
{
	if ( ((self.enemy != world) && (self.enemy.health > 1)) )			// if enemy & alive:
	{
		self.origin = self.enemy.origin;	
		if ( (self.velocity == VEC_ORIGIN) ) {self.avelocity = VEC_ORIGIN;}
	}
	self.nextthink = (time + 0.1);
};

//=============================================================================================

void() W_Detonate_Mine = 								//triggers remote detonation
{
        if (FLOAT_Active_Mine == 0)
        {
        	sprint (self, "No mines to detonate... \n");
        	return;
        }
        
        local entity    find_mine; 							//Declares the search entity for mine

        find_mine = findradius (self.origin, 10000); 					//Finds everything within a 10000 radius
        while(find_mine) 								//Loops through everything put in the mine entity
        {
                if((find_mine.classname == "mine") && (find_mine.owner == self)) 	//Checks mine owner
                        find_mine.nextthink = time + 0; 				//sends the message that it is time to react
			find_mine = find_mine.chain; 					//links every mine found so they all go BOOM!
        }
        FLOAT_Active_Mine = 0;								//reset FLOAT to 0, indicates 0 active entities
        sound (self, CHAN_AUTO, "placeholder_sound/beep2.wav", 1, ATTN_NORM); 		//detonate sound
};

//=============================================================================================

void() Mine_Detonated =
{
	T_RadiusDamage (self, self.owner, ROCKET_REMOTE_DMG, world);
	T_RadiusDamage (self, self.owner, ROCKET_REMOTE_DMG, world);
	T_RadiusDamage (self, self.owner, ROCKET_REMOTE_DMG, world);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	FLOAT_Active_Mine = 0;		//reset when explode, instant shoot again
	BecomeExplosion();		//explode
};
