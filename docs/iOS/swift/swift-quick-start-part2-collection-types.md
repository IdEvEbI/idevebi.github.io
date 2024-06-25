# ChatGPT iOS 学习日志（2）：集合类型

在本篇文章中，咱们将探讨 Swift 中的集合类型。这些类型是 Swift 编程的重要组成部分，用于存储和管理数据。Swift 提供了三种主要的集合类型：**数组（Array）**、**集合（Set）**和**字典（Dictionary）**。

## 1. 集合类型

集合类型是用于存储和组织数据的容器。每种集合类型都有其独特的特点和适用场景，帮助开发者更有效地管理数据。集合类型的定义如下：

- **数组（Array）**：一个**有序**、**可以重复**的数据集合，**存储相同类型的元素**。
  - **示例**：存储一周七天的名称。

  ```swift
  let daysOfWeek: [String] = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"]
  ```

- **集合（Set）**：一个**无序**、**不可重复**的数据集合，**存储相同类型的元素**。
  - **示例**：存储一组不重复的学生ID。

  ```swift
  let studentIDs: Set<Int> = [101, 102, 103, 104, 105]
  ```

- **字典（Dictionary）**：一个**无序**的**键值对**集合，**每个键唯一对应一个值**。
  - **示例**：存储学生姓名和对应的成绩。
  
  ```swift
  let stuScores: [String: Int] = ["张三": 85, "李四": 90, "王五": 78]
  ```

## 2. 数组（Array）

### 2.1 定义数组

数组是有序的数据集合，存储相同类型的元素。可以使用方括号 `[]` 来定义数组，并通过**下标**访问元素。

> 提示：数组的下标计数从 `0` 开始，对应数组中的第一个元素。

```swift
var numbers: [Int] = [1, 2, 3, 4, 5]
let names: [String] = ["张三", "李四", "王五"]
```

### 2.2 操作数组

数组提供了多种操作方法，例如 `append` **添加**、`remove` **删除**和通过下标直接修改元素。

```swift
var fruits = ["香蕉", "苹果", "大鸭梨"]
fruits.append("西瓜")  // 添加元素
fruits.remove(at: 1)   // 删除元素
fruits[0] = "哈密瓜"  // 修改元素
print(fruits)
```

### 2.3 遍历数组

可以使用 `for-in` 循环遍历数组中的元素。

```swift
let cities = ["北京", "上海", "广州", "深圳"]
for city in cities {
    print("City: \(city)")
}
```

### 2.4 数组的特点和应用场景

- **特点**：有序性、可重复性、快速的随机访问。
- **应用场景**：适用于需要有序存储和频繁访问元素的场景，例如显示列表数据、管理任务队列等。数组支持通过下标进行快速访问和修改，非常适合需要频繁随机访问的业务需求。

## 3. 集合（Set）

### 3.1 定义集合

集合是无序且不重复的数据集合。可以使用构造器语法定义集合。

```swift
var uniqueNumbers: Set<Int> = [1, 2, 3, 1, 2]
print(uniqueNumbers)  // 输出 [2, 3, 1]
```

### 3.2 操作集合

集合提供了多种操作方法，例如 `insert` **添加**和 `remove` **删除**元素。

```swift
var colors: Set<String> = ["Red", "Green", "Blue"]
colors.insert("Yellow")  // 添加元素
colors.remove("Green")   // 删除元素
print(colors)
```

### 3.3 集合运算

集合支持常见的集合运算，例如 `union` **并集**、`intersection` **交集**和 `subtracting` **差集**。

```swift
let setA: Set = [1, 2, 3, 4]
let setB: Set = [3, 4, 5, 6]

let unionSet = setA.union(setB)         // 并集
let intersectionSet = setA.intersection(setB) // 交集
let differenceSet = setA.subtracting(setB)    // 差集

print("Union: \(unionSet)")
print("Intersection: \(intersectionSet)")
print("Difference: \(differenceSet)")
```

### 集合的特点和应用场景

- **特点**：无序性、不重复性、快速的插入和查找。
- **应用场景**：适用于需要确保元素唯一性且无需有序存储的场景，例如处理标签系统、管理用户权限等。集合提供高效的插入和查找操作，非常适合处理需要快速去重的业务需求。

## 4. 字典（Dictionary）

### 4.1 定义字典

字典是键值对的数据集合。可以使用方括号 `[:]` 来定义字典，并通过键访问值。

```swift
var person: [String: String] = ["name": "张三", "city": "北京"]
let scores: [String: Int] = ["Math": 95, "English": 88]
```

### 4.2 操作字典

字典提供了多种操作方法，例如 `updateValue` **添加或修改**和 `removeValue` **删除**键值对。

```swift
var capitals = ["中国": "北京", "美国": "纽约"]

capitals["法国"] = "巴黎"   // 添加键值对
capitals["美国"] = "洛杉矶"  // 修改键值对

capitals.updateValue("伦敦", forKey: "英国")  // 添加键值对
capitals.updateValue("华盛顿", forKey: "美国")  // 修改键值对
capitals.removeValue(forKey: "美国")  // 删除键值对
print(capitals)
```

### 4.3 遍历字典

可以使用 `for-in` 循环遍历字典中的键值对。

```swift
let countries = ["中国": "北京", "英国": "伦敦", "美国": "华盛顿"]
for (country, capital) in countries {
    print("\(country): \(capital)")
}
```

### 字典的特点和应用场景

- **特点**：键值对存储、无序性、快速查找。
- **应用场景**：适用于需要根据唯一标识符快速查找值的场景，例如存储用户信息、缓存数据等。字典提供高效的键值对存取操作，非常适合处理需要快速访问和更新数据的业务需求。

## 5. 集合类型的高级操作

### 5.1 筛选与映射

可以使用高阶函数 `filter` 和 `map` 对集合类型进行**筛选**和**映射**操作。

- **筛选**：筛选出满足特定条件的元素。

  ```swift
  let nums = [1, 2, 3, 4, 5, 6]
  let evenNumbers = nums.filter { $0 % 2 == 0 }  // 筛选偶数
  print(evenNumbers)  // 输出 [2, 4, 6]
  ```

- **映射**：将每个元素转换为另一种形式。

  ```swift
  let squaredNumbers = nums.map { $0 * $0 }  // 映射为平方
  print(squaredNumbers)  // 输出 [1, 4, 9, 16, 25, 36]
  ```

### 5.2 合并与排序

- **合并**：使用 `reduce` 函数将集合中的所有元素合并成一个值。`reduce` 方法通过一个初始值和一个组合闭包，将集合中的元素合并为一个值。例如，可以用它来求和。

  ```swift
  let nums = [1, 2, 3, 4, 5, 6]
  let sum = nums.reduce(0, { x, y in
      x + y
  })  // 合并求和
  print("Sum: \(sum)")  // 输出 Sum: 21
  ```

- **排序**：使用 `sorted` 方法将集合中的元素排序，`sorted` 方法会返回一个排序后的新数组。

  ```swift
  let unsortedNumbers = [3, 1, 4, 1, 5, 9, 2, 6, 5]
  let sortedNumbers = unsortedNumbers.sorted()  // 按升序排序
  print("Sorted: \(sortedNumbers)")  // 输出 Sorted: [1, 1, 2, 3, 4, 5, 5, 6, 9]
  ```

  可以自定义排序顺序，例如按降序排序：

  ```swift
  let reversedNumbers = unsortedNumbers.sorted(by: >)  // 按降序排序
  print("Reversed: \(reversedNumbers)")  // 输出 Reversed: [9, 6, 5, 5, 4, 3, 2, 1, 1]
  ```

## 6. 案例：学生成绩管理案例

### 6.1 案例简介

接下来，咱们将创建一个简单的学生成绩管理系统，使用数组、集合和字典来存储和管理学生及其成绩。

### 6.2 实现步骤

1. **定义数据结构**：使用字典存储学生及其成绩。
2. **实现功能**：实现添加学生、删除学生和显示所有学生成绩的功能。
3. **组织代码**：使用集合类型的高级操作简化代码，实现筛选和排序功能。

### 6.3 代码示例

```swift
import Foundation

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

let topStudents = filterTopStudents()
print("优等生名单: \(topStudents)")

let sortedList = sortedStudents()
print("成绩单排名: \(sortedList)")
```

## 7. 结语

在这篇文章中，我们深入探讨了 Swift 的集合类型，并通过一个学生成绩管理系统案例将所学知识应用到实践中。希望你对 Swift 的集合类型有了更深入的理解。下一篇文章将进一步探讨 Swift 的面向对象编程，敬请期待！

> 本专栏文档及配套代码的 GitHub 地址：[壹刀流的技术人生](https://github.com/IdEvEbI/idevebi.github.io)。
