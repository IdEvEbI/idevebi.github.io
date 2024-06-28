# Swift 学习日志（8）：Swift 的高级特性

在本篇文章中，咱们将探讨 Swift 的一些**高级特性**，这些特性能帮助我们编写更高效、更灵活的代码。这些特性包括**内存管理**、**自动引用计数**（ARC）、**多线程**等。

## 1. 内存管理

Swift 使用**自动引用计数**（ARC）来管理应用程序的内存。ARC 会自动跟踪和管理你的应用程序的内存使用情况，确保不再需要的类实例会被自动释放。

### 1.1 强引用循环

当两个类实例互相保持对方的强引用时，会导致**强引用循环**，从而导致内存泄漏。可以使用**弱引用**（`weak`）或**无主引用**（`unowned`）来打破强引用循环。

```swift
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
```

#### 弱引用和无主引用的区别

**弱引用**（`weak`）和**无主引用**（`unowned`）都可以打破强引用循环，但它们的使用场景有所不同：

- **弱引用**：当引用的对象可以在其生命周期中变为 `nil` 时使用。弱引用总是可选类型，当对象被释放时，弱引用会自动变为 `nil`。
- **无主引用**：当引用的对象在其生命周期中不会变为 `nil` 时使用。无主引用不是可选类型，当对象被释放时，无主引用不会自动变为 `nil`，如果在对象被释放后访问无主引用，会导致运行时错误。

#### deinit 方法

`deinit` 方法是析构方法，当对象被释放时会自动调用。可以在 `deinit` 方法中执行清理操作，例如释放资源或打印调试信息。

```swift
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
```

## 2. 多线程

Swift 提供了多种方式来实现**多线程**，如使用 GCD（Grand Central Dispatch）和操作队列。多线程可以提高应用程序的响应速度和性能。

### 2.1 GCD

GCD 是一个强大的工具，用于在多核设备上执行并发代码。可以使用全局队列或自定义队列来执行任务。

#### 全局队列和主队列

全局队列提供了多个优先级队列，适合执行各种并发任务。主队列则用于更新 UI 或执行需要在主线程上完成的任务。

```swift
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
```

#### 自定义队列

可以创建自定义队列以更好地控制任务执行。

```swift
let customQueue = DispatchQueue(label: "com.example.customQueue")

customQueue.async {
    for i in 1...5 {
        print("自定义队列任务 \(i)")
    }
}
```

### 2.2 操作队列

操作队列提供了更高层次的抽象，用于管理和协调并发操作。操作队列基于操作（Operation）来管理任务，支持依赖关系和取消操作。

#### 操作和操作队列

操作（Operation）是可以添加到操作队列（OperationQueue）中的基本单元。可以使用 `BlockOperation` 创建操作。

```swift
let queue = OperationQueue()

let operation1 = BlockOperation {
    print("操作 1")
}

let operation2 = BlockOperation {
    print("操作 2")
}

operation2.addDependency(operation1)

queue.addOperations([operation1, operation2], waitUntilFinished: false)
```

### 2.3 GCD 与操作队列对比

- **GCD**：适合简单的并发任务管理，使用方便，提供全局队列和主队列。
- **操作队列**：适合复杂的任务管理，支持依赖关系、取消操作和任务优先级。

### 开发中的选择

在开发中，如果任务之间没有复杂的依赖关系且不需要取消操作，可以优先选择 GCD，因为它更简单直接。如果任务之间存在依赖关系，需要更精细的控制和管理，可以选择操作队列。

## 3. 案例：并发任务管理器

### 3.1 案例简介

咱们将创建一个简单的并发任务管理器，演示如何使用 GCD 和操作队列来管理和执行并发任务。

### 3.2 实现步骤

1. **定义任务管理器类**：定义一个 `TaskManager` 类，用于管理并发任务。
2. **实现添加和执行任务的方法**：实现 `addTask` 和 `executeTasks` 方法。

### 3.3 代码示例

```swift
import Foundation

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
```

## 4. 结语

在这篇文章中，我们深入探讨了 Swift 的**高级特性**，包括**内存管理**和**多线程**，并通过一个简单的并发任务管理器案例将所学知识应用到实践中。希望你对 Swift 的高级特性有了更深入的理解。下一篇开始将进入 SwiftUI 专栏相关文章，让我们一起探索 iOS App 开发之旅。

> 本专栏文档及配套代码的 GitHub 地址：[壹刀流的技术人生](https://github.com/IdEvEbI/idevebi.github.io)。
