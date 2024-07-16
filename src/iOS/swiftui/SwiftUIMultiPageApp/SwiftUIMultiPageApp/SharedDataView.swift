//
//  SharedDataView.swift
//  SwiftUIMultiPageApp
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

/// ### 3.1 使用 `@State` 和 `@Binding` 传递数据
struct ParentView: View {
    @State private var message = "Hello, SwiftUI!"
    
    var body: some View {
        ChildView(message: $message)
    }
}

struct ChildView: View {
    @Binding var message: String
    
    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
                .padding()
            Button("更改消息") {
                message = "Hello, World!"
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    ParentView()
}
