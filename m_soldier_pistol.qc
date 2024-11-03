/*
==============================================================================

SOLDIER / PLAYER

==============================================================================
*/

$cd id1/models/soldier3
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
SOLDIER CODE
==============================================================================
*/

void()	pistolarmy_stand1	=[	$stand1,	pistolarmy_stand2	] {ai_stand();}
void()	pistolarmy_stand2	=[	$stand2,	pistolarmy_stand3	] {ai_stand();}
void()	pistolarmy_stand3	=[	$stand3,	pistolarmy_stand4	] {ai_stand();}
void()	pistolarmy_stand4	=[	$stand4,	pistolarmy_stand5	] {ai_stand();}
void()	pistolarmy_stand5	=[	$stand5,	pistolarmy_stand6	] {ai_stand();}
void()	pistolarmy_stand6	=[	$stand6,	pistolarmy_stand7	] {ai_stand();}
void()	pistolarmy_stand7	=[	$stand7,	pistolarmy_stand8	] {ai_stand();}
void()	pistolarmy_stand8	=[	$stand8,	pistolarmy_stand1	] {ai_stand();}

void()	pistolarmy_walk1	=[	$prowl_1,	pistolarmy_walk2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "soldier/idle.wav", 1, ATTN_IDLE);
ai_walk(1);}
void()	pistolarmy_walk2	=[	$prowl_2,	pistolarmy_walk3	] {ai_walk(1);}
void()	pistolarmy_walk3	=[	$prowl_3,	pistolarmy_walk4	] {ai_walk(1);}
void()	pistolarmy_walk4	=[	$prowl_4,	pistolarmy_walk5	] {ai_walk(1);}
void()	pistolarmy_walk5	=[	$prowl_5,	pistolarmy_walk6	] {ai_walk(2);}
void()	pistolarmy_walk6	=[	$prowl_6,	pistolarmy_walk7	] {ai_walk(3);}
void()	pistolarmy_walk7	=[	$prowl_7,	pistolarmy_walk8	] {ai_walk(4);}
void()	pistolarmy_walk8	=[	$prowl_8,	pistolarmy_walk9	] {ai_walk(4);}
void()	pistolarmy_walk9	=[	$prowl_9,	pistolarmy_walk10	] {ai_walk(2);}
void()	pistolarmy_walk10	=[	$prowl_10,	pistolarmy_walk11	] {ai_walk(2);}
void()	pistolarmy_walk11	=[	$prowl_11,	pistolarmy_walk12	] {ai_walk(2);}
void()	pistolarmy_walk12	=[	$prowl_12,	pistolarmy_walk13	] {ai_walk(1);}
void()	pistolarmy_walk13	=[	$prowl_13,	pistolarmy_walk14	] {ai_walk(0);}
void()	pistolarmy_walk14	=[	$prowl_14,	pistolarmy_walk15	] {ai_walk(1);}
void()	pistolarmy_walk15	=[	$prowl_15,	pistolarmy_walk16	] {ai_walk(1);}
void()	pistolarmy_walk16	=[	$prowl_16,	pistolarmy_walk17	] {ai_walk(1);}
void()	pistolarmy_walk17	=[	$prowl_17,	pistolarmy_walk18	] {ai_walk(3);}
void()	pistolarmy_walk18	=[	$prowl_18,	pistolarmy_walk19	] {ai_walk(3);}
void()	pistolarmy_walk19	=[	$prowl_19,	pistolarmy_walk20	] {ai_walk(3);}
void()	pistolarmy_walk20	=[	$prowl_20,	pistolarmy_walk21	] {ai_walk(3);}
void()	pistolarmy_walk21	=[	$prowl_21,	pistolarmy_walk22	] {ai_walk(2);}
void()	pistolarmy_walk22	=[	$prowl_22,	pistolarmy_walk23	] {ai_walk(1);}
void()	pistolarmy_walk23	=[	$prowl_23,	pistolarmy_walk24	] {ai_walk(1);}
void()	pistolarmy_walk24	=[	$prowl_24,	pistolarmy_walk1	] {ai_walk(1);}

void()	pistolarmy_run1	=[	$run1,		pistolarmy_run2	] {
if (random() < 0.2 && time > self.show_hostile)
	sound (self, CHAN_VOICE, "soldier/idle.wav", 1, ATTN_IDLE);
ai_run(11);}
void()	pistolarmy_run2	=[	$run2,		pistolarmy_run3	] {ai_run(15);}
void()	pistolarmy_run3	=[	$run3,		pistolarmy_run4	] {ai_run(10);}
void()	pistolarmy_run4	=[	$run4,		pistolarmy_run5	] {ai_run(10);}
void()	pistolarmy_run5	=[	$run5,		pistolarmy_run6	] {ai_run(8);}
void()	pistolarmy_run6	=[	$run6,		pistolarmy_run7	] {ai_run(15);}
void()	pistolarmy_run7	=[	$run7,		pistolarmy_run8	] {ai_run(10);}
void()	pistolarmy_run8	=[	$run8,		pistolarmy_run1	] {ai_run(8);}

void()	pistolarmy_atk1		    =[	$shoot1,	pistolarmy_atk2		    ] {nmfast();ai_face();}
void()	pistolarmy_atk2		    =[	$shoot2,	pistolarmy_atk3		    ] {nmfast();ai_face();}
void()	pistolarmy_atk3		    =[	$shoot3,	pistolarmy_atk4		    ] {nmfast();ai_face(); pistolarmy_aim();}
void()	pistolarmy_atk4		    =[	$shoot4,	pistolarmy_atk5		    ] {nmfast();ai_face(); pistolarmy_fire();}
void()	pistolarmy_atk5		    =[	$shoot2,	pistolarmy_atk6		    ] {nmfast();ai_face();}
void()	pistolarmy_atk6		    =[	$shoot3,	pistolarmy_atk7		    ] {nmfast();ai_face(); pistolarmy_aim();}
void()	pistolarmy_atk7		    =[	$shoot4,	pistolarmy_atk8		    ] {nmfast();ai_face(); pistolarmy_fire();}
void()	pistolarmy_atk8		    =[	$shoot2,	pistolarmy_atk9		    ] {nmfast();ai_face();}
void()	pistolarmy_atk9		    =[	$shoot3,	pistolarmy_atk10		] {nmfast();ai_face(); pistolarmy_aim(); }
void()	pistolarmy_atk10		=[	$shoot4,	pistolarmy_atk11		] {nmfast();ai_face(); pistolarmy_fire();}
void()	pistolarmy_atk11		=[	$shoot2,	pistolarmy_atk12		] {nmfast();ai_face();}
void()	pistolarmy_atk12		=[	$shoot3,	pistolarmy_atk13		] {nmfast();ai_face();}
void()	pistolarmy_atk13	    =[	$shoot4,	pistolarmy_atk14        ] {ai_face();}
void()	pistolarmy_atk14	    =[	$shoot7,	pistolarmy_atk15        ] {ai_face(); ai_check_refire (pistolarmy_atk3);}
void()	pistolarmy_atk15	    =[	$shoot8,	pistolarmy_atk16        ] {ai_face(); ai_attack_finished (0.3 + random() + random());}
void()	pistolarmy_atk16	    =[	$shoot9,	pistolarmy_run1	        ] {ai_face();}


void()	pistolarmy_pain1	=[	$pain1,		pistolarmy_pain2	] {}
void()	pistolarmy_pain2	=[	$pain2,		pistolarmy_pain3	] {}
void()	pistolarmy_pain3	=[	$pain3,		pistolarmy_pain4	] {}
void()	pistolarmy_pain4	=[	$pain4,		pistolarmy_pain5	] {}
void()	pistolarmy_pain5	=[	$pain5,		pistolarmy_pain6	] {}
void()	pistolarmy_pain6	=[	$pain6,		pistolarmy_run1	] {ai_pain(1);}

void()	pistolarmy_painb1	=[	$painb1,	pistolarmy_painb2	] {}
void()	pistolarmy_painb2	=[	$painb2,	pistolarmy_painb3	] {ai_painforward(13);}
void()	pistolarmy_painb3	=[	$painb3,	pistolarmy_painb4	] {ai_painforward(9);}
void()	pistolarmy_painb4	=[	$painb4,	pistolarmy_painb5	] {}
void()	pistolarmy_painb5	=[	$painb5,	pistolarmy_painb6	] {}
void()	pistolarmy_painb6	=[	$painb6,	pistolarmy_painb7	] {}
void()	pistolarmy_painb7	=[	$painb7,	pistolarmy_painb8	] {}
void()	pistolarmy_painb8	=[	$painb8,	pistolarmy_painb9	] {}
void()	pistolarmy_painb9	=[	$painb9,	pistolarmy_painb10] {}
void()	pistolarmy_painb10=[	$painb10,	pistolarmy_painb11] {}
void()	pistolarmy_painb11=[	$painb11,	pistolarmy_painb12] {}
void()	pistolarmy_painb12=[	$painb12,	pistolarmy_painb13] {ai_pain(2);}
void()	pistolarmy_painb13=[	$painb13,	pistolarmy_painb14] {}
void()	pistolarmy_painb14=[	$painb14,	pistolarmy_run1	] {}

void()	pistolarmy_painc1	=[	$painc1,	pistolarmy_painc2	] {}
void()	pistolarmy_painc2	=[	$painc2,	pistolarmy_painc3	] {ai_pain(1);}
void()	pistolarmy_painc3	=[	$painc3,	pistolarmy_painc4	] {}
void()	pistolarmy_painc4	=[	$painc4,	pistolarmy_painc5	] {}
void()	pistolarmy_painc5	=[	$painc5,	pistolarmy_painc6	] {ai_painforward(1);}
void()	pistolarmy_painc6	=[	$painc6,	pistolarmy_painc7	] {ai_painforward(1);}
void()	pistolarmy_painc7	=[	$painc7,	pistolarmy_painc8	] {}
void()	pistolarmy_painc8	=[	$painc8,	pistolarmy_painc9	] {ai_pain(1);}
void()	pistolarmy_painc9	=[	$painc9,	pistolarmy_painc10] {ai_painforward(4);}
void()	pistolarmy_painc10=[	$painc10,	pistolarmy_painc11] {ai_painforward(3);}
void()	pistolarmy_painc11=[	$painc11,	pistolarmy_painc12] {ai_painforward(6);}
void()	pistolarmy_painc12=[	$painc12,	pistolarmy_painc13] {ai_painforward(8);}
void()	pistolarmy_painc13=[	$painc13,	pistolarmy_run1] {}

void(entity attacker, float damage)	pistolarmy_pain =
{
	local float r;
	
	if (self.pain_finished > time)
		return;

	r = random();

	if (r < 0.2)
	{
		PainFinished(0.6);
		pistolarmy_pain1 ();
		sound (self, CHAN_VOICE, "soldier/pain1.wav", 1, ATTN_NORM);
	}
	else if (r < 0.6)
	{
		PainFinished(1.1);
		pistolarmy_painb1 ();
		sound (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
	else
	{
		PainFinished(1.1);
		pistolarmy_painc1 ();
		sound (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
}

/*
vanilla grunts pretend to lag their shots by applying negative leading based
on player velocity. SV_PushMove only sets origins per hostframe and doesn't 
modify velocities, so a player standing on a train or a lift will have zero 
velocity and get drilled constantly. (see: SMEJ w1m1)

grunts now choose an aim vector 0.3 seconds before firing, rather than trying 
to work 0.2 seconds backwards at firing time
*/
void() pistolarmy_aim =
{
	// store it relative to self in case we're riding the same mover as our target
	self.dest = enemy_vispos() + enemy_aim_vertical() - self.origin;
}

void() pistolarmy_fire =
{
	local	vector	dir;
	
	ai_face();
	self.effects = self.effects | EF_MUZZLEFLASH;	
	sound (self, CHAN_WEAPON, "soldier/sattck1.wav", 1, ATTN_NORM);	

// fire somewhat behind the player, so a dodging player is harder to hit
//	dir = enemy_vispos() - self.enemy.velocity*0.2;
//	dir = normalize (dir - self.origin);
	dir = normalize (self.dest);

	// lunaran: moved multidamage here
	ClearMultiDamage ();
	FireBullets (4, dir, '0.1 0.1 0');
	ApplyMultiDamage ();
}


/*
===========
PistolSoldierCheckAttack

The player is in view, so decide to move or launch an attack
Returns FALSE if movement should continue
============
*/
float() PistolSoldierCheckAttack =
{
	local float		chance;

	if (time < self.attack_finished)
		return FALSE;
		
	if (enemy_range >= RANGE_FAR)
		return FALSE;
		
	if (!CheckClearAttack()) return FALSE;

	// missile attack
	
	if (enemy_range <= RANGE_MELEE)
		chance = 0.9;
	else if (enemy_range == RANGE_NEAR)
		chance = 0.4;
	else if (enemy_range == RANGE_MID)
		chance = 0.05;
	else
		chance = 0;

	if (random () < chance)
	{
		self.attack_state = AS_MISSILE;
		ai_attack_finished (1 + random() + random());
		return TRUE;
	}

	return FALSE;
}
//=============================================================================


void()	pistolarmy_die1	=[	$death1,	pistolarmy_die2	] {pistolarmy_checkgib();}
void()	pistolarmy_die2	=[	$death2,	pistolarmy_die3	] {pistolarmy_checkgib();}
void()	pistolarmy_die3	=[	$death3,	pistolarmy_die4	]
{if (pistolarmy_checkgib()) return;
self.solid = SOLID_NOT;self.takedamage = DAMAGE_NO; self.ammo_shells = 4;DropBackpack();} //FlakTax
void()	pistolarmy_die4	=[	$death4,	pistolarmy_die5	] {}
void()	pistolarmy_die5	=[	$death5,	pistolarmy_die6	] {}
void()	pistolarmy_die6	=[	$death6,	pistolarmy_die7	] {}
void()	pistolarmy_die7	=[	$death7,	pistolarmy_die8	] {}
void()	pistolarmy_die8	=[	$death8,	pistolarmy_die9	] {}
void()	pistolarmy_die9	=[	$death9,	pistolarmy_die10	] {}
void()	pistolarmy_die10	=[	$death10,	SUB_Null	] {}

void()	pistolarmy_cdie1	=[	$deathc1,	pistolarmy_cdie2	] {}
void()	pistolarmy_cdie2	=[	$deathc2,	pistolarmy_cdie3	] {ai_back(5);}
void()	pistolarmy_cdie3	=[	$deathc3,	pistolarmy_cdie4	]
{self.solid = SOLID_NOT;self.ammo_shells = 4;DropBackpack();ai_back(4);} //FlakTax
void()	pistolarmy_cdie4	=[	$deathc4,	pistolarmy_cdie5	] {ai_back(13);}
void()	pistolarmy_cdie5	=[	$deathc5,	pistolarmy_cdie6	] {ai_back(3);}
void()	pistolarmy_cdie6	=[	$deathc6,	pistolarmy_cdie7	] {ai_back(4);}
void()	pistolarmy_cdie7	=[	$deathc7,	pistolarmy_cdie8	] {}
void()	pistolarmy_cdie8	=[	$deathc8,	pistolarmy_cdie9	] {}
void()	pistolarmy_cdie9	=[	$deathc9,	pistolarmy_cdie10	] {}
void()	pistolarmy_cdie10	=[	$deathc10,	pistolarmy_cdie11	] {}
void()	pistolarmy_cdie11	=[	$deathc11,	SUB_Null	] {}

float() pistolarmy_checkgib =
{	
	if (self.health < -35)
	{
		Gib("progs/h_guard.mdl", self.health);
		self.ammo_shells = 4; //FlakTax
		DropBackpack();
		return TRUE;
	}
	return FALSE;
}

void() pistolarmy_die =
{
// check for gib
	if (pistolarmy_checkgib())
		return;

// regular death
	sound (self, CHAN_VOICE, "soldier/death1.wav", 1, ATTN_NORM);
	if (random() < 0.5)
		pistolarmy_die1 ();
	else
		pistolarmy_cdie1 ();
}

void() monster_pistolarmy_spawn =
{
	self.classname = "monster_army";
	
	self.solid = SOLID_SLIDEBOX;
	//self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/soldier.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');
	self.health = 35;

	self.th_stand = pistolarmy_stand1;
	self.th_walk = pistolarmy_walk1;
	self.th_run = pistolarmy_run1;
	self.th_missile = pistolarmy_atk1;
	self.th_pain = pistolarmy_pain;
	self.th_die = pistolarmy_die;
	self.th_checkattack = PistolSoldierCheckAttack;

	if (self.deathtype == string_null)
		self.deathtype = "was shot by a Grunt";

	walkmonster_start ();
}

void() monster_pistolarmy_spawner = {mon_spawner_use(monster_pistolarmy_spawn);}

/*QUAKED monster_army_pistol (1 0 0) (-16 -16 -24) (16 16 40) AMBUSH ? ? ? TRIGGERED NOTFOG NOTELEFRAG INSTAWAKE
Pistol Grunt, 30 health points.

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
@PointClass base(Monster) size(-16 -16 -24, 16 16 40) model({ "path": ":progs/soldier.mdl" }) = monster_army_pistol : "Pistol Grunt" []
*/
void() monster_army_pistol =
{	
	if (!SUB_ShouldSpawn()) return;
	if (nomonster()) return;
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model ("progs/soldier.mdl");
	precache_model ("progs/h_guard.mdl");
	precache_model ("progs/gib1.mdl");
	precache_model ("progs/gib2.mdl");
	precache_model ("progs/gib3.mdl");

	precache_sound ("soldier/death1.wav");
	precache_sound ("soldier/idle.wav");
	precache_sound ("soldier/pain1.wav");
	precache_sound ("soldier/pain2.wav");
	precache_sound ("soldier/sattck1.wav");
	precache_sound ("soldier/sight1.wav");

	precache_sound ("player/udeath.wav");		// gib death
	self.health = 35;

	setsize (self, '-16 -16 -24', '16 16 40');
	if ( monster_spawnsetup( monster_pistolarmy_spawner ) ) return;
	
	addmonster(1);
	monster_pistolarmy_spawn();
}
