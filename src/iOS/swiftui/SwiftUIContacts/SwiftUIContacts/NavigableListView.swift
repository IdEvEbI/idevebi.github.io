//
//  NavigableListView.swift
//  SwiftUIContacts
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

/// ### 2.2 列表中的导航
struct FruitDetailView: View {
    var fruit: String
    
    var body: some View {
        Text("你选择了 \(fruit)")
            .font(.largeTitle)
            .padding()
    }
}

struct NavigableListView: View {
    let fruits = ["苹果", "香蕉", "橙子", "西瓜"]
    
    var body: some View {
        NavigationView {
            List(fruits, id: \.self) { fruit in
                NavigationLink(destination: FruitDetailView(fruit: fruit)) {
                    Text(fruit)
                }
            }
            .navigationTitle("水果列表")
        }
    }
}

#Preview {
    NavigableListView()
}
