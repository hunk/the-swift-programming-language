//: Playground - noun: a place where people can play

import UIKit

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index;
    }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")


struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue:0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            
            if indexIsValidForRow(row, column: column) {
                print("true")
            } else{ print("false") }
            
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            print("hi")
            return 2//grid[(row * column) + column]
        }
        set {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * column) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

//let someValue = matrix[2, 2] //Error
