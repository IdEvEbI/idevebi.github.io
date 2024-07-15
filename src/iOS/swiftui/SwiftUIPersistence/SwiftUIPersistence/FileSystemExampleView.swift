//
//  FileSystemExampleView.swift
//  SwiftUIPersistence
//
//  Created by 黑马程序员 on 2024/7/12.
//

import SwiftUI

/// ### 4.2 使用文件系统进行数据持久化
struct FileSystemExampleView: View {
    @State private var username: String = ""
    @State private var savedUsername: String = ""
    
    /// 获取文档目录路径
    var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        VStack {
            TextField("用户名", text: $username)
                .padding()
                .border(Color.gray)
            Button("保存用户名") {
                saveUsernameToFile(username)
            }
            .padding()
            Button("读取用户名") {
                savedUsername = readUsernameFromFile() ?? "未找到用户名"
            }
            .padding()
            Text(savedUsername)
        }
        .padding()
    }
    
    /// 保存用户名到文件
    func saveUsernameToFile(_ username: String) {
        let fileURL = documentsDirectory
            .appendingPathComponent("username.txt")
        do {
            try username.write(to: fileURL, 
                               atomically: true,
                               encoding: .utf8)
        } catch {
            print("保存用户名失败：\(error.localizedDescription)")
        }
    }
    
    /// 从文件读取用户名
    func readUsernameFromFile() -> String? {
        let fileURL = documentsDirectory
            .appendingPathComponent("username.txt")
        do {
            return try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            print("读取用户名失败：\(error.localizedDescription)")
            return nil
        }
    }
}

#Preview {
    FileSystemExampleView()
}
