import UIKit

struct Stack {
    private var privateStorage: [String] = []
    
    mutating func push(_ element: String) {
        privateStorage.append(element)
    }
    
    mutating func pop() -> String? {
        return privateStorage.popLast()
    }
}

var stack = Stack()

stack.push("Hello")
stack.push("World")
stack.push("?")
stack.pop()
stack.push("!")
// stack.pop()
// stack.pop()
// stack.pop()

extension Stack: Collection {
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return privateStorage.count
    }
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(position: Int) -> String {
        return privateStorage[position]
    }
}

for element in stack {
    print("\(element)")
}

stack.count
stack.isEmpty

Array(stack[1...2])

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: String...) {
        privateStorage = elements
    }
}

let stackFromArrayLiteral: Stack = ["one", "two", "three"]

let string = "Simple string"

var indexInString1: String.Index = string.index(of: "s")!
var indexInString2 = indexInString1
indexInString2 = string.index(after: indexInString2)
string.formIndex(after: &indexInString2)

var indexDistance = string.distance(from: indexInString1,
                                    to: indexInString2)

indexInString1 = string.index(indexInString1, offsetBy: indexDistance)
indexInString1 == indexInString2

// Collections has startIndex and endIndex. endIndex is not exists - it follows after last index
// it is useful for while loops

class Multiplier {
    let value: Int
    init (value: Int) {
        value = value
    }
    func multiply(_ array: [Int]) -> [Int] {
        return array.map {
            $0 * self.value
        }
    }
}

let multiplier = Multiplier (value: 5)
multiplier.multiply ([5, 6, 7, 8, 9])
