//
//  ProfileView.swift
//  SwiftUIProfileCard
//
//  Created by 黑马程序员 on 2024/6/27.
//

import SwiftUI

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .resizable()  // 使图像可以调整大小
                    .frame(width: 100, height: 100)  // 设置图像的宽度和高度
                    .foregroundColor(.blue)  // 设置图像颜色为蓝色
                VStack(alignment: .leading) {
                    Text("张三")
                        .font(.title)  // 设置文本字体为标题
                        .foregroundColor(.primary)  // 设置文本颜色为主要颜色
                    Text("iOS 开发工程师")
                        .font(.subheadline)  // 设置文本字体为副标题
                        .foregroundColor(.secondary)  // 设置文本颜色为次要颜色
                }
                .padding(.leading, 10)  // 设置左侧内边距为10
            }
            .padding()  // 为 HStack 添加内边距
            Divider()  // 添加一个分隔线
            VStack(alignment: .leading) {
                Text("简介")
                    .font(.headline)  // 设置文本字体为标题
                Text("具有多年 iOS 开发经验，熟悉 Swift 和 SwiftUI，擅长构建高性能的应用程序。")
                    .font(.body)  // 设置文本字体为正文
                    .padding(.top, 5)  // 设置上侧内边距为5
            }
            .padding()  // 为 VStack 添加内边距
            Spacer()  // 添加一个可伸缩的空白区域
            Button(action: {
                print("按钮被点击")
            }) {
                Text("联系我")
                    .font(.title2)  // 设置按钮文本字体为标题2
                    .padding()  // 添加内边距，增加按钮周围的空间
                    .background(Color.blue)  // 设置按钮背景颜色为蓝色
                    .foregroundColor(.white)  // 设置按钮文本颜色为白色
                    .cornerRadius(10)  // 设置按钮的圆角半径为10
                    .padding(.bottom, 20)  // 设置底部内边距为20
            }
            .frame(maxWidth: .infinity)  // 设置按钮的最大宽度为无限大
        }
        .padding()  // 为整个 VStack 添加内边距
        .background(Color(.systemGray6))  // 设置背景颜色为系统灰色6
        .cornerRadius(15)  // 设置圆角半径为15
        .shadow(radius: 10)  // 设置阴影半径为10
        .padding()  // 为整个视图再添加一层内边距
    }
}

#Preview {
    ProfileView()
}
