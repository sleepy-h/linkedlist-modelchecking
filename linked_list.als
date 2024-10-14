module LinkedList

// Signature for Node
sig Node {
    value: Int,       // Value stored in the node
    next: lone Node   // Reference to the next node, can be absent
}

// A linked list consists of nodes
sig LinkedList {
    head: one Node   // The head of the linked list
}

// A predicate to define the presence of a loop in a linked list
pred noLoop(ll: LinkedList) {
    // The only allowable path from head to subsequent nodes
    // should eventually reach a node with no successor
    all n: Node | n in ll.head.*next implies n.next = none
}

// A predicate defining a simple operation for adding a node
pred addNode(ll: LinkedList, newValue: Int) {
    // New node is added at the head
    let newNode = Node {
        value = newValue,
        next = ll.head
    } |
    ll.head = newNode
}

// Assert that a linked list can be created with 3 nodes
run {
    let n1 = Node {
        value = 1,
        next = n2
    },
    n2 = Node {
        value = 2,
        next = n3
    },
    n3 = Node {
        value = 3,
        next = none
    } |
    some head: n1
}

// Check if the example linked list has no loops
check noLoop
