//=============================================================================================
// Placeholder weapons testing
//=============================================================================================

string	SSG_SUPERSAWED_NAME	=	"SSG_SUPERSAWED";
string	SSG_SUPERSAWED_MODEL	=	"progs/placeholder_progs/v_shotgun_sawed.mdl";


//	ROF	COUNT * DMG	COST	SPREAD			DESCRIPTION
//	1.05	22	4	1	'280 60 0'		//QBJ3 flak (88)

//	1.4	16	8	2	'420 180 0'		//W_Fire_SSG_SUPERSAWED_flak (128)
//	1.9	22	13	4	'640 180 0'		//Big Hitbox + Short Linear Travel = 4 cost (286)

//	1.8	15	10	2	'600 200 0'		//Nerfed Double Barrel SSG (150++) point ent


//=============================================================================================
	
	
	float	SSG_SUPERSAWED_ROF	=	1.8;		//seconds post-fire
	
	float	SSG_SUPERSAWED_COUNT	=	15;		//number of shots
	float	SSG_SUPERSAWED_DMG 	=	10;	//150	//damage per shot

	float	SSG_SUPERSAWED_COST	=	2;		//ammo cost to fire
	
	float	SSG_SUPERSAWED_LIFE	=	0.2;		//0.25 sec of pellet life
	
	vector	SSG_SUPERSAWED_SPREAD	=	'600 200 0';	//seconds post-fire	//W_Fire_SSG_SUPERSAWED_flak


//=============================================================================================

float() weaponanim_SSG_SUPERSAWED =
{
	if (self.attack_finished > time)
		return FALSE;
	
	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon(), FALSE);
		return FALSE;}
	
	self.currentammo = self.ammo_shells = self.ammo_shells - SSG_SUPERSAWED_COST;
	self.attack_finished = time + SSG_SUPERSAWED_ROF;

	SUB_CallAsSelf(player_shot1, self.animcontroller);
	self.effects = self.effects | EF_MUZZLEFLASH;

	SuperDamageSound();
	
	self.customflags |= CFL_WEAPONLOCK;	//weapon LOCK
	
	W_Fire_SSG_SUPERSAWED_flak();

	self.weaponframe = 11;	
	self.think = weaponanim_SSG_SUPERSAWED_loop;
	self.nextthink = time + 0.06;	
	return TRUE;
}

void() weaponanim_SSG_SUPERSAWED_loop =
{
	if (intermission) return;

	if (self.weaponframe == 25)
	{	
		Eject_BuckshotCasing();
		Eject_BuckshotCasing();
		sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	}
	
	if (self.weaponframe == 34) sound(self, CHAN_AUTO, "placeholder_sound/shell_reload.wav", 1, ATTN_NORM);
	
	if (self.weaponframe >= 40)	self.customflags &~= CFL_WEAPONLOCK;	//weapon UNLOCK
	
	if (self.weaponframe >= 50)
	{
		self.weaponframe = 10;
		return;
	}
	else 	self.weaponframe++;

	self.think = weaponanim_SSG_SUPERSAWED_loop;
	self.nextthink = time + 0.06;
}
//=============================================================================================

void() W_Fire_SSG_SUPERSAWED_flak =
{
	sound(self, CHAN_AUTO, "placeholder_sound/shotgun2.wav", 1, ATTN_NORM);
	
	makevectors(self.v_angle);
	self.punchangle_x = -4;
	
	//self.velocity = self.velocity + (v_forward * -100) + '0 0 25';	//shotgun jump +64 units
	self.velocity = self.velocity + (v_forward * -150) + '0 0 25';		//shotgun knockback
	
	float shotcount = SSG_SUPERSAWED_COUNT;
	vector spread = SSG_SUPERSAWED_SPREAD;
	vector view_origin = self.origin + self.view_ofs + v_forward*12 + v_up*-4 + v_right*4;

	vector mvel;
	entity fl;
	while (shotcount > 0)
	{
		mvel = (v_forward * 2000) + (v_up * 100) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;
		fl = Launch_Flak_SSG_SUPERSAWED(view_origin, mvel);
		fl.count = shotcount;
		shotcount = shotcount - 1;
	}
}
//=============================================================================================

entity(vector org, vector vel) Launch_Flak_SSG_SUPERSAWED =
{
	entity flak;
	//gunshot(org);
	flak = toss_projectile(org, vel, "flak");
	flak.lifetime_finished = time + SSG_SUPERSAWED_LIFE;
	flak.attack_finished = time + 1;
	flak.gravity = -0.001;
	flak.think = FlakThink;
	flak.nextthink = time + 0.05;
	flak.touch = FlakTouch_SSG_SUPERSAWED_pierce_knockback;
	flak.alpha = 1;
	flak.oldvelocity = flak.velocity;
	//flak.movetype = MOVETYPE_FLYMISSILE;	//point

	//SUB_ChangeModel (flak, "progs/placeholder_progs/proj_pellet_blue.mdl");
	SUB_ChangeModel (flak, "progs/proj_pellet.mdl");

	return flak;
}
//=============================================================================================

void() FlakTouch_SSG_SUPERSAWED_pierce_knockback =
{
	if (CheckProjectilePassthru()) return;

	if (pointcontents(self.origin) == CONTENT_SKY) {
		remove(self);
		return;
	}
	
	if (other.takedamage)
	{
		if ((other.classname == "monster_swarmer" || other.classname == "monster_zombie" ) ||	// IF swarmer or zombie...
			(other.classname == "monster_fish" && other.health <= SSG_SUPERSAWED_DMG))	// OR IF fish 1 pellet away from death...
			T_Damage(other, self, self.trueowner, 60);					// gib'em!
		else
			T_Damage(other, self, self.trueowner, SSG_SUPERSAWED_DMG);

		//------------------------------------------------------------------------------- proj KNOCK BACK
		if ((other.movetype == MOVETYPE_STEP || other.movetype == MOVETYPE_WALK) && 
			// don't swat bosses or other non-standard-sized enemies around
			other.maxs_x <= 128 && /*other.health > 0 &&*/ other.type != "boss")
		{			
			local vector toss;
			toss = v_forward;
			toss_z = 0;
				
			toss = normalize(toss) * 400;
			toss_z = 100;
			
			other.origin_z = other.origin_z + 0;
			other.velocity = toss;
			other.flags = not(other.flags, FL_ONGROUND);		
		}
		//------------------------------------------------------------------------------- proj KNOCK BACK

		if (other.solid != SOLID_BSP) {
			//ThrowGib ("progs/zom_gib.mdl", GibVelocityForHealth(SSG_SUPERSAWED_DMG));
		}
		
		FX_Impact(FX_BLOOD_BIG, self.origin, self.oldvelocity);

		particle (self.origin, self.velocity*0.1, 73, 40);

		float chance = random();
		
		if 	(chance < 0.33)	sound (self, CHAN_AUTO, "rebar/pierce1.wav", 0.2, ATTN_NORM);
		else if (chance < 0.5)	sound (self, CHAN_AUTO, "rebar/pierce2.wav", 0.2, ATTN_NORM);
		else			sound (self, CHAN_AUTO, "rebar/pierce3.wav", 0.2, ATTN_NORM);
		
		//sound (self, CHAN_AUTO, "rebar/pierce_impact.wav", 1, ATTN_NORM);

		// doesn't go through doors
		if (other.classname != "func_door" && other.classname != "func_door_secret"){
			projectile_passthru();
			return;
		}
	}
	else
		//FX_Impact(FX_SPARK_LASER, self.origin, self.origin);
		FX_Impact(FX_SPARK, self.origin, self.origin);
		remove(self);	
}