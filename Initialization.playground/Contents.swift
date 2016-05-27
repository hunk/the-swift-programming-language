//: Playground - noun: a place where people can play

import UIKit

// Initializer
struct Fahrenheit {
    var temperature: Double
    
    init() {
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature)")

// Customizing Initialization
struct Celsius {
    
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
boilingPointOfWater.temperatureInCelsius

let frezingPointOfWater = Celsius(fromKelvin: 273.15)
frezingPointOfWater.temperatureInCelsius

// Local and External Parameter Names

struct Color {
    var red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magente = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)

//let veryGreen(0.0, 1.0, 0.0) // Error

// Initializer Parameters Without External Names

struct AnotherCelsius {
    
    var temperatureInCelsius: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celcius: Double) {
        temperatureInCelsius = celcius
    }

}

let bodyTemperature = AnotherCelsius(37.0)
bodyTemperature.temperatureInCelsius

// Optional Property Types
class SurveyQuestion {
    
    var text: String
    var reponse: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.reponse = "Yes, I do like cheese"

// Assingning Constant Properties During Initialization
class SurveyQuestion2 {
    
    let text: String
    var reponse: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
}

let beetsQuestion = SurveyQuestion2(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.reponse = "I also like beets. (But not with cheese)"

// Default Initializers
class ShoppingListItemAlt {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItemAlt()

// Memberwise Initializers for Structure Types
struct Size {
    var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2.0, height: 2.0)

// Initializer Delegation for Value Types
//struct Size {
//    var width = 0.0, height = 0.0
//}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin  = Point()
    var size = Size()
    
    init() {}
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
centerRect.origin.x
centerRect.origin.y

// Class inherintance and Initialization
// Desingnated Initializers and Conveniece Initializers

// Desingnated
//init(parameters) {
//    statements
//}


// Convenience
//conveniece init(parameters) {
//    statements
//}

// Initializer Inheritance and Overriding
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheels(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

// Designated and Convenience Initializers in Action
class Food {
    var name: String
    
    init(name: String) {
        NSLog("1")
        self.name = name
    }
    
    convenience init() {
        NSLog("2")
        self.init(name: "[Unnamed]")
    }
}


let namedMeat = Food(name: "Bacon")
namedMeat.name

let mysteryMeat = Food()
mysteryMeat.name

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        NSLog("3")
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        NSLog("4")
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
oneMysteryItem.name
oneMysteryItem.quantity

let oneBacon = RecipeIngredient(name: "Bacon")
let sizEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✓" : " 𐄂"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6)
]
breakfastList[0].name
breakfastList[0].name = "Orange juice"
breakfastList[0].description
breakfastList[0].purchased = true
breakfastList[0].description

for item in breakfastList {
    print(item.description)
}

// Failable Initializers
class Animal {
    let species: String
    
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")

if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

// Failable Initializers for Enumerations
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "k":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

// Fialable Initializer for Enumerations wirh Raw Values
enum TemperatureUnit2: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
if fahrenheitUnit2 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknownUnit2 = TemperatureUnit2(rawValue: "X")
if unknownUnit2 == nil {
    print("This is not a defined temperature unit, so initialization failed.")
}

// Propagation of Initialization Failure
class Product {
    let name: String
    
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
    
}

class CartItem: Product {
    let quantity: Int
    
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
    
}

if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to intialize zero shirts")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to intialize one unnamed product")
}

// Overriding a Failable Initializer
class Document {
    var name: String?
    
    init() {}
    
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    
    override init() {
        super.init(name: "[Untitled]")!
    }
}

// The init! Failable Initializer

// Required Initializers
class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeClass {
    
    required init() {
        // subclass imlementation of the required initializer goes here
        // Note: you do not write ovrride modifier when overriding a required designated initializer
    }
}

// Setting a Default Property Value with a Closure or Function
class AnotherSomeClass {
    let someProperty: String = {
        // create a default value for someProperty inside this closure
        // someValue muest be of the same type as SomeType
        let someValue = "Hi"
        return someValue
    }()
}

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        
        return temporaryBoard
    }()
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()

print(board.squareIsBlackAtRow(0, column: 1))
print(board.squareIsBlackAtRow(7, column: 7))











