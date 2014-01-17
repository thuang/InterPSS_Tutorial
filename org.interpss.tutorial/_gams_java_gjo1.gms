$Title ED model                                                 
Sets                                                            
         i   generating unit                                    
         j   load bus;                                          
                                                                
Parameters                                                      
        genPLow(i) lower  bound of each generating unit         
        genPUp(i) upper bound of each generating unit           
        loadP(j) demand at load bus j;                          
                                                                
Parameter FactorA(i) weighting factor A for generation cost function; 
Parameter FactorB(i) weighting factor B for generation cost function; 
Parameter FactorC(i) weighting factor C for generation cost function; 
                                                                
$gdxin %gdxincname%                                             
$LOAD  i j genPLow genPUp  loadP FactorA FactorB FactorC        
$GDXIN                                                          
                                                                
Variables                                                       
         genp(i)     generation output for each generating unit  
         ft       total generation cost ;                       
Equations                                                       
        cost            define objective function               
        powerBalance    real power balance of the whole network; 
                                                                
cost.. ft =e= sum(i,  FactorA(i)+FactorB(i)*genp(i)+FactorC(i)*genp(i)*genp(i));
powerBalance ..      sum(i, genp(i)) =g= sum(j,loadP(j)) ;         
  genp.lo(i)  =  genPLow(i);                                       
  genp.up(i)  =  genPUp(i);                                        
                                                                
Model transport /all/ ;                                         
                                                                
solve transport using nlp minimizing ft ;                       
                                                                
display genp.l, genp.m ;                                        
