(* 
This problem is borrowed from Daniel Jackson's book _"Software Abstractions: Logic, Language, and Analysis"_.

Most hotels nowadays issue disposable card keys. When the guest checks out, they
can take the key with them. Therefore, the hotel needs to prevent the guests
from entering their room after they have checked out. To solve this problem,
since 1980's hotels use recordable locks. The idea is that the hotel issues a
new key to the next guest, which _recodes_ the lock, making the previous key no
longer usable. The lock is a simple stand-alone battery-powered unit with a
memory holding the current key combination. The lock is opened only by the
current combination, and if its successor is inserted, the successor is made to
be the current combination, so that the old combination is no longer accepted.

Following the template in the file `Rooms.tla`, define the specification of the
hotel with the electronic keys according to the text above. Then use the TLC
model checker to ensure that the property `NoBadEntry` holds as an invariant. 
*)
--------------------------- MODULE Rooms -----------------------------
EXTENDS TLC, Naturals, FiniteSets
CONSTANT Room, Guest

Key == Room \X Nat

VARIABLE assignedKey
VARIABLE registered
VARIABLE roomKey
VARIABLE guestKeys
VARIABLE inside

\* A helper function to issue the next key
NextKey(r,k) == <<r,k[2]+1>>

\* Hint: use "nobody" to represent an empty room and 
\*           "noroom" to indicate that a guest is currently not in any room.

\* A basic coherence invariant of the system
\* TODO: Define me!
TypeOK == /\ assignedKey \in Room \X Nat 
    
Init == assignedKey \in Room \X {0} \* TODO: Define me!
  
CheckIn(g,r) == FALSE \* TODO: Define me!
             
CheckOut(g,r) == FALSE \* TODO: Define me!
  
EnterRoom(g,r) == FALSE \* TODO: Define me!
       
LeaveRoom(g,r) == FALSE \* TODO: Define me!
   
Next == 
   \/ \E g \in Guest, r \in Room : CheckIn(g,r)
   \/ \E g \in Guest, r \in Room : CheckOut(g,r)
   \/ \E g \in Guest, r \in Room : EnterRoom(g,r)
   \/ \E g \in Guest, r \in Room : LeaveRoom(g,r)

(* This is the invariant that should hold *)
NoBadEntry == FALSE \* TODO: Define me!
     
---------------------------------------------------------------
\* TODO: Work out the constraints for the state-space to make 
\* checking of this model via TLC tractable. Use this constraints
\* in the Rooms.cfg file.

constr == FALSE \* TODO: Define me!

===============================================================
          