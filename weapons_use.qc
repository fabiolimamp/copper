
// called by worldspawn
void() W_Precache =
{
	precache_sound ("weapons/r_exp3.wav");
	precache_sound ("weapons/rocket1i.wav");	// nailgun
	precache_sound ("weapons/sgun1.wav");
	precache_sound ("weapons/guncock.wav");		// sg
	precache_sound ("weapons/ric1.wav");		// ricochet (used in c code)
	precache_sound ("weapons/ric2.wav");		// ricochet (used in c code)
	precache_sound ("weapons/ric3.wav");		// ricochet (used in c code)
	precache_sound ("weapons/spike2.wav");		// super spikes
	precache_sound ("weapons/tink1.wav");		// spikes tink (used in c code)
	precache_sound ("weapons/grenade.wav");		// grenade launcher
	precache_sound ("weapons/bounce.wav");		// grenade bounce
	precache_sound ("weapons/shotgn2.wav");		// ssg
	precache_model2 ("progs/k_spike.mdl");
	precache_model ("progs/lavaball.mdl");	
	precache_sound ("weapons/lhit.wav");		//lightning
	precache_sound ("weapons/lstart.wav");		//lightning start
	precache_sound ("weapons/spindn_click.wav");
//	precache_sound ("items/damage3.wav");

// ax sounds	
	precache_sound ("weapons/ax1.wav");		// ax swoosh
	precache_sound2 ("weapons/axhit1.wav");		// ax hit meat
	precache_sound2 ("weapons/axhit2.wav");		// ax hit meat 2
	precache_sound ("player/axhit1.wav");		// ax hit me
	precache_sound ("player/axhit2.wav");		// ax hit world
	
	precache_sound ("zombie/z_hit.wav");
	
	//=============================================================================================
	precache_sound ("axhit3.wav");
	precache_sound ("axhit4.wav");
	precache_sound ("swordhit1.wav");
	precache_sound ("swordhit2.wav");
	precache_sound ("swordhit3.wav");
	precache_sound ("pistol_shoot.wav");
	precache_sound ("shotgn3.wav");
	
	precache_sound ("bullet_impact1.wav");
	precache_sound ("bullet_impact2.wav");
	precache_sound ("bullet_impact3.wav");
	precache_sound ("bullet_impact4.wav");
	precache_sound ("bullet_impact5.wav");
	precache_sound ("bullet_impact6.wav");
	precache_sound ("bullet_impact7.wav");
	precache_sound ("bullet_impact8.wav");
	precache_sound ("bullet_impact9.wav");
	precache_sound ("bullet_impact10.wav");
	precache_sound ("bullet_impact11.wav");
	precache_sound ("bullet_impact12.wav");
	/*
	precache_sound ("bullet_woosh1.wav");
	precache_sound ("bullet_woosh2.wav");
	precache_sound ("bullet_woosh3.wav");
	precache_sound ("bullet_woosh4.wav");
	precache_sound ("bullet_woosh5.wav");
	precache_sound ("bullet_woosh6.wav");
	precache_sound ("bullet_woosh7.wav");
	precache_sound ("bullet_woosh8.wav");
	precache_sound ("bullet_woosh9.wav");
	precache_sound ("bullet_woosh10.wav");
	precache_sound ("bullet_woosh11.wav");
	precache_sound ("bullet_woosh12.wav");
	*/
	precache_sound ("ammo_rattle.wav");
	precache_sound ("gun_click.wav");
	
	precache_sound ("volley_fire1.wav");
	precache_sound ("volley_fire2.wav");
	precache_sound ("volley_fire3.wav");
	precache_sound ("shotgun3.wav");
	
	precache_model ("progs/pellet.mdl");
	precache_model ("progs/nail.mdl");
	precache_model ("progs/tracer_long_yellow.mdl");
	precache_model ("progs/mini_grenade.mdl");
	
	precache_model ("progs/rebar.mdl");
	precache_sound ("penfire.wav");
	precache_sound ("pierce1.wav");
	precache_sound ("pierce2.wav");
	precache_sound ("pierce3.wav");
	precache_sound ("stick1.wav");
	
	precache_sound ("pistol_reload.wav");
	precache_sound ("deadlock_reload.wav");
	precache_sound ("grenade_reload.wav");
	precache_sound ("pump_reload.wav");
	precache_sound ("mag_drop.wav");
	//precache_sound ("shell_load.wav");     // NO...
		
	precache_model ("progs/pistol_mag.mdl");
	precache_model ("progs/bullet_casing.mdl");
	
	precache_model ("progs/flame1_thrower.mdl");
	precache_model ("progs/flame1_ground.mdl");
	precache_model ("progs/flame1_ignite.mdl");
	precache_sound ("flamer.wav");
	precache_sound ("flamer_loop.wav");
	//=============================================================================================

	precache_model ("progs/v_axe2.mdl");
	precache_model ("progs/v_shot.mdl");
	precache_model ("progs/v_nail.mdl");
	precache_model ("progs/v_rock.mdl");
	precache_model ("progs/v_shot2.mdl");
	precache_model ("progs/v_nail2.mdl");
	precache_model ("progs/v_rock2.mdl");
	precache_model ("progs/v_light.mdl");
	

	for (float i = 0; i < 9; i++) {
		if (weaponsclass[i].model != "") precache_model(weaponsclass[i].model);
	}

}



typedef struct {
	float id;
	float slot;
	float slotPos;
	string name;
	string model;
	float ammofield;
	float ammo_item;
	float ammo_usage;
	float() animfunction;
	void() idlefunction;
} weaponclass_t;

.float ammofieldlist[5] = {
	currentammo,
	ammo_shells,
	ammo_nails, 
	ammo_rockets,
	ammo_cells
};


weaponclass_t wpc_no_weapon = {
	IT_NO_WEAPON,
	0, // slot
	0, // slotPos
	"No weapon", // name
	"", // model
	0, // ammofield
	0, // ammo_item
	0, // ammo_usage
	SUB_Null, // animfunction
	SUB_Null // idlefunction
};

weaponclass_t wpc_axe = {
	IT_AXE,
	1, // slot
	0, // slotPos
	"Wrench", // name
	"progs/v_axe2.mdl", // model
	0, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_wrench, // animfunction
	SUB_Null // idlefunction
};


weaponclass_t wpc_shotgun = {
	IT_SHOTGUN,
	2, // slot
	0, // slotPos
	"Pistol", // name
	"progs/v_shot.mdl", // model
	0, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_pistol, // animfunction
	SUB_Null // idlefunction
};

weaponclass_t wpc_supershotgun = {
	IT_SUPER_SHOTGUN,
	3, // slot
	0, // slotPos
	"Flak Shotgun", // name
	"progs/v_shot2.mdl", // model
	1, // ammofield
	IT_SHELLS, // ammo_item
	1, // ammo_usage
	weaponanim_flakshotgun, // animfunction
	SUB_Null // idlefunction
};

weaponclass_t wpc_nailgun = {
	IT_NAILGUN,
	4, // slot
	0, // slotPos
	"Nailgun", // name
	"progs/v_nail.mdl", // model
	2, // ammofield
	IT_NAILS, // ammo_item
	1, // ammo_usage
	weaponanim_twinnailgun, // animfunction
	SUB_Null // idlefunction
};

weaponclass_t wpc_supernailgun = {
	IT_SUPER_NAILGUN,
	5, // slot
	0, // slotPos
	"Rebar Cannon", // name
	"progs/v_nail2.mdl", // model
	2, // ammofield
	IT_NAILS, // ammo_item
	1, // ammo_usage
	weaponanim_rebarcannon, // animfunction
	SUB_Null // idlefunction
};

weaponclass_t wpc_grenade = {
	IT_GRENADE_LAUNCHER,
	6, // slot
	0, // slotPos
	"Grenade Launcher", // name
	"progs/v_rock.mdl", // model
	3, // ammofield
	IT_ROCKETS, // ammo_item
	1, // ammo_usage
	weaponanim_qbj3grenade, // animfunction	//weaponanim_clustergrenade	//weaponanim_volleygrenade
	SUB_Null // idlefunction
};

weaponclass_t wpc_rocket = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	0, // slotPos
	"Multi-Missile Launcher", // name
	"progs/v_rock2.mdl", // model
	3, // ammofield
	IT_ROCKETS, // ammo_item
	1, // ammo_usage
	weaponanim_boxrocket, // animfunction	//weaponanim_twinrocket,
	SUB_Null // idlefunction
};

weaponclass_t wpc_lg = {
	IT_LIGHTNING,
	8, // slot
	0, // slotPos
	"Flamethrower", // name
	"progs/v_light.mdl", // model
	4, // ammofield
	IT_CELLS, // ammo_item
	1, // ammo_usage
	weaponanim_flamethrower, // animfunction
	SUB_Null // idlefunction
};


weaponclass_t weaponsclass[9] = {
	wpc_no_weapon,
	wpc_axe,
	wpc_shotgun,
	wpc_supershotgun,
	wpc_nailgun,
	wpc_supernailgun,
	wpc_grenade,
	wpc_rocket,
	wpc_lg
};

float MAX_WEAPON_NUM = 8;

float(float weap) getWeapon = {
	switch (weap) {
		case IT_AXE:			return 1;
		case IT_SHOTGUN:		return 2;
		case IT_SUPER_SHOTGUN:		return 3;
		case IT_NAILGUN:		return 4;
		case IT_SUPER_NAILGUN:		return 5;
		case IT_GRENADE_LAUNCHER:	return 6;
		case IT_ROCKET_LAUNCHER:	return 7;
		case IT_LIGHTNING:		return 8;

		default:			return 0;
	}
}


typedef struct {
	weaponclass_t weaps[4];
	float qt;
} weaponslot_t;

weaponslot_t weaponslots[9] = {
	{{wpc_no_weapon}, 1}, 	//0
	{{wpc_axe}, 1}, 	//1
	{{wpc_shotgun}, 1}, 	//2
	{{wpc_supershotgun}, 1},//3
	{{wpc_nailgun}, 1}, 	//4
	{{wpc_supernailgun}, 1},//5
	{{wpc_grenade}, 1}, 	//6
	{{wpc_rocket}, 1}, 	//7
	{{wpc_lg}, 1} 		//8
};


enum {
	WEAPONSTAT_NOWEAPON,
	WEAPONSTAT_NOAMMO,
	WEAPONSTAT_AVAILABLE
};


/*
 * wrap
 *
 * Limits the given value to the given range and will wrap the value to the
 * the other end of the range if exceeded.
 *
 * value: A number
 *
 * minValue: The minimum value of the range
 *
 * maxValue: The maximum value of the range
 *
 * Returns: A number within the given range.
 */
float(float value, float minValue, float maxValue) wrap = {
	local float range = maxValue - minValue;

	return mod(value - minValue, range + 1) + minValue;
};

/*
============
W_WeaponFrame

Called every frame so impulse events can be handled as well as possible
============
*/
void() W_WeaponFrame = {
	if (self.button0) {
		if (self.attackpressed) self.attackhold = 1;
		else self.attackhold = 0;

		self.attackpressed = 1;

		W_Attack();
	}
	else {
		self.attackpressed = 0;
		self.attackhold = 0;
	}
}


// syncs up current ammo with its correspondent ammo_* field
void() W_UpdateCurrentAmmo = {
	weaponclass_t weap = weaponsclass[getWeapon(self.weapon)];
	self.currentammo = self.(ammofieldlist[weap.ammofield]);
}

float(float weapons, entity cl, float waterlevel) W_BestWeaponParms =
{
	if (W_CheckWeapon(IT_LIGHTNING, cl) == WEAPONSTAT_AVAILABLE && waterlevel <= 1)
		return IT_LIGHTNING;
	if (W_CheckWeapon(IT_SUPER_NAILGUN, cl) == WEAPONSTAT_AVAILABLE)
		return IT_SUPER_NAILGUN;
	if (W_CheckWeapon(IT_SUPER_SHOTGUN, cl) == WEAPONSTAT_AVAILABLE)
		return IT_SUPER_SHOTGUN;
	if (W_CheckWeapon(IT_NAILGUN, cl) == WEAPONSTAT_AVAILABLE)
		return IT_NAILGUN;
	if (W_CheckWeapon(IT_SHOTGUN, cl) == WEAPONSTAT_AVAILABLE)
		return IT_SHOTGUN;
	if (W_CheckWeapon(IT_AXE, cl) == WEAPONSTAT_AVAILABLE)
		return IT_AXE;

	return IT_NO_WEAPON; 
};

float(float w) W_RankForWeapon =
{
	if (!w)
		return 666;
	if (w == IT_LIGHTNING)
		return 1;
	if (w == IT_ROCKET_LAUNCHER)
		return 2;
	if (w == IT_SUPER_NAILGUN)
		return 3;
	if (w == IT_GRENADE_LAUNCHER)
		return 4;
	if (w == IT_SUPER_SHOTGUN)
		return 5;
	if (w == IT_NAILGUN)
		return 6;
	return 7;
}

float() W_BestWeapon = {
	return W_BestWeaponParms(self.items, self, self.waterlevel);
};

float(float weap, entity cl) W_CheckWeapon = {
	weaponclass_t weapcl = weaponsclass[getWeapon(weap)];

	if (weap == IT_NO_WEAPON) return WEAPONSTAT_AVAILABLE;

	if (!(cl.items & weap)) return WEAPONSTAT_NOWEAPON;

	if (cl.(ammofieldlist[weapcl.ammofield]) < weapcl.ammo_usage) {
		return WEAPONSTAT_NOAMMO;
	}
	//dprint3("Ammo: ", ftos(cl.(weapcl.ammofield)), "\n");
	return WEAPONSTAT_AVAILABLE;
};

/*
=============
W_BetterWeapon

Deathmatch weapon change rules for picking up a weapon
=============
*/
void(entity e, float new) W_BetterWeapon =
{
	entity oself = self;
	if (!deathmatch)
	{
		// don't switch to explosive weapons with quad
		// 1.12: don't switch to explosives when invisible either, since you can't see the stupid viewmodel
		if ( (has_quad(e) || has_invis(e)) &&
			(new == IT_ROCKET_LAUNCHER || new == IT_GRENADE_LAUNCHER))
			return;
		// don't switch to a lightning gun when standing in water
		if (e.waterlevel >= 2 && new == IT_LIGHTNING)
			return;
	}	
	self = e;
	if (!deathmatch || W_RankForWeapon (new) < W_RankForWeapon (self.weapon) )
		W_ChangeWeapon(new);
	self = oself;
}

void() W_SelectBestWeapon =
{
	W_ChangeWeapon(W_BestWeaponParms(self.items, self, self.waterlevel));
}

void() W_ResetWeaponState = 
{
	W_ChangeWeapon(self.weapon);
}

void() W_SelectLastWeapon =
{
	if (self.attack_state)
		W_ChangeWeapon(self.attack_state);
}

void() W_SelectBestShotgun =
{
	if (self.items & (IT_SHOTGUN|IT_SUPER_SHOTGUN))
	{
		if (W_ChangeWeapon(IT_SHOTGUN) != WEAPONSTAT_NOAMMO && W_ChangeWeapon(IT_SUPER_SHOTGUN) != WEAPONSTAT_NOAMMO)
			sprint (self, "not enough ammo.\n");
	}
	else
	{
		sprint(self, "no weapon.\n");
	}
}

void() W_SelectBestNailgun =
{
	if (self.items & (IT_NAILGUN|IT_SUPER_NAILGUN))
	{
		if (W_ChangeWeapon(IT_NAILGUN) != WEAPONSTAT_NOAMMO && W_ChangeWeapon(IT_SUPER_NAILGUN) != WEAPONSTAT_NOAMMO)
			sprint (self, "not enough ammo.\n");
	}
	else
	{
		sprint(self, "no weapon.\n");
	}
}


void() W_Attack = {
	
	weaponclass_t weap = weaponsclass[getWeapon(self.weapon)];

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE) {
		return;
	}

	makevectors(self.v_angle);			// calculate forward angle for velocity
	
	float fired = weap.animfunction();

	if (fired) self.show_hostile = time + 1;	// wake monsters up
};



float(float weap) W_ChangeWeapon = {

	if (self.animcontroller.owner != self)
		return 0;

	float weapstat = W_CheckWeapon(weap, self);
	if (weapstat < WEAPONSTAT_AVAILABLE){
		return weapstat;
	}

	// don't reset anything if trying to change to the same weapon
	if (self.weapon == weap){
		return weapstat;
	}

	if (time > self.pistol_lastreload_time + 3.75 && self.pistol_ammo_count >= 10) // reset pistol reload
		self.pistol_ammo_count = 0;

	weaponclass_t weapcl = weaponsclass[getWeapon(weap)];

	self.attack_state = self.weapon;
	self.weapon = weap;
	self.currentammo = self.(ammofieldlist[weapcl.ammofield]);
	self.items &~= (IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS);
	self.items |= weapcl.ammo_item;

	if (weapcl.ammo_usage > 0) {
		self.currentammo = self.(ammofieldlist[weapcl.ammofield]);
	}
	else {
		self.currentammo = 0;
	}

	self.weaponmodel = weapcl.model;
	self.weaponframe = 0;

	self.attackpressed = 0;
	self.attackhold = 0;

	self.animcontroller.think = player_run;
	self.think = SUB_Null;

	if (weapcl.idlefunction != SUB_Null) weapcl.idlefunction();
	return weapstat;
}


float(float imp) W_ChangeSlot = {
	weaponslot_t newSlot = weaponslots[imp];

	weaponclass_t currentWeapon = weaponsclass[getWeapon(self.weapon)];

	float startSlotPos;

	if (currentWeapon.slot == imp)
		startSlotPos = wrap(currentWeapon.slotPos + 1, 0, newSlot.qt - 1);
	else
		startSlotPos = 0;

	float i;
	
	float weaponstat;

	while (i < newSlot.qt) {
		weaponstat = W_CheckWeapon(newSlot.weaps[startSlotPos].id, self);
		if (weaponstat == WEAPONSTAT_AVAILABLE){
			W_ChangeWeapon(newSlot.weaps[startSlotPos].id);
			return weaponstat;
		}
		startSlotPos = wrap(startSlotPos + 1, 0, newSlot.qt - 1);
		i++;
	}

	return weaponstat;
}


void(float stp) W_CycleWeapon = {

	float currentWeapon = getWeapon(self.weapon);

	float next = wrap(currentWeapon + stp, 1, MAX_WEAPON_NUM);
	float i;
	while (next != currentWeapon && i <= MAX_WEAPON_NUM) {
		//dprint3("Testing slot ", ftos(next), "...\n");
		if (W_CheckWeapon(weaponsclass[next].id, self) == WEAPONSTAT_AVAILABLE) {
		//	dprint3("Found! slot ", ftos(next), "\n");
			W_ChangeWeapon(weaponsclass[next].id);
			return;
		}

		next = wrap(next + stp, 1, MAX_WEAPON_NUM);
		i++;
	}

	if (i > MAX_WEAPON_NUM) W_ChangeWeapon(IT_NO_WEAPON);
}

/*
========
SuperDamageSound

Plays sound if needed
========
*/
void() SuperDamageSound =
{
	if (!has_quad(self)) return;
	if (self.super_damage_finished < time + 3) return;
	if (self.super_sound < time)
	{
		self.super_sound = time + 0.9;
		sound (self, CHAN_POWERUP, "items/damage3.wav", 1, ATTN_NORM);
	}
}


