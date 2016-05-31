//: Playground - noun: a place where people can play

import UIKit

// Optional Chaning as an Alternative to Forced Unwrapping
class PersonAlt {
    var residence: ResidenceAlt?
}

class ResidenceAlt {
    var numberOfRooms = 1
}

let johnAlt = PersonAlt()
//let roomCount = john.residence!.numberOfRooms // error
if let roomCount = johnAlt.residence?.numberOfRooms {
    print("Jhon's residence has \(roomCount)")
} else {
    print("Unable to retrive the number of rooms.")
}

johnAlt.residence = ResidenceAlt()
if let roomCount = johnAlt.residence?.numberOfRooms {
    print("Jhon's residence has \(roomCount)")
} else {
    print("Unable to retrive the number of rooms.")
}


// Defining Model CLasses for Optional Chaining
class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func bluidingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

// Accessing Properties Through Optional Chaining
let john = Person()
if let roomCount = johnAlt.residence?.numberOfRooms {
    print("Jhon's residence has \(roomCount)")
} else {
    print("Unable to retrive the number of rooms.")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress //nil, because residence is nil


func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

john.residence?.address = createAddress() // createAddress is not called, because residence is nil (optional chaining)

// Calling Methods Through Optional Chaining
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("it was not possible to print the number if rooms.")
}

if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the adress.")
} else {
    print("It was not possible to set the adress.")
}

// Accessing Subscripts Through Optional Chaining
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrive the first room name.")
}

john.residence?[0] = Room(name: "Bathroom")

let johnsHouse = Residence()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrive the first room name.")
}

// Accessing Subscript of Optional Type
var testScores = ["Dave": [86,82,84], "Bev": [79,94,81]]
testScores["Dave"]?[0] = 91
testScores
testScores["Bev"]?[0] += 1
testScores
testScores["Brian"]?[0] = 72
testScores

// Linking Multiple Levels of Chaining
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet)")
} else {
    print("Unable to retrive the address")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet)")
} else {
    print("Unable to retrive the address")
}

// Chaining on Methods with Optional Return Values
if let buildingIdentifier = john.residence?.address?.bluidingIdentifier() {
    print("John's building identifier is \(buildingIdentifier)")
}

if let beginsWithThe = john.residence?.address?.bluidingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"the\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}

