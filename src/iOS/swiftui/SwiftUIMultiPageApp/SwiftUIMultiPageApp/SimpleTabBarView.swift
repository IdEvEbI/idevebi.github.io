//
//  SimpleTabBarView.swift
//  SwiftUIMultiPageApp
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

/// ### 1.2 创建 TabBar
struct SimpleTabBarView: View {
    var body: some View {
        TabView {
            Text("首页")
                .tabItem {
                    Label("首页", systemImage: "house")
                }
            Text("搜索")
                .tabItem {
                    Label("搜索", systemImage: "magnifyingglass")
                }
            Text("设置")
                .tabItem {
                    Label("设置", systemImage: "gear")
                }
        }
    }
}

#Preview {
    SimpleTabBarView()
}
