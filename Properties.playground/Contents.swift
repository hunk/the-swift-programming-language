//: Playground - noun: a place where people can play

import UIKit

struct FixedLengthRange {
    var firstValue: Int
    let lenght: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, lenght: 3)
rangeOfThreeItems.firstValue = 3

let rangeOfFourItems = FixedLengthRange(firstValue: 0, lenght: 4)

// rangeOfFourItems.lenght = 6 // Error


// Lazy Stored Properties

class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

// until this moment the instance(DataImporter) has been created
manager.importer.fileName

//Computed Properties
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - (size.height / 2)
            origin.y = newCenter.y - (size.width / 2)
        }
    }
    //shorthand setter decleration
    var centerShort: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        set {
            origin.x = newValue.x - (size.height / 2)
            origin.y = newValue.y - (size.width / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y:0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x)), (\(square.origin.y))")

//Read Only

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")


//Porperty Observers
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896


// type property syntax
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
    
    var some: String {
        return SomeStructure.storedTypeProperty
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

let myStructInstance = SomeStructure()
print(myStructInstance.some)

print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
print(myStructInstance.some)

print(SomeEnumeration.computedTypeProperty)
print(SomeEnumeration.storedTypeProperty)

print(SomeClass.computedTypeProperty)

// Querying and Setting Type Properties
// some like: a global variable/constant across all instances of struct/class/enums
struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightCannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)

print(AudioChannel.maxInputLevelForAllChannels)

rightCannel.currentLevel = 11
print(rightCannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)
