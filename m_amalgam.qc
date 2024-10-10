/*
==============================================================================

AMALGAM
Originally from reliq
by Fairweather

==============================================================================
*/

$cd id1/models/toothy3
$origin 0 -6 24
$base base		
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11

$frame load1 load2 load3 load4 load5 load6 load7 load8 load9 load10 load11

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9 painb10
$frame painb11 painb12 painb13 painb14

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 painc8 painc9 painc10
$frame painc11 painc12 painc13

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame shoot1 shoot2 shoot3 shoot4 shoot5 shoot6 shoot7 shoot8 shoot9

$frame prowl_1 prowl_2 prowl_3 prowl_4 prowl_5 prowl_6 prowl_7 prowl_8
$frame prowl_9 prowl_10 prowl_11 prowl_12 prowl_13 prowl_14 prowl_15 prowl_16
$frame prowl_17 prowl_18 prowl_19 prowl_20 prowl_21 prowl_22 prowl_23 prowl_24

/*
==============================================================================
toothy CODE
==============================================================================
*/

void()	amalgam_stand1	=[	$stand1,	amalgam_stand2	] {ai_stand();}
void()	amalgam_stand2	=[	$stand2,	amalgam_stand3	] {ai_stand();}
void()	amalgam_stand3	=[	$stand3,	amalgam_stand4	] {ai_stand();}
void()	amalgam_stand4	=[	$stand4,	amalgam_stand5	] {ai_stand();}
void()	amalgam_stand5	=[	$stand5,	amalgam_stand6	] {ai_stand();}
void()	amalgam_stand6	=[	$stand6,	amalgam_stand7	] {ai_stand();}
void()	amalgam_stand7	=[	$stand7,	amalgam_stand8	] {ai_stand();}
void()	amalgam_stand8	=[	$stand8,	amalgam_stand1	] {ai_stand();}

void()	amalgam_walk1	=[	$prowl_1,	amalgam_walk2	] {
if (random() < 0.4)
	sound (self, CHAN_VOICE, "amalg/amalgidle.wav", 1, ATTN_IDLE);
ai_walk(1);}
void()	amalgam_walk2	=[	$prowl_2,	amalgam_walk3	] {ai_walk(1);}
void()	amalgam_walk3	=[	$prowl_3,	amalgam_walk4	] {ai_walk(1);}
void()	amalgam_walk4	=[	$prowl_4,	amalgam_walk5	] {ai_walk(1);}
void()	amalgam_walk5	=[	$prowl_5,	amalgam_walk6	] {ai_walk(2);}
void()	amalgam_walk6	=[	$prowl_6,	amalgam_walk7	] {ai_walk(3);}
void()	amalgam_walk7	=[	$prowl_7,	amalgam_walk8	] {ai_walk(4);}
void()	amalgam_walk8	=[	$prowl_8,	amalgam_walk9	] {ai_walk(4);}
void()	amalgam_walk9	=[	$prowl_9,	amalgam_walk10	] {ai_walk(2);}
void()	amalgam_walk10	=[	$prowl_10,	amalgam_walk11	] {ai_walk(2);}
void()	amalgam_walk11	=[	$prowl_11,	amalgam_walk12	] {ai_walk(2);}
void()	amalgam_walk12	=[	$prowl_12,	amalgam_walk13	] {ai_walk(1);}
void()	amalgam_walk13	=[	$prowl_13,	amalgam_walk14	] {ai_walk(0);}
void()	amalgam_walk14	=[	$prowl_14,	amalgam_walk15	] {ai_walk(1);}
void()	amalgam_walk15	=[	$prowl_15,	amalgam_walk16	] {ai_walk(1);}
void()	amalgam_walk16	=[	$prowl_16,	amalgam_walk17	] {ai_walk(1);}
void()	amalgam_walk17	=[	$prowl_17,	amalgam_walk18	] {ai_walk(3);}
void()	amalgam_walk18	=[	$prowl_18,	amalgam_walk19	] {ai_walk(3);}
void()	amalgam_walk19	=[	$prowl_19,	amalgam_walk20	] {ai_walk(3);}
void()	amalgam_walk20	=[	$prowl_20,	amalgam_walk21	] {ai_walk(3);}
void()	amalgam_walk21	=[	$prowl_21,	amalgam_walk22	] {ai_walk(2);}
void()	amalgam_walk22	=[	$prowl_22,	amalgam_walk23	] {ai_walk(1);}
void()	amalgam_walk23	=[	$prowl_23,	amalgam_walk24	] {ai_walk(1);}
void()	amalgam_walk24	=[	$prowl_24,	amalgam_walk1	] {ai_walk(1);}

void()	amalgam_run1	=[	$run1,		amalgam_run2	] {
if (random() < 0.4 && time > self.show_hostile)
	sound (self, CHAN_VOICE, "amalg/amalgidle.wav", 1, ATTN_IDLE);
ai_run(11);}
void()	amalgam_run2	=[	$run2,		amalgam_run3	] {ai_run(15);}
void()	amalgam_run3	=[	$run3,		amalgam_run4	] {ai_run(10);}
void()	amalgam_run4	=[	$run4,		amalgam_run5	] {ai_run(10);}
void()	amalgam_run5	=[	$run5,		amalgam_run6	] {ai_run(8);}
void()	amalgam_run6	=[	$run6,		amalgam_run7	] {ai_run(15);}
void()	amalgam_run7	=[	$run7,		amalgam_run8	] {ai_run(10);}
void()	amalgam_run8	=[	$run8,		amalgam_run1	] {ai_run(8);}

void()	amalgam_atk1	=[	$shoot2,	amalgam_atk2	] {ai_face();}
void()	amalgam_atk2	=[	$shoot3,	amalgam_atk3	] {ai_face();}
void()	amalgam_atk3	=[	$shoot4,	amalgam_atk4	] {ai_face();}
void()	amalgam_atk4	=[	$shoot5,	amalgam_atk5	] {ai_face();}
void()	amalgam_atk5	=[	$shoot6,	amalgam_atk6	] {ai_face();}
void()	amalgam_atk6	=[	$shoot7,	amalgam_atk7	] {ai_face();}
void()	amalgam_atk7	=[	$shoot6,	amalgam_atk8	] {ai_face();}
void()	amalgam_atk8	=[	$shoot7,	amalgam_atk9	] {ai_face(); amalgam_fire();}
void()	amalgam_atk9	=[	$shoot6,	amalgam_atk10	] {ai_face(); amalgam_fire(); amalgam_fire();}
void()	amalgam_atk10	=[	$shoot7,	amalgam_atk11	] {ai_face(); amalgam_fire();}
void()	amalgam_atk11	=[	$shoot6,	amalgam_atk12	] {ai_face(); amalgam_fire(); amalgam_fire();}
void()	amalgam_atk12	=[	$shoot7,	amalgam_run1	] {ai_face();}


void()	amalgam_pain1	=[	$pain1,		amalgam_pain2	] {}
void()	amalgam_pain2	=[	$pain2,		amalgam_pain3	] {}
void()	amalgam_pain3	=[	$pain3,		amalgam_pain4	] {}
void()	amalgam_pain4	=[	$pain4,		amalgam_run1	] {}

void()	amalgam_painb1	=[	$painb1,	amalgam_painb2	] {}
void()	amalgam_painb2	=[	$painb2,	amalgam_painb3	] {ai_painforward(13);}
void()	amalgam_painb3	=[	$painb3,	amalgam_painb4	] {ai_painforward(9);}
void()	amalgam_painb4	=[	$painb4,	amalgam_painb5	] {}
void()	amalgam_painb5	=[	$painb5,	amalgam_painb6	] {}
void()	amalgam_painb6	=[	$painb6,	amalgam_run1	] {}

void(entity attacker, float damage)	amalgam_pain =
{
	local float r;
	
	if (self.pain_finished > time)
		return;

	r = random();

	if (random() > 0.8)
	{
		if (r >= 0.5)
		{
			PainFinished(3);
			AmalGoop_Spam(5);
			amalgam_pain1 ();
		}
		else if (r < 0.5)
		{
			PainFinished(3);
			AmalGoop_Spam(5);
			amalgam_painb1 ();
		}
	}

	if (r >= 0.5)
		sound (self, CHAN_VOICE, "amalg/amalgpain1.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_VOICE, "amalg/amalgpain2.wav", 1, ATTN_NORM);
}

void() amalgam_fire =
{
	local	entity goop;
	vector gorg, gvel;
	
	self.effects = self.effects | EF_MUZZLEFLASH;
	sound (self, CHAN_WEAPON, "amalg/amalgshoot.wav", 1, ATTN_NORM);

	// set grenade speed	
	makevectors (self.angles);
	gorg = self.origin + v_forward * 16;
	gvel = OgreAimGrenade(enemy_vispos() - gorg, 432 + (random() * 200), -15 + random() * 45);

    goop = toss_projectile(gorg, gvel, "goop");
	goop.solid = SOLID_TRIGGER;
	goop.movetype = MOVETYPE_TOSS;
	goop.classname = "AmalGoop";
	setmodel (goop, "progs/proj_amalgoop.mdl");
	setsize (goop, '0 0 0', '0 0 0');
	goop.angles_y = (random() * (random() * 256));

	goop.touch = AmalGoop_Touch;
	goop.think = SUB_Remove;
	goop.nextthink = time + 15;
}

/*
===========
AmalgamCheckAttack

The player is in view, so decide to move or launch an attack
Returns FALSE if movement should continue
============
*/
float() AmalgamCheckAttack =
{
	local float		chance;

	if (time < self.attack_finished)
		return FALSE;
		
	if (enemy_range >= RANGE_FAR)
		return FALSE;
		
	if (!CheckClearAttack()) return FALSE;

	// missile attack
	if (enemy_range == RANGE_MELEE)
		chance = 0.9;
	else if (enemy_range == RANGE_NEAR)
		chance = 0.7;
	else if (enemy_range == RANGE_MID)
		chance = 0.3;
	else
		chance = 0;

	if (random () < chance)
	{
		self.th_missile ();
		ai_attack_finished (2 + random());
		return TRUE;
	}

	return FALSE;
}
//=============================================================================


void()	amalgam_die1	=[	$death1,	amalgam_die2	] {self.movetype = MOVETYPE_NONE;}
void()	amalgam_die2	=[	$death2,	amalgam_die3	] {}
void()	amalgam_die3	=[	$death3,	amalgam_die4	] {}
void()	amalgam_die4	=[	$death4,	amalgam_die5	] {}
void()	amalgam_die5	=[	$death9,	amalgam_die6	] {}
void()	amalgam_die6	=[	$death10,	amalgam_die7	] {}
void()	amalgam_die7	=[	$death1,	amalgam_die8	] {}
void()	amalgam_die8	=[	$death2,	amalgam_die9	] {}
void()	amalgam_die9	=[	$death3,	amalgam_die10	] {}
void()	amalgam_die10	=[	$death4,	amalgam_die11	] {}
void()	amalgam_die11	=[	$death4,	amalgam_die12	] {}
void()	amalgam_die12	=[	$death5,	amalgam_die13	] {AmalGoop_Spam(1); GibSpray("NULL", -75);}
void()	amalgam_die13	=[	$death6,	amalgam_die14	] {AmalGoop_Spam(1); }
void()	amalgam_die14	=[	$death7,	amalgam_die15	] {AmalGoop_Spam(1); }
void()	amalgam_die15	=[	$death8,	amalgam_die16	] {AmalGoop_Spam(2); }
void()	amalgam_die16	=[	$death9,	amalgam_die17	] {AmalGoop_Spam(2); GibSpray("NULL", -100);}
void()	amalgam_die17	=[	$death10,	SUB_Null		] {GoopBlood(1); remove(self);}

void(float drop_count) AmalGoop_Spam =
{
	float i;

    while(i < drop_count)
    {
        AmalGoop_Drop();
        i++;
    }
}

void() AmalGoop_Drop =
{
	entity item;

	item = spawn();
	item.origin = self.origin + '0 0 24';

	item.velocity_z = 300 + (random() * 100);
	item.velocity_x = crandom() * 300;
	item.velocity_y = crandom() * 300;
	
	item.flags = FL_ITEM;
	item.solid = SOLID_TRIGGER;
	item.movetype = MOVETYPE_TOSS;
	item.classname = "AmalGoop";
	setmodel (item, "progs/proj_amalgoop.mdl");
	setsize (item, '0 0 0', '0 0 0');
	item.angles_y = (random() * (random() * 256));

	sound (self, CHAN_WEAPON, "amalg/amalgshoot.wav", .5, ATTN_NORM);

	item.touch = AmalGoop_Touch;
	item.think = SUB_Remove;
	item.nextthink = time + 20;
}

void() AmalGoop_Touch =
{
	local float played_tink;

	if (!played_tink) {
		sound (self, CHAN_BODY, "weapons/tink1.wav", 1, ATTN_STATIC);
		played_tink = 1;
	}

	if (!CheckValidTouch()) return;
	if (other.flags & FL_MONSTER) return;
	if (self.attack_finished > time) return;

	T_Damage(other, self.owner, self, 8);

	if (random() > .5)
		sound(self, CHAN_VOICE, "amalg/amalg_goop1.wav", .6, ATTN_NORM);
	else
		sound(self, CHAN_VOICE, "amalg/amalg_goop2.wav", .6, ATTN_NORM);

	GoopBlood(0);
	remove(self); //change this to an animation l8r
}

//this blood sprite stuff is by Kebby
//thanks Kebby! - fw
void(float forcebig) GoopBlood =
{
	entity spark = spawn();
	spark.think = x_blood_01;
	spark.touch = SUB_Null;
	spark.nextthink = time;

	if ((random() < .3) || (forcebig == 1))
		setmodel (spark, "progs/s_blood_128x.spr");
	else if (random() < .5)
		setmodel (spark, "progs/s_blood_96x.spr");
	else
		setmodel (spark, "progs/s_blood_64x.spr");

	setorigin (spark, self.origin + '0 0 16');
}
void() x_blood_01 = {                 snt(0.025); self.think = x_blood_02;};
void() x_blood_02 = {self.frame += 1; snt(0.025); self.think = x_blood_03;};
void() x_blood_03 = {self.frame += 1; snt(0.025); self.think = x_blood_04;};
void() x_blood_04 = {self.frame += 1; snt(0.025); self.think = x_blood_05;};
void() x_blood_05 = {self.frame += 1; snt(0.025); self.think = x_blood_06;};
void() x_blood_06 = {self.frame += 1; snt(0.05); self.think = x_blood_07;};
void() x_blood_07 = {self.frame += 1; snt(0.05); self.think = x_blood_08;};
void() x_blood_08 = {self.frame += 1; snt(0.05); self.think = x_blood_09;};
void() x_blood_09 = {self.frame += 1; snt(0.05); self.think = x_blood_10;};
void() x_blood_10 = {self.frame += 1; snt(0.05); self.think = x_blood_11;};
void() x_blood_11 = {self.frame += 1; snt(0.05); self.think = x_blood_12;};
void() x_blood_12 = {self.frame += 1; snt(0.05); self.think = x_blood_13;};
void() x_blood_13 = {self.frame += 1; snt(0.05); self.think = x_blood_14;};
void() x_blood_14 = {self.frame += 1; snt(0.05); self.think = x_blood_15;};
void() x_blood_15 = {self.frame += 1; snt(0.05); self.think = SUB_Remove;};

void(float float_think) snt = {self.nextthink = time + float_think;};		//	snt();
//the keb stops here!

void() amalgam_die =
{
	sound (self, CHAN_VOICE, "amalg/amalgdeath.wav", 1, ATTN_NORM);
	self.takedamage = DAMAGE_NO;
	amalgam_die1 ();
}

void() monster_amalgam_spawn =
{
	self.classname = "monster_amalgam";
	
	self.solid = SOLID_SLIDEBOX;
	//self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/toothy.mdl");

	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = 400;

	self.th_stand = amalgam_stand1;
	self.th_walk = amalgam_walk1;
	self.th_run = amalgam_run1;
	self.th_missile = amalgam_atk1;
	self.th_pain = amalgam_pain;
	self.th_die = amalgam_die;
	self.th_checkattack = AmalgamCheckAttack;

	if (self.deathtype == string_null)
		self.deathtype = "was shlorped by the Amalgam";

    flymonster_start ();
}

void() monster_amalgam_spawner = {mon_spawner_use(monster_amalgam_spawn);}

/*QUAKED monster_amalgam (1 0 0) (-16 -16 -24) (16 16 40) AMBUSH ? ? ? TRIGGERED NOTFOG NOTELEFRAG INSTAWAKE
Amalgam, 60 health points.

Flags:
"ambush" only wake up on seeing the player, not another monster getting angry

"Triggered"	will not spawn until triggered - triggering again will wake him up. Set 'count' to make this a multi-use spawner.
"NoTfog" 	supress teleport glitter when spawned with 'triggered'
"NoTelefrag" will silently fail to spawn if doing so would telefrag an existing monster. will try again automatically 2x/second until it succeeds.
"Instawake" spawn angry at activator

Keys:
"target" entity to trigger when killed
"targetname" entity name
"movedir" set to a velocity to make the monster jump on awakening
*/
/*FGD
@PointClass base(Monster) size(-16 -16 -24, 16 16 40) model({ "path": ":progs/toothy.mdl" }) = monster_amalgam : "Amalgam" []
*/
void() monster_amalgam =
{	
	if (!SUB_ShouldSpawn()) return;
	if (nomonster()) return;
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model ("progs/toothy.mdl");
	precache_model ("progs/h_guard.mdl");
	precache_model ("progs/gib1.mdl");
	precache_model ("progs/gib2.mdl");
	precache_model ("progs/gib3.mdl");

	precache_model ("progs/proj_amalgoop.mdl");
	precache_sound ("amalg/amalg_goop1.wav");
	precache_sound ("amalg/amalg_goop2.wav");

	precache_sound ("amalg/amalgdeath.wav");
	precache_sound ("amalg/amalgidle.wav");
	precache_sound ("amalg/amalgpain1.wav");
	precache_sound ("amalg/amalgpain2.wav");
	precache_sound ("amalg/amalgshoot.wav");
	precache_sound ("amalg/amalgsight.wav");

	precache_model ("progs/s_blood_128x.spr");
	precache_model ("progs/s_blood_96x.spr");
	precache_model ("progs/s_blood_64x.spr");
	self.health = 400;

	setsize (self, '-32 -32 -32', '32 32 72');
	if ( monster_spawnsetup( monster_amalgam_spawner ) ) return;
	
	addmonster(1);
	monster_amalgam_spawn();
}
