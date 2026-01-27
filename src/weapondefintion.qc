/*
================================================================================

WEAPON DEFINITIONS

================================================================================
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

weaponclass_t wpc_axe = {
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

weaponclass_t wpc_PISTOL_AKIMBO = {
	IT_SHOTGUN,
	2, // slot
	PISTOL_AKIMBO_NAME, // name
	PISTOL_AKIMBO_MODEL, // model
	5, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_PISTOL_AKIMBO, // animfunction
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

weaponclass_t wpc_SHOTGUN_PRISM = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SHOTGUN_PRISM_NAME,
	SHOTGUN_PRISM_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SHOTGUN_PRISM_COST, // ammo_usage
	weaponanim_SHOTGUN_PRISM,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SHOTGUN_LEVER = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SHOTGUN_LEVER_NAME,
	SHOTGUN_LEVER_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SHOTGUN_LEVER_COST, // ammo_usage
	weaponanim_SHOTGUN_LEVER,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SHOTGUN_STACK = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SHOTGUN_STACK_NAME,
	SHOTGUN_STACK_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SHOTGUN_STACK_COST, // ammo_usage
	weaponanim_SHOTGUN_STACK,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SHOTGUN_BRAZIL = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SHOTGUN_BRAZIL_NAME,
	SHOTGUN_BRAZIL_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SHOTGUN_BRAZIL_COST, // ammo_usage
	weaponanim_SHOTGUN_BRAZIL,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================

weaponclass_t wpc_SSG_BLUE = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_BLUE_NAME,
	SSG_BLUE_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_BLUE_COST, // ammo_usage
	weaponanim_SSG_BLUE,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SSG_SUPER = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_SUPER_NAME,
	SSG_SUPER_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_SUPER_COST, // ammo_usage
	weaponanim_SSG_SUPER,
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

weaponclass_t wpc_SSG_ROTARYv2 = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_ROTARYv2_NAME,
	SSG_ROTARYv2_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_ROTARYv2_COST, // ammo_usage
	weaponanim_SSG_ROTARYv2,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SSG_AUTO = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_AUTO_NAME,
	SSG_AUTO_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_AUTO_COST, // ammo_usage
	weaponanim_SSG_AUTO,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SSG_SWEEPER = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_SWEEPER_NAME,
	SSG_SWEEPER_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_SWEEPER_COST, // ammo_usage
	weaponanim_SSG_SWEEPER,
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

weaponclass_t wpc_NAIL_HEAVY = {
	IT_NAILGUN,
	4, // slot
	NAIL_HEAVY_NAME,
	NAIL_HEAVY_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	NAIL_HEAVY_COST, // ammo_usage
	weaponanim_NAIL_HEAVY,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_NAIL_TURBO = {
	IT_NAILGUN,
	4, // slot
	NAIL_TURBO_NAME,
	NAIL_TURBO_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	NAIL_TURBO_COST, // ammo_usage
	weaponanim_NAIL_TURBO,
	SUB_Null,
	weaponanim_draw
};


weaponclass_t wpc_NAIL_LMG = {
	IT_NAILGUN,
	4, // slot
	NAIL_LMG_NAME,
	NAIL_LMG_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	NAIL_LMG_COST, // ammo_usage
	weaponanim_NAIL_LMG,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_NAIL_DRUM = {
	IT_NAILGUN,
	4, // slot
	NAIL_DRUM_NAME,
	NAIL_DRUM_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	NAIL_DRUM_COST, // ammo_usage
	weaponanim_NAIL_DRUM,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 5: Rebar
// ====================================================================================

weaponclass_t wpc_REBAR_CANNON = {
	IT_SUPER_NAILGUN,
	5, // slot
	"Rebar Cannon",
	"progs/v_rebar.mdl",
	2, // ammofield
	IT_NAILS, // ammo_item
	10, // ammo_usage
	weaponanim_rebarcannon,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_REBAR_MULTI = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_MULTI_NAME,
	REBAR_MULTI_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_MULTI_COST, // ammo_usage
	weaponanim_REBAR_MULTI,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_REBAR_WIDE = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_WIDE_NAME,
	REBAR_WIDE_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_WIDE_COST, // ammo_usage
	weaponanim_REBAR_WIDE,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_REBAR_TALL = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_TALL_NAME,
	REBAR_TALL_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_TALL_COST, // ammo_usage
	weaponanim_REBAR_TALL,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_REBAR_TRIPLE = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_TRIPLE_NAME,
	REBAR_TRIPLE_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_TRIPLE_COST, // ammo_usage
	weaponanim_REBAR_TRIPLE,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_REBAR_FAST = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_FAST_NAME,
	REBAR_FAST_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_FAST_COST, // ammo_usage
	weaponanim_REBAR_FAST,
	SUB_Null,
	weaponanim_draw
};

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

weaponclass_t wpc_REBAR_RIFLE = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_RIFLE_NAME,
	REBAR_RIFLE_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_RIFLE_COST, // ammo_usage
	weaponanim_REBAR_RIFLE,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_REBAR_REPEATER = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_REPEATER_NAME,
	REBAR_REPEATER_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_REPEATER_COST, // ammo_usage
	weaponanim_REBAR_REPEATER,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_REBAR_BOUNCE = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_BOUNCE_NAME,
	REBAR_BOUNCE_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_BOUNCE_COST, // ammo_usage
	weaponanim_REBAR_BOUNCE,
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

weaponclass_t wpc_GRENADE_DIRECT = {
	IT_GRENADE_LAUNCHER,
	6, // slot
	GRENADE_DIRECT_NAME,
	GRENADE_DIRECT_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	GRENADE_DIRECT_COST, // ammo_usage
	weaponanim_GRENADE_DIRECT,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_GRENADE_TRIBOLT = {
	IT_GRENADE_LAUNCHER,
	6, // slot
	GRENADE_TRIBOLT_NAME,
	GRENADE_TRIBOLT_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	GRENADE_DIRECT_COST, // ammo_usage
	weaponanim_GRENADE_TRIBOLT,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 7: Rockets
// ====================================================================================

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

weaponclass_t wpc_ROCKET_ORIGINAL = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	ROCKET_ORIGINAL_NAME,
	ROCKET_ORIGINAL_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	1, // ammo_usage
	weaponanim_ROCKET_ORIGINAL,
	SUB_Null,
	weaponanim_draw
};

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

weaponclass_t wpc_ROCKET_INSTANT = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	ROCKET_INSTANT_NAME,
	ROCKET_INSTANT_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	ROCKET_INSTANT_COST, // ammo_usage
	weaponanim_ROCKET_INSTANT,
	SUB_Null,
	weaponanim_draw
};

// ====================================================================================
// SLOT 8: Superweapon
// ====================================================================================

weaponclass_t wpc_invoker = {
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

// ====================================================================================
// WEAPON ARRAY - Contains all weapons in order
// ====================================================================================

weaponclass_t weaponsclass[] = {
	wpc_no_weapon,
//───────────────────────────────────────── MELEE {---}
	wpc_axe,
//───────────────────────────────────────── PISTOLS {bullets}
	wpc_PISTOL_STECHKIN,
	wpc_PISTOL_AKIMBO,
	wpc_PISTOL_REVOLVER,
//───────────────────────────────────────── SHOTGUNS {shells}
	wpc_SHOTGUN_FLAK,
	wpc_SHOTGUN_PRISM,
	wpc_SHOTGUN_LEVER,
	wpc_SHOTGUN_STACK,
	wpc_SHOTGUN_BRAZIL,
//───────────────────────────────────────── SUPER SHOTGUNS {shells}
	wpc_SSG_BLUE,
	wpc_SSG_SUPER,
	wpc_SSG_ROTARY,
	wpc_SSG_ROTARYv2,
	wpc_SSG_AUTO,
	wpc_SSG_SWEEPER,
//───────────────────────────────────────── NAILGUNS {scraps}
	wpc_NAIL_TWIN,
	wpc_NAIL_HEAVY,
	wpc_NAIL_TURBO,
	wpc_NAIL_LMG,
	wpc_NAIL_DRUM,
//───────────────────────────────────────── REBARS {scraps}
	wpc_REBAR_CANNON,
	wpc_REBAR_WIDE,
	wpc_REBAR_TALL,
	wpc_REBAR_TRIPLE,
	wpc_REBAR_FAST,
	wpc_REBAR_MULTI,
	wpc_REBAR_BUFF,
	wpc_REBAR_RIFLE,
	wpc_REBAR_REPEATER,
	wpc_REBAR_BOUNCE,
//───────────────────────────────────────── GRENADES {explosives}
	wpc_GRENADE_LAUNCHER,
	wpc_GRENADE_DIRECT,
	wpc_GRENADE_TRIBOLT,
//───────────────────────────────────────── ROCKETS {explosives}
	wpc_ROCKET_MMML,
	wpc_ROCKET_ORIGINAL,
	wpc_ROCKET_RPG,
	wpc_ROCKET_INSTANT,
//───────────────────────────────────────── POWER WEAPONS {fragments}
	wpc_invoker
};

float MAX_WEAPON_NUM = 38;

weaponslot_t weaponslots[9] = {
	{{wpc_no_weapon}, 1},
	{{wpc_axe}, 1},
	
	//{{wpc_PISTOL_STECHKIN}, 1},	//broken spin
	//{{wpc_PISTOL_AKIMBO}, 1},
	{{wpc_PISTOL_REVOLVER}, 1},
	
	{{wpc_SHOTGUN_FLAK, wpc_SSG_BLUE, wpc_SHOTGUN_PRISM}, 3},
	{{wpc_NAIL_TWIN, wpc_NAIL_DRUM}, 2},
	{{wpc_REBAR_BUFF, wpc_REBAR_BOUNCE}, 2},
	
	{{wpc_GRENADE_LAUNCHER, wpc_GRENADE_DIRECT, wpc_GRENADE_TRIBOLT}, 3},
	{{wpc_ROCKET_MMML, wpc_ROCKET_RPG, wpc_ROCKET_INSTANT}, 3},
	{{wpc_invoker}, 1}
};