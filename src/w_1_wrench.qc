////////////////////////////////////////////////////////////////////////////////////////////////
// multi-hit sword sweeping code by bmFbr, edits by Kebby
////////////////////////////////////////////////////////////////////////////////////////////////

.float	swordhitme;

////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_wrench =
{
	if (has_berserk(self))
		return weaponanim_berserk();

	if (self.attack_finished > time)
		return FALSE;



	sound (self, CHAN_OTHER, "weapons/ax1.wav", 1, ATTN_NORM);
	SuperDamageSound();
	
	self.attack_finished = time + 0.8;
	
	self.weaponframe = floor(random()*2.99)*20 + 1;	//(3 cycles, 20 frames)
	
	// converts weaponframe to a 0-4 integer selector for the player animation
	player_axe_start(self.animcontroller, (self.weaponframe - 1)/20);
	
	//new big wrench = (3 cycles, 20 frames)
	//     0 idle
	//  1-20 poke
	// 21-40 swing
	// 41-60 slam

	self.think = weaponanim_wrench_loop; //<<<
	self.nextthink = time + 0.05;

	return FALSE; // axe swing will never count as fired until it hits something
}

void() weaponanim_wrench_loop =
{
	if (self.weaponframe % 20 == 3)
		W_FireWrench(); //<<<

	if (self.weaponframe % 20 == 0) {
		self.weaponframe = 0;
		//idleanim_melee();
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_wrench_loop; //<<<
	self.nextthink = time + 0.05;

}

////////////////////////////////////////////////////////////////////////////////////////////////

void() wrench_hitsound = {
	if (random() < 0.5)
		sound (self, CHAN_WEAPON, "weapons/axhit1.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_WEAPON, "weapons/axhit2.wav", 1, ATTN_NORM);
}
//=============================================================================================

void(float wrenchhit_volume) sound_wrench_hit_enemy =
{
	local float r = floor(random()*4);
	if 	(r == 0)	sound (self, CHAN_AUTO, "impact/wrench_impact1.wav", wrenchhit_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "impact/wrench_impact2.wav", wrenchhit_volume, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_AUTO, "impact/wrench_impact3.wav", wrenchhit_volume, ATTN_NORM);
	else 			sound (self, CHAN_AUTO, "impact/wrench_impact4.wav", wrenchhit_volume, ATTN_NORM);
}
//=============================================================================================

void(float wrenchclank_volume) sound_wrench_hit_world =
{
	if (random() < 0.5)
		sound (self, CHAN_AUTO, "impact/wrench_clank1.wav", wrenchclank_volume, ATTN_NORM);
	else
		sound (self, CHAN_AUTO, "impact/wrench_clank2.wav", wrenchclank_volume, ATTN_NORM);
}

//=============================================================================================

void() W_FireWrench =
{
	local	vector	source;
	
	entity hitent1, hitent2;
	vector hitpos1, hitpos2;
	float shortest_hit1 = 1000;
	float shortest_hit2 = 1000;

	makevectors (self.v_angle);
	source = self.origin + self.view_ofs - v_up*0;

	traceline2 (source, source + v_forward*60 - v_right*40, self, FALSE);
	if (trace_fraction < 1) {
		shortest_hit1 = vlen(trace_endpos - source);
		hitent1 = trace_ent;
		hitpos1 = trace_endpos;
 	}

	traceline2 (source, source + v_forward*72 - v_right*20, self, FALSE);
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

	traceline2 (source, source + v_forward*86, self, FALSE);
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

	traceline2 (source, source + v_forward*72 + v_right*20, self, FALSE);
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

	traceline2 (source, source + v_forward*60 + v_right*40, self, FALSE);
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

	if (shortest_hit1 < 1000) hitwrench(hitent1, hitpos1 - v_forward*4, dir);
	if (shortest_hit2 < 1000 && hitent1 != hitent2) hitwrench(hitent2, hitpos2 - v_forward*4, dir);


};
//=============================================================================================
void(entity hitent, vector org, vector dir) hitwrench =
{
	if (hitent.takedamage) 
	{		
		hitent.swordhitme = 1;

		SpawnBlood(org, dir, 60);

		FX_Impact(FX_BLOOD, org, dir);

		if (hitent.classname == "monster_zombie") //keep zombies Unbonkable
			T_Damage(hitent, self, self, 59, DMGTYPE_MELEE);
		else	
			T_Damage(hitent, self, self, 60, DMGTYPE_MELEE);
		
		//johnfitz -- make clank sound when hitting brushmodels
		if (hitent.movetype == MOVETYPE_PUSH || hitent.movetype == MOVETYPE_NONE)
			sound_wrench_hit_world(1);

		if ((hitent.flags & FL_MONSTER) || (hitent.classname == "player"))
		{	
			if (trace_ent.classname == "monster_hell_knight")
			{
				FX_Impact(FX_SPARK, org, dir);
				sound_bullet_hit_metal(1);
			}
			
			sound_wrench_hit_enemy(1);
					
			if ((hitent.movetype == MOVETYPE_STEP || hitent.movetype == MOVETYPE_WALK) && 
				// don't swat bosses or other non-standard-sized enemies around
				hitent.maxs_x <= 32 && hitent.health > 0 && hitent.type != "boss")
			{
				local vector toss;
				toss = v_forward;
				toss_z = 0;
				toss = normalize(toss) * 200;
				toss_z = 150;
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
			
			sound_wrench_hit_enemy(1);
		}
		else
		{
			sound (self, CHAN_WEAPON, "zombie/z_hit.wav", 1, ATTN_IDLE);
			sound_wrench_hit_enemy(1);
		}
				
		// do knockback with a quad
		if (has_quad(self))
		{
			if ((trace_ent.movetype == MOVETYPE_STEP || trace_ent.movetype == MOVETYPE_WALK) && 
				// don't swat bosses or other non-standard-sized enemies around
				trace_ent.maxs_x <= 32 && trace_ent.health > 0 && trace_ent.type != "boss")
			{
				toss = v_forward;
				toss_z = 0;
				toss = normalize(toss) * 800;
				toss_z = 150;
				trace_ent.origin_z = trace_ent.origin_z + 1;
				trace_ent.velocity = toss;
				trace_ent.flags = not(trace_ent.flags, FL_ONGROUND);
			}
		}
	}
	else	{	// hit wall
		sound (self, CHAN_WEAPON, "player/axhit2.wav", 0.2, ATTN_NORM);
		sound_wrench_hit_world(0.8);
		
		FX_Impact(FX_SPARK, org, dir);

		gunshot(org);
	}
}