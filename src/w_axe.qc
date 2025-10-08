/*
===============

THE AXE

===============
*/

// SOUNDS

void() W_AxeHitSound =
{
	if (random() < 0.5)
		sound (self, CHAN_WEAPON, "weapons/axhit1.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_WEAPON, "weapons/axhit2.wav", 1, ATTN_NORM);
}



float() weaponanim_axe = {
	if (self.attack_finished > time)
		return FALSE;

	sound (self, CHAN_OTHER, "weapons/ax1.wav", 1, ATTN_NORM);
	
	self.attack_finished = time + 0.5;
	
	self.weaponframe = floor(random()*4.99)*10 + 1;
	
	// converts weaponframe to a 0-4 integer selector for the player animation
	player_axe_start(self.animcontroller, (self.weaponframe - 1)/10); 

	self.think = weaponanim_axe_loop;
	self.nextthink = time + 0.05;

	return FALSE; // axe swing will never count as fired until it hits something
}

void() weaponanim_axe_loop = {
	if (self.weaponframe % 10 == 3)
		W_FireAxe();

	if (self.weaponframe % 10 == 0) {
		self.weaponframe = 0;
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_axe_loop;
	self.nextthink = time + 0.05;

}

/*
================
W_FireAxe
================
*/
void() W_FireAxe =
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
	
	if (trace_ent.takedamage)
	{
		trace_ent.customflags = trace_ent.customflags | CFL_AXEHITME;
		SpawnBlood (org, '0 0 0', 20);
		T_Damage (trace_ent, self, self, 24, DMGTYPE_MELEE);
		
		if (trace_ent.flags & FL_MONSTER)
		{
			if (trace_ent.type == "zombie")
				zombie_knockdown(trace_ent);
			W_AxeHitSound();
		}
		else
		{
			sound (self, CHAN_WEAPON, "zombie/z_hit.wav", 1, ATTN_IDLE);
		}
		
		// do knockback with a quad
		if (has_quad(self))
		{
			if ((trace_ent.movetype == MOVETYPE_STEP || trace_ent.movetype == MOVETYPE_WALK) && 
				// don't swat bosses or other non-standard-sized enemies around
				trace_ent.maxs_x <= 32 && trace_ent.health > 0 && trace_ent.type != "boss")
			{
				local vector toss;
				toss = v_forward;
				toss_z = 0;
				toss = normalize(toss) * 400;
				toss_z = 100;
				//bprint(vtos(toss));
				//bprint("\n");
				//toss *=  - vlen(head.maxs - head.mins)
				trace_ent.origin_z = trace_ent.origin_z + 1;
				trace_ent.velocity = toss;
				trace_ent.flags = not(trace_ent.flags, FL_ONGROUND);
			}
		}
	}
	else
	{	// hit wall
		sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
		gunshot(org);
	}
}


