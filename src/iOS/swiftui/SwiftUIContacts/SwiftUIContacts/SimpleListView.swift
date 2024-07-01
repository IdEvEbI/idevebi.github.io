//
//  SimpleListView.swift
//  SwiftUIContacts
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

/// ### 1.1 创建简单列表
struct SimpleListView: View {
    let items = ["苹果", "香蕉", "橙子", "西瓜"]
        
        var body: some View {
            List(items, id: \.self) { item in
                Text(item)
            }
        }
}

#Preview {
    SimpleListView()
}
