import Foundation

//: ## 1. 内存管理
//: Swift 使用**自动引用计数**（ARC）来管理应用程序的内存。ARC 会自动跟踪和管理你的应用程序的内存使用情况，确保不再需要的类实例会被自动释放。
//: ### 1.1 强引用循环
//: 当两个类实例互相保持对方的强引用时，会导致**强引用循环**，从而导致内存泄漏。可以使用**弱引用**（`weak`）或**无主引用**（`unowned`）来打破强引用循环。
class Person {
    var name: String
    weak var apartment: Apartment?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 被释放")
    }
}

class Apartment {
    var unit: String
    unowned var tenant: Person
    
    init(unit: String, tenant: Person) {
        self.unit = unit
        self.tenant = tenant
    }
    
    deinit {
        print("单元 \(unit) 被释放")
    }
}

var john: Person? = Person(name: "John Appleseed")
var unit4A: Apartment? = Apartment(unit: "4A", tenant: john!)

john?.apartment = unit4A

john = nil
unit4A = nil

//: #### deinit 方法
//: `deinit` 方法是析构方法，当对象被释放时会自动调用。可以在 `deinit` 方法中执行清理操作，例如释放资源或打印调试信息。
class ExampleClass {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 被释放")
    }
}

var example: ExampleClass? = ExampleClass(name: "示例")
example = nil  // 当对象被释放时，会调用 deinit 方法

//: ## 2. 多线程
//: Swift 提供了多种方式来实现**多线程**，如使用 GCD（Grand Central Dispatch）和操作队列。多线程可以提高应用程序的响应速度和性能。
//: ### 2.1 GCD
//: GCD 是一个强大的工具，用于在多核设备上执行并发代码。可以使用全局队列或自定义队列来执行任务。
//: #### 全局队列和主队列
// 使用全局队列执行异步任务
DispatchQueue.global().async {
    for i in 1...5 {
        print("异步任务 \(i)")
    }
}

// 使用主队列更新 UI
DispatchQueue.main.async {
    print("更新 UI")
}

//: #### 自定义队列
// 可以创建自定义队列以更好地控制任务执行。
let customQueue = DispatchQueue(label: "com.example.customQueue")

customQueue.async {
    for i in 1...5 {
        print("自定义队列任务 \(i)")
    }
}

//: ### 2.2 操作队列
// 操作队列提供了更高层次的抽象，用于管理和协调并发操作。操作队列基于操作（Operation）来管理任务，支持依赖关系和取消操作。
let queue = OperationQueue()

let operation1 = BlockOperation {
    print("操作 1")
}

let operation2 = BlockOperation {
    print("操作 2")
}

operation2.addDependency(operation1)

queue.addOperations([operation1, operation2], waitUntilFinished: false)

//: ## 3. 案例：并发任务管理器
// 定义任务管理器类
class TaskManager {
    private let queue = OperationQueue()
    
    func addTask(_ task: @escaping () -> Void) {
        let operation = BlockOperation(block: task)
        queue.addOperation(operation)
    }
    
    func executeTasks() {
        queue.waitUntilAllOperationsAreFinished()
    }
}

// 测试任务管理器
let manager = TaskManager()

manager.addTask {
    print("任务 1 正在执行")
    sleep(1)
}

manager.addTask {
    print("任务 2 正在执行")
    sleep(2)
}

manager.addTask {
    print("任务 3 正在执行")
    sleep(3)
}

manager.executeTasks()
print("所有任务执行完毕")
