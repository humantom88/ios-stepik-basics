import UIKit

protocol MyProtocol {
    
}

struct MyStruct: MyProtocol {
    
}

protocol MyProtocolWithProperties {
    var settableProperty: Int { set get }
    var gettableProperty: Double { get }
}

struct MyStructWithProperties: MyProtocolWithProperties {
    private var storage: Int = 10
    
    var settableProperty: Int {
        get {
            return storage
        }
        set {
            storage = newValue
        }
    }
    
    var gettableProperty: Double
    
    init(gettableProperty: Double) {
        self.gettableProperty = gettableProperty
    }
    
}

protocol MyProtocolWithTypeProperty {
    static var typeProperty: Int { get }
}

protocol MyProtocolWithMethods {
    mutating func instanceMethod(parameter: Int)
    static func typeMethod() -> Double
}

struct MyStructWithPropertiesAndMethods: MyProtocolWithProperties, MyProtocolWithMethods {
    var settableProperty: Int
    var gettableProperty: Double
    
    mutating func instanceMethod(parameter: Int) {
        gettableProperty = Double(parameter)
    }
    
    static func typeMethod() -> Double {
        return 4.0
    }
}

// Protocol Implementation with init
protocol MyProtocolWithInit {
    init(parameter: Int)
}

class MyClassWithInit: MyProtocolWithInit {
    let someConst: Int
    
    required init(parameter: Int) {
        someConst = parameter
    }
}

// We can set someObject type as Protocol
var someObject: MyProtocolWithProperties = MyStructWithProperties(gettableProperty: 5.0)
someObject.settableProperty
// We can assign another struct to our protocol
someObject = MyStructWithPropertiesAndMethods(settableProperty: 1, gettableProperty: 2.0)
someObject.settableProperty

// Delegate pattern
class StringProcessor {
    var delegate: StringProcessorDelegate?
    
    func process(_ strings: [String]) -> String {
        guard strings.count > 0, let delegate = delegate else {
            return ""
        }
        
        var temp = [String]()
        
        for string in strings {
            let t = delegate.transform(string)
            temp.append(t)
        }
        
        return temp.joined(separator: delegate.concatenateSeparator)
    }
}

protocol StringProcessorDelegate {
    var concatenateSeparator: String { get }
    
    func transform(_ string: String) -> String
}

class UpperCaseStringProcessorDelegate: StringProcessorDelegate {
    var concatenateSeparator: String {
        return " "
    }
    
    func transform(_ string: String) -> String {
        return string.uppercased()
    }
}

class FirstLetterStringProcessorDelegate: StringProcessorDelegate {
    var concatenateSeparator: String {
        return ""
    }
    
    func transform(_ string: String) -> String {
        guard let firstCharacter = string.first else {
            return ""
        }
        
        return String(firstCharacter)
    }
}

var processor = StringProcessor()
let upperCaseDelegate = UpperCaseStringProcessorDelegate()
let firstLetterDelegate = FirstLetterStringProcessorDelegate()
let testArray = ["This", "are", "simple", "test", "strings"]

processor.process(testArray)

processor.delegate = upperCaseDelegate
processor.process(testArray)

processor.delegate = firstLetterDelegate
processor.process(testArray)

var arrayOfDelegates = [StringProcessorDelegate]()

arrayOfDelegates.append(upperCaseDelegate)
arrayOfDelegates.append(firstLetterDelegate)

for delegate in arrayOfDelegates {
    delegate.concatenateSeparator
}


// Protocol Composition
let compoundObject: MyProtocolWithProperties & MyProtocolWithMethods
compoundObject = MyStructWithPropertiesAndMethods(settableProperty: 1, gettableProperty: 2.0)

let compoundClassObject: UIView & MyProtocol

// is, as, as?
let arrayOfAny: [Any] = [4, firstLetterDelegate, "String"]

for object in arrayOfAny {
    if let processorDelegate = object as? StringProcessorDelegate {
        processor.delegate = processorDelegate
        processor.process(testArray)
    }
}

// Protocols available for Objective-C code
@objc protocol ObjCProtocol {
    // Optional protocols supported only by Objective-C classed,
    // or Swift classes, but only marked with @objc attribute
    // But Structs and Enums cannot support such a protocol
    @objc optional func optionalFunc() -> Int
    func normalSwiftRequiredFunc()
}

@objc class MyObjcExposedClass: NSObject, ObjCProtocol {
    func normalSwiftRequiredFunc() {
        
    }
}

let objcClass: ObjCProtocol = MyObjcExposedClass()
let res = objcClass.optionalFunc?()


