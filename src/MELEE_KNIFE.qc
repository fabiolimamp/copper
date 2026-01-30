//=============================================================================================
// tracers and bullet code by bmFbr, edits by Kebby
//=============================================================================================

string	MELEE_KNIFE_NAME	=	"MELEE_KNIFE";
//string	MELEE_KNIFE_MODEL	=	"progs/placeholder_progs/v_melee_knife2.mdl";
string	MELEE_KNIFE_MODEL	=	"progs/placeholder_progs/v_melee_knife3.mdl";

/*
	Knife
	{0-70}
	v_melee_knife
	
	0  idle
	1-10  draw > idle
	11-(14)-[26]-30  swing
	31-(34)-[46]-50  swing
	51-(54)-[66]-70  swing
	~~~
	71-80  twirl
	81-101  idle loop
	
	*swing (hit) [skip] > idle
*/
//=============================================================================================


	float	MELEE_KNIFE_ROF	=	0.4;	//0.8 sec wrench

	float	MELEE_KNIFE_DMG	=	25;	//60 wrench


//=============================================================================================

float() weaponanim_MELEE_KNIFE =
{
	if (has_berserk(self))
		return weaponanim_berserk();

	if (self.attack_finished > time)
		return FALSE;

	//sound (self, CHAN_OTHER, "weapons/ax1.wav", 1, ATTN_NORM);
	//sound (self, CHAN_OTHER, "impact/wrench_swing.wav", 1, ATTN_NORM);
	
	sound_MELEE_KNIFE_air_swipe(1);
	
	SuperDamageSound();
	
	self.attack_finished = time + MELEE_KNIFE_ROF;
	
	/*
	local float r = floor(random()*3);
	if 	(r== 0)	self.weaponframe = 11;
	else if (r== 1)	self.weaponframe = 31;
	else		self.weaponframe = 51;
	*/
	
	
	local float r = floor(random()*3);
	if 	(r== 0)	self.weaponframe = 13;
	else if (r== 1)	self.weaponframe = 33;
	else		self.weaponframe = 53;
	
	
	
	// converts weaponframe to a 0-4 integer selector for the player animation
	//player_axe_start(self.animcontroller, (self.weaponframe - 1)/20);
	
	
	SUB_CallAsSelf(player_wrench1, self.animcontroller);
	
	
	self.think = weaponanim_MELEE_KNIFE_loop;
	self.nextthink = time + 0.025;

	return FALSE; // axe swing will never count as fired until it hits something
}

void() weaponanim_MELEE_KNIFE_loop =
{
	if (self.weaponframe == 14 || self.weaponframe == 34 || self.weaponframe == 54)
		W_Fire_MELEE_KNIFE();

	if (self.weaponframe == 30 || self.weaponframe == 50 || self.weaponframe == 70)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_MELEE_KNIFE_loop;
	self.nextthink = time + 0.04;
}

////////////////////////////////////////////////////////////////////////////////////////////////
/*
void() weaponanim_draw_MELEE_KNIFE =
{		
	if (has_berserk(self)) {
		weaponanim_draw_berserker();
		return;
	}

	sound (self, CHAN_AUTO, "misc/draw1.wav", 0.1, ATTN_NORM);
	
	self.weaponframe = 1;
	
	self.think = weaponanim_draw_loop;
	self.nextthink = time + 0.033;
}
*/
//=============================================================================================

.float	wrenchhitme;

void() W_Fire_MELEE_KNIFE =
{
	local	vector	source;
	
	entity hitent1, hitent2;
	vector hitpos1, hitpos2;
	float shortest_hit1 = 1000;
	float shortest_hit2 = 1000;

	makevectors (self.v_angle);
	source = self.origin + self.view_ofs - v_up*0;

	traceline2 (source, source + v_forward*48 - v_right*24, self, FALSE);	//60,-40
	if (trace_fraction < 1) {
		shortest_hit1 = vlen(trace_endpos - source);
		hitent1 = trace_ent;
		hitpos1 = trace_endpos;
 	}

	traceline2 (source, source + v_forward*56 - v_right*12, self, FALSE);	//72,-20
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

	traceline2 (source, source + v_forward*64, self, FALSE);		//86,
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

	traceline2 (source, source + v_forward*56 + v_right*12, self, FALSE);	//72,20
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

	traceline2 (source, source + v_forward*48 + v_right*24, self, FALSE);	//60,40
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

	if (shortest_hit1 < 1000) hit_MELEE_KNIFE(hitent1, hitpos1 - v_forward*4, dir);
	if (shortest_hit2 < 1000 && hitent1 != hitent2) hit_MELEE_KNIFE(hitent2, hitpos2 - v_forward*4, dir);
};
//=============================================================================================

void(float knifeswipe_volume) sound_MELEE_KNIFE_air_swipe =
{
	local float r = floor(random()*2);
	if 	(r == 0)	sound (self, CHAN_AUTO, "placeholder_sound/knife_slash1.wav", knifeswipe_volume, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "placeholder_sound/knife_slash2.wav", knifeswipe_volume, ATTN_NORM);
}
//=============================================================================================

void(float knifehit_volume) sound_MELEE_KNIFE_hit_enemy =
{
	local float r = floor(random()*4);
	if 	(r == 0)	sound (self, CHAN_AUTO, "placeholder_sound/knife_hit1.wav", knifehit_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "placeholder_sound/knife_hit2.wav", knifehit_volume, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_AUTO, "placeholder_sound/knife_hit3.wav", knifehit_volume, ATTN_NORM);
	else 			sound (self, CHAN_AUTO, "placeholder_sound/knife_hit4.wav", knifehit_volume, ATTN_NORM);
}
//=============================================================================================

void(entity hitent, vector org, vector dir) hit_MELEE_KNIFE =
{
	if (hitent.takedamage) 
	{		
		hitent.meleehitme = 1;

		SpawnBlood(org, dir, MELEE_KNIFE_DMG);

		FX_Impact(FX_BLOOD, org, dir);

		//if (hitent.classname == "monster_zombie") //keep zombies Unbonkable
		//	T_Damage(hitent, self, self, 59, DMGTYPE_MELEE);
		//else	
			T_Damage(hitent, self, self, MELEE_KNIFE_DMG, DMGTYPE_MELEE);
		
		//johnfitz -- make clank sound when hitting brushmodels
		if (hitent.movetype == MOVETYPE_PUSH || hitent.movetype == MOVETYPE_NONE)
			//sound_wrench_hit_world(1);
			sound (self, CHAN_AUTO, "placeholder_sound/knife_hitwall1.wav", 1, ATTN_NORM);

		if ((hitent.flags & FL_MONSTER) || (hitent.classname == "player"))
		{	
			//sound_wrench_hit_enemy(1);
			sound_MELEE_KNIFE_hit_enemy(1);
			/*		
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
			*/
		}
			
		//johnfitz

		if (trace_ent.flags & FL_MONSTER)
		{
			if (trace_ent.type == "zombie")
				zombie_knockdown(trace_ent);
			
			sound_MELEE_KNIFE_hit_enemy(1);
		}
		else
		{
			sound (self, CHAN_WEAPON, "zombie/z_hit.wav", 1, ATTN_IDLE);
			sound_MELEE_KNIFE_hit_enemy(1);
		}
				
		// do knockback with a quad
		/*
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
		*/
	}
	else	{	// hit wall
		sound (self, CHAN_AUTO, "placeholder_sound/knife_hitwall1.wav", 0.5, ATTN_NORM);
		//sound_wrench_hit_world(0.8);
		
		FX_Impact(FX_SPARK, org, dir);

		gunshot(org);
	}
}