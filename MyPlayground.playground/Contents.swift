//: Playground - noun: a place where people can play

import UIKit

class Shit {
    var smell: String?
    var solidity: String?
    var weight: Double?
    
    init(smell: String?, solidity: String?, weight: Double?) {
        self.smell = smell
        self.solidity = solidity
        self.weight = weight
    }
}

let myShit = Shit(smell: "heavy", solidity: "solid", weight: nil)

let mirror = Mirror(reflecting: myShit)


for child in mirror.children {
    let value: Any = child.value
    
    let subMirror = Mirror(reflecting: value)
    
    if subMirror.displayStyle == .optional {
        if subMirror.children.count == 0 {
            print("\(child) - nil")
        } else {
            print("\(child) - not nil")
        }
        
    }
    
}

