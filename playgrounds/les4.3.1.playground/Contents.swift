import Foundation

// Arrays (Ordered), Dictionaries (Unordered key-val), Range(Unordered unique)
// there is no immutable/mutable, it depends on let/var

// Example 1

// var mutableArray: [Int]
var mutableArray = [1, 2, 3]

// let immutableDictionary: [String: String]
let immutableDictionary = ["language": "Swift", "version": "4.0"]

// var mutableSet: Set<Int>
var mutableSet: Set<Int> = [0, 1, 1, 2, 3] // if elements are repeated - they will be thrown away

// if collection contains object, so immutability guarantees
// that only links to objects are immutable, but data inside object
// may be changed

// All collections are valuable types, so we can simple pass them to function (even if it is declared as var)
// There's no need to worry about changes, cause we will always work with copy of collection

// Elements in set and keys in dict must support Hashable Protocol

// Example 2
// Subscripts
mutableArray[1]
immutableDictionary["language"]

mutableArray.append(contentsOf: [4, 5, 6])

// Slice does not create new array, it keeps link to array
// and beginning and end of chosen range
let slice = mutableArray[3..<mutableArray.endIndex]
type(of: slice)

// There're differences between behaviour of Foundation in Swift and Objective-C
// NSArray is not valuable type in Swift, so we had to do copy always
// Some other collections moved to Swift as valuable types and support Protocols and Collection

var indices = IndexSet()
indices.insert(integersIn: 0..<5)
indices.insert(integersIn: 8...20)
let filtered = indices.filter {
    $0 % 2 == 0
}

filtered.contains(5)
filtered.contains(10)
filtered.contains(15)
