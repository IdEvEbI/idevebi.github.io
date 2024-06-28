//
//  CustomContainerExample.swift
//  SwiftUILayoutsExample
//
//  Created by 黑马程序员 on 2024/6/28.
//

import SwiftUI

struct CustomContainer<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            content
        }
        .padding()
        .background(Color.gray.opacity(0.4))
        .cornerRadius(50)
    }
}

struct CustomContainerExample: View {
    var body: some View {
        CustomContainer {
            Text("自定义容器视图")
            Text("SwiftUI")
        }
    }
}

#Preview {
    CustomContainerExample()
}
