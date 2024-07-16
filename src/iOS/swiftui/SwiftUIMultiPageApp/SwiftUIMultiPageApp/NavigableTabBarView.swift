//
//  NavigableTabBarView.swift
//  SwiftUIMultiPageApp
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

/// ### 2.1 在 TabBar 中进行导航
struct NavigableTabBarView: View {
    init() {
        UITabBar.appearance().backgroundColor = .systemGray6
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    
    var body: some View {
        TabView {
            NavigationView {
                HomeViewWithNavigation()
            }
            .tabItem {
                Label("首页", systemImage: "house")
            }
            NavigationView {
                SearchViewWithNavigation()
            }
            .tabItem {
                Label("搜索", systemImage: "magnifyingglass")
            }
            NavigationView {
                SettingsViewWithNavigation()
            }
            .tabItem {
                Label("设置", systemImage: "gear")
            }
        }
    }
}

/// 带导航的首页视图
struct HomeViewWithNavigation: View {
    var body: some View {
        VStack {
            Text("欢迎来到首页")
                .font(.largeTitle)
                .padding()
            NavigationLink(destination: Text("详细页面")) {
                Text("点击查看详情")
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("首页")
    }
}

/// 带导航的搜索视图
struct SearchViewWithNavigation: View {
    var body: some View {
        VStack {
            Text("搜索页面")
                .font(.largeTitle)
                .padding()
            NavigationLink(destination: Text("搜索结果页面")) {
                Text("点击查看搜索结果")
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("搜索")
    }
}

/// 带导航的设置视图
struct SettingsViewWithNavigation: View {
    var body: some View {
        VStack {
            Text("设置页面")
                .font(.largeTitle)
                .padding()
            NavigationLink(destination: Text("设置详情页面")) {
                Text("点击查看设置详情")
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationTitle("设置")
    }
}

#Preview {
    NavigableTabBarView()
}
