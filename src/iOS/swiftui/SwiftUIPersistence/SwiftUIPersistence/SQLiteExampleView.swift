//
//  SQLiteExampleView.swift
//  SwiftUIPersistence
//
//  Created by 黑马程序员 on 2024/7/15.
//

import SwiftUI
import SQLite

/// ### 5.3 使用 SQLite 进行数据持久化
struct SQLiteExampleView: SwiftUI.View {
    @State private var username: String = ""
    @State private var savedUsername: String = ""
    
    /// 数据库连接对象
    private var db: Connection?
    /// 用户表
    private var usersTable = Table("users")
    /// ID 列
    private var idColumn = Expression<Int64>("id")
    /// 用户名列
    private var usernameColumn = Expression<String>("username")
    
    /// 文档目录路径
    var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }
    
    init() {
        do {
            // 连接到数据库
            db = try Connection(documentsDirectory.appendingPathComponent("users.sqlite3").path)
            // 如果不存在用户表，则创建
            try db?.run(
                usersTable.create(ifNotExists: true) { t in
                    t.column(idColumn, primaryKey: .autoincrement)
                    t.column(usernameColumn)
                })
        } catch {
            print("数据库连接失败：\(error.localizedDescription)")
        }
    }
    
    var body: some SwiftUI.View {
        VStack {
            TextField("用户名", text: $username)
                .padding()
                .border(Color.gray)
            Button("保存用户名") {
                saveUsernameToDatabase(username)
            }
            .padding()
            Button("读取用户名") {
                savedUsername = readUsernameFromDatabase() ?? "未找到用户名"
            }
            .padding()
            Text(savedUsername)
        }
        .padding()
    }
    
    /// 将用户名保存至数据库
    func saveUsernameToDatabase(_ username: String) {
        guard let db = db else { return }
        do {
            try db.run(usersTable.insert(usernameColumn <- username))
        } catch {
            print("保存用户名失败：\(error.localizedDescription)")
        }
    }
    
    /// 从数据库读取用户名
    func readUsernameFromDatabase() -> String? {
        guard let db = db else { return nil }
        do {
            if let user = try db.pluck(usersTable) {
                return user[usernameColumn]
            }
        } catch {
            print("读取用户名失败：\(error.localizedDescription)")
        }
        return nil
    }
}

#Preview {
    SQLiteExampleView()
}
