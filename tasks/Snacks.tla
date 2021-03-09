------------------------ MODULE Snacks ---------------------
EXTENDS TLC, Naturals

\* Types of coints
coin == {"dollar","dime"} 
\* Type of banked amounts
bank == [coin -> Nat]

(* Operator to fold over a set s using function f and initial value i *)
Fold(f(_,_),i,s) ==
   LET DFold [s0 \in SUBSET s] ==
      LET elt == CHOOSE e \in s0 : TRUE
      IN IF s0 = {} THEN i ELSE f(elt,DFold[s0 \{elt}])
   IN DFold[s] 

\* An example of using fold
Sum(s) == Fold(LAMBDA e,r : e + r, 0 , s)

subBank(b1,b2) == [c \in coin |-> b1[c] - b2[c]]

CONSTANT product
CONSTANT price
CONSTANT initialStock
CONSTANT maxBanked
CONSTANT initialBanked

ASSUME 
   /\ price \in [product -> Nat]
   /\ TRUE \* TODO: What should be the other assumptions on the constants above?

VARIABLE stock
VARIABLE banked
VARIABLE deposited

TypeOK == FALSE \* TODO: Define me!
   
Init == FALSE \* TODO: Define me!
   
Next == FALSE \* TODO: Define me!

\* Defining "good" states of the vending machine.
Good == FALSE \* TODO: Define me!

=============================================================