//: Playground - noun: a place where people can play

import UIKit
func swapTwoInts(inout a: Int, inout _ b: Int) {
    let temporalA = a
    a = b
    b = temporalA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")


func swapTwoString(inout a: String, inout _ b: String) {
    let temporalA = a
    a = b
    b = temporalA
}

func swapTwoDoubles(inout a: Double, inout _ b: Double) {
    let temporalA = a
    a = b
    b = temporalA
}

// Generic Functions
func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let temporalA = a
    a = b
    b = temporalA
}

swapTwoValues(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

var someString = "Hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
print("someString is now \(someString), and anotherString is now \(anotherString)")

// Generic Types
struct IntStackFirst {
    var items = [Int]()
    
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfString = Stack<String>()
stackOfString.push("Uno")
stackOfString.push("Dos")
stackOfString.push("Tres")
stackOfString.push("Cuatro")

let fromTheTop = stackOfString.pop()
print(fromTheTop)

//var stackOdint = Stack(items: [1,2,3])

// Extending a Generic Type
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfString.topItem {
    print("The top item on the stack is \(topItem).")
}

// Type Constraints Syntax
class SomeClass {}
protocol SomeProtocol {}
func someFuntion<T: SomeClass, U: SomeProtocol> (someT: T, someU: U) {
    // function body goes here
}

// Type Cpnstraints in Action
func findStringIndex(array: [String], _ valueToFind: String) -> Int? {
    for (index,value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findStringIndex(strings, "llama") {
    print("The index of llama is \(foundIndex)")
}

//func findIndex<T>(array: [T], _ valueToFind: T) -> Int? {
//    for (index,value) in array.enumerate() {
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}

func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index,value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex([3.14159, 0.1, 0.25], 9.3)
let stringIndex = findIndex(["Mike", "Malcom", "Andrea"], "Andrea")

// Associated Types
protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {
    // Original InstStack implementation
    var items = [Int]()
    
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // conformance to the Contaner protocol
//    typealias ItemType = Int // you can skip this
    
    mutating func append(item: Int) {
        self.push(item)
    }
    
    var count: Int { return items.count }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct AnotherStack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    
    mutating func push(item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    mutating func append(item: Element) {
        self.push(item)
    }
    
    var count: Int { return items.count }
    
    subscript(i : Int) -> Element { return items[i] }
}

// Extending an Existing Type to Specify an Associated Type
extension Array: Container{}

// Where Clauses
func allItemsMatch<C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>(someContainer: C1, _ anotherContainer: C2) -> Bool {
    
    // check that both containers contain the same number of items
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    // check each pair of items to see if they are equivalent
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    // all items match, so return true
    return true
}

var newStackOfStrings = AnotherStack<String>()
newStackOfStrings.push("uno")
newStackOfStrings.push("dos")
newStackOfStrings.push("tres")

var arrayOfStrings = ["uno","dos","tres"]

if allItemsMatch(newStackOfStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}


