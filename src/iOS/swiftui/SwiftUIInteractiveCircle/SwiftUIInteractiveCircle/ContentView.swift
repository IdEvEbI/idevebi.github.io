//
//  ContentView.swift
//  SwiftUIInteractiveCircle
//
//  Created by 黑马程序员 on 2024/6/29.
//

import SwiftUI

/// ### 1.1 隐式动画
/// **隐式动画**是指通过修改视图属性，并使用 `.animation` 修饰符自动添加动画效果。
//struct ContentView: View {
//    @State private var isExpanded = false  // 定义一个状态变量
//
//    var body: some View {
//        VStack {
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: isExpanded ? 200 : 100, height: 100)
//                .animation(.easeInOut(duration: 1.0), value: isExpanded)  // 添加隐式动画
//            Button(action: {
//                isExpanded.toggle()  // 切换状态
//            }) {
//                Text("切换大小")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//    }
//}

/// ### 1.2 显式动画
/// **显式动画**是指使用 `withAnimation` 函数来包装状态改变，从而控制动画的时机和方式。
//struct ContentView: View {
//    @State private var rotationAngle: Double = 0  // 定义一个旋转角度状态变量
//
//    var body: some View {
//        VStack {
//            Image(systemName: "arrow.right.circle")
//                .resizable()
//                .frame(width: 100, height: 100)
//                .rotationEffect(.degrees(rotationAngle))  // 应用旋转效果
//            Button(action: {
//                withAnimation(.spring()) {
//                    rotationAngle += 45  // 使用显式动画
//                }
//            }) {
//                Text("旋转")
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//    }
//}

/// ### 1.3 组合动画
//struct ContentView: View {
//    @State private var scale: CGFloat = 1.0  // 定义一个缩放比例状态变量
//    @State private var opacity: Double = 1.0  // 定义一个透明度状态变量
//
//    var body: some View {
//        VStack {
//            Circle()
//                .fill(Color.red)
//                .frame(width: 100, height: 100)
//                .scaleEffect(scale)  // 应用缩放效果
//                .opacity(opacity)  // 应用透明度效果
//            Button(action: {
//                withAnimation(.easeInOut(duration: 1.0)) {
//                    scale = scale == 1.0 ? 1.5 : 1.0  // 切换缩放比例
//                    opacity = opacity == 1.0 ? 0.5 : 1.0  // 切换透明度
//                }
//            }) {
//                Text("组合动画")
//                    .padding()
//                    .background(Color.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//    }
//}

/// ## 2. SwiftUI 手势
/// ### 2.1 点击手势
//struct ContentView: View {
//    @State private var isTapped = false  // 定义一个点击状态变量
//
//    var body: some View {
//        Circle()
//            .fill(isTapped ? Color.green : Color.blue)  // 根据点击状态切换颜色
//            .frame(width: 100, height: 100)
//            .animation(.bouncy, value: isTapped)
//            .onTapGesture {
//                isTapped.toggle()  // 切换点击状态
//            }
//    }
//}

/// ### 2.2 拖动手势
//struct ContentView: View {
//    @State private var offset: CGSize = .zero  // 定义一个偏移量状态变量
//
//    var body: some View {
//        Circle()
//            .fill(Color.orange)
//            .frame(width: 100, height: 100)
//            .offset(offset)  // 应用偏移量
//            .gesture(
//                DragGesture()
//                    .onChanged { gesture in
//                        offset = gesture.translation  // 更新偏移量
//                    }
//                    .onEnded { _ in
//                        withAnimation {
//                            offset = .zero  // 重置偏移量
//                        }
//                    }
//            )
//    }
//}

/// ### 2.3 长按手势
//struct ContentView: View {
//    @State private var isLongPressed = false  // 定义一个长按状态变量
//
//    var body: some View {
//        Circle()
//            .fill(isLongPressed ? Color.red : Color.yellow)  // 根据长按状态切换颜色
//            .frame(width: 100, height: 100)
//            .scaleEffect(isLongPressed ? 1.2 : 1.0)  // 根据长按状态切换缩放比例
//            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: isLongPressed)
//            .gesture(
//                LongPressGesture(minimumDuration: 1.0)
//                    .onChanged { _ in
//                        isLongPressed = true  // 更新长按状态
//                    }
//                    .onEnded { _ in
//                        isLongPressed = false  // 重置长按状态
//                    }
//            )
//    }
//}

/// ### 2.4 缩放手势
struct ContentView: View {
    @State private var scale: CGFloat = 1.0  // 定义一个缩放比例状态变量

    var body: some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .frame(width: 100, height: 100)
            .scaleEffect(scale)  // 应用缩放效果
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        scale = value  // 更新缩放比例
                    }
                    .onEnded { _ in
                        withAnimation {
                            scale = 1.0  // 重置缩放比例
                        }
                    }
            )
    }
}

#Preview {
    ContentView()
}
