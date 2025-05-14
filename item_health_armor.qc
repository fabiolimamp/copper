/*
=========================================================================

HEALTH BOXES

=========================================================================
*/

float	ITEM_HEALTH_ROTTEN = 1;
float	ITEM_HEALTH_MEGA = 2;


void() health_touch =
{
	if (!CheckValidTouch()) return;
	
	if (!T_Heal(other, self.healamount, (self.spawnflags & ITEM_HEALTH_MEGA)))
		return;

	// coop 1 megahealth brings all other clients up to 100
	entity pl;
	if (coop == 1 && self.spawnflags & ITEM_HEALTH_MEGA)
	{
		pl = get_next_client(other);
		while (pl != other)
		{
			if (T_Heal(pl, 100, FALSE))
			{
				sprint(pl, "You were restored by ");
				sprint(pl, other.netname);
				sprint(pl, "'s Megahealth\n");
				sound(pl, CHAN_ITEM, self.noise, 1, ATTN_NORM);
			}
			pl = get_next_client(pl);
		}
	}

	sound(other, CHAN_ITEM, self.noise, 1, ATTN_NORM);

	ItemTouched();
}	


/*
================================
item_health & item_health_go
split up precaches and business code for late game health spawns
================================
*/
void() item_health_go
{
	self.touch = health_touch;
	self.type = "health";

	if (self.spawnflags & ITEM_HEALTH_ROTTEN)
	{
		setmodel(self, "progs/m_h15.mdl");
		self.noise = "items/r_item1.wav";
		self.healamount = 15;
	}
	else if (self.spawnflags & ITEM_HEALTH_MEGA)
	{
		setmodel(self, "progs/m_h100.mdl");
		self.noise = "items/r_item2.wav";
		self.healamount = 100;
	}
	else
	{
		setmodel(self, "progs/m_h25.mdl");
		self.noise = "items/health1.wav";
		self.healamount = 25;
	}
	setsize (self, '0 0 0', '32 32 56');
	
	if (deathmatch == 1 || deathmatch == 3)
	{
		if (self.spawnflags & ITEM_HEALTH_MEGA)
			// 20 seconds after health <= 100, minimum 25 seconds
			// Copper doesn't handle megahealth the same way, so we can't do that.
			// This is a longer time, picked somewhat arbitrarily.
			// This will be slower than vanilla id1 if you're taking a lot of damage,
			// but faster if you're being relatively safe.
			self.wait = 40;
		else
			self.wait = 20;
	}
		
	StartItem ();
}

// ===============================================================================

/*QUAKED item_health (0 .5 .5) (0 0 0) (32 32 24) SMALL MEGA SUSPENDED 
Health box. Normally gives 25 points.

Flags:
"mega" will add 100 health, then rot you down to your maximum health limit, one point per second
"small" gives 15 points

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass size(0 0 0, 32 32 24) color(0 128 128) base(Item) 
	model(
        {{
            spawnflags & 2 ->   ":maps/b_bh100.bsp",
            spawnflags & 1 ->   ":maps/b_bh10.bsp",
                                ":maps/b_bh25.bsp"
        }}
    ) =
    item_health : "Health pack, +25" 
[
	spawnflags(flags) = 
	[
		1 : "Small, +15" : 0
		2 : "Megahealth, +100" : 0
	]
]
*/
void() item_health =
{	
	if (!SUB_ShouldSpawn()) return;
	if (self.spawnflags & ITEM_HEALTH_MEGA)
	{
		precache_model_safe("progs/m_h100.mdl");
		precache_sound_safe("items/r_item2.wav");
	}
	else if (self.spawnflags & ITEM_HEALTH_ROTTEN)
	{
		precache_model_safe("progs/m_h15.mdl");
		precache_sound_safe("items/r_item1.wav");
	}
	else
	{
		precache_model_safe("progs/m_h25.mdl");
		precache_sound_safe("items/health1.wav");
	}

	item_health_go();
}





/*
===============================================================================

ARMOR

armorvalue = hit point quantity
armortype = 0-1 protection rate

===============================================================================
*/

float ARMORTYPE_RELIQ = 0.5;

/*
============
armor_set_type

coverage derived from last armor grabbed, but drops off to a lower tier below 100 * type
============
*/
void(entity e) armor_set_type =
{
	if (e.classname != "player")
		return;
	
	e.items = not(e.items, (IT_ARMOR2));
	if (!e.armorvalue)
	{
		e.armortype = 0.0;
		return;
	}

	e.items |= IT_ARMOR2;
	
	e.armorvalue = min(e.armorvalue, 500);
}

void() armor_touch =
{
	if (other.classname != "player")
		return;

	if ( !CheckValidTouch() ) return;

	T_GiveArmor(other, self.armorvalue);

	other.items = (other.items |= IT_ARMOR2);

	if (self.cnt == 1)
	{
		sprint(other, "You got an Armor Shard  \b+5\b");
		//sprint(other, "\x92");
		//sprint(other, "\x93");
		sprint(other, "\n");
		sound(other, CHAN_ITEM, "items/armor_shard.wav", 1, ATTN_NORM);
		stuffcmd (other, "bf\n");
	}

	if (self.cnt == 2)
	{
		sprint(other, "You got Light Armor  \b+25\b");
		//sprint(other, "\x92");
		//sprint(other, "\x93");
		sprint(other, "\n");
		sound(other, CHAN_ITEM, "items/armor_light.wav", 1, ATTN_NORM);
		stuffcmd (other, "bf\n");
	}

	if (self.cnt == 3)
	{
		sprint(other, "You got Heavy Armor  \b+100\b");
		//sprint(other, "\x92");
		//sprint(other, "\x93");
		sprint(other, "\n");
		sound(other, CHAN_ITEM, "items/armor_heavy.wav", 1, ATTN_NORM);
		stuffcmd (other, "bf\n");
	}

	ItemTouched();
}

/*QUAKED item_armor_shard (0 .5 .5) (-8 -8 0) (8 8 32) ? ? SUSPENDED
Amror shard, gives 5pts @ 50%, stackable.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass size(-8 -8 0, 8 8 32) color(180 0 180) base(Item) model({ "path": ":progs/item_armor_shard.mdl" }) =
	item_armor_shard : "Amror shard (5pts, 50%, stackble)" []
*/
void() item_armor_shard =
{
	self.touch = armor_touch;
	self.armortype = ARMORTYPE_RELIQ;
	self.armorvalue = 5;
	self.cnt = 1;
	precache_model ("progs/item_armor_shard.mdl");
	setmodel (self, "progs/item_armor_shard.mdl");
	setsize (self, '-8 -8 0', '8 8 32');

	StartItem();
};

/*QUAKED item_armor_light (0 .5 .5) (-16 -16 0) (16 16 32) ? ? SUSPENDED
Light armor, gives 25pts @ 50%, stackable.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass size(-16 -16 0, 16 16 56) color(180 0 180) base(Item) model({ "path": ":progs/item_armor_light.mdl" }) =
	item_armor_light : "Light Amror (25pts, 50%, stackble)" []
*/
void() item_armor_light =
{
	self.touch = armor_touch;
	self.armortype = ARMORTYPE_RELIQ;
	self.armorvalue = 25;
	self.cnt = 2;
	precache_model ("progs/item_armor_light.mdl");
	setmodel (self, "progs/item_armor_light.mdl");
	setsize (self, '-16 -16 0', '16 16 56');

	StartItem();
};

/*QUAKED item_armor_heavy (0 .5 .5) (-16 -16 0) (16 16 32) ? ? SUSPENDED
Heavy armor, gives 100pts @ 50%, stackable.

Keys:
"target/2/3/4/k" - entity to trigger when picked up
"targetname" - will not spawn until triggered
"wait" - will respawn after 'wait' seconds. fires targets every time.
"count" - limit number of times to respawn
*/
/*FGD
@PointClass size(-16 -16 0, 16 16 56) color(180 0 180) base(Item) model({ "path": ":progs/item_armor_heavy.mdl" }) =
	item_armor_heavy : "Heavy armor (100pts, 50%, stackble)" []
*/
void() item_armor_heavy =
{
	self.touch = armor_touch;
	self.armortype = ARMORTYPE_RELIQ;
	self.armorvalue = 100;
	self.cnt = 3;
	precache_model ("progs/item_armor_heavy.mdl");
	setmodel (self, "progs/item_armor_heavy.mdl");
	setsize (self, '-16 -16 0', '16 16 56');

	StartItem();
};

void() item_armor1 =
{
	item_armor_light();
};

void() item_armor2 =
{
	item_armor_heavy();
};

void() item_armorInv =
{
	item_armor_heavy();
};

// ===============================================================================