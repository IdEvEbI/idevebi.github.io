import Foundation

//: ## 1. 泛型概述
//: ### 1.1 定义泛型函数
//: 泛型函数可以处理不同类型的参数。例如，定义一个交换两个值的泛型函数：
// 定义一个交换两个值的泛型函数
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

// 测试泛型函数
var number1 = 5
var number2 = 10
swapTwoValues(&number1, &number2)
print("number1: \(number1), number2: \(number2)")  // 输出 "number1: 10, number2: 5"

var string1 = "Hello"
var string2 = "World"
swapTwoValues(&string1, &string2)
print("string1: \(string1), string2: \(string2)")  // 输出 "string1: World, string2: Hello"

//: ### 1.2 定义泛型类型
//: 泛型不仅可以用于**函数**，还可以用于定义**类**、**结构体**和**枚举**。例如，定义一个泛型栈（Stack）结构体：
// 定义一个泛型栈结构体
struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element? {
        return items.popLast()
    }
}

// 测试泛型栈
var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
print("intStack: \(intStack.items)")  // 输出 "intStack: [1, 2]"
intStack.pop()
print("intStack: \(intStack.items)")  // 输出 "intStack: [1]"

var stringStack = Stack<String>()
stringStack.push("Hello")
stringStack.push("World")
print("stringStack: \(stringStack.items)")  // 输出 "stringStack: ["Hello", "World"]"
stringStack.pop()
print("stringStack: \(stringStack.items)")  // 输出 "stringStack: ["Hello"]"

//: ### 1.3 泛型约束
//: 有时候，咱们需要对泛型类型施加约束，确保泛型类型符合某些**协议**。例如，定义一个比较两个值是否相等的泛型函数，并要求泛型类型遵循 `Equatable` 协议：
// 定义一个比较两个值是否相等的泛型函数
func areValuesEqual<T: Equatable>(_ a: T, _ b: T) -> Bool {
    return a == b
}

// 测试泛型函数
print(areValuesEqual(1, 1))  // 输出 "true"
print(areValuesEqual("Hello", "World"))  // 输出 "false"

//: ## 2. 案例：泛型队列
// 定义一个泛型队列结构体
struct Queue<Element> {
    private var elements = [Element]()
    
    mutating func enqueue(_ element: Element) {
        elements.append(element)
    }
    
    mutating func dequeue() -> Element? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeFirst()
    }
    
    func peek() -> Element? {
        return elements.first
    }
}

// 测试泛型队列
var intQueue = Queue<Int>()
intQueue.enqueue(1)
intQueue.enqueue(2)
print("intQueue: \(intQueue)")  // 输出 "intQueue: Queue<Int>(elements: [1, 2])"
intQueue.dequeue()
print("intQueue: \(intQueue)")  // 输出 "intQueue: Queue<Int>(elements: [2])"

var stringQueue = Queue<String>()
stringQueue.enqueue("Hello")
stringQueue.enqueue("World")
print("stringQueue: \(stringQueue)")  // 输出 "stringQueue: Queue<String>(elements: ["Hello", "World"])"
stringQueue.dequeue()
print("stringQueue: \(stringQueue)")  // 输出 "stringQueue: Queue<String>(elements: ["World"])"
