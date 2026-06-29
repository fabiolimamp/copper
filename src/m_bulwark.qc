/*
==============================================================================

BULWARK

==============================================================================
*/

float BULWARK_MISSILE_RANGE = 640;

$cd id1/models/bulwark
$origin 0 0 24
$base base		
$skin base

$frame dummy

/*
-----------------
Bulwark  [0-106]

0-16  stand
17-28  walk
29-34  run
35-46  smash
47-55  swingL...
56-64  swingR...
65-77  magic
78-89  jump
90-95  pain
96-106  death
-----------------
*/

//============================================================================
// STAND
//============================================================================

void() blwk_stand1	=[0,	blwk_stand2	] {ai_stand();}
void() blwk_stand2	=[1,	blwk_stand3	] {ai_stand();}
void() blwk_stand3	=[2,	blwk_stand4	] {ai_stand();}
void() blwk_stand4	=[3,	blwk_stand5	] {ai_stand();}
void() blwk_stand5	=[4,	blwk_stand6	] {ai_stand();}
void() blwk_stand6	=[5,	blwk_stand7	] {ai_stand();}
void() blwk_stand7	=[6,	blwk_stand8	] {ai_stand();}
void() blwk_stand8	=[7,	blwk_stand9	] {ai_stand();}
void() blwk_stand9	=[8,	blwk_stand10	] {ai_stand();}
void() blwk_stand10	=[9,	blwk_stand11	] {ai_stand();}
void() blwk_stand11	=[10,	blwk_stand12	] {ai_stand();}
void() blwk_stand12	=[11,	blwk_stand13	] {ai_stand();}
void() blwk_stand13	=[12,	blwk_stand14	] {ai_stand();}
void() blwk_stand14	=[13,	blwk_stand15	] {ai_stand();}
void() blwk_stand15	=[14,	blwk_stand16	] {ai_stand();}
void() blwk_stand16	=[15,	blwk_stand17	] {ai_stand();}
void() blwk_stand17	=[16,	blwk_stand1	] {ai_stand();}

//============================================================================
// WALK
//============================================================================

void() blwk_walk1	=[17, blwk_walk2	] {ai_walk(10);}
void() blwk_walk2	=[18, blwk_walk3	] {ai_walk(9);}
void() blwk_walk3	=[19, blwk_walk4	] {ai_walk(9);}
void() blwk_walk4	=[20, blwk_walk5	] {ai_walk(5);}
void() blwk_walk5	=[21, blwk_walk6	] {ai_walk(6);}
void() blwk_walk6	=[22, blwk_walk7	] {ai_walk(12);}
void() blwk_walk7	=[23, blwk_walk8	] {ai_walk(8);}
void() blwk_walk8	=[24, blwk_walk9	] {ai_walk(3);}
void() blwk_walk9	=[25, blwk_walk10] 	{ai_walk(13);}
void() blwk_walk10	=[26, blwk_walk11] 	{ai_walk(9);}
void() blwk_walk11	=[27, blwk_walk12] 	{ai_walk(7);}
void() blwk_walk12	=[28, blwk_walk1	] {ai_walk(7);}

//============================================================================
// RUN
//============================================================================

void() blwk_run1	=[29, blwk_run2] {ai_run(20);}
void() blwk_run2	=[30, blwk_run3] {ai_run(24);}
void() blwk_run3	=[31, blwk_run4] {ai_run(20);}
void() blwk_run4	=[32, blwk_run5] {ai_run(20);}
void() blwk_run5	=[33, blwk_run6] {ai_run(24);}
void() blwk_run6	=[34, blwk_run1] {ai_run(20);}

//============================================================================
// MELEE ATTACKS
//============================================================================

void() BlwkSmash =
{
	local vector	delta;
	local float 	ldmg;

	if (!self.enemy)
		return;
	ai_charge(0);

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 100)
		return;
	if (!CanDamage (self.enemy, self.origin))
		return;
		
	ldmg = (random() + random() + random()) * 40;
	T_Damage(self.enemy, self, self, ldmg, DMGTYPE_MELEE);

	SpawnMeatSpray (self.origin + v_forward*16, crandom() * 100 * v_right);
	SpawnMeatSpray (self.origin + v_forward*16, crandom() * 100 * v_right);
}

void() blwk_smash1	=[35, blwk_smash2 ] {ai_charge(2);}
void() blwk_smash2	=[36, blwk_smash3 ] {nmfast(); ai_charge(6);}
void() blwk_smash3	=[37, blwk_smash4 ] {nmfast(); ai_charge(6);}
void() blwk_smash4	=[38, blwk_smash5 ] {nmfast(); ai_charge(5);}
void() blwk_smash5	=[39, blwk_smash6 ] {nmfast(); ai_charge(4);}
void() blwk_smash6	=[40, blwk_smash7 ] {nmfast(); ai_charge(1);}
void() blwk_smash7	=[41, blwk_smash8 ] {nmfast(); ai_charge(0);}
void() blwk_smash8	=[42, blwk_smash9 ] {nmfast(); ai_charge(0);}
void() blwk_smash9	=[43, blwk_smash10] {nmfast(); ai_charge(0);}
void() blwk_smash10	=[44, blwk_smash11] {BlwkSmash();}
void() blwk_smash11	=[45, blwk_smash12] {ai_charge(5);}
void() blwk_smash12	=[46, blwk_run1  ] {ai_charge(4);}

void(float side) BlwkClaw =
{
	float ldmg;

	if (!self.enemy)
		return;
	if (vdist(self.enemy.origin, self.origin) > 100)
		return;
		
	ldmg = (random() + random() + random()) * 20;
	T_Damage(self.enemy, self, self, ldmg, DMGTYPE_MELEE);

	if (side)
	{
		makevectors (self.angles);
		SpawnMeatSpray (self.origin + v_forward*16, side * v_right);
	}
}

void() blwk_swingl1	=[47, blwk_swingl2] {ai_charge(5);}
void() blwk_swingl2	=[48, blwk_swingl3] {nmfast(); ai_charge(3);}
void() blwk_swingl3	=[49, blwk_swingl4] {nmfast(); ai_charge(7);}
void() blwk_swingl4	=[50, blwk_swingl5] {nmfast(); ai_charge(3);}
void() blwk_swingl5	=[51, blwk_swingl6] {nmfast(); ai_charge(7);}
void() blwk_swingl6	=[52, blwk_swingl7] {nmfast(); ai_charge(9);}
void() blwk_swingl7	=[53, blwk_swingl8] {ai_charge(15); BlwkClaw(250);}
void() blwk_swingl8	=[54, blwk_swingl9] {ai_charge(4);}
void() blwk_swingl9	=[55, blwk_run1  ] {
	ai_charge(8);
	if (random()<0.5 && vdist(self.enemy.origin, self.origin) < 100 && CheckClearAttack())
		self.think = blwk_swingr1;
}

void() blwk_swingr1	=[56, blwk_swingr2] {ai_charge(1);}
void() blwk_swingr2	=[57, blwk_swingr3] {nmfast(); ai_charge(8);}
void() blwk_swingr3	=[58, blwk_swingr4] {nmfast(); ai_charge(14);}
void() blwk_swingr4	=[59, blwk_swingr5] {nmfast(); ai_charge(7);}
void() blwk_swingr5	=[60, blwk_swingr6] {nmfast(); ai_charge(3);}
void() blwk_swingr6	=[61, blwk_swingr7] {nmfast(); ai_charge(6);}
void() blwk_swingr7	=[62, blwk_swingr8] {ai_charge(16); BlwkClaw(-250);}
void() blwk_swingr8	=[63, blwk_swingr9] {ai_charge(3);}
void() blwk_swingr9	=[64, blwk_run1  ] {
	ai_charge(11);
	if (!self.deadflag && random()<0.5 && vdist(self.enemy.origin, self.origin) < 100 && CheckClearAttack())
		self.think = blwk_swingl1;
}

void() blwk_melee =
{
	if (self.enemy.type == "zombie")
	{
		blwk_smash1();
		return;
	}

	float chance;
	chance = random();
	
	if (chance < floor(self.lip) / 6.66)
	{
		blwk_magic1();
		return;
	}

	if (chance > 0.6)
		blwk_smash1 ();
	else if (chance > 0.3)
		blwk_swingr1 ();
	else
		blwk_swingl1 ();

	self.lip += 0.5;
}


//============================================================================
// RANGED ATTACK
//============================================================================

void(float side) blwk_fire =
{
	entity  magic;
	entity  magic2;
	vector  shot_org, target_pos, dir, spread_dir;

	ai_face();
	makevectors(self.angles);
	self.effects = self.effects | EF_MUZZLEFLASH;

	shot_org = self.origin + v_forward * 24 + '0 0 16';
	target_pos = enemy_vispos() + enemy_aim_vertical();

	dir = normalize(target_pos - shot_org);
	magic = launch_projectile(shot_org, dir*800, "magic");
	magic.dmg = 15;
	magic.touch = spike_touch;
	SUB_ChangeModel(magic, "progs/placeholder_progs/proj_magic_claw.mdl");
	
	spread_dir = normalize(target_pos + v_right * 130 * side - shot_org);
	magic2 = launch_projectile(shot_org, spread_dir*800, "magic");
	magic2.dmg = 15;
	magic2.touch = spike_touch;
	SUB_ChangeModel(magic2, "progs/placeholder_progs/proj_magic_claw.mdl");
}

void() blwk_magic1	=[65, blwk_magic2  ] {ai_face(); self.lip = 0; self.cnt = 1;}
void() blwk_magic2	=[66, blwk_magic3  ] {ai_face();}
void() blwk_magic3	=[67, blwk_magic4  ] {ai_face();}
void() blwk_magic4	=[68, blwk_magic5  ] {ai_face();}
void() blwk_magic5	=[69, blwk_magic6  ] {ai_face();}
void() blwk_magic6	=[70, blwk_magic7  ] {ai_face();}
void() blwk_magic7	=[71, blwk_magic8  ] {blwk_fire(self.cnt);}
void() blwk_magic8	=[72, blwk_magic9  ] {}
void() blwk_magic9	=[73, blwk_magic10 ] {}
void() blwk_magic10	=[74, blwk_magic11 ] {}
void() blwk_magic11	=[75, blwk_magic12 ] {}
void() blwk_magic12	=[76, blwk_magic13 ] {blwk_fire(-self.cnt); self.cnt = -self.cnt;}
void() blwk_magic13	=[77, blwk_run1    ] {ai_attack_finished(1 + random());}


//============================================================================
// LEAP ATTACK
// Only triggered when the enemy is far away, otherwise magic+melee
//============================================================================

float BLWK_LEAP_HVEL = 600;
float BLWK_LEAP_VVEL = 250;
float BLWK_LEAP_VEL  = 650;
float BLWK_LEAP_BLOCKED_HEAD = -1;
float BLWK_LEAP_BLOCKED_TOE  = -2;

void() Blwk_DoLeap =
{
	vector leap;
	if (!self.speed) self.speed = BLWK_LEAP_VEL;
	makevectors(self.angles);
	leap = SinCos(self.height);
	self.velocity   = v_forward * leap_y;
	self.velocity_z = leap_x;
	self.velocity  *= self.speed;
	self.touch       = BlwkJumpTouch;
	self.flags       = not(self.flags, FL_ONGROUND);
	self.height      = 0;
}

float(vector attack, float ang) Blwk_LeapSweep =
{
	vector corner, wmins, dir, arc, hullsize;
	float  headfails, stepfails;
	float  sweepdist = 160;

	arc = SinCos(ang - 1);
	dir = attack * arc_y;
	dir_z = arc_x;
	dir *= sweepdist;

	traceline(self.origin, self.origin + dir, TRUE, self);
	if (trace_fraction < 1)
		return FALSE;

	float x, y, z;
	wmins    = self.origin + self.mins + '0 0 0.1';
	hullsize = VEC_HULL2_MAX - VEC_HULL2_MIN;
	for (x = 0; x <= 1; x += 1) for (y = 0; y <= 1; y += 1) for (z = 0; z <= 1; z += 1)
	{
		corner = wmins + vec_scale(hullsize, Vector(x, y, z));
		traceline(corner, corner + dir, TRUE, self);
		if (trace_fraction < 1 || trace_startsolid || trace_allsolid)
		{
			if (z) headfails++;
			else   stepfails++;
		}
	}

	if (headfails && stepfails) return FALSE;
	if (headfails) return BLWK_LEAP_BLOCKED_HEAD;
	if (stepfails) return BLWK_LEAP_BLOCKED_TOE;
	return TRUE;
}

float(vector attack) Blwk_LeapCheckClearance =
{
	float try, last;
	attack_z  = 0;
	attack    = normalize(attack);

	try  = Blwk_LeapSweep(attack, self.height);
	last = try;
	while (try < 0 && try == last)
	{
		if (try == BLWK_LEAP_BLOCKED_HEAD && self.height >= 15)
		{
			self.speed  += 25;
			self.height -= 10;
			try = Blwk_LeapSweep(attack, self.height);
		}
		else if (try == BLWK_LEAP_BLOCKED_TOE && self.height <= 35)
		{
			self.height += 10;
			self.speed  -= 25;
			try = Blwk_LeapSweep(attack, self.height);
		}
		else break;
	}

	if (try > 0)
		return TRUE;
	self.height = 0;
	return FALSE;
}

float() BlwkCheckLeap =
{
	vector org, dir, tgt, angles;
	float  d, ang;

	if (!(self.flags & FL_ONGROUND))
		return FALSE;

	dir   = self.enemy.origin - self.origin;
	dir_z = max(0, dir_z * 2);
	d     = vlen(dir);

	if (d < 200) return FALSE;
	if (d > 360 && random() < 0.9) return FALSE;

	org = self.origin;
	tgt = self.enemy.origin;
	if (!(self.enemy.flags & (FL_ONGROUND | FL_FLY)))
	{
		if (self.enemy.velocity_z > 0) return FALSE;
		traceline(tgt, tgt - '0 0 96', TRUE, self.enemy);
		if (trace_fraction == 1.0) return FALSE;
		tgt = (tgt + trace_endpos) * 0.5;
	}

	if (self.enemy.origin_z < self.origin_z - 16)
	{
		org_z += self.maxs_z;
		tgt_z += self.enemy.mins_z;
	}
	else if (self.enemy.origin_z > self.origin_z + 16)
	{
		org_z += self.mins_z;
		tgt_z += self.enemy.maxs_z;
	}
	traceline(org, tgt, TRUE, self);
	if (trace_fraction != 1.0) return FALSE;

	org   = self.origin;
	d     = hdist(tgt, org);
	tgt_z += BLWK_LEAP_VVEL * (d / BLWK_LEAP_HVEL);

	dir    = normalize(tgt - org);
	angles = vectoangles(dir);
	ang    = angles_x;
	if (ang > 90) ang -= 360;

	if (ang > 45 || ang < -5) return FALSE;

	self.speed = BLWK_LEAP_VEL;
	if (ang < 8)
	{
		self.speed -= (8 - ang) * 15;
		ang = 16 - ang;
	}
	self.height = ang;
	return Blwk_LeapCheckClearance(dir);
}

void() blwk_airthink =
{
	self.think     = blwk_airthink;
	self.nextthink = time + 0.1;

	if (time >= self.lifetime_finished)
	{
		blwk_jump1();
		return;
	}
	if (self.origin == self.oldorigin && self.flags & FL_ONGROUND)
	{
		blwk_jump11();
		return;
	}
	self.oldorigin = self.origin;
}

void() BlwkJumpTouchGround =
{
	if (!(self.flags & FL_ONGROUND)) return;

	self.touch = SUB_Null;

	if (checkbottom(self))
	{
		if (time < self.attack_finished)
			ai_attack_finished(1);
		blwk_jump11();
		return;
	}

	self.think     = blwk_jump1;
	self.nextthink = time + 0.1;
}

void() BlwkJumpTouch =
{
	local float ldmg;

	if (self.health <= 0)
		return;

	if (other.takedamage)
	{
		if (vlen(self.velocity) > 300)
		{
			if (other.classname != "player" || time > self.touch_time)
			{
				if (other.classname == "player")
					self.touch_time = time + 0.2;

				ldmg = 40 + 10 * random();
				T_Damage(other, self, self, ldmg);
				ai_attack_finished(0);
			}
		}
	}

	BlwkJumpTouchGround();
}

void() blwk_jump1	=[78, blwk_jump2 ] {
	ai_face();
	if (!self.height) { blwk_run1(); return; }
	ai_attack_finished(0.5);
	nmfast();
}
void() blwk_jump2	=[79, blwk_jump3 ] {nmfast(); ai_face();}
void() blwk_jump3	=[80, blwk_jump4 ] {nmfast(); ai_face();}
void() blwk_jump4	=[81, blwk_jump5 ] {nmfast(); ai_face(); Blwk_DoLeap();}
void() blwk_jump5	=[82, blwk_jump6 ] {nmfast();}
void() blwk_jump6	=[83, blwk_jump7 ] {nmfast();}
void() blwk_jump7	=[84, blwk_jump8 ] {nmfast();}
void() blwk_jump8	=[85, blwk_jump9 ] {nmfast();}
void() blwk_jump9	=[86, blwk_jump10] {nmfast();}
void() blwk_jump10	=[87, blwk_airthink] {nmfast();
	self.oldorigin        = self.origin;
	self.lifetime_finished = time + 3;
}
void() blwk_jump11	=[88, blwk_jump12] {nmfast();}
void() blwk_jump12	=[89, blwk_run1  ] {nmfast(); ai_face();}

// leaps at range, otherwise casts magic
void() blwk_missile =
{
	if (BlwkCheckLeap())
	{
		blwk_jump1();
		return;
	}

	// clear stale state and fall back to magic.
	self.speed  = BLWK_LEAP_VEL;
	self.height = 0;
	blwk_magic1();
};

//============================================================================
// PAIN
//============================================================================

void() blwk_pain1	=[90, blwk_pain2] {}
void() blwk_pain2	=[91, blwk_pain3] {}
void() blwk_pain3	=[92, blwk_pain4] {}
void() blwk_pain4	=[93, blwk_pain5] {}
void() blwk_pain5	=[94, blwk_pain6] {}
void() blwk_pain6	=[95, blwk_run1 ] {}

void(entity attacker, float damage) blwk_pain =
{
	if (self.health <= 0) return;
	if (self.touch == BlwkJumpTouch) return;	// don't flinch mid-leap
	if (self.pain_finished > time) return;
	if (random()*400 > damage) return;

	PainFinished(2);
	blwk_pain1();
}


//============================================================================
// ATTACK DECISION
//============================================================================

float() BlwkCheckAttack =
{
	if (enemy_range <= RANGE_MELEE && CheckClearAttack() && z_overlap(self.enemy))
	{
		if (vdist(self.origin, self.enemy.origin) > 95)
		{
			if (ai_charge(1))
			{
				self.attack_state = AS_MELEE;
				return TRUE;
			}
		}
		else
		{
			self.attack_state = AS_MELEE;
			return TRUE;
		}
	}

	if (time < self.attack_finished)
		return FALSE;
	if (!enemy_vis)
		return FALSE;

	if (has_invis(self.enemy))
	{
		if (random() < 0.1)
		{
			self.attack_state = AS_MELEE;
			return TRUE;
		}
	}

	if (!CheckClearAttack()) return FALSE;

	if (vlen(self.origin - enemy_vispos()) > BULWARK_MISSILE_RANGE)
		return FALSE;
	self.attack_state = AS_MISSILE;
	return TRUE;

	return FALSE;
}

//============================================================================
// DEATH
//============================================================================

float() blwk_checkgib =
{
	if (self.health <= 0)
	{
		Gib ("progs/gibs/gibhead_shambler.mdl", self.health);
		GibBloodBath(3);
		return TRUE;
	}
	return FALSE;
}

void() blwk_death1	=[96, blwk_death2 ] {if (blwk_checkgib()) return;}
void() blwk_death2	=[97, blwk_death3 ] {if (blwk_checkgib()) return;}
void() blwk_death3	=[98, blwk_death4 ] {if (blwk_checkgib()) return;}
void() blwk_death4	=[99, blwk_death5 ] {if (blwk_checkgib()) return; self.takedamage = DAMAGE_NO; self.solid = SOLID_NOT;}
void() blwk_death5	=[100, blwk_death6 ] {}
void() blwk_death6	=[101, blwk_death7 ] {}
void() blwk_death7	=[102, blwk_death8 ] {}
void() blwk_death8	=[103, blwk_death9 ] {}
void() blwk_death9	=[104, blwk_death10] {}
void() blwk_death10	=[105, blwk_death11] {}
void() blwk_death11	=[106, SUB_Null       ] {}

void() blwk_die =
{
	if (blwk_checkgib()) return;
	blwk_death1();
}

//============================================================================
// SPAWN
//============================================================================

void() monster_bulwark_spawn =
{
	self.classname = "monster_bulwark";
	self.solid = SOLID_SLIDEBOX;
	setmodel (self, "progs/placeholder_progs/mon_bulwark.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);

	self.th_stand		= blwk_stand1;
	self.th_walk		= blwk_walk1;
	self.th_run			= blwk_run1;
	self.th_die			= blwk_die;
	self.th_melee		= blwk_melee;
	self.th_missile		= blwk_missile;
	self.th_pain		= blwk_pain;
	self.th_checkattack	= BlwkCheckAttack;

	self.gibgroup = GIBGROUP_TAR_ALLOWED;

	if (self.deathtype == string_null)
		self.deathtype = "was crushed by a Bulwark";

	nmspeed(0.08);
	walkmonster_start();	
}

void() monster_bulwark_spawner = {mon_spawner_use(monster_bulwark_spawn);}

/*QUAKED monster_bulwark (1 0 0) (-32 -32 -24) (32 32 64) AMBUSH ? ? ? TRIGGERED NOTFOG NOTELEFRAG INSTAWAKE
Bulwark, 400 health points.

Flags:
"ambush"		only wake up on seeing the player, not another monster getting angry
"Triggered"		will not spawn until triggered - triggering again will wake it up. Set 'count' to make this a multi-use spawner.
"NoTfog"		suppress teleport glitter when spawned with 'triggered'
"NoTelefrag"	will silently fail to spawn if doing so would telefrag an existing monster. will try again automatically 2x/second until it succeeds.
"Instawake"		spawn angry at activator

Keys:
"target"		entity to trigger when killed
"targetname"	entity name
"movedir"		set to a velocity to make the monster jump on awakening
*/
/*FGD
@PointClass base(Monster) size(-32 -32 -24, 32 32 64) model({ "path": ":progs/placeholder_progs/mon_bulwark.mdl", "skin": skin }) = monster_bulwark : "Bulwark" []
*/
void() monster_bulwark =
{
	if (!SUB_ShouldSpawn()) return;
	if (nomonster()) return;
	if (deathmatch) { remove(self); return; }

	precache_model ("progs/placeholder_progs/mon_bulwark.mdl");
	precache_model ("progs/gibs/gibhead_shambler.mdl");
	precache_model ("progs/placeholder_progs/proj_magic_claw.mdl");
	precache_model ("progs/placeholder_progs/proj_magic_claw_trail.mdl");

	self.gibgroup = GIBGROUP_TAR_ALLOWED;
	self.health = 400;
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);

	if (monster_spawnsetup(monster_bulwark_spawner)) return;
	
	addmonster(1);
	monster_bulwark_spawn();
}
