import UIKit

@discardableResult
func usefulFunc(firstParam: Int = 0, secondParam: String = "", thirdParam: String) -> (firstResult: Int, secondResult: String) {
    
    return (firstParam, secondParam)
}

usefulFunc(firstParam: 1, thirdParam: "Simple string")

func usefulFunc2(_ parameterWithoutArgumentName: Int, argumentName parameterName: String) {
    print("Received \(parameterWithoutArgumentName) and \(parameterName)")
}

usefulFunc2(20, argumentName: "<#T##String#> argument")

func sum(_ numbers: Int...) -> Int {
    var result: Int = 0
    for number in numbers {
        result += number;
    }
    
    return result
}

sum(1, 2, 3, 4, 5)

func swapInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var first = 1
var second = 2

swapInts(&first, &second)

print("first \(first) second \(second)")

func summation(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplication(_ a: Int, _ b: Int) -> Int {
    return a * b
}

type(of: summation)
type(of: multiplication)

var function: (Int, Int) -> Int = summation
function = multiplication
function(3, 4)

// ===
func provideTransformator() -> (Int) -> Int {
    func squareTransformator(transform value: Int) -> Int {
        return value * value
    }
    
    return squareTransformator
}

func transform(_ value: Int, using transformator: (Int) -> Int) -> Int {
    return transformator(value)
}

let transformator = provideTransformator()
let result = transform(6, using: transformator)

// ===

class Counter {
    private var count = 0
    
    func increment() {
        // self.count += 1
        count += 1
    }
    
    func isGraterThan(_ count: Int) -> Bool {
        return self.count > count
    }
}

// ===

struct Point {
    var x = 0.0
    var y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    
    mutating func reset() {
        self = Point()
    }
    
    mutating func df() {
        
    }
}

var point = Point(x: 3, y: 4)
point.moveBy(x: 4, y: -2)
point.reset()
print("X:\(point.x) Y:\(point.y)")

class MyClass {
    class func generateText() -> String {
        return "MyClass"
    }
    
    class func printer1() {
        print("\(self.generateText())")
    }
    
    class func printer2() {
        print("\(MyClass.generateText())")
    }
}

class MySubClass: MyClass {
    override class func generateText() -> String {
        return "MySubClass"
    }
}

MySubClass.printer1()
MySubClass.printer2()

struct MyStruct {
    static var sharedValue = 0
    
    func increment() {
        type(of: self).sharedValue += 1
    }
}

let myStruct = MyStruct()

MyStruct.sharedValue

myStruct.increment()

MyStruct.sharedValue

// ===

// Lesson 1
//var str = "Hello, playground"
//
//2 * 2
//
//str
//
//print(str)
//
//CGRect(x: 10, y: 20, width: 200, height: 150)
// Lesson 1 END
