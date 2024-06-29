//
//  ContentView.swift
//  SwiftUITaskManager
//
//  Created by 黑马程序员 on 2024/6/28.
//

import SwiftUI

/// 1.1 @State 属性包装器
//struct ContentView: View {
//    @State private var count = 0  // 定义一个计数状态变量
//    
//    var body: some View {
//        VStack {
//            Text("计数: \(count)")
//                .font(.largeTitle)
//            Button(action: {
//                count += 1  // 点击按钮时修改计数状态变量
//            }) {
//                Text("增加计数")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//    }
//}

/// 1.2 @Binding 属性包装器
struct ContentView: View {
    @State private var isOn = false // ① 定义一个开关状态变量
    
    var body: some View {
        ToggleView(isOn: $isOn) // ④ 使用 $isOn 将绑定的状态传递给子视图
    }
}

struct ToggleView: View {
    @Binding var isOn: Bool // ② 使用 @Binding 接收父视图传递的开关状态
    
    var body: some View {
        Toggle("开关", isOn: $isOn)  // ③ 绑定状态到开关控件
            .padding()
    }
}

/// 1.3 @ObservableObject 和 @StateObject 属性包装器
class TimerModel: ObservableObject {
    @Published var time: Int = 0  // 定义一个发布的属性
    
    func start() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.time += 1  // 每秒增加一次计数
        }
    }
}

struct TimerView: View {
    @StateObject private var timerModel = TimerModel()  // 创建一个本地状态对象
    
    var body: some View {
        VStack {
            Text("时间: \(timerModel.time)")
                .font(.largeTitle)
            Button(action: {
                timerModel.start()  // 点击按钮时启动计时器
            }) {
                Text("开始计时")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

/// 2.1 单向数据流
//struct ParentView: View {
//    @State private var count = 0    // 定义一个本地状态变量
//    
//    var body: some View {
//        ChildView(count: count) // 传递状态给子视图
//    }
//}
//
//struct ChildView: View {
//    let count: Int  // 接收父视图传递的状态
//    
//    var body: some View {
//        Text("计数: \(count)")    // 显示计数值
//            .padding()
//    }
//}

/// 2.2 双向绑定
//struct ParentView: View {
//    @State private var count = 0    // 定义一个本地状态变量
//    
//    var body: some View {
//        ChildView(count: $count)    // 传递绑定状态给子视图
//    }
//}
//
//struct ChildView: View {
//    @Binding var count: Int // 接收父视图传递的绑定状态
//    
//    var body: some View {
//        VStack {
//            Text("计数: \(count)")    // 显示计数值
//            Button(action: {
//                count += 1  // 点击按钮时增加计数
//            }) {
//                Text("增加计数")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//    }
//}

/// 2.3 状态的传播与依赖
class SharedData: ObservableObject {
    @Published var value: String = ""  // 定义一个发布的属性
}

struct ParentView: View {
    @StateObject private var sharedData = SharedData()  // 创建一个本地状态对象
    
    var body: some View {
        VStack {
            ChildView1(sharedData: sharedData)  // 传递状态对象给子视图1
            ChildView2(sharedData: sharedData)  // 传递状态对象给子视图2
        }
    }
}

struct ChildView1: View {
    @ObservedObject var sharedData: SharedData  // 接收父视图传递的状态对象
    
    var body: some View {
        TextField("输入一些文字", text: $sharedData.value)  // 绑定状态到文本输入框
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
}

struct ChildView2: View {
    @ObservedObject var sharedData: SharedData  // 接收父视图传递的状态对象
    
    var body: some View {
        Text("你输入的是: \(sharedData.value)")  // 显示输入的文字
            .padding()
    }
}

#Preview {
    ParentView()
}
