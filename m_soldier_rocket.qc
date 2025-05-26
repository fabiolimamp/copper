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

void()	rocketarmy_stand1	=[	$stand1,	rocketarmy_stand2	] {ai_stand();}
void()	rocketarmy_stand2	=[	$stand2,	rocketarmy_stand3	] {ai_stand();}
void()	rocketarmy_stand3	=[	$stand3,	rocketarmy_stand4	] {ai_stand();}
void()	rocketarmy_stand4	=[	$stand4,	rocketarmy_stand5	] {ai_stand();}
void()	rocketarmy_stand5	=[	$stand5,	rocketarmy_stand6	] {ai_stand();}
void()	rocketarmy_stand6	=[	$stand6,	rocketarmy_stand7	] {ai_stand();}
void()	rocketarmy_stand7	=[	$stand7,	rocketarmy_stand8	] {ai_stand();}
void()	rocketarmy_stand8	=[	$stand8,	rocketarmy_stand1	] {ai_stand();}

void()	rocketarmy_walk1	=[	$prowl_1,	rocketarmy_walk2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "soldier/idle.wav", 1, ATTN_IDLE);
ai_walk(1);}
void()	rocketarmy_walk2	=[	$prowl_2,	rocketarmy_walk3	] {ai_walk(1);}
void()	rocketarmy_walk3	=[	$prowl_3,	rocketarmy_walk4	] {ai_walk(1);}
void()	rocketarmy_walk4	=[	$prowl_4,	rocketarmy_walk5	] {ai_walk(1);}
void()	rocketarmy_walk5	=[	$prowl_5,	rocketarmy_walk6	] {ai_walk(2);}
void()	rocketarmy_walk6	=[	$prowl_6,	rocketarmy_walk7	] {ai_walk(3);}
void()	rocketarmy_walk7	=[	$prowl_7,	rocketarmy_walk8	] {ai_walk(4);}
void()	rocketarmy_walk8	=[	$prowl_8,	rocketarmy_walk9	] {ai_walk(4);}
void()	rocketarmy_walk9	=[	$prowl_9,	rocketarmy_walk10	] {ai_walk(2);}
void()	rocketarmy_walk10	=[	$prowl_10,	rocketarmy_walk11	] {ai_walk(2);}
void()	rocketarmy_walk11	=[	$prowl_11,	rocketarmy_walk12	] {ai_walk(2);}
void()	rocketarmy_walk12	=[	$prowl_12,	rocketarmy_walk13	] {ai_walk(1);}
void()	rocketarmy_walk13	=[	$prowl_13,	rocketarmy_walk14	] {ai_walk(0);}
void()	rocketarmy_walk14	=[	$prowl_14,	rocketarmy_walk15	] {ai_walk(1);}
void()	rocketarmy_walk15	=[	$prowl_15,	rocketarmy_walk16	] {ai_walk(1);}
void()	rocketarmy_walk16	=[	$prowl_16,	rocketarmy_walk17	] {ai_walk(1);}
void()	rocketarmy_walk17	=[	$prowl_17,	rocketarmy_walk18	] {ai_walk(3);}
void()	rocketarmy_walk18	=[	$prowl_18,	rocketarmy_walk19	] {ai_walk(3);}
void()	rocketarmy_walk19	=[	$prowl_19,	rocketarmy_walk20	] {ai_walk(3);}
void()	rocketarmy_walk20	=[	$prowl_20,	rocketarmy_walk21	] {ai_walk(3);}
void()	rocketarmy_walk21	=[	$prowl_21,	rocketarmy_walk22	] {ai_walk(2);}
void()	rocketarmy_walk22	=[	$prowl_22,	rocketarmy_walk23	] {ai_walk(1);}
void()	rocketarmy_walk23	=[	$prowl_23,	rocketarmy_walk24	] {ai_walk(1);}
void()	rocketarmy_walk24	=[	$prowl_24,	rocketarmy_walk1	] {ai_walk(1);}

void()	rocketarmy_run1	=[	$run1,		rocketarmy_run2	] {
if (random() < 0.2 && time > self.show_hostile)
	sound (self, CHAN_VOICE, "soldier/idle.wav", 1, ATTN_IDLE);
nmfast(); ai_run(11);}
void()	rocketarmy_run2	=[	$run2,		rocketarmy_run3	] {nmfast(); ai_run(15);}
void()	rocketarmy_run3	=[	$run3,		rocketarmy_run4	] {nmfast(); ai_run(10);}
void()	rocketarmy_run4	=[	$run4,		rocketarmy_run5	] {nmfast(); ai_run(10);}
void()	rocketarmy_run5	=[	$run5,		rocketarmy_run6	] {nmfast(); ai_run(8);}
void()	rocketarmy_run6	=[	$run6,		rocketarmy_run7	] {nmfast(); ai_run(15);}
void()	rocketarmy_run7	=[	$run7,		rocketarmy_run8	] {nmfast(); ai_run(10);}
void()	rocketarmy_run8	=[	$run8,		rocketarmy_run1	] {nmfast(); ai_run(8);}

void()	rocketarmy_atk1	=[	$shoot1,	rocketarmy_atk2	] {nmfast();ai_face();}
void()	rocketarmy_atk2	=[	$shoot2,	rocketarmy_atk3	] {nmfast();ai_face();}
void()	rocketarmy_atk3	=[	$shoot3,	rocketarmy_atk4	] {nmfast();ai_face(); rocketarmy_aim(); }
void()	rocketarmy_atk4	=[	$shoot4,	rocketarmy_atk5	] {nmfast();ai_face();}
void()	rocketarmy_atk5	=[	$shoot5,	rocketarmy_atk6	] {nmfast();ai_face(); rocketarmy_fire(); }
void()	rocketarmy_atk6	=[	$shoot6,	rocketarmy_atk7	] {nmfast(); ai_face();}
void()	rocketarmy_atk7	=[	$shoot7,	rocketarmy_atk8	] {nmfast(); ai_face();}
void()	rocketarmy_atk8	=[	$shoot8,	rocketarmy_atk9	] {nmfast(); ai_face(); ai_attack_finished (0.3 + random() + random());}
void()	rocketarmy_atk9	=[	$shoot9,	rocketarmy_run1	] {nmfast(); ai_face();}


void()	rocketarmy_pain1	=[	$pain1,		rocketarmy_pain2	] {}
void()	rocketarmy_pain2	=[	$pain2,		rocketarmy_pain3	] {}
void()	rocketarmy_pain3	=[	$pain3,		rocketarmy_pain4	] {}
void()	rocketarmy_pain4	=[	$pain4,		rocketarmy_pain5	] {}
void()	rocketarmy_pain5	=[	$pain5,		rocketarmy_pain6	] {}
void()	rocketarmy_pain6	=[	$pain6,		rocketarmy_run1	] {ai_pain(1);}

void()	rocketarmy_painb1	=[	$painb1,	rocketarmy_painb2	] {}
void()	rocketarmy_painb2	=[	$painb2,	rocketarmy_painb3	] {ai_painforward(13);}
void()	rocketarmy_painb3	=[	$painb3,	rocketarmy_painb4	] {ai_painforward(9);}
void()	rocketarmy_painb4	=[	$painb4,	rocketarmy_painb5	] {}
void()	rocketarmy_painb5	=[	$painb5,	rocketarmy_painb6	] {}
void()	rocketarmy_painb6	=[	$painb6,	rocketarmy_painb7	] {}
void()	rocketarmy_painb7	=[	$painb7,	rocketarmy_painb8	] {}
void()	rocketarmy_painb8	=[	$painb8,	rocketarmy_painb9	] {}
void()	rocketarmy_painb9	=[	$painb9,	rocketarmy_painb10] {}
void()	rocketarmy_painb10=[	$painb10,	rocketarmy_painb11] {}
void()	rocketarmy_painb11=[	$painb11,	rocketarmy_painb12] {}
void()	rocketarmy_painb12=[	$painb12,	rocketarmy_painb13] {ai_pain(2);}
void()	rocketarmy_painb13=[	$painb13,	rocketarmy_painb14] {}
void()	rocketarmy_painb14=[	$painb14,	rocketarmy_run1	] {}

void()	rocketarmy_painc1	=[	$painc1,	rocketarmy_painc2	] {}
void()	rocketarmy_painc2	=[	$painc2,	rocketarmy_painc3	] {ai_pain(1);}
void()	rocketarmy_painc3	=[	$painc3,	rocketarmy_painc4	] {}
void()	rocketarmy_painc4	=[	$painc4,	rocketarmy_painc5	] {}
void()	rocketarmy_painc5	=[	$painc5,	rocketarmy_painc6	] {ai_painforward(1);}
void()	rocketarmy_painc6	=[	$painc6,	rocketarmy_painc7	] {ai_painforward(1);}
void()	rocketarmy_painc7	=[	$painc7,	rocketarmy_painc8	] {}
void()	rocketarmy_painc8	=[	$painc8,	rocketarmy_painc9	] {ai_pain(1);}
void()	rocketarmy_painc9	=[	$painc9,	rocketarmy_painc10] {ai_painforward(4);}
void()	rocketarmy_painc10=[	$painc10,	rocketarmy_painc11] {ai_painforward(3);}
void()	rocketarmy_painc11=[	$painc11,	rocketarmy_painc12] {ai_painforward(6);}
void()	rocketarmy_painc12=[	$painc12,	rocketarmy_painc13] {ai_painforward(8);}
void()	rocketarmy_painc13=[	$painc13,	rocketarmy_run1] {}

void(entity attacker, float damage)	rocketarmy_pain =
{
	local float r;
	
	if (self.pain_finished > time)
		return;

	r = random();

	if (r < 0.2)
	{
		PainFinished(0.6);
		rocketarmy_pain1 ();
		sound (self, CHAN_VOICE, "soldier/pain1.wav", 1, ATTN_NORM);
	}
	else if (r < 0.6)
	{
		PainFinished(1.1);
		rocketarmy_painb1 ();
		sound (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
	else
	{
		PainFinished(1.1);
		rocketarmy_painc1 ();
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
void() rocketarmy_aim =
{
	// store it relative to self in case we're riding the same mover as our target
	self.dest = enemy_vispos() + enemy_aim_vertical() - self.origin;
}

void() rocketarmy_fire =
{
	ai_face();
	self.effects = self.effects | EF_MUZZLEFLASH;	
	sound (self, CHAN_WEAPON, "soldier/sattck1.wav", 1, ATTN_NORM);	

    SoldierMissile();
}

const float SOLDIER_MISSILE_VEL = 800;
const float SOLDIER_MISSILE_VEL_NM = 1100;

void() SoldierMissile =
{
	entity 	missile;
	vector	dir;

	self.effects = self.effects | EF_MUZZLEFLASH;
	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 1, ATTN_NORM);
	makevectors(self.angles);
	
	dir = (enemy_vispos() + '0 0 10') - self.origin + enemy_aim_vertical();
	dir = normalize(dir);
	
	// if player has strafed around behind, don't lob the missile out of our ass
	if (angledif(self.ideal_yaw, self.angles_y) > 80)
	{
		dir_x = v_forward_x;
		dir_y = v_forward_y;
		dir = normalize(dir);
	}
	
	if (skill >= 3)
		missile = launch_projectile(self.origin + '0 0 10' + v_forward * 16, dir * SOLDIER_MISSILE_VEL_NM, "voreball");
	else
		missile = launch_projectile(self.origin + '0 0 10' + v_forward * 16, dir * SOLDIER_MISSILE_VEL, "voreball");

	SUB_ChangeModel (missile, "progs/proj_missile.mdl");

	missile.nextthink = time + 0.1;
	missile.think = MissileHome;
	missile.enemy = self.enemy;
	missile.touch = ShalMissileTouch;
	missile.lifetime_finished = time + 5;	 // blow up after a while
	if (skill == 3) missile.dest = self.dest;
}

void() MissileHome =
{
	// a voreball with perfect homing causes combat to effectively stop, forcing the player
	// to run around around trying to shake it, often backpedaling through lots of empty map.
	// limiting the voreball's turn rate so they can be dodged and forgotten about makes vores
	// a more flexible enemy and more useful to the mapper
	float dist, rate, dot;
	
	if (self.lifetime_finished < time)
	{
		ShalMissileExplode();
		return;
	}		
	if (!alive(self.enemy))
	{
		self.think = ShalMissileExplode;
		self.nextthink = self.lifetime_finished;
		//remove(self);
		return;
	}

    self.angles = vectoangles(self.velocity);
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	
	self.think = MissileHome;
	self.nextthink = time + SHAL_BALL_THINK_RATE;
	rate = SHAL_BALL_TURN_RATE;
	dot = normalize(self.velocity) * normalize(self.enemy.origin - self.origin);
	
	// reset our owner regularly, or else a voreball that passes through a notrace-invisible
	// player will become owned by the player and remain nonsolid to them after the ring ends
	self.owner = self.trueowner;
	// if the projectile is inside a notrace entity at this time, it'll touch again this frame
	// and reset anyway, so this state will pingpong until it passes out the other side
	
	// go faster at long distance to close the gap, so snipey vores have a better presence
	dist = vlen(self.enemy.origin - self.origin);
	dist = saturate( (dist-200) / 600 );

    if (!self.lip)
        self.lip = 1.2;
	
	if (!has_invis(self.enemy))
	{
		if (dot > 0)
		{
			rate *= max(1, 1.5 * (1 - dot));
		}
		self.velocity = SOLDIER_MISSILE_VEL * ShalTurnToward(self.enemy.origin, rate * self.lip);
        if (self.lip > 0)
            self.lip -= 0.05;
	}

	self.oldvelocity = self.velocity;	
}


/*
===========
RocketSoldierCheckAttack

The player is in view, so decide to move or launch an attack
Returns FALSE if movement should continue
============
*/
float() RocketSoldierCheckAttack =
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


void()	rocketarmy_die1	=[	$death1,	rocketarmy_die2	] {rocketarmy_checkgib();}
void()	rocketarmy_die2	=[	$death2,	rocketarmy_die3	] {rocketarmy_checkgib();}
void()	rocketarmy_die3	=[	$death3,	rocketarmy_die4	]
{if (rocketarmy_checkgib()) return;
self.solid = SOLID_NOT;self.takedamage = DAMAGE_NO; self.ammo_rockets = 1;DropBackpack(3);} //FlakTax
void()	rocketarmy_die4	=[	$death4,	rocketarmy_die5	] {}
void()	rocketarmy_die5	=[	$death5,	rocketarmy_die6	] {}
void()	rocketarmy_die6	=[	$death6,	rocketarmy_die7	] {}
void()	rocketarmy_die7	=[	$death7,	rocketarmy_die8	] {}
void()	rocketarmy_die8	=[	$death8,	rocketarmy_die9	] {}
void()	rocketarmy_die9	=[	$death9,	rocketarmy_die10	] {}
void()	rocketarmy_die10	=[	$death10,	SUB_Null	] {}

void()	rocketarmy_cdie1	=[	$deathc1,	rocketarmy_cdie2	] {}
void()	rocketarmy_cdie2	=[	$deathc2,	rocketarmy_cdie3	] {ai_back(5);}
void()	rocketarmy_cdie3	=[	$deathc3,	rocketarmy_cdie4	]
{self.solid = SOLID_NOT;self.ammo_rockets = 1;DropBackpack(3);ai_back(4);} //FlakTax
void()	rocketarmy_cdie4	=[	$deathc4,	rocketarmy_cdie5	] {ai_back(13);}
void()	rocketarmy_cdie5	=[	$deathc5,	rocketarmy_cdie6	] {ai_back(3);}
void()	rocketarmy_cdie6	=[	$deathc6,	rocketarmy_cdie7	] {ai_back(4);}
void()	rocketarmy_cdie7	=[	$deathc7,	rocketarmy_cdie8	] {}
void()	rocketarmy_cdie8	=[	$deathc8,	rocketarmy_cdie9	] {}
void()	rocketarmy_cdie9	=[	$deathc9,	rocketarmy_cdie10	] {}
void()	rocketarmy_cdie10	=[	$deathc10,	rocketarmy_cdie11	] {}
void()	rocketarmy_cdie11	=[	$deathc11,	SUB_Null	] {}

float() rocketarmy_checkgib =
{	
	if (self.health < -35)
	{
		Gib("progs/h_guard.mdl", self.health);
		self.ammo_rockets = 1; //FlakTax
		DropBackpack(3);
		return TRUE;
	}
	return FALSE;
}

void() rocketarmy_die =
{
// check for gib
	if (rocketarmy_checkgib())
		return;

// regular death
	sound (self, CHAN_VOICE, "soldier/death1.wav", 1, ATTN_NORM);
	if (random() < 0.5)
		rocketarmy_die1 ();
	else
		rocketarmy_cdie1 ();
}

void() monster_rocketarmy_spawn =
{
	self.classname = "monster_army";
	
	self.solid = SOLID_SLIDEBOX;
	//self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/soldier_rocket_qbj.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');
	self.health = 35;

	nmspeed (0.07);

	self.th_stand = rocketarmy_stand1;
	self.th_walk = rocketarmy_walk1;
	self.th_run = rocketarmy_run1;
	self.th_missile = rocketarmy_atk1;
	self.th_pain = rocketarmy_pain;
	self.th_die = rocketarmy_die;
	self.th_checkattack = RocketSoldierCheckAttack;

	if (self.deathtype == string_null)
		self.deathtype = "was exploded by a Rocket Trenchknight";

	walkmonster_start ();
}

void() monster_rocketarmy_spawner = {mon_spawner_use(monster_rocketarmy_spawn);}

/*QUAKED monster_army_rocket (1 0 0) (-16 -16 -24) (16 16 40) AMBUSH ? ? ? TRIGGERED NOTFOG NOTELEFRAG INSTAWAKE
Rocket Trenchknight (Rocket Grunt), 30 health points.

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
@PointClass base(Monster) size(-16 -16 -24, 16 16 40) model({ "path": ":progs/soldier_rocket_qbj.mdl" }) = monster_army_rocket : "Rocket Trenchknight (Rocket Grunt)" []
*/
void() monster_army_rocket =
{	
	if (!SUB_ShouldSpawn()) return;
	if (nomonster()) return;
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model ("progs/soldier_rocket_qbj.mdl");
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
	if ( monster_spawnsetup( monster_rocketarmy_spawner ) ) return;
	
	addmonster(1);
	monster_rocketarmy_spawn();
}
