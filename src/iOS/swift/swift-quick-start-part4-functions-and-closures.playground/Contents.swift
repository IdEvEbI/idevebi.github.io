import Foundation

//: ## 1. 函数
//: ### 1.1 定义和调用函数
//: 函数使用 `func` 关键字**定义**。函数可以接受**参数**并**返回**值。
// 定义一个简单的函数
func sayHello() {
    print("你好，世界！")
}

// 调用函数
sayHello()  // 输出 "你好，世界！"

//: 函数可以接受**参数**并**返回值**。
// 定义一个带参数和返回值的函数
func add(a: Int, b: Int) -> Int {
    return a + b
}

// 调用函数
let sum = add(a: 5, b: 3)
print("和为 \(sum)")  // 输出 "和为 8"

//: ### 1.2 参数和返回值
//: 函数可以有多个**参数**和**返回值**。
// 定义一个带多个参数的函数
func greet(name: String, age: Int) -> String {
    return "你好，我叫 \(name)，今年 \(age) 岁。"
}

// 调用函数
let greeting = greet(name: "张三", age: 30)
print(greeting)  // 输出 "你好，我叫 张三，今年 30 岁。"

//: ### 1.3 参数标签和默认参数值
//: **参数标签**用于在调用函数时更清晰地表示参数的含义。可以为参数设置**默认值**。
// 定义一个带参数标签和默认值的函数
func introduce(name: String, from city: String = "北京") {
    print("大家好，我是 \(name)，来自 \(city)。")
}

// 调用函数
introduce(name: "李四")  // 输出 "大家好，我是 李四，来自 北京。"
introduce(name: "王五", from: "上海")  // 输出 "大家好，我是 王五，来自 上海。"

//: ### 1.4 可变参数
//: 函数可以接受数量**可变**的参数。
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

//: ## 2. 闭包
//: ### 2.1 闭包表达式
//: **闭包表达式**是一种简洁的闭包语法，可以定义未命名的内联闭包。
// 使用闭包表达式进行排序
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

let sortedNames = names.sorted { (name1: String, name2: String) -> Bool in
    return name1 < name2
}

print(sortedNames)  // 输出 ["Alex", "Barry", "Chris", "Daniella", "Ewa"]

//: ### 2.2 尾随闭包
//: **尾随闭包**是一种语法糖，用于在函数调用时更简洁地表示闭包。
// 使用尾随闭包进行排序
let reversedNames = names.sorted { name1, name2 in
    name1 > name2
}

print(reversedNames)  // 输出 ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

//: ### 2.3 捕获值
//: 闭包可以捕获并存储其所在上下文中的变量和常量。
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

//: ## 3. 案例：简单的任务管理器
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
