//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SHOTGUN_OVERUNDER_NAME	=	"SHOTGUN_OVERUNDER";
string	SHOTGUN_OVERUNDER_MODEL	=	"progs/placeholder_progs/v_shotgun_overunder.mdl";


//	ROF	COUNT * DMG	COST	SPREAD		DESCRIPTION
//	1.05	22	4	1	'280 60 0'	//QBJ3 flak (88)
//	0.8	11	5	1	'220 180 0'	//fade flak (55)
//	0.8	13	4	1	'220 180 0'	//fade flak (52)
//	0.8	13	4	1	'220 180 0'	//fade flak (52)
//	0.8	10	5	1	'160 240 0'	//Cowbow maresleg (50*)
//	0.8	11	5	1	'0.16 0.1 0'	//Cowbow Quakey (55) hitscan, no pierce

//	1.6	10	5	2	'180 280 0'	//Shotgun Overunder 2-tapper (100) proj, no pierce


//	90 / 1 = 90 DPS
//	50 / 0.7 = 71 DPS
//	55 / 0.8 = 68 DPS*
//	60 / 0.9 = 67 DPS
//	66 / 1 = 66 DPS

//=============================================================================================
	
	
	float	SHOTGUN_OVERUNDER_ROF		=	1.6;		//seconds post-fire
	
	float	SHOTGUN_OVERUNDER_COUNT		=	10;		//number of shots
	float	SHOTGUN_OVERUNDER_DMG 		=	5;	//50*2=100	//damage per shot

	float	SHOTGUN_OVERUNDER_COST		=	2;		//ammo cost to fire
	
	vector	SHOTGUN_OVERUNDER_SPREAD	=	'0.1 0.12 0';	//0.14 0.08 0' ID1 spread amount
	
	
	
	float	SHOTGUN_OVERUNDER_LIFE	=	0.5;		//seconds for pellet
	
	float	SHOTGUN_OVERUNDER_SPEED	=	2000;		//2000 ups
	
	vector	SHOTGUN_OVERUNDER_SPREAD_PROJ=	'180 280 0';	//seconds post-fire


//=============================================================================================

float() weaponanim_SHOTGUN_OVERUNDER =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_OVERUNDER_COST;
	self.attack_finished = time + SHOTGUN_OVERUNDER_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	//self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	
	//W_Fire_SHOTGUN_OVERUNDER();
	W_Fire_SHOTGUN_OVERUNDER_flak();


	self.weaponframe = 11;	
	self.think = weaponanim_SHOTGUN_OVERUNDER_loop;
	self.nextthink = time + 0.05;	
	return TRUE;
}

void() weaponanim_SHOTGUN_OVERUNDER_loop =
{
	if (intermission) return;
	
	if (self.weaponframe == 14) W_Fire_SHOTGUN_OVERUNDER_flak();	//W_Fire_SHOTGUN_OVERUNDER();

	if (self.weaponframe == 23) 
	{
		Eject_BuckshotCasing();
		Eject_BuckshotCasing();
		sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	}
	
	if (self.weaponframe == 34) sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	
	//if (self.weaponframe >= 40)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 40)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SHOTGUN_OVERUNDER_loop;
	self.nextthink = time + 0.05;
}

//=============================================================================================

void() W_Fire_SHOTGUN_OVERUNDER =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun1.wav", 0.5, ATTN_NORM);
	sound (self, CHAN_AUTO, "flak/volley_fire1.wav", 1, ATTN_NORM);
	//sound_shotgun_shoot(0.5);
	
		
	makevectors(self.v_angle);
	vector org_gun = self.origin + self.view_ofs + v_forward*12 + v_up*-4 + v_right*4;
	vector org_eye = self.origin + self.view_ofs;
	
	// aim point directly in front of the crosshair
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
	
	self.punchangle_x = -2;
	local vector dir = aim(self, AUTOAIM_DIST);
	
	ClearMultiDamage();
	
	FirePistolBullets(SHOTGUN_OVERUNDER_COUNT, SHOTGUN_OVERUNDER_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_OVERUNDER_SPREAD, 4, TRUE);                        
	
	ApplyMultiDamage();
}

//=============================================================================================
//=============================================================================================
//=============================================================================================
//=============================================================================================

void() W_Fire_SHOTGUN_OVERUNDER_flak =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun1.wav", 0.5, ATTN_NORM);
	sound (self, CHAN_AUTO, "flak/volley_fire1.wav", 1, ATTN_NORM);
	//sound_shotgun_shoot(0.5);
	
	makevectors(self.v_angle);
	self.punchangle_x = -2;
	
	float shotcount = SHOTGUN_OVERUNDER_COUNT;
	vector spread = SHOTGUN_OVERUNDER_SPREAD_PROJ;
	vector view_origin = self.origin + self.view_ofs + v_forward*12 + v_up*-4 + v_right*4;

	vector mvel;
	entity fl;
	while (shotcount > 0)
	{
		mvel = (v_forward * SHOTGUN_OVERUNDER_SPEED) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		fl = Launch_Flak_SHOTGUN_OVERUNDER_proj(view_origin, mvel);

		fl.count = shotcount;
		shotcount = shotcount - 1;
	}
}


entity(vector org, vector vel) Launch_Flak_SHOTGUN_OVERUNDER_proj =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "flak");
	flak.lifetime_finished = time + SHOTGUN_OVERUNDER_LIFE;
	flak.attack_finished = time + 1;
	flak.gravity = -0.1;
	flak.think = FlakThink;
	flak.nextthink = time + 0.05;
	flak.touch = FlakTouch_SHOTGUN_OVERUNDER_proj;
	flak.alpha = 1;
	flak.oldvelocity = flak.velocity;
	//flak.movetype = MOVETYPE_FLYMISSILE;

	SUB_ChangeModel (flak, "progs/proj_pellet.mdl");

	return flak;
}
//=============================================================================================
//=============================================================================================
//=============================================================================================

void() FlakTouch_SHOTGUN_OVERUNDER_proj =
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

		T_Damage(other, self, self.trueowner, SHOTGUN_SAWED_DMG);
		
		//dprint3("Dealing damage, health ", ftos(other.health), "\n");
		SpawnBlood(self.origin, self.velocity, 50);

		if (random() < 0.25)	FX_Impact(FX_BLOOD_BIG, self.origin, self.velocity);

		sound_flakshotgun_impact();

		if (other.health <= 0) projectile_passthru();
		else remove(self);
		
		return;
	}
	FX_Impact(FX_SPARK, self.origin, self.origin);
	remove(self);
}