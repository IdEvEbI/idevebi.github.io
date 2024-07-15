//
//  UserDefaultsExampleView.swift
//  SwiftUIPersistenceExample
//
//  Created by 黑马程序员 on 2024/7/11.
//

import SwiftUI

/// ### 2.2 使用 UserDefaults 进行数据持久化
struct UserDefaultsExampleView: View {
    @State private var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    @State private var notificationsEnabled: Bool = UserDefaults.standard.bool(forKey: "notificationsEnabled")
    
    var body: some View {
        VStack {
            TextField("用户名", text: $username)
                .padding()
                .border(Color.gray)
            Toggle("启用通知", isOn: $notificationsEnabled)
                .padding()
            Button("保存设置") {
                saveSettings()
            }
            .padding()
        }
        .padding()
    }
    
    /// 保存设置
    func saveSettings() {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(notificationsEnabled, forKey: "notificationsEnabled")
    }
}

#Preview {
    UserDefaultsExampleView()
}
