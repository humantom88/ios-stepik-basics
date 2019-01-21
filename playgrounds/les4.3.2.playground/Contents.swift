import Foundation

// Sequence Protocol is basic protocols for each collection
// requires only makeIterator method
// iterators can give only next element or go to the beginning

struct MultiplicityIterator: IteratorProtocol {
    var base = 1
    
    public mutating func next() -> Int? {
        defer { base += base }
        return base
    }
}

var i = MultiplicityIterator()

i.base = 4
i.next()
i.next()
i.next()

// AnyIterator wraps any another iterator
let sequence = stride(from: 0, to: 10, by: 1) // Последовательность чисел от 0 до 10 с шагом 1

var iterator1 = sequence.makeIterator()
var anyIterator1 = AnyIterator(iterator1)

var iterator2 = sequence.makeIterator()
var anyIterator2 = anyIterator1

iterator1.next()
iterator1.next()
iterator2.next()
iterator2.next()

anyIterator1.next()
anyIterator2.next()
anyIterator1.next()
anyIterator1.next()

let randomIterator = AnyIterator() { arc4random_uniform(100) }
let randomSequence = AnySequence(randomIterator)

let arrayOfRandomNumbers = Array(randomSequence.prefix(10));

for randomNumber in randomSequence.prefix(15) {
    print("Another random number: \(randomNumber)")
}

struct MultiplicitySequence: Sequence {
    private let base: Int
    
    init(base: Int) {
        self.base = base
    }
    
    public func makeIterator() -> MultiplicityIterator {
        var iterator = MultiplicityIterator()
        iterator.base = base
        return iterator
    }
}

let multiplicitySequence = MultiplicitySequence(base: 4)
Array(multiplicitySequence.prefix(4))
Array(multiplicitySequence.prefix(4))

// Example
struct Countdown: Sequence, IteratorProtocol {
    
    var count: Int
    
    mutating func next() -> Int? {
        if count == 0 {
            return nil
        } else {
            defer { count -= 1}
            return count
        }
    }
}

/*
 // Не компилируется в Xcode 9 Beta 5
 protocol Sequence {
     associatedtype SubSequence: Sequence
     where Iterator.Element == SubSequence.Iterator.Element, SubSequence.SubSequence == SubSequence {
         func dropFirst(_ n : Int) -> Self.SubSequence
     }
 }
 */
