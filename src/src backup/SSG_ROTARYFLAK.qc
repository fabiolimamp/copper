//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SSG_ROTARYFLAK_NAME	=	"SSG_ROTARYFLAK";
//string	SSG_ROTARYFLAK_MODEL	=	"progs/placeholder_progs/v_ssg_rotary.mdl";
string	SSG_ROTARYFLAK_MODEL	=	"progs/placeholder_progs/v_ssg_auto.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)
//	1.3	20	2	1*4	'0.1 0.02 0'		//Dwell Rotary hitscan (40*4= 160)
//	1.3	10	5	1*4	'0.1 0.02 0'		//Dwell Rotary hitscan (50*4= 200)
//	1.3	10	4	1*4	'200 50 0'		//Dwell Rotary hitscan (40*4= 160)


//=============================================================================================
	
	
	float	SSG_ROTARYFLAK_ROF	=	1.3;		//seconds post-fire
	
	float	SSG_ROTARYFLAK_COUNT	=	10;		//number of shots
	float	SSG_ROTARYFLAK_DMG 	=	4;	//=40	//damage per shot
	
	float	SG_ROTARYFLAK_SPEED	=	2000;	//	//ups
	float	SSG_ROTARYFLAK_LIFE	=	0.8;	//	//seconds to live

	float	SSG_ROTARYFLAK_COST	=	1;	//*4	//ammo cost to fire
	
	vector	SSG_ROTARYFLAK_SPREAD	=	'200 50 0';	//spread
	

//=============================================================================================

float() weaponanim_SSG_ROTARYFLAK =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	//self.currentammo = self.ammo_shells = self.ammo_shells - SSG_ROTARYFLAK_COST;
	self.attack_finished = time + SSG_ROTARYFLAK_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	
	W_Fire_SSG_ROTARYFLAK_flak();


	self.weaponframe = 11;
	self.think = weaponanim_SSG_ROTARYFLAK_loop;
	self.nextthink = time + 0.025;	
	return TRUE;
}

void() weaponanim_SSG_ROTARYFLAK_loop =
{
	if (intermission) return;

	//fires:  1,  8, 16, 24
	//+draw: 11, 18, 26, 34

	if (self.weaponframe == 18)	W_Fire_SSG_ROTARYFLAK_flak();
	if (self.weaponframe == 26)	W_Fire_SSG_ROTARYFLAK_flak();
	if (self.weaponframe == 34)	W_Fire_SSG_ROTARYFLAK_flak();
		
	if (self.weaponframe >= 50)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 72)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SSG_ROTARYFLAK_loop;
	self.nextthink = time + 0.025;
}

//=============================================================================================

void() W_Fire_SSG_ROTARYFLAK_flak =
{
	sound(self, CHAN_WEAPON, "placeholder_sound/shotgn3.wav", 1, ATTN_NORM);
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SSG_ROTARYFLAK_COST;
	Eject_BuckshotCasing();
	
	makevectors(self.v_angle);
	self.punchangle_x = -2;
	
	float shotcount = SSG_ROTARYFLAK_COUNT;
	vector spread = SSG_ROTARYFLAK_SPREAD;
	vector view_origin = self.origin + self.view_ofs + v_forward*12 + v_up*-4 + v_right*2;

	vector mvel;
	entity fl;
	while (shotcount > 0)
	{
		mvel = (v_forward * SG_ROTARYFLAK_SPEED) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		fl = Launch_Flak_SSG_ROTARYFLAK(view_origin, mvel);
		fl.count = shotcount;
		shotcount = shotcount - 1;
	}
}
//=============================================================================================

entity(vector org, vector vel) Launch_Flak_SSG_ROTARYFLAK =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "flak");
	flak.lifetime_finished = time + SSG_ROTARYFLAK_LIFE;
	flak.attack_finished = time + 1;
	flak.gravity = 0.1;
	flak.think = FlakThink;
	flak.nextthink = time + 0.05;
	flak.touch = FlakTouch_SSG_ROTARYFLAK;
	flak.alpha = 1;
	flak.oldvelocity = flak.velocity;
	//flak.movetype = MOVETYPE_FLYMISSILE;	//point

	//SUB_ChangeModel (flak, "progs/placeholder_progs/proj_pellet_blue.mdl");
	SUB_ChangeModel (flak, "progs/proj_pellet.mdl");

	return flak;
}
//=============================================================================================

void() FlakTouch_SSG_ROTARYFLAK =
{
	if (CheckProjectilePassthru()) return;

	if (self.attack_finished < time) {
		remove(self);
		return;
	}

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}

	if (other.takedamage)
	{
		T_Damage(other, self, self.trueowner, SSG_ROTARYFLAK_DMG);
		
		FX_Impact(FX_BLOOD_BIG, self.origin, self.oldvelocity);

		particle (self.origin, self.velocity*0.1, 73, 40);

		sound_flakshotgun_impact();

		if (other.health <= 0) projectile_passthru();
		else remove(self);
		
		return;
	}
	
	FX_Impact(FX_SPARK, self.origin, self.origin);
		
	remove(self);
}