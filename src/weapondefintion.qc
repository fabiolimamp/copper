// ====================================================================================
// SLOT 0: No Weapon
// ====================================================================================

weaponclass_t wpc_no_weapon = {
	IT_NO_WEAPON,
	0, // slot
	"No weapon", // name
	"", // model
	0, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_null, // animfunction
	SUB_Null, // idlefunction
	SUB_Null // drawfunction
};

// ====================================================================================
// SLOT 1: Melee
// ====================================================================================

weaponclass_t wpc_MELEE_WRENCH = {
	IT_AXE,
	1, // slot
	"Wrench", // name
	"progs/v_wrench.mdl", // model
	0, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_wrench, // animfunction
	SUB_Null, // idlefunction
	weaponanim_draw_wrench // drawfunction
};

// ====================================================================================
// SLOT 2: Handguns
// ====================================================================================

weaponclass_t wpc_PISTOL_STECHKIN = {
	IT_SHOTGUN,
	2, // slot
	"Pistol", // name
	"progs/v_pistol.mdl", // model
	5, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_pistol, // animfunction
	SUB_Null, // idlefunction
	weaponanim_draw // drawfunction
};

weaponclass_t wpc_REVOLVER = {
	IT_SHOTGUN,
	2, // slot
	REVOLVER_NAME, // name
	REVOLVER_MODEL, // model
	5, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_REVOLVER, // animfunction
	SUB_Null, // idlefunction
	weaponanim_draw // drawfunction
};

// ====================================================================================
// SLOT 3: Shells
// ====================================================================================

weaponclass_t wpc_FLAK_SHOTGUN = {
	IT_SUPER_SHOTGUN,
	3, // slot
	"Flak Shotgun",
	"progs/v_flakshotgun.mdl",
	1, // ammofield
	IT_SHELLS, // ammo_item
	1, // ammo_usage
	weaponanim_flakshotgun,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_ROTARY_SHOTGUN = {
	IT_SUPER_SHOTGUN,
	3, // slot
	ROTARY_SHOTGUN_NAME,
	ROTARY_SHOTGUN_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	ROTARY_SHOTGUN_COST, // ammo_usage
	weaponanim_ROTARY_SHOTGUN,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 4: Nailgun
// ====================================================================================

weaponclass_t wpc_TWIN_NAILGUNS = {
	IT_NAILGUN,
	4, // slot
	"Twin Nailgun",
	"progs/v_tnailgun.mdl",
	2, // ammofield
	IT_NAILS, // ammo_item
	1, // ammo_usage
	weaponanim_twinnailgun,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_RIVETER = {
	IT_NAILGUN,
	4, // slot
	RIVETER_NAME,
	RIVETER_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	RIVETER_COST, // ammo_usage
	weaponanim_RIVETER,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 5: Rebar
// ====================================================================================

weaponclass_t wpc_REBAR_CANNON = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_CANNON_NAME,
	REBAR_CANNON_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_CANNON_COST, // ammo_usage
	weaponanim_REBAR_CANNON,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SAW_CANNON = {
	IT_SUPER_NAILGUN,
	5, // slot
	SAW_CANNON_NAME,
	SAW_CANNON_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	SAW_CANNON_COST, // ammo_usage
	weaponanim_SAW_CANNON,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 6: Grenades
// ====================================================================================

weaponclass_t wpc_GRENADE_LAUNCHER = {
	IT_GRENADE_LAUNCHER,
	6, // slot
	"Grenade Launcher",
	"progs/v_grenlauncher.mdl",
	3, // ammofield
	IT_ROCKETS, // ammo_item
	1, // ammo_usage
	weaponanim_qbj3grenade,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_TRIDENT = {
	IT_GRENADE_LAUNCHER,
	6, // slot
	TRIDENT_NAME,
	TRIDENT_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	TRIDENT_COST, // ammo_usage
	weaponanim_TRIDENT,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 7: Rockets
// ====================================================================================

weaponclass_t wpc_RPG = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	RPG_NAME,
	RPG_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	RPG_COST, // ammo_usage
	weaponanim_RPG,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_MMML = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	"Multi-Missile Launcher",
	"progs/v_mmml.mdl",
	3, // ammofield
	IT_ROCKETS, // ammo_item
	1, // ammo_usage
	weaponanim_boxrocket,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 8: Superweapon
// ====================================================================================

weaponclass_t wpc_INVOKER = {
	IT_LIGHTNING,
	8, // slot
	"The Invoker",
	"progs/v_invoker.mdl",
	4, // ammofield
	IT_CELLS, // ammo_item
	1, // ammo_usage
	weaponanim_invoker,
	SUB_Null,
	weaponanim_draw_invoker
};

weaponclass_t wpc_RAILGUN = {
	IT_LIGHTNING,
	8, // slot
	RAILGUN_NAME,
	RAILGUN_MODEL,
	4, // ammofield
	IT_CELLS, // ammo_item
	RAILGUN_COST, // ammo_usage
	weaponanim_RAILGUN,
	SUB_Null,
	weaponanim_draw_invoker
};

// ====================================================================================
// SLOT X: Secretweapon
// ====================================================================================

weaponclass_t wpc_BULLPUP = {
	IT_NAILGUN,
	4, // slot
	BULLPUP_NAME,
	BULLPUP_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	BULLPUP_COST, // ammo_usage
	weaponanim_ash,
	SUB_Null,
	weaponanim_draw_ash
};

// ====================================================================================
// WEAPON ARRAY - Contains all weapons in order
// ====================================================================================

weaponclass_t weaponsclass[] = {
	wpc_no_weapon,
//─────────────────────────────────────────[1]  MELEE {---}

	wpc_MELEE_WRENCH,
	
//─────────────────────────────────────────[2]  PISTOLS {bullets}

	wpc_PISTOL_STECHKIN,
	wpc_REVOLVER,
	
//─────────────────────────────────────────[3]  SHOTGUNS {shells}

	wpc_FLAK_SHOTGUN,
	wpc_ROTARY_SHOTGUN,
	
//─────────────────────────────────────────[4]  NAILGUNS {scraps}

	wpc_TWIN_NAILGUNS,
	wpc_RIVETER,
	
//─────────────────────────────────────────[5]  REBARS {scraps}

	wpc_REBAR_CANNON,
	wpc_SAW_CANNON,
	
//─────────────────────────────────────────[6]  GRENADES {explosives}

	wpc_GRENADE_LAUNCHER,
	wpc_TRIDENT,
	
//─────────────────────────────────────────[7]  ROCKETS {explosives}

	wpc_RPG,
	wpc_MMML,
	
//─────────────────────────────────────────[8]  POWER WEAPONS {fragments}

	wpc_RAILGUN,
	wpc_INVOKER,

//─────────────────────────────────────────[X]  SECRET WEAPONS {---}
	
	wpc_BULLPUP

//.........................................
};

float MAX_WEAPON_NUM = 16;	//66;

// ====================================================================================
// WEAPONS ASSIGNED
// ====================================================================================

weaponslot_t weaponslots[9] = {
	{{wpc_no_weapon}, 1},

	// 1 MELEE
	{{wpc_MELEE_WRENCH}, 1},

	// 2 PISTOLS
	{{wpc_PISTOL_STECHKIN, wpc_REVOLVER}, 2},

	// 3 SHOTGUNS
	{{wpc_FLAK_SHOTGUN, wpc_ROTARY_SHOTGUN}, 2},

	// 4 NAILGUNS
	{{wpc_TWIN_NAILGUNS, wpc_RIVETER}, 2},

	// 5 REBARS
	{{wpc_REBAR_CANNON, wpc_SAW_CANNON}, 2},

	// 6 GRENADES
	{{wpc_GRENADE_LAUNCHER, wpc_TRIDENT}, 2},

	// 7 ROCKETS
	{{wpc_RPG, wpc_MMML}, 2},

	// 8 POWER WEAPONS
	{{wpc_RAILGUN, wpc_INVOKER}, 2}
};