//
//  TwoColumnView.swift
//  SwiftUILayoutsExample
//
//  Created by 黑马程序员 on 2024/7/7.
//

import SwiftUI

/// ## 4. 自定义容器视图 - 两列布局视图
struct TwoColumnView<Content: View>: View {
    let leftTitle: String               // 左侧标题
    let leftContent: Content            // 左侧内容
    let rightTitle: String              // 右侧标题
    let rightContent: Content           // 右侧内容

    init(leftTitle: String, rightTitle: String, @ViewBuilder leftContent: () -> Content, @ViewBuilder rightContent: () -> Content) {
        self.leftTitle = leftTitle
        self.rightTitle = rightTitle
        self.leftContent = leftContent()
        self.rightContent = rightContent()
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(leftTitle)
                    .font(.headline)
                leftContent
            }
            .padding()
            .background(.gray)
            Spacer()
            VStack(alignment: .leading) {
                Text(rightTitle)
                    .font(.headline)
                rightContent
            }
            .padding()
            .background(.yellow)
        }
    }
}

#Preview {
    TwoColumnView(leftTitle: "左列标题", rightTitle: "右列标题", leftContent: {
        Text("左列项目 1")
        Text("左列项目 2")
    }, rightContent: {
        Text("右列项目 1")
        Text("右列项目 2")
    })
}
