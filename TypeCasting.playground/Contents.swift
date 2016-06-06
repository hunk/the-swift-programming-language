//: Playground - noun: a place where people can play

import UIKit

class MediaItem {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artits: String
    init(name: String, artits: String) {
        self.artits = artits
        super.init(name: name)
    }
}

let library = [
    Movie(name: "Casablanca", director: "Micheal Curtiz"),
    Song(name: "Blue Suede Shoes", artits: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Wells"),
    Song(name: "The One and Only", artits: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artits: "Rick Astley")
]

library.dynamicType

let firstElemen = library[0]
firstElemen.dynamicType

// Checking Type
var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media Library contains \(movieCount) movies and \(songCount) songs")

// Downcasting
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir: \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by: \(song.artits)")
    }
}

// Type Casting for Any and AnyObject
let someObjects: [AnyObject] = [
    Movie(name: "2001: A space Odyssey", director: "Stanley Kubric"),
    Movie(name: "Moon", director: "Ducan Jones"),
    Movie(name: "Alien", director: "Ridley Scott")
]

for object in someObjects {
    let movie = object as! Movie
    print("Movie: \(movie.name), dir. \(movie.director)")
}

for movie in someObjects as! [Movie] {
    print("Movie: \(movie.name), dir. \(movie.director)")
}

// Any
var things = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
//things.append((3.0, 5.0)) // error: ambiguous reference to member 'append'
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({(name: String) -> String in "Hello, \(name)"})

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \(someString)")
    case let (x,y) as (Double, Double):
        print("an (x,y) point at \(x),\(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as String -> String:
        print(stringConverter("Micheal"))
    default:
        print("something else")
    }
}

