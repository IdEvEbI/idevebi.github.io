//
//  AnimationView.swift
//  SwiftUICardFlip
//
//  Created by 黑马程序员 on 2024/7/8.
//

import SwiftUI

/// ### 2.1 简单动画
struct SimpleAnimationView: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.blue)
                .frame(width: isExpanded ? 200 : 100, height: isExpanded ? 200 : 100)
                .animation(.default, value: isExpanded)
            Button("切换") {
                withAnimation {
                    isExpanded.toggle()
                }
            }
        }
    }
}

/// ### 2.2 自定义动画
struct CustomAnimationView: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            Circle()
                .fill(.green)
                .frame(width: isExpanded ? 150 : 75, height: isExpanded ? 150 : 75)
                .animation(Animation.easeInOut(duration: 1).repeatCount(3), value: isExpanded)
            Button("切换") {
                withAnimation {
                    isExpanded.toggle()
                }
            }
        }
    }
}

/// ### 2.3 组合动画
struct CombinedAnimationView: View {
    @State private var isExpanded = false
    @State private var isRotated = false
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.orange)
                .frame(width: isExpanded ? 200 : 100, height: isExpanded ? 200 : 100)
                .rotationEffect(.degrees(isRotated ? 180 : 0))
                .animation(.easeInOut(duration: 1), value: isExpanded)
                .animation(.easeInOut(duration: 1), value: isRotated)
            Button("切换") {
                withAnimation {
                    isExpanded.toggle()
                    isRotated.toggle()
                }
            }
        }
    }
}

/// ### 2.4 使用 Transaction 控制动画
struct TransactionAnimationView: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            Circle()
                .fill(.purple)
                .frame(width: isExpanded ? 200 : 100, height: isExpanded ? 200 : 100)
                .animation(.default, value: isExpanded)
            Button("切换") {
                withAnimation {
                    var transaction = Transaction(animation: .easeInOut(duration: 1))
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        isExpanded.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    TransactionAnimationView()
}
