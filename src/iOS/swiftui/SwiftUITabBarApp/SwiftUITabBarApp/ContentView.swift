//
//  ContentView.swift
//  SwiftUITabBarApp
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

struct ContentView: View {
    @StateObject var sharedData = SharedData()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("首页")
                }
                .environmentObject(sharedData)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("搜索")
                }
                .environmentObject(sharedData)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("设置")
                }
        }
    }
}

#Preview {
    ContentView()
}
