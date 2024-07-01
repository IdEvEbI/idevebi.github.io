//
//  SettingsView.swift
//  SwiftUITabBarApp
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("设置")
                .font(.largeTitle)
        }
        .padding()
        .onAppear {
            print("设置页面出现")
        }
        .onDisappear {
            print("设置页面消失")
        }
    }
}

#Preview {
    SettingsView()
}
