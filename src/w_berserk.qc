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
		//W_FireBerserk();
		W_FireBerserk2();

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

////////////////////////////////////////////////////////////////////////////////////////////////
void() W_FireBerserk2 =
{
	local	vector	source;
	
	entity hitent1, hitent2;
	vector hitpos1, hitpos2;
	float shortest_hit1 = 1000;
	float shortest_hit2 = 1000;

	makevectors (self.v_angle);
	source = self.origin + self.view_ofs - v_up*6;

	traceline (source, source + v_forward*72 - v_right*40, FALSE, self);
	if (trace_fraction < 1) {
		shortest_hit1 = vlen(trace_endpos - source);
		hitent1 = trace_ent;
		hitpos1 = trace_endpos;
 	}

	traceline (source, source + v_forward*86 - v_right*20, FALSE, self);
	if (trace_fraction < 1) {
		if (trace_ent == hitent1 && vlen(trace_endpos - source) < shortest_hit1) {
			shortest_hit1 = vlen(trace_endpos - source);
			hitent1 = trace_ent;
			hitpos1 = trace_endpos;
		}
		if (trace_ent != hitent1 && vlen(trace_endpos - source) < shortest_hit2) {
			shortest_hit2 = vlen(trace_endpos - source);
			hitent2 = trace_ent;
			hitpos2 = trace_endpos;
		}
	}

	traceline (source, source + v_forward*100, FALSE, self);
	if (trace_fraction < 1) {
		if (trace_ent == hitent1 && vlen(trace_endpos - source) < shortest_hit1) {
			shortest_hit1 = vlen(trace_endpos - source);
			hitent1 = trace_ent;
			hitpos1 = trace_endpos;
		}
		if (trace_ent != hitent1 && vlen(trace_endpos - source) < shortest_hit2) {
			shortest_hit2 = vlen(trace_endpos - source);
			hitent2 = trace_ent;
			hitpos2 = trace_endpos;
		}
	}

	traceline (source, source + v_forward*86 + v_right*20, FALSE, self);
	if (trace_fraction < 1) {
		if (trace_ent == hitent1 && vlen(trace_endpos - source) < shortest_hit1) {
			shortest_hit1 = vlen(trace_endpos - source);
			hitent1 = trace_ent;
			hitpos1 = trace_endpos;
		}
		if (trace_ent != hitent1 && vlen(trace_endpos - source) < shortest_hit2) {
			shortest_hit2 = vlen(trace_endpos - source);
			hitent2 = trace_ent;
			hitpos2 = trace_endpos;
		}
	}

	traceline (source, source + v_forward*72 + v_right*40, FALSE, self);
	if (trace_fraction < 1) {
		if (trace_ent == hitent1 && vlen(trace_endpos - source) < shortest_hit1) {
			shortest_hit1 = vlen(trace_endpos - source);
			hitent1 = trace_ent;
			hitpos1 = trace_endpos;
		}
		if (trace_ent != hitent1 && vlen(trace_endpos - source) < shortest_hit2) {
			shortest_hit2 = vlen(trace_endpos - source);
			hitent2 = trace_ent;
			hitpos2 = trace_endpos;
		}
	}

	if (shortest_hit1 == 1000 && shortest_hit2 == 1000) {
		return;
	}

	self.show_hostile = time + 1; // hit something, so alert monsters
	
	vector dir = v_right * 20 - v_up*5; // direction for blood particles

	if (shortest_hit1 < 1000) hitberserk2(hitent1, hitpos1 - v_forward*4, dir);
	if (shortest_hit2 < 1000 && hitent1 != hitent2) hitberserk2(hitent2, hitpos2 - v_forward*4, dir);


};
//=============================================================================================
void(entity hitent, vector org, vector dir) hitberserk2 =
{
	if (hitent.takedamage) 
	{		
		hitent.swordhitme = 1;

		SpawnBlood(org, dir, 100);

		/*
		if (hitent.classname == "monster_zombie") //keep zombies Unbonkable
			//zombie_knockdown(trace_ent);
			T_Damage(hitent, self, self, 29, DMGTYPE_MELEE);	// zombie_knockdown crashes when multi-hit?
		else
		*/	
			T_Damage(hitent, self, self, 666, DMGTYPE_MELEE);	// Instant Kills EVERYTHING!
		
		//johnfitz -- make clank sound when hitting brushmodels
		if (hitent.movetype == MOVETYPE_PUSH || hitent.movetype == MOVETYPE_NONE)
			wrench_hitsound();

		if ((hitent.flags & FL_MONSTER) || (hitent.classname == "player"))
		{	
			wrench_hitsound();
			
			
			if ((hitent.movetype == MOVETYPE_STEP || hitent.movetype == MOVETYPE_WALK) && 
				// don't swat bosses or other non-standard-sized enemies around
				hitent.maxs_x <= 32 && hitent.health > 0 && hitent.type != "boss")
			{
				local vector toss;
				toss = v_forward;
				toss_z = 0;
				toss = normalize(toss) * 800;
				toss_z = 100;
				hitent.origin_z = hitent.origin_z + 1;
				hitent.velocity = toss;
				hitent.flags = not(hitent.flags, FL_ONGROUND);
			}	
		}
		//johnfitz

		if (trace_ent.flags & FL_MONSTER)
		{
			if (trace_ent.type == "zombie")
				zombie_knockdown(trace_ent);
			wrench_hitsound();
		}
		else
		{
			sound (self, CHAN_WEAPON, "zombie/z_hit.wav", 1, ATTN_IDLE);
		}
	}
	else	{	// hit wall
		sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
		gunshot(org);
	}
}