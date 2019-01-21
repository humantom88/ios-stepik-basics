import UIKit

// Constant and variable properties
struct SimpleStruct {
    var firstValue: Int = 1
    let secondValue: Int
}

var simpleStruct = SimpleStruct(firstValue: 0, secondValue: 2)
simpleStruct.firstValue = 6

let constantStruct = SimpleStruct(firstValue: 0, secondValue: 2)
// constantStruct.firstValue = 3 // Error, unable to change value of let

// Lazy properties
class DataStore {
    var counter = 0
}

// Only global vars can be lazy (from stepik test)

class DataManager {
    lazy var dataStore = DataStore() // We can't use lazy for simple variables (outside class)
}

let dataManager = DataManager()
dataManager.dataStore.counter = 1 // first initialization of counter is here
dataManager.dataStore.counter = 2

// Getters and setters (Computed properties)
class AnotherDataStore {
    var counter: Int {
        get {
            return numbers.count
        }
        set(newCounter) {
            numbers = []
            for index in 0...newCounter {
                numbers.append(index)
            }
        }
    }
    
    var numbers = [Int]()
}

var anotherDataStore = AnotherDataStore()
anotherDataStore.counter = 5
print(anotherDataStore.counter)

// Observers
class ExplicitCounter {
    
    var total: Int = 0 {
        willSet(newTotal) { // newTotal is let value, newValue by default if no params passed
            print("Скоро установится новое значение \(newTotal)")
        }
        didSet { // oldValue by default, could be changed the same way as in willSet
            if (total > oldValue) { // oldValue is var, so we can update value here to be set
                print("Значение изменилось на:\(total - oldValue)")
            }
        }
    }
    
    // Note: If observable prop is passed as inout param,
    // this props observers didSet and willSet will be called either way
    // even if this values hasn't been set before
}

let explicitCounter = ExplicitCounter()
explicitCounter.total = 5
explicitCounter.total = 9

// Static properties
class SomeClass {
    static var storedTypeProperty = 2
    static var squareOfProperty: Int {
        return storedTypeProperty * storedTypeProperty;
    }
    
    // class before var allow us to override this property during inheritance
    class var overrideableHalfOfProperty: Int {
        get {
            return storedTypeProperty * storedTypeProperty
        }
        
        set {
            storedTypeProperty = newValue / 2
        }
    }
}

print(SomeClass.squareOfProperty)
SomeClass.overrideableHalfOfProperty = 10
print(SomeClass.squareOfProperty)

