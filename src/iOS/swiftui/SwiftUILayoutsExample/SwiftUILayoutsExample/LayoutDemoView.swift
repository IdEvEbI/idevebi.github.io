//
//  LayoutDemoView.swift
//  SwiftUILayoutsExample
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

struct LayoutDemoView: View {
    var body: some View {
        /// ### 3.1 对齐方式
        VStack(alignment: .leading) {
            Text("上方文本")
            Text("中间文本")
            Text("下方文本")
        }
        .padding()                      // 为 VStack 添加内边距
        .background(.blue)              // 设置背景色
        /// ### 3.2 间距
        HStack(spacing: 20) {
            Text("左侧文本")
            Text("中间文本")
            Text("右侧文本")
        }
        .padding()                      // 为 HStack 添加内边距
        .background(.green)             // 设置背景色
        /// ### 3.3 GeometryReader
        GeometryReader { geometry in
            VStack {
                Text("父视图宽度: \(geometry.size.width)")
                Text("父视图高度: \(geometry.size.height)")
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)    // 设置 VStack 的宽度和高度与父视图一致
        }
        .padding()
        .background(.gray)
        /// ### 4.3 使用自定义容器视图
        TwoColumnView(leftTitle: "左列标题", rightTitle: "右列标题", leftContent: {
            Text("左列项目 1")
            Text("左列项目 2")
        }, rightContent: {
            Text("右列项目 1")
            Text("右列项目 2")
        })
        .padding()
        .background(.green)
        /// ## 5. 布局优先级
        HStack {
            Text("低优先级").background(.red)
            Text("低优先级").background(.green)
            Text("低优先级").background(.yellow)
            Text("低优先级").background(.orange)
            Text("高优先级")
                .layoutPriority(1)
                .background(Color.blue)
        }
        .frame(height: 50)
        .padding()
    }
}

#Preview {
    LayoutDemoView()
}
