//
//  StateExampleView.swift
//  SwiftUITaskManager
//
//  Created by 黑马程序员 on 2024/7/7.
//

import SwiftUI

/// ### 2.1 @State 属性包装器
struct StateExampleView: View {
    @State private var counter = 0      // 定义计数状态变量
    
    var body: some View {
        VStack {
            Text("计数器: \(counter)")
                .font(.largeTitle)
            Button(action: {
                counter += 1            // 点击按钮计数状态变量 + 1
            }) {
                Text("增加")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    StateExampleView()
}
