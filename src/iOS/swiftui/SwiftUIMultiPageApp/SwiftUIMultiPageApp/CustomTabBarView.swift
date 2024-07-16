//
//  CustomTabBarView.swift
//  SwiftUIMultiPageApp
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

/// ### 1.3 自定义 TabBar 选项卡
struct CustomTabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("首页", systemImage: "house.fill")
                }
            SearchView()
                .tabItem {
                    Label("搜索", systemImage: "magnifyingglass.circle.fill")
                }
            SettingsView()
                .tabItem {
                    Label("设置", systemImage: "gearshape.fill")
                }
        }
        .accentColor(.blue)
    }
}

/// 首页
struct HomeView: View {
    var body: some View {
        VStack {
            Text("欢迎来到首页")
                .font(.largeTitle)
            Image(systemName: "house.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}

/// 搜索页
struct SearchView: View {
    var body: some View {
        VStack {
            Text("搜索内容")
                .font(.largeTitle)
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}

/// 设置页
struct SettingsView: View {
    var body: some View {
        VStack {
            Text("设置")
                .font(.largeTitle)
            Image(systemName: "gearshape.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
    }
}

#Preview {
    CustomTabBarView()
}
