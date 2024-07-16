//
//  ResponsiveLayoutView.swift
//  SwiftUILayoutsExample
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

/// 响应式视图案例
struct ResponsiveLayoutView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("响应式布局示例")
                    .font(.largeTitle)
                    .padding()
                HStack {
                    Text("左侧视图")
                        .frame(width: geometry.size.width * 0.3)
                        .background(.red)
                        .padding()
                    Spacer()
                    Text("右侧视图")
                        .frame(width: geometry.size.width * 0.3)
                        .background(.blue)
                        .padding()
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("底部视图")
                        .padding()
                        .background(.green)
                    Spacer()
                }
                .padding(.bottom, 20)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    ResponsiveLayoutView()
}
