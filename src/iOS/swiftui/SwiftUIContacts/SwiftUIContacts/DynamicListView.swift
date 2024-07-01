//
//  DynamicListView.swift
//  SwiftUIContacts
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

/// ### 1.3 动态列表
struct Fruit: Identifiable {
    var id = UUID()
    var name: String
}

struct DynamicListView: View {
    let fruits = [
        Fruit(name: "苹果"),
        Fruit(name: "香蕉"),
        Fruit(name: "橙子"),
        Fruit(name: "西瓜")
    ]
    
    var body: some View {
        List(fruits) { fruit in
            Text(fruit.name)
        }
    }
}

#Preview {
    DynamicListView()
}
