import FirstCourseThirdTaskChecker

// Этот файл пуст не по ошибке. В этот раз вам необходимо самостоятельно импортировать необходимые модули и запустить проверку

class Stack: ArrayInitializableStorage {
    private var array: [Int]
    
    override public var count: Int {
        get {
            return array.count
        }
    }

    required init(array: [Int]) {
        self.array = array
        super.init(array: array)
    }
    
    required init() {
        self.array = []
        super.init()
    }
    
    override func push(_ element: Int) {
        array.append(element)
    }
    
    override func pop() -> Int {
        if let nonOptionalPopLast = array.popLast() {
            return nonOptionalPopLast
        }
        return 0
    }
}

class Queue: ArrayInitializableStorage {
    private var array: [Int]
    
    override public var count: Int {
        get {
            return array.count
        }
    }
    
    required init(array: [Int]) {
        self.array = array
        super.init(array: array)
    }
    
    required init() {
        self.array = []
        super.init()
    }
    
    override func push(_ element: Int) {
        array.append(element)
    }
    
    override func pop() -> Int {
        if let nonOptionalFirst = array.first {
            array.removeFirst()
            return nonOptionalFirst
        }
        return 0
    }
}

let stack = Stack(array: [Int]())
let queue = Queue(array: [Int]())
/// Вам необходимо создать два сабкласса ArrayInitializableStorage. Один из них должен
/// реализовать стек(LIFO), а второй - очередь(FIFO). Список методов и их требования
/// смотрите в комментариях к классу ArrayInitializableStorage и AbstractStorage.
/// Для проверки передайте экземпляры этих классов в метод. Если ваше решение окажется
/// правильным, то в консоли вы увидите часть кодового слова.
///
/// - Parameters:
///   - stack: Экземпляр сабкласса ArrayInitializableStorage, реализующий стек.
///   - queue: Экземпляр сабкласса ArrayInitializableStorage, реализующий очередь.

let checker = Checker()
checker.checkInheritance(stack: stack, queue: queue)

// ====================================================================================================
struct Stack2 : ArrayInitializable, StorageProtocol {
    init() {
        array = [Int]()
    }
    
    var array: [Int]
    
    init(array: [Int]) {
        self.array = array
    }
    
    var count: Int {
        get {
            return array.count
        }
    }
    
    mutating func push(_ element: Int) {
        array.append(element)
    }
    
    mutating func pop() -> Int {
        if let nonOptionalPopLast = array.popLast() {
            return nonOptionalPopLast
        }
        return 0
    }
}

struct Queue2: ArrayInitializable, StorageProtocol {
    init() {
        array = [Int]()
    }

    var array: [Int] = [Int]()
    
    init(array: [Int]) {
        self.array = array
    }

    var count: Int {
        get {
            return array.count
        }
    }

    mutating func push(_ element: Int) {
        array.append(element)
    }
    
    mutating func pop() -> Int {
        if let element = array.first {
            array.removeFirst()
            return element
        }
        return 0
    }
}

let stack2 = Stack2()
let queue2 = Queue2()

/// Вам необходимо создать две структуры. Одна из них должна реализовать стек(LIFO), а
/// вторая - очередь(FIFO). Они должны поддерживать протоколы StorageProtocol и
/// ArrayInitializable. Список методов и их требования смотрите в комментариях к ним.
/// Для проверки передайте экземпляры этих структур в метод. Если ваше решение окажется
/// правильным, то в консоли вы увидите часть кодового слова.
///
/// - Parameters:
///   - stack: Экземпляр структуры, реализующей стек.
///   - queue: Экземпляр структуры, реализующей очередь.
checker.checkProtocols(stack: stack2, queue: queue2)

let stack3 = Stack2()
let queue3 = Queue2()


extension User : JSONSerializable {
    public func toJSON() -> String {
        return "{\"fullName\": \"\(self.fullName)\", \"email\": \"\(self.email)\"}"
    }
}

extension User: JSONInitializable {
    
    public convenience init(JSON: String) {
        var resultDict = [String: String]()
        
        let substrings: [String.SubSequence] = JSON.split(separator: ",")
        substrings
            .filter {
                substring in
                return substring.contains("{") || substring.contains("}")
            }
            .map {
                substring in
                return substring
                    .replacingOccurrences(of: "{", with: "")
                    .replacingOccurrences(of: "}", with: "")
                    .replacingOccurrences(of: "\"", with: "")
            }
            .forEach {
                pairString in
                let pair = pairString.split(separator: ":")
                if let first = pair.first {
                    if let last = pair.last {
                        resultDict[String(first).trimmingCharacters(in: .whitespacesAndNewlines)] = String(last).trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                }
        }
        
        self.init()
        
        if let nonOptionalFullName = resultDict["fullName"] {
            self.fullName = nonOptionalFullName
        }
        if let nonOptionalEmail = resultDict["email"] {
            self.email = nonOptionalEmail
        }
    }
}


/// Ваша задача добавить в класс User поддержку протоколов JSONSerializable и JSONInitializable.
/// Требования к ним смотрите в комментариях. Обратите внимание, что проверять данные на
/// корректность не нужно. Checker всегда будет передавать правильный JSON. Для проверки
/// передайте в метод тип User. Если ваше решение окажется правильным, то в консоли вы увидите
/// часть кодового слова. Внимание! Это задание нельзя решать с помощью протокола Codable.
/// Формат и порядок данных в строке нужно соблюсти строго.
///
/// - Parameter userType: Тип User
checker.checkExtensions(userType: User.self)

// TURoJUaQR0oR4LfK
