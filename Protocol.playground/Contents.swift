//: Playground - noun: a place where people can play

import UIKit

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")
john.fullName

//
class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullName

// Method Requirements
protocol SomeProtocolTwo {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}


class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c ) % m)
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")

// Mutating Method Requirements
protocol Tooglable {
    mutating func toggle()
}

enum OnOffSwitch: Tooglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

var lightSwitch = OnOffSwitch.Off
lightSwitch.toggle()

// Initializer Requirements
protocol SomeProtocolThree {
    init(someParameter: Int)
}


// Class implementations of Protocol Initializer Requirements
class SomeClass: SomeProtocolThree {
    required init(someParameter: Int) {
        
    }
}

protocol SomeProtocolFour {
    init()
}

class SomeSuperClass {
    init() {
    
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocolFour {
    // required is from SomeProtocolFour conformance,
    // override from SomeSuperClass
    required override init() {
        
    }
}

// Failable Initializer Requirements

// Protocols as Types
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

// Delegation
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init() {
        board = [Int](count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02;
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08;
    }
    
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snales and ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns)")
    }
    
}

let tracker =  DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()

// Adding Protocol Conformance with an Extension
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sides dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Sankes and ladders with \(finalSquare) squares"
    }
}

print(game.textualDescription)

// Declaring Protocol Adoption with an Extension
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepesentable: TextRepresentable = simonTheHamster
print(somethingTextRepesentable.textualDescription)


// Collections of Protocol Types
let things: [TextRepresentable] = [game, d12, simonTheHamster]

for thing in things {
    print(thing.textualDescription)
     if let simon = thing as? Hamster {
        print(simon.name)
    }
}

// Protocol Ineheritance
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {

}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ": \n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "🔺 "
            case let snake where snake < 0:
                output += "🔻 "
            default:
                output += "⚬ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)

protocol SomeInheritedProtocol {

}

// Class-Only Protocols
protocol SomeClassOnlyProtocol: class, SomeInheritedProtocol {
    // class-only protocol definition goes here
}

// Protocol Composition
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct AnotherPerson: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(celebrator: protocol<Named,Aged>) {
    print("Heppy birthday \(celebrator.name)- you're \(celebrator.age)")
}

let birthdayPerson = AnotherPerson(name: "Malcom", age: 21)
wishHappyBirthday(birthdayPerson)

// Cheking for Protocol Conformance

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 234_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

// Optional Protocol Requirements

@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()

for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}

// Protocol Extensions
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let generator2 = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And here's a random Boolean: \(generator.randomBool())")

// Providing Default Implementations
extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

protocol hunkProtocol {
    func someFunc() -> String
}

class hunker: hunkProtocol {
//    func someFunc() -> String {
//        return "asdfgh"
//    }
}

extension hunkProtocol {
    func someFunc() -> String {
        return "Qwerty"
    }
}

let yop = hunker()
yop.someFunc()

// Adding Constraints to Protocol Extensions
extension CollectionType where Generator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map {
            $0.textualDescription
        }
        
        return "[" + itemsAsText.joinWithSeparator(",") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

print(hamsters.textualDescription)

let animals = [Animal(legs: 4) ,Animal(legs: 3),Animal(legs: 2)]
//print(Animal.textualDescription) // Error because animal does not conform the protocol TextRepresentable, so, the collecionType (array) dont include textualDescription