//: Playground - noun: a place where people can play

import UIKit

//public class SomePublicClass {}
//internal class SomeInternalCLass {}
//private class SomePriveteClass {}
//
//public var somePublicVariable = 0
//internal let someInternalConstant = 0
//private func somePrivateFunction() {}

// Custom Types
public class SomePublicClass { // explicitly public class
    public var somePublicProperty = 0 // explicitly public class member
    var comeInternalProperty = 0 // implicitly internal class member
    private func somePrivateMethod() {} // explicitly private class member
}

class SomeInternalClass { // implicitly internal class
    var someInternalProperty = 0 // implicitly internal class member
    private func somePrivateMethod() {} // explicitly private class member
}

private class SomePrivateClass { // explicitly private class
    var somePrivateProperty = 0 // implicitly private class member
    func somePrivateMethod() {} // implicitly private class member
}

// Function Types
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    
    return ( SomeInternalClass(), SomePrivateClass() )
}

// Enumeration Types
public enum COmpassPoint {
    case North
    case south
    case East
    case West
}

// Subclassing
public class A {
    private func someMethod() {}
}

internal class B: A {
    override internal func someMethod() { }
}


public class A1 {
    private func someMethod() {}
}

internal class B1: A1 {
    override internal func someMethod() {
        super.someMethod() // Because B1 and A1 are in the same file
    }
}

// Getters and Setters
struct TrackedString {
    private(set) var numberofEdits = 0
    var value: String = "" {
        didSet {
            numberofEdits += 1
        }
    }
}


 var stringToEdit =  TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberofEdits)")

public struct TrackedString2 {
    public private(set) var numberofEdits = 0
    var value: String = "" {
        didSet {
            numberofEdits += 1
        }
    }
    
    public init() {}
}





