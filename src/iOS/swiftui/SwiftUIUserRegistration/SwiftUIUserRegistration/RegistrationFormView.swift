//
//  RegistrationFormView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/9.
//

import SwiftUI
import AlertToast

/// ## 5. 综合案例：用户注册表单
/// 用户模型
struct User {
    var name: String
    var email: String
    var password: String
    var age: Int
    var agreeToTerms: Bool
}

/// 用户注册表单视图
struct RegistrationFormView: View {
    @State private var user = User(name: "",
                                   email: "",
                                   password: "",
                                   age: 18,
                                   agreeToTerms: false)
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showToast = false
    @State private var isValidate = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("个人信息")) {
                    TextField("姓名", text: $user.name)
                    TextField("邮箱", text: $user.email)
                    SecureField("密码", text: $user.password)
                    Stepper(value: $user.age, in: 18...100) {
                        Text("年龄: \(user.age)")
                    }
                }
                
                Section(header: Text("条款与协议")) {
                    Toggle("同意条款", isOn: $user.agreeToTerms)
                }
                
                Button("注册") {
                    if validateForm() {
                        submitForm()
                    } else {
                        showToast = true
                    }
                }
            }
            .toast(isPresenting: $showToast) {
                AlertToast(type: isValidate ? .complete(.blue) : .error(.red),
                           title: alertMessage)
            }
            .navigationTitle("用户注册")
        }
    }
    
    func validateForm() -> Bool {
        if user.name.isEmpty {
            alertMessage = "请输入姓名。"
            return false
        }
        
        if !user.email.contains("@") {
            alertMessage = "请输入有效的邮箱地址。"
            return false
        }
        
        if user.password.count < 6 {
            alertMessage = "密码长度至少为 6 位。"
            return false
        }
        
        if !user.agreeToTerms {
            alertMessage = "请同意条款。"
            return false
        }
        
        return true
    }
    
    func submitForm() {
        alertMessage = "注册成功！"
        isValidate = true
        showToast = true
        
        // 模拟提交注册数据……
    }
}

#Preview {
    RegistrationFormView()
}
