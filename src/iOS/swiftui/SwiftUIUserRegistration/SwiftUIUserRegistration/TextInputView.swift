//
//  TextInputView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/2.
//

import SwiftUI

/// ### 1.2 TextField、SecureField 和 TextEditor
struct TextInputView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var bio = ""
    
    var body: some View {
        Form {
            Section(header: Text("账号信息")) {
                TextField("用户名", text: $username)
                SecureField("密码", text: $password)
            }
            
            Section(header: Text("个人简介")) {
                TextEditor(text: $bio)
                    .frame(height: 100)
            }
        }
    }
}

#Preview {
    TextInputView()
}
