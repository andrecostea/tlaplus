# TLA+ Homework

This repository contains the templates for the TLA+ homework tasks. Please,
submit your solution as a tagged release on LumiNUS.

## Software Prerequisites

Please, make sure to install
[Visual Studio Code](https://code.visualstudio.com/download) and its
[TLA+ Extension](https://marketplace.visualstudio.com/items?itemName=alygin.vscode-tlaplus),
following the instructions on the linked pages. Also, consider adding the
[following command](https://github.com/alygin/vscode-tlaplus/wiki/Automatic-Module-Parsing)
to your VSCode setting to parse your TLA+ code automatically.

## Tasks

The task templates are availble in the folder `tasks`. Each tasks is implemented
in a separate `*.tla` file. Use contextual help of VSCode (`Ctrl-Shift-P` or
`Cmd-Shit-P`) to parse and check the specifications.

### Task 1: Rooms, Guests, and Keys (3 points)

This problem is borrowed from Daniel Jackson's book _"Software Abstractions: Logic, Language, and Analysis"_.

Most hotels nowadays issue disposable card keys. When the guest checks out, they
can take the key with them. Therefore, the hotel needs to prevent the guests
from entering their room after the have checked out. To solve this problem,
since 1980's hotels use recordable locks. The idea is that the hotel issues a
new key to the next guest, which _recodes_ the lock, making the previous key no
longer usable. The lock is a simple stand-alone battery-powered unit with a
memory holding the current key combination. The lock is opened only by the
current combination, and if its successor is inserted, the successor is made to
be the current combination, so that the old combination is no longer accepted.

Following the template in the file `Rooms.tla`, define the specification of the
hotel with the electronic keys according to the text above. Then use the TLC
model checker to ensure that the property `NoBadEntry` holds as an invariant.

### Task 2: River Crossing (3 points)

A classical river-crossing puzzle is stated as follows:

_Once upon a time a farmer went to a market and purchased a wolf, a goat, and a
cabbage. On his way home, the farmer came to the bank of a river and rented a
boat. But crossing the river by boat, the farmer could carry only himself and a
single one of his purchases: the wolf, the goat, or the cabbage. If left
unattended together, the wolf would eat the goat, or the goat would eat the
cabbage. The farmer's challenge was to carry himself and his purchases to the
far bank of the river, leaving each purchase intact. How did he do it?_

Complete the file `RiverCrossing.tla` and use TLC to solve the puzzle. Explain
your solution in comments. 

### Task 3: Snack Machine (4 points)

Complete the TLA+ specification in file `Snacks.tla` for a snack vending machine
that stocks a small number of different kinds of products (e.g. different kinds
of candy or soda). The machine is initally stocked with zero or more products of
each kinds, and zero or more coins in its internal bank. When in operation, it
responds to the following external actions:

* Customer deposits a coin.
* Customer selects a product. If they have deposited enough coins, the product
  is delivered, the money needed to pay for it is retained by the machine, and
  any amount of extra money they may have deposited is returned to them (the
  machine “makes change.”) Otherwise, nothing happens.
* Customer selects “cancel”. Any coins they have deposited so far are returned.

Your specification should allow you to use TLC to check the property that the
total value of products in the machine’s stock plus money in its internal bank
is invariant during operation. Actually, this isn’t quite true: you’ll need to
come up with a more precise invariant that is true.

Do this exercise in two steps:

(a) To begin with, assume that products all cost some multiple of $1, and the
    machine only accepts dollar coins.

(b) As a second step, assume that products all cost some multiple of $0.10 and
    that the machine accepts either dimes or dollar coins, with separate
    internal storage for each kind of coin in its bank. Note that in this
    scenario, it is possible for the machine to be unable to make change in
    certain circumstances (e.g., consider depositing a dollar coin and selecting
    an item that costs less than $1). Make sure that your specification
    considers this possibility and prevents an item from being selected if the
    machine cannot make change for it.

Here are some guidelines and hints for your specification. Feel free to
ignore/change any of these if you think you have a better way to express the
problem. Use comments to explain anything non-obvious in your specification.

* The set of products and their prices should be `CONSTANTS`. Represent products
  as a set of values. Represent prices as a function from products to `Nat`.
  Modify the file `SnacksModel.tla` to set the concrete values of your constants
  and use this file for model-checking your main protocol implementation.
  
  To describe a concrete function given by the ordered pairs `{(d1, r1),(d2, r2), ...,(dn, rn)}` 
  as the value of a constant, use the notation `(d1 :> r1 @@ d2 :> r2 @@ ... @@ dn :> rn)`.

* Check the variables definition and think of the suitable `TypeOK` invariant
  for them. The initial values of these variables should be specified as
  `CONSTANTS` too (except for the coins deposited so far, which can be initialized
  to zero).

* There should be three actions: depositing money, selecting an item to
  purchase, and cancelling the purchase. The `Next` action should just be a
  disjunction of these.

* You may find the higher-order `FOLD` operator (familiar from functional
  languages, but defined in a hacky way via `CHOOSE`) useful for computing the
  value of the products in the machine:

  ```
  Fold(f(_,_),i,s) ==
   LET DFold [s0 \in SUBSET s] ==
      LET elt == CHOOSE e \in s0 : TRUE
      IN IF s0 = {} THEN i ELSE f(elt,DFold[s0 \{elt}])
   IN DFold[s] 
  ```

  You can use it as follows for defining a sum of a set `s`:

  ```
  Sum(s) == Fold(LAMBDA e,r : e + r, 0 , s)
  ```
