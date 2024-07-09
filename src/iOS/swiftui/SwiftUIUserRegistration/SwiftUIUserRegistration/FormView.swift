//
//  FormView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/9.
//

import SwiftUI

/// ### 2.1 简单的表单
struct SimpleFormView: View {
    /// 用户名
    @State private var username: String = ""
    /// 启用通知
    @State private var notificationsEnabled: Bool = false
    /// 音量
    @State private var volume: Double = 0.5
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("用户信息")) {
                    TextField("用户名", text: $username)
                    Toggle("启用通知", isOn: $notificationsEnabled)
                }
                Section(header: Text("设置")) {
                    Slider(value: $volume, in: 0...1)
                    Text("音量: \(Int(volume * 100))%")
                }
            }
            .navigationTitle("表单示例")
        }
    }
}

//#Preview {
//    SimpleFormView()
//}

/// ### 2.2 带有绑定的表单
//struct User {
//    /// 用户名
//    var username: String
//    /// 启用通知
//    var notificationsEnabled: Bool
//    /// 音量
//    var volume: Double
//}
//
///// 带有绑定的表单视图
//struct BindingFormView: View {
//    @Binding var user: User
//    
//    var body: some View {
//        Form {
//            Section(header: Text("用户信息")) {
//                TextField("用户名", text: $user.username)
//                Toggle("启用通知", isOn: $user.notificationsEnabled)
//            }
//            Section(header: Text("设置")) {
//                Slider(value: $user.volume, in: 0...1)
//                Text("音量: \(Int(user.volume * 100))%")
//            }
//        }
//    }
//}
//
///// 绑定表单视图容器（传递状态）
//struct BindingFormContainer: View {
//    @State private var user = User(username: "壹刀流",
//                                   notificationsEnabled: true,
//                                   volume: 0.8)
//    
//    var body: some View {
//        NavigationView {
//            BindingFormView(user: $user)
//                .navigationTitle("绑定表单示例")
//        }
//    }
//}
//
//#Preview {
//    BindingFormContainer()
//}
