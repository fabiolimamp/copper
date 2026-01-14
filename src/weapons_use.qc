
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
	//	precache_sound ("items/damage3.wav");

// ax sounds	
	precache_sound ("weapons/ax1.wav");		// ax swoosh
	precache_sound2 ("weapons/axhit1.wav");		// ax hit meat
	precache_sound2 ("weapons/axhit2.wav");		// ax hit meat 2
	precache_sound ("player/axhit1.wav");		// ax hit me
	precache_sound ("player/axhit2.wav");		// ax hit world
	
	precache_sound ("zombie/z_hit.wav");
	
	//=============================================================================================
	
	precache_model ("progs/v_wrench.mdl");						// 1 Melee
	precache_model ("progs/v_berserk.mdl");
	precache_sound ("impact/fist_hit.wav");
	precache_sound ("impact/fist_impact1.wav");
	precache_sound ("impact/fist_impact2.wav");
	precache_sound ("impact/fist_impact3.wav");
	precache_sound ("impact/fist_impact4.wav");
	precache_sound ("impact/wrench_impact1.wav");
	precache_sound ("impact/wrench_impact2.wav");
	precache_sound ("impact/wrench_impact3.wav");
	precache_sound ("impact/wrench_impact4.wav");
	precache_sound ("impact/wrench_swing.wav");
	precache_sound ("impact/wrench_clink.wav");
	//precache_sound ("impact/wrench_clank1.wav");
	//precache_sound ("impact/wrench_clank2.wav");
	precache_sound ("impact/hit_player1.wav");
	precache_sound ("impact/hit_player2.wav");
	precache_sound ("impact/hit_player3.wav");
	precache_sound ("impact/hit_player4.wav");
		
	//=============================================================================================
											// 2 Pistol
	precache_model ("progs/bullet_casing.mdl");
	precache_model ("progs/pistol_mag.mdl");
	precache_model ("progs/tracer_long_yellow.mdl");
	precache_sound ("pistol/deadlock_reload.wav");
	precache_sound ("pistol/pistol_shoot.wav");
	precache_sound ("pistol/ammo_rattle.wav");
	precache_sound ("pistol/gun_click.wav");
	precache_sound ("pistol/mag_drop.wav");
	precache_sound ("pistol/pistol_fire.wav");
	precache_sound ("pistol/pistol_fire1.wav");
	precache_sound ("pistol/pistol_fire2.wav");
	precache_sound ("pistol/pistol_fire3.wav");
	precache_sound ("pistol/pistol_fire4.wav");
	precache_sound ("pistol/casing.wav");
	
	//=============================================================================================
											// 3 Shotgun
	precache_model ("progs/buckshot_casing.mdl");
	precache_model ("progs/proj_pellet.mdl");
	precache_sound ("flak/volley_fire1.wav");
	precache_sound ("flak/volley_fire2.wav");
	precache_sound ("flak/volley_fire3.wav");
	precache_sound ("flak/shotgun2.wav");
	precache_sound ("flak/shotgun3.wav");
	precache_sound ("flak/pump_reload.wav");
	precache_sound ("flak/pump_reload.wav");
	precache_sound ("flak/shell_casing1.wav");
	precache_sound ("flak/shell_casing2.wav");
	precache_sound ("flak/shell_casing3.wav");
	precache_sound ("flak/shotgun_fire1.wav");
	precache_sound ("flak/shotgun_fire2.wav");
	precache_sound ("flak/shotgun_fire3.wav");
	precache_sound ("flak/shotgun_fire4.wav");

	//=============================================================================================
											// 4 Nailguns
	precache_model ("progs/proj_nail.mdl");
	precache_sound ("nail/nailgun1.wav");
	precache_sound ("nail/nailgun2.wav");
	precache_sound ("nail/nailgun3.wav");
	precache_sound ("nail/nailgun4.wav");
	precache_sound ("nail/nailgun5.wav");
	precache_sound ("nail/airpuff.wav");
	precache_sound ("nail/nail_tink1.wav");
	precache_sound ("nail/nail_tink2.wav");
	precache_sound ("nail/nail_tink3.wav");
	
	//=============================================================================================
											// 5 RebarBow
	precache_model ("progs/proj_rebar.mdl");
	precache_model ("progs/proj_rebar_nosmoke.mdl");
	precache_sound ("rebar/penfire.wav");
	precache_sound ("rebar/pierce1.wav");
	precache_sound ("rebar/pierce2.wav");
	precache_sound ("rebar/pierce3.wav");
	precache_sound ("rebar/pierce_impact.wav");
	precache_sound ("rebar/stick1.wav");
	precache_sound ("rebar/stick_metal1.wav");
	precache_sound ("rebar/stick_metal2.wav");
	precache_sound ("rebar/bow_reload1.wav");
	precache_sound ("rebar/bow_reload2.wav");
	precache_sound ("rebar/bow_reload3.wav");
	precache_sound ("rebar/bow_reload4.wav");
	precache_sound ("rebar/bow_clank.wav");
	
	//=============================================================================================
											// 6 GrenadeL
	precache_sound ("grenade/grenade_reload.wav");
	precache_sound ("grenade/grenade_fire1.wav");
	precache_sound ("grenade/grenade_fire2.wav");
	precache_sound ("grenade/grenade_fire3.wav");
	
	//=============================================================================================
											// 7 MissileL	
	precache_model ("progs/proj_missile.mdl");	
	precache_sound ("mmml/fire1.wav");
	precache_sound ("mmml/fire2.wav");
	precache_sound ("mmml/fire3.wav");
	precache_sound ("mmml/fire4.wav");
	precache_sound ("mmml/silo_latch.wav");
	precache_sound ("mmml/silo_load.wav");
	precache_sound ("mmml/silo_load2.wav");
	precache_sound ("mmml/silo_clunk.wav");
	precache_sound ("mmml/silo_clunk2.wav");

	//=============================================================================================
											// 8 Invoker	
	precache_model ("progs/v_invoker.mdl");
	precache_model ("progs/proj_chain.mdl");
	precache_sound ("invoker/invoker_firerail.wav");	
	precache_sound ("invoker/magic07.wav");	
	precache_sound ("invoker/magic08.wav");	
	precache_sound ("invoker/magic21.wav");	
	precache_sound ("invoker/magic26.wav");
	precache_sound ("invoker/energy_charge.wav");
	precache_sound ("invoker/energy_hit1.wav");
	precache_sound ("invoker/energy_hit2.wav");
	precache_sound ("invoker/energy_hit3.wav");
	precache_sound ("invoker/energy_hit4.wav");
	
	//=============================================================================================
											// FX Effects	
	precache_sound ("impact/bullet_impact1.wav");
	precache_sound ("impact/bullet_impact2.wav");
	precache_sound ("impact/bullet_impact3.wav");
	precache_sound ("impact/bullet_impact4.wav");
	precache_sound ("impact/bullet_metal1.wav");
	precache_sound ("impact/bullet_metal2.wav");
	precache_sound ("impact/bullet_metal3.wav");
	precache_sound ("impact/bullet_metal4.wav");
	precache_sound ("impact/ric1.wav");
	precache_sound ("impact/ric2.wav");
	precache_sound ("impact/ric3.wav");
	precache_sound ("impact/ric4.wav");
	precache_sound ("impact/ric5.wav");
	
	precache_model ("progs/fx/spark1.mdl");
	precache_model ("progs/fx/spark2.mdl");
	precache_model ("progs/fx/spark3.mdl");
	precache_model ("progs/fx/spark4.mdl");
	precache_model ("progs/fx/spark_laser1.mdl");
	precache_model ("progs/fx/spark_laser2.mdl");
	precache_model ("progs/fx/spark_laser3.mdl");
	precache_model ("progs/fx/spark_laser4.mdl");
	precache_model ("progs/fx/blood1.mdl");
	precache_model ("progs/fx/blood2.mdl");
	precache_model ("progs/fx/blood3.mdl");
	precache_model ("progs/fx/blood4.mdl");
	precache_model ("progs/fx/blood_big1.mdl");
	precache_model ("progs/fx/blood_big2.mdl");
	precache_model ("progs/fx/blood_big3.mdl");
	precache_model ("progs/fx/blood_big4.mdl");
	
	precache_model ("progs/fx/invoked_chain.mdl");
	
	precache_model ("progs/s_blood_128x.spr");
	precache_model ("progs/s_blood_96x.spr");
	precache_model ("progs/s_blood_64x.spr");
								
	//=============================================================================================
											// Misc
	precache_sound ("misc/draw1.wav");
	
	//=============================================================================================	
											//PLACEHOLDER
	precache_sound ("placeholder_sound/shotgun1.wav");
	precache_sound ("placeholder_sound/shotgun2.wav");
	precache_sound ("placeholder_sound/shell_reload.wav");
	precache_sound ("placeholder_sound/shell_reload.wav");
	precache_sound ("placeholder_sound/shotgn3.wav");
	
	precache_model ("progs/placeholder_progs/proj_pellet_blue.mdl");
	precache_model ("progs/placeholder_progs/proj_stake.mdl");
	precache_model ("progs/placeholder_progs/proj_stake_smoke.mdl");
	
	precache_model ("progs/placeholder_progs/v_shotgun_super2.mdl");
	precache_model ("progs/placeholder_progs/v_shotgun_super3.mdl");
	precache_model ("progs/placeholder_progs/v_shotgun_super4.mdl");
	precache_model ("progs/placeholder_progs/v_shotgun_lever.mdl");
	precache_model ("progs/placeholder_progs/v_shotgun_stack.mdl");
	precache_model ("progs/placeholder_progs/v_shotgun_brazil.mdl");
	precache_model ("progs/placeholder_progs/v_shotgun_rotary.mdl");	
	precache_model ("progs/placeholder_progs/v_shotgun_auto.mdl");	
	precache_model ("progs/placeholder_progs/v_shotgun_sweeper.mdl");	
	precache_model ("progs/placeholder_progs/v_shotgun_blue2.mdl");	
	precache_model ("progs/placeholder_progs/v_shotgun_bigblue.mdl");	
	
	precache_model ("progs/placeholder_progs/v_rebar_multi.mdl");	
	precache_model ("progs/placeholder_progs/v_rebar_wide.mdl");	
	precache_model ("progs/placeholder_progs/v_rebar_tall.mdl");	
	precache_model ("progs/placeholder_progs/v_rebar_fast.mdl");		
	precache_model ("progs/placeholder_progs/v_rebar_buff.mdl");
			
	precache_model ("progs/placeholder_progs/v_nail_heavy.mdl");		
	precache_model ("progs/placeholder_progs/v_nail_turbo.mdl");		
	
	//=============================================================================================	



	for (float i = 0; i <= MAX_WEAPON_NUM; i++) {
		if (weaponsclass[i].model != "") precache_model(weaponsclass[i].model);
	}

}

.float ammofieldlist[6] = {
	currentammo,
	ammo_shells,
	ammo_nails, 
	ammo_rockets,
	ammo_cells,
	pistol_ammo_count
};

typedef struct {
	float id;
	float slot;
	string name;
	string model;
	float ammofield;
	float ammo_item;
	float ammo_usage;
	float() animfunction;
	void() idlefunction;
	void() drawfunction;
} weaponclass_t;

typedef struct {
	weaponclass_t weaps[10];
	float qt;
} weaponslot_t;

float() weaponanim_null = {return FALSE;}



//=====================================================================================================================

// generic weapon draw functions used by most weapons

void() weaponanim_draw =
{		
	sound (self, CHAN_AUTO, "misc/draw1.wav", 0.1, ATTN_NORM);
	
	self.weaponframe = 1;
	
	self.think = weaponanim_draw_loop;
	self.nextthink = time + 0.033;
}

void() weaponanim_draw_loop =
{
	if (self.weaponframe >= 10)
		return;
	else 
		self.weaponframe++;

	self.think = weaponanim_draw_loop;
	self.nextthink = time + 0.033;
}

float(float weap) getWeapon = {
	switch (weap) {
		case IT_AXE:				return 1;
		case IT_SHOTGUN:			return 2;
		case IT_SUPER_SHOTGUN:		return 3; //these numbers have to match the dumb sequence
		case IT_NAILGUN:			return 13;// any way to make this dynamic? -fw
		case IT_SUPER_NAILGUN:		return 14;
		case IT_GRENADE_LAUNCHER:	return 21;
		case IT_ROCKET_LAUNCHER:	return 22;
		case IT_LIGHTNING:			return 23;
		default:					return 0;
	}
}


enum {
	WEAPONSTAT_NOWEAPON,
	WEAPONSTAT_NOAMMO,
	WEAPONSTAT_CHANGELOCKED,
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
void() W_WeaponFrame =
{
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
void() W_UpdateCurrentAmmo =
{
	float weapIndex;
	if (self.active_weapon_index > 0 && self.active_weapon_index <= MAX_WEAPON_NUM)
		weapIndex = self.active_weapon_index;
	else
		weapIndex = getWeapon(self.weapon);
		
	weaponclass_t weap = weaponsclass[weapIndex];
	self.currentammo = self.(ammofieldlist[weap.ammofield]);
}

float(float weapons, entity cl, float waterlevel) W_BestWeaponParms =
{
	//if (W_CheckWeapon(IT_LIGHTNING, cl) 	== WEAPONSTAT_AVAILABLE)	return IT_LIGHTNING;
	if (W_CheckWeapon(IT_SUPER_NAILGUN, cl) == WEAPONSTAT_AVAILABLE)	return IT_SUPER_NAILGUN;
	if (W_CheckWeapon(IT_SUPER_SHOTGUN, cl) == WEAPONSTAT_AVAILABLE)	return IT_SUPER_SHOTGUN;
	if (W_CheckWeapon(IT_NAILGUN, cl) 	== WEAPONSTAT_AVAILABLE)	return IT_NAILGUN;
	if (W_CheckWeapon(IT_SHOTGUN, cl) 	== WEAPONSTAT_AVAILABLE)	return IT_SHOTGUN;
	if (W_CheckWeapon(IT_AXE, cl)		== WEAPONSTAT_AVAILABLE)	return IT_AXE;

	return IT_NO_WEAPON; 
};

float(float w) W_RankForWeapon =
{
	if (!w)				return 666;
	if (w == IT_LIGHTNING)		return 1;
	if (w == IT_ROCKET_LAUNCHER)	return 2;
	if (w == IT_SUPER_NAILGUN)	return 3;
	if (w == IT_GRENADE_LAUNCHER)	return 4;
	if (w == IT_SUPER_SHOTGUN)	return 5;
	if (w == IT_NAILGUN)		return 6;
	return 7;
}

float() W_BestWeapon =
{
	return W_BestWeaponParms(self.items, self, self.waterlevel);
};

float(float weap, entity cl) W_CheckWeapon =
{
	float weapIndex;
	
	if (weap == cl.weapon && cl.active_weapon_index > 0 && cl.active_weapon_index <= MAX_WEAPON_NUM)
		weapIndex = cl.active_weapon_index;
	else
		weapIndex = getWeapon(weap);
	
	weaponclass_t weapcl = weaponsclass[weapIndex];

	//if (has_gorgon(cl) && weap == IT_AXE) return WEAPONSTAT_AVAILABLE;
	if (has_berserk(cl) && weap == IT_AXE) return WEAPONSTAT_AVAILABLE;
	
	if (weap == IT_NO_WEAPON) return WEAPONSTAT_AVAILABLE;

	if (!(cl.items & weap)) return WEAPONSTAT_NOWEAPON;

	if (cl.(ammofieldlist[weapcl.ammofield]) < weapcl.ammo_usage) {
		return WEAPONSTAT_NOAMMO;
	}
	//dprint3("Ammo: ", ftos(cl.(weapcl.ammofield)), "\n");
	return WEAPONSTAT_AVAILABLE;
};

void() W_ResetWeaponState = 
{
	W_ChangeWeapon(self.weapon, FALSE);
}

void() W_Attack =
{
	float weapIndex;
	if (self.active_weapon_index > 0 && self.active_weapon_index <= MAX_WEAPON_NUM)
		weapIndex = self.active_weapon_index;
	else
		weapIndex = getWeapon(self.weapon);
	
	weaponclass_t weap = weaponsclass[weapIndex];

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE) {
		return;
	}

	makevectors(self.v_angle);			// calculate forward angle for velocity
	
	float fired = weap.animfunction();

	if (fired) self.show_hostile = time + 1;	// wake monsters up
};



float(float weap, float forcereset = FALSE) W_ChangeWeapon =
{
	if (self.animcontroller.owner != self) return WEAPONSTAT_CHANGELOCKED;

	if (self.customflags & CFL_WEAPONLOCK) return WEAPONSTAT_CHANGELOCKED;

	// Force reset if player is being unplunged from a void
	if (self.customflags & CFL_PLUNGE) {
		forcereset = TRUE;
	}

	float weapstat = W_CheckWeapon(weap, self);
	if (weapstat < WEAPONSTAT_AVAILABLE){
		return weapstat;
	}

	// don't reset anything if trying to change to the same weapon
	if (self.weapon == weap && !forcereset){
		return weapstat;
	}

	float weapIndex = getWeapon(weap);

	if (self.active_weapon_index != weapIndex && self.active_weapon_index > 0) {
		forcereset = TRUE;
	}

	if (time > self.pistol_lastreload_time + 3.75 && self.pistol_ammo_count <= 0)	
		self.pistol_ammo_count = 10;	// reset pistol reload

	self.weaponreload_perc = 0;
	weaponclass_t weapcl = weaponsclass[weapIndex];

	self.prev_weapon = self.weapon;
	self.weapon = weap;
	self.active_weapon_index = weapIndex;
	self.currentammo = self.(ammofieldlist[weapcl.ammofield]);
	self.items &~= (IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS);
	self.items |= weapcl.ammo_item;

	if (weapcl.ammofield)
		self.currentammo = self.(ammofieldlist[weapcl.ammofield]);
		
	else 	self.currentammo = 0;
	
	if (has_berserk(self) && weap == IT_AXE)
		weapcl.model = "progs/v_berserk.mdl";
	
	self.weaponmodel = weapcl.model;
	
	self.weaponframe = 0;

	self.attackpressed = 0;
	self.attackhold = 0;

	self.animcontroller.think = player_run;
	self.think = SUB_Null;

	
	// @ bmFbr it working!!!  -Kebby_
			
	
	weapcl.idlefunction();
	// whatever drawfunction does will probably override an idlefunction's actions if there's one.
	// in this case the end of the draw loop must call idlefunction
	weapcl.drawfunction(); 
	
			
	return weapstat;
}


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
		//if (e.waterlevel >= 2 && new == IT_LIGHTNING)
			//return;
	}	
	self = e;
	if (!deathmatch || W_RankForWeapon (new) < W_RankForWeapon (self.weapon) )
		W_ChangeWeapon(new, FALSE);
	self = oself;
}

/*
===================================================================================================

WEAPON SELECTION IMPULSES

===================================================================================================
*/


float() W_SelectBestWeapon =
{
	return W_ChangeWeapon(W_BestWeaponParms(self.items, self, self.waterlevel), FALSE);
}

float() W_SelectLastWeapon =
{
	if (self.prev_weapon)
		return W_ChangeWeapon(self.prev_weapon, FALSE);
	else
		return WEAPONSTAT_AVAILABLE; // do nothing
}

float() W_SelectBestShotgun =
{
	if (self.items & (IT_SHOTGUN|IT_SUPER_SHOTGUN))
	{
		if (W_ChangeWeapon(IT_SHOTGUN, FALSE) != WEAPONSTAT_NOAMMO && W_ChangeWeapon(IT_SUPER_SHOTGUN, FALSE) != WEAPONSTAT_NOAMMO)
		{
			sprint (self, "not enough ammo.\n");
			return WEAPONSTAT_NOAMMO;
		}
		else
			return WEAPONSTAT_AVAILABLE;
	}
	else
	{
		sprint(self, "no weapon.\n");
		return WEAPONSTAT_NOWEAPON;
	}
}

float() W_SelectBestNailgun =
{
	if (self.items & (IT_NAILGUN|IT_SUPER_NAILGUN))
	{
		if (W_ChangeWeapon(IT_NAILGUN, FALSE) != WEAPONSTAT_NOAMMO && W_ChangeWeapon(IT_SUPER_NAILGUN, FALSE) != WEAPONSTAT_NOAMMO)
		{
			sprint (self, "not enough ammo.\n");
			return WEAPONSTAT_NOAMMO;
		}
		else
			return WEAPONSTAT_AVAILABLE;
	
	}
	else
	{
		sprint(self, "no weapon.\n");
		return WEAPONSTAT_NOWEAPON;
	}
}

float(float weapId, string weapName) FindWeaponIndex =
{
	float i;
	for (i = 0; i <= MAX_WEAPON_NUM; i++) {
		if (weaponsclass[i].id == weapId && weaponsclass[i].name == weapName) {
			return i;
		}
	}
	return 0;
}

float(float weapIndex) W_ChangeWeaponByIndex =
{
	weaponclass_t weapcl = weaponsclass[weapIndex];
	float weap = weapcl.id;
	
	if (self.animcontroller.owner != self) return WEAPONSTAT_CHANGELOCKED;
	if (self.customflags & CFL_WEAPONLOCK) return WEAPONSTAT_CHANGELOCKED;

	float weapstat = W_CheckWeapon(weap, self);
	if (weapstat < WEAPONSTAT_AVAILABLE){
		return weapstat;
	}

	float forcereset = (self.active_weapon_index != weapIndex);

	if (self.weapon == weap && !forcereset){
		return weapstat;
	}

	if (time > self.pistol_lastreload_time + 3.75 && self.pistol_ammo_count <= 0)	
		self.pistol_ammo_count = 10;

	self.weaponreload_perc = 0;

	self.prev_weapon = self.weapon;
	self.weapon = weap;
	self.active_weapon_index = weapIndex;
	
	self.currentammo = self.(ammofieldlist[weapcl.ammofield]);
	self.items &~= (IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS);
	self.items |= weapcl.ammo_item;

	if (weapcl.ammofield)
		self.currentammo = self.(ammofieldlist[weapcl.ammofield]);
	else 	
		self.currentammo = 0;
	
	if (has_berserk(self) && weap == IT_AXE)
		weapcl.model = "progs/v_berserk.mdl";
	
	self.weaponmodel = weapcl.model;
	self.weaponframe = 0;
	self.attackpressed = 0;
	self.attackhold = 0;
	self.animcontroller.think = player_run;
	self.think = SUB_Null;

	weapcl.idlefunction();
	weapcl.drawfunction(); 
	
	return weapstat;
}

float(float imp) W_ChangeSlot =
{
	// Pistol Manual Reload
	if (imp == 2 && self.weapon == IT_SHOTGUN)
	{
		if (self.pistol_ammo_count != 10)
			weaponanim_reloadpistol();
		else if (self.pistol_ammo_count == 10)
			weaponanim_twirlpistol();
		return WEAPONSTAT_AVAILABLE;
	}
		
	if (self.customflags & CFL_WEAPONLOCK) return WEAPONSTAT_CHANGELOCKED;

	float slotQuantity = weaponslots[imp].qt;
	
	weaponclass_t currentWeapon;
	if (self.active_weapon_index > 0 && self.active_weapon_index <= MAX_WEAPON_NUM)
		currentWeapon = weaponsclass[self.active_weapon_index];
	else
		currentWeapon = weaponsclass[getWeapon(self.weapon)];

	float startSlotPos;

	if (currentWeapon.slot == imp)
	{
		startSlotPos = self.active_slot_weapon[imp];
		startSlotPos = wrap(startSlotPos + 1, 0, slotQuantity - 1);
	}
	else
	{
		startSlotPos = self.active_slot_weapon[imp];
	}

	float i = 0;
	float weaponstat;

	while (i < slotQuantity) 
	{
		// Get the specific weapon data from your weaponslots array 
		weaponclass_t targetWeap = weaponslots[imp].weaps[startSlotPos];
		float checkedWeaponId = targetWeap.id;
		
		weaponstat = W_CheckWeapon(checkedWeaponId, self);
		if (weaponstat == WEAPONSTAT_AVAILABLE)
		{
			self.active_slot_weapon[imp] = startSlotPos;
			
			// Find the global index using the ID and Name from your slot definition [cite: 25]
			float weapIndex = FindWeaponIndex(targetWeap.id, targetWeap.name);

			// Print the weapon name to the player
			bprint("Selected: ");
			bprint(weaponsclass[weapIndex].name);
			bprint("\n");
			
			W_ChangeWeaponByIndex(weapIndex);
			return weaponstat;
		}
		startSlotPos = wrap(startSlotPos + 1, 0, slotQuantity - 1);
		i++;
	}
	
	if (weaponstat == WEAPONSTAT_NOAMMO)
		sprint(self, "not enough ammo.\n");
	if (weaponstat == WEAPONSTAT_NOWEAPON)
		sprint(self, "no weapon.\n");

	return weaponstat;
}

float() W_CycleSlotWeapon =
{
	weaponclass_t currentWeapon;
	if (self.active_weapon_index > 0 && self.active_weapon_index <= MAX_WEAPON_NUM)
		currentWeapon = weaponsclass[self.active_weapon_index];
	else
		currentWeapon = weaponsclass[getWeapon(self.weapon)];
		
	float currentSlot = currentWeapon.slot;
	
	if (currentSlot <= 2)
		return WEAPONSTAT_CHANGELOCKED;
	
	return W_ChangeSlot(currentSlot);
}


float(float stp) W_CycleWeapon =
{
	if (self.customflags & CFL_WEAPONLOCK) return WEAPONSTAT_CHANGELOCKED;

	float currentWeapon = getWeapon(self.weapon);

	float next = wrap(currentWeapon + stp, 1, MAX_WEAPON_NUM);
	float i;
	while (next != currentWeapon && i <= MAX_WEAPON_NUM) {
		//dprint3("Testing slot ", ftos(next), "...\n");
		if (W_CheckWeapon(weaponsclass[next].id, self) == WEAPONSTAT_AVAILABLE) {
		//	dprint3("Found! slot ", ftos(next), "\n");
			W_ChangeWeapon(weaponsclass[next].id, FALSE);
			return WEAPONSTAT_AVAILABLE;
		}

		next = wrap(next + stp, 1, MAX_WEAPON_NUM);
		i++;
	}

	if (i > MAX_WEAPON_NUM) W_ChangeWeapon(IT_NO_WEAPON, FALSE);
	return WEAPONSTAT_AVAILABLE;
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



