//
//  CustomFormView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/2.
//

import SwiftUI

/// ### 2.2 与表单交互
struct CustomFormView: View {
    @State private var name = ""
    @State private var rating = 3
    
    var body: some View {
        Form {
            Section(header: Text("基本信息")) {
                TextField("姓名", text: $name)
                HStack {
                    Text("评分")
                    RatingView(rating: $rating)
                }
            }
            
            Section {
                Button("提交") {
                    print("提交信息：\(name), 评分：\(rating)")
                }
            }
        }
    }
}

#Preview {
    CustomFormView()
}
