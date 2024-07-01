//
//  ContentView.swift
//  SwiftUICardView
//
//  Created by 黑马程序员 on 2024/6/29.
//

import SwiftUI

/// ### 2.1 定义自定义修饰符
struct CustomTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .padding()
            .background(Color.yellow)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

/// ### 2.3 简化修饰符使用
extension View {
    func customTitleStyle() -> some View {
        self.modifier(CustomTitleModifier())
    }
}

//struct ContentView: View {
//    var body: some View {
//        VStack {
//            CustomButton(title: "点点我") {
//                print("我被点了")
//            }
//            CustomCard(title: "SwiftUI", description: "一个强大的 UI 框架")
//            CustomCard(title: "自定义视图", description: "提高代码复用性")
//            Text("自定义修饰符")
//                .modifier(CustomTitleModifier())
//            Text("简化修饰符使用")
//                .customTitleStyle()
//        }
//        .padding()
//    }
//}

/// ## 3. 综合案例：照片展示视图
struct ContentView: View {
    let photos = [
        Photo(imageName: "photo1", title: "头像 1"),
        Photo(imageName: "photo2", title: "头像 2"),
        Photo(imageName: "photo3", title: "头像 3")
    ]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(photos) { photo in
                    PhotoView(photo: photo)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
