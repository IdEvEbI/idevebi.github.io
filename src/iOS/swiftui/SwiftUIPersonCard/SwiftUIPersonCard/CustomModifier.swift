//
//  CustomModifier.swift
//  SwiftUIPersonCard
//
//  Created by 黑马程序员 on 2024/7/8.
//

import SwiftUI

/// ### 3.2 创建自定义修饰符
struct CustomModifier: ViewModifier {
    var cornerRadius: CGFloat
    var backgroundColor: Color
    var foregroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(cornerRadius)
            .shadow(radius: 5)
    }
}

/// 扩展 View 协议简化自定义修饰符的使用
extension View {
    func customStyle(cornerRadius: CGFloat, 
                     backgroundColor: Color,
                     foregroundColor: Color) -> some View {
        self.modifier(CustomModifier(
            cornerRadius: cornerRadius,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor)
        )
    }
}

//#Preview {
//    Text("自定义修饰符")
//        .customStyle(cornerRadius: 10, 
//                     backgroundColor: .blue,
//                     foregroundColor: .white)
//}

/// ### 3.3 使用自定义修饰符
struct CustomModifierExampleView: View {
    var body: some View {
        VStack {
            Text("示例 1")
                .customStyle(cornerRadius: 10, 
                             backgroundColor: .red,
                             foregroundColor: .white)
            Text("示例 2")
                .customStyle(cornerRadius: 20, 
                             backgroundColor: .yellow,
                             foregroundColor: .black)
            Text("示例 3")
                .customStyle(cornerRadius: 30, 
                             backgroundColor: .blue,
                             foregroundColor: .yellow)
        }
    }
}

#Preview {
    CustomModifierExampleView()
}
