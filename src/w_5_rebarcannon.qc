////////////////////////////////////////////////////////////////////////////////////////////////
// piercing projectile Impaler code by Fairweather, edits by Kebby and bmFbr
////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_rebarcannon = {
	if (self.attack_finished > time)
		return FALSE;

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;
	}

	self.currentammo = self.ammo_nails = self.ammo_nails - 10;

	self.attack_finished = time + 1;
	
	SUB_CallAsSelf(player_shot1, self.animcontroller);
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	W_FireRebarCannon();

	self.weaponframe = 1;
	self.think = weaponanim_rebarcannon_loop;
	self.nextthink = time + 0.05;
	
	return TRUE;
}

void() weaponanim_rebarcannon_loop = {

	if (self.weaponframe == 8)	sound (self, CHAN_AUTO, "rebar/bow_reload2.wav", 0.3, ATTN_NORM);
	if (self.weaponframe == 10)	sound (self, CHAN_AUTO, "rebar/bow_clank.wav", 0.4, ATTN_NORM);
	if (self.weaponframe == 13)	sound (self, CHAN_AUTO, "rebar/bow_reload3.wav", 0.3, ATTN_NORM);
	if (self.weaponframe == 16)	sound (self, CHAN_AUTO, "rebar/bow_reload4.wav", 0.4, ATTN_NORM);
	
		
	if (self.weaponframe >= 20) {
		self.weaponframe = 0;
		return;
	}
	else {
		self.weaponframe++;
	}

	self.think = weaponanim_rebarcannon_loop;
	self.nextthink = time + 0.05;

}

////////////////////////////////////////////////////////////////////////////////////////////////

void() W_FireRebarCannon =
{
	sound (self, CHAN_WEAPON, "rebar/penfire.wav", 1, ATTN_NORM);
	sound (self, CHAN_AUTO, "rebar/bow_reload1.wav", 0.5, ATTN_NORM);
	
	self.punchangle_x = -2;
	makevectors (self.v_angle);
	float base = 1400;
	
	vector org = self.origin + self.view_ofs - v_up*8 + v_forward*15;
	vector mvel = v_forward*base + v_up*160;
	
	launch_impaler(org, mvel);
}
////////////////////////////////////////////////////////////////////////////////////////////////

entity(vector org, vector vel) launch_impaler =
{
	entity impaler;
	gunshot(org);

	impaler = toss_projectile(org, vel, "impaler");
	impaler.lifetime_finished = time + 10;
	
	SUB_ChangeModel (impaler, "progs/proj_rebar.mdl");

	impaler.gravity = .75;
	impaler.think = ImpalerThink;
	impaler.touch = ImpalerTouch;
	impaler.alpha = 1;

	return impaler;
}

void() ImpalerThink =
{
	if (time > self.lifetime_finished)
	{
		ImpalerFade();
		return;
	}

	self.angles = vectoangles(self.velocity);
	self.flags &~= FL_ONGROUND;
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;
}

void() ImpalerFade =
{
	self.alpha -= 0.025;
	
	if (self.alpha <= 0)
	{
		remove(self);
		return;
	}

	if (!self.state)
	{
		self.angles = vectoangles(self.velocity);
		self.flags &~= FL_ONGROUND;
		self.oldvelocity = self.velocity;
	}

	self.think = ImpalerFade;
	self.nextthink = time + 0.05;
}


//=============================================================================================


void() ImpalerTouch =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		if (other.classname == "monster_zombie")
			T_Damage(other, self, self.trueowner, 59);
		else
			T_Damage(other, self, self.trueowner, 100);

		if (other.solid != SOLID_BSP) {
			ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(20));
			ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(20));
		}

		FX_Impact(FX_BLOOD_BIG, self.origin, self.oldvelocity);

		particle (self.origin, self.velocity*0.1, 73, 40);

		float chance = random();
		
		if 	(chance < 0.33)	sound (self, CHAN_AUTO, "rebar/pierce1.wav", 1, ATTN_NORM);
		else if (chance < 0.5)	sound (self, CHAN_AUTO, "rebar/pierce2.wav", 1, ATTN_NORM);
		else			sound (self, CHAN_AUTO, "rebar/pierce3.wav", 1, ATTN_NORM);
		
		sound (self, CHAN_AUTO, "rebar/pierce_impact.wav", 1, ATTN_NORM);

		// doesn't go through doors
		if (other.classname != "func_door" && other.classname != "func_door_secret"){
			projectile_passthru();
			return;
		}
	}
	
	sound (self, CHAN_AUTO, "rebar/stick1.wav", 0.5, ATTN_NORM);
	
	if (random() < 0.5)	sound (self, CHAN_AUTO, "rebar/stick_metal1.wav", 0.7, ATTN_NORM);
	else			sound (self, CHAN_AUTO, "rebar/stick_metal2.wav", 0.7, ATTN_NORM);

	FX_Impact(FX_SPARK, self.origin, self.oldvelocity);
	
	gunshot(self.origin);

	if (other.solid == SOLID_BSP && other.classname != "func_movewall") {
		self.movetype = MOVETYPE_NONE;
		self.solid = SOLID_NOT;
		self.owner = other;
		self.touch = SUB_Null;
		// change model so that smoke doesn't appear when stuck to moving brushes
		setmodel(self, "progs/proj_rebar_nosmoke.mdl");


		// move origin away from walls when stuck, helps prevent "void-lighting"
		setorigin(self, self.origin - 2*normalize(self.velocity));

		self.pos1 = other.absmin;

		// set state 2 to rebars attached to non-world entities (for movement and validity checks)
		if (other != world) self.state = 2;
		else self.state = 1;
		
		self.alpha = 1;
		self.think = ImpalerFade;
		self.nextthink = time + 10;
	}
	else
		remove(self);
	
}

void() updateRebars =
{
	entity e = find(world, classname, "impaler");
	while (e)
	{
		if (e.state)
		{
			// hole is in a valid non-world solid entity
			if (e.owner && e.owner.solid == SOLID_BSP)
			{
				if (e.owner.absmin != e.pos1)
				{
					setorigin(e, e.origin - e.pos1 + e.owner.absmin);
					e.pos1 = e.owner.absmin;
				}
			}

			// hole was originally in a non-world entity, but it was removed or changed to non-solid
			else if (e.state == 2) { 
				remove(e);
			}
		}

		e = find(e, classname, "impaler");
	}
}
//=====================================================================================================================

void() weaponanim_drawrebarcannon =
{		
	sound (self, CHAN_AUTO, "ammo/draw1.wav", 0.5, ATTN_NORM);
	
	self.weaponframe = 22;
	
	self.think = weaponanim_drawrebarcannon_loop;
	self.nextthink = time + 0.025;
}

void() weaponanim_drawrebarcannon_loop =
{
	if (self.weaponframe >= 32)
	{
		self.weaponframe = 0;
		self.think = SUB_Null;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_drawrebarcannon_loop;
	self.nextthink = time + 0.025;
}