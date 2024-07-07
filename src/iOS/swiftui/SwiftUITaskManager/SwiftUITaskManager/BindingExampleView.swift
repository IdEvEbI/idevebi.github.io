//
//  BindingExampleView.swift
//  SwiftUITaskManager
//
//  Created by 黑马程序员 on 2024/7/7.
//

import SwiftUI

/// ### 2.2 @Binding 属性包装器
struct BindingExampleView: View {
    @State private var isOn = false         // 定义开关状态变量
    
    var body: some View {
        VStack {
            Text(isOn ? "开" : "关").font(.largeTitle)
            BindingToggleView(isOn: $isOn)  // $状态名 向子视图传递状态
        }
    }
}

/// 绑定开关视图
struct BindingToggleView: View {
    @Binding var isOn: Bool                 // 接收父视图传递的状态
    
    var body: some View {
        Toggle("开关", isOn: $isOn)          // 绑定状态到控件
            .padding()
    }
}

#Preview {
    BindingExampleView()
}
