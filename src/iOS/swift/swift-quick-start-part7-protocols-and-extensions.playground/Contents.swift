import Foundation

//: ## 1. 协议（Protocol）
//: 协议定义了一组**方法**和**属性**，任何遵循该协议的类型都必须实现这些方法和属性。协议可以用于指定**接口**，提供一致性和灵活性。
//: ### 1.1 定义协议
//: 可以使用 `protocol` 关键字来定义协议：
// 定义一个协议
protocol Describable {
    var description: String { get }
    func describe() -> String
}

//: ### 1.2 遵循协议
//: 类、结构体或枚举都可以遵循协议，并实现协议要求的方法和属性：
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

//: ### 1.3 协议继承
//: 协议可以继承其他协议，从而组合多个协议的要求：
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

//: ## 2. 扩展（Extension）
//: 扩展可以向已有的**类**、**结构体**、**枚举**和**协议**添加新功能。通过扩展，咱们可以在不修改原有代码的情况下，增强类型的功能。

//: ### 2.1 扩展基础类型
//: 可以使用 `extension` 关键字向基础类型添加新功能：
// 向 Int 类型添加一个计算平方的方法
extension Int {
    func squared() -> Int {
        return self * self
    }
}

// 测试扩展
let number = 4
print("\(number) 的平方是 \(number.squared())")  // 输出 "4 的平方是 16"

//: ### 2.2 扩展自定义类型
//: 可以使用扩展向自定义类型添加新功能：
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

//: ### 2.3 扩展协议
//: 扩展不仅可以用于**类**、**结构体**和**枚举**，还可以用于协议。通过扩展协议，可以为遵循该协议的所有类型提供默认实现：

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

//: ## 3. 案例：综合协议和扩展
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
