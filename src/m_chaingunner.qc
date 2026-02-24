void() chain_fire =
{
	entity	spike;
    entity  spike2;
	vector	shot_org, target_pos, dir;

	ai_face();
	self.effects = self.effects | EF_MUZZLEFLASH;
	sound (self, CHAN_WEAPON, "placeholder_sound/chaingunner/chshoot.wav", 1, ATTN_NORM);

	shot_org = chaingunner_muzzle_org();

	target_pos = enemy_vispos() + enemy_aim_vertical();
	dir = normalize(target_pos - shot_org);

	dir = normalize(dir + v_right * crandom() * 0.03 + v_up * crandom() * 0.03);
    spike = launch_projectile(shot_org, dir*1400, "cshot");
	spike.dmg = 5;
	spike.touch = spike_touch;
	SUB_ChangeModel (spike, "progs/proj_pellet.mdl");

	dir = normalize(dir + v_right * crandom() * 0.03 + v_up * crandom() * 0.03);
    spike2 = launch_projectile(shot_org, dir*1000, "cshot");
	spike2.dmg = 5;
	spike2.touch = spike_touch;
	SUB_ChangeModel (spike2, "progs/proj_pellet.mdl");
}

/*
==============================================================================

chaingunner

==============================================================================
*/

$cd id1/models/enforcer
$origin 0 -6 24
$base base		
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10
$frame walk11 walk12 walk13 walk14 walk15 walk16

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame attack1 attack2 attack3 attack4 attack5 attack6
$frame attack7 attack8 attack9 attack10

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10 death11 death12 death13 death14

$frame fdeath1 fdeath2 fdeath3 fdeath4 fdeath5 fdeath6 fdeath7 fdeath8
$frame fdeath9 fdeath10 fdeath11

$frame paina1 paina2 paina3 paina4

$frame painb1 painb2 painb3 painb4 painb5

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 painc8

$frame paind1 paind2 paind3 paind4 paind5 paind6 paind7 paind8
$frame paind9 paind10 paind11 paind12 paind13 paind14 paind15 paind16
$frame paind17 paind18 paind19

vector() chaingunner_muzzle_org =
{
	vector vec, right;
	vec = normalize(enemy_vispos() - self.origin);
	right = CrossProduct(vec, '0 0 1');

	return (self.origin + vec * 24 + right * 6 + '0 0 16');
}

float() chaingunner_clear_attack =
{
	vector spot1, spot2;

	if (has_invis(self.enemy)) return TRUE;	// blast away

	spot1 = chaingunner_muzzle_org();
	spot2 = enemy_vispos() + self.enemy.view_ofs;

	traceline2(spot1, spot2, self, TRACE_WATER);

	if ((trace_inopen && trace_inwater) || (trace_ent != self.enemy))
	{
		if (self.cnt <= 4)
		{
			self.cnt++;
			dprint("\bBlind Shots:\b ");
			dprint(ftos(self.cnt));
			dprint("\n");
			return TRUE;
		}
		else
		{
			self.cnt = 0;
			return FALSE;
		}
	}
	self.cnt = 0;
	return TRUE;
}

float() chaingunner_check_attack =
{
	float chance;

	if (time < self.attack_finished)
	{
		dprint("\battack_finished: \b");
		dprint(ftos(self.attack_finished - time));
		dprint("\n");
		return FALSE;
	}
	if (enemy_range >= RANGE_FAR) return FALSE;
	if (!chaingunner_clear_attack()) return FALSE;

	if (enemy_range == RANGE_MELEE)
	{
		chance = 0.9;
		self.attack_finished = 0;
	}
	else if (enemy_range == RANGE_NEAR)
		chance = 0.4;
	else if (enemy_range == RANGE_MID)
		chance = 0.2;
	else
		chance = 0;

	if (random() < chance)
	{
		self.attack_state = AS_MISSILE;
		return TRUE;
	}

	return FALSE;
}

//============================================================================

void()	chain_stand1	=[	$stand1,	chain_stand2	] {ai_stand();}
void()	chain_stand2	=[	$stand2,	chain_stand3	] {ai_stand();}
void()	chain_stand3	=[	$stand3,	chain_stand4	] {ai_stand();}
void()	chain_stand4	=[	$stand4,	chain_stand5	] {ai_stand();}
void()	chain_stand5	=[	$stand5,	chain_stand6	] {ai_stand();}
void()	chain_stand6	=[	$stand6,	chain_stand7	] {ai_stand();}
void()	chain_stand7	=[	$stand7,	chain_stand1	] {ai_stand();}

void()	chain_walk1	=[	$walk1 ,	chain_walk2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "placeholder_sound/chaingunner/chidle.wav", 1, ATTN_IDLE);
ai_walk(2);}
void()	chain_walk2	=[	$walk2 ,	chain_walk3	] {ai_walk(4);}
void()	chain_walk3	=[	$walk3 ,	chain_walk4	] {ai_walk(4);}
void()	chain_walk4	=[	$walk4 ,	chain_walk5	] {ai_walk(3);}
void()	chain_walk5	=[	$walk5 ,	chain_walk6	] {ai_walk(1);}
void()	chain_walk6	=[	$walk6 ,	chain_walk7	] {ai_walk(2);}
void()	chain_walk7	=[	$walk7 ,	chain_walk8	] {ai_walk(2);}
void()	chain_walk8	=[	$walk8 ,	chain_walk9	] {ai_walk(1);}
void()	chain_walk9	=[	$walk9 ,	chain_walk10	] {ai_walk(2);}
void()	chain_walk10	=[	$walk10,	chain_walk11	] {ai_walk(4);}
void()	chain_walk11	=[	$walk11,	chain_walk12	] {ai_walk(4);}
void()	chain_walk12	=[	$walk12,	chain_walk13	] {ai_walk(1);}
void()	chain_walk13	=[	$walk13,	chain_walk14	] {ai_walk(2);}
void()	chain_walk14	=[	$walk14,	chain_walk15	] {ai_walk(3);}
void()	chain_walk15	=[	$walk15,	chain_walk16	] {ai_walk(4);}
void()	chain_walk16	=[	$walk16,	chain_walk1	] {ai_walk(2);}

void()	chain_run1	=[	$run1  ,	chain_run2	] {
	if (random() < 0.2 && time > self.show_hostile)
		sound (self, CHAN_VOICE, "placeholder_sound/chaingunner/chidle.wav", 1, ATTN_IDLE);
	self.yaw_speed = 20;
	ai_run(18);
}
void()	chain_run2	=[	$run2  ,	chain_run3	] {ai_run(14);}
void()	chain_run3	=[	$run3  ,	chain_run4	] {ai_run(7);}
void()	chain_run4	=[	$run4  ,	chain_run5	] {ai_run(12);}
void()	chain_run5	=[	$run5  ,	chain_run6	] {ai_run(14);}
void()	chain_run6	=[	$run6  ,	chain_run7	] {ai_run(14);}
void()	chain_run7	=[	$run7  ,	chain_run8	] {ai_run(7);}
void()	chain_run8	=[	$run8  ,	chain_run1	] {ai_run(11);}

void()	chain_atk1	=[	$attack1,	chain_atk2	] {self.yaw_speed = 30; ai_face(); self.lip = time + 4;}
void()	chain_atk2	=[	$attack2,	chain_atk3	] {ai_face();}
void()	chain_atk3	=[	$attack3,	chain_atk4	] {ai_face();}
void()	chain_atk4	=[	$attack4,	chain_atk5	] {ai_face();}
void()	chain_atk5	=[	$attack5,	chain_atk6	] {ai_face();}
void()	chain_atk6	=[	$attack5,	chain_atk7	] {ai_face();}
void()	chain_atk7	=[	$attack6,	chain_run1	] {chain_fire(); ai_face(); 
	if (!alive(self.enemy) || self.enemy.customflags & CFL_LIMBO )
		return;
	
	if (angledif(self.ideal_yaw, self.angles_y) > 80)	// player got behind us
		return;
	
	if (has_invis(self.enemy) && random() > 0.80)
	{
		ai_attack_finished(0.25 + random()); // randomly break volley if player is being sneaky
		return;
	}
	if (!chaingunner_clear_attack())
	{
		ai_attack_finished(1 + random());	// force a little maneuvering if LOS is broken
		return;
	}

	if (time >= self.lip)
	{
		ai_attack_finished(1 + random());	// burst time limit
		return;
	}

	self.nextthink = time + 0.030;
	self.think = chain_atk6;
}

void()	chain_atk10	=[	$attack10,	chain_run1	] {self.yaw_speed = 20; ai_face(); ai_attack_finished (2*random());}

void()	chain_paina1	=[	$paina1,	chain_paina2	] {}
void()	chain_paina2	=[	$paina2,	chain_paina3	] {}
void()	chain_paina3	=[	$paina3,	chain_paina4	] {}
void()	chain_paina4	=[	$paina4,	chain_run1	] {}

void()	chain_painb1	=[	$painb1,	chain_painb2	] {}
void()	chain_painb2	=[	$painb2,	chain_painb3	] {}
void()	chain_painb3	=[	$painb3,	chain_painb4	] {}
void()	chain_painb4	=[	$painb4,	chain_painb5	] {}
void()	chain_painb5	=[	$painb5,	chain_run1	] {}

void()	chain_painc1	=[	$painc1,	chain_painc2	] {}
void()	chain_painc2	=[	$painc2,	chain_painc3	] {}
void()	chain_painc3	=[	$painc3,	chain_painc4	] {}
void()	chain_painc4	=[	$painc4,	chain_painc5	] {}
void()	chain_painc5	=[	$painc5,	chain_painc6	] {}
void()	chain_painc6	=[	$painc6,	chain_painc7	] {}
void()	chain_painc7	=[	$painc7,	chain_painc8	] {}
void()	chain_painc8	=[	$painc8,	chain_run1	] {}

void(entity attacker, float damage)	chain_pain =
{
	if (self.pain_finished > time)
		return;

	float r;
	self.yaw_speed = 20;
	
	r = random ();
	
	if (r < 0.5)
		sound (self, CHAN_VOICE, "placeholder_sound/chaingunner/pain2.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_VOICE, "placeholder_sound/chaingunner/pain1.wav", 1, ATTN_NORM);

	if (r < 0.2)
	{
		PainFinished(3);
		chain_paina1 ();
	}
	else if (r < 0.4)
	{
		PainFinished(3);
		chain_painb1 ();
	}
	else
	{
		PainFinished(3);
		chain_painc1 ();
	}
}

//============================================================================




void()	chain_die1	=[	$death1,	chain_die2	] {}
void()	chain_die2	=[	$death2,	chain_die3	] {}
void()	chain_die3	=[	$death3,	chain_die4	] {
	self.solid = SOLID_NOT;
	self.ammo_shells = 10;
	DropBackpack();
}
void()	chain_die4	=[	$death4,	chain_die5	] {ai_forward(14);}
void()	chain_die5	=[	$death5,	chain_die6	] {ai_forward(2);}
void()	chain_die6	=[	$death6,	chain_die7	] {}
void()	chain_die7	=[	$death7,	chain_die8	] {}
void()	chain_die8	=[	$death8,	chain_die9	] {}
void()	chain_die9	=[	$death9,	chain_die10	] {ai_forward(3);}
void()	chain_die10	=[	$death10,	chain_die11	] {ai_forward(5);}
void()	chain_die11	=[	$death11,	chain_die12	] {ai_forward(5);}
void()	chain_die12	=[	$death12,	chain_die13	] {ai_forward(5);}
void()	chain_die13	=[	$death13,	chain_die14	] {}
void()	chain_die14	=[	$death14,	SUB_Null	] {}

void()	chain_fdie1	=[	$fdeath1,	chain_fdie2	] {}
void()	chain_fdie2	=[	$fdeath2,	chain_fdie3	] {}
void()	chain_fdie3	=[	$fdeath3,	chain_fdie4	] {
	self.solid = SOLID_NOT;
	self.ammo_shells = 10;
	DropBackpack();
}
void()	chain_fdie4	=[	$fdeath4,	chain_fdie5	] {}
void()	chain_fdie5	=[	$fdeath5,	chain_fdie6	] {}
void()	chain_fdie6	=[	$fdeath6,	chain_fdie7	] {}
void()	chain_fdie7	=[	$fdeath7,	chain_fdie8	] {}
void()	chain_fdie8	=[	$fdeath8,	chain_fdie9	] {}
void()	chain_fdie9	=[	$fdeath9,	chain_fdie10	] {}
void()	chain_fdie10	=[	$fdeath10,	chain_fdie11	] {}
void()	chain_fdie11	=[	$fdeath11,	SUB_Null	] {}


void() chain_die =
{
	 
// check for gib
	if (self.health < -35)
	{
		self.ammo_shells = 10;
		DropBackpack();
		Gib ("progs/h_PROTOTYPE_chaingunner.mdl", self.health);
		return;
	}

// regular death
	sound (self, CHAN_VOICE, "placeholder_sound/chaingunner/chdeath.wav", 1, ATTN_NORM);
	if (random() > 0.5)
		chain_die1 ();
	else
		chain_fdie1 ();
}


void() monster_chaingunner_spawn =
{
	self.classname = "monster_chaingunner";
		
	self.solid = SOLID_SLIDEBOX;
	//self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/PROTOTYPE_chaingunner.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');
	self.health = 230;

	self.th_stand = chain_stand1;
	self.th_walk = chain_walk1;
	self.th_run = chain_run1;
	self.th_pain = chain_pain;
	self.th_die = chain_die;
	self.th_missile = chain_atk1;
	self.th_checkattack = chaingunner_check_attack;

	if (self.deathtype == string_null)
		self.deathtype = "met the Chaingunner's barrels.";

	walkmonster_start();
}

void() monster_chaingunner_spawner = {mon_spawner_use(monster_chaingunner_spawn);}


/*QUAKED monster_chaingunner (1 0 0) (-16 -16 -24) (16 16 40) AMBUSH ? ? ? TRIGGERED NOTFOG NOTELEFRAG INSTAWAKE
Chaingunner, 200 health points.

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
@PointClass base(Monster) size(-16 -16 -24, 16 16 40) model({ "path": ":progs/PROTOTYPE_chaingunner.mdl" }) = monster_chaingunner : "Chaingunner" []
*/
void() monster_chaingunner =
{
	if (!SUB_ShouldSpawn()) return;
	if (nomonster()) return;
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model2 ("progs/PROTOTYPE_chaingunner.mdl");
	precache_model2 ("progs/h_PROTOTYPE_chaingunner.mdl");
	precache_model2 ("progs/proj_pellet.mdl");

	precache_sound2 ("placeholder_sound/chaingunner/chalert.wav");
	precache_sound2 ("placeholder_sound/chaingunner/chdeath.wav");
	precache_sound2 ("placeholder_sound/chaingunner/chidle.wav");
	precache_sound2 ("placeholder_sound/chaingunner/pain1.wav");
	precache_sound2 ("placeholder_sound/chaingunner/pain2.wav");
	precache_sound2 ("placeholder_sound/chaingunner/chshoot.wav");

	self.health = 230;
	setsize (self, '-16 -16 -24', '16 16 40');
	if ( monster_spawnsetup( monster_chaingunner_spawner ) ) return;
	
	addmonster(1);
	monster_chaingunner_spawn();
}