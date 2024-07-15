//
//  ObjectSerializationExampleView.swift
//  SwiftUIPersistence
//
//  Created by 黑马程序员 on 2024/7/15.
//

import SwiftUI

/// ### 4.3 对象的序列化和反序列化
/// 用户模型
struct User: Codable {
    var username: String
    var age: Int
}

struct ObjectSerializationExampleView: View {
    @State private var user = User(username: "壹刀流", age: 30)
    @State private var savedUser: User?
    
    /// 文档目录路径
    var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }

    var body: some View {
        VStack {
            Text("用户名: \(user.username)")
            Text("年龄: \(user.age)")
            Button("保存用户") {
                saveUserToFile(user)
            }
            .padding()
            Button("读取用户") {
                savedUser = readUserFromFile()
            }
            .padding()
            if let savedUser = savedUser {
                Text("读取到的用户名: \(savedUser.username)")
                Text("读取到的年龄: \(savedUser.age)")
            }
        }
        .padding()
    }
    

    func saveUserToFile(_ user: User) {
        let fileURL = documentsDirectory.appendingPathComponent("user.json")
        do {
            let data = try JSONEncoder().encode(user)
            try data.write(to: fileURL)
        } catch {
            print("保存用户失败：\(error.localizedDescription)")
        }
    }

    func readUserFromFile() -> User? {
        let fileURL = documentsDirectory.appendingPathComponent("user.json")
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(User.self, from: data)
        } catch {
            print("读取用户失败：\(error.localizedDescription)")
            return nil
        }
    }
}

#Preview {
    ObjectSerializationExampleView()
}
