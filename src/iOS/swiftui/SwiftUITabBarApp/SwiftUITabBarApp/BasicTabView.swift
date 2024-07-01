//
//  BasicTabView.swift
//  SwiftUITabBarApp
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

/// ### 1.1 创建 TabView
struct BasicTabView: View {
    var body: some View {
        TabView {
            Text("首页")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首页")
                }
            Text("搜索")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("搜索")
                }
            Text("设置")
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("设置")
                }
        }
    }
}

#Preview {
    BasicTabView()
}
