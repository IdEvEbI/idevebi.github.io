//
//  ContentView.swift
//  SwiftUIProfileCard
//
//  Created by 黑马程序员 on 2024/6/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /// ### 3.1 Text 视图
        Text("你好，SwiftUI!")
            .font(.largeTitle)          // 设置文本字体为大标题
            .foregroundColor(.blue)     // 设置文本颜色
            .padding()                  // 添加内边距，增加视图周围的空间
            .background(.green)         // 设置背景颜色，要放在 padding 之后
        /// ### 3.2 Image 视图
        Image(systemName: "star.fill")
            .resizable()                // 使图像可以调整大小
            .frame(width: 100, height: 100) // 设置图像的宽度和高度
            .foregroundColor(.yellow)   // 设置图像颜色
            .padding()                  // 添加内边距，增加视图周围的空间
            .background(.green)         // 设置背景颜色，要放在 padding 之后
        /// ### 3.3 Button 视图
        Button(action: {
            print("按钮被点击了~")
        }) {
            Text("点击我")
                .font(.title)           // 设置按钮文本字体为标题
                .padding()              // 添加内边距，增加按钮周围的空间
                .background(.green)     // 设置按钮背景颜色为绿色
                .foregroundColor(.white)// 设置按钮文本颜色为白色
                .cornerRadius(10)       // 设置按钮的圆角半径为10
        }
/// ### 3.4 VStack、HStack 和 ZStack
VStack {
    Text("上方文本")
    HStack {
        Text("左侧文本")
        Text("右侧文本")
    }
    ZStack {
        Image(systemName: "star")
            .resizable()
            .frame(width: 100, height: 100)
        Text("叠加文本")
            .foregroundColor(.red)
            .font(.largeTitle)
    }
}
.padding()                          // 为整个 VStack 添加内边距
        /// ### 3.5 Spacer 和 Divider
        VStack {
            Text("上方文本")
            Spacer()                        // 添加一个可伸缩的空白区域
            Divider()                       // 添加一个分隔线
            Text("下方文本")
        }
        .padding()                          // 为整个 VStack 添加内边距
    }
}

#Preview {
    ContentView()
}
