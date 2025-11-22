/*
==============================================================================

SHAL-RATH

==============================================================================
*/

const float SHAL_BALL_TURN_RATE		= 265;
const float SHAL_BALL_THINK_RATE	= 0.1;
const float SHAL_BALL_VEL			= 300;


$cd id1/models/shalrath
$origin 0 0 24
$base base
$skin skin
$scale 0.7

$frame attack1 attack2 attack3 attack4 attack5 attack6 attack7 attack8
$frame attack9 attack10 attack11

$frame pain1 pain2 pain3 pain4 pain5 

$frame death1 death2 death3 death4 death5 death6 death7

$frame	walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10
$frame	walk11 walk12

$frame attackb1 attackb2 attackb3 attackb4 attackb5 attackb6 attackb7 attackb8
$frame attackb9 attackb10 attackb11

$frame attackc1 attackc2 attackc3 attackc4 attackc5 attackc6 attackc7 attackc8
$frame attackc9 attackc10 attackc11

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9 stand10
$frame stand11 stand12 stand13 stand14 stand15 stand16 stand17 stand18 stand19 stand20
$frame stand21 stand22 stand23 stand24 stand25 stand26 stand27 stand28 stand29 stand30
$frame stand31 stand32 stand33 stand34 stand35 stand36 stand37 stand38 stand39 stand40
$frame stand41 stand42 stand43 stand44 stand45 stand46 stand47 stand48 stand49 stand50
$frame stand51 stand52

void() shal_stand1     =[      $stand1,       shal_stand2    ] {ai_stand(); zaplight(0);}
void() shal_stand2     =[      $stand2,       shal_stand3    ] {ai_stand();}
void() shal_stand3     =[      $stand3,       shal_stand4    ] {ai_stand();}
void() shal_stand4     =[      $stand4,       shal_stand5    ] {ai_stand();}
void() shal_stand5     =[      $stand5,       shal_stand6    ] {ai_stand();}
void() shal_stand6     =[      $stand6,       shal_stand7    ] {ai_stand();}
void() shal_stand7     =[      $stand7,       shal_stand8    ] {ai_stand();}
void() shal_stand8     =[      $stand8,       shal_stand9    ] {ai_stand();}
void() shal_stand9     =[      $stand9,       shal_stand10   ] {ai_stand();}
void() shal_stand10    =[      $stand11,      shal_stand11   ] {ai_stand();}
void() shal_stand11    =[      $stand12,      shal_stand12   ] {ai_stand();}
void() shal_stand12    =[      $stand13,      shal_stand13   ] {ai_stand();}
void() shal_stand13    =[      $stand14,      shal_stand14   ] {ai_stand();}
void() shal_stand14    =[      $stand15,      shal_stand15   ] {ai_stand();}
void() shal_stand15    =[      $stand16,      shal_stand16   ] {ai_stand();}
void() shal_stand16    =[      $stand17,      shal_stand17   ] {ai_stand();}
void() shal_stand17    =[      $stand18,      shal_stand18   ] {ai_stand();}
void() shal_stand18    =[      $stand19,      shal_stand19   ] {ai_stand();}
void() shal_stand19    =[      $stand20,      shal_stand20   ] {ai_stand();}
void() shal_stand20    =[      $stand21,      shal_stand21   ] {ai_stand();}
void() shal_stand21    =[      $stand22,      shal_stand22   ] {ai_stand();}
void() shal_stand22    =[      $stand23,      shal_stand23   ] {ai_stand();}
void() shal_stand23    =[      $stand24,      shal_stand24   ] {ai_stand();}
void() shal_stand24    =[      $stand25,      shal_stand25   ] {ai_stand();}
void() shal_stand25    =[      $stand26,      shal_stand26   ] {ai_stand();}
void() shal_stand26    =[      $stand27,      shal_stand27   ] {ai_stand();}
void() shal_stand27    =[      $stand28,      shal_stand28   ] {ai_stand();}
void() shal_stand28    =[      $stand29,      shal_stand29   ] {ai_stand();}
void() shal_stand29    =[      $stand30,      shal_stand30   ] {ai_stand();}
void() shal_stand30    =[      $stand31,      shal_stand31   ] {ai_stand();}
void() shal_stand31    =[      $stand32,      shal_stand32   ] {ai_stand();}
void() shal_stand32    =[      $stand33,      shal_stand33   ] {ai_stand();}
void() shal_stand33    =[      $stand34,      shal_stand34   ] {ai_stand();}
void() shal_stand34    =[      $stand35,      shal_stand35   ] {ai_stand();}
void() shal_stand35    =[      $stand36,      shal_stand36   ] {ai_stand();}
void() shal_stand36    =[      $stand37,      shal_stand37   ] {ai_stand();}
void() shal_stand37    =[      $stand38,      shal_stand38   ] {ai_stand();}
void() shal_stand38    =[      $stand39,      shal_stand39   ] {ai_stand();}
void() shal_stand39    =[      $stand40,      shal_stand40   ] {ai_stand();}
void() shal_stand40    =[      $stand41,      shal_stand41   ] {ai_stand();}
void() shal_stand41    =[      $stand42,      shal_stand42   ] {ai_stand();}
void() shal_stand42    =[      $stand43,      shal_stand43   ] {ai_stand();}
void() shal_stand43    =[      $stand44,      shal_stand44   ] {ai_stand();}
void() shal_stand44    =[      $stand45,      shal_stand45   ] {ai_stand();}
void() shal_stand45    =[      $stand46,      shal_stand46   ] {ai_stand();}
void() shal_stand46    =[      $stand47,      shal_stand47   ] {ai_stand();}
void() shal_stand47    =[      $stand48,      shal_stand48   ] {ai_stand();}
void() shal_stand48    =[      $stand49,      shal_stand49   ] {ai_stand();}
void() shal_stand49    =[      $stand50,      shal_stand50   ] {ai_stand();}
void() shal_stand50    =[      $stand51,      shal_stand51   ] {ai_stand();}
void() shal_stand51    =[      $stand52,      shal_stand1    ] {ai_stand();}

void() shal_walk1     =[      $walk2,       shal_walk2    ] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "shalrath/idle.wav", 1, ATTN_IDLE);
ai_walk(9); zaplight(0);}
void() shal_walk2     =[      $walk3,       shal_walk3    ] {ai_walk(10);}
void() shal_walk3     =[      $walk4,       shal_walk4    ] {ai_walk(9);}
void() shal_walk4     =[      $walk5,       shal_walk5    ] {ai_walk(4);}
void() shal_walk5     =[      $walk6,       shal_walk6    ] {ai_walk(5);}
void() shal_walk6     =[      $walk7,       shal_walk7    ] {ai_walk(4);}
void() shal_walk7     =[      $walk8,       shal_walk8    ] {ai_walk(5);}
void() shal_walk8     =[      $walk9,       shal_walk9    ] {ai_walk(3);}
void() shal_walk9     =[      $walk10,       shal_walk10    ] {ai_walk(5);}
void() shal_walk10    =[      $walk11,       shal_walk11    ] {ai_walk(6);}
void() shal_walk11    =[      $walk12,       shal_walk12    ] {ai_walk(5);}
void() shal_walk12    =[      $walk1,       shal_walk1    ] {ai_walk(2);}

void() shal_run1     =[      $walk2,       shal_run2    ] {ai_run(9); zaplight(0);}
void() shal_run2     =[      $walk3,       shal_run3    ] {ai_run(10);}
void() shal_run3     =[      $walk4,       shal_run4    ] {ai_run(9);}
void() shal_run4     =[      $walk5,       shal_run5    ] {ai_run(4);}
void() shal_run5     =[      $walk6,       shal_run6    ] {ai_run(5);}
void() shal_run6     =[      $walk7,       shal_run7    ] {ai_run(4);}
void() shal_run7     =[      $walk8,       shal_run8    ] {ai_run(5);}
void() shal_run8     =[      $walk9,       shal_run9    ] {ai_run(3);}
void() shal_run9     =[      $walk10,       shal_run10    ] {ai_run(5);}
void() shal_run10    =[      $walk11,       shal_run11    ] {ai_run(6);}
void() shal_run11    =[      $walk12,       shal_run12    ] {ai_run(5);}
void() shal_run12    =[      $walk1,       shal_run1    ] {ai_run(2);
if (random() < 0.2)
	sound (self, CHAN_VOICE, "shalrath/idle.wav", 1, ATTN_IDLE);
}

void() shal_attack1     =[      $attack1,       shal_attack2    ] {sound (self, CHAN_VOICE, "shalrath/attack.wav", 1, ATTN_NORM); ai_face(); zaplight(0);}
void() shal_attack2     =[      $attack2,       shal_attack3    ] {ai_face();}
void() shal_attack3     =[      $attack3,       shal_attack4    ] {ai_face();}
void() shal_attack4     =[      $attack4,       shal_attack5    ] {ai_face();}
void() shal_attack5     =[      $attack5,       shal_attack6    ] {ai_face();}
void() shal_attack6     =[      $attack6,       shal_attack7    ] {ai_face(); self.lip = 1;}
void() shal_attack7     =[      $attack7,       shal_attack8    ] {ai_face(); if (skill == 3) self.dest = enemy_vispos();}
void() shal_attack8     =[      $attack8,       shal_attack9    ] {ai_face(); if (skill == 3 && visible(self.enemy)) self.dest = enemy_vispos();}
void() shal_attack9     =[      $attack9,       shal_attack10   ] {zaplight(1); ShalMissile();}
void() shal_attack10    =[      $attack10,      shal_attack11   ] {zaplight(0); ai_face();}
void() shal_attack11    =[      $attack11,      shal_run1   	] {}

void() shal_attackb1     =[      $attackb1,       shal_attackb2    ] {sound (self, CHAN_VOICE, "shalrath/attack.wav", 1, ATTN_NORM); ai_face(); zaplight(0);}
void() shal_attackb2     =[      $attackb2,       shal_attackb3    ] {ai_face();}
void() shal_attackb3     =[      $attackb3,       shal_attackb4    ] {ai_face();}
void() shal_attackb4     =[      $attackb4,       shal_attackb5    ] {ai_face();}
void() shal_attackb5     =[      $attackb5,       shal_attackb6    ] {ai_face();}
void() shal_attackb6     =[      $attackb6,       shal_attackb7    ] {ai_face(); self.lip = 2;}
void() shal_attackb7     =[      $attackb7,       shal_attackb8    ] {ai_face(); if (skill == 3) self.dest = enemy_vispos();}
void() shal_attackb8     =[      $attackb8,       shal_attackb9    ] {ai_face(); if (skill == 3 && visible(self.enemy)) self.dest = enemy_vispos();}
void() shal_attackb9     =[      $attackb9,       shal_attackb10   ] {zaplight(1); ShalMissile();}
void() shal_attackb10    =[      $attackb10,      shal_attackb11   ] {zaplight(0); ai_face();}
void() shal_attackb11    =[      $attackb11,      shal_run1   	] {}

void() shal_attackc1     =[      $attackc1,       shal_attackc2    ] {sound (self, CHAN_VOICE, "shalrath/attack.wav", 1, ATTN_NORM); ai_face(); zaplight(0);}
void() shal_attackc2     =[      $attackc2,       shal_attackc3    ] {ai_face();}
void() shal_attackc3     =[      $attackc3,       shal_attackc4    ] {ai_face();}
void() shal_attackc4     =[      $attackc4,       shal_attackc5    ] {ai_face();}
void() shal_attackc5     =[      $attackc5,       shal_attackc6    ] {ai_face();}
void() shal_attackc6     =[      $attackc6,       shal_attackc7    ] {ai_face(); self.lip = 0;}
void() shal_attackc7     =[      $attackc7,       shal_attackc8    ] {ai_face(); if (skill == 3) self.dest = enemy_vispos();}
void() shal_attackc8     =[      $attackc8,       shal_attackc9    ] {ai_face(); if (skill == 3 && visible(self.enemy)) self.dest = enemy_vispos();}
void() shal_attackc9     =[      $attackc9,       shal_attackc10   ] {zaplight(1); ShalMissile();}
void() shal_attackc10    =[      $attackc10,      shal_attackc11   ] {zaplight(0); ai_face();}
void() shal_attackc11    =[      $attackc11,      shal_run1   	] {}

void() shal_pain1       =[      $pain1, shal_pain2      ] {zaplight(0);}
void() shal_pain2       =[      $pain2, shal_pain3      ] {}
void() shal_pain3       =[      $pain3, shal_pain4      ] {}
void() shal_pain4       =[      $pain4, shal_pain5      ] {}
void() shal_pain5       =[      $pain5, shal_run1      ] {}

void() shal_death1      =[      $death1,        shal_death2     ] {zaplight(0); if (shalrath_checkgib()) return;}
void() shal_death2      =[      $death2,        shal_death3     ] {if (shalrath_checkgib()) return; self.takedamage = DAMAGE_NO; self.solid = SOLID_NOT;}
void() shal_death3      =[      $death3,        shal_death4     ] {}
void() shal_death4      =[      $death4,        shal_death5     ] {}
void() shal_death5      =[      $death5,        shal_death6     ] {}
void() shal_death6      =[      $death6,        shal_death7     ] {}
void() shal_death7      =[      $death7,        SUB_Null    ] {}


void( entity attacker, float damage ) shalrath_pain =
{
	if (self.health <= 0) return;
	if (self.pain_finished > time) return;

	sound (self, CHAN_VOICE, "shalrath/pain.wav", 1, ATTN_NORM);
	shal_pain1();
	
	PainFinished(3);
}


float() shalrath_checkgib =
{
	if (self.health < -90)
	{
		Gib ("progs/gibs/gibhead_vore.mdl", self.health);
		GibBloodBath(2);
		return TRUE;
	}
	return FALSE;
}

void() shalrath_die =
{
// check for gib
	zaplight(0);
	if (shalrath_checkgib()) return;

	sound (self, CHAN_VOICE, "shalrath/death.wav", 1, ATTN_NORM);
	shal_death1();
}

/*
================
ShalMissile
================
*/

void() shalrath_attack = 
{
	if (self.lip == 0)
		shal_attack1();
	else if (self.lip == 1)
		shal_attackb1();
	else
		shal_attackc1();
}

void() ShalMissileExplode =
{
	T_RadiusDamage (self, self.trueowner, 40, world, DMGTYPE_EXPLOSION);
	//sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);

	T_ExplosiveTouch();
}

void() ShalMissileTouch =
{
	if (CheckProjectilePassthru()) return;
	if (other == self.owner)
		return;		// don't explode on owner

	if (other.type == "zombie")
		T_Damage (other, self, self.trueowner, other.health + 25);
	
	ShalMissileExplode();
}

vector(vector targ, float turnrate) ShalTurnToward =
{
	vector	vel, aimdir, temp, temp2, out;

	temp = targ + '0 0 10';
	aimdir = temp - self.origin;
	aimdir = normalize(aimdir);
	vel = normalize(self.velocity);
	
	temp = CrossProduct(vel, aimdir);
	
	// try to flatten the rotation to the horizontal plane unless the difference is extreme
	if (fabs(temp_z) > 0.92)
	{
		temp_z *= 4;
		temp = normalize(temp);
	}
	out = rotateVectorAround(vel, temp, turnrate * SHAL_BALL_THINK_RATE);
	
	// don't turn past the desired direction
	temp2 = CrossProduct(out, aimdir);
	if ((temp * temp2) < 0)
		return aimdir;
	return out;
}

void() ShalHome =
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
	
	if (!self.deadflag)
	{
		if ( self.owner.health <= 0		// if our mama dies
			|| self.owner.customflags & CFL_PLUNGE )	// or falls in a hole
		{
			self.deadflag = TRUE;
			setmodel(self, "progs/proj_voreball2.mdl");	// stop sparkling

			if (self.owner.skin == 1) //tar skin
				self.skin = 1;

			setsize(self, VEC_ORIGIN, VEC_ORIGIN);
		}
	}
	
	self.think = ShalHome;
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
	
	if (skill < 3)
	{
		// 'poor' homing (half turn rate):
		if ( self.deadflag		// if our mama dies or falls in a hole
			//|| !visible(self.enemy)		// if we lost LOS
			// took ^^ this one out, because it made voreballs even more effective at going
			// around corners, which meant that courageous players had a nice new dodge move
			// but those who tried to fight the vore the old cautious way were punished			
			|| has_invis(self.enemy)			// if target is invis
			|| pointcontents(self.origin) < CONTENT_SOLID ) // if voreball is underwater
		{
			// voreballs headed straight at the player when he's hidden should maintain course, to
			// make the dodge possible without it immediately turning to hit him
			if (dot > 0)
			{
				rate *= max(1, 1.5 * (1 - dot));
			}
			self.velocity = SHAL_BALL_VEL * ShalTurnToward(self.enemy.origin, rate * 0.33);
		}
		else // good homing (full turn rate):
		{
			// voreballs headed straight away from the player don't normally seem to be able to pick a direction to 
			// turn and wobble more or less straight away - amp turn rate in these cases to force a 'decision'
			if (dot < 0)
			{
				rate *= min(1.4, 1.4 + fabs(dot));
			}
			self.velocity = SHAL_BALL_VEL * ShalTurnToward(self.enemy.origin, rate);
		}
		
		self.velocity *= 1 + dist;
		self.velocity += Vector(crandom(),crandom(),crandom()) * 16;
	}
	else
	{
		// nightmare: vanilla-evil homing with corner following to force engagement rather than encourage it
		enemy_vis = visible(self.enemy);
		
		self.dest2 = self.dest;
		if (enemy_vis)	// go straight to follow player around corners
		{
			// remember last seen positions for corner hax
			self.dest = self.enemy.origin;
		}
		else if (self.dest2 == self.dest)
		{
			// player has been out of sight for two frames, don't keep changing velocity or
			// when we reach that point we'll dance around it weirdly
			self.oldvelocity = self.velocity;
			return;
		}
		
		// poor homing
		if ( self.deadflag		// if our mama dies or falls in a hole
			|| pointcontents(self.origin) < CONTENT_SOLID )
		{
			if (dot > 0)
			{
				rate *= max(1, 1.5 * (1 - dot));
			}
			self.velocity = SHAL_BALL_VEL * ShalTurnToward(self.dest2, rate * 0.5);
		}
		else // evile homing
		{
			self.velocity = SHAL_BALL_VEL * normalize(self.dest2 + '0 0 10' - self.origin);
		}
		
		self.velocity *= 1 + dist;
		self.velocity += Vector(crandom(),crandom(),crandom()) * 16;
	}

	self.oldvelocity = self.velocity;	
}


void() ShalMissile =
{
	entity 	missile;
	vector	dir;

	//self.effects = self.effects | EF_MUZZLEFLASH;
	sound (self, CHAN_WEAPON, "shalrath/attack2.wav", 1, ATTN_NORM);
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
	
	missile = launch_projectile(self.origin + '0 0 10' + v_forward * 16, dir * SHAL_BALL_VEL, "voreball");

	SUB_ChangeModel (missile, "progs/proj_voreball.mdl");

	
	if (self.skin == 1) //tar skin
		missile.skin = 1;

	missile.avelocity = '300 300 300';
	missile.nextthink = time + 0.1;
	missile.think = ShalHome;
	missile.enemy = self.enemy;
	missile.touch = ShalMissileTouch;
	missile.lifetime_finished = time + 30;	 // blow up after a while
	if (skill == 3) missile.dest = self.dest;
}

//=================================================================
void() monster_shalrath_spawn =
{
	self.classname = "monster_shalrath";
		
	self.solid = SOLID_SLIDEBOX;
	//self.movetype = MOVETYPE_STEP;
	
	setmodel (self, "progs/shalrath_qbj.mdl");
	
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = 400;

	self.th_stand = shal_stand1;
	self.th_walk = shal_walk1;
	self.th_run = shal_run1;
	self.th_die = shalrath_die;
	self.th_pain = shalrath_pain;
	self.th_missile = shalrath_attack;
	self.th_checkattack = CheckAttack;

	self.gibgroup = GIBGROUP_TAR_ALLOWED;

	if (self.deathtype == string_null)
		self.deathtype = "was exploded by a Shalrath";
		
	//self.think = walkmonster_start;
	//self.nextthink = time + 0.1 + random ()*0.1;	
	
	walkmonster_start();
}

void() monster_shalrath_spawner = {mon_spawner_use(monster_shalrath_spawn);}


/*QUAKED monster_shalrath (1 0 0) (-32 -32 -24) (32 32 40) AMBUSH ? ? ? TRIGGERED NOTFOG NOTELEFRAG INSTAWAKE
Vore (Shalrath), 400 health points.

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
@PointClass base(Monster) size(-32 -32 -24, 32 32 64) model({ "path": ":progs/shalrath_qbj.mdl", "skin": skin }) = monster_shalrath : "Vore" []
*/
void() monster_shalrath =
{
	if (!SUB_ShouldSpawn()) return;
	if (nomonster()) return;
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model2 ("progs/shalrath_qbj.mdl");
	precache_model2 ("progs/gibs/gibhead_vore.mdl");
	precache_model2 ("progs/proj_voreball.mdl");
	precache_model2 ("progs/proj_voreball2.mdl");

	self.invokedmodel = "progs/fx/invoked_shalrath.mdl";
	precache_model(self.invokedmodel);
	
	precache_sound2 ("shalrath/attack.wav");
	precache_sound2 ("shalrath/attack2.wav");
	precache_sound2 ("shalrath/death.wav");
	precache_sound2 ("shalrath/idle.wav");
	precache_sound2 ("shalrath/pain.wav");
	precache_sound2 ("shalrath/sight.wav");

	self.gibgroup = GIBGROUP_TAR_ALLOWED;
	
	self.health = 400;
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	if ( monster_spawnsetup( monster_shalrath_spawner ) ) return;
	
	addmonster(1);
	monster_shalrath_spawn();
}
