//: Playground - noun: a place where people can play

import UIKit

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    
    func incrementBy(amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
    
    //
    func newIncrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
}


let counter = Counter()
counter.increment()
counter.incrementBy(5)
counter.reset()

counter.newIncrementBy(5, numberOfTimes: 3)

// Self Property
extension Counter {
    func anoterIncrement() {
        self.count += 1
    }
}

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}

let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOfX(1.0) {
    print("this point is to the right of the line where x == 1.0")
}

// mutating

extension Point {
    mutating func moveByX(deltaX: Double, y DeltaY: Double) {
        x += deltaX
        y += DeltaY
    }
}

var somePoint2 = Point(x: 1.0, y: 1.0)
somePoint2.moveByX(2.0, y: 3.0)
print("The point is now at \(somePoint2.x), \(somePoint2.y)")


let fixedPoint = Point(x: 3.0, y: 3.0)
// fixedPoint.moveByX(2.0, y: 3.0) // error because is a constant

// Assinging to self Within a Mutating Method

struct AnotherPoint {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y DeltaY: Double) {
        self = AnotherPoint(x: x + deltaX, y: y + DeltaY)
    }
}

enum TriStateSwitch {
    case Off, Low, High
    
    mutating func next() {
        switch self {
        case Off:
            self = Low
        case Low:
            self = High
        case High:
            self = Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()
ovenLight.next()


// Type Methods
class SomeClass {
    class func someTypedMethod() {
    
    }
}

SomeClass.someTypedMethod()


struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func levelIsUnlocked(level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    var currentLevel = 1
    
    mutating func advanceToLevel(level: Int) -> Bool {
        if LevelTracker.levelIsUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func completedLevel(level: Int) {
        LevelTracker.unlockLevel(level + 1)
        tracker.advanceToLevel(level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Hunk")
player.completedLevel(1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Link")
if player.tracker.advanceToLevel(6) {
    print("player is now on level 6")
} else {
    print("level has not yet been unlocked")
}