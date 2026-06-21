/*
	██     ██ ███████  █████  ██████   ██████  ███    ██     ██████  ███████ ███████ ██ ███    ██ ██ ████████ ██  ██████  ███    ██ ███████ 
	██     ██ ██      ██   ██ ██   ██ ██    ██ ████   ██     ██   ██ ██      ██      ██ ████   ██ ██    ██    ██ ██    ██ ████   ██ ██      
	██  █  ██ █████   ███████ ██████  ██    ██ ██ ██  ██     ██   ██ █████   █████   ██ ██ ██  ██ ██    ██    ██ ██    ██ ██ ██  ██ ███████ 
	██ ███ ██ ██      ██   ██ ██      ██    ██ ██  ██ ██     ██   ██ ██      ██      ██ ██  ██ ██ ██    ██    ██ ██    ██ ██  ██ ██      ██ 
	 ███ ███  ███████ ██   ██ ██       ██████  ██   ████     ██████  ███████ ██      ██ ██   ████ ██    ██    ██  ██████  ██   ████ ███████ 
*/

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

weaponclass_t wpc_PISTOL_REVOLVER = {
	IT_SHOTGUN,
	2, // slot
	PISTOL_REVOLVER_NAME, // name
	PISTOL_REVOLVER_MODEL, // model
	5, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_PISTOL_REVOLVER, // animfunction
	SUB_Null, // idlefunction
	weaponanim_draw // drawfunction
};

// ====================================================================================
// SLOT 3: Shells
// ====================================================================================

weaponclass_t wpc_SHOTGUN_FLAK = {
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

weaponclass_t wpc_SSG_ROTARY = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_ROTARY_NAME,
	SSG_ROTARY_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_ROTARY_COST, // ammo_usage
	weaponanim_SSG_ROTARY,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 4: Nailgun
// ====================================================================================

weaponclass_t wpc_NAIL_TWIN = {
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

weaponclass_t wpc_NAIL_SPINUPv2 = {
	IT_NAILGUN,
	4, // slot
	NAIL_SPINUPv2_NAME,
	NAIL_SPINUPv2_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	NAIL_SPINUPv2_COST, // ammo_usage
	weaponanim_NAIL_SPINUPv2,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 5: Rebar
// ====================================================================================

weaponclass_t wpc_REBAR_BUFF = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_BUFF_NAME,
	REBAR_BUFF_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_BUFF_COST, // ammo_usage
	weaponanim_REBAR_BUFF,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_REBAR_BUZZSAW2 = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_BUZZSAW2_NAME,
	REBAR_BUZZSAW2_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_BUZZSAW2_COST, // ammo_usage
	weaponanim_REBAR_BUZZSAW2,
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

weaponclass_t wpc_GRENADE_TRIBOLTqc = {
	IT_GRENADE_LAUNCHER,
	6, // slot
	GRENADE_TRIBOLTqc_NAME,
	GRENADE_TRIBOLTqc_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	GRENADE_TRIBOLTqc_COST, // ammo_usage
	weaponanim_GRENADE_TRIBOLTqc,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 7: Rockets
// ====================================================================================

weaponclass_t wpc_ROCKET_RPG = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	ROCKET_RPG_NAME,
	ROCKET_RPG_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	ROCKET_RPG_COST, // ammo_usage
	weaponanim_ROCKET_RPG,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_ROCKET_MMML = {
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

weaponclass_t wpc_POWER_INVOKER = {
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

weaponclass_t wpc_POWER_RIFLE = {
	IT_LIGHTNING,
	8, // slot
	POWER_RIFLE_NAME,
	POWER_RIFLE_MODEL,
	4, // ammofield
	IT_CELLS, // ammo_item
	POWER_RIFLE_COST, // ammo_usage
	weaponanim_POWER_RIFLE,
	SUB_Null,
	weaponanim_draw_invoker
};

// ====================================================================================
// SLOT X: Secretweapon
// ====================================================================================

weaponclass_t wpc_SECRET_ASH = {
	IT_NAILGUN,
	4, // slot
	ash_NAME,
	ash_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	ash_COST, // ammo_usage
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
	wpc_PISTOL_REVOLVER,
	
//─────────────────────────────────────────[3]  SHOTGUNS {shells}

	wpc_SHOTGUN_FLAK,
	wpc_SSG_ROTARY,
	
//─────────────────────────────────────────[4]  NAILGUNS {scraps}

	wpc_NAIL_TWIN,
	wpc_NAIL_SPINUPv2,
	
//─────────────────────────────────────────[5]  REBARS {scraps}

	wpc_REBAR_BUFF,
	wpc_REBAR_BUZZSAW2,
	
//─────────────────────────────────────────[6]  GRENADES {explosives}

	wpc_GRENADE_LAUNCHER,
	wpc_GRENADE_TRIBOLTqc,
	
//─────────────────────────────────────────[7]  ROCKETS {explosives}

	wpc_ROCKET_RPG,
	wpc_ROCKET_MMML,
	
//─────────────────────────────────────────[8]  POWER WEAPONS {fragments}

	wpc_POWER_RIFLE,
	wpc_POWER_INVOKER,

//─────────────────────────────────────────[X]  SECRET WEAPONS {---}
	
	wpc_SECRET_ASH

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
	{{wpc_PISTOL_STECHKIN, wpc_PISTOL_REVOLVER}, 2},

	// 3 SHOTGUNS
	{{wpc_SHOTGUN_FLAK, wpc_SSG_ROTARY}, 2},

	// 4 NAILGUNS
	{{wpc_NAIL_TWIN, wpc_NAIL_SPINUPv2}, 2},

	// 5 REBARS
	{{wpc_REBAR_BUFF, wpc_REBAR_BUZZSAW2}, 2},

	// 6 GRENADES
	{{wpc_GRENADE_LAUNCHER, wpc_GRENADE_TRIBOLTqc}, 2},

	// 7 ROCKETS
	{{wpc_ROCKET_RPG, wpc_ROCKET_MMML}, 2},

	// 8 POWER WEAPONS
	{{wpc_POWER_RIFLE, wpc_POWER_INVOKER}, 2}
};