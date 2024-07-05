//
//  TaskView.swift
//  SwiftUITaskManager
//
//  Created by 黑马程序员 on 2024/6/29.
//

import SwiftUI

/// 任务
class Task: Identifiable, ObservableObject {
    let id = UUID()                     // 唯一标识符
    @Published var title: String        // 任务标题
    @Published var isCompleted: Bool    // 是否完成
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

/// 任务管理器
class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []   // 任务数组
    
    func addTask(title: String) {
        let newTask = Task(title: title)
        tasks.append(newTask)           // 添加新任务到任务数组
    }
    
    func removeTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)    // 从任务数组中移除任务
    }
}

/// 任务视图
struct TaskView: View {
    @StateObject private var taskManager = TaskManager()  // 任务管理器状态
    @State private var newTaskTitle = ""                  // 新任务标题状态
    
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
                        TaskRow(task: task)  // 使用 TaskRow 组件来展示任务
                    }
                    .onDelete(perform: taskManager.removeTask)  // 支持删除任务
                }
                .navigationTitle("任务管理器")
            }
        }
    }
}

struct TaskRow: View {
    @ObservedObject var task: Task  // 观察 Task 对象的变化
    
    var body: some View {
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
}

#Preview {
    TaskView()
}
