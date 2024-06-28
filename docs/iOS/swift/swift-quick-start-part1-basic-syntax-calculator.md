# Swift 学习日志（1）：基础语法与简单计算器案例

本篇文章介绍 Swift 的基础语法，并通过一个简单的计算器案例来应用所学知识。Swift 是一门强大且易于学习的编程语言，广泛用于 iOS 开发。

## 1. 基础语法

### 1.1 注释

**注释**用于解释代码，Swift 支持单行注释和多行注释。

```swift
// 这是单行注释

/*
 这是多行注释
 你可以在这里编写多行内容
*/
```

> 提示：在 Playground 中使用 `//:` 可以使用 Markdown 语法编写注释。

### 1.2 字面量

**字面量**是指在代码中直接表示现实生活中的信息（数据）的固定值，例如：

- **数字字面量**，描述一个整数或者小数，例如：`42`，`3.14`
- **字符串字面量**，描述一段文字信息，例如：`"Hello, World!"`
- **布尔字面量**，描述逻辑的真假，包括：`true`，`false`

### 1.3 常量与变量

在 Swift 中，使用 `let` 声明**常量**，使用 `var` 声明**变量**。常量的值在声明后不能更改，而变量的值可以随时更改。

```swift
let constantValue = 10
var variableValue = 20
variableValue = 30
```

无论是常量还是变量，都可以用来存储数据，在后续需要时，代码通过**常量名**或**变量名**访问到保存在其中的数据。

> 提示：在实际开发中，可以优先用 `let` 定义常量来保存数据，在需要修改时，再修改为 `var`。

### 1.4 数据类型

Swift 提供了多种**基本数据类型**，包括 `Int`（整数）、`Double`（小数，又称浮点数）、`Bool`（布尔值）和 `String`（字符串），在定义常量或变量时，可以使用**类型注释**（`变量名: 类型`）来明确变量或常量中保存数据的类型。

```swift
let age: Int = 25
let height: Double = 1.75
let isStudent: Bool = true
let name: String = "Alice"
```

### 1.5 类型注释与类型推断

在声明时可以使用**类型注释**来明确变量或常量中保存数据的类型，但 Swift 也能通过赋值来推断类型。

```swift
let explicitType: Double = 70.5  // 明确类型注释
let inferredType = 70.5          // 类型推断为 Double
```

## 2. 基本操作

### 2.1 输出与输入

使用 `print` 函数可以输出**字面量**、**常量**或**变量**的值。

```swift
print("Hello, Swift!")
print("Age:", age)
print("variableValue", variableValue)
```

### 2.2 字符串操作

可以通过 `+` **拼接**或 `\(变量名)` **插值**来操作字符串。

```swift
let greeting = "Hello"
let message = greeting + ", Swift!"
let interpolatedMessage = "\(greeting), Swift!"
print(message)
print(interpolatedMessage)
```

### 2.3 数值运算

Swift 支持基本的算术运算，并且可以进行类型转换。

```swift
let sum = 10 + 5        // 加法
let product = 10 * 5    // 乘法
let quotient = 10.0 / 3.0  // 除法（浮点数）
let integerDivision = 10 / 3  // 整数除法
let remainder = 10 % 3   // 取余

let doubleValue = Double(sum)  // 类型转换
print(quotient)
print(remainder)
```

### 2.4 逻辑运算

Swift 支持基本的逻辑运算，用于布尔值的运算。

```swift
let isAdult = true
let hasPermission = false

let canEnter = isAdult && hasPermission  // 逻辑与
let canVote = isAdult || hasPermission   // 逻辑或
let isMinor = !isAdult                   // 逻辑非

print("Can Enter: \(canEnter)")  // 输出 false
print("Can Vote: \(canVote)")    // 输出 true
print("Is Minor: \(isMinor)")    // 输出 false
```

## 3. 控制流

### 3.1 条件语句

使用 `if` 和 `switch` 语句可以实现条件控制。

```swift
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
```

### 3.2 循环语句

使用 `for` 和 `while` 循环可以重复执行代码块。

```swift
for i in 1...5 {
    print("Number: \(i)")
}

var count = 5
while count > 0 {
    print("Countdown: \(count)")
    count -= 1
}
```

## 4. 函数

### 4.1 函数的定义与调用

函数是执行特定任务的代码块，使用 `func` 关键字定义。函数可以接受**参数**并**返回值**。

```swift
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

let greetingMessage = greet(person: "Alice")
print(greetingMessage)
```

### 4.2 函数参数与返回值

函数可以接受多个参数，并返回一个值。参数和返回值的类型需要在函数定义中明确指出。

```swift
func add(a: Int, b: Int) -> Int {
    return a + b
}

let sumResult = add(a: 5, b: 3)
print("Sum: \(sumResult)")
```

### 4.3 内嵌函数与闭包

函数可以嵌套定义，内嵌函数只能在其外部函数中使用。闭包是可以捕获和存储其所在环境的变量和常量的自包含代码块。

```swift
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
```

## 5. 可选值

可选值用于处理**可能为空**的情况。使用 `!` 进行强制解包，或使用可选绑定来安全地解包可选值。

```swift
let optionalName: String? = "Alice"
print(optionalName!)  // 强制解包

if let name = optionalName {
    print("Hello, \(name)")
} else {
    print("No name found")
}

let defaultName = optionalName ?? "Unknown"  // nil 合并运算符
print(defaultName)
```

## 6. 断言与前置条件

**断言**用于开发阶段检查，**前置条件**用于确保重要条件在运行时成立。

```swift
let myAge = 18
assert(myAge >= 0, "A person's age can't be less than zero.")

let index = 10
precondition(index >= 0, "Index must be greater than or equal to zero.")
```

## 7. 错误处理

Swift 提供了强大的错误处理机制，可以捕获和处理运行时错误，确保程序的稳定性和可靠性。

### 7.1 定义错误

首先，定义一个符合 `Error` 协议的类型来表示错误。

```swift
enum CalculationError: Error {
    case divisionByZero
}
```

### 7.2 抛出和捕获错误

然后，使用 `throw` 关键字在函数中抛出错误，并在调用函数时使用 `do-catch` 结构捕获和处理错误。

```swift
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
```

### 7.3 处理可选错误

如果确定不会有错误抛出，可以使用 `try?` 或 `try!`。

```swift
let result1 = try? divide(10, by: 0)  // 返回 nil
let result2 = try! divide(10, by: 2)  // 确定不会抛出错误
print(result2)
```

通过错误处理机制，可以更好地控制程序的执行流程，确保在发生错误时提供适当的处理措施，提高程序的稳定性和用户体验。

## 8. 实战案例：简单的计算器

### 8.1 案例简介

接下来，咱们将创建一个简单的计算器，处理基本的加减乘除运算。

### 8.2 实现步骤

1. **定义变量与常量**：声明需要的变量与常量。
2. **接受用户输入并进行基本运算**：编写函数接受用户输入，并根据选择进行运算。
3. **使用控制流处理不同的运算选择**：使用 `if` 或 `switch` 语句处理不同运算。
4. **使用断言与前置条件检查输入的有效性**：确保输入值有效。

### 8.3 代码示例

```swift
import Foundation

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
```

## 9. 结语

在这篇文章中，我们介绍了 Swift 的基础语法，并通过一个简单的计算器案例将所学知识应用到实践中。希望你对 Swift 有了初步的了解。下一篇文章将进一步探讨 Swift 的进阶概念，敬请期待！

> 本专栏文档及配套代码的 GitHub 地址：[壹刀流的技术人生](https://github.com/IdEvEbI/idevebi.github.io)。
