//
//  InteractiveCircleView.swift
//  SwiftUIInteractiveCircle
//
//  Created by 黑马程序员 on 2024/6/29.
//

import SwiftUI

struct InteractiveCircleView: View {
    @State private var offset: CGSize = .zero  // 定义一个偏移量状态变量
    @State private var scale: CGFloat = 1.0  // 定义一个缩放比例状态变量
    @State private var color: Color = .blue  // 定义一个颜色状态变量

    var body: some View {
        Circle()
            .fill(color)  // 应用颜色
            .frame(width: 100 * scale, height: 100 * scale)  // 根据缩放比例调整大小
            .offset(offset)  // 应用偏移量
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        withAnimation {
                            offset = gesture.translation  // 更新偏移量
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            offset = .zero  // 重置偏移量
                        }
                    }
                    .simultaneously(
                        with: MagnificationGesture()
                            .onChanged { value in
                                withAnimation {
                                    scale = value  // 更新缩放比例
                                }
                            }
                            .onEnded { _ in
                                withAnimation {
                                    scale = 1.0  // 重置缩放比例
                                }
                            }
                    )
            )
            .onTapGesture {
                withAnimation {
                    color = color == .blue ? .green : .blue  // 切换颜色
                }
            }
    }
}

#Preview {
    InteractiveCircleView()
}
