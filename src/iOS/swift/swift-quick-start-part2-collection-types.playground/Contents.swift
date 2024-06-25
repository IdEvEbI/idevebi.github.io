import Foundation

//: ## 1. 集合类型
//: **数组（Array）**：一个**有序**、**可以重复**的数据集合，**存储相同类型的元素**。
let daysOfWeek: [String] = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"]

//: **集合（Set）**：一个**无序**、**不可重复**的数据集合，**存储相同类型的元素**。
let studentIDs: Set<Int> = [101, 102, 103, 104, 105]

//: **字典（Dictionary）**：一个**无序**的**键值对**集合，**每个键唯一对应一个值**。
let stuScores: [String: Int] = ["张三": 85, "李四": 90, "王五": 78]

//: ## 2. 数组（Array）
//: ### 2.1 定义数组
//: 数组是有序的数据集合，存储相同类型的元素。可以使用方括号 `[]` 来定义数组，并通过**下标**访问元素。
var numbers: [Int] = [1, 2, 3, 4, 5]
let names: [String] = ["张三", "李四", "王五"]

//: ### 2.2 操作数组
//: 数组提供了多种操作方法，例如 `append` **添加**、`remove` **删除**和通过下标直接修改元素。
var fruits = ["香蕉", "苹果", "大鸭梨"]
fruits.append("西瓜")  // 添加元素
fruits.remove(at: 1)   // 删除元素
fruits[0] = "哈密瓜"  // 修改元素
print(fruits)

//: ### 2.3 遍历数组
//: 可以使用 `for-in` 循环遍历数组中的元素。
let cities = ["北京", "上海", "广州", "深圳"]
for city in cities {
    print("City: \(city)")
}

//: ## 3. 集合（Set）
//: ### 3.1 定义集合
//: 集合是无序且不重复的数据集合。可以使用构造器语法定义集合。
var uniqueNumbers: Set<Int> = [1, 2, 3, 1, 2]
print(uniqueNumbers)  // 输出 [2, 3, 1]

//: ### 3.2 操作集合
//: 集合提供了多种操作方法，例如 `insert` **添加**和 `remove` **删除**元素。
var colors: Set<String> = ["Red", "Green", "Blue"]
colors.insert("Yellow")  // 添加元素
colors.remove("Green")   // 删除元素
print(colors)

//: ### 3.3 集合运算
//: 集合支持常见的集合运算，例如 `union` **并集**、`intersection` **交集**和 `subtracting` **差集**。
let setA: Set = [1, 2, 3, 4]
let setB: Set = [3, 4, 5, 6]

let unionSet = setA.union(setB)         // 并集
let intersectionSet = setA.intersection(setB) // 交集
let differenceSet = setA.subtracting(setB)    // 差集

print("Union: \(unionSet)")
print("Intersection: \(intersectionSet)")
print("Difference: \(differenceSet)")

//: ## 4. 字典（Dictionary）
//: ### 4.1 定义字典
//: 字典是键值对的数据集合。可以使用方括号 `[:]` 来定义字典，并通过键访问值。
var person: [String: String] = ["name": "张三", "city": "北京"]
let scores: [String: Int] = ["Math": 95, "English": 88]

//: ### 4.2 操作字典
//: 字典提供了多种操作方法，例如 `updateValue` **添加或修改**和 `removeValue` **删除**键值对。
var capitals = ["中国": "北京", "美国": "纽约"]

capitals["法国"] = "巴黎"   // 添加键值对
capitals["美国"] = "洛杉矶"  // 修改键值对

capitals.updateValue("伦敦", forKey: "英国")  // 添加键值对
capitals.updateValue("华盛顿", forKey: "美国")  // 修改键值对
capitals.removeValue(forKey: "美国")  // 删除键值对
print(capitals)

//: ### 4.3 遍历字典
//: 可以使用 `for-in` 循环遍历字典中的键值对。
let countries = ["中国": "北京", "英国": "伦敦", "美国": "华盛顿"]
for (country, capital) in countries {
    print("\(country): \(capital)")
}

//: ## 5. 集合类型的高级操作
//: ### 5.1 筛选与映射
//: 可以使用高阶函数 `filter` 和 `map` 对集合类型进行**筛选**和**映射**操作。
let nums = [1, 2, 3, 4, 5, 6]
let evenNumbers = nums.filter { $0 % 2 == 0 }  // 筛选偶数
print(evenNumbers)  // 输出 [2, 4, 6]

let squaredNumbers = numbers.map { $0 * $0 }  // 映射为平方
print(squaredNumbers)  // 输出 [1, 4, 9, 16, 25, 36]

//: ### 5.2 合并与排序
//: **合并**：使用 `reduce` 函数将集合中的所有元素合并成一个值。`reduce` 方法通过一个初始值和一个组合闭包，将集合中的元素合并为一个值。例如，可以用它来求和。
let sum = nums.reduce(0, { x, y in
    x + y
})  // 合并求和
print("Sum: \(sum)")  // 输出 Sum: 21

//: **排序**：使用 `sorted` 方法将集合中的元素排序，`sorted` 方法会返回一个排序后的新数组。
let unsortedNumbers = [3, 1, 4, 1, 5, 9, 2, 6, 5]
let sortedNumbers = unsortedNumbers.sorted()  // 按升序排序
print("Sorted: \(sortedNumbers)")  // 输出 Sorted: [1, 1, 2, 3, 4, 5, 5, 6, 9]

let reversedNumbers = unsortedNumbers.sorted(by: >)  // 按降序排序
print("Reversed: \(reversedNumbers)")  // 输出 Reversed: [9, 6, 5, 5, 4, 3, 2, 1, 1]

//: ## 6. 案例：学生成绩管理案例
// 定义学生成绩字典
var studentScores: [String: Int] = ["张三": 85, "李四": 90, "王五": 78]

// 添加学生成绩
func addStudent(name: String, score: Int) {
    studentScores[name] = score
}

// 删除学生成绩
func removeStudent(name: String) {
    studentScores.removeValue(forKey: name)
}

// 显示所有学生成绩
func listStudentScores() {
    for (name, score) in studentScores {
        print("\(name): \(score)")
    }
}

// 筛选成绩大于 80 的学生
func filterTopStudents() -> [String] {
    return studentScores.filter { $0.value > 80 }.map { $0.key }
}

// 按成绩排序学生
func sortedStudents() -> [(String, Int)] {
    return studentScores.sorted { $0.value > $1.value }
}

// 测试功能
addStudent(name: "小明", score: 92)
removeStudent(name: "张三")
listStudentScores()

studentScores

let topStudents = filterTopStudents()
print("优等生名单: \(topStudents)")

let sortedList = sortedStudents()
print("成绩单排名: \(sortedList)")
