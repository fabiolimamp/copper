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

weaponclass_t wpc_MELEE_KNIFE = {
	IT_AXE,
	1, // slot
	MELEE_KNIFE_NAME, // name
	MELEE_KNIFE_MODEL, // model
	0, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_MELEE_KNIFE, // animfunction
	SUB_Null, // idlefunction
	weaponanim_draw // drawfunction
};

weaponclass_t wpc_MELEE_THROW = {
	IT_AXE,
	1, // slot
	MELEE_THROW_NAME, // name
	MELEE_THROW_MODEL, // model
	0, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_MELEE_THROW, // animfunction
	SUB_Null, // idlefunction
	weaponanim_draw // drawfunction
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

weaponclass_t wpc_PISTOL_BIGIRON = {
	IT_SHOTGUN,
	2, // slot
	PISTOL_BIGIRON_NAME, // name
	PISTOL_BIGIRON_MODEL, // model
	5, // ammofield
	0, // ammo_item
	0, // ammo_usage
	weaponanim_PISTOL_BIGIRON, // animfunction
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

weaponclass_t wpc_SHOTGUN_COWBOY = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SHOTGUN_COWBOY_NAME,
	SHOTGUN_COWBOY_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SHOTGUN_COWBOY_COST, // ammo_usage
	weaponanim_SHOTGUN_COWBOY,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SHOTGUN_COWBOYv2 = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SHOTGUN_COWBOYv2_NAME,
	SHOTGUN_COWBOYv2_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SHOTGUN_COWBOYv2_COST, // ammo_usage
	weaponanim_SHOTGUN_COWBOYv2,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SHOTGUN_QUAKEY = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SHOTGUN_QUAKEY_NAME,
	SHOTGUN_QUAKEY_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SHOTGUN_QUAKEY_COST, // ammo_usage
	weaponanim_SHOTGUN_QUAKEY,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SHOTGUN_OVERUNDER = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SHOTGUN_OVERUNDER_NAME,
	SHOTGUN_OVERUNDER_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SHOTGUN_OVERUNDER_COST, // ammo_usage
	weaponanim_SHOTGUN_OVERUNDER,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SHOTGUN_SAWED = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SHOTGUN_SAWED_NAME,
	SHOTGUN_SAWED_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SHOTGUN_SAWED_COST, // ammo_usage
	weaponanim_SHOTGUN_SAWED,
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

weaponclass_t wpc_SSG_SAWEDBLUE = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_SAWEDBLUE_NAME,
	SSG_SAWEDBLUE_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_SAWEDBLUE_COST, // ammo_usage
	weaponanim_SSG_SAWEDBLUE,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SSG_SAWEDBLUEv2 = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_SAWEDBLUEv2_NAME,
	SSG_SAWEDBLUEv2_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_SAWEDBLUEv2_COST, // ammo_usage
	weaponanim_SSG_SAWEDBLUEv2,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SSG_SUPERSAWED = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_SUPERSAWED_NAME,
	SSG_SUPERSAWED_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_SUPERSAWED_COST, // ammo_usage
	weaponanim_SSG_SUPERSAWED,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SSG_TRIPLE = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_TRIPLE_NAME,
	SSG_TRIPLE_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_TRIPLE_COST, // ammo_usage
	weaponanim_SSG_TRIPLE,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SSG_THREE = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_THREE_NAME,
	SSG_THREE_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_THREE_COST, // ammo_usage
	weaponanim_SSG_THREE,
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

weaponclass_t wpc_SSG_ROTARYBUFF = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_ROTARYBUFF_NAME,
	SSG_ROTARYBUFF_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_ROTARYBUFF_COST, // ammo_usage
	weaponanim_SSG_ROTARYBUFF,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SSG_ROTARYFLAK = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_ROTARYFLAK_NAME,
	SSG_ROTARYFLAK_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_ROTARYFLAK_COST, // ammo_usage
	weaponanim_SSG_ROTARYFLAK,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_SSG_ROTARYFAST = {
	IT_SUPER_SHOTGUN,
	3, // slot
	SSG_ROTARYFAST_NAME,
	SSG_ROTARYFAST_MODEL,
	1, // ammofield
	IT_SHELLS, // ammo_item
	SSG_ROTARYFAST_COST, // ammo_usage
	weaponanim_SSG_ROTARYFAST,
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

weaponclass_t wpc_NAIL_SPINUP = {
	IT_NAILGUN,
	4, // slot
	NAIL_SPINUP_NAME,
	NAIL_SPINUP_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	NAIL_SPINUP_COST, // ammo_usage
	weaponanim_NAIL_SPINUP,
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

weaponclass_t wpc_REBAR_BUZZSAW = {
	IT_SUPER_NAILGUN,
	5, // slot
	REBAR_BUZZSAW_NAME,
	REBAR_BUZZSAW_MODEL,
	2, // ammofield
	IT_NAILS, // ammo_item
	REBAR_BUZZSAW_COST, // ammo_usage
	weaponanim_REBAR_BUZZSAW,
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
	GRENADE_TRIBOLT_COST, // ammo_usage
	weaponanim_GRENADE_TRIBOLT,
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

weaponclass_t wpc_GRENADE_AUTO = {
	IT_GRENADE_LAUNCHER,
	6, // slot
	GRENADE_AUTO_NAME,
	GRENADE_AUTO_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	GRENADE_AUTO_COST, // ammo_usage
	weaponanim_GRENADE_AUTO,
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

weaponclass_t wpc_ROCKET_HALFLIFE = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	ROCKET_HALFLIFE_NAME,
	ROCKET_HALFLIFE_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	ROCKET_HALFLIFE_COST, // ammo_usage
	weaponanim_ROCKET_HALFLIFE,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_ROCKET_HEAVY = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	ROCKET_HEAVY_NAME,
	ROCKET_HEAVY_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	ROCKET_HEAVY_COST, // ammo_usage
	weaponanim_ROCKET_HEAVY,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_ROCKET_DOUBLE = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	ROCKET_DOUBLE_NAME,
	ROCKET_DOUBLE_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	ROCKET_DOUBLE_COST, // ammo_usage
	weaponanim_ROCKET_DOUBLE,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_ROCKET_FLASH = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	ROCKET_FLASH_NAME,
	ROCKET_FLASH_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	ROCKET_FLASH_COST, // ammo_usage
	weaponanim_ROCKET_FLASH,
	SUB_Null,
	weaponanim_draw
};

weaponclass_t wpc_ROCKET_TRIPLE = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	ROCKET_TRIPLE_NAME,
	ROCKET_TRIPLE_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	ROCKET_TRIPLE_COST, // ammo_usage
	weaponanim_ROCKET_TRIPLE,
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

weaponclass_t wpc_ROCKET_REMOTE = {
	IT_ROCKET_LAUNCHER,
	7, // slot
	ROCKET_REMOTE_NAME,
	ROCKET_REMOTE_MODEL,
	3, // ammofield
	IT_ROCKETS, // ammo_item
	ROCKET_REMOTE_COST, // ammo_usage
	weaponanim_ROCKET_REMOTE,
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
	5, // slot
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

	wpc_MELEE_WRENCH,	//YES
	wpc_PISTOL_STECHKIN,	//(force impulse 9 reset with pistol)
	wpc_MELEE_KNIFE,	//no
	wpc_MELEE_THROW,	//no
	
//─────────────────────────────────────────[2]  PISTOLS {bullets}

	//wpc_PISTOL_STECHKIN,	//maybe?
	wpc_PISTOL_AKIMBO,	//YES
	wpc_PISTOL_REVOLVER,	//YES
	wpc_PISTOL_BIGIRON,	//no
	
//─────────────────────────────────────────[3]  SHOTGUNS {shells}

	wpc_SHOTGUN_FLAK,	//YES
	wpc_SHOTGUN_PRISM,	//no
	wpc_SHOTGUN_COWBOY,	//no
	wpc_SHOTGUN_COWBOYv2,	//no
	wpc_SHOTGUN_QUAKEY,	//maybe?
	wpc_SHOTGUN_OVERUNDER,	//maybe?
	wpc_SHOTGUN_SAWED,	//no
	wpc_SHOTGUN_LEVER,	//no
	wpc_SHOTGUN_STACK,	//no
	wpc_SHOTGUN_BRAZIL,	//no
	
//─────────────────────────────────────────[4]  SUPER SHOTGUNS {shells}

	wpc_SSG_BLUE,		//no
	wpc_SSG_SAWEDBLUE,	//no
	wpc_SSG_SAWEDBLUEv2,	//no
	wpc_SSG_SUPERSAWED,	//no
	wpc_SSG_TRIPLE,		//no
	wpc_SSG_THREE,		//maybe?
	wpc_SSG_SUPER,		//no
	wpc_SSG_ROTARY,		//YES
	wpc_SSG_ROTARYBUFF,	//maybe?
	wpc_SSG_ROTARYFLAK,	//maybe?
	wpc_SSG_ROTARYFAST,	//no
	wpc_SSG_AUTO,		//no
	wpc_SSG_SWEEPER,	//no
	
//─────────────────────────────────────────[5]  NAILGUNS {scraps}

	wpc_NAIL_TWIN,		//YES
	wpc_NAIL_HEAVY,		//no
	wpc_NAIL_TURBO,		//no
	wpc_NAIL_LMG,		//no
	wpc_NAIL_DRUM,		//no
	wpc_NAIL_SPINUP,	//maybe?
	wpc_NAIL_SPINUPv2,	//maybe?
	
//─────────────────────────────────────────[6]  REBARS {scraps}

	wpc_REBAR_CANNON,	//no
	wpc_REBAR_WIDE,		//no
	wpc_REBAR_TALL,		//no
	wpc_REBAR_TRIPLE,	//no
	wpc_REBAR_FAST,		//no
	wpc_REBAR_MULTI,	//no
	wpc_REBAR_BUFF,		//YES
	wpc_REBAR_RIFLE,	//no
	wpc_REBAR_REPEATER,	//no
	wpc_REBAR_BUZZSAW,	//maybe?
	
//─────────────────────────────────────────[7]  GRENADES {explosives}

	wpc_GRENADE_LAUNCHER,	//YES
	wpc_GRENADE_DIRECT,	//maybe?
	wpc_GRENADE_TRIBOLT,	//maybe?
	wpc_GRENADE_TRIBOLTqc,	//maybe?
	wpc_GRENADE_AUTO,	//maybe?
	
//─────────────────────────────────────────[8]  ROCKETS {explosives}

	wpc_ROCKET_MMML,	//YES
	wpc_ROCKET_ORIGINAL,	//maybe?
	wpc_ROCKET_RPG,		//maybe?
	wpc_ROCKET_HALFLIFE,	//no
	wpc_ROCKET_HEAVY,	//no
	wpc_ROCKET_DOUBLE,	//maybe?
	wpc_ROCKET_FLASH,	//maybe?
	wpc_ROCKET_TRIPLE,	//maybe?
	wpc_ROCKET_INSTANT,	//no
	wpc_ROCKET_REMOTE,	//maybe?
	
//─────────────────────────────────────────[9]  POWER WEAPONS {fragments}

	wpc_POWER_INVOKER,	//YES
	wpc_POWER_RIFLE,	//maybe?

//─────────────────────────────────────────[X]  SECRET WEAPONS {---}
	
	wpc_SECRET_ASH		//secret!
	
};

float MAX_WEAPON_NUM = 65;

weaponslot_t weaponslots[9] = {
	{{wpc_no_weapon}, 1},
	
	{{wpc_MELEE_WRENCH}, 1},
	
	{{wpc_PISTOL_STECHKIN, wpc_PISTOL_AKIMBO, wpc_PISTOL_REVOLVER, wpc_PISTOL_BIGIRON}, 4},	//impulse 19 = manual reload & pin
	
	{{wpc_SHOTGUN_FLAK, wpc_SSG_THREE, wpc_SHOTGUN_QUAKEY, wpc_SHOTGUN_OVERUNDER, wpc_SHOTGUN_SAWED, wpc_SSG_ROTARY, wpc_SSG_ROTARYBUFF, wpc_SSG_ROTARYFLAK}, 8},
	
	{{wpc_NAIL_TWIN, wpc_NAIL_SPINUPv2, wpc_SECRET_ASH}, 3},
	
	{{wpc_REBAR_BUFF, wpc_REBAR_BUZZSAW}, 2},
	
	{{wpc_GRENADE_LAUNCHER, wpc_GRENADE_DIRECT, wpc_GRENADE_TRIBOLTqc, wpc_GRENADE_TRIBOLT}, 4},
	
	{{wpc_ROCKET_MMML, wpc_ROCKET_TRIPLE, wpc_ROCKET_REMOTE, wpc_ROCKET_ORIGINAL, wpc_ROCKET_RPG, wpc_ROCKET_DOUBLE}, 6},
	
	{{wpc_POWER_INVOKER, wpc_POWER_RIFLE}, 2}
};