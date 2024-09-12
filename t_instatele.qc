/*
==============================================================================

TELEPORT TRIGGERS

==============================================================================
*/

.string oldmodel;
.vector omins;
.vector omaxs;

float PLAYER_ONLY	= 1;
float SILENT = 2;
float TELE_STEALTH = 4;
float TELE_MONSTER_ONLY = 8;
float TELE_PLAYERTRIGGERED = 16;


float TELEPORT_STYLE_FIRST = 0;
float TELEPORT_STYLE_RANDOM = 1;
float TELEPORT_STYLE_CYCLE = 2;

float TELEDEST_KEEPANGLE = 1;
float TELEDEST_KEEPPITCH = 2;
float TELEDEST_STEALTH = 4;
float TELEDEST_KEEPVELOCITY = 8;
float TELEDEST_KEEPANGLE_NOOFFSET = 16;
float TELEDEST_DONTDROP = 32;

float TELEDEST_STYLE_NORMAL = 0;
float TELEDEST_STYLE_INSTANT = 1;

//=================================================================================================

// high precision vectoyaw
float(vector vec) vectoyaw2 =
{
    float b = 0.596227;

    // Extract the sign bits
    float ux_s  =  vec_x < 0 ? -1 : 1;
    float uy_s  =  vec_y < 0 ? -1 : 1;

    // Determine the quadrant offset
    float q;
    if (ux_s > 0 && uy_s > 0) q = 0;
    else if (ux_s < 0 && uy_s > 0) q = 1;
    else if (ux_s < 0 && uy_s < 0) q = 2;
    else q = 3;

    // Calculate the arctangent in the first quadrant
    float bxy_a = fabs( b * vec_x * vec_y );
    float num = bxy_a + vec_y * vec_y;
    float atan_1q =  num / ( vec_x * vec_x + bxy_a + num );

    // Translate it to the proper quadrant
    float uatan_2q = ux_s < 0 ? 1 - atan_1q : atan_1q;
    if (q >= 2) uatan_2q = 1 - uatan_2q;
    return (q + uatan_2q) * 90;
}

float(float x) sign = {
	if (x > 0) {
		return 1;
	}
	else if (x < 0) {
		return -1;
	}

	return 0;
};

// normalizes an angle vector to the -180/+179 range
vector(vector ang) normalizeAngles180 = {
	ang_x = ang_x - floor((ang_x+180)/360) * 360;
	ang_y = ang_y - floor((ang_y+180)/360) * 360;
	ang_z = ang_z - floor((ang_z+180)/360) * 360;

	return ang;
};

//=================================================================================================

void() play_teleport =
{
	local	float v;
	local	string tmpstr;

	v = random() * 5;
	if (v < 1)
		tmpstr = "misc/r_tele1.wav";
	else if (v < 2)
		tmpstr = "misc/r_tele2.wav";
	else if (v < 3)
		tmpstr = "misc/r_tele3.wav";
	else if (v < 4)
		tmpstr = "misc/r_tele4.wav";
	else
		tmpstr = "misc/r_tele5.wav";

	sound (self, CHAN_VOICE, tmpstr, 1, ATTN_NORM);
	remove (self);
}

void(vector org) spawn_tfog =
{
	entity telesound = spawn();
	telesound.origin = org;
	telesound.nextthink = time + 0.2;
	telesound.think = play_teleport;

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_TELEPORT);
	WriteCoord (MSG_BROADCAST, org_x);
	WriteCoord (MSG_BROADCAST, org_y);
	WriteCoord (MSG_BROADCAST, org_z);
}



void() restoreModel =
{
	setmodel(self.owner, self.oldmodel);
	setsize(self.owner, self.omins, self.omaxs);
	self.owner.skin = self.armortype;
	self.owner.frame = self.armorvalue;
	self.owner.aiment = world;
	remove(self);
}

void() instateleport_touch =
{
	entity	t;
	vector	tAngle, pAngle;
	float vAngleX;

	//if (other.flags & FL_NEVERTELEPORT)
	//	return;

	if (other.solid == SOLID_BSP)
		return;

	if (self.customflags & CFL_LOCKED) return;

	if (other.movetype == MOVETYPE_NOCLIP) return;

	if ((self.spawnflags & TELEPORT_NOTRIGGER) == 0)
		if (self.targetname != string_null)
			if ((self.spawnflags & TELEPORT_TRIGGER_FIRST) == 0) // not trigger first
				if (self.nextthink < time) {
					return;
				}

	if (self.spawnflags & TELEPORT_PLAYER_ONLY) {
		if (!(other.flags & FL_CLIENT))
			return;
	}
	
	if (self.spawnflags & TELEPORT_MONSTER_ONLY) {
		if (!(other.flags & FL_MONSTER))
			return;
	}

	if (self.spawnflags & TELE_PLAYERTRIGGERED && self.nextthink < time) {
		if (other.flags & FL_CLIENT)
			teleport_use();
			
		return;
	}

	// only teleport living creatures
	//if (other.health <= 0 || other.solid != SOLID_SLIDEBOX)
	//	return;

	
	t = findunlockedtarget(self, world);//teleport_getdestination();
	if (!t)
	{
		objerror ("teleporter couldn't find target");
		return;
	}


	if (t.style == TELEDEST_STYLE_NORMAL)
	{
		if (other.health <= 0 || other.solid != SOLID_SLIDEBOX)
			return;
	}

	SUB_UseTargets();

	// put a tfog where the player was
	if (!(self.spawnflags & TELE_STEALTH || t.spawnflags & TELEDEST_STEALTH))
		spawn_tfog (other.origin);

	// teleport destination's angle offset
	tAngle = t.mangle;
	//tAngle_y += self.mangle_y;
	//dprint2(vtos(tAngle), "\n");

	// entity is a client, so take the angles from v_angle instead
	if (other.flags & FL_CLIENT)
		pAngle = [-other.v_angle_x, other.v_angle_y, other.v_angle_z]; // v_angle has +pitch as down instead of up
	else
		pAngle = other.angles;

	//pAngle_y += self.mangle_y;

	// stores the original v_angle pitch for players
	vAngleX = other.v_angle_x;

	/*
	makevectors(self.mangle);
	vector s_forward = v_forward;
	vector s_right = v_right;
	vector s_up = v_up;
	*/

	makevectors([tAngle_x, tAngle_y, tAngle_z]);
	vector t_forward = v_forward;
	vector t_right = v_right;
	vector t_up = v_up;

	//vector f_forward = t_forward*s_forward_x - t_right*s_forward_y + t_up*s_forward_z;
	/*
	vector f_forward = s_forward*t_forward_x - s_right*t_forward_y + s_up*t_forward_z;
	vector f_right = s_forward*t_right_x - s_right*t_right_y + s_up*t_right_z;
	vector f_up = s_forward*t_up_x - s_right*t_up_y + s_up*t_up_z;
	*/
	vector f_forward = t_forward;
	vector f_right = t_right;
	vector f_up = t_up;

	makevectors([-pAngle_x, pAngle_y, pAngle_z]);
	vector p_forward = v_forward;
	vector p_right = v_right;
	vector p_up = v_up;

	/*dprint3("s_forward: ", vtos(s_forward*100), "\n");
	dprint3("t_forward: ", vtos(t_forward*100), "\n");
	dprint3("f_forward: ", vtos(f_forward*100), "\n");
	dprint3("p_forward: ", vtos(p_forward*100), "\n");
	*/


	// offsets the current angle by the destination's mangle,

	if (t.mangle != '0 0 0')
	{
		other.angles = vectoangles(f_forward*p_forward_x - t_right*p_forward_y + t_up*p_forward_z);
		other.angles_y = vectoyaw2(f_forward*p_forward_x - t_right*p_forward_y + t_up*p_forward_z);
	}
	else
		other.angles = pAngle;
	


	//other.angles_y -= self.mangle_y;

	other.velocity = f_forward*other.velocity_x - t_right*other.velocity_y + t_up*other.velocity_z;
	
	float isProjectile = other.type == "gib" || other.type == "spike"
		|| other.type == "grenade" || other.type == "missile" || other.type == "head";

	// only players, projectiles and gibs maintain their pitch and roll angles
	// everything else gets set to what it was before
	if (!isProjectile && !(other.flags & FL_CLIENT))
	{
		other.angles_x = pAngle_x;
		other.angles_z = pAngle_z;
	}

	if (other.flags & (FL_MONSTER + FL_CLIENT))
		spawn_tdeath(t.origin, other);

	// move the player and lock him down for a little while
	if (!other.health && other.flags & FL_CLIENT)
	{
		other.origin = t.origin;
		other.velocity = (p_forward * other.velocity_x) + (p_forward * other.velocity_y);
		return;
	}

	vector neworg;

	// instant teleports need a little more math

	vector teleMid = (self.absmin + self.absmax)/2;
	vector destMid = (t.absmin + t.absmax)/2;

	// rotates destination point around mangle
	if (tAngle)
	{
		vector offs = other.origin - teleMid;
		neworg = destMid + f_forward*offs_x - t_right*offs_y + t_up*offs_z;
	}
	else
		neworg = other.origin - teleMid + destMid;

	// if the entity is onground, move the origin upwards a bit and drop it to avoid getting stuck at the destination
	if (other.flags & FL_ONGROUND && !(t.spawnflags & TELEDEST_DONTDROP))
	{
		float frac = 1;
		traceline(neworg + [0, 0, other.maxs_z], neworg + [0, 0, other.maxs_z] + '0 0 32', 0, other);
		if (trace_fraction < frac) frac = trace_fraction;
		traceline(neworg + [other.mins_x, other.mins_y, other.maxs_z], neworg + [other.mins_x, other.mins_y, other.maxs_z] + '0 0 32', 0, other);
		if (trace_fraction < frac) frac = trace_fraction;
		traceline(neworg + [other.maxs_x, other.mins_y, other.maxs_z], neworg + [other.maxs_x, other.mins_y, other.maxs_z] + '0 0 32', 0, other);
		if (trace_fraction < frac) frac = trace_fraction;
		traceline(neworg + [other.mins_x, other.maxs_y, other.maxs_z], neworg + [other.mins_x, other.maxs_y, other.maxs_z] + '0 0 32', 0, other);
		if (trace_fraction < frac) frac = trace_fraction;
		traceline(neworg + [other.maxs_x, other.maxs_y, other.maxs_z], neworg + [other.maxs_x, other.maxs_y, other.maxs_z] + '0 0 32', 0, other);
		if (trace_fraction < frac) frac = trace_fraction;
		
		setorigin(other, neworg + [0, 0, frac * 32]);
		entity oself = self;
		self = other;
		droptofloor(0,0);
		self = oself;
	}
	else
		setorigin(other, neworg);

	// projectiles and gibs must have their models removed for a few frames
	// otherwise effect trails may lerp when the destination is close enough
	if (isProjectile)
	{
		// there was a controller attached already, so give it a little more time
		if (other.aiment.classname == "mdlcontroller") {
			other.aiment.nextthink = time + 0.05;
		}
		else {
			entity mdlctrl = spawn();
			other.aiment = mdlctrl;
			mdlctrl.classname = "mdlcontroller";
			mdlctrl.nextthink = time + 0.05;
			mdlctrl.think = restoreModel;
			mdlctrl.owner = other;
			mdlctrl.omins = other.mins;
			mdlctrl.omaxs = other.maxs;
			mdlctrl.oldmodel = other.model;
			mdlctrl.armortype = other.skin;
			mdlctrl.armorvalue = other.frame;
			other.frame = 0;
			other.skin = 0;

			setmodel(other, "progs/misc_empty.mdl");
			setsize(other, mdlctrl.omins, mdlctrl.omaxs);
		}
	}
	
	
	// spawn a tfog flash in front of the destination
	if (!(self.spawnflags & TELE_STEALTH || t.spawnflags & TELEDEST_STEALTH))
		spawn_tfog (other.origin + 32 * f_forward);

	
	if (other.classname == "player")
	{
		fog_setFromEnt(other, t);

		if (t.style == TELEDEST_STYLE_INSTANT)
			dprint3("Player teleported to instadestination ", t.targetname, "\n");
		else
			dprint3("Player teleported to destination ", t.targetname, "\n");

		if (t.spawnflags & TELEDEST_KEEPANGLE || t.style == TELEDEST_STYLE_INSTANT)
		{
			// When a changing player's angles field on a frame with fixangle set to 1,
			// the set angles get passed to the v_angle field on the next frame.
			// That means I need to invert the X component (pitch angle), because
			// +pitch in v_angle points up, and in angles points down
			other.angles_x *= -1;

			if (t.spawnflags & TELEDEST_KEEPPITCH)
			{
				other.angles_x = vAngleX;
			}
			else
			{
				// YEAH MATH
				// Calculates the roll for the player's view angle,
				// to compensate for the destination's horizontal plane 
				// potentially being at an angle.
				// At this point angles already follow the v_angle
				// convention, so no X inversion is necessary
				makevectors(other.angles);
				other.angles_z = atan2(v_right*t_up, v_up*t_up);
			}
		}

		if (t.spawnflags & TELEDEST_KEEPANGLE_NOOFFSET)
			other.angles = other.v_angle;

		// turn this way immediately
		other.fixangle = 1;
		

		// lock the player's controls for some time
		if (t.style != TELEDEST_STYLE_INSTANT) other.teleport_time = time + 0.7;

		if (other.flags & FL_ONGROUND)
			other.flags = other.flags - FL_ONGROUND;


		if (t.style != TELEDEST_STYLE_INSTANT && !(t.spawnflags & TELEDEST_KEEPANGLE))
		{
			if (!(t.spawnflags & TELEDEST_KEEPVELOCITY))
				other.velocity = f_forward * 300;
			else	
				other.velocity = f_forward * vlen(other.velocity);
		} 


	}
	//dprint3("After: ", vtos(other.angles),"\n");
	other.flags &~= FL_ONGROUND;
}

void() instateleport_use =
{
	self.nextthink = time + 0.2;
	force_retouch = 2;		// make sure even still objects get hit
	self.think = SUB_Null;
}

void() instateleport_reactivate =
{
	trigger_reactivate();
	// triggerfirst + nonsilent = delayed ambientsound, so shortcut teleporters don't sound like secrets
	if ( self.spawnflags & TELEPORT_TRIGGER_FIRST && !(self.spawnflags & TELEPORT_SILENT) )
		teleport_hum();
	
	self.use = instateleport_use;
}

/*QUAKED trigger_teleport (.5 .5 .5) ? PLAYER_ONLY SILENT
Any object touching this will be transported to the corresponding info_teleport_destination entity. You must set the "target" field, and create an object with a "targetname" field that matches.

If the trigger_teleport has a targetname, it will only teleport entities when it has been fired.
*/
void() trigger_instateleport =
{
	if (!SUB_ShouldSpawn()) return;
	
	precache_model ("progs/misc_empty.mdl");

	//local vector o;

	InitTrigger();
	self.touch = instateleport_touch;
	// find the destination 
	if (!self.target)
		objerror ("no target");

	self.use = instateleport_use;

	self.count = -1;
	if (!(self.spawnflags & TELEPORT_SILENT))
	{
		precache_sound_safe ("ambience/hum1.wav");
		if (!(self.spawnflags & TELEPORT_TRIGGER_FIRST))
			teleport_hum();
	}

	if (self.spawnflags & TELEPORT_TRIGGER_FIRST)
		self.use = instateleport_reactivate;
}


void() trigger_instateleport_destination =
{
	if (!SUB_ShouldSpawn()) return;
	
	if (!self.targetname)
		objerror ("no targetname");

	//self.flags |= FL_NEVERTELEPORT;
	
	self.solid = SOLID_TRIGGER;
	setmodel(self, self.model);	// set size and link into world
	self.movetype = MOVETYPE_NONE;
	self.modelindex = 0;
	self.model = "";

	self.style = TELEDEST_STYLE_INSTANT;

	//SetAngles();

	if (!self.mangle && self.angles) self.mangle = self.angles;

	// flips the stealth flag
	self.spawnflags ^= TELEDEST_STEALTH;
}
