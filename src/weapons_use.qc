
// called by worldspawn
void() W_Precache =
{
	precache_sound ("weapons/r_exp3.wav");
	precache_sound ("weapons/rocket1i.wav");	// nailgun
	precache_sound ("weapons/sgun1.wav");
	precache_sound ("weapons/guncock.wav");		// sg
	precache_sound ("weapons/ric1.wav");		// ricochet (used in c code)
	precache_sound ("weapons/ric2.wav");		// ricochet (used in c code)
	precache_sound ("weapons/ric3.wav");		// ricochet (used in c code)
	precache_sound ("weapons/spike2.wav");		// super spikes
	precache_sound ("weapons/tink1.wav");		// spikes tink (used in c code)
	precache_sound ("weapons/grenade.wav");		// grenade launcher
	precache_sound ("weapons/bounce.wav");		// grenade bounce
	precache_sound ("weapons/shotgn2.wav");		// ssg
	precache_model2 ("progs/k_spike.mdl");
	precache_model ("progs/lavaball.mdl");	
	precache_sound ("weapons/lhit.wav");		//lightning
	precache_sound ("weapons/lstart.wav");		//lightning start
	//	precache_sound ("items/damage3.wav");

// ax sounds	
	precache_sound ("weapons/ax1.wav");		// ax swoosh
	precache_sound2 ("weapons/axhit1.wav");		// ax hit meat
	precache_sound2 ("weapons/axhit2.wav");		// ax hit meat 2
	precache_sound ("player/axhit1.wav");		// ax hit me
	precache_sound ("player/axhit2.wav");		// ax hit world
	
	precache_sound ("zombie/z_hit.wav");
	
	//=============================================================================================
	
	precache_model ("progs/v_wrench.mdl");						// 1 Melee
	precache_model ("progs/v_berserk.mdl");
	precache_sound ("impact/fist_hit.wav");
	precache_sound ("impact/fist_impact1.wav");
	precache_sound ("impact/fist_impact2.wav");
	precache_sound ("impact/fist_impact3.wav");
	precache_sound ("impact/fist_impact4.wav");
	precache_sound ("impact/wrench_impact1.wav");
	precache_sound ("impact/wrench_impact2.wav");
	precache_sound ("impact/wrench_impact3.wav");
	precache_sound ("impact/wrench_impact4.wav");
	precache_sound ("impact/wrench_swing.wav");
	precache_sound ("impact/wrench_clink.wav");
	//precache_sound ("impact/wrench_clank1.wav");
	//precache_sound ("impact/wrench_clank2.wav");
	precache_sound ("impact/hit_player1.wav");
	precache_sound ("impact/hit_player2.wav");
	precache_sound ("impact/hit_player3.wav");
	precache_sound ("impact/hit_player4.wav");
		
	//=============================================================================================
											// 2 Pistol
	precache_model ("progs/bullet_casing.mdl");
	precache_model ("progs/pistol_mag.mdl");
	precache_model ("progs/tracer_long_yellow.mdl");
	precache_sound ("pistol/deadlock_reload.wav");
	precache_sound ("pistol/pistol_shoot.wav");
	precache_sound ("pistol/ammo_rattle.wav");
	precache_sound ("pistol/gun_click.wav");
	precache_sound ("pistol/mag_drop.wav");
	precache_sound ("pistol/pistol_fire.wav");
	precache_sound ("pistol/pistol_fire1.wav");
	precache_sound ("pistol/pistol_fire2.wav");
	precache_sound ("pistol/pistol_fire3.wav");
	precache_sound ("pistol/pistol_fire4.wav");
	precache_sound ("pistol/casing.wav");
	
	//=============================================================================================
											// 3 Shotgun
	precache_model ("progs/buckshot_casing.mdl");
	precache_model ("progs/proj_pellet.mdl");
	precache_sound ("flak/volley_fire1.wav");
	precache_sound ("flak/volley_fire2.wav");
	precache_sound ("flak/volley_fire3.wav");
	precache_sound ("flak/shotgun2.wav");
	precache_sound ("flak/shotgun3.wav");
	precache_sound ("flak/pump_reload.wav");
	precache_sound ("flak/pump_reload.wav");
	precache_sound ("flak/shell_casing1.wav");
	precache_sound ("flak/shell_casing2.wav");
	precache_sound ("flak/shell_casing3.wav");
	precache_sound ("flak/shotgun_fire1.wav");
	precache_sound ("flak/shotgun_fire2.wav");
	precache_sound ("flak/shotgun_fire3.wav");
	precache_sound ("flak/shotgun_fire4.wav");

	//=============================================================================================
											// 4 Nailguns
	precache_model ("progs/proj_nail.mdl");
	precache_sound ("nail/nailgun1.wav");
	precache_sound ("nail/nailgun2.wav");
	precache_sound ("nail/nailgun3.wav");
	precache_sound ("nail/nailgun4.wav");
	precache_sound ("nail/nailgun5.wav");
	precache_sound ("nail/airpuff.wav");
	precache_sound ("nail/nail_tink1.wav");
	precache_sound ("nail/nail_tink2.wav");
	precache_sound ("nail/nail_tink3.wav");
	
	//=============================================================================================
											// 5 RebarBow
	precache_model ("progs/proj_rebar.mdl");
	precache_model ("progs/proj_rebar_nosmoke.mdl");
	precache_sound ("rebar/penfire.wav");
	precache_sound ("rebar/pierce1.wav");
	precache_sound ("rebar/pierce2.wav");
	precache_sound ("rebar/pierce3.wav");
	precache_sound ("rebar/pierce_impact.wav");
	precache_sound ("rebar/stick1.wav");
	precache_sound ("rebar/stick_metal1.wav");
	precache_sound ("rebar/stick_metal2.wav");
	precache_sound ("rebar/bow_reload1.wav");
	precache_sound ("rebar/bow_reload2.wav");
	precache_sound ("rebar/bow_reload3.wav");
	precache_sound ("rebar/bow_reload4.wav");
	precache_sound ("rebar/bow_clank.wav");
	
	//=============================================================================================
											// 6 GrenadeL
	precache_sound ("grenade/grenade_reload.wav");
	precache_sound ("grenade/grenade_fire1.wav");
	precache_sound ("grenade/grenade_fire2.wav");
	precache_sound ("grenade/grenade_fire3.wav");
	
	//=============================================================================================
											// 7 MissileL	
	precache_model ("progs/proj_missile.mdl");	
	precache_sound ("mmml/fire1.wav");
	precache_sound ("mmml/fire2.wav");
	precache_sound ("mmml/fire3.wav");
	precache_sound ("mmml/fire4.wav");
	precache_sound ("mmml/silo_latch.wav");
	precache_sound ("mmml/silo_load.wav");
	precache_sound ("mmml/silo_load2.wav");
	precache_sound ("mmml/silo_clunk.wav");
	precache_sound ("mmml/silo_clunk2.wav");

	//=============================================================================================
											// 8 Invoker	
	precache_model ("progs/v_invoker.mdl");
	precache_model ("progs/proj_chain.mdl");
	precache_sound ("invoker/invoker_firerail.wav");	
	precache_sound ("invoker/magic07.wav");	
	precache_sound ("invoker/magic08.wav");	
	precache_sound ("invoker/magic21.wav");	
	precache_sound ("invoker/magic26.wav");
	precache_sound ("invoker/energy_charge.wav");
	precache_sound ("invoker/energy_hit1.wav");
	precache_sound ("invoker/energy_hit2.wav");
	precache_sound ("invoker/energy_hit3.wav");
	precache_sound ("invoker/energy_hit4.wav");
	
	//=============================================================================================
											// FX Effects	
	precache_sound ("impact/bullet_impact1.wav");
	precache_sound ("impact/bullet_impact2.wav");
	precache_sound ("impact/bullet_impact3.wav");
	precache_sound ("impact/bullet_impact4.wav");
	precache_sound ("impact/bullet_metal1.wav");
	precache_sound ("impact/bullet_metal2.wav");
	precache_sound ("impact/bullet_metal3.wav");
	precache_sound ("impact/bullet_metal4.wav");
	precache_sound ("impact/ric1.wav");
	precache_sound ("impact/ric2.wav");
	precache_sound ("impact/ric3.wav");
	precache_sound ("impact/ric4.wav");
	precache_sound ("impact/ric5.wav");
	
	precache_model ("progs/fx/spark1.mdl");
	precache_model ("progs/fx/spark2.mdl");
	precache_model ("progs/fx/spark3.mdl");
	precache_model ("progs/fx/spark4.mdl");
	precache_model ("progs/fx/spark_laser1.mdl");
	precache_model ("progs/fx/spark_laser2.mdl");
	precache_model ("progs/fx/spark_laser3.mdl");
	precache_model ("progs/fx/spark_laser4.mdl");
	precache_model ("progs/fx/blood1.mdl");
	precache_model ("progs/fx/blood2.mdl");
	precache_model ("progs/fx/blood3.mdl");
	precache_model ("progs/fx/blood4.mdl");
	precache_model ("progs/fx/blood_big1.mdl");
	precache_model ("progs/fx/blood_big2.mdl");
	precache_model ("progs/fx/blood_big3.mdl");
	precache_model ("progs/fx/blood_big4.mdl");
	
	precache_model ("progs/fx/invoked_chain.mdl");
	
	precache_model ("progs/s_blood_128x.spr");
	precache_model ("progs/s_blood_96x.spr");
	precache_model ("progs/s_blood_64x.spr");
								
	//=============================================================================================
											// Misc
	precache_sound ("misc/draw1.wav");
	
	//=============================================================================================	
											//PLACEHOLDER		
	precache_sound ("placeholder_sound/shotgun1.wav");
	precache_sound ("placeholder_sound/shotgun2.wav");
	precache_sound ("placeholder_sound/shell_reload.wav");
	precache_sound ("placeholder_sound/shell_reload.wav");
	precache_sound ("placeholder_sound/shotgn3.wav");
	precache_sound ("placeholder_sound/sniper.wav");
	precache_sound ("placeholder_sound/buzz_shoot.wav");
	precache_sound ("placeholder_sound/buzz_saw.wav");
	precache_sound ("placeholder_sound/cod_hitmarker.wav");
	precache_sound ("placeholder_sound/cs_headshot.wav");
	precache_sound ("placeholder_sound/tommy_fire.wav");
	precache_sound ("placeholder_sound/tommy_fire2.wav");
	precache_sound ("placeholder_sound/tommy_fire2.wav");
	precache_sound ("placeholder_sound/puckler_snap.wav");
	precache_sound ("placeholder_sound/beep1.wav");
	precache_sound ("placeholder_sound/beep2.wav");
	
	precache_sound ("placeholder_sound/knife_slash1.wav");
	precache_sound ("placeholder_sound/knife_slash2.wav");
	precache_sound ("placeholder_sound/knife_hit1.wav");
	precache_sound ("placeholder_sound/knife_hit2.wav");
	precache_sound ("placeholder_sound/knife_hit3.wav");
	precache_sound ("placeholder_sound/knife_hit4.wav");
	precache_sound ("placeholder_sound/knife_hitwall1.wav");
	
	precache_sound ("placeholder_sound/ash_casing.wav");
	precache_sound ("placeholder_sound/ash_casing2.wav");
	precache_sound ("placeholder_sound/ash_casing3.wav");
	precache_sound ("placeholder_sound/ash_click.wav");
	precache_sound ("placeholder_sound/ash_click2.wav");
	precache_sound ("placeholder_sound/ash_click3.wav");
	precache_sound ("placeholder_sound/ash_fire.wav");
	precache_sound ("placeholder_sound/ash_fire2.wav");
	precache_sound ("placeholder_sound/ash_fire3.wav");
	precache_sound ("placeholder_sound/ash_fire4.wav");
	precache_sound ("placeholder_sound/ash_fire5.wav");
	precache_sound ("placeholder_sound/ash_fire6.wav");
	precache_sound ("placeholder_sound/ash_reload.wav");
	
	precache_sound ("placeholder_sound/beep_tone_1.wav");
	precache_sound ("placeholder_sound/beep_tone_2.wav");
	precache_sound ("placeholder_sound/beep_tone_3.wav");
	precache_sound ("placeholder_sound/beep_tone_4.wav");
	precache_sound ("placeholder_sound/beep_tone_5.wav");
	
	precache_model ("progs/placeholder_progs/dev_point.mdl");
	precache_model ("progs/placeholder_progs/dev_point_anim.mdl");
	precache_model ("progs/placeholder_progs/dev_bbox32.mdl");
	precache_model ("progs/placeholder_progs/proj_pellet_blue.mdl");
	precache_model ("progs/placeholder_progs/proj_stake.mdl");
	precache_model ("progs/placeholder_progs/proj_stake_smoke.mdl");
	precache_model ("progs/placeholder_progs/proj_nail_heavy.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_small.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_small_hot.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_large.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_large_hot.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_hot_1.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_hot_2.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_hot_3.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_hot_4.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_hot_5.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_1.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_2.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_3.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_4.mdl");
	precache_model ("progs/placeholder_progs/proj_buzz_5.mdl");
	precache_model ("progs/placeholder_progs/railtrail_smoke.mdl");
	precache_model ("progs/placeholder_progs/railtrail_tracer.mdl");
	precache_model ("progs/placeholder_progs/proj_grenade_mini.mdl");
	precache_model ("progs/placeholder_progs/proj_grenade_mini_nosmoke.mdl");
	precache_model ("progs/placeholder_progs/proj_grenade_nosmoke.mdl");
	precache_model ("progs/placeholder_progs/proj_missile_nosmoke.mdl");
	precache_model ("progs/placeholder_progs/proj_missile_heavy.mdl");
	precache_model ("progs/placeholder_progs/proj_knife.mdl");
	precache_model ("progs/placeholder_progs/proj_mine.mdl");
	precache_model ("progs/placeholder_progs/proj_mine_nosmoke.mdl");
	precache_model ("progs/placeholder_progs/proj_mine_armed.mdl");
	precache_model ("progs/placeholder_progs/cube.mdl");
	
	precache_model ("progs/placeholder_progs/v_melee_knife.mdl");
	precache_model ("progs/placeholder_progs/v_melee_knife2.mdl");
	precache_model ("progs/placeholder_progs/v_melee_knife3.mdl");
	precache_model ("progs/placeholder_progs/v_melee_throw.mdl");
	
	precache_model ("progs/placeholder_progs/v_pistol_akimbo.mdl");
	precache_model ("progs/placeholder_progs/v_pistol_revolver.mdl");
	precache_model ("progs/placeholder_progs/v_pistol_bigiron.mdl");
	
	precache_model ("progs/placeholder_progs/v_shotgun_lever.mdl");
	precache_model ("progs/placeholder_progs/v_shotgun_stack.mdl");
	precache_model ("progs/placeholder_progs/v_shotgun_brazil.mdl");
	precache_model ("progs/placeholder_progs/v_shotgun_prism.mdl");	
	precache_model ("progs/placeholder_progs/v_shotgun_cowboy.mdl");	
	precache_model ("progs/placeholder_progs/v_shotgun_sawed.mdl");		
	precache_model ("progs/placeholder_progs/v_shotgun_overunder.mdl");		
		
	precache_model ("progs/placeholder_progs/v_ssg_super2.mdl");
	precache_model ("progs/placeholder_progs/v_ssg_super3.mdl");
	precache_model ("progs/placeholder_progs/v_ssg_super4.mdl");
	precache_model ("progs/placeholder_progs/v_ssg_rotary.mdl");	
	precache_model ("progs/placeholder_progs/v_ssg_auto.mdl");	
	precache_model ("progs/placeholder_progs/v_ssg_sweeper.mdl");	
	precache_model ("progs/placeholder_progs/v_ssg_blue2.mdl");	
	precache_model ("progs/placeholder_progs/v_ssg_bigblue.mdl");	
	precache_model ("progs/placeholder_progs/v_ssg_sawed2.mdl");	
	precache_model ("progs/placeholder_progs/v_ssg_sawed4.mdl");	
	precache_model ("progs/placeholder_progs/v_ssg_3tri.mdl");	
	precache_model ("progs/placeholder_progs/v_ssg_3flat.mdl");	
	
	precache_model ("progs/placeholder_progs/v_nail_heavy.mdl");		
	precache_model ("progs/placeholder_progs/v_nail_turbo.mdl");		
	precache_model ("progs/placeholder_progs/v_nail_lmg.mdl");
	precache_model ("progs/placeholder_progs/v_nail_drum.mdl");
	
	precache_model ("progs/placeholder_progs/v_rebar_multi.mdl");	
	precache_model ("progs/placeholder_progs/v_rebar_wide.mdl");	
	precache_model ("progs/placeholder_progs/v_rebar_tall.mdl");	
	precache_model ("progs/placeholder_progs/v_rebar_fast.mdl");		
	precache_model ("progs/placeholder_progs/v_rebar_buff.mdl");
	precache_model ("progs/placeholder_progs/v_rebar_rifle.mdl");
	precache_model ("progs/placeholder_progs/v_rebar_buzzsaw.mdl");
	precache_model ("progs/placeholder_progs/v_rebar_buzzsaw_charge.mdl");
	precache_model ("progs/placeholder_progs/v_rebar_buzzsaw_charge_1.mdl");
	precache_model ("progs/placeholder_progs/v_rebar_buzzsaw_charge_2.mdl");
	precache_model ("progs/placeholder_progs/v_rebar_buzzsaw_charge_3.mdl");
	precache_model ("progs/placeholder_progs/v_rebar_buzzsaw_charge_4.mdl");
	precache_model ("progs/placeholder_progs/v_rebar_buzzsaw_charge_5.mdl");
	
	precache_model ("progs/placeholder_progs/v_grenade_direct.mdl");
	precache_model ("progs/placeholder_progs/v_grenade_crossbow.mdl");
	precache_model ("progs/placeholder_progs/v_grenade_thumper.mdl");
	precache_model ("progs/placeholder_progs/v_grenade_tribolt.mdl");
	precache_model ("progs/placeholder_progs/v_grenade_triboltqc.mdl");
	precache_model ("progs/placeholder_progs/v_grenade_triple.mdl");
	precache_model ("progs/placeholder_progs/v_grenade_auto.mdl");
	precache_model ("progs/placeholder_progs/v_grenade_auto2.mdl");
	
	precache_model ("progs/placeholder_progs/v_rocket_original.mdl");		
	precache_model ("progs/placeholder_progs/v_rocket_rpg.mdl");		
	precache_model ("progs/placeholder_progs/v_rocket_instant.mdl");		
	precache_model ("progs/placeholder_progs/v_rocket_heavy.mdl");		
	precache_model ("progs/placeholder_progs/v_rocket_halflife.mdl");
	precache_model ("progs/placeholder_progs/v_rocket_double.mdl");
	precache_model ("progs/placeholder_progs/v_rocket_flash.mdl");
	precache_model ("progs/placeholder_progs/v_rocket_remote.mdl");
	precache_model ("progs/placeholder_progs/v_rocket_remote2.mdl");
	precache_model ("progs/placeholder_progs/v_rocket_triple.mdl");
			
	precache_model ("progs/placeholder_progs/v_power_rifle.mdl");	
	
	precache_model ("progs/placeholder_progs/wish/g_ash.mdl");
	precache_model ("progs/placeholder_progs/wish/v_ash.mdl");
	precache_model ("progs/placeholder_progs/wish/casing_big.mdl");
	precache_model ("progs/placeholder_progs/wish/mag_ash.mdl");
	precache_model ("progs/placeholder_progs/wish/mag_ash_empty.mdl");
	precache_model ("progs/placeholder_progs/wish/mag_ash_empty.mdl");	
	precache_model ("progs/placeholder_progs/wish/s_bullet_hole.spr");	
	
	precache_model ("progs/placeholder_progs/splithalf_soldier_p_legs.mdl");
	precache_model ("progs/placeholder_progs/splithalf_soldier_p_torso_floor.mdl");
	precache_model ("progs/placeholder_progs/splithalf_soldier_p_torso_floor2.mdl");
	precache_model ("progs/placeholder_progs/splithalf_soldier_p_gun_floor.mdl");
	precache_model ("progs/placeholder_progs/splithalf_soldier_p_gun.mdl");
	precache_model ("progs/placeholder_progs/splithalf_soldier_p_torso.mdl");
	
	//=============================================================================================	



	for (float i = 0; i <= MAX_WEAPON_NUM; i++) {
		if (weaponsclass[i].model != "") precache_model(weaponsclass[i].model);
	}

}

.float ammofieldlist[6] = {
	currentammo,
	ammo_shells,
	ammo_nails, 
	ammo_rockets,
	ammo_cells,
	pistol_ammo_count
};

typedef struct {
	float id;
	float slot;
	string name;
	string model;
	float ammofield;
	float ammo_item;
	float ammo_usage;
	float() animfunction;
	void() idlefunction;
	void() drawfunction;
} weaponclass_t;

typedef struct {
	weaponclass_t weaps[10];
	float qt;
} weaponslot_t;

float() weaponanim_null = {return FALSE;}



//=====================================================================================================================

// generic weapon draw functions used by most weapons

void() weaponanim_draw =
{		
	sound (self, CHAN_AUTO, "misc/draw1.wav", 0.1, ATTN_NORM);
	
	self.weaponframe = 1;
	
	self.think = weaponanim_draw_loop;
	self.nextthink = time + 0.033;
}

void() weaponanim_draw_loop =
{
	if (self.weaponframe >= 10)
		return;
	else 
		self.weaponframe++;

	self.think = weaponanim_draw_loop;
	self.nextthink = time + 0.033;
}

float(float weap) getWeapon = {
	//replaced the old hardcoded system with something dynamic.
	float i, j;
	for (i = 0; i < 9; i++) {
		if (weaponslots[i].weaps[0].id == weap) {
			weaponclass_t target = weaponslots[i].weaps[0];
			for (j = 0; j < MAX_WEAPON_NUM; j++) {
				if (weaponsclass[j].id == target.id && weaponsclass[j].name == target.name)
					return j;
			}
		}
	}
	return 0;
}


enum {
	WEAPONSTAT_NOWEAPON,
	WEAPONSTAT_NOAMMO,
	WEAPONSTAT_CHANGELOCKED,
	WEAPONSTAT_AVAILABLE
};


/*
 * wrap
 *
 * Limits the given value to the given range and will wrap the value to the
 * the other end of the range if exceeded.
 *
 * value: A number
 *
 * minValue: The minimum value of the range
 *
 * maxValue: The maximum value of the range
 *
 * Returns: A number within the given range.
 */
float(float value, float minValue, float maxValue) wrap = {
	local float range = maxValue - minValue;

	return mod(value - minValue, range + 1) + minValue;
};

/*
============
W_WeaponFrame

Called every frame so impulse events can be handled as well as possible
============
*/
void() W_WeaponFrame =
{
	if (self.button0) {
		if (self.attackpressed) self.attackhold = 1;
		else self.attackhold = 0;

		self.attackpressed = 1;

		W_Attack();
	}
	else {
		self.attackpressed = 0;
		self.attackhold = 0;
	}
}


// syncs up current ammo with its correspondent ammo_* field
void() W_UpdateCurrentAmmo =
{
	float weapIndex;
	if (self.active_weapon_index > 0 && self.active_weapon_index <= MAX_WEAPON_NUM)
		weapIndex = self.active_weapon_index;
	else
		weapIndex = getWeapon(self.weapon);
		
	weaponclass_t weap = weaponsclass[weapIndex];
	self.currentammo = self.(ammofieldlist[weap.ammofield]);
}

float(float weapons, entity cl, float waterlevel) W_BestWeaponParms =
{
	// iterate slots from highest to lowest priority
	// for each slot, check the variant the player currently has equipped
	float i, altBit, pos;
	for (i = 8; i >= 1; i--)
	{
		if (weaponslots[i].qt < 1) continue;
		altBit = SlotBit(i);
		pos = (cl.weapon_alternate & altBit) ? 1 : 0;
		weaponclass_t weap = weaponslots[i].weaps[pos];
		if (W_CheckWeapon(weap.id, cl) == WEAPONSTAT_AVAILABLE)
			return weap.id;
	}
	return IT_NO_WEAPON;
};

float(float w) W_RankForWeapon =
{
	float i, altBit, pos;
	if (!w) return 666;
	for (i = 1; i <= 8; i++)
	{
		if (weaponslots[i].qt < 1) continue;
		altBit = SlotBit(i);
		pos = (self.weapon_alternate & altBit) ? 1 : 0;
		if (weaponslots[i].weaps[pos].id == w)
			return (9 - i);
	}
	return 7;
}

float() W_BestWeapon =
{
	return W_BestWeaponParms(self.items, self, self.waterlevel);
};

float(float weap, entity cl) W_CheckWeapon =
{
	float weapIndex;
	
	if (weap == cl.weapon && cl.active_weapon_index > 0 && cl.active_weapon_index <= MAX_WEAPON_NUM)
		weapIndex = cl.active_weapon_index;
	else
		weapIndex = getWeapon(weap);
	
	weaponclass_t weapcl = weaponsclass[weapIndex];

	//if (has_gorgon(cl) && weap == IT_AXE) return WEAPONSTAT_AVAILABLE;
	if (has_berserk(cl) && weap == IT_AXE) return WEAPONSTAT_AVAILABLE;
	
	if (weap == IT_NO_WEAPON) return WEAPONSTAT_AVAILABLE;

	if (!(cl.items & weap)) return WEAPONSTAT_NOWEAPON;

	if (cl.(ammofieldlist[weapcl.ammofield]) < weapcl.ammo_usage) {
		return WEAPONSTAT_NOAMMO;
	}
	//dprint3("Ammo: ", ftos(cl.(weapcl.ammofield)), "\n");
	return WEAPONSTAT_AVAILABLE;
};

void() W_ResetWeaponState = 
{
	W_ChangeWeapon(self.weapon, FALSE);
}

void() W_Attack =
{
	float weapIndex;
	if (self.active_weapon_index > 0 && self.active_weapon_index <= MAX_WEAPON_NUM)
		weapIndex = self.active_weapon_index;
	else
		weapIndex = getWeapon(self.weapon);
	
	weaponclass_t weap = weaponsclass[weapIndex];

	if (W_CheckWeapon(self.weapon, self) != WEAPONSTAT_AVAILABLE) {
		return;
	}

	makevectors(self.v_angle);			// calculate forward angle for velocity
	
	float fired = weap.animfunction();

	if (fired) self.show_hostile = time + 1;	// wake monsters up
};



float(float weap, float forcereset = FALSE) W_ChangeWeapon =
{
	if (self.animcontroller.owner != self) return WEAPONSTAT_CHANGELOCKED;

	if (self.customflags & CFL_WEAPONLOCK) return WEAPONSTAT_CHANGELOCKED;

	// Force reset if player is being unplunged from a void
	if (self.customflags & CFL_PLUNGE) {
		forcereset = TRUE;
	}

	float weapstat = W_CheckWeapon(weap, self);
	if (weapstat < WEAPONSTAT_AVAILABLE){
		return weapstat;
	}

	// don't reset anything if trying to change to the same weapon
	if (self.weapon == weap && !forcereset){
		return weapstat;
	}

	float weapIndex = getWeapon(weap);

	if (self.active_weapon_index != weapIndex && self.active_weapon_index > 0) {
		forcereset = TRUE;
	}

	if (time > self.pistol_lastreload_time + 3.75 && self.pistol_ammo_count <= 0)	
	//if (time > self.pistol_lastreload_time + 3.75)	
		self.pistol_ammo_count = 10;	// reset pistol reload

	self.weaponreload_perc = 0;
	weaponclass_t weapcl = weaponsclass[weapIndex];

	self.prev_weapon = self.weapon;
	self.weapon = weap;
	self.active_weapon_index = weapIndex;
	self.currentammo = self.(ammofieldlist[weapcl.ammofield]);
	self.items &~= (IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS);
	self.items |= weapcl.ammo_item;

	if (weapcl.ammofield)
		self.currentammo = self.(ammofieldlist[weapcl.ammofield]);
		
	else 	self.currentammo = 0;
	
	if (has_berserk(self) && weap == IT_AXE)
		weapcl.model = "progs/v_berserk.mdl";
	
	self.weaponmodel = weapcl.model;
	
	self.weaponframe = 0;

	self.attackpressed = 0;
	self.attackhold = 0;

	self.animcontroller.think = player_run;
	self.think = SUB_Null;

	
	// @ bmFbr it working!!!  -Kebby_
			
	
	weapcl.idlefunction();
	// whatever drawfunction does will probably override an idlefunction's actions if there's one.
	// in this case the end of the draw loop must call idlefunction
	weapcl.drawfunction(); 
	
			
	return weapstat;
}


/*
=============
W_BetterWeapon

Deathmatch weapon change rules for picking up a weapon
=============
*/
void(entity e, float new) W_BetterWeapon =
{
	entity oself = self;
	if (!deathmatch)
	{
		// don't switch to explosive weapons with quad
		// 1.12: don't switch to explosives when invisible either, since you can't see the stupid viewmodel
		if ( (has_quad(e) || has_invis(e)) &&
			(new == IT_ROCKET_LAUNCHER || new == IT_GRENADE_LAUNCHER))
			return;
		// don't switch to a lightning gun when standing in water
		//if (e.waterlevel >= 2 && new == IT_LIGHTNING)
			//return;
	}	
	self = e;
	if (!deathmatch || W_RankForWeapon (new) < W_RankForWeapon (self.weapon) )
		W_ChangeWeapon(new, FALSE);
	self = oself;
}

/*
===================================================================================================

WEAPON SELECTION IMPULSES

===================================================================================================
*/


float() W_SelectBestWeapon =
{
	return W_ChangeWeapon(W_BestWeaponParms(self.items, self, self.waterlevel), FALSE);
}

float() W_SelectLastWeapon =
{
	if (self.prev_weapon)
		return W_ChangeWeapon(self.prev_weapon, FALSE);
	else
		return WEAPONSTAT_AVAILABLE; // do nothing
}

float() W_SelectBestShotgun =
{
	if (self.items & (IT_SHOTGUN|IT_SUPER_SHOTGUN))
	{
		if (W_ChangeWeapon(IT_SHOTGUN, FALSE) != WEAPONSTAT_NOAMMO && W_ChangeWeapon(IT_SUPER_SHOTGUN, FALSE) != WEAPONSTAT_NOAMMO)
		{
			sprint (self, "not enough ammo.\n");
			return WEAPONSTAT_NOAMMO;
		}
		else
			return WEAPONSTAT_AVAILABLE;
	}
	else
	{
		sprint(self, "no weapon.\n");
		return WEAPONSTAT_NOWEAPON;
	}
}

float() W_SelectBestNailgun =
{
	if (self.items & (IT_NAILGUN|IT_SUPER_NAILGUN))
	{
		if (W_ChangeWeapon(IT_NAILGUN, FALSE) != WEAPONSTAT_NOAMMO && W_ChangeWeapon(IT_SUPER_NAILGUN, FALSE) != WEAPONSTAT_NOAMMO)
		{
			sprint (self, "not enough ammo.\n");
			return WEAPONSTAT_NOAMMO;
		}
		else
			return WEAPONSTAT_AVAILABLE;
	
	}
	else
	{
		sprint(self, "no weapon.\n");
		return WEAPONSTAT_NOWEAPON;
	}
}

float(float weapId, string weapName) FindWeaponIndex =
{
	float i;
	for (i = 0; i <= MAX_WEAPON_NUM; i++) {
		if (weaponsclass[i].id == weapId && weaponsclass[i].name == weapName) {
			return i;
		}
	}
	return 0;
}

float(float weapIndex) W_ChangeWeaponByIndex =
{
	weaponclass_t weapcl = weaponsclass[weapIndex];
	float weap = weapcl.id;
	
	if (self.animcontroller.owner != self) return WEAPONSTAT_CHANGELOCKED;
	if (self.customflags & CFL_WEAPONLOCK) return WEAPONSTAT_CHANGELOCKED;

	float weapstat = W_CheckWeapon(weap, self);
	if (weapstat < WEAPONSTAT_AVAILABLE){
		return weapstat;
	}

	float forcereset = (self.active_weapon_index != weapIndex);

	if (self.weapon == weap && !forcereset){
		return weapstat;
	}

	if (time > self.pistol_lastreload_time + 3.75 && self.pistol_ammo_count <= 0)	
	//if (time > self.pistol_lastreload_time + 3.75)	
		self.pistol_ammo_count = 10;

	self.weaponreload_perc = 0;

	self.prev_weapon = self.weapon;
	self.weapon = weap;
	self.active_weapon_index = weapIndex;
	
	self.currentammo = self.(ammofieldlist[weapcl.ammofield]);
	self.items &~= (IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS);
	self.items |= weapcl.ammo_item;

	if (weapcl.ammofield)
		self.currentammo = self.(ammofieldlist[weapcl.ammofield]);
	else 	
		self.currentammo = 0;
	
	if (has_berserk(self) && weap == IT_AXE)
		weapcl.model = "progs/v_berserk.mdl";
	
	self.weaponmodel = weapcl.model;
	self.weaponframe = 0;
	self.attackpressed = 0;
	self.attackhold = 0;
	self.animcontroller.think = player_run;
	self.think = SUB_Null;

	weapcl.idlefunction();
	weapcl.drawfunction(); 
	
	return weapstat;
}

// converts slot number to the bit
float(float n) SlotBit =
{
	float v = 1;
	float i;
	for (i = 0; i < n; i++)
		v = v * 2;
	return v;
};

float(float imp) W_ChangeSlot =
{
	// Pistol Manual Reload
	if (imp == 2 && self.weapon == IT_SHOTGUN)
	{
		if (self.pistol_ammo_count != 10)
			
			/*
			if 	(self.weaponmodel == "progs/placeholder_progs/v_pistol_akimbo.mdl")
				weaponanim_reload_PISTOL_AKIMBO();
			else if (self.weaponmodel == "progs/placeholder_progs/v_pistol_revolver.mdl")
			*/
			
			if (self.weaponmodel == "progs/placeholder_progs/v_pistol_revolver.mdl")	
				weaponanim_reload_REVOLVER();
			else
				weaponanim_reloadpistol();

		else if (self.pistol_ammo_count == 10)
			weaponanim_twirlpistol();
		
		return WEAPONSTAT_AVAILABLE;
	}


	self.melee_returnimpcheck = imp;

	if (self.customflags & CFL_WEAPONLOCK) return WEAPONSTAT_CHANGELOCKED;

	float altBit = SlotBit(imp);

	weaponclass_t currentWeapon;
	if (self.active_weapon_index > 0 && self.active_weapon_index <= MAX_WEAPON_NUM)
		currentWeapon = weaponsclass[self.active_weapon_index];
	else
		currentWeapon = weaponsclass[getWeapon(self.weapon)];

	float alreadyOnSlot = (currentWeapon.slot == imp);
	float slotQuantity = weaponslots[imp].qt;

	float targetPos;

	float hasAlternate = (self.weapon_alternate & altBit);

	if (alreadyOnSlot)
	{
		if (slotQuantity < 2) return WEAPONSTAT_AVAILABLE;

		if (hasAlternate)
			return WEAPONSTAT_AVAILABLE;
		return WEAPONSTAT_AVAILABLE;
	}
	else
	{
		targetPos = hasAlternate ? 1 : 0;
		if (targetPos >= slotQuantity)
			targetPos = 0;
	}
	float i;
	for (i = 0; i < slotQuantity; i++)
	{
		float tryPos = (targetPos + i) % slotQuantity;
		weaponclass_t targetWeap = weaponslots[imp].weaps[tryPos];

		float weaponstat = W_CheckWeapon(targetWeap.id, self);
		if (weaponstat == WEAPONSTAT_AVAILABLE)
		{
			float weapIndex = FindWeaponIndex(targetWeap.id, targetWeap.name);

			bprint("Selected: ");
			bprint(weaponsclass[weapIndex].name);
			bprint("\n");
			
			W_ChangeWeaponByIndex(weapIndex);
			return weaponstat;
		}
	}

	// otherwise...
	weaponclass_t fallback = weaponslots[imp].weaps[0];
	float fallbackStat = W_CheckWeapon(fallback.id, self);
	if (fallbackStat == WEAPONSTAT_NOAMMO)
		sprint(self, "not enough ammo.\n");
	if (fallbackStat == WEAPONSTAT_NOWEAPON)
		sprint(self, "no weapon.\n");
	return fallbackStat;
}


float() W_ToggleAlternate =
{
	weaponclass_t currentWeapon;
	if (self.active_weapon_index > 0 && self.active_weapon_index <= MAX_WEAPON_NUM)
		currentWeapon = weaponsclass[self.active_weapon_index];
	else
		currentWeapon = weaponsclass[getWeapon(self.weapon)];

	float currentSlot = currentWeapon.slot;
	if (currentSlot <= 0) return WEAPONSTAT_CHANGELOCKED;

	float slotQuantity = weaponslots[currentSlot].qt;
	if (slotQuantity < 2) return WEAPONSTAT_AVAILABLE;

	float altBit = SlotBit(currentSlot);

	// toggle the ownership bit
	self.weapon_alternate = self.weapon_alternate ^ altBit;
	float targetPos = (self.weapon_alternate & altBit) ? 1 : 0;

	weaponclass_t targetWeap = weaponslots[currentSlot].weaps[targetPos];
	float weaponstat = W_CheckWeapon(targetWeap.id, self);
	if (weaponstat == WEAPONSTAT_AVAILABLE)
	{
		float weapIndex = FindWeaponIndex(targetWeap.id, targetWeap.name);
		W_ChangeWeaponByIndex(weapIndex);
		return weaponstat;
	}

	// target wasn't available, flip the bit back
	self.weapon_alternate = self.weapon_alternate ^ altBit;
	return weaponstat;
}



float(float stp) W_CycleWeapon =
{
	if (self.customflags & CFL_WEAPONLOCK) return WEAPONSTAT_CHANGELOCKED;

	float currentWeapon = getWeapon(self.weapon);

	float next = wrap(currentWeapon + stp, 1, MAX_WEAPON_NUM);
	float i;
	while (next != currentWeapon && i <= MAX_WEAPON_NUM) {
		//dprint3("Testing slot ", ftos(next), "...\n");
		if (W_CheckWeapon(weaponsclass[next].id, self) == WEAPONSTAT_AVAILABLE) {
		//	dprint3("Found! slot ", ftos(next), "\n");
			W_ChangeWeapon(weaponsclass[next].id, FALSE);
			return WEAPONSTAT_AVAILABLE;
		}

		next = wrap(next + stp, 1, MAX_WEAPON_NUM);
		i++;
	}

	if (i > MAX_WEAPON_NUM) W_ChangeWeapon(IT_NO_WEAPON, FALSE);
	return WEAPONSTAT_AVAILABLE;
}





/*
========
SuperDamageSound

Plays sound if needed
========
*/
void() SuperDamageSound =
{
	if (!has_quad(self)) return;
	if (self.super_damage_finished < time + 3) return;
	if (self.super_sound < time)
	{
		self.super_sound = time + 0.9;
		sound (self, CHAN_POWERUP, "items/damage3.wav", 1, ATTN_NORM);
	}
}



