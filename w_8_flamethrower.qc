////////////////////////////////////////////////////////////////////////////////////////////////
// 
////////////////////////////////////////////////////////////////////////////////////////////////

float() weaponanim_flamethrower = {	// handled via animation loop4
	if (self.attackhold && self.attack_finished > time) {
		return FALSE;
	}

	if (self.attack_finished > time)
		return FALSE;

	SUB_CallAsSelf(player_light1, self.animcontroller);

	self.weaponframe = 0;
	
	weaponanim_flamethrower_loop();
	
	return TRUE;
	
}

void() weaponanim_flamethrower_loop = {
	if (!self.attackhold && !self.attackpressed){
		self.weaponframe = 0;
		SUB_CallAsSelf(player_run, self.animcontroller);
		return;
	}


	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE){
		W_ChangeWeapon(W_BestWeapon());
		return;
	}

	if (self.weaponframe >= 4) {
		self.weaponframe = 1;
	}
	else {
		self.weaponframe++;
	}
	
	self.attack_finished = time + 0.2;

	//self.currentammo = self.ammo_cells = self.ammo_cells - 1;

	//self.punchangle_x = -1;

	self.effects |= EF_MUZZLEFLASH;

	SuperDamageSound();
	
	
	
	
	//W_FireFlamethrower();
	
	sound (self, CHAN_WEAPON, "flamer.wav", 1, ATTN_NORM);
	
	local vector dir = v_forward;
	
	Define_Flamethrower_Spread(2, dir, '40 40 0');
	
	
	
	//W_FireLightning();

	self.think = weaponanim_flamethrower_loop;
	self.nextthink = time + 0.05;
}
////////////////////////////////////////////////////////////////////////////////////////////////

void() anim_flame1_loop = {

	self.angles = vectoangles(self.velocity);
	self.flags = not(self.flags, FL_ONGROUND);
	self.oldvelocity = self.velocity;
	
	
	self.effects = EF_DIMLIGHT;
		
	
	if (self.frame >= 40) {
		remove(self);
	}
	else {
		self.frame++;
	}

	self.think = anim_flame1_loop;
	self.touch = FlamethrowerFireTouch;
	self.nextthink = time + 0.025;
}
//=============================================================================================

void() FlamethrowerFire_GroundFireTouch = {
	
	self.origin = self.origin - 2*normalize(self.velocity);	// move origin away from walls when stuck
	
	self.velocity = 0;
	
								// helps prevent "void-lighting"
	self.touch = SUB_Null;
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_NOT;	
	
	self.think = anim_flame1_groundfire_loop;
	self.nextthink = time + 0.025;
	
	
	sound (self, CHAN_OTHER, "flamer_loop.wav", 0.5, ATTN_NORM);
	setmodel (self, "progs/flame1_ground.mdl");
	
	
	//self.think = anim_flame1_wallstop_loop;
	//self.touch = FlamethrowerFireTouch;
	//self.nextthink = time;
}


void() anim_flame1_groundfire_loop = {


	T_RadiusDamage (self, self.trueowner, 20, self.trueowner, DMGTYPE_EXPLOSION); //no self damage
	//T_RadiusDamage (self, self.trueowner, 20, world, DMGTYPE_EXPLOSION);
	
	
	self.effects = EF_DIMLIGHT;
	
	
	if (self.frame >= 40) {
		remove(self);
	}
	else {
		self.frame++;
	}

	self.think = anim_flame1_groundfire_loop;
	//self.touch = FlamethrowerFireTouch;
	self.nextthink = time + 0.05;
}

////////////////////////////////////////////////////////////////////////////////////////////////

void(float shotcount, vector dir, vector spread) Define_Flamethrower_Spread =
{
	entity m;
	vector mvel;
	local vector	view_origin;

	makevectors (self.v_angle);
	
	view_origin = ((self.origin + self.view_ofs) + v_forward* 12 + v_up* -4); //+ v_right* 8;

	ClearMultiDamage ();
	while (shotcount > 0)
	{		
		//RANDOM SPREAD
		mvel = (v_forward * 1000) + (v_up * 100) + crandom()*spread_x*v_right + crandom()*spread_y*v_up;

		
		m = Launch_FlamethrowerFire(view_origin, mvel);
		m.gravity = -0.5; //.5;
		m.think = anim_flame1_loop;
		m.touch = FlamethrowerFireTouch;
		m.th_die = SUB_Remove;
		m.buddy = self;		
		
		shotcount = shotcount - 1;
	}
	ApplyMultiDamage ();
	
}
//=============================================================================================

entity(vector org, vector vel) Launch_FlamethrowerFire =
{
	entity flamethrowerfire;
	//gunshot(org);
	flamethrowerfire = toss_projectile(org, vel, "impaler");
	flamethrowerfire.lifetime_finished = time + 1;


	flamethrowerfire.solid = SOLID_BBOX;
	flamethrowerfire.solid = MOVETYPE_BOUNCE;


	SUB_ChangeModel (flamethrowerfire, "progs/flame1_thrower.mdl");

	return flamethrowerfire;
}

//=============================================================================================

void() FlamethrowerFireTouch =
{
	if (other == self.owner ) return;		// don't touch owner
	if (CheckProjectilePassthru()) return;
	
	if ((other.takedamage == DAMAGE_AIM) || (other.takedamage == DAMAGE_YES))
	{
			//if (other.classname == "monster_zombie")	T_Damage(other,self.buddy,self.buddy,9);
			//else						T_Damage(other,self.buddy,self.buddy,9);
			
			//T_Damage(other,self.buddy,self.buddy,7); //10x10 20x5 15x7
			
			
			
			
			
			//T_RadiusDamage (self, self.trueowner, 25, world, DMGTYPE_EXPLOSION);
			
			T_RadiusDamage (self, self.trueowner, 25, self.trueowner, DMGTYPE_EXPLOSION); //no self damage
			
			
			//FlamethrowerFire_IgniteEnemyTouch(); //ignite enemy instead???  how make follow enemy?

			

			ThrowFire ("progs/flame1_ignite.mdl", '0 0 0'); //idk how to make fire stick :(
			
			FlamethrowerFire_IgniteEnemyTouch();
			
		
			//particle (self.origin, self.velocity*0.1, 73, 40);
			



			projectile_passthru();

			return;
	}
	
	if (!other.takedamage)	//do not get stuck on wall, remove with temp effect
	{
		gunshot(self.origin);

		//stick in the wall if we hit worldspawn as we know that won't move
		if (other == world)
		{
		self.think = FlamethrowerFire_GroundFireTouch;
		}
		else
		remove(self);
	}
	
	// nonsense for combining quad SNG spike damage
	if (self.buddy)	self.buddy.dmg = 0;
	
	//remove(self);
	
}
////////////////////////////////////////////////////////////////////////////////////////////////

entity(string gibname, vector vel) ThrowFire =
{

	entity gib;
	gib = spawn();
	
	// gibs have to be thinking ballistic projectiles to pass through monsterclip/notrace
	//gib.owner = gib.trueowner = self;
	//gib.touch = projectile_touch_null;
	//gib.th_die = SUB_Remove;
	gib.think = projectile_fire_think;
	gib.nextthink = time;
	//gib.touch = projectile_touch_null;
	//gib.lifetime_finished = time + 6 + random() * 6;

	setmodel(gib, gibname);
	setsize (gib, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (gib, self.origin);

	gib.velocity = gib.oldvelocity = vel;	
	//gib.avelocity = Vector(random(),random(),random()) * 3000;
	gib.avelocity = 0;

	gib.movetype = MOVETYPE_BOUNCE;
	
	gib.type = "gib";
	
	return gib;
}

void() projectile_fire_think =
{
	
	T_RadiusDamage (self, self.trueowner, 10, self.trueowner, DMGTYPE_EXPLOSION); //no self damage???
	//T_RadiusDamage (self, self.trueowner, 20, world, DMGTYPE_EXPLOSION);
	
	
	self.effects = EF_DIMLIGHT;
	
	
	if (self.frame >= 40) {
		remove(self);
	}
	else {
		self.frame++;
	}

	//self.think = anim_flame1_igniteenemy_loop;
		
	self.flags = not(self.flags, FL_ONGROUND);
	self.oldvelocity = self.velocity;
	self.nextthink = time + 0.05;	// 10hz is probably enough, but 20hz is surely twice as good
}

////////////////////////////////////////////////////////////////////////////////////////////////

void() FlamethrowerFire_IgniteEnemyTouch =
{

	if ( ((self.enemy != world) && (self.enemy.health > 1)) )		// if enemy & alive:
	{
		setmodel (self, "progs/flame1_ignite.mdl");
		self.frame = 1;
		
		self.think = anim_flame1_igniteenemy_loop;
		self.velocity = (self.velocity * 0);
		self.avelocity = VEC_ORIGIN;
		
		self.origin = self.enemy.origin;	
		if ( (self.velocity == VEC_ORIGIN) ) {self.avelocity = VEC_ORIGIN;}
	}
	self.nextthink = (time + 0.05);
	
	
	
	/*
	entity ignite;
	
	ignite = launch_projectile(self.enemy.origin, 0, "ignite");

	
	SUB_ChangeModel (ignite, "progs/flame1_ignite.mdl");
	
	
	sound (self, CHAN_AUTO, "flamer.wav", 1, ATTN_NORM); 		//stick sound
	ignite.frame = 1;
	
	ignite.think = anim_flame1_igniteenemy_loop;
	self.nextthink = time + 0.05;
	ignite.velocity = 0;
	ignite.avelocity = VEC_ORIGIN;
			
	ignite.origin = ignite.enemy.origin;	
	//if ( (ignite.velocity == VEC_ORIGIN) ) {ignite.avelocity = VEC_ORIGIN;}
	*/
};
//=============================================================================================

void() anim_flame1_igniteenemy_loop = 	//updates position of stuck satchel charge on enemy
{
	/*
	if ( ((self.enemy != world) && (self.enemy.health > 1)) )		// if enemy & alive:
	{
		self.origin = self.enemy.origin;	
		if ( (self.velocity == VEC_ORIGIN) ) {self.avelocity = VEC_ORIGIN;}
	}
	*/
	
	//T_RadiusDamage (self, self.trueowner, 20, self.trueowner, DMGTYPE_EXPLOSION); //no self damage
	//T_RadiusDamage (self, self.trueowner, 20, world, DMGTYPE_EXPLOSION);
	
	
	self.effects = EF_DIMLIGHT;
	
	
	if (self.frame >= 40) {
		remove(self);
	}
	else {
		self.frame++;
	}

	self.think = anim_flame1_igniteenemy_loop;
	//self.touch = FlamethrowerFireTouch;
	self.nextthink = time + 0.05;
};