/*
===============

Gorgon Sledgehammer
Routed from the wrench code

===============
*/


float() weaponanim_gorgon = {
	if (self.attack_finished > time)
		return FALSE;

	//sound (self, CHAN_OTHER, "weapons/ax1.wav", 1, ATTN_NORM);
	
	self.attack_finished = time + 0.5;
	
	self.weaponframe = floor(random()*4.99)*10 + 1;
	
	// converts weaponframe to a 0-4 integer selector for the player animation
	player_axe_start(self.animcontroller, (self.weaponframe - 1)/10); 

	self.think = weaponanim_gorgon_loop;
	self.nextthink = time + 0.05;

	return FALSE; 
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
	//sound (self, CHAN_WEAPON, "items/gorgonhit.wav", 1, ATTN_NORM);

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
		
		if (targ.flags & FL_MONSTER && !(targ.customflags & CFL_STONED))
		{
			Gorgon_TurnStatue(targ);
			W_GorgonHitSound();
		}
		else
		{
			T_Damage (targ, self, self, 48, DMGTYPE_MELEE);
			//sound (self, CHAN_WEAPON, "zombie/z_hit.wav", 1, ATTN_IDLE);
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
	if (targ.customflags & CFL_STONED)
		return;
	if (targ.type == "boss")
		return;

	targ.enemy = self;
	targ.customflags |= CFL_STONED + CFL_PROJECTILE;
	targ.think = statue_think;
	targ.nextthink = time + 0.05;

	targ.touch = statue_touch;
	targ.th_pain = statue_pain;
	targ.th_die = statue_die;
	targ.health = 9999;
	targ.movetype = MOVETYPE_BOUNCE;
	targ.flags &~= FL_FLY;
	targ.flags &~= FL_SWIM;
	targ.flags &~= FL_SWIM2;
}

void() statue_think =
{
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;
	self.think = statue_think;
}

void() statue_restorevelocity =
{
	self.velocity = self.oldvelocity;
	self.flags &~= FL_ONGROUND;
	self.nextthink = time + 0.05;
	self.think = statue_think;
}

void() statue_checkvelocity =
{
	float dot = normalize(self.velocity) * normalize(self.oldvelocity);
	dprint4("current velocity: ", vtos(self.velocity), ", oldvelocity: ", vtos(self.oldvelocity));
	dprint3(", dot: ", ftos(dot), "\n");
	if (vlen(self.oldvelocity) > 400 && ( dot < -0.1))
	{
		dprint("crash!\n");
		
		self.velocity = self.oldvelocity;
		self.health = 1;
		T_Damage(self, self, self.enemy, 100);
		return;
	}
	dprint("Dont crash\n");
	self.oldvelocity = self.velocity;

	self.nextthink = time + 0.05;
	self.think = statue_think;
}

void() statue_touch =
{
	float linvel = vlen(self.velocity);
	//dprint2(ftos(linvel), "\n");
	if (other.takedamage && other.flags & FL_MONSTER)
	{
		
		float dmg = clamp(linvel - 200, 0, 500)*5;

		if (dmg)
		{
			T_Damage(other, self, self.enemy, dmg);
			
			if (!other || other.customflags & CFL_GIBBED)
			{
				self.think = statue_restorevelocity;
				self.nextthink = time + 0.001;
			}
		}
	}
	self.oldvelocity = self.velocity;
	if (linvel > 400 && other.solid == SOLID_BSP) {
		self.think = statue_checkvelocity;
		self.nextthink = time + 0.001;
		/*
		self.health = 1;
		T_Damage(self, self, self.enemy, 100);
		*/
		//self.nextthink = 0;
	}
}

void(entity attacker, float damage) statue_pain =
{
	//dprint("Pain!\n");
	self.velocity += GibVelocityFromInflictor(self, damage*2);
	if (self.flags & FL_ONGROUND)
		self.velocity_z += clamp(damage*2, 100, 300);
	else
		self.velocity_z += min(damage*2, 100);

	self.velocity_z = min(self.velocity_z, 600);
	
	if (vlen(self.velocity) > 2000)
		self.velocity = normalize(self.velocity) * 2000;

	//dprint2(vtos(self.velocity), "\n");
	self.flags &~= FL_ONGROUND;
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