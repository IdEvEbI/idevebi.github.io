//
//  ContentView.swift
//  SwiftUILayoutsExample
//
//  Created by 黑马程序员 on 2024/6/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("上方文本")
            Text("下方文本")
        }
        .padding()  // 为 VStack 添加内边距
        .background(Color.blue) // 设置背景色
        HStack(spacing: 20) {
            Text("左侧文本")
                .alignmentGuide(.leading) { d in d[.leading] }
            Text("右侧文本")
                .alignmentGuide(.leading) { d in d[.trailing] }
        }
        .padding()  // 为 HStack 添加内边距
        .background(Color.green) // 设置背景色
        ZStack {
            Text("底层文本")
            Text("顶层文本")
                .foregroundColor(.red)  // 设置顶层文本颜色为红色
        }
        .padding()  // 为 ZStack 添加内边距
        .background(Color.yellow) // 设置背景色
        GeometryReader { geometry in
            VStack {
                Text("宽度: \(geometry.size.width)")
                Text("高度: \(geometry.size.height)")
            }
        }
        .padding()
        .background(Color.gray)
        CustomContainer {
            Text("在其他视图中使用自定义容器")
            Text("SwiftUI 是很强大的")
        }
        HStack {
            Text("低优先级文本")
                .layoutPriority(1)  // 设置低优先级
            Text("高优先级文本")
                .layoutPriority(2)  // 设置高优先级
        }
        .padding()
        .background(Color.green)
        VStack {
            Text("顶部文本")
            Spacer()
            Text("底部文本")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ContentView()
}
