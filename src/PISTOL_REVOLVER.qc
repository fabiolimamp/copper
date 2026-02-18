//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	PISTOL_REVOLVER_NAME	=	"PISTOL_REVOLVER";
string	PISTOL_REVOLVER_MODEL	=	"progs/placeholder_progs/v_pistol_revolver.mdl";

/*
	mateva revolver (WIP)
	{0-60}
	
	0   idle
	11  fire
	31  reload
*/
//=============================================================================================

//	ROF	COUNT * DMG	COST	SPREAD		DESCRIPTION
//	0.5	2	20	2	'0 0 0'		//Revolver (40) pierce 20/20
//	0.6	1	25++	2	'0 0 0'		//Revolver (20++) pierce 100%


//=============================================================================================

	
	float	PISTOL_REVOLVER_ROF 	= 0.5;		// stetchkin 0.3 sec

//	float	PISTOL_REVOLVER_COUNT	= 2;
	float	PISTOL_REVOLVER_DMG	= 30;	//++	// stetchkin 20 damge
	
	float	PISTOL_REVOLVER_RELOAD	= 2;		// stetchkin 1.5 sec
		
	vector	PISTOL_REVOLVER_SPREAD	= '0 0 0';	// 'width, height, 0' stetchkin '0.015 0.015 0'


//=============================================================================================

float() weaponanim_PISTOL_REVOLVER =
{
	if (self.attack_finished > time)
		return FALSE;

	// detects if a reload is still happening without having to rely on attack_finished
	if (self.think == weaponanim_reload_PISTOL_REVOLVER_loop) 
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	if (self.pistol_ammo_count <= 0)
	{
		weaponanim_reloadpistol();
		return FALSE;
	}
	
	self.weaponreload_perc = 0;
	
	if (self.pistol_ammo_count == 1)
	{	
		weaponanim_reload_PISTOL_REVOLVER();
		return FALSE;
	}
	self.pistol_ammo_count--;
	self.pistol_ammo_count--;

	self.currentammo = self.pistol_ammo_count;

	if (self.pistol_ammo_count <= 0)
	{
		self.pistol_lastreload_time = time;
	}
	
	
	
	self.attack_finished = time + PISTOL_REVOLVER_ROF;
	
	
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
			
	W_Fire_PISTOL_REVOLVER(); //fancy tracers and all that
	
	
	// --------------------------------
	// Low Ammo Alert
	if 	(self.pistol_ammo_count ==  0) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 1, ATTN_NORM);
	else if (self.pistol_ammo_count ==  1) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.85, ATTN_NORM);
	else if (self.pistol_ammo_count ==  2) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.7, ATTN_NORM);	
	else if (self.pistol_ammo_count ==  3) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.55, ATTN_NORM);	
	// --------------------------------

	self.weaponframe = 11;
	
	self.think = weaponanim_PISTOL_REVOLVER_loop;
	self.nextthink = time + 0.033;
	
	return TRUE;
}

void() weaponanim_PISTOL_REVOLVER_loop =
{	
	
	if (self.pistol_ammo_count <= 0 && time > (self.attack_finished - 0.1))
	{
		weaponanim_reload_PISTOL_REVOLVER(); 
		return;
	}
	
	if (self.weaponframe >= 30)
	{
		self.weaponframe = 10;
		return;
	}
	else	self.weaponframe++;

	self.think = weaponanim_PISTOL_REVOLVER_loop;
	self.nextthink = time + 0.033;
}

//=====================================================================================================================

void() weaponanim_reload_PISTOL_REVOLVER =
{
	if (self.think == weaponanim_reload_PISTOL_REVOLVER_loop) 
		return;
	
	
	self.pistol_lastreload_time = time;

	self.nextthink1 = time + PISTOL_REVOLVER_RELOAD;
	
	sound (self, CHAN_AUTO, "pistol/gun_click.wav", 1, ATTN_NORM);

	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.weaponreload_perc = 1/24;

	self.weaponframe = 31;
	
	self.think = weaponanim_reload_PISTOL_REVOLVER_loop;
	self.nextthink = time + 0.05;
}

void() weaponanim_reload_PISTOL_REVOLVER_loop =
{	
	if (self.weaponframe == 35) sound (self, CHAN_AUTO, "pistol/deadlock_reload.wav", 1, ATTN_NORM);		
	
	
	if (self.weaponframe == 42) 
	{
		Eject_BulletCasing();
		Eject_BulletCasing();
		Eject_BulletCasing();
		Eject_BulletCasing();
		Eject_BulletCasing();
	}	
	
		
	if (self.weaponframe >= 55)
	{
		self.pistol_ammo_count = 10; //RESET ammo
		self.weaponreload_perc = 0;
	}
	else	self.weaponreload_perc = min(self.weaponreload_perc + 1/24, 1);

	self.currentammo = self.pistol_ammo_count;

	if (self.weaponframe >= 60) {
		self.weaponframe = 0;
		self.think = SUB_Null;
		return;
	}
	else 	self.weaponframe++;

	if (time >= self.nextthink1)
		self.weaponframe = 60;

	self.think = weaponanim_reload_PISTOL_REVOLVER_loop;
	self.nextthink = time + 0.05;
}

//=====================================================================================================================

void() W_Fire_PISTOL_REVOLVER =
{
	sound (self, CHAN_AUTO, "pistol/pistol_fire.wav", 1, ATTN_NORM);
	sound_pistol_fire(1);
	
	makevectors (self.v_angle);
	vector org_gun;
	
	org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  8;
	
	vector org_eye = self.origin + self.view_ofs;
	
	// aim point directly in front of the crosshair
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
		
	ClearMultiDamage ();
	
	
	
	//FirePistolBullets (PISTOL_REVOLVER_COUNT, PISTOL_REVOLVER_DMG, org_eye, org_gun + v_forward * 16 * trace_fraction, dir_eye, PISTOL_REVOLVER_SPREAD, TRUE);
	
	
	
	FirePierce_HitscanTrace(PISTOL_REVOLVER_DMG, org_gun, org_eye, dir_eye, TRUE);
	
	
	
	//invokerTrace(PISTOL_REVOLVER_DMG, org + (up * 0) + (right * 0), dir, FALSE); // center
	//invokerTrace(PISTOL_REVOLVER_DMG, org_eye, dir_eye, FALSE); // center
		
	//Start_Smoketrail_ROCKET_INSTANT();
		
	//FX_Impact(FX_SPARK, trace_endpos, 0);
	
	
	
	ApplyMultiDamage ();
	self.punchangle_x = -1;	//punch AFTER makevectors
};
//=====================================================================================================================
//=====================================================================================================================
//=====================================================================================================================
//=====================================================================================================================
//=====================================================================================================================

void(float pierce_damage, vector org_gun, vector org_eye, vector dir_eye, float drawTrail) FirePierce_HitscanTrace =
{
	float timetoend;
	vector vel, loopsrc, destination, dir2, dir3;
	entity target_ent;
	
	
	destination = org_eye + (dir_eye * 8192);
	
	loopsrc = org_eye;
	target_ent = self;
	
	vector neworg = org_eye;
	while ( !timetoend )
	{
		traceline2(loopsrc, destination, target_ent, 0);
		if (trace_fraction != 1.0)
		{
			target_ent = trace_ent;

			neworg = trace_endpos - dir_eye*4;

			if (target_ent.takedamage && target_ent != self)
			{
				vel = dir_eye + 2*trace_plane_normal;
				vel = vel * pierce_damage;

				SpawnBlood(neworg, vel*0.2, pierce_damage);
				
				FX_Impact(FX_BLOOD, neworg, dir_eye);
				
				//sound_invoker_impact(1);
				
				target_ent.effects = target_ent.effects | EF_MUZZLEFLASH;

				//if (deathmatch != 0)
				//	T_Damage (target_ent, self, self, pierce_damage/2);
				//else
					T_Damage (target_ent, self, self, pierce_damage);
				
				// ded
				if (target_ent && target_ent.health <= 0 && target_ent.flags & (FL_MONSTER | FL_CLIENT))
				{
					// if we have the right amount of health add some velocity if we're not gibbing
					if (!(target_ent.customflags & CFL_GIBBED))
					{
						
						target_ent.velocity.z = pierce_damage;
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
						target_ent.velocity = target_ent.velocity + (dir2 * pierce_damage);
					}								
					// gibbed, so just let meat fly and call the invoked effect
					//else
						//FX_Invoked(target_ent.invokedmodel, target_ent.origin, dir, self.origin);
				}

				// Trace from inside of the hitted monster (vf)
				loopsrc = trace_endpos + (dir_eye * 4);
			}
			else
			{
				if (drawTrail) gunshot(trace_endpos);
				timetoend = 1;
				
				placebullethole(trace_endpos, trace_plane_normal, trace_ent);
			}
		}
		else timetoend = 1;
	}

	if (drawTrail)
		//drawInvokerTrail(self, org, trace_endpos);
		Draw_Smoketrail(self, org_gun + v_forward * 32, trace_endpos, 0);
		
	FX_Impact(FX_SPARK, trace_endpos, 0);
};