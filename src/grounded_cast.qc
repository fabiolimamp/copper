/*=================================================================================================
   
   
    Grounded casts are attacks that stay on the ground and run checks to validate spreading patterns
    Think of a slug inching along the ground leaving behind a hazardous slime trail in a straight line
    Could be radial like Molotovs and Spitter goo from Left 4 Dead 2, set max number of splits to set the max spread size
    Imagine multiple slugs, splitting and spreading outwards in a circular radius away from the center impact
    If any slug reaches a stair step or slope that is too steep to travel, remove the slug to stop that trail
    Slugs are spawned as temp entities from an initial cast, then inch forwards by teleporting every nexththink time
    Slug trail patterns can appear instantly by doing all the traceline checks in a single function using for() loops


//=================================================================================================
                                                               
                                                                                                         
                                     (2)╭────╭────╭────╭────╮(3)                                                                      
                                        │    │    │    │    │                                                                
                                   ╭────│    │    │    │    ╭────╮                                                                     
                                   │    │    │    │    │    │    │                                                                
                              ╭────│    │    │    │    │    │    ╭────╮                                                                    
         (0)                  │    │    █    █    █    █    │    │    │                                                  
          │              ╭────│    │   ░░░░░░░░░░░░░░░░░░   │    │    ╭────╮                                                    
          │              │    │    █   ░░░░░░░░░░░░░░░░░░   █    │    │    │                                                
          ╭────╭────╭────│    │   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   │    │    ╭────╭────╭────╭────╮                                                      
          │    │    │    │    █   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   █    │    │    │    │    │    │                                                     
          │    │    │    │   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   │    │    │    │    │    │                                                              
          │    │    │    █   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   █    │    │    │    │    │(4)                                                          
          │    │    │   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   │    │    │    │    │                                                                   
          █    █    █   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   █    █    █    █    │                      
    ░░░░░(1)░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   │  
    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   │  
    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   │(5) drop is too far to continue   
    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    
    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░     
    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░     
    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░   


 //=================================================================================================
 
 
          (0)[start]        [check ceiling](2)─────────>(3)[forward distance]
           │                                ^            │
           │                                │            │
           │                                │            v
           │                                │           (4)[max upper slope]
           │                                │            │
           │                                │            │
           │                                │            │
           │                                │            │
           │	                            │            │
           │	                           (1)           │
           │                 [ground]░░░░░░░░░░░░░░░     │
           │                                             │
           │                                             │
           v                                             │
          (1)[check ground]                              │              
                                                         │
                                                         v
                                                        (5)[max lower slope]


//=================================================================================================


    (0) initial origin of the cast, fire traceline downward and checks if ground valid origin point (1)
        *if ground check failed, don't start the loop, caster is too high in the air\
        
    (1) if ground check valid, create [grounded attack] at that ground origin point, then fire another traceline upward and check ceiling (2)
        *if ceiling detected, exit the loop, prevents [grounded attack] being created in areas where the player can't jump over safely
        
    (2) if ceiling check valid, fire traceline forwards and check forward distance (3)
        *if forward traceline failed, exit the loop, cast has hit a vertical wall and can not continue
        
    (3) if forward check valid, fire traceline downward and check the height of the max upper slope (4)
        *this shorter trace prevents putting attacks on the corners of brushes, much be above the next step
        
    (4) if max upper slope valid, fire another traceline downward and check the height until reaching the max lower slope (5)
        *this is the max upper and lower range for how steep a slope or how high a stair step can be in order to continue, else exit the loop
        
    (5) if [ground]░░░░░ is detected within traceline (4) then that becomes the new origin point for [grounded attack] to fire and loop (1)
        *if [ground]░░░░░ is not detected with traceline (4) exit the loop, the [ground]░░░░░ is too far away for the [grounded attack] to reach


=================================================================================================*/








void() Start_Grounded_Cast =
{
	makevectors (self.v_angle);
	
		
	//convert v_forward into yaw vector (without pitch) and keeps radius length in tact!
	v_forward.z = 0;
	vector yaw = v_forward * (1/vlen(v_forward));	



	vector 	next_startpos = self.origin + self.view_ofs;
	//vector 	prev_startpos;
	
	//dprint("check floor...\n");
	
	traceline2(next_startpos, next_startpos + '0 0 -96', self, TRACE_NOMONSTERS|TRACE_WATER);		//v_up * -96
	
	//prev_startpos = next_startpos;
	//next_startpos = trace_endpos;
		
	if (trace_ent == self)	
		return;
		
	if (trace_fraction == 1.0)
		return;
	
	else
	{
		entity cast = SpawnTempEnt_Grounded_Cast(trace_endpos, yaw);
		
		//cast.nextthink = time + 0.1;
	}
}





entity(vector org, vector yaw/*, string cname*/) SpawnTempEnt_Grounded_Cast =
{
	entity cast;
		
	cast = spawn();
	cast.owner = cast.trueowner = self;
	//cast.movetype = MOVETYPE_FLYMISSILE;
	cast.movetype = MOVETYPE_NONE;
	//cast.solid = SOLID_BBOX;
	cast.solid = SOLID_NOT;

	cast.angles = vectoangles(yaw);
	
	cast.type = "spike";
	cast.touch = projectile_touch_null;
	//cast.lifetime_finished = time + 0.2;
	//cast.th_die = SUB_Remove;
	cast.th_die = Grounded_Cast_Think;
	//cast.think = SUB_Remove;
	cast.think = Grounded_Cast_Think;
	//cast.nextthink = time + 6;
	cast.nextthink = time + 0.1;
	cast.customflags |= CFL_PROJECTILE;

	setsize (cast, VEC_ORIGIN, VEC_ORIGIN);
	setorigin (cast, org);

	//cast.velocity = cast.oldvelocity = vel;
	
	//cast.classname = cname;
	cast.classname = "grounded";
	
	return cast;
}





void() Grounded_Cast_Think =
{
	SUB_Remove();	//clear SpawnTempEnt
	
	
	makevectors (self.v_angle);
	
		
	//convert v_forward into yaw vector (without pitch) and keeps radius length in tact!
	v_forward.z = 0;
	vector yaw = v_forward * (1/vlen(v_forward));	



	vector 	next_startpos = self.origin + self.view_ofs;
	vector 	prev_startpos;
	
		
	
	//traceline2(next_startpos, next_startpos + '0 0 -96', self, TRACE_NOMONSTERS|TRACE_WATER);
		
	
	
	
	//float stop_loop;
	//for (stop_loop = 0; stop_loop < 32; stop_loop++)	//max number of ground attacks spawned
	
	//dprint("floor valid, draw grounded, check air above...\n");
	
	
		Draw_Groundedtrail (yaw, trace_endpos, "progs/placeholder_progs/fx_grounded_magic_lava.mdl");
		
		entity cast = SpawnTempEnt_Grounded_Cast(trace_endpos, yaw);
	
	//	launch_groundedattack (trace_endpos, '0 0 1', "progs/placeholder_progs/fx_grounded_magic_lava.mdl");
	
		
					
	traceline2(next_startpos, next_startpos + '0 0 64', self, TRACE_NOMONSTERS|TRACE_WATER);	//v_up * 64
	
	prev_startpos = next_startpos;
	next_startpos = trace_endpos;
					
	//Draw_Tracertrail(self, prev_startpos, next_startpos, 0, "progs/placeholder_progs/railtrail_tracer.mdl", 1);
	
	if (trace_ent == self)	
		return;
	
	if (trace_fraction != 1.0)
		return;
	
	else
	{
		//dprint("air above valid, check air forwards...\n");
		
		traceline2(next_startpos, next_startpos + yaw * 32, self, TRACE_NOMONSTERS|TRACE_WATER);		// * 16
		
		prev_startpos = next_startpos;
		next_startpos = trace_endpos;
								
		Draw_Tracertrail(self, prev_startpos, next_startpos, 0, "progs/placeholder_progs/railtrail_tracer.mdl", 1);
		
		if (trace_ent == self)	
			return;
	
		if (trace_fraction != 1.0)
			return;
			
		else
		{
			//dprint("forwards air valid, check air max upper range...\n");
											
			traceline2(next_startpos, next_startpos + '0 0 -16', self, TRACE_NOMONSTERS|TRACE_WATER);	//v_up * -16
			
			prev_startpos = next_startpos;
			next_startpos = trace_endpos;
							
			Draw_Tracertrail(self, prev_startpos, next_startpos, 0, "progs/placeholder_progs/railtrail_tracer.mdl", 1);
			
			if (trace_ent == self)	
				return;
			
			if (trace_fraction != 1.0)
				return;
				
			else
			{
				//dprint("max air upper range valid, check floor...\n");
												
				traceline2(next_startpos, next_startpos + '0 0 -96', self, TRACE_NOMONSTERS|TRACE_WATER);	//v_up * -96
				
				prev_startpos = next_startpos;
				next_startpos = trace_endpos;
									
				Draw_Tracertrail(self, prev_startpos, next_startpos, 0, "progs/placeholder_progs/railtrail_tracer.mdl", 1);
				
				if (trace_ent == self)	
					return;
				
				if (trace_fraction == 1.0)
					return;
			}
		}
	}	
}
