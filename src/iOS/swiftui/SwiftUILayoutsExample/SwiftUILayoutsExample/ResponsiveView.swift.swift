//
//  ResponsiveView.swift.swift
//  SwiftUILayoutsExample
//
//  Created by 黑马程序员 on 2024/6/28.
//

import SwiftUI

struct ResponsiveView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if geometry.size.width > 600 {
                    HStack {
                        Text("宽屏模式")
                        Image(systemName: "tv")
                    }
                } else {
                    VStack {
                        Text("窄屏模式")
                        Image(systemName: "iphone")
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .padding()
    }
}

#Preview {
    ResponsiveView()
}
