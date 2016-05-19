//: Playground - noun: a place where people can play

import UIKit

class SomeClass {

}

struct SomeStruct {
    
}

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()
print("the width of someResolution is \(someResolution.width)")
print("The width of videoMode is \(someVideoMode.resolution.width)")

someVideoMode.resolution.width = 1280
print("The width of videoMode is now \(someVideoMode.resolution.width)")

let vga = Resolution(width: 640, height: 480)

let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

//
enum CompassPoint {
    case North, South, East, West
}

var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}
//

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

tenEighty.frameRate

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

let anotherInstanceVideoMode = VideoMode()
anotherInstanceVideoMode.resolution = hd
anotherInstanceVideoMode.interlaced = true
anotherInstanceVideoMode.name = "1080i"
anotherInstanceVideoMode.frameRate = 30.0

if tenEighty === anotherInstanceVideoMode {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
} else {
    print("is not the same instance")
}