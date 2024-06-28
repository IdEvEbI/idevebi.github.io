# Swift 学习日志（3）：面向对象与结构体

在本篇文章中，咱们将探讨 Swift 中的**面向对象编程（OOP）**与**结构体（Struct）**。这两者是 Swift 中的核心概念，广泛用于构建复杂的应用程序。

## 1. 面向对象编程（OOP）

面向对象编程是一种编程范式，它将代码组织成具有**属性**和**行为**的对象。Swift 提供了强大的 OOP 支持，包括**类（Class）**、**继承**、**方法**和**属性**等。

**属性**代表对象包含的数据，而**方法**则是对这些数据进行操作的行为。通过面向对象的编程范式，可以有效地封装数据和行为，实现更好的模块化和隔离性。

### 1.1 定义类

类是面向对象编程的核心，可以定义**属性**和**方法**，类的**实例**称为**对象**。**初始化方法（init）**是类的特殊方法，用于在创建对象时初始化其属性。

```swift
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func greet() {
        print("你好，我的名字叫 \(name)，年龄 \(age) 岁。")
    }
}

// 创建对象
let person = Person(name: "张三", age: 30)
person.greet()  // 输出 "你好，我的名字叫 张三，年龄 30 岁。"
```

**init** 方法在对象创建时自动执行，用于设置对象的初始状态。每当调用 `Person(name:age:)` 创建新对象时，`init` 方法都会被执行，以确保对象的所有属性都被正确初始化。

### 1.2 继承

继承是 OOP 的重要特性，一个类可以继承另一个类的**属性**和**方法**。在子类的初始化过程中，必须先调用父类的初始化方法 `super.init`。

```swift
class Student: Person {
    var studentID: Int
    
    init(name: String, age: Int, studentID: Int) {
        self.studentID = studentID
        super.init(name: name, age: age)
    }
    
    override func greet() {
        print("你好，我的名字叫 \(name)，年龄 \(age) 岁，学号 \(studentID)。")
    }
}

let student = Student(name: "李四", age: 20, studentID: 12345)
student.greet()  // 输出 "你好，我的名字叫 李四，年龄 20 岁，学号 12345。"
```

在子类的 `init` 方法中，`super.init` 必须在子类初始化完成其自身属性之后立即调用，用于初始化父类的属性。如果子类没有调用 `super.init`，父类的属性将不会被正确初始化，可能会导致运行时错误。

### 1.3 属性和方法

类可以包含**属性**和**方法**，**属性**用于存储值，**方法**用于定义行为。

```swift
class Car {
    var brand: String
    var speed: Int = 0
    
    init(brand: String) {
        self.brand = brand
    }
    
    func accelerate() {
        speed += 10
        print("\(brand) 车现在的车速是 \(speed) 公里/小时。")
    }
}

let car = Car(brand: "比亚迪")
car.accelerate()  // 输出 "比亚迪 车现在的车速是 10 公里/小时。"
car.accelerate()  // 输出 "比亚迪 车现在的车速是 20 公里/小时。"
```

## 2. 结构体（Struct）

结构体与类类似，但有一些重要的区别。**结构体**是**值类型**，而**类**是**引用类型**。值类型在赋值或传递时会创建一个副本，而引用类型则不会。

### 2.1 定义结构体

结构体也可以定义**属性**和**方法**。

```swift
struct DevBook {
    var title: String
    var author: String
    
    func description() {
        print("《\(title)》 作者： \(author)")
    }
}

let book = DevBook(title: "Swift 编程", author: "Apple")
book.description()  // 输出 "《Swift 编程》 作者： Apple"
```

### 2.2 结构体的初始化

结构体有一个自动生成的成员初始化器，允许直接为所有**属性**赋值。

```swift
struct Rectangle {
    var width: Int
    var height: Int
    
    func area() -> Int {
        return width * height
    }
}

let rectangle = Rectangle(width: 10, height: 20)
print("面积： \(rectangle.area())")  // 输出 "面积： 200"
```

### 2.3 结构体的可变方法

默认情况下，结构体的**属性**是不可变的。如果需要修改**属性**，可以在**方法**前加上 `mutating` 关键字。

```swift
struct Circle {
    var radius: Double
    
    mutating func enlarge(by factor: Double) {
        radius *= factor
    }
}

var circle = Circle(radius: 5.0)
circle.enlarge(by: 2.0)
print("放大后的半径： \(circle.radius)")  // 输出 "放大后的半径： 10.0"
```

## 3. 类与结构体的选择

在 Swift 中，选择使用**类**还是**结构体**取决于具体需求：

- 使用**类**：
  - 当需要继承其他类的**属性**和**行为**时。
  - 当需要在多个地方引用同一个实例时。

- 使用**结构体**：
  - 当需要简单的数据结构，并且**值传递**更合适时。
  - 当不需要继承时。

## 4. 案例：图书馆系统

### 4.1 案例简介

咱们将创建一个简单的图书馆系统，使用**类**和**结构体**来定义不同的书籍和借阅记录，并实现添加和查询书籍的功能。

### 4.2 实现步骤

1. **定义书籍类**：定义一个 `Book` 类，包含书籍的基本信息。
2. **定义借阅记录结构体**：定义一个结构体 `BorrowRecord`，包含借阅记录的信息。
3. **实现图书馆类**：实现一个 `Library` 类，用于管理书籍和借阅记录。

### 4.3 代码示例

```swift
import Foundation

// 定义书籍类
class Book {
    var title: String
    var author: String
    var isAvailable: Bool
    
    init(title: String, author: String, isAvailable: Bool = true) {
        self.title = title
        self.author = author
        self.isAvailable = isAvailable
    }
}

// 定义借阅记录结构体
struct BorrowRecord {
    var book: Book
    var borrower: String
    var borrowDate: Date
    var returnDate: Date?
}

// 定义图书馆类
class Library {
    var books: [Book] = []
    var borrowRecords: [BorrowRecord] = []
    
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    func borrowBook(title: String, borrower: String) -> Bool {
        if let book = books.first(where: { $0.title == title && $0.isAvailable }) {
            book.isAvailable = false
            let record = BorrowRecord(book: book, borrower: borrower, borrowDate: Date(), returnDate: nil)
            borrowRecords.append(record)
            return true
        }
        return false
    }
    
    func returnBook(title: String, borrower: String) -> Bool {
        if let index = borrowRecords.firstIndex(where: { $0.book.title == title && $0.borrower == borrower && $0.returnDate == nil }) {
            borrowRecords[index].book.isAvailable = true
            borrowRecords[index].returnDate = Date()
            return true
        }
        return false
    }
    
    func listAvailableBooks() {
        for book in books where book.isAvailable {
            print("《\(book.title)》 作者： \(book.author)")
        }
    }
}

// 测试图书馆系统
let library = Library()
let book1 = Book(title: "Swift 编程", author: "苹果")
let book2 = Book(title: "iOS 开发", author: "壹刀流")

library.addBook(book1)
library.addBook(book2)

print("可借阅书籍：")
library.listAvailableBooks()  // 输出 "《Swift 编程》 作者： 苹果" 和 "《iOS 开发》 作者： 壹刀流"

library.borrowBook(title: "Swift 编程", borrower: "张三")
print("借书后可借阅书籍：")
library.listAvailableBooks()  // 只输出 "《iOS 开发》 作者： 壹刀流"

library.returnBook(title: "Swift 编程", borrower: "张三")
print("还书后可借阅书籍：")
library.listAvailableBooks()  // 输出 "《Swift 编程》 作者： 苹果" 和 "《iOS 开发》 作者： 壹刀流"
```

## 5. 结语

在这篇文章中，我们深入探讨了 Swift 的**面向对象编程**和**结构体**，并通过一个简单的图书馆系统案例将所学知识应用到实践中。希望你对 Swift 的 OOP 和结构体有了更深入的理解。下一篇文章将进一步探讨 Swift 的函数和闭包，敬请期待！

> 本专栏文档及配套代码的 GitHub 地址：[壹刀流的技术人生](https://github.com/IdEvEbI/idevebi.github.io)。
