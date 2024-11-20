/*
===============

Berserk
Routed from the wrench code

===============
*/


float() weaponanim_berserk = {
	if (self.attack_finished > time)
		return FALSE;

	sound (self, CHAN_AUTO, "weapons/ax1.wav", 1, ATTN_NORM);
	
	if (self.berserk_sound < time)
	{
		self.berserk_sound = time + 1;
		sound (self, CHAN_POWERUP, "items/berserk_fire.wav", 1, ATTN_NORM);
	}

	self.attack_finished = time + 0.5;
	
	self.weaponframe = floor(random()*4.99)*10 + 1;
	
	// converts weaponframe to a 0-4 integer selector for the player animation
	player_axe_start(self.animcontroller, (self.weaponframe - 1)/10); 

	self.think = weaponanim_berserk_loop;
	self.nextthink = time + 0.05;

	return FALSE; 
}

void() weaponanim_berserk_loop = {
	if (self.weaponframe % 10 == 3)
		W_FireBerserk();

	if (self.weaponframe % 10 == 0) {
		self.weaponframe = 0;
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_berserk_loop;
	self.nextthink = time + 0.05;

}


//=================================================================================================

void() W_FireBerserk =
{
	local vector toss;
	if (self.health <= 0)
		return;
	
	makevectors (self.v_angle);
			
	vector source = self.origin + self.view_ofs;//'0 0 16';	
	
	traceline2(source, source + v_forward * (96), self, 0);	// flail has increased range by default
		
	if (trace_fraction == 1.0) 
		return;
	
	self.show_hostile = time + 1;	// wake monsters up
	
	vector org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		trace_ent.customflags = trace_ent.customflags | CFL_AXEHITME;
		
		if (trace_ent.flags & FL_MONSTER)
		{
			if (trace_ent.type == "zombie")
				zombie_knockdown(trace_ent);

			if (random() < 0.5) sound (self, CHAN_WEAPON, "weapons/axhit1.wav", 1, ATTN_NORM);
			else sound (self, CHAN_WEAPON, "weapons/axhit2.wav", 1, ATTN_NORM);
		}
		else
		{
			sound (self, CHAN_WEAPON, "zombie/z_hit.wav", 1, ATTN_IDLE);
		}
		
		if ((trace_ent.movetype == MOVETYPE_STEP || trace_ent.movetype == MOVETYPE_WALK) && (
				trace_ent.type != "boss" || // don't swat bosses or other non-standard-sized enemies around
				(trace_ent.classname == "player" && trace_ent.health < 1)) // push dying players?
			)
		{
			toss = v_forward;
			toss_z = 0;

			toss = normalize(toss) * 800; // beserk doubled the knockback with the axe but removed the quad knockback

			toss_z = 100;
			//bprint(vtos(toss));
			//bprint("\n");
			//toss *=  - vlen(head.maxs - head.mins)
			trace_ent.origin_z = trace_ent.origin_z + 1;
			trace_ent.velocity = toss;
			trace_ent.flags &~= FL_ONGROUND;
		}

		T_Damage (trace_ent, self, self, 480);
		SpawnBlood (org, '0 0 0', 20);
	}
	else
	{	// hit wall
		sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
		gunshot(org);
	}
}