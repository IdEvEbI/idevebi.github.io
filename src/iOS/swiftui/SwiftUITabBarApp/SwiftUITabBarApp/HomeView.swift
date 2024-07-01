//
//  HomeView.swift
//  SwiftUITabBarApp
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sharedData: SharedData
    
    var body: some View {
        VStack {
            Text("首页")
                .font(.largeTitle)
            TextField("输入一些文字", text: $sharedData.text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .padding()
        .onAppear {
            print("首页出现")
        }
        .onDisappear {
            print("首页消失")
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(SharedData())
}
