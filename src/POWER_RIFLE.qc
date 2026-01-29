//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	POWER_RIFLE_NAME	=	"POWER_RIFLE";
string	POWER_RIFLE_MODEL	=	"progs/placeholder_progs/v_power_rifle.mdl";


//	ROF	COUNT * DMG	COST	SPREAD		DESCRIPTION
//	1.5	6	666	1			//POWER RIFLE ()


//=============================================================================================
	
	
	float	POWER_RIFLE_ROF		=	1.6;		//seconds post-fire
	
	float	POWER_RIFLE_DMG 	=	333;	// 	//damage per shot

	float	POWER_RIFLE_COST	=	5;		//ammo cost to fire
	

//=============================================================================================


float() weaponanim_POWER_RIFLE =
{
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE)
	{
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - POWER_RIFLE_COST;

	self.attack_finished = time + POWER_RIFLE_ROF;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	
	W_Fire_POWER_RIFLE();
	
	
	self.punchangle_x = -4;
	self.effects |= EF_MUZZLEFLASH;


	self.weaponframe = 11;
	self.think = weaponanim_POWER_RIFLE_loop;
	self.nextthink = time + 0.025;
	
	return TRUE;
}

void() weaponanim_POWER_RIFLE_loop =
{
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_POWER_RIFLE_loop;
	self.nextthink = time + 0.05;
}
//=============================================================================================

void() W_Fire_POWER_RIFLE =
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


	invokerTrace(POWER_RIFLE_DMG, org + (up * 0) + (right * 0), dir, TRUE); // center
	
	
	Start_Smoketrail_ROCKET_INSTANT();
	
	
	FX_Impact(FX_CHAINS, trace_endpos, 0);
}
