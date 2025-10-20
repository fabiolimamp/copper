/*
===============================================================================

WEAPONS

===============================================================================
*/

float	ITEM_AMMO_BIG = 1;
float	ITEM_AMMO_YOOGE = 2;


void(entity e) bound_ammo =
{
	e.ammo_shells = min(e.ammo_shells, MAX_AMMO_SHELLS);
	e.ammo_nails = min(e.ammo_nails, MAX_AMMO_NAILS);
	e.ammo_rockets = min(e.ammo_rockets, MAX_AMMO_ROCKETS);
	e.ammo_cells = min(e.ammo_cells, MAX_AMMO_CELLS);
}

/*
=============
weapon_touch_coop
=============
*/
void() weapon_touch_coop =
{
	if (!coop) return;
	activator = other;
	SUB_UseTargets();
	self.killtarget = string_null;
	self.target = string_null;
	self.target2 = string_null;
	self.target3 = string_null;
	self.target4 = string_null;
}

void(entity to) weapon_give =
{
	to.items |= self.items;
	to.ammo_shells += self.ammo_shells;
	to.ammo_nails += self.ammo_nails;
	to.ammo_rockets += self.ammo_rockets;
	to.ammo_cells += self.ammo_cells;
		
	bound_ammo(to);

	sprint (to, "You got the ");
	sprint (to, self.netname);
	sprint (to, "\n");

	sound (to, CHAN_ITEM, "weapons/pkup.wav", 1, ATTN_NORM);
	stuffcmd (to, "bf\n");
}

/*
=============
weapon_touch
=============
*/
void() weapon_touch =
{
	float	leave, nsw;

	if (!CheckValidTouch()) return;

	if (deathmatch == 2 || deathmatch == 3 || coop > 1)
		leave = 1;
	else
		leave = 0;
	
	if (leave)
	{
		if (other.items & self.items == self.items)	// already have it
		{
			weapon_touch_coop();
			return;
		}
	}
	
	if (self.items & other.items) nsw = TRUE;

	weapon_give(other);
	// change to the weapon
	if (nsw)
		SUB_CallAsSelf(W_ResetWeaponState, other);
	else
		W_BetterWeapon(other, self.items);

	if (coop == 1)
	{
		entity pl = get_next_client(other);
		while (pl != other)
		{
			weapon_give(pl);
			pl = get_next_client(pl);
		}
	}
	
	if (leave)
	{
		weapon_touch_coop();
		return;
	}

	ItemTouched();
}


/*
============
StartWeapon
============
*/
void() StartWeapon =
{
	self.type = "weapon";
	self.touch = weapon_touch;
	setsize (self, '-16 -16 0', '16 16 56');
	if (deathmatch == 1)
		self.wait = 30;
	StartItem ();
}


// ===============================================================================

/*FGD
@baseclass size(-16 -16 0, 16 16 56) color(0 0 200) base(Item) = Weapon []
*/

/*QUAKED weapon_pistol (0 0 1) (-16 -16 0) (16 16 56) ? ? SUSPENDED
Pistol.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Weapon) model({ "path": ":progs/g_pistol.mdl" }) = weapon_pistol : "Pistol." []
*/
void() weapon_pistol =
{
	if (!SUB_ShouldSpawn()) return;
	precache_model3 ("progs/g_pistol.mdl");
	setmodel (self, "progs/g_pistol.mdl");
	self.items = IT_SHOTGUN;
	self.ammo_shells = 0; //FlakTax
	self.netname = "Stechkin Pistol";
	StartWeapon();
}

void() weapon_shotgun = {weapon_pistol();} //for legacy compat


/*QUAKED weapon_flak (0 0 1) (-16 -16 0) (16 16 56) ? ? SUSPENDED
Flak shotgun.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Weapon) model({ "path": ":progs/g_flakshotgun.mdl" }) = weapon_flak : "Flak Shotgun.
16 shells." []
*/
void() weapon_flak =
{
	if (!SUB_ShouldSpawn()) return;
	precache_model_safe ("progs/g_flakshotgun.mdl");
	setmodel (self, "progs/g_flakshotgun.mdl");
	self.items = IT_SUPER_SHOTGUN;
	self.ammo_shells = 16; //FlakTax
	self.netname = "KS-23 FLAK";
	StartWeapon();
}

void() weapon_supershotgun = {weapon_flak();} //for legacy compat



/*QUAKED weapon_nailgun (0 0 1) (-16 -16 0) (16 16 56) ? ? SUSPENDED
Twin Nailgun.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Weapon) model({ "path": ":progs/g_tnailgun.mdl" }) = weapon_nailgun : "Twin Nailgun.
30 nails." []
*/
void() weapon_nailgun =
{
	if (!SUB_ShouldSpawn()) return;
	precache_model_safe ("progs/g_tnailgun.mdl");
	setmodel (self, "progs/g_tnailgun.mdl");
	self.items = IT_NAILGUN;
	self.ammo_nails = 30;
	self.netname = "Twin Nailguns";
	StartWeapon();
}

/*QUAKED weapon_rebar (0 0 1) (-16 -16 0) (16 16 56) ? ? SUSPENDED
Rebar Cannon.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Weapon) model({ "path": ":progs/g_rebar.mdl" }) = weapon_rebar : "Rebar Cannon.
30 nails." []
*/
void() weapon_rebar =
{
	if (!SUB_ShouldSpawn()) return;
	precache_model_safe ("progs/g_rebar.mdl");
	setmodel (self, "progs/g_rebar.mdl");
	self.items = IT_SUPER_NAILGUN;
	self.ammo_nails = 30;
	self.netname = "Rebar Cannon";
	StartWeapon();
}

void() weapon_supernailgun = {weapon_rebar();} //for legacy compat

/*QUAKED weapon_grenadelauncher (0 0 1) (-16 -16 0) (16 16 56) ? ? SUSPENDED
Grenade Launcher.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Weapon) model({ "path": ":progs/g_grenlauncher.mdl" }) = weapon_grenadelauncher : "Grenade Launcher.
8 rockets." []
*/
void() weapon_grenadelauncher =
{
	if (!SUB_ShouldSpawn()) return;
	precache_model_safe ("progs/g_grenlauncher.mdl");
	setmodel (self, "progs/g_grenlauncher.mdl");
	self.items = IT_GRENADE_LAUNCHER;
	self.ammo_rockets = 8;
	self.netname = "RG-6 Grenade Launcher";
	StartWeapon();
}

/*QUAKED weapon_mmml (0 0 1) (-16 -16 0) (16 16 56) ? ? SUSPENDED
Multi Mini-Missile Launcher.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Weapon) model({ "path": ":progs/g_mmml.mdl" }) = weapon_mmml : "Multi Mini-Missile Launcher.
8 rockets." []
*/
void() weapon_mmml =
{
	if (!SUB_ShouldSpawn()) return;
	precache_model_safe ("progs/g_mmml.mdl");
	setmodel (self, "progs/g_mmml.mdl");
	self.items = IT_ROCKET_LAUNCHER;
	self.ammo_rockets = 8;
	self.netname = "Multi Mini-Missile Launcher";
	StartWeapon();
}

void() weapon_rocketlauncher = {weapon_mmml();} //for legacy compat

/*QUAKED weapon_invoker (0 0 1) (-16 -16 0) (16 16 56) ? ? SUSPENDED
The Invoker.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Weapon) model({ "path": ":progs/g_invoker.mdl" }) = weapon_invoker : "The Invoker.
1 cell." []
*/
void() weapon_invoker =
{
	if (!SUB_ShouldSpawn()) return;
	precache_model_safe ("progs/g_invoker.mdl");
	setmodel (self, "progs/g_invoker.mdl");
	self.items = IT_LIGHTNING;
	self.ammo_cells = 1;
	self.netname = "The Invoker";
	StartWeapon();
}

void() weapon_lightning = {weapon_invoker();} //for legacy compat

/*QUAKED weapon_wrench (0 0 1) (-16 -16 0) (16 16 56) ? ? SUSPENDED
The Wrench, should you happen to make the player start without one.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Weapon) model({ "path": ":progs/g_wrench.mdl" }) = weapon_wrench : "Wrench." []
*/
void() weapon_wrench =
{
	if (!SUB_ShouldSpawn()) return;
	precache_model_safe ("progs/g_wrench.mdl");
	setmodel (self, "progs/g_wrench.mdl");
	self.items = IT_AXE;
	self.netname = "Skullcracker";
	StartWeapon();
}

void() weapon_axe = {weapon_wrench();} //for legacy compat


// ===============================================================================

/*
============
ammo_touch
============
*/
void() ammo_touch =
{
	if (!CheckValidTouch()) return;

	// structured in dual if's instead of using && to preserve ammo_touch maphacks
	if (self.ammo_shells)
	{
		if (other.ammo_shells < MAX_AMMO_SHELLS)
			other.ammo_shells += self.ammo_shells;
		else return;
	}
	else if (self.ammo_nails)
	{
		if (other.ammo_nails < MAX_AMMO_NAILS)
			other.ammo_nails += self.ammo_nails;
		else return;
	}
	else if (self.ammo_rockets)
	{
		if (other.ammo_rockets < MAX_AMMO_ROCKETS)
			other.ammo_rockets += self.ammo_rockets;
		else return;
	}
	else if (self.ammo_cells)
	{
		if (other.ammo_cells < MAX_AMMO_CELLS)
			other.ammo_cells += self.ammo_cells;
		else return;
	}
	//else return;	

	bound_ammo(other);
	
	sprint (other, "You got the ");
	sprint (other, self.netname);
	sprint (other, "\n");

	sound (other, CHAN_ITEM, "weapons/lock4.wav", 1, ATTN_NORM);
	stuffcmd (other, "bf\n");

	if (!self.weapon)
		SUB_CallAsSelf(W_SelectBestWeapon, other);
	else
		// if changed current ammo, update it	
		SUB_CallAsSelf(W_UpdateCurrentAmmo, other);
	
	ItemTouched();
}

/*
============
StartAmmo
============
*/
void() StartAmmo =
{
	self.type = "ammo";
	setsize (self, '0 0 0', '32 32 56');
	self.touch = ammo_touch;
	if (deathmatch == 1)
		self.wait = 30;
	if (deathmatch == 3)
		self.wait = 15;
	StartItem ();
	//ItemRotateAndSize('32 32 56');
}

/*FGD
@baseclass size(0 0 0, 32 32 32) color(0 160 160) base(Item) = Ammo [ spawnflags(flags) =  [ 2 : "YOOGE (refills 50%)" 1 : "Large box (2x)" : 0 ] ]
*/

/*QUAKED item_shells (0 .5 .5) (0 0 0) (32 32 32) BIG ? SUSPENDED
10 shells for the Flak Shotgun.

Flags:
"big" gives 8 instead of 4
"YOOGE" gives 50

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Ammo)
    model(
        {{
            spawnflags & 2 ->   ":progs/tb/shells_2.mdl",
            spawnflags & 1 ->   ":progs/tb/shells_1.mdl",
                                ":progs/tb/shells_0.mdl"
        }}
    ) = item_shells : "Shells, 4/8/50" []
*/
void() item_shells =
{
	if (!SUB_ShouldSpawn()) return;
	
	if (self.spawnflags & ITEM_AMMO_YOOGE)
	{
		self.ammo_shells = 50;
		precache_model_safe ("progs/ammo/shells_large.mdl");
		setmodel(self, "progs/ammo/shells_large.mdl");
	}
	else if (self.spawnflags & ITEM_AMMO_BIG)
	{
		self.ammo_shells = 8;
		precache_model_safe ("progs/ammo/shells_med.mdl");
		setmodel(self, "progs/ammo/shells_med.mdl");
	}
	else
	{
		self.ammo_shells = 4;
		precache_model_safe ("progs/ammo/shells_small.mdl");
		setmodel(self, "progs/ammo/shells_small.mdl");
	}
	
	self.weapon = 1;
	self.netname = "shells";
	StartAmmo();
}

/*QUAKED item_spikes (0 .5 .5) (0 0 0) (32 32 32) BIG ? SUSPENDED
30 ammo points (spikes) for the Twin Nailguns and Rebar Cannon.

Flags:
"big" gives 50 instead of 25
"YOOGE" gives 100

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Ammo) 
    model(
        {{
            spawnflags & 2 ->   ":progs/tb/nails_2.mdl",
            spawnflags & 1 ->   ":progs/tb/nails_1.mdl",
                                ":progs/tb/nails_0.mdl"
        }}
    ) = item_spikes : "Nailgun/Perforator ammo, 25/50/100" []
*/
void() item_spikes =
{
	if (!SUB_ShouldSpawn()) return;
	
	if (self.spawnflags & ITEM_AMMO_YOOGE)
	{
		self.ammo_nails = 100;
		precache_model_safe ("progs/ammo/nails_large.mdl");
		setmodel(self, "progs/ammo/nails_large.mdl");
	}
	else if (self.spawnflags & ITEM_AMMO_BIG)
	{
		self.ammo_nails = 50;
		precache_model_safe ("progs/ammo/nails_med.mdl");
		setmodel (self, "progs/ammo/nails_med.mdl");
	}
	else
	{
		self.ammo_nails = 25;
		precache_model_safe ("progs/ammo/nails_small.mdl");
		setmodel (self, "progs/ammo/nails_small.mdl");
	}
	self.weapon = 2;
	self.netname = "nails";
	StartAmmo();
}

/*QUAKED item_rockets (0 .5 .5) (0 0 0) (32 32 32) BIG ? SUSPENDED
4 ammo points (explosives) for the Grenade Launcher / Multi Mini-Missile Launcher.

Flags:
"big" gives 8 instead of 4
"YOOGE" gives 50
    
Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Ammo) 
    model(
        {{
            spawnflags & 2 ->   ":progs/tb/explosives_2.mdl",
            spawnflags & 1 ->   ":progs/tb/explosives_1.mdl",
                                ":progs/tb/explosives_0.mdl"
        }}
    ) =
    item_rockets : "Rockets, 4/8/50" []
*/
void() item_rockets =
{
	if (!SUB_ShouldSpawn()) return;
	
	if (self.spawnflags & ITEM_AMMO_YOOGE)
	{
		self.ammo_rockets = 50;
		precache_model_safe ("progs/ammo/explosives_large.mdl");
		setmodel(self, "progs/ammo/explosives_large.mdl");
	}	
	else if (self.spawnflags & ITEM_AMMO_BIG)
	{
		self.ammo_rockets = 8;
		precache_model_safe ("progs/ammo/explosives_med.mdl");
		setmodel (self, "progs/ammo/explosives_med.mdl");
	}
	else
	{
		self.ammo_rockets = 4;
		precache_model_safe ("progs/ammo/explosives_small.mdl");
		setmodel (self, "progs/ammo/explosives_small.mdl");
	}
	self.weapon = 3;
	self.netname = "explosives";
	StartAmmo();
}

/*QUAKED item_cells (0 .5 .5) (0 0 0) (32 32 32) BIG ? SUSPENDED
1 ammo point (cell) for The Invoker (RailGun).

Flags:
"big" gives 3 instead of 1
"YOOGE" gives 5
    
Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass base(Ammo) 
    model(
        {{
            spawnflags & 2 ->   ":progs/tb/fragments_2.mdl",
            spawnflags & 1 ->   ":progs/tb/fragments_1.mdl",
                                ":progs/tb/fragments_0.mdl"
        }}
    ) =
    item_cells : "The Invoker, 1/3/5" []
*/
void() item_cells =
{
	if (!SUB_ShouldSpawn()) return;
	
	if (self.spawnflags & ITEM_AMMO_YOOGE)
	{
		self.ammo_cells = 5;
		precache_model_safe ("progs/ammo/fragments_large.mdl");
		setmodel(self, "progs/ammo/fragments_large.mdl");
	}		
	else if (self.spawnflags & ITEM_AMMO_BIG)
	{
		self.ammo_cells = 3;
		precache_model_safe ("progs/ammo/fragments_med.mdl");
		setmodel (self, "progs/ammo/fragments_med.mdl");
	}
	else
	{
		self.ammo_cells = 1;
		precache_model_safe ("progs/ammo/fragments_small.mdl");
		setmodel (self, "progs/ammo/fragments_small.mdl");
	}
	self.weapon = 4;
	self.netname = "fragments";
	StartAmmo();
}



// ================================


// still used in a few id maps, bleh
void() item_weapon =
{
	float WEAPON_SHOTGUN = 1;
	float WEAPON_ROCKET = 2;
	float WEAPON_SPIKES = 4;
	float WEAPON_BIG = 8;
	
	float oldflags;
	oldflags = self.spawnflags & 15;
	self.spawnflags = not(self.spawnflags, 15);
	
	if (oldflags & WEAPON_BIG)
		self.spawnflags = self.spawnflags | ITEM_AMMO_BIG;
	
	if (oldflags & WEAPON_SHOTGUN)
		item_shells();
	else if (oldflags & WEAPON_SPIKES)
		item_spikes();
	else if (oldflags & WEAPON_ROCKET)
		item_rockets();
};