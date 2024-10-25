//Decompiled code. Please respect the original copyright.

void(entity e, float a, float b) genHeal = {};

void() swarmer_stand1 = [ 0, swarmer_stand2 ]{ai_stand();	genHeal(self, 1, 0);};
void() swarmer_stand2 = [ 1, swarmer_stand3 ]{ai_stand();};
void() swarmer_stand3 = [ 2, swarmer_stand4 ]{ai_stand();};
void() swarmer_stand4 = [ 3, swarmer_stand5 ]{ai_stand();};
void() swarmer_stand5 = [ 4, swarmer_stand6 ]{ai_stand();};
void() swarmer_stand6 = [ 5, swarmer_stand7 ]{ai_stand();};
void() swarmer_stand7 = [ 6, swarmer_stand8 ]{ai_stand();};
void() swarmer_stand8 = [ 7, swarmer_stand9 ]{ai_stand();	genHeal(self, 1, 0);};
void() swarmer_stand9 = [ 8, swarmer_stand10 ]{ai_stand();};
void() swarmer_stand10 = [ 9, swarmer_stand11 ]{ai_stand();};
void() swarmer_stand11 = [ 10, swarmer_stand12 ]{ai_stand();};
void() swarmer_stand12 = [ 11, swarmer_stand13 ]{ai_stand();};
void() swarmer_stand13 = [ 12, swarmer_stand14 ]{ai_stand();};
void() swarmer_stand14 = [ 13, swarmer_stand15 ]{ai_stand();};
void() swarmer_stand15 = [ 14, swarmer_stand1 ]{ai_stand();};

void() swarmer_footStep = {
	local float rSnd;

	rSnd = random();
	if (rSnd < (1 / 5))	{
		sound(self, 5, "swarmer/footstep1.wav", 1, ATTN_NORM);
	}
	else if (rSnd < (2 / 5)) {
		sound(self, 5, "swarmer/footstep2.wav", 1, ATTN_NORM);
	}
	else if (rSnd < (3 / 5)) {
		sound(self, 5, "swarmer/footstep3.wav", 1, ATTN_NORM);
	}
	else if ((rSnd < (4 / 5))) {
		sound(self, 5, "swarmer/footstep4.wav", 1, ATTN_NORM);
	}
	else {
		sound(self, 5, "swarmer/footstep5.wav", 1, ATTN_NORM);
	}
};


void() swarmer_walk1 = [ 15, swarmer_walk2 ]{ai_walk(1);genHeal(self, 1, 0);};
void() swarmer_walk2 = [ 16, swarmer_walk3 ]{ai_walk(1);};
void() swarmer_walk3 = [ 17, swarmer_walk4 ]{ai_walk(0);};
void() swarmer_walk4 = [ 18, swarmer_walk5 ]{ai_walk(1);};
void() swarmer_walk5 = [ 19, swarmer_walk6 ]{ai_walk(2);};
void() swarmer_walk6 = [ 20, swarmer_walk7 ]{ai_walk(3);};
void() swarmer_walk7 = [ 21, swarmer_walk8 ]{ai_walk(4);};
void() swarmer_walk8 = [ 22, swarmer_walk9 ]{ai_walk(4);genHeal(self, 1, 0);};
void() swarmer_walk9 = [ 23, swarmer_walk10 ]{ai_walk(2);};
void() swarmer_walk10 = [ 24, swarmer_walk11 ]{ai_walk(0);};
void() swarmer_walk11 = [ 25, swarmer_walk12 ]{ai_walk(0);};
void() swarmer_walk12 = [ 26, swarmer_walk13 ]{ai_walk(0);};
void() swarmer_walk13 = [ 27, swarmer_walk14 ]{ai_walk(2);};
void() swarmer_walk14 = [ 28, swarmer_walk15 ]{ai_walk(4);};
void() swarmer_walk15 = [ 29, swarmer_walk16 ]{ai_walk(6);genHeal(self, 1, 0);};
void() swarmer_walk16 = [ 30, swarmer_walk17 ]{ai_walk(7);};
void() swarmer_walk17 = [ 31, swarmer_walk18 ]{ai_walk(3);};
void() swarmer_walk18 = [ 32, swarmer_walk1 ]{
	local float rSnd;

	ai_walk(8);
	rSnd = random();

	if ((rSnd < (1 / 4))) 
		sound(self, CHAN_VOICE, "swarmer/idle1.wav", 0.4, 3.5);
	else if ((rSnd < (2 / 4)))
		sound(self, CHAN_VOICE, "swarmer/idle2.wav", 0.4, 3.5);
	else if ((rSnd < (3 / 4)))
		sound(self, CHAN_VOICE, "swarmer/idle3.wav", 0.4, 3.5);
	else
		sound(self, CHAN_VOICE, "swarmer/idle4.wav", 0.4, 3.5);
};

void(float step) ai_swarmer_run = {
	vector _origin;
	float _count;
	//float dist;
	float eYaw;
	float loopStep;
	float enemy_range2D;
	vector vec;

	vector prev_org = self.origin;
	ai_run(step);
	if (self.origin == prev_org) return;

	_origin = self.origin;
	eYaw = vectoyaw(self.enemy.origin - self.origin);
	enemy_range2D = vlen([self.origin_x, self.origin_y, 0] - [self.enemy.origin_x, self.enemy.origin_y, 0]);

	if (enemy_vis) {
		if (enemy_range2D < 512) {
			if (enemy_range2D < 192)
				self.frame = (self.frame + 8);
			
			loopStep = 12;
			_count = floor(128 / loopStep);

			while (_count > 0) {
				_count = _count - 1;

				if (!walkmove(eYaw, loopStep))
					_count = -666;
				
			}

			setorigin(self, _origin);
			if (_count != -666) {
				self.ideal_yaw = eYaw + crandom();
				ChangeYaw();
				walkmove(eYaw, step);
				return;
			}
		}
	}

	movetogoal(1);
	walkmove2(self.angles_y, step - 1);
	vec_y = self.ideal_yaw;
	makevectors(vec);
	vec = (self.origin + (v_forward * 32));
	self.ideal_yaw = self.ideal_yaw + crandom();

	if (self.origin == _origin) {
		if (enemy_range == RANGE_MELEE) {
			self.ideal_yaw = eYaw;
			ChangeYaw();
		}
		else {
			self.ideal_yaw = (random() * 360);
			ChangeYaw();
		}
	}
	
};

void() swarmer_run1 = [ 33, swarmer_run2 ]{ai_swarmer_run(24);/*genHeal(self, 1, 0);*/};
void() swarmer_run2 = [ 34, swarmer_run3 ]{ai_swarmer_run(24);swarmer_footStep();};
void() swarmer_run3 = [ 35, swarmer_run4 ]{ai_swarmer_run(24);};
void() swarmer_run4 = [ 36, swarmer_run5 ]{ai_swarmer_run(24);};
void() swarmer_run5 = [ 37, swarmer_run6 ]{ai_swarmer_run(24);};
void() swarmer_run6 = [ 38, swarmer_run7 ]{ai_swarmer_run(24);swarmer_footStep();};
void() swarmer_run7 = [ 39, swarmer_run8 ]{ai_swarmer_run(24);};
void() swarmer_run8 = [ 40, swarmer_run1 ]{
	local float rSnd;
	ai_swarmer_run(24);
	if (time > self.air_finished) {
		rSnd = random();
		if (rSnd < (1 / 4))
			sound(self, CHAN_VOICE, "swarmer/idle5.wav", 0.4, 3.5);
		else if (rSnd < (2 / 4))
			sound(self, CHAN_VOICE, "swarmer/idle6.wav", 0.4, 3.5);
		else if (rSnd < (3 / 4))
			sound(self, CHAN_VOICE, "swarmer/idle7.wav", 0.4, 3.5);
		else
			sound(self, CHAN_VOICE, "swarmer/idle8.wav", 0.4, 3.5);

		self.air_finished = (time + 6) + (random() * 2);
	}
};

void() swarmer_meleeAttack =
{
	vector delta;
	float dist;
	float rSnd;

	if (!self.enemy) 
		return;
	
	delta = self.enemy.origin - self.origin;
	dist = vlen(delta);
	dist = (dist - self.enemy.maxs_x) - self.maxs_x;
	if (dist > 16)
		return;
	
	rSnd = random();

	if (rSnd < (1 / 4))
		sound(self, CHAN_WEAPON, "swarmer/punch1.wav", 1, ATTN_NORM);
	else if (rSnd < (2 / 4))
		sound(self, CHAN_WEAPON, "swarmer/punch2.wav", 1, ATTN_NORM);
	else if (rSnd < (3 / 4))
		sound(self, CHAN_WEAPON, "swarmer/punch3.wav", 1, ATTN_NORM);
	else
		sound(self, CHAN_WEAPON, "swarmer/punch4.wav", 1, ATTN_NORM);
			
	
	T_Damage(self.enemy, self, self, 4, DMGTYPE_MELEE);
};

//-----------------------------------------------------------------------------------------------------

void(float step) ai_swarmer_charge =
{
	ai_face();
	//walkmove_robust(self.angles_y, step, 10);
	walkmove2(self.angles_y, step);
};

void() swarmer_atkl1 = [ 49, swarmer_atkl2 ]{ai_swarmer_charge(24);};
void() swarmer_atkl2 = [ 50, swarmer_atkl3 ]{ai_swarmer_charge(24);};
void() swarmer_atkl3 = [ 51, swarmer_atkl4 ]{ai_swarmer_charge(24);};
void() swarmer_atkl4 = [ 52, swarmer_atkl5 ]{ai_swarmer_charge(24);swarmer_meleeAttack();};
void() swarmer_atkl5 = [ 53, swarmer_atkl6 ]{ai_swarmer_charge(24);};
void() swarmer_atkl6 = [ 54, swarmer_atkl7 ]{ai_swarmer_charge(24);};
void() swarmer_atkl7 = [ 55, swarmer_atkl8 ]{ai_swarmer_charge(24);};
void() swarmer_atkl8 = [ 56, swarmer_run1 ]{ai_swarmer_charge(24);};

void() swarmer_atkr1 = [ 57, swarmer_atkr2 ]{ai_swarmer_charge(24);};
void() swarmer_atkr2 = [ 58, swarmer_atkr3 ]{ai_swarmer_charge(24);};
void() swarmer_atkr3 = [ 59, swarmer_atkr4 ]{ai_swarmer_charge(24);};
void() swarmer_atkr4 = [ 60, swarmer_atkr5 ]{ai_swarmer_charge(24);swarmer_meleeAttack();};
void() swarmer_atkr5 = [ 61, swarmer_atkr6 ]{ai_swarmer_charge(24);};
void() swarmer_atkr6 = [ 62, swarmer_atkr7 ]{ai_swarmer_charge(24);};
void() swarmer_atkr7 = [ 63, swarmer_atkr8 ]{ai_swarmer_charge(24);};
void() swarmer_atkr8 = [ 64, swarmer_run1 ]{ai_swarmer_charge(24);};

void() swarmer_atkm1 = [ 65, swarmer_atkm2 ]{ai_swarmer_charge(24);};
void() swarmer_atkm2 = [ 66, swarmer_atkm3 ]{ai_swarmer_charge(24);};
void() swarmer_atkm3 = [ 67, swarmer_atkm4 ]{ai_swarmer_charge(24);};
void() swarmer_atkm4 = [ 68, swarmer_atkm5 ]{ai_swarmer_charge(24);swarmer_meleeAttack();};
void() swarmer_atkm5 = [ 69, swarmer_atkm6 ]{ai_swarmer_charge(24);};
void() swarmer_atkm6 = [ 70, swarmer_atkm7 ]{ai_swarmer_charge(24);};
void() swarmer_atkm7 = [ 71, swarmer_atkm8 ]{ai_swarmer_charge(24);};
void() swarmer_atkm8 = [ 72, swarmer_run1 ]{ai_swarmer_charge(24);};

void() swarmer_melee =
{
	local float r;

	r = random();

	if (r < (1 / 7)) 
		sound(self, CHAN_VOICE, "swarmer/attack1.wav", 1, ATTN_NORM);
	else if (r < (2 / 7))
		sound(self, CHAN_VOICE, "swarmer/attack2.wav", 1, ATTN_NORM);
	else if (r < (3 / 7))
		sound(self, CHAN_VOICE, "swarmer/attack3.wav", 1, ATTN_NORM);
	else if (r < (4 / 7))
		sound(self, CHAN_VOICE, "swarmer/attack4.wav", 1, ATTN_NORM);
	else if (r < (5 / 7))
		sound(self, CHAN_VOICE, "swarmer/attack5.wav", 1, ATTN_NORM);
	else if (r < (6 / 7))
		sound(self, CHAN_VOICE, "swarmer/attack6.wav", 1, ATTN_NORM);
	else
		sound(self, CHAN_VOICE, "swarmer/attack7.wav", 1, ATTN_NORM);
		
	if (random() < 0.75) {
		if (self.state) swarmer_atkl1();
		else swarmer_atkr1();

		self.state = (1 - self.state);
	}
	else {
		swarmer_atkm1();
	}
};

void() swarmer_deathA1 = [ 73, swarmer_deathA2 ]{};
void() swarmer_deathA2 = [ 74, swarmer_deathA3 ]{ai_pain(8);};
void() swarmer_deathA3 = [ 75, swarmer_deathA4 ]{ai_pain(5);};
void() swarmer_deathA4 = [ 76, swarmer_deathA5 ]{ai_pain(3);};
void() swarmer_deathA5 = [ 77, swarmer_deathA6 ]{ai_pain(1);};
void() swarmer_deathA6 = [ 78, swarmer_deathA7 ]{ai_pain(2);};
void() swarmer_deathA7 = [ 79, swarmer_deathA8 ]{ai_pain(1);};
void() swarmer_deathA8 = [ 80, swarmer_deathA9 ]{ai_pain(1);};
void() swarmer_deathA9 = [ 81, swarmer_deathA10 ]{ai_pain(2);};
void() swarmer_deathA10 = [ 82, swarmer_deathA11 ]{};
void() swarmer_deathA11 = [ 83, SUB_Null ]{};

void() swarmer_deathB1 = [ 84, swarmer_deathB2 ]{ai_pain(16 + random()*8);};
void() swarmer_deathB2 = [ 85, swarmer_deathB3 ]{ai_pain(16 + random()*8);};
void() swarmer_deathB3 = [ 86, swarmer_deathB4 ]{ai_pain(16 + random() * 8);};
void() swarmer_deathB4 = [ 87, swarmer_deathB5 ]{ai_pain(8);};
void() swarmer_deathB5 = [ 88, swarmer_deathB6 ]{ai_pain(4);};
void() swarmer_deathB6 = [ 89, swarmer_deathB7 ]{};
void() swarmer_deathB7 = [ 90, swarmer_deathB8 ]{};
void() swarmer_deathB8 = [ 91, swarmer_deathB9 ]{};
void() swarmer_deathB9 = [ 92, SUB_Null ]{};

void() swarmer_deathC1 = [ 93, swarmer_deathC2 ]{};
void() swarmer_deathC2 = [ 94, swarmer_deathC3 ]{};
void() swarmer_deathC3 = [ 95, swarmer_deathC4 ]{};
void() swarmer_deathC4 = [ 96, swarmer_deathC5 ]{};
void() swarmer_deathC5 = [ 97, swarmer_deathC6 ]{};
void() swarmer_deathC6 = [ 98, swarmer_deathC7 ]{};
void() swarmer_deathC7 = [ 99, swarmer_deathC8 ]{};
void() swarmer_deathC8 = [ 100, swarmer_deathC9 ]{};
void() swarmer_deathC9 = [ 101, swarmer_deathC10 ]{walkmove2(self.angles_y+90, 2);};
void() swarmer_deathC10 = [ 102, swarmer_deathC11 ]{walkmove2(self.angles_y+90, 6);};
void() swarmer_deathC11 = [ 103, SUB_Null ]{};

void() swarmer_deathD1 = [ 104, swarmer_deathD2 ]{ai_swarmer_charge(24);};
void() swarmer_deathD2 = [ 105, swarmer_deathD3 ]{ai_swarmer_charge(20);};
void() swarmer_deathD3 = [ 106, swarmer_deathD4 ]{ai_swarmer_charge(16);};
void() swarmer_deathD4 = [ 107, swarmer_deathD5 ]{ai_forward(14);};
void() swarmer_deathD5 = [ 108, swarmer_deathD6 ]{ai_forward(8);};
void() swarmer_deathD6 = [ 109, swarmer_deathD7 ]{ai_forward(4);};
void() swarmer_deathD7 = [ 110, swarmer_deathD8 ]{};
void() swarmer_deathD8 = [ 111, swarmer_deathD9 ]{};
void() swarmer_deathD9 = [ 112, swarmer_deathD10 ]{};
void() swarmer_deathD10 = [ 113, SUB_Null ]{};

float() swarmer_checkgib =
{	
	if (self.health < -40)
	{
		Gib("progs/h_zombie.mdl", self.health);
		return TRUE;
	}
	return FALSE;
}


void() swarmer_die =
{
	local float r;

// check for gib
	if (swarmer_checkgib())
		return;


	r = random();
	if (r < (1 / 3))
		sound(self, CHAN_VOICE, "swarmer/death1.wav", 1, ATTN_NORM);
	else if ((r < (2 / 3)))
		sound(self, CHAN_VOICE, "swarmer/death2.wav", 1, ATTN_NORM);
	else
		sound(self, CHAN_VOICE, "swarmer/death3.wav", 1, ATTN_NORM);

	r = random();
	
	self.solid = SOLID_TRIGGER;
	setorigin(self, self.origin);
	
	if (r < (1 / 4))
		swarmer_deathA1();
	else if (r < (2 / 4))
		swarmer_deathB1();
	else if (r < (3 / 4))
		swarmer_deathC1();
	else
		swarmer_deathD1();
};

void(entity attacker, float take) swarmer_pain = {
	return;
};

void() monster_swarmer_precaches =
{
	precache_model("progs/swarmer.mdl");
	precache_model("progs/h_zombie.mdl");
	precache_model("progs/zom_gib.mdl");
	precache_sound("swarmer/sight1.wav");
	precache_sound("swarmer/sight2.wav");
	precache_sound("swarmer/sight3.wav");
	precache_sound("swarmer/idle1.wav");
	precache_sound("swarmer/idle2.wav");
	precache_sound("swarmer/idle3.wav");
	precache_sound("swarmer/idle4.wav");
	precache_sound("swarmer/idle5.wav");
	precache_sound("swarmer/idle6.wav");
	precache_sound("swarmer/idle7.wav");
	precache_sound("swarmer/idle8.wav");
	precache_sound("swarmer/footstep1.wav");
	precache_sound("swarmer/footstep2.wav");
	precache_sound("swarmer/footstep3.wav");
	precache_sound("swarmer/footstep4.wav");
	precache_sound("swarmer/footstep5.wav");
	precache_sound("swarmer/attack1.wav");
	precache_sound("swarmer/attack2.wav");
	precache_sound("swarmer/attack3.wav");
	precache_sound("swarmer/attack4.wav");
	precache_sound("swarmer/attack5.wav");
	precache_sound("swarmer/attack6.wav");
	precache_sound("swarmer/attack7.wav");
	precache_sound("swarmer/punch1.wav");
	precache_sound("swarmer/punch2.wav");
	precache_sound("swarmer/punch3.wav");
	precache_sound("swarmer/punch4.wav");
	precache_sound("swarmer/death1.wav");
	precache_sound("swarmer/death2.wav");
	precache_sound("swarmer/death3.wav");
	precache_sound("zombie/z_gib.wav");
};


void() monster_swarmer_spawn =
{
	self.classname = "monster_swarmer";
	self.solid = SOLID_SLIDEBOX;

	setmodel(self, "progs/swarmer.mdl");

	setsize(self, '-6 -6 -24', '6 6 32');
	
	self.health = 10;

		
	self.th_stand = swarmer_stand1;
	self.th_walk = swarmer_walk1;
	self.th_run = swarmer_run1;
	self.th_pain = swarmer_pain;
	self.th_die = swarmer_die;
	self.th_melee = swarmer_melee;
	self.yaw_speed = 35;
	
	if (self.deathtype == string_null)
		self.deathtype = "was swarmed by a Swarmer";

	walkmonster_start ();

};

void() monster_swarmer_spawner = {mon_spawner_use(monster_swarmer_spawn);};

/*QUAKED monster_swarmer (1 0 0) (-16 -16 -24) (16 16 32) AMBUSH ? ? ? TRIGGERED NOTFOG NOTELEFRAG INSTAWAKE
Swarmer, 10 health points.

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
@PointClass base(Monster) size(-16 -16 -24, 16 16 32) model({ "path": ":progs/swarmer.mdl" }) = monster_swarmer : "Swarmer" []
*/
void() monster_swarmer =
{
	if (!SUB_ShouldSpawn()) return;
	if (nomonster()) return;
	if (deathmatch)
	{
		remove(self);
		return;
	}
	
	monster_swarmer_precaches();
	
	self.health = 10;
	setsize(self, '-6 -6 -24', '6 6 32');
	
	if ( monster_spawnsetup( monster_swarmer_spawner ) ) return;
	
	addmonster(1);
	monster_swarmer_spawn();
};
