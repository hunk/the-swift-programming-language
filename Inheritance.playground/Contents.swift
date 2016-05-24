//: Playground - noun: a place where people can play

import UIKit

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling ar \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        // do nothing - an arbitrary vehicle dosen't necessarily make a noise
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")

// Subclassing
class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")

// Overriding
class Train: Vehicle {
    override func makeNoise() {
        print("Choo choo")
    }
}

let train = Train()
train.makeNoise()

// Overring Property Getters and Setters
class Car: Vehicle {
    var gears = 1
    override var description: String {
        return super.description + " in gear \(gears)"
    }
}

let car = Car()
car.currentSpeed = 25.0
car.gears = 3
print("Car: \(car.description)")

// Overriding Property Observers
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gears = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")

// Preventing Overrides
// add final keyword before the method or property or subscript