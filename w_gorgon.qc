/*
===============

Gorgon Sledgehammer
Routed from the wrench code

===============
*/


float() weaponanim_gorgon = {
	if (self.attack_finished > time)
		return FALSE;

	sound (self, CHAN_OTHER, "weapons/ax1.wav", 1, ATTN_NORM);
	
	self.attack_finished = time + 0.5;
	
	self.weaponframe = floor(random()*4.99)*10 + 1;
	
	// converts weaponframe to a 0-4 integer selector for the player animation
	player_axe_start(self.animcontroller, (self.weaponframe - 1)/10); 

	self.think = weaponanim_gorgon_loop;
	self.nextthink = time + 0.05;

	return FALSE; // axe swing will never count as fired until it hits something
}

void() weaponanim_gorgon_loop = {
	if (self.weaponframe % 10 == 3)
		W_FireGorgon();

	if (self.weaponframe % 10 == 0) {
		self.weaponframe = 0;
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_gorgon_loop;
	self.nextthink = time + 0.05;

}


//=================================================================================================

void() W_GorgonHitSound =
{
	//if (random() < 0.5)
		sound (self, CHAN_WEAPON, "items/gorgonhit.wav", 1, ATTN_NORM);
	//else
	//	sound (self, CHAN_WEAPON, "weapons/axhit2.wav", 1, ATTN_NORM);
}



void() W_FireGorgon =
{
	vector	source, org;
	if (self.health <= 0)
		return;
	
	makevectors (self.v_angle);
	source = self.origin + self.view_ofs;//'0 0 16';
	traceline2(source, source + v_forward * (64), self, 0);
	if (trace_ent == self)
		return;	// some notrace shit happened
	if (trace_fraction == 1.0) 
		return;
	
	self.show_hostile = time + 1;	// wake monsters up
	
	org = trace_endpos - v_forward*4;

	// cache trace_ent locally to avoid global fuckery
	entity targ = trace_ent;

	if (targ.takedamage)
	{
		
		targ.customflags = targ.customflags | CFL_AXEHITME;
		
		if (targ.flags & FL_MONSTER)
		{
			Gorgon_TurnStatue(targ);
			W_GorgonHitSound();
		}
		else
		{
			T_Damage (targ, self, self, 24, DMGTYPE_MELEE);
			sound (self, CHAN_WEAPON, "zombie/z_hit.wav", 1, ATTN_IDLE);
			SpawnBlood (org, '0 0 0', 20);
		}
		

	}
	else
	{	// hit wall
		sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
		gunshot(org);
	}
}


void(entity targ) Gorgon_TurnStatue =
{
	if (!(targ.flags & FL_MONSTER) || targ.health <= 0)
		return;

	targ.think = SUB_Null;
	targ.nextthink = 0;

	targ.touch = SUB_Null;
	targ.th_pain = statue_pain;
	targ.th_die = statue_die;
	targ.health = 5;
	targ.flags &~= FL_FLY;
	targ.flags &~= FL_SWIM;
	targ.flags &~= FL_SWIM2;
}

void(entity attacker, float damage) statue_pain =
{

}

void() statue_die =
{
	self.think = statue_gib;
	self.nextthink = time + 0.1;
}

void() statue_gib =
{
	entity debris;
	float i;
	float totaldebris = rint(self.size_x/4);

	float gibhealth = max(self.health*3, -60);

	for (i = 0; i < totaldebris; i++)
	{
		debris = ThrowGib ("progs/debris.mdl", GibVelocityComplete(self, gibhealth));
		debris.skin = 2;
	}

	remove(self);
}