//
//  CustomCard.swift
//  SwiftUICardView
//
//  Created by 黑马程序员 on 2024/6/29.
//

import SwiftUI

struct CustomCard: View {
    var title: String
    var description: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    CustomCard(title: "标题", description: "描述信息")
}
