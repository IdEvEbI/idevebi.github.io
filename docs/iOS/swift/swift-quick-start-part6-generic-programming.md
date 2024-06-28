# Swift 学习日志（6）：泛型编程

在本篇文章中，咱们将探讨 Swift 中的**泛型编程**。泛型编程是一种编写灵活且可重用代码的方法，**可以处理任何类型的数据**。通过使用泛型，咱们可以避免代码重复，提高代码的可维护性和可读性。

## 1. 泛型概述

泛型允许我们编写的**函数**、**类**和**结构体**能够处理不同类型的数据，而不需要每次都重新编写代码。Swift 的泛型使用尖括号 `<>` 来表示类型参数。

### 1.1 定义泛型函数

泛型函数可以处理不同类型的参数。例如，定义一个交换两个值的泛型函数：

```swift
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
```

> **说明**：`inout` 关键字用于表示参数是可变的，函数可以修改该参数的值，并在函数执行完毕后将修改后的值返回给调用方。在调用函数时，需要在参数前添加 `&` 符号，以表示该参数是可变的。

### 1.2 定义泛型类型

泛型不仅可以用于**函数**，还可以用于定义**类**、**结构体**和**枚举**。例如，定义一个泛型栈（Stack）结构体：

```swift
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
```

### 1.3 泛型约束

有时候，咱们需要对泛型类型施加约束，确保泛型类型符合某些**协议**。例如，定义一个比较两个值是否相等的泛型函数，并要求泛型类型遵循 `Equatable` 协议：

> **说明**：协议（Protocol）是一种约定，用于定义一组方法和属性，任何符合该协议的类型都必须实现这些方法和属性。在下一篇专栏文章中，我们将详细探讨协议的相关内容。

```swift
// 定义一个比较两个值是否相等的泛型函数
func areValuesEqual<T: Equatable>(_ a: T, _ b: T) -> Bool {
    return a == b
}

// 测试泛型函数
print(areValuesEqual(1, 1))  // 输出 "true"
print(areValuesEqual("Hello", "World"))  // 输出 "false"
```

## 2. 案例：泛型队列

### 2.1 案例简介

咱们将创建一个简单的泛型队列（Queue），演示如何使用泛型编写一个可以处理任何类型数据的队列，并实现添加和删除元素的功能。

### 2.2 实现步骤

1. **定义队列结构体**：定义一个 `Queue` **结构体**，使用泛型类型。
2. **实现添加元素的方法**：实现一个 `enqueue` **方法**，用于向队列中添加元素。
3. **实现删除元素的方法**：实现一个 `dequeue` **方法**，用于从队列中删除元素。

### 2.3 代码示例

```swift
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
```

## 3. 结语

在这篇文章中，我们深入探讨了 Swift 的**泛型编程**，并通过一个简单的泛型队列案例将所学知识应用到实践中。希望你对 Swift 的泛型编程有了更深入的理解。下一篇文章将进一步探讨 Swift 的协议和扩展，敬请期待。

> 本专栏文档及配套代码的 GitHub 地址：[壹刀流的技术人生](https://github.com/IdEvEbI/idevebi.github.io)。
