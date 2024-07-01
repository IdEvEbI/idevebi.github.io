//
//  SectionedListView.swift
//  SwiftUIContacts
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

/// ### 1.4 Section 和 GroupedListStyle（列表分组）
struct SectionedListView: View {
    var body: some View {
        List {
            Section(header: Text("水果")) {
                Text("苹果")
                Text("香蕉")
            }
            Section(header: Text("蔬菜")) {
                Text("西红柿")
                Text("黄瓜")
            }
        }
        .listStyle(GroupedListStyle())
    }
}

#Preview {
    SectionedListView()
}
