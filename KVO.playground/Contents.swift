//: Playground - noun: a place where people can play

import UIKit

class MyClass: NSObject {
    dynamic var variable = 0
    dynamic var anotherVariable = 0
}

var c = MyClass()
c.value(forKeyPath: #keyPath(MyClass.variable))
c.setValue(11, forKeyPath: #keyPath(MyClass.variable))

class MyObserver: NSObject {
    var myContext: Int = 1
    var value: MyClass
    
    init(_ value: MyClass) {
        self.value = value
        super.init()
        value.addObserver(self,
                          forKeyPath: #keyPath(MyClass.variable),
                          options: .new,
                          context: &myContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if context == &myContext {
            print("Change at keyPath = \(keyPath) for \(object)")
        }
    }
    
    deinit {
        value.removeObserver(self, forKeyPath: #keyPath(MyClass.variable))
    }
}

var observed = MyClass()
var o = MyObserver(observed)

observed.variable = 42
