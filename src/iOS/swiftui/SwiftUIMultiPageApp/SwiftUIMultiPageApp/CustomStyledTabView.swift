//
//  CustomStyledTabView.swift
//  SwiftUIMultiPageApp
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

/// ### 1.4 自定义 TabBar 外观
struct CustomStyledTabView: View {
    init() {
        UITabBar.appearance().backgroundColor = .systemGray6
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首页")
                }.badge("3")
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("搜索")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("设置")
                }
        }
    }
}

#Preview {
    CustomStyledTabView()
}
