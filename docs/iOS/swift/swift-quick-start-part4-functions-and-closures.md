# Swift 学习日志（4）：函数与闭包

在本篇文章中，咱们将探讨 Swift 中的**函数**和**闭包**。这两个概念是 Swift 编程的重要组成部分，广泛用于实现代码的模块化和复用。

## 1. 函数

**函数**是执行特定任务的自包含代码块。Swift 提供了强大的函数支持，包括**定义**、**调用**、**参数**、**返回值**等。

### 1.1 定义和调用函数

函数使用 `func` 关键字**定义**。函数可以接受**参数**并**返回**值。

```swift
// 定义一个简单的函数
func sayHello() {
    print("你好，世界！")
}

// 调用函数
sayHello()  // 输出 "你好，世界！"
```

函数可以接受**参数**并**返回值**。

```swift
// 定义一个带参数和返回值的函数
func add(a: Int, b: Int) -> Int {
    return a + b
}

// 调用函数
let sum = add(a: 5, b: 3)
print("和为 \(sum)")  // 输出 "和为 8"
```

### 1.2 参数和返回值

函数可以有多个**参数**和**返回值**。

```swift
// 定义一个带多个参数的函数
func greet(name: String, age: Int) -> String {
    return "你好，我叫 \(name)，今年 \(age) 岁。"
}

// 调用函数
let greeting = greet(name: "张三", age: 30)
print(greeting)  // 输出 "你好，我叫 张三，今年 30 岁。"
```

### 1.3 参数标签和默认参数值

**参数标签**用于在调用函数时更清晰地表示参数的含义。可以为参数设置**默认值**。

```swift
// 定义一个带参数标签和默认值的函数
func introduce(name: String, from city: String = "北京") {
    print("大家好，我是 \(name)，来自 \(city)。")
}

// 调用函数
introduce(name: "李四")  // 输出 "大家好，我是 李四，来自 北京。"
introduce(name: "王五", from: "上海")  // 输出 "大家好，我是 王五，来自 上海。"
```

### 1.4 可变参数

函数可以接受数量**可变**的参数。

```swift
// 定义一个带可变参数的函数
func sumOf(numbers: Int...) -> Int {
    var total = 0
    for number in numbers {
        total += number
    }
    return total
}

// 调用函数
let totalSum = sumOf(numbers: 1, 2, 3, 4, 5)
print("总和为 \(totalSum)")  // 输出 "总和为 15"
```

## 2. 闭包

**闭包**是自包含的功能代码块，可以在代码中被传递和使用。闭包可以捕获和存储其所在上下文中的变量和常量。

### 2.1 闭包表达式

**闭包表达式**是一种简洁的闭包语法，可以定义未命名的内联闭包。

```swift
// 使用闭包表达式进行排序
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

let sortedNames = names.sorted { (name1: String, name2: String) -> Bool in
    return name1 < name2
}

print(sortedNames)  // 输出 ["Alex", "Barry", "Chris", "Daniella", "Ewa"]
```

### 2.2 尾随闭包

**尾随闭包**是一种语法糖，用于在函数调用时更简洁地表示闭包。如果闭包是函数的最后一个参数，可以省略参数标签，直接在括号外书写闭包。并且如果闭包的函数体只有一个表达式，可以省略 `return` 关键字。

```swift
// 使用尾随闭包进行排序
let reversedNames = names.sorted { name1, name2 in
    name1 > name2
}

print(reversedNames)  // 输出 ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
```

### 2.3 捕获值

闭包可以捕获并存储其所在上下文中的变量和常量。

```swift
// 定义一个捕获值的闭包
func makeIncrementer(incrementAmount: Int) -> () -> Int {
    var total = 0
    return {
        total += incrementAmount
        return total
    }
}

// 使用闭包
let incrementByTen = makeIncrementer(incrementAmount: 10)
print(incrementByTen())  // 输出 "10"
print(incrementByTen())  // 输出 "20"
```

### 2.4 @escaping 关键字

在函数中，闭包作为参数传递时，如果闭包在函数返回之后才被调用，那么就需要使用 `@escaping` 关键字。这种情况通常发生在异步操作中，例如网络请求或任务调度器。

## 3. 案例：简单的任务管理器

### 3.1 案例简介

咱们将创建一个简单的任务管理器，使用**函数**和**闭包**来定义和管理任务，并实现添加和执行任务的功能。

### 3.2 实现步骤

1. **定义任务结构体**：定义一个 `Task` 结构体，包含任务的基本信息。
2. **定义任务管理器类**：定义一个 `TaskManager` 类，用于管理任务。
3. **实现功能**：实现添加任务和执行任务的功能。

### 3.3 @escaping 示例

在下面的任务管理器示例中，`addTask` 方法接受一个闭包作为参数，并将其存储在 `tasks` 数组中。因为闭包在函数返回之后才会被执行，所以需要使用 `@escaping` 关键字。

### 3.4 代码示例

```swift
import Foundation

// 定义任务结构体
struct Task {
    var name: String
    var action: () -> Void
}

// 定义任务管理器类
class TaskManager {
    var tasks: [Task] = []
    
    func addTask(name: String, action: @escaping () -> Void) {
        let task = Task(name: name, action: action)
        tasks.append(task)
    }
    
    func executeTasks() {
        for task in tasks {
            print("执行任务：\(task.name)")
            task.action()
        }
    }
}

// 测试任务管理器
let manager = TaskManager()
manager.addTask(name: "任务一") {
    print("任务一正在执行...")
}
manager.addTask(name: "任务二") {
    print("任务二正在执行...")
}

manager.executeTasks()
// 输出：
// 执行任务：任务一
// 任务一正在执行...
// 执行任务：任务二
// 任务二正在执行...
```

## 4. 结语

在这篇文章中，我们深入探讨了 Swift 的**函数**和**闭包**，并通过一个简单的任务管理器案例将所学知识应用到实践中。希望你对 Swift 的函数和闭包有了更深入的理解。下一篇文章将进一步探讨 Swift 的错误处理，敬请期待！

> 本专栏文档及配套代码的 GitHub 地址：[壹刀流的技术人生](https://github.com/IdEvEbI/idevebi.github.io)。
