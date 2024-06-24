import UIKit

//: ## 1. 基本语法
//: ### 1.1 注释
//: **注释**用于解释代码，Swift 支持单行注释和多行注释。
// 这是单行注释

/*
 这是多行注释
 你可以在这里编写多行内容
*/

//: ### 1.2 字面量
//: **字面量**是指在代码中直接表示现实生活中的信息（数据）的固定值。
42                  // 整数
3.14                // 小数
"Hello World"       // 字符串
true                // 布尔值

//: ### 1.3 常量和变量
//: 在 Swift 中，使用 `let` 声明常量，使用 `var` 声明变量。常量的值在声明后不能更改，而变量的值可以随时更改。
let constantValue = 10
var variableValue = 20
variableValue = 30  // 变量保存的数据可以被修改

//: ### 1.4 数据类型
//: Swift 提供了多种**基本数据类型**，包括 `Int`（整数）、`Double`（浮点数）、`Bool`（布尔值）和 `String`（字符串），在定义常量或变量时，可以使用**类型注释**来明确变量或常量中保存数据的类型。
let age: Int = 25
let height: Double = 1.75
let isStudent: Bool = true
let name: String = "Alice"

//: ### 1.5 类型注释与类型推断
//: 在声明时可以使用**类型注释**来明确变量或常量中保存数据的类型，但 Swift 也能通过赋值来推断类型。
let explicitType: Double = 70.5  // 明确类型注释
let inferredType = 70.5          // 类型推断为 Double

//: ## 2. 基本操作
//: ### 2.1 输出与输入
//: 使用 `print` 函数可以输出**字面量**、**常量**或**变量**的值。
print("Hello, Swift!")
print("Age:", age)
print("variableValue", variableValue)

//: ### 2.2 字符串操作
//: 可以通过 `+` **拼接**或 `\(变量名)` **插值**来操作字符串。
let greeting = "Hello"
let message = greeting + ", Swift!"
let interpolatedMessage = "\(greeting), Swift!"
print(message)
print(interpolatedMessage)

//: ### 2.3 数值运算
//: Swift 支持基本的算术运算，并且可以进行类型转换。
let sum = 10 + 5        // 加法
let product = 10 * 5    // 乘法
let quotient = 10.0 / 3.0  // 除法（浮点数）
let integerDivision = 10 / 3  // 整数除法
let remainder = 10 % 3   // 取余

let doubleValue = Double(sum)  // 类型转换
print(quotient)
print(remainder)

//: ## 3. 控制流
//: ### 3.1 条件语句
//: 使用 `if` 和 `switch` 语句可以实现条件控制。

let score = 85
if score >= 90 {
    print("Grade: A")
} else if score >= 80 {
    print("Grade: B")
} else {
    print("Grade: C")
}

let grade = "B"
switch grade {
case "A":
    print("Excellent!")
case "B":
    print("Good!")
default:
    print("Keep trying!")
}

//: ### 3.2 循环语句
//: 使用 `for` 和 `while` 循环可以重复执行代码块。
for i in 1...5 {
    print("Number: \(i)")
}

var count = 5
while count > 0 {
    print("Countdown: \(count)")
    count -= 1
}

//: ## 4. 函数
//: ### 4.1 函数的定义与调用
//: 函数是执行特定任务的代码块，使用 `func` 关键字定义。函数可以接受**参数**并**返回值**。
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

let greetingMessage = greet(person: "Alice")
print(greetingMessage)

//: ### 4.2 函数参数与返回值
//: 函数可以接受多个参数，并返回一个值。参数和返回值的类型需要在函数定义中明确指出。
func add(a: Int, b: Int) -> Int {
    return a + b
}

let sumResult = add(a: 5, b: 3)
print("Sum: \(sumResult)")

//: ### 4.3 内嵌函数与闭包
//: 函数可以嵌套定义，内嵌函数只能在其外部函数中使用。闭包是可以捕获和存储其所在环境的变量和常量的自包含代码块。
func makeIncrementer(incrementAmount: Int) -> () -> Int {
    var total = 0
    func incrementer() -> Int {
        total += incrementAmount
        return total
    }
    return incrementer
}

let incrementByTwo = makeIncrementer(incrementAmount: 2)
print(incrementByTwo())  // 输出 2
print(incrementByTwo())  // 输出 4

//: ## 5. 可选值
//: 可选值用于处理**可能为空**的情况。使用 `!` 进行强制解包，或使用可选绑定来安全地解包可选值。
let optionalName: String? = "Alice"
print(optionalName!)  // 强制解包

if let name = optionalName {
    print("Hello, \(name)")
} else {
    print("No name found")
}

let defaultName = optionalName ?? "Unknown"  // nil 合并运算符
print(defaultName)

//: ## 6. 断言与前置条件
//: **断言**用于开发阶段检查，**前置条件**用于确保重要条件在运行时成立。
let myAge = 18
assert(myAge >= 0, "A person's age can't be less than zero.")

let index = 10
precondition(index >= 0, "Index must be greater than or equal to zero.")

//: ## 7. 错误处理
//: ### 7.1 定义错误
//: 定义一个符合 `Error` 协议的类型来表示错误。
enum CalculationError: Error {
    case divisionByZero
}

//: ### 7.2 抛出和捕获错误
//: 使用 `throw` 关键字抛出错误，并在调用函数时使用 `do-catch` 结构捕获和处理错误。
func divide(_ a: Double, by b: Double) throws -> Double {
    if b == 0 {
        throw CalculationError.divisionByZero
    }
    return a / b
}

do {
    let result = try divide(10, by: 0)
    print("Result: \(result)")
} catch CalculationError.divisionByZero {
    print("Error: Division by zero is not allowed.")
} catch {
    print("An unexpected error occurred: \(error).")
}

//: ### 7.3 处理可选错误
//: 如果确定不会有错误抛出，可以使用 `try?` 或 `try!`。
let result1 = try? divide(10, by: 0)  // 返回 nil
let result2 = try! divide(10, by: 2)  // 确定不会抛出错误
print(result2)

//: ## 8. 实战案例：简单的计算器
// 定义变量与常量
let number1: Double = 10
let number2: Double = 5
let operation: String = "+"

// 函数：执行运算
func calculate(_ a: Double, _ b: Double, operation: String) -> Double? {
    switch operation {
    case "+":
        return a + b
    case "-":
        return a - b
    case "*":
        return a * b
    case "/":
        assert(b != 0, "Division by zero is undefined.")
        return a / b
    default:
        return nil
    }
}

// 执行运算
if let result = calculate(number1, number2, operation: operation) {
    print("Result: \(result)")
} else {
    print("Invalid operation")
}
