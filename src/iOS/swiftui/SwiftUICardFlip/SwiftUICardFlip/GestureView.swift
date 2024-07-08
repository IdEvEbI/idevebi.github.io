//
//  GestureView.swift
//  SwiftUICardFlip
//
//  Created by 黑马程序员 on 2024/7/8.
//

import SwiftUI

/// ### 3.1 点击手势
struct TapGestureView: View {
    @State private var message = "请点击我"
    @State private var backgroundColor: Color = .purple
    
    var body: some View {
        Text(message)
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 1)) {
                    message = "我被点了"
                    backgroundColor = .blue
                }
            }
    }
}

/// ### 3.2 长按手势
struct LongPressGestureView: View {
    @State private var isLongPressed = false
    
    var body: some View {
        Circle()
            .fill(isLongPressed ? .red : .yellow)
            .frame(width: 100, height: 100)
            .scaleEffect(isLongPressed ? 1.2 : 1.0)
            .onLongPressGesture(minimumDuration: 1.0, pressing: { isPressing in
                withAnimation {
                    isLongPressed = isPressing
                }
            }, perform: {
                print("长按手势结束")
            })
    }
}

/// ### 3.3 拖动手势
struct DragGestureView: View {
    @State private var offset: CGSize = .zero
    
    var body: some View {
        Circle()
            .fill(.green)
            .frame(width: 100, height: 100)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        withAnimation(.easeInOut(duration: 0.5)) {
                            offset = .zero
                        }
                    }
            )
    }
}

/// ### 3.4 捏合手势
struct MagnificationGestureView: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundColor(.red)
            .scaleEffect(scale)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        scale = value
                    }
                    .onEnded { _ in
                        withAnimation {
                            scale = 1.0
                        }
                    }
            )
    }
}

/// ### 3.5 旋转手势
struct RotationGestureView: View {
    @State private var angle: Angle = .zero
    
    var body: some View {
        Image(systemName: "arrow.right.circle.fill")
            .resizable()
            .frame(width: 100, height: 100)
            .foregroundColor(.blue)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { _ in
                        withAnimation {
                            angle = .zero
                        }
                    }
            )
    }
}

/// ## 4. 组合动画与手势
struct CombinedAnimationGestureView: View {
    @State private var offset = CGSize.zero
    @State private var isScaled = false
    
    var body: some View {
        Circle()
            .fill(.blue)
            .frame(width: isScaled ? 200 : 100, height: isScaled ? 200 : 100)
            .offset(offset)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        withAnimation {
                            offset = .zero
                        }
                    }
                    .simultaneously(with: TapGesture()
                        .onEnded {
                            withAnimation {
                                isScaled.toggle()
                            }
                        }
                    )
            )
    }
}

#Preview {
    CombinedAnimationGestureView()
}
