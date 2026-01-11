//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SHOTGUN_AUTO_NAME	=	"SHOTGUN_AUTO";
string	SHOTGUN_AUTO_MODEL	=	"progs/placeholder_progs/v_shotgun_auto.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)
//	1.3	20	2	1*4	'0.1 0.02 0'		//Dwell Rotary hitscan (40*4= 160)
//	1.8	12	5	1*4	'0.4 0.015 0'~'0.1 0.03 0'		//Dwell Rotary hitscan (60*4= 240)
//	2	10	3	1*4	'0.4 0.015 0'~'0.1 0.03 0'		//Dwell Rotary hitscan (30*8= 240)
//	2	6	5	1*4	'0.4 0.015 0'~'0.1 0.03 0'		//Dwell Rotary hitscan (30*8= 240)
//	2	6	5	1*3	'0.2 0.02 0';		//Dwell Rotary hitscan (30*6= 180)
//	2	8	5	1*3	'0.2 0.02 0';		//Dwell Rotary hitscan (40*6= 240)


//=============================================================================================
	
	
	float	SHOTGUN_AUTO_ROF	=	2;		//seconds post-fire
	
	float	SHOTGUN_AUTO_COUNT	=	8;		//number of shots
	float	SHOTGUN_AUTO_DMG 	=	5;	//40	//damage per shot

	float	SHOTGUN_AUTO_COST	=	1;		//ammo cost to fire
	
	
	vector	SHOTGUN_AUTO_SPREAD	=	'0.2 	0.02 	0';	//W_Fire_SHOTGUN_AUTO_hitscan	
	
	
	
	/*
	vector	SHOTGUN_AUTO_SPREAD1	=	'0.4 	0.005 	0';	//W_Fire_SHOTGUN_AUTO_hitscan
	vector	SHOTGUN_AUTO_SPREAD2	=	'0.35 	0.01 	0';
	vector	SHOTGUN_AUTO_SPREAD3	=	'0.3 	0.015	0';
	vector	SHOTGUN_AUTO_SPREAD4	=	'0.25 	0.02 	0';
	vector	SHOTGUN_AUTO_SPREAD5	=	'0.2 	0.025 	0';
	vector	SHOTGUN_AUTO_SPREAD6	=	'0.15 	0.03 	0';
	vector	SHOTGUN_AUTO_SPREAD7	=	'0.1 	0.035 	0';
	vector	SHOTGUN_AUTO_SPREAD8	=	'0.05 	0.04 	0';
	*/

//=============================================================================================

float() weaponanim_SHOTGUN_AUTO =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	//self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;
	self.attack_finished = time + SHOTGUN_AUTO_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	//W_Fire_SHOTGUN_AUTO_hitscan(1);
	W_Fire_SHOTGUN_AUTO_hitscan_same();
	//W_Fire_SHOTGUN_AUTO_flak();


	
	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;
	Eject_BuckshotCasing();



	self.weaponframe = 11;
	self.think = weaponanim_SHOTGUN_AUTO_loop;
	self.nextthink = time + 0.025;	
	return TRUE;
}

void() weaponanim_SHOTGUN_AUTO_loop =
{
	if (intermission) return;

	//fires:  1,  8, 16, 24
	//+draw: 11, 18, 26, 34

	/*
	if (self.weaponframe == 16)	{W_Fire_SHOTGUN_AUTO_hitscan(2);}
	if (self.weaponframe == 21)	{W_Fire_SHOTGUN_AUTO_hitscan(3);	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;}
	if (self.weaponframe == 26)	{W_Fire_SHOTGUN_AUTO_hitscan(4);}
	if (self.weaponframe == 31)	{W_Fire_SHOTGUN_AUTO_hitscan(5);	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;}
	if (self.weaponframe == 36)	{W_Fire_SHOTGUN_AUTO_hitscan(6);}
	if (self.weaponframe == 41)	{W_Fire_SHOTGUN_AUTO_hitscan(7);	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;}
	if (self.weaponframe == 46)	{W_Fire_SHOTGUN_AUTO_hitscan(8);}
	*/
	
	/*
	if (self.weaponframe == 16)	{W_Fire_SHOTGUN_AUTO_hitscan_same();}
	if (self.weaponframe == 21)	{W_Fire_SHOTGUN_AUTO_hitscan_same();	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;}
	if (self.weaponframe == 26)	{W_Fire_SHOTGUN_AUTO_hitscan_same();}
	if (self.weaponframe == 31)	{W_Fire_SHOTGUN_AUTO_hitscan_same();	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;}
	if (self.weaponframe == 36)	{W_Fire_SHOTGUN_AUTO_hitscan_same();}
	if (self.weaponframe == 41)	{W_Fire_SHOTGUN_AUTO_hitscan_same();	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;}
	if (self.weaponframe == 46)	{W_Fire_SHOTGUN_AUTO_hitscan_same();}
	*/
	
	if (self.weaponframe == 18)	{W_Fire_SHOTGUN_AUTO_hitscan_same();}
	if (self.weaponframe == 24)	{W_Fire_SHOTGUN_AUTO_hitscan_same();	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;}
	if (self.weaponframe == 32)	{W_Fire_SHOTGUN_AUTO_hitscan_same();}
	if (self.weaponframe == 40)	{W_Fire_SHOTGUN_AUTO_hitscan_same();	self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;}
	if (self.weaponframe == 48)	{W_Fire_SHOTGUN_AUTO_hitscan_same();}

	
		
	if (self.weaponframe >= 60)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 72)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SHOTGUN_AUTO_loop;
	self.nextthink = time + 0.025;
}

//=============================================================================================

void() W_Fire_SHOTGUN_AUTO_hitscan_same =
{
	sound(self, CHAN_WEAPON, "placeholder_sound/shotgn3.wav", 1, ATTN_NORM);
	
	//self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;
	Eject_BuckshotCasing();
		
	makevectors(self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  6;
	vector org_eye = self.origin + self.view_ofs;
	
	// aim point directly in front of the crosshair
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
	
	self.punchangle_x = -1;
	local vector dir = aim(self, AUTOAIM_DIST);
	
	ClearMultiDamage();
	FirePistolBullets(SHOTGUN_AUTO_COUNT, SHOTGUN_AUTO_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_AUTO_SPREAD, TRUE);              
	ApplyMultiDamage();
}

void(float sequence) W_Fire_SHOTGUN_AUTO_hitscan =
{
	sound(self, CHAN_WEAPON, "placeholder_sound/shotgn3.wav", 1, ATTN_NORM);
	
	//self.currentammo = self.ammo_shells = self.ammo_shells - SHOTGUN_AUTO_COST;
	Eject_BuckshotCasing();
	
	
	
	makevectors(self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  6;
	vector org_eye = self.origin + self.view_ofs;
	
	// aim point directly in front of the crosshair
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
	
	
	
	self.punchangle_x = -1;
	local vector dir = aim(self, AUTOAIM_DIST);
	
	ClearMultiDamage();
	/*
	if (sequence == 1)	FireBulletsEx_SHOTGUN_AUTO(SHOTGUN_AUTO_COUNT, dir, SHOTGUN_AUTO_SPREAD1, SHOTGUN_AUTO_DMG);
	if (sequence == 2)	FireBulletsEx_SHOTGUN_AUTO(SHOTGUN_AUTO_COUNT, dir, SHOTGUN_AUTO_SPREAD2, SHOTGUN_AUTO_DMG);
	if (sequence == 3)	FireBulletsEx_SHOTGUN_AUTO(SHOTGUN_AUTO_COUNT, dir, SHOTGUN_AUTO_SPREAD3, SHOTGUN_AUTO_DMG);
	if (sequence == 4)	FireBulletsEx_SHOTGUN_AUTO(SHOTGUN_AUTO_COUNT, dir, SHOTGUN_AUTO_SPREAD4, SHOTGUN_AUTO_DMG);
	if (sequence == 5)	FireBulletsEx_SHOTGUN_AUTO(SHOTGUN_AUTO_COUNT, dir, SHOTGUN_AUTO_SPREAD5, SHOTGUN_AUTO_DMG);
	if (sequence == 6)	FireBulletsEx_SHOTGUN_AUTO(SHOTGUN_AUTO_COUNT, dir, SHOTGUN_AUTO_SPREAD6, SHOTGUN_AUTO_DMG);
	if (sequence == 7)	FireBulletsEx_SHOTGUN_AUTO(SHOTGUN_AUTO_COUNT, dir, SHOTGUN_AUTO_SPREAD7, SHOTGUN_AUTO_DMG);
	if (sequence == 8)	FireBulletsEx_SHOTGUN_AUTO(SHOTGUN_AUTO_COUNT, dir, SHOTGUN_AUTO_SPREAD8, SHOTGUN_AUTO_DMG);
	*/
	
	//FirePistolBullets (1, 20, org_eye, org_gun + v_forward * 16 * trace_fraction, dir_eye, spread, TRUE);
	//void(float shotcount, float dmg, vector shot_org, vector tracer_org, vector dir, vector spread, float tracer)
	
	/*
	if (sequence == 1)	FirePistolBullets(SHOTGUN_AUTO_COUNT, SHOTGUN_AUTO_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_AUTO_SPREAD1, TRUE);
	if (sequence == 2)	FirePistolBullets(SHOTGUN_AUTO_COUNT, SHOTGUN_AUTO_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_AUTO_SPREAD2, TRUE);
	if (sequence == 3)	FirePistolBullets(SHOTGUN_AUTO_COUNT, SHOTGUN_AUTO_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_AUTO_SPREAD3, TRUE);
	if (sequence == 4)	FirePistolBullets(SHOTGUN_AUTO_COUNT, SHOTGUN_AUTO_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_AUTO_SPREAD4, TRUE);
	if (sequence == 5)	FirePistolBullets(SHOTGUN_AUTO_COUNT, SHOTGUN_AUTO_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_AUTO_SPREAD5, TRUE);
	if (sequence == 6)	FirePistolBullets(SHOTGUN_AUTO_COUNT, SHOTGUN_AUTO_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_AUTO_SPREAD6, TRUE);
	if (sequence == 7)	FirePistolBullets(SHOTGUN_AUTO_COUNT, SHOTGUN_AUTO_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_AUTO_SPREAD7, TRUE);
	if (sequence == 8)	FirePistolBullets(SHOTGUN_AUTO_COUNT, SHOTGUN_AUTO_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_AUTO_SPREAD8, TRUE);
         */
	
	
	FirePistolBullets(SHOTGUN_AUTO_COUNT, SHOTGUN_AUTO_DMG, org_eye, org_gun + v_forward * 24 * trace_fraction, dir_eye, SHOTGUN_AUTO_SPREAD, TRUE);
	
	
	ApplyMultiDamage();
}

/*
void(float shotcount, vector dir, vector spread, float damage) FireBulletsEx_SHOTGUN_AUTO =
{
	vector src, direction;
	entity ig;
	float s, lim;
	
	if (shotcount <= 0) return;
	
	makevectors(self.v_angle);

	if (trace_debug) dprint3("*** firing ", ftos(shotcount), " bullets *\n\n");
	for (s = 0; s < shotcount; s++)
	{
		src = self.origin + v_forward*10;
		src_z = self.absmin_z + self.size_z * 0.7;
		direction = SpreadVector(dir, spread);
		
		if (trace_debug) dprint("* firing a bullet *\n");
		
		lim = 0;
		// check for trace-through cases
		for (ig = self; ig != world; lim++)	// ig == world if we hit a wall or hit nothing
		{
			traceline2(src, src + direction*2048, ig, 0);
			
			if (trace_ent == self)
				return;	// some notrace shit happened
		
			// if we've already pelted a monster enough to kill it, let additional bullets add 
			// up for possible gibs (ala quake), but trace them again through the target for 
			// better crowd control feels (ala doom).
			// this is only noticeable with big hordes of weak guys, but it makes big hordes of
			// weak guys not feel like solid ammo-sponge walls.
			if (trace_ent.takedamage && 
				(trace_ent.flags & FL_MONSTER || trace_ent.classname == "player" ) && 
				// some id shootables are actually trigger_multiples with health and SOLID_BBOX, so this doesn't work (see e1m6):
				//( trace_ent.solid == SOLID_BBOX || trace_ent.solid == SOLID_SLIDEBOX ) &&	
				HasBeenShotToDeath(trace_ent) )
			{
				BulletImpact (2+2*random(), direction);

				// start 0.1 unit forward, or else when shooting an adjacent enemy we'll
				// just hit ourselves again
				src = trace_endpos + direction * 0.1;
				ig = trace_ent;
				if (trace_debug) dprint3("bullet hit ", ig.classname, ", continuing thru\n");
			}
			else
			{
				if (trace_debug) dprint("bullet reached world\n");
				ig = world;
			}
			if (lim > 8)
			{
				dprint("bullet pen limit exceeded\n");
				break;
			}
		}
		
		if (trace_fraction != 1.0)
		{
			BulletImpact (damage, direction);
		}
		
		if (trace_debug) dprint("bullet is over\n\n");
	}
}
*/