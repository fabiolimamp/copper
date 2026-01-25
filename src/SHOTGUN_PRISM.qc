//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SHOTGUN_PRISM_NAME	=	"SHOTGUN_PRISM";
string	SHOTGUN_PRISM_MODEL	=	"progs/placeholder_progs/v_shotgun_prism.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)
//	0.8	11	5	1	'220 180 0'		//fade flak (55)
//	0.8	13	4	1	'220 180 0'		//fade flak (52)


//=============================================================================================
	
	
	float	SHOTGUN_PRISM_ROF	=	1;		//seconds post-fire
	
	float	SHOTGUN_PRISM_COUNT	=	12;		//number of shots
	float	SHOTGUN_PRISM_DMG 	=	5;	//60	//damage per shot

	float	SHOTGUN_PRISM_COST	=	1;		//ammo cost to fire
	float	SHOTGUN_PRISM_LIFE	=	0.2;		//seconds for pellet
	
	float	SHOTGUN_PRISM_SPEED	=	2000;		//2000 ups
	
	vector	SHOTGUN_PRISM_SPREAD	=	'160 240 0';	//seconds post-fire	//W_Fire_SHOTGUN_PRISM_flak

	float	SHOTGUN_PRISM_SPREAD_ORIGIN	=	20;	//projectile need BIG numbers vs tracers!
	float	SHOTGUN_PRISM_SPREAD_WIDTH	=	1000;
	float	SHOTGUN_PRISM_SPREAD_RISE	=	100;

//=============================================================================================

float() weaponanim_SHOTGUN_PRISM =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_PRISM_COST;
	self.attack_finished = time + SHOTGUN_PRISM_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	//self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	//W_Fire_SHOTGUN_PRISM_hitscan();
	W_Fire_SHOTGUN_PRISM_flak();

	self.weaponframe = 11;	
	self.think = weaponanim_SHOTGUN_PRISM_loop;
	self.nextthink = time + 0.05;	
	return TRUE;
}

void() weaponanim_SHOTGUN_PRISM_loop =
{
	if (intermission) return;

	if (self.weaponframe == 21) 
	{
		Eject_BuckshotCasing();
		sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	}
	
	//if (self.weaponframe >= 40)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SHOTGUN_PRISM_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void() W_Fire_SHOTGUN_PRISM_flak =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun1.wav", 0.1, ATTN_NORM);
	sound_shotgun_shoot(0.5);
	
	makevectors(self.v_angle);
	self.punchangle_x = -2;
	
	float shotcount = SHOTGUN_PRISM_COUNT;
	vector spread = SHOTGUN_PRISM_SPREAD;
	vector view_origin = self.origin + self.view_ofs + v_forward*12 + v_up*0 + v_right*0;

	
		float spread_width 	= SHOTGUN_PRISM_SPREAD_WIDTH;
		float spread_rise 	= SHOTGUN_PRISM_SPREAD_RISE;
		float pellet_count 	= SHOTGUN_PRISM_COUNT;

		float origin_width 	= SHOTGUN_PRISM_SPREAD_ORIGIN;
		float base 		= SHOTGUN_PRISM_SPEED;
	
	
	vector mvel;
	entity fl;
	while (shotcount > 0)
	{
		
		
		float pellet_spacing = spread_width / (pellet_count - 1);
		
		float spread_result = ((spread_width / 2) + pellet_spacing) - (pellet_spacing * shotcount);
		
		mvel = v_forward*base + v_up*4 + spread_result*v_right + crandom()*spread_rise*v_up;	
		
		
		
		
		float origin_spacing = origin_width / (pellet_count - 1);
		
		float origin_result = ((origin_width / 2) + origin_spacing) - (origin_spacing * shotcount);	
		
		vector org = view_origin + origin_result*v_right;	
		
		

		
		//mvel = (v_forward * SHOTGUN_PRISM_SPEED) + (v_up * 100) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		//fl = Launch_Flak_SHOTGUN_PRISM(view_origin, mvel);
		fl = Launch_Flak_SHOTGUN_PRISM(org + v_up*-4, mvel);
		fl.count = shotcount;
		shotcount = shotcount - 1;
	}
}


entity(vector org, vector vel) Launch_Flak_SHOTGUN_PRISM =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "flak");
	flak.lifetime_finished = time + SHOTGUN_PRISM_LIFE;
	flak.attack_finished = time + 1;
	flak.gravity = 0;
	flak.think = FlakThink;
	flak.nextthink = time + 0.05;
	flak.touch = FlakTouch_SHOTGUN_PRISM;
	flak.alpha = 1;
	flak.oldvelocity = flak.velocity;
	flak.movetype = MOVETYPE_FLYMISSILE;

	//SUB_ChangeModel (flak, "progs/proj_pellet.mdl");
	SUB_ChangeModel (flak, "progs/placeholder_progs/proj_pellet_blue.mdl");

	return flak;
}

void() FlakTouch_SHOTGUN_PRISM =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, SHOTGUN_PRISM_DMG);

		if (other.solid != SOLID_BSP) {
			//ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(SHOTGUN_PRISM_DMG));
		}

		FX_Impact(FX_BLOOD_BIG, self.origin, self.oldvelocity);

		particle (self.origin, self.velocity*0.1, 73, 40);

		float chance = random();
		
		if 	(chance < 0.33)	sound (self, CHAN_AUTO, "rebar/pierce1.wav", 0.2, ATTN_NORM);
		else if (chance < 0.5)	sound (self, CHAN_AUTO, "rebar/pierce2.wav", 0.2, ATTN_NORM);
		else			sound (self, CHAN_AUTO, "rebar/pierce3.wav", 0.2, ATTN_NORM);
		
		//sound (self, CHAN_AUTO, "rebar/pierce_impact.wav", 1, ATTN_NORM);

		// doesn't go through doors
		if (other.classname != "func_door" && other.classname != "func_door_secret"){
			projectile_passthru();
			return;
		}
	}
	else
		FX_Impact(FX_SPARK_LASER, self.origin, self.origin);
		remove(self);	
}