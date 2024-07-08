//
//  CustomView.swift
//  SwiftUIPersonCard
//
//  Created by 黑马程序员 on 2024/7/8.
//

import SwiftUI

/// ### 2.1 简单的自定义视图
struct CustomButton: View {
    var title: String                   // 按钮标题
    var action: () -> Void              // 按钮点击事件
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

//#Preview {
//    CustomButton(title: "点击我", action: {
//        print("按钮被点击了")
//    })
//}

/// ### 2.2 带有状态的自定义视图
struct CounterView: View {
    @State private var count = 0
    
    var body: some View {
        VStack {
            Text("计数器: \(count)")
                .font(.largeTitle)
            Button("增加") {
                count += 1
            }
            .font(.headline)
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

//#Preview {
//    CounterView()
//}

/// ### 2.3 带有绑定的自定义视图
/// 开关切换自定义视图
struct ToggleSwitch: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text("开关状态: \(isOn ? "开" : "关")")
        }
        .padding()
    }
}

/// 开关切换视图容器
struct ToggleSwitchContainer: View {
    @State private var isOn = true
    
    var body: some View {
        ToggleSwitch(isOn: $isOn)
    }
}

#Preview {
    ToggleSwitchContainer()
}
