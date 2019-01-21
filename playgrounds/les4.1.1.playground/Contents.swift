import UIKit

// les 4.1

func counterFunc() -> (Int) -> String {
    var counter = 0
    func innerFunc(i: Int) -> String {
        counter += i
        
        return "running total: \(counter)"
    }
    
    return innerFunc
}

let closure = counterFunc()

closure(3)
closure(5)

// ===

func transform(_ value: Int, using transformator: (Int) -> Int) -> Int {
    return transformator(value);
}

let multiplier = 3

// Example 1:
// let anonymousClosure = {
//     (anotherItemInArray: Int) -> Int in
//
//     return anotherItemInArray * multiplier
// }
// transform(6, using: anonymousClosure)

// Example 2:
// transform(6, using: {
//     (anotherItemInArray: Int) in
//
//     return anotherItemInArray * multiplier
// })

// Example 3:
//transform(6, using: {
//    return $0 * multiplier
//})

// Example 4:
// transform(6, using: { $0 * multiplier })

// Example 5 (argument is the last):
transform(6) { $0 * multiplier }

// Example 6 (if argument is the only):
// transform { $0 * multiplier }

// ===
// Each closure has it's own counter variable
let firstCounter = counterFunc()
let anotherCounter = counterFunc()
anotherCounter(3)
firstCounter(3)

// ===
var a = 0
var b = 0
let closure1 = {
    [newNameForA = a] in
    
    print(newNameForA, b)
}

a = 10
b = 10
closure1()

let secondReferenceToAnotherCounter = anotherCounter
secondReferenceToAnotherCounter(3)
secondReferenceToAnotherCounter(3)
anotherCounter(3)

class ClosureRunner {
    
    private var closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    func runClosure() {
        closure()
    }
}
