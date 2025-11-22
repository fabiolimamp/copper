////////////////////////////////////////////////////////////////////////////////////////////////
// Blood Gem
////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_invoker = 
{
	if (self.attack_finished > time)
		return FALSE;

	if (self.weaponframe >= 1 && self.weaponframe <= 84){
		return FALSE;
	}

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	//self.attack_finished = time + (2.1);
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);

	sound (self, CHAN_AUTO, "invoker/magic21.wav", 1, ATTN_NORM);
	
	sound (self, CHAN_AUTO, "invoker/magic26.wav", 1, ATTN_NORM);
		
	self.weaponframe = 1;
	self.think = weaponanim_invoker_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
	
	// Invoker Charge Time to Fire = 1.7 seconds, 40fps = 68 frames
	
	// Invoker Total Time Cooldown = 2.1 seconds, 40fps = 84 frames minimum

	// Invoker weapon change lock = frames 54 to 84 (~80% charge)
}

//=============================================================================================

void() weaponanim_invoker_loop = 
{
	if (intermission) return;
	
	if (self.weaponframe == 31)	sound (self, CHAN_AUTO, "invoker/magic07.wav", 1, ATTN_NORM);
	
	if (self.weaponframe == 67)	sound (self, CHAN_AUTO, "invoker/energy_charge.wav", 1, ATTN_NORM);
	
	if (self.weaponframe >= 54 && self.weaponframe <= 84){
		self.customflags |= CFL_WEAPONLOCK;
		//dprint("locked\n");
	}
	else
		self.customflags &~= CFL_WEAPONLOCK;

	if (self.weaponframe == 68)
	{		
		self.currentammo = self.ammo_cells = self.ammo_cells - 1;
		self.effects = self.effects | EF_MUZZLEFLASH;

		SuperDamageSound();
		W_FireInvoker();
		
		self.weaponframe++;
	}

	if (self.weaponframe >= 100)	// added post-fire + ready to fire --> idle padding
	{
		//self.weaponframe = 0;
		idleamim_invoker();
		return;
	}	
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_invoker_loop;
	self.nextthink = time + 0.025;
}
////////////////////////////////////////////////////////////////////////////////////////////////

void() idleamim_invoker =
{	
	self.weaponframe = 85;
	
	self.think = idleamim_invoker_loop;
	self.nextthink = time + 0.1;
}

void() idleamim_invoker_loop =
{

	if (self.weaponframe >= 100)	//restart idle loop
	{
		idleamim_invoker();
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = idleamim_invoker_loop;
	self.nextthink = time + 0.1;
}

////////////////////////////////////////////////////////////////////////////////////////////////


void() W_FireInvoker =
{
	sound(self, CHAN_AUTO, "invoker/invoker_firerail.wav", 1, ATTN_NORM);
	
	sound(self, CHAN_AUTO, "invoker/magic08.wav", 1, ATTN_NORM);

	makevectors(self.v_angle);

	vector org = self.origin + self.view_ofs + (v_forward * 4);
	
	vector dir = v_forward;
	vector up = v_up;
	vector right = v_right;

	invokerTrace(org + (up * 32) + (right * -32), dir, TRUE); // top left
	invokerTrace(org + (up * 32) + (right * 0), dir, TRUE); // top center
	invokerTrace(org + (up * 32) + (right * 32), dir, TRUE); // top right
	invokerTrace(org + (up * 0) + (right * -32), dir, TRUE); // center left
	invokerTrace(org + (up * 0) + (right * 0), dir, TRUE); // center
	invokerTrace(org + (up * 0) + (right * 32), dir, TRUE); // center right
	invokerTrace(org + (up * -32) + (right * -32), dir, TRUE); // bottom left
	invokerTrace(org + (up * -32) + (right * 0), dir, TRUE); // bottom center
	invokerTrace(org + (up * -32) + (right * 32), dir, TRUE); // bottom right

	// extra invisible traces to the sides of the crosshair to catch up rogue swarmers
	invokerTrace(org + (up * 0) + (right * -12), dir, FALSE); // left
	invokerTrace(org + (up * 0) + (right * -24), dir, FALSE); // left
	invokerTrace(org + (up * 0) + (right * 12), dir, FALSE); // right
	invokerTrace(org + (up * 0) + (right * 24), dir, FALSE); // right
}

void(vector org, vector dir, float drawTrail) invokerTrace =
{
	float timetoend;
	vector vel, loopsrc, destination, dir2, dir3;
	entity target_ent;
	
	
	destination = org + (dir * 8192);
	
	loopsrc = org;
	target_ent = self;
	
	vector neworg = org;
	while ( !timetoend )
	{
		traceline2(loopsrc, destination, target_ent, 0);
		if (trace_fraction != 1.0)
		{
			target_ent = trace_ent;

			neworg = trace_endpos - dir*4;

			if (target_ent.takedamage && target_ent != self)
			{
				vel = dir + 2*trace_plane_normal;
				vel = vel * 200;

				SpawnBlood(neworg, vel*0.2, 400);
				
				FX_Impact(FX_CHAINS, neworg, dir);
				
				sound_invoker_impact(1);
				
				target_ent.effects = target_ent.effects | EF_MUZZLEFLASH;

				if (deathmatch != 0)
					T_Damage (target_ent, self, self, 333);
				else
					T_Damage (target_ent, self, self, 666);
				
				// ded
				if (target_ent && target_ent.health <= 0 && target_ent.flags & (FL_MONSTER | FL_CLIENT))
				{
					// if we have the right amount of health add some velocity if we're not gibbing
					if (!(target_ent.customflags & CFL_GIBBED))
					{
						
						target_ent.velocity = '0 0 175';
						// zero out the velocity and give it some z velocity so its off ground
						target_ent.flags = target_ent.flags - (target_ent.flags & FL_ONGROUND);
						// also set the flag
						
						// we don't want z velocity, so we're going to zero that out too.
						dir3 = BoundsCenter(self); // player
						dir3_z = 0;
						dir2 = target_ent.origin; // monster
						dir2_z = 0;
						dir2 = dir2 - dir3; // direction from player to monster
						dir2 = normalize(dir2);
						target_ent.velocity = target_ent.velocity + (dir2 * 400);
					}								
					// gibbed, so just let meat fly and call the invoked effect
					else
						FX_Invoked(target_ent.invokedmodel, target_ent.origin, dir);
				}

				// Trace from inside of the hitted monster (vf)
				loopsrc = trace_endpos + (dir * 4);
			}
			else
			{
				if (drawTrail) gunshot(trace_endpos);
				timetoend = 1;
			}
		}
		else timetoend = 1;
	}

	if (drawTrail)
		drawInvokerTrail(self, org, trace_endpos);

};


////////////////////////////////////////////////////////////////////////////////////////////////

void(float invokerhit_volume) sound_invoker_impact =
{
	local float r = floor(random()*4);
	if 	(r == 0)	sound (self, CHAN_BODY, "invoker/energy_hit1.wav", invokerhit_volume, ATTN_NORM);
	else if (r == 1)	sound (self, CHAN_BODY, "invoker/energy_hit2.wav", invokerhit_volume, ATTN_NORM);
	else if (r == 2)	sound (self, CHAN_BODY, "invoker/energy_hit3.wav", invokerhit_volume, ATTN_NORM);
	else 			sound (self, CHAN_BODY, "invoker/energy_hit4.wav", invokerhit_volume, ATTN_NORM);
}
//=============================================================================================


////////////////////////////////////////////////////////////////////////////////////////////////


void(entity pl, vector org, vector dest) drawInvokerTrail = 
{
	float len = vlen(dest - org);
	vector dir = normalize(dest - org);
	vector ang = vectoangles(dest - org);
	float ct = floor(len / 30);
	entity sg;
	entity prevsg;

	for (float i = 0; i < ct; i++) {
		sg = spawn();
		if (prevsg) prevsg.buddy = sg;

		setmodel(sg, "progs/proj_chain.mdl");
		setsize(sg, VEC_ORIGIN, VEC_ORIGIN);
		setorigin(sg, org + dir * 30 * i);

		sg.flags |= CFL_PROJECTILE;
		sg.classname = "lgsegment";
		sg.angles = ang;
		sg.angles_z = random() * 360;
		sg.owner = pl;

		sg.think = rail_fade;

		// farther segments tick slower
		sg.attack_finished = 0.03 + (i * 0.0004);

		sg.cnt = 4 + i;
		if (sg.cnt > 12) sg.cnt = 12; // clamp max to keep reasonable

		sg.nextthink = time + sg.attack_finished;
		sg.alpha = 0.9;

		prevsg = sg;
	}

	if (sg) sg.effects |= EF_MUZZLEFLASH;
}

////////////////////////////////////////////////////////////////////////////////////////////////

void() rail_fade = 
{
	self.think = rail_fade;
	self.nextthink = time + self.attack_finished;

	//if (self.skin < 6)
	//	self.skin++;

	if (self.cnt >= 10)
		self.alpha = 0.9;
	else if (self.cnt == 9)
		self.alpha = 0.7;
	else if (self.cnt == 8)
		self.alpha = 0.5;
	else if (self.cnt == 7)
		self.alpha = 0.4;
	else if (self.cnt == 6)
		self.alpha = 0.3;
	else if (self.cnt == 5)
		self.alpha = 0.2;
	else if (self.cnt == 4)
		self.alpha = 0.15;
	else if (self.cnt == 3)
		self.alpha = 0.1;
	else if (self.cnt == 2)
		self.alpha = 0.07;
	else 
	{
		self.alpha = 0.05;
		self.think = SUB_Remove;
	}	
	

	self.cnt = self.cnt - 1;
};