//
//  SearchView.swift
//  SwiftUITabBarApp
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        VStack {
            Text("搜索")
                .font(.largeTitle)
            Text("你输入的是： \(sharedData.text)")
                .padding()
        }
        .padding()
        .onAppear {
            print("搜索页面出现")
        }
        .onDisappear {
            print("搜索页面消失")
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(SharedData())
}
