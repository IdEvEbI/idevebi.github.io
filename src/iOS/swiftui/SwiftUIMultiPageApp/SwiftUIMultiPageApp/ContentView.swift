//
//  ContentView.swift
//  SwiftUIMultiPageApp
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

/// ### 3.2 使用 `@EnvironmentObject` 共享数据
class SharedData: ObservableObject {
    @Published var count = 0
}

struct ContentView: View {
    @StateObject private var sharedData = SharedData()
    
    var body: some View {
        TabView {
            CounterView()
                .tabItem {
                    Label("计数器", systemImage: "number")
                }
            DisplayView()
                .tabItem {
                    Label("显示", systemImage: "eye")
                }
        }
        .environmentObject(sharedData)
    }
}

struct CounterView: View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        VStack {
            Text("计数器：\(sharedData.count)")
                .font(.largeTitle)
                .padding()
            Button("增加计数") {
                sharedData.count += 1
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct DisplayView: View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        VStack {
            Text("当前计数：\(sharedData.count)")
                .font(.largeTitle)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
