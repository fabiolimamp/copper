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

$frame amalg_idle1 amalg_idle2 amalg_idle3 amalg_idle4 amalg_idle5
$frame amalg_idle6 amalg_idle7 amalg_idle8 amalg_idle9 amalg_idle10
$frame amalg_idle11 amalg_idle12 amalg_idle13 amalg_idle14 amalg_idle15
$frame amalg_idle16 amalg_idle17 amalg_idle18 amalg_idle19 amalg_idle20
$frame amalg_idle21 amalg_idle22 amalg_idle23 amalg_idle24 amalg_idle25
$frame amalg_idle26 amalg_idle27 amalg_idle28 amalg_idle29 amalg_idle30
$frame amalg_idle31 amalg_idle32 amalg_idle33 amalg_idle34 amalg_idle35
$frame amalg_idle36 amalg_idle37 amalg_idle38 amalg_idle39

$frame shoot1 shoot2 shoot3 shoot4 shoot5 shoot6 shoot7
$frame shoot8 shoot9 shoot10 shoot11 shoot12

$frame death1 death2 death3 death4 death5 death6 death7 death8 death9
$frame death10 death11 death12 death13 death14 death15 death16

$frame amalg_pain1 amalg_pain2 amalg_pain3 amalg_pain4
$frame amalg_painb1 amalg_painb2 amalg_painb3 amalg_painb4 amalg_painb5 amalg_painb6

/*
==============================================================================
toothy CODE
==============================================================================
*/

void() amalgam_ai_stand =
{
	if (FindTarget ())
		return;
	
	if (time > self.pausetime && self.goalentity)
	{
		self.th_walk ();
		return;
	}
}

void()	amalgam_stand1	=[	$amalg_idle1,	amalgam_stand2	] {amalgam_ai_stand(); AmalgamIdleNoise();}
void()	amalgam_stand2	=[	$amalg_idle2,	amalgam_stand3	] {amalgam_ai_stand();}
void()	amalgam_stand3	=[	$amalg_idle3,	amalgam_stand4	] {amalgam_ai_stand();}
void()	amalgam_stand4	=[	$amalg_idle4,	amalgam_stand5	] {amalgam_ai_stand();}
void()	amalgam_stand5	=[	$amalg_idle5,	amalgam_stand6	] {amalgam_ai_stand();}
void()	amalgam_stand6	=[	$amalg_idle6,	amalgam_stand7	] {amalgam_ai_stand();}
void()	amalgam_stand7	=[	$amalg_idle7,	amalgam_stand8	] {amalgam_ai_stand();}
void()	amalgam_stand8	=[	$amalg_idle8,	amalgam_stand9	] {amalgam_ai_stand();}
void()	amalgam_stand9	=[	$amalg_idle9,	amalgam_stand10	] {amalgam_ai_stand();}
void()	amalgam_stand10	=[	$amalg_idle10,	amalgam_stand11	] {amalgam_ai_stand();}
void()	amalgam_stand11	=[	$amalg_idle11,	amalgam_stand12	] {amalgam_ai_stand();}
void()	amalgam_stand12	=[	$amalg_idle12,	amalgam_stand13	] {amalgam_ai_stand();}
void()	amalgam_stand13	=[	$amalg_idle13,	amalgam_stand14	] {amalgam_ai_stand();}
void()	amalgam_stand14	=[	$amalg_idle14,	amalgam_stand15	] {amalgam_ai_stand();}
void()	amalgam_stand15	=[	$amalg_idle15,	amalgam_stand16	] {amalgam_ai_stand();}
void()	amalgam_stand16	=[	$amalg_idle16,	amalgam_stand17	] {amalgam_ai_stand();}
void()	amalgam_stand17	=[	$amalg_idle17,	amalgam_stand18	] {amalgam_ai_stand(); AmalgamIdleNoise();}
void()	amalgam_stand18	=[	$amalg_idle18,	amalgam_stand19	] {amalgam_ai_stand();}
void()	amalgam_stand19	=[	$amalg_idle19,	amalgam_stand20	] {amalgam_ai_stand();}
void()	amalgam_stand20	=[	$amalg_idle20,	amalgam_stand21	] {amalgam_ai_stand();}
void()	amalgam_stand21	=[	$amalg_idle21,	amalgam_stand22	] {amalgam_ai_stand();}
void()	amalgam_stand22	=[	$amalg_idle22,	amalgam_stand23	] {amalgam_ai_stand();}
void()	amalgam_stand23	=[	$amalg_idle23,	amalgam_stand24	] {amalgam_ai_stand();}
void()	amalgam_stand24	=[	$amalg_idle24,	amalgam_stand25	] {amalgam_ai_stand();}
void()	amalgam_stand25	=[	$amalg_idle25,	amalgam_stand26	] {amalgam_ai_stand();}
void()	amalgam_stand26	=[	$amalg_idle26,	amalgam_stand27	] {amalgam_ai_stand();}
void()	amalgam_stand27	=[	$amalg_idle27,	amalgam_stand28	] {amalgam_ai_stand();}
void()	amalgam_stand28	=[	$amalg_idle28,	amalgam_stand29	] {amalgam_ai_stand();}
void()	amalgam_stand29	=[	$amalg_idle29,	amalgam_stand30	] {amalgam_ai_stand();}
void()	amalgam_stand30	=[	$amalg_idle30,	amalgam_stand31	] {amalgam_ai_stand();}
void()	amalgam_stand31	=[	$amalg_idle31,	amalgam_stand32	] {amalgam_ai_stand();}
void()	amalgam_stand32	=[	$amalg_idle32,	amalgam_stand33	] {amalgam_ai_stand();}
void()	amalgam_stand33	=[	$amalg_idle33,	amalgam_stand34	] {amalgam_ai_stand();}
void()	amalgam_stand34	=[	$amalg_idle34,	amalgam_stand35	] {amalgam_ai_stand();}
void()	amalgam_stand35	=[	$amalg_idle35,	amalgam_stand36	] {amalgam_ai_stand();}
void()	amalgam_stand36	=[	$amalg_idle36,	amalgam_stand37	] {amalgam_ai_stand();}
void()	amalgam_stand37	=[	$amalg_idle37,	amalgam_stand38	] {amalgam_ai_stand();}
void()	amalgam_stand38	=[	$amalg_idle38,	amalgam_stand39	] {amalgam_ai_stand();}
void()	amalgam_stand39	=[	$amalg_idle39,	amalgam_stand1	] {amalgam_ai_stand();}


void()	amalgam_walk1	=[	$amalg_idle1,	amalgam_walk2	] {ai_walk(1); AmalgamIdleNoise();}
void()	amalgam_walk2	=[	$amalg_idle2,	amalgam_walk3	] {ai_walk(1);}
void()	amalgam_walk3	=[	$amalg_idle3,	amalgam_walk4	] {ai_walk(1);}
void()	amalgam_walk4	=[	$amalg_idle4,	amalgam_walk5	] {ai_walk(1);}
void()	amalgam_walk5	=[	$amalg_idle5,	amalgam_walk6	] {ai_walk(2);}
void()	amalgam_walk6	=[	$amalg_idle6,	amalgam_walk7	] {ai_walk(3);}
void()	amalgam_walk7	=[	$amalg_idle7,	amalgam_walk8	] {ai_walk(4);}
void()	amalgam_walk8	=[	$amalg_idle8,	amalgam_walk9	] {ai_walk(4);}
void()	amalgam_walk9	=[	$amalg_idle9,	amalgam_walk10	] {ai_walk(2);}
void()	amalgam_walk10	=[	$amalg_idle10,	amalgam_walk11	] {ai_walk(2);}
void()	amalgam_walk11	=[	$amalg_idle11,	amalgam_walk12	] {ai_walk(2);}
void()	amalgam_walk12	=[	$amalg_idle12,	amalgam_walk13	] {ai_walk(1);}
void()	amalgam_walk13	=[	$amalg_idle13,	amalgam_walk14	] {ai_walk(0);}
void()	amalgam_walk14	=[	$amalg_idle14,	amalgam_walk15	] {ai_walk(1);}
void()	amalgam_walk15	=[	$amalg_idle15,	amalgam_walk16	] {ai_walk(1);}
void()	amalgam_walk16	=[	$amalg_idle16,	amalgam_walk17	] {ai_walk(1);}
void()	amalgam_walk17	=[	$amalg_idle17,	amalgam_walk18	] {ai_walk(3); AmalgamIdleNoise();}
void()	amalgam_walk18	=[	$amalg_idle18,	amalgam_walk19	] {ai_walk(3);}
void()	amalgam_walk19	=[	$amalg_idle19,	amalgam_walk20	] {ai_walk(3);}
void()	amalgam_walk20	=[	$amalg_idle20,	amalgam_walk21	] {ai_walk(3);}
void()	amalgam_walk21	=[	$amalg_idle21,	amalgam_walk22	] {ai_walk(2);}
void()	amalgam_walk22	=[	$amalg_idle22,	amalgam_walk23	] {ai_walk(1);}
void()	amalgam_walk23	=[	$amalg_idle23,	amalgam_walk24	] {ai_walk(1);}
void()	amalgam_walk24	=[	$amalg_idle24,	amalgam_walk25	] {ai_walk(1);}
void()	amalgam_walk25	=[	$amalg_idle13,	amalgam_walk26	] {ai_walk(0);}
void()	amalgam_walk26	=[	$amalg_idle14,	amalgam_walk27	] {ai_walk(1);}
void()	amalgam_walk27	=[	$amalg_idle15,	amalgam_walk28	] {ai_walk(1);}
void()	amalgam_walk28	=[	$amalg_idle16,	amalgam_walk29	] {ai_walk(1);}
void()	amalgam_walk29	=[	$amalg_idle17,	amalgam_walk30	] {ai_walk(3);}
void()	amalgam_walk30	=[	$amalg_idle18,	amalgam_walk31	] {ai_walk(3);}
void()	amalgam_walk31	=[	$amalg_idle19,	amalgam_walk32	] {ai_walk(3);}
void()	amalgam_walk32	=[	$amalg_idle20,	amalgam_walk33	] {ai_walk(3);}
void()	amalgam_walk33	=[	$amalg_idle21,	amalgam_walk34	] {ai_walk(2);}
void()	amalgam_walk34	=[	$amalg_idle22,	amalgam_walk35	] {ai_walk(1);}
void()	amalgam_walk35	=[	$amalg_idle23,	amalgam_walk36	] {ai_walk(1);}
void()	amalgam_walk36	=[	$amalg_idle24,	amalgam_walk37	] {ai_walk(1);}
void()	amalgam_walk37	=[	$amalg_idle22,	amalgam_walk38	] {ai_walk(1);}
void()	amalgam_walk38	=[	$amalg_idle23,	amalgam_walk39	] {ai_walk(1);}
void()	amalgam_walk39	=[	$amalg_idle24,	amalgam_walk1	] {ai_walk(1);}

void() AmalgamIdleNoise =
{
	if (random() < 0.4)
	sound (self, CHAN_VOICE, "amalg/amalgidle.wav", 1, ATTN_IDLE);
}

void()	amalgam_run1	=[	$amalg_idle1,	amalgam_run2	] {
	if (random() < 0.4)
		sound (self, CHAN_VOICE, "amalg/amalgidle.wav", 1, ATTN_IDLE);
	ai_run(16);}
void()	amalgam_run2	=[	$amalg_idle2,	amalgam_run3	] {ai_run(8);}
void()	amalgam_run3	=[	$amalg_idle3,	amalgam_run4	] {ai_run(8);}
void()	amalgam_run4	=[	$amalg_idle4,	amalgam_run5	] {ai_run(8);}
void()	amalgam_run5	=[	$amalg_idle5,	amalgam_run6	] {ai_run(8);}
void()	amalgam_run6	=[	$amalg_idle6,	amalgam_run7	] {ai_run(8);}
void()	amalgam_run7	=[	$amalg_idle7,	amalgam_run8	] {ai_run(8);}
void()	amalgam_run8	=[	$amalg_idle8,	amalgam_run9	] {ai_run(8);}
void()	amalgam_run9	=[	$amalg_idle9,	amalgam_run10	] {ai_run(8);}
void()	amalgam_run10	=[	$amalg_idle10,	amalgam_run11	] {ai_run(8);}
void()	amalgam_run11	=[	$amalg_idle11,	amalgam_run12	] {ai_run(8);}
void()	amalgam_run12	=[	$amalg_idle12,	amalgam_run13	] {ai_run(8);}
void()	amalgam_run13	=[	$amalg_idle13,	amalgam_run14	] {ai_run(8);}
void()	amalgam_run14	=[	$amalg_idle14,	amalgam_run15	] {ai_run(8);}
void()	amalgam_run15	=[	$amalg_idle15,	amalgam_run16	] {ai_run(8);}
void()	amalgam_run16	=[	$amalg_idle16,	amalgam_run17	] {ai_run(8);}
void()	amalgam_run17	=[	$amalg_idle17,	amalgam_run18	] {ai_run(8);}
void()	amalgam_run18	=[	$amalg_idle18,	amalgam_run19	] {ai_run(8);}
void()	amalgam_run19	=[	$amalg_idle19,	amalgam_run20	] {ai_run(8);}
void()	amalgam_run20	=[	$amalg_idle20,	amalgam_run21	] {ai_run(8);}
void()	amalgam_run21	=[	$amalg_idle21,	amalgam_run22	] {ai_run(8);}
void()	amalgam_run22	=[	$amalg_idle22,	amalgam_run23	] {ai_run(8);}
void()	amalgam_run23	=[	$amalg_idle23,	amalgam_run24	] {ai_run(8);}
void()	amalgam_run24	=[	$amalg_idle24,	amalgam_run25	] {ai_run(8);}
void()	amalgam_run25	=[	$amalg_idle13,	amalgam_run26	] {ai_run(8);}
void()	amalgam_run26	=[	$amalg_idle14,	amalgam_run27	] {ai_run(8);}
void()	amalgam_run27	=[	$amalg_idle15,	amalgam_run28	] {ai_run(8);}
void()	amalgam_run28	=[	$amalg_idle16,	amalgam_run29	] {ai_run(8);}
void()	amalgam_run29	=[	$amalg_idle17,	amalgam_run30	] {ai_run(8);}
void()	amalgam_run30	=[	$amalg_idle18,	amalgam_run31	] {ai_run(8);}
void()	amalgam_run31	=[	$amalg_idle19,	amalgam_run32	] {ai_run(8);}
void()	amalgam_run32	=[	$amalg_idle20,	amalgam_run33	] {ai_run(8);}
void()	amalgam_run33	=[	$amalg_idle21,	amalgam_run34	] {ai_run(8);}
void()	amalgam_run34	=[	$amalg_idle22,	amalgam_run35	] {ai_run(8);}
void()	amalgam_run35	=[	$amalg_idle23,	amalgam_run36	] {ai_run(8);}
void()	amalgam_run36	=[	$amalg_idle24,	amalgam_run37	] {ai_run(8);}
void()	amalgam_run37	=[	$amalg_idle22,	amalgam_run38	] {ai_run(8);}
void()	amalgam_run38	=[	$amalg_idle23,	amalgam_run39	] {ai_run(8);}
void()	amalgam_run39	=[	$amalg_idle24,	amalgam_run1	] {ai_run(8);}
/*
void()	amalgam_atk1	=[	$shoot1,	amalgam_atk2	] {ai_face();}
void()	amalgam_atk2	=[	$shoot2,	amalgam_atk3	] {ai_face();}
void()	amalgam_atk3	=[	$shoot3,	amalgam_atk4	] {ai_face();}
void()	amalgam_atk4	=[	$shoot4,	amalgam_atk5	] {ai_face();}
void()	amalgam_atk5	=[	$shoot5,	amalgam_atk6	] {ai_face();}
void()	amalgam_atk6	=[	$shoot6,	amalgam_atk7	] {ai_face();}
void()	amalgam_atk7	=[	$shoot7,	amalgam_atk8	] {ai_face();}
void()	amalgam_atk8	=[	$shoot8,	amalgam_atk9	] {ai_face(); amalgam_fire();}
void()	amalgam_atk9	=[	$shoot9,	amalgam_atk10	] {ai_face(); amalgam_fire(); amalgam_fire();}
void()	amalgam_atk10	=[	$shoot10,	amalgam_atk11	] {ai_face(); amalgam_fire();}
void()	amalgam_atk11	=[	$shoot11,	amalgam_atk12	] {ai_face(); amalgam_fire(); amalgam_fire();}
void()	amalgam_atk12	=[	$shoot12,	amalgam_run1	] {ai_face();}
*/
void()	amalgam_atk1	=[	$shoot1,	amalgam_atk2	] {
	self.movetype = MOVETYPE_FLY; //MOVETYPE_STEP apparently doesn't get avelocity applied
	self.avelocity_y = 200;
}
void()	amalgam_atk2	=[	$shoot2,	amalgam_atk3	] {}
void()	amalgam_atk3	=[	$shoot3,	amalgam_atk4	] {}
void()	amalgam_atk4	=[	$shoot4,	amalgam_atk5	] {}
void()	amalgam_atk5	=[	$shoot5,	amalgam_atk6	] {}
void()	amalgam_atk6	=[	$shoot6,	amalgam_atk7	] {}
void()	amalgam_atk7	=[	$shoot7,	amalgam_atk8	] {}
void()	amalgam_atk8	=[	$shoot8,	amalgam_atk9	] {amalgam_fire();}
void()	amalgam_atk9	=[	$shoot9,	amalgam_atk10	] {amalgam_fire(); amalgam_fire();}
void()	amalgam_atk10	=[	$shoot10,	amalgam_atk11	] {amalgam_fire();}
void()	amalgam_atk11	=[	$shoot11,	amalgam_atk12	] {amalgam_fire(); amalgam_fire();}
void()	amalgam_atk12	=[	$shoot12,	amalgam_run1	] {}

void()	amalg_pain1	=[	$amalg_pain1,		amalg_pain2	] {self.avelocity_y = 0;}
void()	amalg_pain2	=[	$amalg_pain2,		amalg_pain3	] {}
void()	amalg_pain3	=[	$amalg_pain3,		amalg_pain4	] {}
void()	amalg_pain4	=[	$amalg_pain4,		amalgam_run1	] {}

void()	amalg_painb1	=[	$amalg_painb1,	amalg_painb2	] {self.avelocity_y = 0;}
void()	amalg_painb2	=[	$amalg_painb2,	amalg_painb3	] {ai_painforward(13);}
void()	amalg_painb3	=[	$amalg_painb3,	amalg_painb4	] {ai_painforward(9);}
void()	amalg_painb4	=[	$amalg_painb4,	amalg_painb5	] {}
void()	amalg_painb5	=[	$amalg_painb5,	amalg_painb6	] {}
void()	amalg_painb6	=[	$amalg_painb6,	amalgam_run1	] {}

void(entity attacker, float damage)	amalg_pain =
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
			amalg_pain1 ();
		}
		else if (r < 0.5)
		{
			PainFinished(3);
			AmalGoop_Spam(5);
			amalg_painb1 ();
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

	sound (self, CHAN_WEAPON, "amalg/amalgshoot.wav", 1, ATTN_NORM);

	makevectors (self.angles);
	gorg = self.origin + v_forward * 16;
	gvel = OgreAimGrenade(enemy_vispos() - gorg, 432 + (random() * 200), -15 + random() * 45);

    goop = toss_projectile(gorg, gvel, "goop");
	goop.solid = SOLID_TRIGGER;
	goop.movetype = MOVETYPE_TOSS;
	goop.classname = "AmalGoop";

	if (skill != 3)
	{
		goop.touch = AmalGoop_Touch;
		setmodel(goop, "progs/proj_amalgoop.mdl");
		goop.dmg = 8;
	}
	else if (random() < 0.2)
	{
		goop.touch = amalgamNightmareBoom;
		setmodel(goop, "progs/proj_amalgoop_explo.mdl");
		goop.dmg = 35;
	}
	else
	{
		goop.touch = AmalGoop_Touch;
		setmodel(goop, "progs/proj_amalgoop.mdl");
		goop.dmg = 8;
	}

	setsize (goop, '0 0 0', '0 0 0');
	//goop.angles_y = (random() * (random() * 256));
	//goop.avelocity = '10 150 10';
	
	local vector goop_spin;
	goop_spin_y = (random() * 1000);
	
	goop.avelocity = goop_spin;
	goop.skin = self.skin;

	goop.think = SUB_Remove;
	goop.nextthink = time + 15;
}

void() amalgamNightmareBoom = 
{
	if (!CheckValidTouch()) return;
	if (other.flags & FL_MONSTER) return;
	if (self.attack_finished > time) return;

	kaboom(self.origin, self.dmg, self, TRUE);
	SUB_Remove();
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
	if (enemy_range <= RANGE_MELEE)
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
void()	amalgam_die2	=[	$death2,	amalgam_die3	] {SpawnMeatUndConcreteBurst(self.origin + v_forward*16, crandom() * 100 * v_right, 5, FALSE);}
void()	amalgam_die3	=[	$death3,	amalgam_die4	] {self.solid = SOLID_NOT;}
void()	amalgam_die4	=[	$death4,	amalgam_die5	] {}
void()	amalgam_die5	=[	$death5,	amalgam_die6	] {}
void()	amalgam_die6	=[	$death6,	amalgam_die7	] {}
void()	amalgam_die7	=[	$death7,	amalgam_die8	] {}
void()	amalgam_die8	=[	$death8,	amalgam_die9	] {}
void()	amalgam_die9	=[	$death9,	amalgam_die10	] {}
void()	amalgam_die10	=[	$death10,	amalgam_die11	] {SpawnMeatUndConcreteBurst(self.origin + v_forward*16, crandom() * 100 * v_right, 5, FALSE);}
void()	amalgam_die11	=[	$death11,	amalgam_die12	] {AmalGoop_Spam(2);}
void()	amalgam_die12	=[	$death12,	amalgam_die13	] {AmalGoop_Spam(2);}
void()	amalgam_die13	=[	$death13,	amalgam_die14	] {AmalGoop_Spam(2);}
void()	amalgam_die14	=[	$death14,	amalgam_die15	] {AmalGoop_Spam(1);}
void()	amalgam_die15	=[	$death15,	amalgam_die16	] {AmalGoop_Spam(1);}
void()	amalgam_die16	=[	$death16,	amalgam_die17	] {SpawnMeatUndConcreteBurst(self.origin + v_forward*16, crandom() * 100 * v_right, 5, FALSE);}
void()	amalgam_die17	=[	$death16,	SUB_Null		] {AmalGoop_Spam(4); GoopBlood(1); remove(self);}


void() amalgam_gib =
{
	AmalGoop_Spam(12);
	
	SpawnMeatUndConcreteBurst(self.origin, GibVelocityComplete(self, self.health), 12, TRUE);

	GoopBlood(1);
	remove(self);
};


void(vector org, vector vel, float count, float randomOrigin) SpawnMeatUndConcreteBurst =
{
    local float i;
    local vector randvel;

    for (i = 0; i < count; i = i + 1)
    {
        randvel = vel;
        randvel = randvel + v_right * (crandom() * 200);
        randvel = randvel + v_up * (crandom() * 200);
        randvel = randvel + v_forward * (crandom() * 200);

        if (randomOrigin) {
        	org_x += crandom() * 24;
        	org_y += crandom() * 24;
        	org_z += crandom() * 50 + 24;
        }
        SpawnMeatUndConcreteSpray(org, randvel);
    }
};


void(vector org, vector vel) SpawnMeatUndConcreteSpray =
{
    entity meat;
    vector mvel;
    float r;
    string gibmdl;

    mvel = vel;
    mvel_z += 250 + 50 * random();

    meat = toss_projectile(org, mvel, "gib");
    meat.type = "gib";
    meat.avelocity = '3000 1000 2000';
    meat.lifetime_finished = time + 30;

    r = floor(random() * 9);

    if (r == 0)
        gibmdl = "progs/gibs/gib_conc_1.mdl";
    else if (r == 1)
        gibmdl = "progs/gibs/gib_conc_2.mdl";
    else if (r == 2)
        gibmdl = "progs/gibs/gib_conc_3.mdl";
    else if (r == 3)
        gibmdl = "progs/gibs/gib_gen_1.mdl";
    else if (r == 4)
        gibmdl = "progs/gibs/gib_gen_2.mdl";
    else if (r == 5)
        gibmdl = "progs/gibs/gib_gen_3.mdl";
    else if (r == 6)
        gibmdl = "progs/gibs/gib_gen_4.mdl";
    else if (r == 7)
        gibmdl = "progs/gibs/gib_gen_5.mdl";
    else
        gibmdl = "progs/gibs/gib_gen_6.mdl";

    SUB_ChangeModel(meat, gibmdl);
};


void(float drop_count) AmalGoop_Spam =
{
	float i;
	
	i = 0;

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
	item.avelocity = '100 100 100';
	
	item.flags = FL_ITEM;
	item.solid = SOLID_TRIGGER;
	item.movetype = MOVETYPE_TOSS;
	item.classname = "AmalGoop";
	setmodel (item, "progs/proj_amalgoop.mdl");
	setsize (item, '0 0 0', '0 0 0');
	//item.angles_y = (random() * (random() * 256));
	
	local vector goop_spin;
	goop_spin_y = (random() * 1000);
	item.avelocity = goop_spin;

	item.skin = self.skin;

	sound (self, CHAN_WEAPON, "amalg/amalgshoot.wav", .5, ATTN_NORM);

	item.dmg = 8;
	item.touch = AmalGoop_Touch;
	item.think = SUB_Remove;
	item.nextthink = time + 20;
}

float played_tink;

void() AmalGoop_Touch =
{

	if (!played_tink) {
		sound (self, CHAN_BODY, "weapons/tink1.wav", 1, ATTN_STATIC);
		played_tink = 1;
	}

	if (!CheckValidTouch()) return;
	if (other.flags & FL_MONSTER) return;
	if (self.attack_finished > time) return;

	T_Damage(other, self.owner, self, self.dmg);

	if (random() > .5)
	{
		sound(self, CHAN_VOICE, "amalg/amalg_goop1.wav", .6, ATTN_NORM);
	}
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

	if (self.health < -150) {
		amalgam_gib();
		return;
	}
	
	// disable directional gibs
	self.inflictor_vel = VEC_ORIGIN;
	self.inflictor_origin = self.origin;

	amalgam_die1 ();
}



void() monster_amalgam_spawn =
{
	self.classname = "monster_amalgam";
	
	self.solid = SOLID_SLIDEBOX;
	//self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/toothy_qbj.mdl");
	
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.health = 400;

	self.th_stand = amalgam_stand1;
	self.th_walk = amalgam_walk1;
	self.th_run = amalgam_run1;
	self.th_missile = amalgam_atk1;
	self.th_pain = amalg_pain;
	self.th_die = amalgam_die;
	self.th_checkattack = AmalgamCheckAttack;


	if (self.deathtype == string_null)
		self.deathtype = "was shlorped by the Amalgam";

    flymonster_start ();
}

void() monster_amalgam_spawner = {mon_spawner_use(monster_amalgam_spawn);}

/*QUAKED monster_amalgam (1 0 0) (-32 -32 -32) (32 32 72) AMBUSH ? ? ? TRIGGERED NOTFOG NOTELEFRAG INSTAWAKE
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
@PointClass base(Monster) size(-32 -32 -32, 32 32 72) model({ "path": ":progs/toothy_qbj.mdl", "skin": skin }) = monster_amalgam : "Amalgam" []
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
	precache_model ("progs/toothy_qbj.mdl");
	precache_model ("progs/h_guard.mdl");

	self.invokedmodel = "progs/fx/invoked_amalgam.mdl";
	precache_model(self.invokedmodel);

	precache_model ("progs/gibs/gib_gen_1.mdl");
	precache_model ("progs/gibs/gib_gen_2.mdl");
	precache_model ("progs/gibs/gib_gen_3.mdl");
	precache_model ("progs/gibs/gib_gen_4.mdl");
	precache_model ("progs/gibs/gib_gen_5.mdl");
	precache_model ("progs/gibs/gib_gen_6.mdl");

	precache_model ("progs/proj_amalgoop.mdl");
	precache_model ("progs/proj_amalgoop_explo.mdl");
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
