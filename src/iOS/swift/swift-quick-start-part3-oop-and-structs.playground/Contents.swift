import Foundation

//: ## 1. 面向对象编程（OOP）
//: ### 1.1 定义类
//: 类是面向对象编程的核心，可以定义**属性**和**方法**，类的**实例**称为**对象**。
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

//: ### 1.2 继承
//: 继承是 OOP 的重要特性，一个类可以继承另一个类的**属性**和**方法**。
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

//: ### 1.3 属性和方法
//: 类可以包含**属性**和**方法**，**属性**用于存储值，**方法**用于定义行为。
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

//: ## 2. 结构体（Struct）
//: ### 2.1 定义结构体
//: 结构体也可以定义**属性**和**方法**。
struct DevBook {
    var title: String
    var author: String
    
    func description() {
        print("《\(title)》 作者： \(author)")
    }
}

let book = DevBook(title: "Swift 编程", author: "Apple")
book.description()  // 输出 "《Swift 编程》 作者： Apple"

//: ### 2.2 结构体的初始化
//: 结构体有一个自动生成的成员初始化器，允许直接为所有**属性**赋值。
struct Rectangle {
    var width: Int
    var height: Int
    
    func area() -> Int {
        return width * height
    }
}

let rectangle = Rectangle(width: 10, height: 20)
print("面积： \(rectangle.area())")  // 输出 "面积： 200"

//: ### 2.3 结构体的可变方法
struct Circle {
    var radius: Double
    
    mutating func enlarge(by factor: Double) {
        radius *= factor
    }
}

var circle = Circle(radius: 5.0)
circle.enlarge(by: 2.0)
print("放大后的半径： \(circle.radius)")  // 输出 "放大后的半径： 10.0"

//: ## 4. 案例：图书馆系统
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

print("Available books:")
library.listAvailableBooks()  // 输出 "《Swift 编程》 作者： Apple" 和 "《iOS 开发》 作者： 壹刀流"

library.borrowBook(title: "Swift 编程", borrower: "张三")
print("可借阅书籍：")
library.listAvailableBooks()  // 只输出 "《iOS 开发》 作者： 壹刀流"

library.returnBook(title: "Swift 编程", borrower: "张三")
print("可借阅书籍：")
library.listAvailableBooks()  // 输出 "《Swift 编程》 作者： Apple" 和 "《iOS 开发》 作者： 壹刀流"
