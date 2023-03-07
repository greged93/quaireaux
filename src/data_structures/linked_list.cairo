//! Linked List implementation.
//!
//! # Example
//! ```
//! use quaireaux::data_structures::linked_list::LinkedListTrait;
//!
//! // Create a new linked list instance
//! let mut linked_list = LinkedListTrait::new();
//! ```

// Core lib imports
use array::ArrayTrait;
use option::OptionTrait;
use box::Box;

/// Node representation.
struct Node {
    val: felt,
    next: Option::<Box::<Node>>,
    prev: Option::<Box::<Node>>,
}

/// Linked List representation.
struct LinkedList {
    length: usize,
    head: Option::<Node>,
    tail: Option::<Node>,
}

/// Linked List Trait
trait LinkedListTrait {
    /// Create a new empty linked list instance
    fn new() -> LinkedList;
// /// Insert an element at index in the list
// fn insert(ref self: LinkedList::<T>, element: T, index: felt);
// /// Push an element at the front of the list
// fn push_front(ref self: LinkedList::<T>, element: T);
// /// Push an element at the back of the list
// fn push_back(ref self: LinkedList::<T>, element: T);
// /// Remove the element at index and return it
// fn remove(ref self: LinkedList::<T>, index: felt) -> Option::<T>;
// /// Remove the first element and return it
// fn pop_front(ref self: LinkedList::<T>) -> Option::<T>;
// /// Remove the last element and return it
// fn pop_back(ref self: LinkedList::<T>) -> Option::<T>;
// /// Return the element at index without removing it
// fn get(self: @LinkedList::<T>, index: felt) -> Option::<T>;
// /// Return the number of items in the list
// fn len(self: @LinkedList::<T>) -> usize;
// /// Returns true if the list is empty
// fn is_empty(self: @LinkedList::<T>) -> bool;
}

impl LinkedListImpl of LinkedListTrait {
    #[inline(always)]
    /// Create a new Linked List instance
    /// # Returns
    /// The linked list
    fn new() -> LinkedList {
        LinkedList { length: 0_usize, head: Option::None(()) }
    }
}

impl NodeDrop of Drop::<Node>;
impl BoxNodeDrop of Drop::<Box::<Node>>;
impl OptionNodeDrop of Drop::<Option::<Node>>;
impl OptionBoxNodeDrop of Drop::<Option::<Box::<Node>>>;
impl LinkedListDrop of Drop::<LinkedList>;

