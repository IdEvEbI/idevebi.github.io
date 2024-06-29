//
//  TaskView.swift
//  SwiftUITaskManager
//
//  Created by 黑马程序员 on 2024/6/29.
//

import SwiftUI

class Task: Identifiable, ObservableObject {
    let id = UUID()  // 定义一个唯一标识符
    @Published var title: String  // 定义一个发布的属性
    @Published var isCompleted: Bool  // 定义一个发布的属性
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []  // 定义一个任务数组并发布
    
    func addTask(title: String) {
        let newTask = Task(title: title)
        tasks.append(newTask)  // 添加新任务到任务数组
    }
    
    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)  // 从任务数组中移除任务
    }
}

struct TaskView: View {
    @StateObject private var taskManager = TaskManager()  // 创建一个本地状态对象
    @State private var newTaskTitle = ""  // 定义一个本地状态变量
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("输入任务", text: $newTaskTitle)  // 绑定状态到文本输入框
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        if !newTaskTitle.isEmpty {
                            taskManager.addTask(title: newTaskTitle)  // 添加新任务
                            newTaskTitle = ""  // 清空文本输入框
                        }
                    }) {
                        Text("添加")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                List {
                    ForEach(taskManager.tasks) { task in
                        HStack {
                            Text(task.title)
                            Spacer()
                            if task.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            task.isCompleted.toggle()  // 切换任务完成状态
                        }
                    }
                    .onDelete(perform: taskManager.removeTask)  // 支持删除任务
                }
                .navigationTitle("任务管理器")
            }
        }
    }
}

#Preview {
    TaskView()
}
