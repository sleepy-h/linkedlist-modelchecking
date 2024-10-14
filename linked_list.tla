----------------------------- MODULE LinkedList -----------------------------
EXTENDS TLC

(* Defining a node as a record with a value and a reference to the next node. *)
VARIABLE list

Node == [value: Int, next: NODE]

(* Defining the list as a sequence of nodes, where each element is either a Node or NULL. *)
Nodes == Seq(Node) 

(* Typing our linked list 
   The list can either be an empty list (<< >>) or a sequence of Nodes. *)
LinkedList == (list = <<>> \in Nodes) \/ (A \in Nodes => list = A)

(* The states of the linked list *)
Init == list = <<>>

(* Add a node to the beginning of the linked list *)
AddHead(a) == list' = [list EXCEPT ![1] = a, ![2] = [value |-> a, next |-> list[1]]]

(* Remove a node from the beginning of the linked list *)
RemoveHead == list' = [list EXCEPT ![1] = list[2]]

Next == AddHead(a) \/ RemoveHead

(* This captures the invariants that need to hold *)
Invariant == 
    /\ list \in Nodes 
    /\ (CHOOSE n \in list: n.value) >= 0

(* The specification of the system *)
Spec == Init /\ [][Next]_list

THEOREM Spec => []Invariant

=============================================================================
