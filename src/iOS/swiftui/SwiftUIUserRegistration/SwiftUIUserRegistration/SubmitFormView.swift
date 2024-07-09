//
//  SubmitFormView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/9.
//

import SwiftUI

/// ### 3.1 表单验证
struct ValidatedFormView: View {
    /// 邮箱
    @State private var email: String = ""
    /// 密码
    @State private var password: String = ""
    /// 显示警告
    @State private var showAlert = false
    /// 警告信息
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("登录信息")) {
                    TextField("邮箱", text: $email)
                        .keyboardType(.emailAddress)    // 键盘类型
                        .autocapitalization(.none)
                    SecureField("密码", text: $password)
                }
                Button("登录") {
                    if validateForm() {
                        // 执行登录操作
                        print("表单验证通过")
                    } else {
                        showAlert = true
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("验证失败"),
                          message: Text(alertMessage),
                          dismissButton: .default(Text("确定")))
                }
            }
            .navigationTitle("表单验证示例")
        }
    }
    
    /// 校验表单函数
    func validateForm() -> Bool {
        if email.isEmpty || !email.contains("@") {
            alertMessage = "请输入有效的邮箱地址。"
            return false
        }
        
        if password.count < 6 {
            alertMessage = "密码长度至少为 6 位。"
            return false
        }
        
        return true
    }
}

//#Preview {
//    ValidatedFormView()
//}

/// ### 3.2 表单提交
struct SubmissionFormView: View {
    /// 姓名
    @State private var name: String = ""
    /// 年龄
    @State private var age: Int = 18
    /// 启用通知
    @State private var showAlert = false
    /// 警告信息
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("个人信息")) {
                    TextField("姓名", text: $name)
                    Stepper(value: $age, in: 1...100) {
                        Text("年龄: \(age)")
                    }
                }
                Button("提交") {
                    if validateForm() {
                        submitForm()
                    } else {
                        showAlert = true
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("提交失败"), 
                          message: Text(alertMessage),
                          dismissButton: .default(Text("确定")))
                }
            }
            .navigationTitle("表单提交示例")
        }
    }
    
    func validateForm() -> Bool {
        if name.isEmpty {
            alertMessage = "请输入姓名。"
            return false
        }
        
        if age < 1 || age > 100 {
            alertMessage = "请输入有效的年龄。"
            return false
        }
        
        return true
    }
    
    func submitForm() {
        // 模拟提交表单数据
        alertMessage = "表单提交成功！"
        showAlert = true
    }
}

#Preview {
    SubmissionFormView()
}
