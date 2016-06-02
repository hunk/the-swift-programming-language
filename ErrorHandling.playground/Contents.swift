//: Playground - noun: a place where people can play

import UIKit

enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(coinsNeeded: Int)
    case OutOfStock
}


throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)

