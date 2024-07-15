//
//  UserDefaultsExampleView.swift
//  SwiftUIPersistence
//
//  Created by 黑马程序员 on 2024/7/12.
//

import SwiftUI

/// ### 3.2 使用 UserDefaults 进行数据持久化
struct UserDefaultsExampleView: View {
    // 从 UserDefaults 加载 username，否则使用 ""
    @State private var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    // 从 UserDefaults 加载 notificationsEnabled，否则默认为 false
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
        UserDefaults.standard.set(username,
                                  forKey: "username")
        UserDefaults.standard.set(notificationsEnabled,
                                  forKey: "notificationsEnabled")
        
        // 输出沙盒目录
        print(userDefaultsDirectory)
    }
    
    /// UserDefaults 数据存储目录
    var userDefaultsDirectory: String {
        let userDefaultsPath = NSSearchPathForDirectoriesInDomains(
            .libraryDirectory,
            .userDomainMask, true).first!
        let preferencesPath = (userDefaultsPath as NSString)
            .appendingPathComponent("Preferences")
        
        return preferencesPath
    }
}

#Preview {
    UserDefaultsExampleView()
}
