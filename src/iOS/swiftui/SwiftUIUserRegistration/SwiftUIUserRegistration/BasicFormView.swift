//
//  BasicFormView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

/// ### 1.1 Form 和 Section 的使用
struct BasicFormView: View {
    @State private var name = ""
    @State private var age = ""
    
    var body: some View {
        Form {
            Section(header: Text("基本信息")) {
                TextField("姓名", text: $name)
                TextField("年龄", text: $age)
            }
            
            Section {
                Button(action: {
                    print("提交信息：\(name), \(age)")
                }, label: {
                    HStack {
                        Spacer()
                        Text("提交")
                        Spacer()
                    }
                })
            }
        }
    }
}

#Preview {
    BasicFormView()
}
