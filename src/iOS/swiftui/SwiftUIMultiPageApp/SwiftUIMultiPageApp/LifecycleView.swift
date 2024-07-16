//
//  LifecycleView.swift
//  SwiftUIMultiPageApp
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

/// ### 4.1 使用 `onAppear` 和 `onDisappear`
struct LifecycleView: View {
    @State private var homeMessage = "首页尚未加载"
    @State private var searchMessage = "搜索尚未加载"
    
    var body: some View {
        TabView {
            Text(homeMessage)
                .tabItem {
                    Label("首页", systemImage: "house")
                }
                .font(.largeTitle)
                .padding()
                .onAppear {
                    homeMessage = "首页视图已加载"
                    print(homeMessage)
                }
                .onDisappear {
                    homeMessage = "首页视图已消失"
                    print(homeMessage)
                }
            Text(searchMessage)
                .tabItem {
                    Label("搜索", systemImage: "magnifyingglass")
                }
                .font(.largeTitle)
                .padding()
                .onAppear {
                    searchMessage = "搜索视图已加载"
                    print(searchMessage)
                }
                .onDisappear {
                    searchMessage = "搜索视图已消失"
                    print(searchMessage)
                }
        }
    }
}

#Preview {
    LifecycleView()
}
