(* 
Once upon a time a farmer went to a market and purchased a wolf, a goat, and a
cabbage. On his way home, the farmer came to the bank of a river and rented a
boat. But crossing the river by boat, the farmer could carry only himself and a
single one of his purchases: the wolf, the goat, or the cabbage. If left
unattended together, the wolf would eat the goat, or the goat would eat the
cabbage. The farmer's challenge was to carry himself and his purchases to the
far bank of the river, leaving each purchase intact. How did he do it?_

Complete the file `RiverCrossing.tla` and use TLC to solve the puzzle. Explain
your solution in comments.  
*)

--------------------- MODULE RiverCrossing ---------------------
EXTENDS TLC

Passenger == {"wolf","goat","cabbage"}
Bank == {"near","far"}

VARIABLES passengers, farmer

\* TODO: Define me!
TypeOK == /\ passengers \in [Passenger -> Bank]
          /\ farmer     \in Bank

\* TODO: Define me!
Init == /\ passengers = [i \in Passenger |-> "near"]
        /\ farmer     = "near"

IsSafe(p,f) == /\ p["wolf"] = p["goat"]    => f = p["goat"]
               /\ p["goat"] = p["cabbage"] => f = p["goat"]

\* TODO: Define me!            
Next ==  
    IF farmer = "near" THEN /\ farmer' = "far"
                            /\ LET p == \E i \in Passenger : passengers[p]="near" 
                               IN /\ passengers' = [passengers EXCEPT ]
                                  /\ IsSafe(farmer',passengers')
                       ELSE /\ farmer' = "near"
                            /\ \E p \in Passenger : passengers[p]="near" 
                            /\ passengers' = passengers
                            /\ IsSafe(farmer',passengers')

InvSafety == /\ \A i \in Passenger : passengers[i] = "far" 
             /\ farmer     = "far"

\* TODO: Define a predicate used for finding a final solution

================================================================