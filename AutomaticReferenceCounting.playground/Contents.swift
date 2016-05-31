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

var anotherCustomer: Customer?
anotherCustomer = Customer(name: "another customer")
var creditCard: CreditCard? = CreditCard(number: 1111_2222_3333_4444, customer: anotherCustomer!)
anotherCustomer?.card = creditCard
anotherCustomer = nil
creditCard = nil

// Unowned References and Implicitly Unwrapped Optional Properties
class Country {
    let name: String
    var capitalCity: City!
    
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")

// Strong Reference Cycles for Closures
class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("HTMLElement:\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}

print(heading.asHTML())

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(paragraph!.asHTML())
paragraph = nil

// Resolving Strong Reference Cycles for Closures
class HTMLElement2 {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
            if let text = self.text {
                return "<\(self.name)>\(text)</\(self.name)>"
            } else {
                return "<\(self.name) />"
            }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("HTMLElement2:\(name) is being deinitialized")
    }
}

var paragraph2: HTMLElement2? = HTMLElement2(name: "p", text: "hello, world")
print(paragraph2!.asHTML())
paragraph2 = nil
