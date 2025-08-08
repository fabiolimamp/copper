////////////////////////////////////////////////////////////////////////////////////////////////
// Blood Gem
////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_bloodgem = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon());
		return FALSE;
	}

	self.attack_finished = time + (2.1);
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	/*
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	sound (self, CHAN_AUTO, "rail/rail_fire1.wav", 1, ATTN_NORM);
	
	
	W_FireRail(0);
	W_FireRail(1);
	W_FireRail(2);
	W_FireRail(3);
	W_FireRail(4);
	W_FireRail(5);
	W_FireRail(6);
	W_FireRail(7);
	W_FireRail(8);

	Start_Sniper_Lightning();
	*/

	self.weaponframe = 1;
	self.think = weaponanim_bloodgem_loop;
	self.nextthink = time + 0.02;
	
	return TRUE;
}

void() weaponanim_bloodgem_loop = {
	
	if (self.weaponframe >= 121){
			self.weaponframe = 0;
			return;
	}
	if (self.weaponframe == 86)
	{		
		self.currentammo = self.ammo_cells = self.ammo_cells - 1;
		self.effects = self.effects | EF_MUZZLEFLASH;

		SuperDamageSound();
		
		sound (self, CHAN_AUTO, "rail/rail_fire1.wav", 1, ATTN_NORM);
	
		
		W_FireRail(0);
		W_FireRail(1);
		W_FireRail(2);
		W_FireRail(3);
		W_FireRail(4);
		W_FireRail(5);
		W_FireRail(6);
		W_FireRail(7);
		W_FireRail(8);
		
		Start_Sniper_Lightning();
		
		self.weaponframe++;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_bloodgem_loop;
	self.nextthink = time + 0.02;
}
////////////////////////////////////////////////////////////////////////////////////////////////

void(float split) W_FireRail =
{
	local float timetoend;
	local vector vel, dir, loopsrc, destination, dir2, dir3;
	local entity thedude;
	vector org;
		
	makevectors(self.v_angle);
	
	
	if	(split == 0)	{ org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 32) + (v_right * -32);	}
	else if	(split == 1)	{ org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 32) + (v_right * 0);	}
	else if	(split == 2)	{ org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 23) + (v_right * 32);	}
	else if	(split == 3)	{ org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 0) + (v_right * -32);	}
	else if	(split == 4)	{ org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 0) + (v_right * 0);	}
	else if	(split == 5)	{ org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 0) + (v_right * 32);	}
	else if	(split == 6)	{ org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * -32) + (v_right * -32);	}
	else if	(split == 7)	{ org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * -32) + (v_right * 0);	}	
	else 			{ org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * -32) + (v_right * 32);	}
	

	dir = aim(self, AUTOAIM_DIST);
	
	destination = org + (dir * 8192);
	
	loopsrc = org;
	thedude = self;
	
	while ( !timetoend )
	{
		traceline2(loopsrc, destination, thedude, 0);
		if (trace_fraction != 1.0)
		{
			vel = normalize(dir);
			vel = vel + 2 * trace_plane_normal;
			vel = vel * 200;

			org = trace_endpos - dir*4;

			if (trace_ent.takedamage && trace_ent != self)
			{
				thedude = trace_ent;
				SpawnBlood (org, vel*0.2, 400);
				if (trace_ent != self) 
				{
					trace_ent.effects = trace_ent.effects | EF_MUZZLEFLASH;

					if (deathmatch != 0)
						T_Damage (trace_ent, self, self, 333);
					else
						T_Damage (trace_ent, self, self, 666);
					
					// if we have the right amount of health add some velocity if we're not gibbing
					if (trace_ent.health <= 0)
					{
						trace_ent.velocity = '0 0 175';					
						// zero out the velocity and give it some z velocity so its off ground
						trace_ent.flags = trace_ent.flags - (trace_ent.flags & FL_ONGROUND);
						// also set the flag
						
						// we don't want z velocity, so we're going to zero that out too.
						dir3 = BoundsCenter(self); // player
						dir3_z = 0;
						dir2 = trace_ent.origin; // monster
						dir2_z = 0;
						dir2 = dir2 - dir3; // direction from player to monster
						dir2 = normalize(dir2);
						trace_ent.velocity = trace_ent.velocity + (dir2 * 400);										
					}
				}

				// Trace from inside of the hitted monster (vf)
				loopsrc = trace_endpos + (dir * 4);
			}
			else
			{
				WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
				WriteByte (MSG_BROADCAST, TE_GUNSHOT);
				WriteCoord (MSG_BROADCAST, org_x);
				WriteCoord (MSG_BROADCAST, org_y);
				WriteCoord (MSG_BROADCAST, org_z);

				timetoend = 1;
			}
		}
		else timetoend = 1;
	}	
};
////////////////////////////////////////////////////////////////////////////////////////////////

void() Start_Sniper_Lightning = 
{
	vector org;
	float i;
	
	if (self.t_width < time)
		self.t_width = time + 0.6;

	makevectors(self.v_angle);
	
	for (i = 0; i < 9; i++)
	{
		if (i == 0)      { org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 32) + (v_right * -32); }
		else if (i == 1) { org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 32) + (v_right * 0); }
		else if (i == 2) { org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 23) + (v_right * 32); }
		else if (i == 3) { org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 0) + (v_right * -32); }
		else if (i == 4) { org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 0) + (v_right * 0); }
		else if (i == 5) { org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * 0) + (v_right * 32); }
		else if (i == 6) { org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * -32) + (v_right * -32); }
		else if (i == 7) { org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * -32) + (v_right * 0); }
		else             { org = self.origin + self.view_ofs + (v_forward * 4) + (v_up * -32) + (v_right * 32); }
		
		traceline(org, org + v_forward * 32, FALSE, self);	
		org = org + v_forward*32*trace_fraction;
		
		vector dir = aim(self, 0);
		vector endpos = Sniper_Lightning_Direction(org, dir);
		
		Draw_Sniper_Lightning(self, org, endpos, i);
	}
};

vector(vector org, vector dir) Sniper_Lightning_Direction = 
{
	traceline (org, org + dir*4000, FALSE, self);
	vector endpoint = trace_endpos;
	return endpoint;
}

//=============================================================================================

.entity sibling;
.float fade_interval;

void(entity pl, vector org, vector dest, float hit) Draw_Sniper_Lightning = 
{
	float len = vlen(dest - org);
	vector dir = normalize(dest - org);
	vector ang = vectoangles(dest - org);
	float ct = floor(len / 30);
	entity sg;
	entity prevsg;

	for (float i = 0; i < ct; i++) {
		sg = spawn();
		if (prevsg) prevsg.sibling = sg;

		setmodel(sg, "progs/railtrail_red.mdl");
		setsize(sg, VEC_ORIGIN, VEC_ORIGIN);
		setorigin(sg, org + dir * 30 * i);

		sg.flags |= CFL_PROJECTILE;
		sg.classname = "lgsegment";
		sg.angles = ang;
		sg.angles_z = random() * 360;
		sg.owner = pl;

		sg.think = rail_fade;

		float base_interval = 0.03;

		// farther segments tick slower
		sg.fade_interval = base_interval + (i * 0.0004);

		sg.cnt = 4 + i;
		if (sg.cnt > 12) sg.cnt = 12; // clamp max to keep reasonable

		sg.nextthink = time + sg.fade_interval;
		sg.alpha = 0.9;
		sg.state = hit;

		prevsg = sg;
	}

	if (sg) sg.effects |= EF_MUZZLEFLASH;
}

void() rail_fade = 
{
	self.think = rail_fade;
	self.nextthink = time + self.fade_interval;

	if (self.skin < 6)
		self.skin++;

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
	else if (self.cnt == 1) 
	{
		self.alpha = 0.05;
		self.think = SUB_Remove;
		self.nextthink = time + self.fade_interval;
	}	
	else
	{
		self.alpha = 0.0;
		self.think = SUB_Remove;
		return;
	}

	self.cnt = self.cnt - 1;
};
