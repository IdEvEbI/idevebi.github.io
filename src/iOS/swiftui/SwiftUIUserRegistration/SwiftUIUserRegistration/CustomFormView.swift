//
//  CustomFormView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/9.
//

import SwiftUI

/// ### 4.2 创建自定义密码控件
struct CustomPasswordField: View {
    var placeholder = "请输入密码"            // 占位符
    @Binding var password: String           // 密码
    @State var isSecure = true              // 是否显示密文
    
    var body: some View {
        HStack {
            if isSecure {
                SecureField(placeholder, text: $password)
                    .padding(.leading, 10)
            } else {
                TextField(placeholder, text: $password)
                    .padding(.leading, 10)
            }
            
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye.slash" : "eye")
                    .foregroundColor(isSecure ? .gray : .blue)
                    .padding(.trailing, 10)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

/// 测试自定义密码控件
struct TestCustomPasswordField: View {
    @State private var password = ""
    
    var body: some View {
        VStack {
            CustomPasswordField(placeholder: "请输入口令",
                                password: $password,
                                isSecure: true)
            .padding()
            Text("您输入的密码是: \(password)")
                .padding()
            Spacer()
        }
    }
}

#Preview {
    TestCustomPasswordField()
}
