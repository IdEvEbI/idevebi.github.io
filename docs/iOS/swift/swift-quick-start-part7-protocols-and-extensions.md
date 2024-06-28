# Swift 学习日志（7）：协议和扩展

在本篇文章中，咱们将探讨 Swift 中的**协议（Protocol）**和**扩展（Extension）**。协议和扩展是 Swift 强大的特性，能够帮助我们编写灵活且可重用的代码。

## 1. 协议（Protocol）

协议定义了一组**方法**和**属性**，任何遵循该协议的类型都必须实现这些方法和属性。协议可以用于指定**接口**，提供一致性和灵活性。

### 1.1 定义协议

可以使用 `protocol` 关键字来定义协议：

```swift
// 定义一个协议
protocol Describable {
    var description: String { get }
    func describe() -> String
}
```

### 1.2 遵循协议

类、结构体或枚举都可以遵循协议，并实现协议要求的方法和属性：

```swift
// 定义一个类遵循协议
class Person: Describable {
    var name: String
    var age: Int
    
    var description: String {
        return "姓名：\(name)，年龄：\(age)"
    }
    
    func describe() -> String {
        return description
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// 测试协议
let person = Person(name: "张三", age: 30)
print(person.describe())  // 输出 "姓名：张三，年龄：30"
```

### 1.3 协议继承

协议可以继承其他协议，从而组合多个协议的要求：

```swift
// 定义两个协议
protocol Nameable {
    var name: String { get }
}

protocol Ageable {
    var age: Int { get }
}

// 定义一个继承上述两个协议的新协议
protocol PersonProtocol: Nameable, Ageable {
    func introduce() -> String
}

// 遵循新协议
class Student: PersonProtocol {
    var name: String
    var age: Int
    var studentID: Int
    
    func introduce() -> String {
        return "姓名：\(name)，年龄：\(age)，学号：\(studentID)"
    }
    
    init(name: String, age: Int, studentID: Int) {
        self.name = name
        self.age = age
        self.studentID = studentID
    }
}

// 测试协议继承
let student = Student(name: "李四", age: 20, studentID: 12345)
print(student.introduce())  // 输出 "姓名：李四，年龄：20，学号：12345"
```

## 2. 扩展（Extension）

扩展可以向已有的**类**、**结构体**、**枚举**和**协议**添加新功能。通过扩展，咱们可以在不修改原有代码的情况下，增强类型的功能。

### 2.1 扩展基础类型

可以使用 `extension` 关键字向基础类型添加新功能：

```swift
// 向 Int 类型添加一个计算平方的方法
extension Int {
    func squared() -> Int {
        return self * self
    }
}

// 测试扩展
let number = 4
print("\(number) 的平方是 \(number.squared())")  // 输出 "4 的平方是 16"
```

### 2.2 扩展自定义类型

可以使用扩展向自定义类型添加新功能：

```swift
// 定义一个自定义结构体
struct Circle {
    var radius: Double
}

// 向自定义结构体添加计算周长的方法
extension Circle {
    func circumference() -> Double {
        return 2 * .pi * radius
    }
}

// 测试扩展
let circle = Circle(radius: 5.0)
print("半径为 \(circle.radius) 的圆的周长是 \(circle.circumference())")  // 输出 "半径为 5.0 的圆的周长是 31.41592653589793"
```

### 2.3 扩展协议

扩展不仅可以用于**类**、**结构体**和**枚举**，还可以用于协议。通过扩展协议，可以为遵循该协议的所有类型提供默认实现：

```swift
// 定义一个协议
protocol Computable {
    func compute() -> Int
}

// 通过扩展为协议提供默认实现
extension Computable {
    func compute() -> Int {
        return 42  // 默认实现返回42
    }
}

// 定义一个类遵循协议
class Calculator: Computable {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    func compute() -> Int {
        return value * 2  // 自定义实现返回值的两倍
    }
}

// 测试扩展协议
let defaultCalculator: Computable = Calculator(value: 10)
print(defaultCalculator.compute())  // 输出 "20"
```

## 3. 案例：综合协议和扩展

### 3.1 案例简介

咱们将创建一个简单的动物系统，使用**协议**和**扩展**定义动物的基本行为，并通过扩展为具体的动物类型添加特定功能。

### 3.2 实现步骤

1. **定义基础协议**：定义一个 `Animal` 协议，包含动物的基本行为。
2. **实现具体动物类型**：实现几个遵循 `Animal` 协议的动物类型。
3. **使用扩展添加功能**：使用扩展为具体动物类型添加特定功能。

### 3.3 代码示例

```swift
import Foundation

// 定义基础协议
protocol Animal {
    var name: String { get }
    func sound() -> String
}

// 定义具体动物类型
class Bird: Animal {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func sound() -> String {
        return "啾啾"
    }
}

class Fish: Animal {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func sound() -> String {
        return "咕噜咕噜"
    }
}

// 使用扩展为具体动物类型添加特定功能
extension Bird {
    func fly() -> String {
        return "\(name) 在飞翔"
    }
}

extension Fish {
    func swim() -> String {
        return "\(name) 在游泳"
    }
}

// 测试案例
let myBird = Bird(name: "小鸟")
let myFish = Fish(name: "小鱼")

print("\(myBird.name) 的叫声是 \(myBird.sound())")  // 输出 "小鸟 的叫声是 啾啾"
print(myBird.fly())  // 输出 "小鸟 在飞翔"

print("\(myFish.name) 的叫声是 \(myFish.sound())")  // 输出 "小鱼 的叫声是 咕噜咕噜"
print(myFish.swim())  // 输出 "小鱼 在游泳"
```

## 4. 结语

在这篇文章中，我们深入探讨了 Swift 的**协议**和**扩展**，并通过一个简单的动物系统案例将所学知识应用到实践中。希望你对 Swift 的协议和扩展有了更深入的理解。下一篇文章将进一步探讨 Swift 的高级特性，敬请期待。

> 本专栏文档及配套代码的 GitHub 地址：[壹刀流的技术人生](https://github.com/IdEvEbI/idevebi.github.io)。
