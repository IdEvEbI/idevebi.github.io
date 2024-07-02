//
//  RegistrationView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/2.
//

import SwiftUI

/// ### 创建注册表单视图
struct RegistrationView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var bio = ""
    @State private var rating = 3
    @State private var isRegistered = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("账号信息")) {
                    TextField("用户名", text: $username)
                    SecureField("密码", text: $password)
                    TextField("邮箱", text: $email)
                }
                
                Section(header: Text("个人简介")) {
                    TextEditor(text: $bio)
                        .frame(height: 100)
                }
                
                Section(header: Text("评分")) {
                    HStack {
                        Text("评分")
                        RatingView(rating: $rating)
                    }
                }
                
                Section {
                    Button("注册") {
                        registerUser()
                    }
                }
            }
            .navigationTitle("用户注册")
            .alert(isPresented: $isRegistered) {
                Alert(
                    title: Text("注册成功"),
                    message: Text("欢迎，\(username)！"),
                    dismissButton: .default(Text("确定"))
                )
            }
        }
    }
    
    func registerUser() {
        let user = User(username: username, password: password, email: email, bio: bio, rating: rating)
        print("注册用户信息：\(user)")
        isRegistered = true
    }
}

#Preview {
    RegistrationView()
}
