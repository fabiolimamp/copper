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