//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	RAILGUN_NAME	=	"Railgun (temp name)";
string	RAILGUN_MODEL	=	"progs/placeholder_progs/v_power_rifle.mdl";


//	ROF	COUNT * DMG	COST	SPREAD		DESCRIPTION
//	1.5	6	666	1			//POWER RIFLE ()


//=============================================================================================
	
	
	float	RAILGUN_COOLDOWN		=	1.6;		//seconds post-fire
	
	float	RAILGUN_DAMAGE 	=	333;	// 	//damage per shot

	float	RAILGUN_COST	=	1;		//ammo cost to fire
	

//=============================================================================================


float() weaponanim_RAILGUN =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_cells = self.ammo_cells - RAILGUN_COST;

	self.attack_finished = time + RAILGUN_COOLDOWN;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	
	W_Fire_RAILGUN();
	
	
	self.punchangle_x = -4;
	self.effects |= EF_MUZZLEFLASH;


	self.weaponframe = 11;
	self.think = weaponanim_RAILGUN_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_RAILGUN_loop =
{
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_RAILGUN_loop;
	self.nextthink = time + 0.05;
}
//=============================================================================================

void() W_Fire_RAILGUN =
{
	sound (self, CHAN_AUTO, "rebar/penfire.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "placeholder_sound/sniper.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "pistol/pistol_fire.wav", 1, ATTN_NORM);
	
	
	

	SUB_CallAsSelf(player_shot1, self.animcontroller);

	makevectors(self.v_angle);

	vector org = self.origin + self.view_ofs + (v_forward * 4) + (v_right * 10) + (v_up * -8);
	
	vector dir = v_forward;
	vector up = v_up;
	vector right = v_right;


	invokerTrace(RAILGUN_DAMAGE, org + (up * 0) + (right * 0), dir, TRUE); // center
	
	
	//Start_Smoketrail_ROCKET_INSTANT();
	
	Draw_Tracertrail(self, org, trace_endpos, 0, "progs/placeholder_progs/railtrail_smoke.mdl", 1);
	
	
	FX_Impact(FX_CHAINS, trace_endpos, 0);
}
