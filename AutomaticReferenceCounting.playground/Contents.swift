//: Playground - noun: a place where people can play

import UIKit

// ARC in Action
class Person {
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is begin deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John Applessed")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil

reference3 = nil

// Strong Rereference Cycles Between Class Instances
class AltPerson {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var aparment: Aparment?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Aparment {
    let unit: String
    
    init(unit: String) { self.unit = unit}
    
    var tenant: AltPerson?
    
    deinit {
        print("Aparment \(unit) is being deinitialized")
    }
}

var john: AltPerson?
var unit4A: Aparment?

john = AltPerson(name: "John Appleseed Alt")
unit4A = Aparment(unit: "4A")

john!.aparment = unit4A
unit4A!.tenant = john


john = nil
unit4A!.tenant?.name
unit4A = nil

// Resolving Strong Reference Cycles Between Class Instances
// Weak References

class PersonTwo {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var aparment: AparmentTwo?
    
    deinit {
        print("\(name) is being deinitialized in PersonTwo")
    }
}

class AparmentTwo {
    let unit: String
    
    init(unit: String) { self.unit = unit}
    
    weak var tenant: PersonTwo?
    
    deinit {
        print("Aparment \(unit) is being deinitialized in AparmentTwo")
    }
}


var johnTwo: PersonTwo?
var unit4ATwo: AparmentTwo?

johnTwo = PersonTwo(name: "John Appleseed Two")
unit4ATwo = AparmentTwo(unit: "4A Two")

johnTwo!.aparment = unit4ATwo
unit4ATwo!.tenant = johnTwo

johnTwo = nil

// mmm, the book says the property tenant will be nil after set nil to johnTwo, but no, mmmm
if let _ = unit4ATwo?.tenant {
    print("exist")
}
unit4ATwo?.tenant?.name
unit4ATwo = nil

// Unowned References
class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}


var mori: Customer?
mori = Customer(name: "Mori name")
mori?.card = CreditCard(number: 1234_5678_9012_3456, customer: mori!)
mori = nil






