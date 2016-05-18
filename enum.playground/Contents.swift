//: Playground - noun: a place where people can play

import UIKit

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)

productBarcode = .QRCode("ABCDEFGHIJ")

switch productBarcode {
    case .UPCA(let numberSystem, let manufacturer, let product, let check):
        print("UPC-A \(numberSystem) \(manufacturer) \(product) \(check)")
    case let .QRCode(productCode):
    print("QR Code: \(productCode)")
}

//
enum Planet: Int {
    case Mercuty = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

let earhsOrder = Planet.Earth.rawValue


enum CompassPoint: String {
    case North, South, East, West
}

let sunsetDirection = CompassPoint.West.rawValue

enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case carriageReturn = "\r"
}

let possiblePlanet = Planet(rawValue: 7)


let positionToFind = 11

if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmess")
    default:
        print("No a safe place for hummans")
        
    }
} else {
    print("There is not a planet at position \(positionToFind)")
}

//
enum ArithmeticExpression {
    case Number(Int)
    indirect case Addition(ArithmeticExpression, ArithmeticExpression)
    indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

// (5 + 4) * 2
let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))

func evaluate(expresion: ArithmeticExpression)  -> Int {
    
    switch expresion {
    case let .Number(value):
        return value
    case let .Addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .Multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))