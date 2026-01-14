//=============================================================================================
// Berserk  Routed from the wrench code
//=============================================================================================
/*
	Berserker
	{0-100}
	v_berserk
	
	0  idle
	1-10  draw > idle
	11-(14)-[20]-30  idle >>> R > idle > reset
	31-(34)-[40]-50  idle >>> L > idle > reset
	51-(54)-60  L >>> R     
	61-(64)-70  R >>> L
	71-80  reset > idle loop
	81-100  idle loop
	
	*>>> alternate right/left
	*3 cycles, 20 frames, 40fps
	*(hit) on 4's like Wrench
	*swing (hit) [skip] > idle
	
	MD3
	v_berserker_gloves
	v_berserker_glow
*/
//=============================================================================================
/*
Berserk Animation Cycles

	    0	idle
	 1-10   draw > idle

	11-20	idle > {R} start	hit (14)	[20]
	21-30	{R} end > reset

	31-40	idle > {L} start	hit (34)	[40]
	41-50	{L} end > reset

	51-60	{L} combo > {R}	combo / {L} end > reset		hit (54)	[60]
	61-70	{R} combo > {L}	combo / {R} end > reset		hit (64)	[70]
	
	71-80	reset > idle loop
	81-100	idle loop	[71-100]
                                                 ╭─────────────────────────────────────────────╮
                                                 │                                             │
                                                 │                     ███ {R} combo ──────────┤
                                                 │                      │      61-70           │
                                                ███ {L} combo ──────────┤[60]                  │
                                                 │      51-60           │                      │
        ███ (if alternator == 0) > {R} start ────┤[20]                 ░░░ {L} end > reset     │
         │                             11-20     │                             41-50           │
         │                                      ░░░ {R} end > reset                            │
         │                                       │      21-30                                  │
         │                                       ╰─────────────────────────────────────────────╯
reset+   │                                                                                   
idle ────┤[71-100]                               ╭─────────────────────────────────────────────╮
loop     │                                       │                                             │
         │                                       │                     ███ {L} combo ──────────┤
         │                                       │                      │      51-60           │
         │                                      ███ {R} combo ──────────┤[70]                  │
         │                                       │      61-70           │                      │
        ███ (if alternator == 1) > {L} start ────┤[40]                 ░░░ {R} end > reset     │
                                       31-40     │                             21-30           │
                                                ░░░ {L} end > reset                            │
                                                 │      41-50                                  │
                                                 ╰─────────────────────────────────────────────╯
	self.attackpressed;
	self.attackhold;
*/
//=============================================================================================

float() weaponanim_berserk = 
{
	if (self.attack_finished > time)
		return FALSE;

	//sound (self, CHAN_OTHER, "weapons/ax1.wav", 1, ATTN_NORM);
	sound (self, CHAN_OTHER, "impact/wrench_swing.wav", 1, ATTN_NORM);
	
	self.attack_finished = time + 0.5;
		
	// converts weaponframe to a 0-4 integer selector for the player animation
	//player_axe_start(self.animcontroller, (self.weaponframe - 1)/10);
	
	
	SUB_CallAsSelf(player_wrench1, self.animcontroller);
	
		
	if (self.weaponframe >= 0
	 && self.weaponframe <= 70)
	{
		if (self.customflags & CFL_LEFTY) self.weaponframe = 51;
		else self.weaponframe = 61;
	}

	if (self.weaponframe >= 71
	 && self.weaponframe <= 100)	// idle loop	[71-100]
	{
		if (self.customflags & CFL_LEFTY) self.weaponframe = 31;
		else self.weaponframe = 11;
	}	

	self.nextthink = time + 0.05;
	self.think = weaponanim_berserk_loop;
	
	if (self.berserk_sound < time)
	{
		self.berserk_sound = time + 1;
		sound (self, CHAN_AUTO, "items/berserk_fire.wav", 1, ATTN_NORM);
	}

	return FALSE; 
}

void() weaponanim_berserk_loop =	// End Check [Junction]
{
	if (self.weaponframe == 14
	 || self.weaponframe == 34
	 || self.weaponframe == 54
	 || self.weaponframe == 64)	W_Fire_Berserker_Multi();	//W_FireBerserk();


	if (self.weaponframe == 60)	self.weaponframe = 40;
	if (self.weaponframe == 70)	self.weaponframe = 20;


	if (self.weaponframe == 30 || self.weaponframe == 50)
	{
		self.weaponframe = 70;
	}
	if (self.weaponframe >= 80)
	{
		weaponanim_idle_melee();
		return;
	}
	
	self.weaponframe++;

	self.think = weaponanim_berserk_loop;
	self.nextthink = time + 0.05;
}

//=================================================================================================
/*
void() W_FireBerserk =
{
	local vector toss;
	if (self.health <= 0)
		return;

	if (self.weaponframe == 14 || self.weaponframe == 64)
		self.customflags |= CFL_LEFTY; // if {R} start || {R} combo = {L} alternator
	else
		self.customflags &~= CFL_LEFTY;	// if {L} start || {L} combo = {R} alternator
	
	makevectors (self.v_angle);
			
	vector source = self.origin + self.view_ofs;
	
	traceline2(source, source + v_forward * (100), self, 0);
		
	if (trace_fraction == 1.0) 
		return;
	
	self.show_hostile = time + 1;	// wake monsters up
		
	vector org = trace_endpos - v_forward*4;

	if (trace_ent.takedamage)
	{
		trace_ent.customflags = trace_ent.customflags | CFL_AXEHITME;
		
		if (trace_ent.flags & FL_MONSTER)
				
		//sound (self, CHAN_OTHER, "impact/fist_hit.wav", 1, ATTN_NORM);
		
		sound_berserk_fist_hit_enemy(1);
		SuperDamageSound();
		
		
		if ((trace_ent.movetype == MOVETYPE_STEP || trace_ent.movetype == MOVETYPE_WALK) && (
				trace_ent.type != "boss" || // don't swat bosses or other non-standard-sized enemies around
				(trace_ent.classname == "player" && trace_ent.health < 1)) // push dying players?
			)
		{
			toss = v_forward;
			toss_z = 0;

			if (trace_ent.type == "zombie")
			{
				toss = normalize(toss) * 200; // don't send zombies flying away
				toss_z = 150;			
			}
			else{
				toss = normalize(toss) * 800; // beserk doubled the knockback with the axe but removed the quad knockback
				toss_z = 100;
			}		
			
			trace_ent.origin_z = trace_ent.origin_z + 1;
			trace_ent.velocity = toss;
			trace_ent.flags &~= FL_ONGROUND;
		}

		T_Damage (trace_ent, self, self, 480);
		SpawnBlood (org, '0 0 0', 20);
	}
	else
	{	// hit wall
		sound (self, CHAN_OTHER, "impact/fist_hit.wav", 1, ATTN_NORM);
		
		SuperDamageSound();
		gunshot(org);
	}
}
*/
//=============================================================================================

void() weaponanim_draw_berserker =
{		
	sound (self, CHAN_AUTO, "misc/draw1.wav", 0.1, ATTN_NORM);
	
	self.weaponframe = 1;
	
	self.think = weaponanim_draw_berserker_loop;
	self.nextthink = time + 0.033;
}

void() weaponanim_draw_berserker_loop =
{
	if (self.weaponframe >= 9)
	{
		weaponanim_idle_melee();
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_draw_berserker_loop;
	self.nextthink = time + 0.033;
}
//=============================================================================================

void() weaponanim_idle_melee =
{	
	self.weaponframe = 81;
	
	self.think = weaponanim_idle_melee_loop;
	self.nextthink = time + 0.05;
}

void() weaponanim_idle_melee_loop =
{
	if (self.weaponframe >= 100)	//restart idle loop
	{
		weaponanim_idle_melee();
		return;
	}
	else	self.weaponframe++;

	self.think = weaponanim_idle_melee_loop;
	self.nextthink = time + 0.05;
}
//=============================================================================================

void(float fisthit_volume) sound_berserk_fist_hit_enemy =
{
	local float r = floor(random()*4);
	if 	(r == 0)	sound (self, CHAN_AUTO, "impact/fist_impact1.wav", fisthit_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_AUTO, "impact/fist_impact2.wav", fisthit_volume, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_AUTO, "impact/fist_impact3.wav", fisthit_volume, ATTN_NORM);
	else 			sound (self, CHAN_AUTO, "impact/fist_impact4.wav", fisthit_volume, ATTN_NORM);
}

//=============================================================================================

void() W_Fire_Berserker_Multi =
{
	if (self.health <= 0)
		return;

	if (self.weaponframe == 14 || self.weaponframe == 64)
		self.customflags |= CFL_LEFTY; // if {R} start || {R} combo = {L} alternator
	else
		self.customflags &~= CFL_LEFTY;	// if {L} start || {L} combo = {R} alternator
	
	
	local	vector	source;
	
	entity hitent1, hitent2;
	vector hitpos1, hitpos2;
	float shortest_hit1 = 1000;
	float shortest_hit2 = 1000;

	makevectors (self.v_angle);
	source = self.origin + self.view_ofs - v_up*0;

	traceline2 (source, source + v_forward*70 - v_right*30, self, FALSE);
	if (trace_fraction < 1) {
		shortest_hit1 = vlen(trace_endpos - source);
		hitent1 = trace_ent;
		hitpos1 = trace_endpos;
 	}

	traceline2 (source, source + v_forward*85 - v_right*15, self, FALSE);
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

	traceline2 (source, source + v_forward*100, self, FALSE);
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

	traceline2 (source, source + v_forward*85 + v_right*15, self, FALSE);
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

	traceline2 (source, source + v_forward*70 + v_right*30, self, FALSE);
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

	if (shortest_hit1 < 1000) hit_berserker_punch(hitent1, hitpos1 - v_forward*4, dir);
	if (shortest_hit2 < 1000 && hitent1 != hitent2) hit_berserker_punch(hitent2, hitpos2 - v_forward*4, dir);
};
//=============================================================================================

void(entity hitent, vector org, vector dir) hit_berserker_punch =
{
	self.show_hostile = time + 1;	// wake monsters up
	
	if (hitent.takedamage) 
	{		
		hitent.wrenchhitme = 1;

		if ((hitent.flags & FL_MONSTER) || (hitent.classname == "player"))
		{	
			if (hitent.classname == "monster_amalgam" || hitent.classname == "monster_shalrath" )
				T_Damage(hitent, self, self, 600, DMGTYPE_MELEE);	//pop'em
						
			sound_berserk_fist_hit_enemy(1);	
			
			if ((hitent.movetype == MOVETYPE_STEP || hitent.movetype == MOVETYPE_WALK) && 
				// don't swat bosses or other non-standard-sized enemies around
				hitent.maxs_x <= 32 && hitent.health > 0 && hitent.type != "boss")
			{
				local vector toss;
				toss = v_forward;
				toss_z = 0;
				toss = normalize(toss) * 800;	// beserk doubled the knockback with the axe but removed the quad knockback
				toss_z = 100;
				hitent.origin_z = hitent.origin_z + 1;
				hitent.velocity = toss;
				hitent.flags = not(hitent.flags, FL_ONGROUND);
			}	
		}
		
		SpawnBlood(org, dir, 240);
		FX_Impact(FX_BLOOD, org, dir);

		T_Damage(hitent, self, self, 480, DMGTYPE_MELEE);
		
		SuperDamageSound();	//always play quad sound even if missing	
	}
	else
	{	// hit wall
		sound (self, CHAN_OTHER, "impact/fist_hit.wav", 1, ATTN_NORM);
		
		SuperDamageSound();
		gunshot(org);
	}
}