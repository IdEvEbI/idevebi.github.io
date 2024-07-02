//
//  PickerToggleView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/2.
//

import SwiftUI

/// ### 1.3 Picker 和 Toggle 等控件
struct PickerToggleView: View {
    @State private var selectedColor = "红色"
    @State private var isOn = false
    
    var colors = ["红色", "绿色", "蓝色"]
    
    var body: some View {
        Form {
            Section(header: Text("颜色选择")) {
                Picker("颜色", selection: $selectedColor) {
                    ForEach(colors, id: \.self) { color in
                        Text(color)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("开关")) {
                Toggle("是否启用", isOn: $isOn)
            }
        }
    }
}

#Preview {
    PickerToggleView()
}
