/*======================================================================
Client Map Variables
--------------------

Allows for binary (0/1) map variables to be stored with the map save
system (parm1-16) by the engine. The top 6 parm variables are never used
and can easily be turned into variables for the map to use.

Adapted from AD

======================================================================*/


float MAPV_BITS = 23;			// Bits used in each parm block
float MAPV_BLCK = 3;			// Blocks used (total parm's)
float MAPV_TOTAL = 69;			// Maximum amount of variables

float MAPV_WRITE_OFF = 1;
float MAPV_WRITE_ON = 2;
float MAPV_WRITE_TOGGLE = 3;

float MAPV_READ_OFF = 1;
float MAPV_READ_ON = 2;


float bitflags[24];				// Bitflag values
float mapvars[3];				// Map variables stored in savefile
nosave float mapvar_started;

.float mapvar;
.float mapvar_not;
.float mapvar_message;

// Setup the bitflag array (used in world.qc)
void() mapvar_setuparray = {
	local float bitindex, bitpow;
	
	// Setup loop and first bit
	bitindex = 0; bitpow = 1;
	while (bitindex < 24) {
		bitflags[bitindex] = bitpow;
		bitpow = bitpow * 2;
		bitindex = bitindex + 1;
	}
};

//----------------------------------------------------------------------
// Reset all map variable banks to zero (used in client.qc)
void() mapvar_reset = {
	local float mapv_bank;
	
	mapv_bank = 0;
	while (mapv_bank < MAPV_BLCK) {
		mapvars[mapv_bank] = 0;
		mapv_bank = mapv_bank + 1;
	}
};

//----------------------------------------------------------------------
// Read map variable from block/bits parms and return value
float(float mapv_indx) read_mapvar = {
	local float mapv_bank, mapv_cell, mapv_bit;
	
	// Work out parm and bitflag index
	mapv_bank = floor(mapv_indx/MAPV_BITS);
	mapv_cell = mapv_indx - (mapv_bank*MAPV_BITS);
	// Error check return value
	if (mapv_bank < 0 || mapv_bank >= MAPV_BLCK) mapv_bank = 0;
	if (mapv_cell < 0 || mapv_cell >= MAPV_BITS) mapv_cell = 0;
	// Find bitflag mask value
	mapv_bit = mapvars[mapv_bank] & bitflags[mapv_cell];
	

	if (mapv_bit > 0) return TRUE;
	else return FALSE;
};

//----------------------------------------------------------------------
// Update map variable from block/bits parms
void(float mapv_indx, float mapv_val) write_mapvar =
{
	local float mapv_bank, mapv_cell, curr_bits;
	
	// Work out parm and bitflag index
	mapv_bank = floor(mapv_indx/MAPV_BITS);
	mapv_cell = mapv_indx - (mapv_bank*MAPV_BITS);
	// Error check return value
	if (mapv_bank < 0 || mapv_bank >= MAPV_BLCK) mapv_bank = 0;
	if (mapv_cell < 0 || mapv_cell >= MAPV_BITS) mapv_cell = 0;
	
	// get the current flag value
	curr_bits = mapvars[mapv_bank] & bitflags[mapv_cell];

	if (mapv_val == MAPV_WRITE_ON || (mapv_val == MAPV_WRITE_TOGGLE && !curr_bits)) {
		mapvars[mapv_bank] = mapvars[mapv_bank] | bitflags[mapv_cell];
		dprint3("Set mapvar #", ftos(mapv_indx), " to 1\n");
	}
	else {
		mapvars[mapv_bank] = mapvars[mapv_bank] - (mapvars[mapv_bank] & bitflags[mapv_cell]);
		dprint3("Set mapvar #", ftos(mapv_indx), " to 0\n");
	}
};

//----------------------------------------------------------------------
// Display the value of all map variable parm blocks
void() display_mapvar = {
	local float loopbank, loopcell, loopspace, loopval;
	
	// Default return conditions (must be player and developer)
	//if ( !(self.flags & FL_CLIENT) ) return;

	// Has the map variable system been setup?
	if (!mapvar_started) {
		sprint(self,"\b[MAPVAR]\b System has not been setup yet!\n");
		return;
	}

	// Reset impulse and initialize variables
	//self.impulse = 0;
	loopbank = loopcell = 0;

	dprint("\n\b[MAPVAR]\b Current System Values\n"); 
	dprint("--------------------------------------\n");
	while (loopbank < MAPV_BLCK) {
		dprint("Bank "); dprint(ftos(loopbank)); dprint(" - ");
		loopcell = 0; loopspace = 4;
		while (loopcell < MAPV_BITS) {
			loopval = read_mapvar((loopbank*MAPV_BITS)+loopcell);
			dprint(ftos(loopval));
			
			loopcell = loopcell+1;
			if (loopcell == loopspace) {
				dprint(" "); 
				loopspace = loopspace+4;
			}
		}
		dprint("\n");
		loopbank = loopbank+1;
	}
	dprint("--------------------------------------\n");
};



void() trigger_mapvar_write_use = {
	write_mapvar(self.mapvar, self.style);
};

void() trigger_mapvar_write = {
	if (!SUB_ShouldSpawn()) return;
	
	if (!self.mapvar)
		objerror("Mapvar id not selected");
	if (self.mapvar < 1 || self.mapvar > MAPV_TOTAL)
		objerror("Mapvar id out of range");

	if (!self.style) self.style = MAPV_WRITE_ON;
	
	self.use = trigger_mapvar_write_use;
};


void() trigger_mapvar_read_use = {
	float mapvar_val;
	mapvar_val = read_mapvar(self.mapvar);

	if ((self.style == MAPV_READ_ON && mapvar_val) || (self.style == MAPV_READ_OFF && !mapvar_val)) {
		dprint4("trigger_mapvar_read fired at (", vtos(self.origin), ") for mapvar #", ftos(self.mapvar));
		if (!mapvar_val) dprint(" = OFF\n");
		else dprint(" = ON\n");

		SUB_UseTargets();
	}
	
};

void() trigger_mapvar_read_start = {
	// not started up yet, waiting for 1st player
	if (!mapvar_started) {
		self.nextthink = time + 0.01;
		return;
	}

	entity pl;
	pl = find(world, classname, "player");
	if (!pl) return;

	activator = pl;
	trigger_mapvar_read_use();
};

void() trigger_mapvar_read = {
	if (!SUB_ShouldSpawn()) return;
	
	if (!self.mapvar){
		objerror("Mapvar id not selected");
		return;
	}
	if (self.mapvar < 1 || self.mapvar > MAPV_TOTAL){
		objerror("Mapvar id out of range");
		return;
	}

	if (!self.style) self.style = MAPV_READ_ON;
	
	self.use = trigger_mapvar_read_use;

	// if it doesn't have a targetname, runs automatically at startup
	if (!self.targetname) {
		self.think = trigger_mapvar_read_start;
		self.nextthink = time + 0.3;
	}
};

//=============================================================================

float() mapvar_check = {
	if (self.mapvar)
	{
		if (!read_mapvar(self.mapvar)){
			//dprint3("Mapvar #", ftos(self.mapvar), " set to false, aborting\n");
			return FALSE;
		}
	}

	if (self.mapvar_not)
	{
		if (read_mapvar(self.mapvar_not)){
			//dprint3("Mapvar #", ftos(self.mapvar_not), " set to true, aborting\n");
			return FALSE;
		}
	}
	return TRUE;
}