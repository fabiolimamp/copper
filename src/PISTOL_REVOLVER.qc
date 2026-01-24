//=============================================================================================
// tracers and bullet code by bmFbr, edits by Kebby
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

	
	float	PISTOL_REVOLVER_ROF 	= 0.6;		// stetchkin 0.3 sec

	float	PISTOL_REVOLVER_DMG	= 40;		// stetchkin 20 damge
	
	float	PISTOL_REVOLVER_RELOAD	= 2;		// stetchkin 1.5 sec
		
	vector	PISTOL_REVOLVER_SPREAD	= '0.01 0.02 0';	// 'width, height, 0' stetchkin '0.015 0.015 0'


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
	
			
	W_Fire_PISTOL_REVOLVER(0); //fancy tracers and all that
	
	
	// --------------------------------
	// Low Ammo Alert
	if 	(self.pistol_ammo_count ==  0) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 1, ATTN_NORM);
	else if (self.pistol_ammo_count ==  1) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.85, ATTN_NORM);
	else if (self.pistol_ammo_count ==  2) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.7, ATTN_NORM);	
	else if (self.pistol_ammo_count ==  3) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.55, ATTN_NORM);	
	// --------------------------------

	self.weaponframe = 11;
	
	self.think = weaponanim_PISTOL_REVOLVER_loop;
	self.nextthink = time + 0.04;
	
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
	self.nextthink = time + 0.04;
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

void(float lefty) W_Fire_PISTOL_REVOLVER =
{
	sound (self, CHAN_AUTO, "pistol/pistol_fire.wav", 1, ATTN_NORM);
	sound_pistol_fire(1);
	
	makevectors (self.v_angle);
	vector org_gun;
	
	if (lefty)	org_gun = self.origin + self.view_ofs - v_up * 8 - v_right *  8;
	else		org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  8;
	
	vector org_eye = self.origin + self.view_ofs;
	
	// aim point directly in front of the crosshair
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
		
	ClearMultiDamage ();
	
	FirePistolBullets (1, PISTOL_REVOLVER_DMG, org_eye, org_gun + v_forward * 16 * trace_fraction, dir_eye, PISTOL_REVOLVER_SPREAD, TRUE);
	
	ApplyMultiDamage ();
	self.punchangle_x = -1;	//punch AFTER makevectors
};
