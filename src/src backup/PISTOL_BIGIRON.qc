//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

	string	PISTOL_BIGIRON_NAME	=	"PISTOL_BIG_IRON";
	string	PISTOL_BIGIRON_MODEL	=	"progs/placeholder_progs/v_pistol_bigiron.mdl";


//=============================================================================================


	float	PISTOL_BIGIRON_ROF 	= 0.7;		// stetchkin 0.3 sec

	float	PISTOL_BIGIRON_COUNT	= 5;
	float	PISTOL_BIGIRON_DMG	= 15;	//75	// stetchkin 20 damge
	
	float	PISTOL_BIGIRON_RELOAD	= 1.8;		// stetchkin 1.5 sec
		
	vector	PISTOL_BIGIRON_SPREAD	= '0.075 0.06 0';	// 'width, height, 0' stetchkin '0.015 0.015 0'

//=============================================================================================

float() weaponanim_PISTOL_BIGIRON =
{
	if (self.attack_finished > time)
		return FALSE;

	// detects if a reload is still happening without having to rely on attack_finished
	if (self.think == weaponanim_reload_PISTOL_BIGIRON_loop) 
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.weaponreload_perc = 0;

	if (self.pistol_ammo_count == 1)
	{
		weaponanim_reload_PISTOL_BIGIRON();
		return FALSE;
	}
		
	self.pistol_ammo_count--;
	self.pistol_ammo_count--;

	self.currentammo = self.pistol_ammo_count;

	if (self.pistol_ammo_count <= 0)
	{
		self.pistol_lastreload_time = time;
	}
	
	self.attack_finished = time + PISTOL_BIGIRON_ROF;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
			
			
	W_Fire_PISTOL_BIGIRON(); //fancy tracers and all that
	

	// --------------------------------
	// Low Ammo Alert
	if 	(self.pistol_ammo_count ==  0) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 1, ATTN_NORM);
	else if (self.pistol_ammo_count ==  1) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.85, ATTN_NORM);
	else if (self.pistol_ammo_count ==  2) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.7, ATTN_NORM);	
	else if (self.pistol_ammo_count ==  3) sound (self, CHAN_AUTO, "pistol/ammo_rattle.wav", 0.55, ATTN_NORM);	
	// --------------------------------

	self.weaponframe = 11;
	
	self.think = weaponanim_PISTOL_BIGIRON_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_PISTOL_BIGIRON_loop =
{	
	//if (self.weaponframe == 12) Eject_BulletCasing();
	
	if (self.pistol_ammo_count <= 0 && time > (self.attack_finished - 0.1))
	{
		weaponanim_reload_PISTOL_BIGIRON(); 
		return;
	}
	
	if (self.weaponframe == 18)	sound (self, CHAN_AUTO, "placeholder_sound/puckler_snap.wav", 1, ATTN_NORM);
	
	if (self.weaponframe >= 31)
	{
		self.weaponframe = 10;
		return;
	}
	else	self.weaponframe++;

	self.think = weaponanim_PISTOL_BIGIRON_loop;
	self.nextthink = time + 0.05;
}
//=====================================================================================================================

void() weaponanim_reload_PISTOL_BIGIRON =
{
	if (self.think == weaponanim_reload_PISTOL_BIGIRON_loop) 
		return;
	
	//Drop_PistolMag();
	Eject_BulletCasing();
	Eject_BulletCasing();
	Eject_BulletCasing();
	Eject_BulletCasing();
	Eject_BulletCasing();
	Eject_BulletCasing();
	Eject_BulletCasing();
	Eject_BulletCasing();
	Eject_BulletCasing();
	Eject_BulletCasing();
	
	self.pistol_lastreload_time = time;

	self.nextthink1 = time + PISTOL_BIGIRON_RELOAD;
	
	sound (self, CHAN_AUTO, "pistol/gun_click.wav", 1, ATTN_NORM);

	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.weaponreload_perc = 1/24;

	self.weaponframe = 35;
	
	self.think = weaponanim_reload_PISTOL_BIGIRON_loop;
	self.nextthink = time + 0.05;
}

void() weaponanim_reload_PISTOL_BIGIRON_loop =
{	
	if (self.weaponframe == 47) sound (self, CHAN_AUTO, "pistol/deadlock_reload.wav", 1, ATTN_NORM);		
		
	if (self.weaponframe >= 55)
	{
		self.pistol_ammo_count = 10; //RESET ammo
		self.weaponreload_perc = 0;
	}
	else	self.weaponreload_perc = min(self.weaponreload_perc + 1/24, 1);

	self.currentammo = self.pistol_ammo_count;

	if (self.weaponframe >= 64) {
		self.weaponframe = 0;
		self.think = SUB_Null;
		return;
	}
	else 	self.weaponframe++;

	if (time >= self.nextthink1)
		self.weaponframe = 64;

	self.think = weaponanim_reload_PISTOL_BIGIRON_loop;
	self.nextthink = time + 0.05;
}

//=====================================================================================================================

void() W_Fire_PISTOL_BIGIRON =
{
	sound (self, CHAN_AUTO, "pistol/pistol_fire.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "flak/volley_fire1.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "flak/volley_fire2.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "flak/volley_fire3.wav", 1, ATTN_NORM);
	sound_pistol_fire(1);
	
	makevectors (self.v_angle);
	vector org_gun = self.origin + self.view_ofs - v_up * 8 + v_right *  8;
	vector org_eye = self.origin + self.view_ofs;
	vector spread = PISTOL_BIGIRON_SPREAD;
	
	// aim point directly in front of the crosshair
	traceline2(org_eye, org_eye + v_forward * 10000, self, FALSE);

	vector dir_eye = normalize(trace_endpos - org_eye);
		
	ClearMultiDamage ();
	
	
	FirePistolBullets (PISTOL_BIGIRON_COUNT, PISTOL_BIGIRON_DMG, org_eye, org_gun + v_forward * 16 * trace_fraction, dir_eye, spread, 4, TRUE);
	
	//FirePierce_HitscanTrace(PISTOL_BIGIRON_DMG, org_gun, org_eye, dir_eye, TRUE);
	
	ApplyMultiDamage ();
	self.punchangle_x = -2;	//punch AFTER makevectors
};
//=====================================================================================================================

void() weaponanim_twirl_PISTOL_BIGIRON =
{	
	if (self.attack_finished > time)
		return;
	
	sound (self, CHAN_OTHER, "weapons/ax1.wav", 1, ATTN_NORM);
	//sound (self, CHAN_OTHER, "impact/wrench_swing.wav", 1, ATTN_NORM);

	if (self.weaponframe >= 66 && self.weaponframe <= 80)
		self.weaponframe = 68;
	
	else	self.weaponframe = 66;
	
	self.attack_finished = time + 0.1;
	
	self.think = weaponanim_twirl_PISTOL_BIGIRON_loop;
	self.nextthink = time + 0.05;
}

void() weaponanim_twirl_PISTOL_BIGIRON_loop =
{
	if (self.weaponframe == 82) sound (self, CHAN_AUTO, "pistol/gun_click.wav", 0.5, ATTN_NORM);

	if (self.weaponframe >= 91)
	{
		self.weaponframe = 0;
		self.think = SUB_Null;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_twirl_PISTOL_BIGIRON_loop;
	self.nextthink = time + 0.05;
}