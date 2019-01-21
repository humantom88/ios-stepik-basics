import UIKit

var arrayOfInts = [1, 2, 3, 4, 5]

var multipliedResult = [Int]()
for element in arrayOfInts {
    multipliedResult.append(element * 3)
}
multipliedResult

let sameMultipliedResult = arrayOfInts.map { $0 * 3 }
sameMultipliedResult

let arrayOfOptionalInts = [10, 9, nil, 7, 6]

let multipliedArrayOfOptionalInts = arrayOfOptionalInts.map {
    (value) -> Int? in
    if let value = value {
        return value * 3
    } else {
        return nil
    }}

multipliedArrayOfOptionalInts

// ===
let arrayOfArrayOfInts = [[1, 2, 3],
                          [4, 5],
                          [6, 7, 8]]

arrayOfOptionalInts.map {
    type(of: $0) // [Int]
}

let increasedArrayOfArrayOfInts = arrayOfArrayOfInts.map { $0.map { $0 + 2} }

increasedArrayOfArrayOfInts

// ===
let arrayOfOptionalArrayOfInts = [[11, 12, 13],
                                  nil,
                                  [15, 16, 17]]

let increasedArrayOfOptionalArrayOfints = arrayOfOptionalArrayOfInts.map { $0?.map { $0 + 2 } }
increasedArrayOfOptionalArrayOfints

let multipliednArrayOfNonOptionalInts = arrayOfOptionalInts.compactMap {
    (value) -> Int? in

    if let value = value {
        return value * 3
    } else {
        return nil
    }
}

multipliednArrayOfNonOptionalInts

let sameMultipliedResult2 = arrayOfInts.compactMap { $0 * 3 }
sameMultipliedResult2

// let flatmappedArrayOfArrayOfInts = arrayOfArrayOfInts.flatMap { $0.map { $0 + 2 }} // the result will be different
let flatmappedArrayOfArrayOfInts = arrayOfArrayOfInts.compactMap { $0.map { $0 + 2 }}
flatmappedArrayOfArrayOfInts

let arrayOfNonOptionalArrayOfints = arrayOfOptionalArrayOfInts.flatMap { $0 }
arrayOfNonOptionalArrayOfints

let flatmappedArrayOfOptionalArrayOfInts = arrayOfNonOptionalArrayOfints.flatMap { $0 ?? [Int]() }
flatmappedArrayOfOptionalArrayOfInts

// ===

// Filters
let arrayOfEvenInts = arrayOfInts.filter { $0 % 2 == 0}
arrayOfEvenInts

let decreaseSortedArrayOfInts = arrayOfInts.sorted { $0 > $1 }
decreaseSortedArrayOfInts
// And the same but shorter
let sameDecreaseSortedArrayOfInts = arrayOfInts.sorted(by: >)
sameDecreaseSortedArrayOfInts

[3, 2, 1].sorted()

let sumOfArrayElements = arrayOfInts.reduce(0) {
    intermediateResult, anotherElement in
    
    return intermediateResult + anotherElement
}
sumOfArrayElements
// And the same but shorter
let sameSumOfArrayElements = arrayOfInts.reduce(0, +)
sameSumOfArrayElements

let sameArrayOfEvenInts = arrayOfInts.reduce([]) { $1 % 2 == 0 ? $0 + [$1] : $0 }
sameArrayOfEvenInts

let sameSumOfArrayElements3 = arrayOfInts.reduce(into: 0) { $0 += $1 }
sameSumOfArrayElements3

var mutableArrayOfInt = [1, 3, 2]
mutableArrayOfInt.swapAt(1, 2)
mutableArrayOfInt

let sequenceOfInts = sequence(first: 1) { $0 + arc4random_uniform(10) } // Create sequence from first element
sequenceOfInts
    .prefix(100) // Get first 100 elements of created sequence
    .reduce(into: []) {
        $0 += [($0.last ?? 0) + $1]
    }
    .map { $0 + 3 }
    .reversed()
    .forEach { print("\($0)") }
