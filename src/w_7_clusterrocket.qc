////////////////////////////////////////////////////////////////////////////////////////////////
// EE code by bmFbr, (bad) edits by Kebby
////////////////////////////////////////////////////////////////////////////////////////////////


float() weaponanim_boxrocket = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		self.customflags &~= CFL_WEAPONLOCK;
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.attack_finished = time + 1.6;
	
	SUB_CallAsSelf(player_rockatt1, self.animcontroller);
	
	boxrocket_launch('0 -6 -8', 0);	//<<<  1
	
	self.customflags |= CFL_WEAPONLOCK;

	self.weaponframe = 1;
	self.think = weaponanim_boxrocket_loop;
	self.nextthink = time + 0.05;
	
	SuperDamageSound();
	
	return TRUE;
}

void() weaponanim_boxrocket_loop = {
	if (intermission) return;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		self.attack_finished = time + 0.05;
		self.customflags &~= CFL_WEAPONLOCK;
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return;
	}

	if (self.weaponframe >= 1 && self.weaponframe <= 14){
		self.customflags |= CFL_WEAPONLOCK;
		//dprint("locked\n");
	}
	else
		self.customflags &~= CFL_WEAPONLOCK;
	
	//dprint3("Intermission: ", ftos(intermission), "\n");
	if (self.weaponframe == 2)  	boxrocket_launch('0 -2 -8', 1);		//<<<  2
	if (self.weaponframe == 4)  	boxrocket_launch('0  2 -8', 0);		//<<<  3
	if (self.weaponframe == 6)  	boxrocket_launch('0  6 -8', 1);		//<<<  4
	if (self.weaponframe == 8)  	boxrocket_launch('0 -6 -12', 0);	//<<<  5
	if (self.weaponframe == 10) 	boxrocket_launch('0 -2 -12', 1);	//<<<  6
	if (self.weaponframe == 11)	sound (self, CHAN_AUTO, "mmml/silo_latch.wav", 1, ATTN_NORM);
	if (self.weaponframe == 12) 	boxrocket_launch('0  2 -12', 0);	//<<<  7
	if (self.weaponframe == 14) {	boxrocket_launch('0  6 -12', 1);	//<<<  8
	
		sound (self, CHAN_AUTO, "mmml/silo_clunk.wav", 1, ATTN_NORM);
		sound (self, CHAN_AUTO, "mmml/silo_clunk2.wav", 1, ATTN_NORM);
	}
	if (self.weaponframe == 18)	sound (self, CHAN_AUTO, "mmml/silo_load.wav", 1, ATTN_NORM);
	if (self.weaponframe == 20)	sound (self, CHAN_AUTO, "mmml/silo_load2.wav", 1, ATTN_NORM);
	
	
	if (self.weaponframe >= 32) {
		self.weaponframe = 0;
		return;
	}

	else {
		self.weaponframe++;
	}

	self.think = weaponanim_boxrocket_loop;
	self.nextthink = time + 0.05;
}

//=====================================================================================================================

void(vector ofs, float ammoUsage) boxrocket_launch = {
	self.currentammo = self.ammo_rockets = self.ammo_rockets - ammoUsage;
	self.punchangle_x = -2;
	self.effects = self.effects | EF_MUZZLEFLASH;

	W_FireSpiralRocket(ofs);
}

void(vector ofs) W_FireSpiralRocket =
{
	local	vector dir, org;

	sound (self, CHAN_WEAPON, "weapons/sgun1.wav", 0.8, ATTN_NORM);
	
	local float r;
	r = random();
	
	if	(r<0.25)sound (self, CHAN_AUTO, "mmml/fire1.wav", 1, ATTN_NORM);
	else if (r<0.5)	sound (self, CHAN_AUTO, "mmml/fire2.wav", 1, ATTN_NORM);
	else if (r<0.75)sound (self, CHAN_AUTO, "mmml/fire3.wav", 1, ATTN_NORM);
	else 		sound (self, CHAN_AUTO, "mmml/fire4.wav", 1, ATTN_NORM);
	
	
	makevectors (self.v_angle);
	dir = aim(self, 1000);

	org = self.origin + self.view_ofs + v_up*ofs_z + v_right*ofs_y;
	traceline(org, org + v_forward * 15, FALSE, self);
	launch_spiralrocket(org + v_forward*15 * trace_fraction, dir, 0);
};

////////////////////////////////////////////////////////////////////////////////////////////////

void() spiralrocket_touch =
{
	local float	damg, rdamg;

	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY)	{
		remove(self.buddy);
		remove(self);
		return;
	}

	damg = 50 + random()*10;
	rdamg = 60;

	if (other.health)
		T_Damage(other, self, self.owner, damg, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );
		
	
	// don't do radius damage to the other, because all the damage
	// was done in the impact.
	// Radius damage type will always be EXPLOSION
	vector prev_vel = self.velocity;
	//self.velocity = '0 0 0';
	T_RadiusDamage (self, self.owner, rdamg, other, DMGTYPE_EXPLOSION | DMGTYPE_ZKILL );

	self.origin = self.origin - 8*normalize(prev_vel);

	remove(self.buddy);

	if (other.classname == "monster_shambler")
		BecomeMiniBlast(2); //weak, no TE_effects
	else
		BecomeMiniBlast(0); //normal, no TE_effects
};
//=============================================================================================

void(float blasttype) BecomeMiniBlast = 
{
	// no extra explosion effects for minis, too much spam, sprites only
	
	if (blasttype == 2)
		//setmodel (self, "progs/s_explo2.spr");
		setmodel (self, "progs/s_explosion_mini_smoke.spr");
	else
		//setmodel (self, "progs/s_explod.spr");
		setmodel (self, "progs/s_explosion_mini.spr");
	
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	self.solid = SOLID_NOT;
	
	//s_explode1 ();
	s_explode_start ();
}
//=============================================================================

void(vector org, vector dir, float init_angle) launch_spiralrocket = {
	//local	entity missile;

	entity pointer = spawn();
	pointer.owner = self;
	pointer.enemy = self.enemy;
	pointer.movetype = MOVETYPE_NOCLIP;
	pointer.solid = SOLID_NOT;
	setorigin (pointer, org);	
	pointer.think = SUB_Remove;
	pointer.nextthink = time + 6;
	pointer.classname = "spiralrocket_pointer";
	pointer.velocity = dir * 1000;
	pointer.ideal_yaw = init_angle;

	vector ang = vectoangles(dir);
	makevectors([-ang_x, ang_y, ang_z]);
	pointer.dest1 = v_right;
	pointer.dest2 = v_up;
	
	setorigin (pointer, org);

	entity newmis = spawn();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.classname = "missile";
	newmis.type = "missile";
	newmis.touch = spiralrocket_touch;
	newmis.angles = vectoangles(dir);
	newmis.velocity = dir * 1000;

	setmodel (newmis, "progs/proj_missile.mdl");
	setsize (newmis, '0 0 0', '0 0 0');
	setorigin (newmis, org);

	newmis.buddy = pointer;
	pointer.buddy = newmis;

	newmis.attack_finished = time + 5;

	//newmis.nextthink = time + 0.25; //0.05;
	newmis.nextthink = time + 0.1; //0.05;
	newmis.think = spiralrocket_think;
	
	
	//newmis = missile;
};
//=============================================================================

void() spiralrocket_think = {
	if (CheckProjectilePassthru()) return;

	if (time > self.attack_finished) {
		if (self.buddy) remove(self.buddy);
		remove(self);
	}

	entity ptr = self.buddy;
	
	float interval = 0.025;

	ptr.ideal_yaw += 36;

	vector dest = ptr.origin + ptr.velocity*interval + cos(ptr.ideal_yaw)*ptr.dest1*6 + sin(ptr.ideal_yaw)*ptr.dest2*6;

	self.velocity = (dest - self.origin)/interval;
	self.avelocity_z = -540;

	self.nextthink = time + interval;
}
