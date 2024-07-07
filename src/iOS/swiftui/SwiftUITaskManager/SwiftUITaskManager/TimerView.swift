//
//  TimerView.swift
//  SwiftUITaskManager
//
//  Created by 黑马程序员 on 2024/7/7.
//

import SwiftUI

/// ### 2.3 @ObservableObject 和 @StateObject 属性包装器
/// 计时器模型
class TimerModel: ObservableObject {
    @Published var timer: Int = 0       // 定义计时器发布的属性
    
    func start() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timer += 1             // 每秒计数器加一
        }
    }
}

/// 计时器视图
struct TimerView: View {
    @StateObject private var model = TimerModel()   // 本地计时器状态对象
    
    var body: some View {
        VStack {
            Text("时间: \(model.timer)")
                .font(.largeTitle)
            Button(action: {
                model.start()           // 点击按钮时启动计时器
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

#Preview {
    TimerView()
}
