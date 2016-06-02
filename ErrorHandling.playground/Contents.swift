//: Playground - noun: a place where people can play

import UIKit

enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}


//throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)

// Propagating Erros Using Throwing Functions

func canThrowErrors() throws -> String { return "" }
func cannotThrowErrors() -> String{ return "" }

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        
        defer {
            print("1")
        }
        
        defer {
            print("2")
        }
        
        defer {
            print("3")
        }
        
        guard let item = inventory[name] else {
            throw VendingMachineError.InvalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        dispenseSnack(name)
    }
}

let favoriteSnack = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnack[person] ?? "Candy Bar"
    defer {
        print("4")
    }
    
    defer {
        print("5")
    }
    
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        
        defer {
            print("6")
        }
        
        defer {
            print("7")
        }
        
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

// Handling Errors Using Do-Catch
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
} catch VendingMachineError.InvalidSelection {
    print("Invalid Selection")
} catch VendingMachineError.OutOfStock {
        print("Out of Stock")
} catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}

// Converting Errors to Optional Values
func someThrowingFunction() throws -> Int {
    // ....
//    throw VendingMachineError.InvalidSelection
    
    return 1
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() {
//        return data
//    }
//    
//    if let data = try? fetchDataFromServer() {
//        return data
//    }
//    
//    return nil
//}

// Disabling Error Propagation
//let photo = try! loadImage("./Resources/John/Appleseed.jpg")

// Specifying Cleanup Action
//func processFile(filename: String) throws {
//    if exits(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        
//        while let line = try file.readline() {
//            //Some work with the line
//        }
//        
//        // close(file) is called here, at the end of the scopr
//    }
//}





