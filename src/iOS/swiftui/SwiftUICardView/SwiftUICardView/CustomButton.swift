//
//  CustomButton.swift
//  SwiftUICardView
//
//  Created by 黑马程序员 on 2024/6/29.
//

import SwiftUI

struct CustomButton: View {
    var title: String   // 按钮标题
    var action: () -> Void  // 按钮点击事件
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

#Preview {
    CustomButton(title: "点我") {
        print("按钮被点击")
    }
}
