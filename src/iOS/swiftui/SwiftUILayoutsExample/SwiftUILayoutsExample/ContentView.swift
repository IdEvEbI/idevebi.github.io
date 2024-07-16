//
//  ContentView.swift
//  SwiftUILayoutsExample
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /// ### 2.1 VStack
        VStack {
            Text("上方文本")
            Text("中间文本")
            Text("下方文本")
        }
        .padding()                      // 为 VStack 添加内边距
        .background(.blue)              // 设置背景色
        /// ### 2.2 HStack
        HStack {
            Text("左侧文本")
            Text("中间文本")
            Text("右侧文本")
        }
        .padding()                      // 为 HStack 添加内边距
        .background(.green)             // 设置背景色
        /// ### 2.3 ZStack
        ZStack {
            Image(systemName: "star")
                .resizable()
                .frame(width: 100, height: 100)
            Text("叠加文本")
                .foregroundColor(.red)
                .font(.largeTitle)
        }
        .padding()                      // 为 ZStack 添加内边距
        .background(.yellow)            // 设置背景色
    }
}

#Preview {
    ContentView()
}
