//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	ROCKET_ORIGINAL_NAME	=	"ROCKET_ORIGINAL";
string	ROCKET_ORIGINAL_MODEL	=	"progs/placeholder_progs/v_rocket_original.mdl";

//=============================================================================================

float() weaponanim_ROCKET_ORIGINAL = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_rockets = self.ammo_rockets - 1;

	self.attack_finished = time + 0.8;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	W_FireRocket();

	self.weaponframe = 11;
	self.think = weaponanim_ROCKET_ORIGINAL_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_ROCKET_ORIGINAL_loop = {

	if (self.weaponframe >= 30) {
		self.weaponframe = 0;
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_ROCKET_ORIGINAL_loop;
	self.nextthink = time + 0.05;

}
