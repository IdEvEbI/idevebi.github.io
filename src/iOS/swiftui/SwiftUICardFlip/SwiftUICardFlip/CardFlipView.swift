//
//  CardFlipView.swift
//  SwiftUICardFlip
//
//  Created by 黑马程序员 on 2024/7/8.
//

import SwiftUI

/// ## 5. 综合案例：卡片翻转动画
struct CardFlipView: View {
    @State private var isFlipped = false
    @State private var rotationAngle = 0.0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(isFlipped ? Color.blue : Color.red)
                .frame(width: 200, height: 300)
                .overlay(
                    Text(isFlipped ? "卡片反面" : "卡片正面")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )
                .rotation3DEffect(.degrees(rotationAngle), axis: (x: 0, y: 1, z: 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        rotationAngle += 180
                        isFlipped.toggle()
                    }
                }
        }
    }
}

#Preview {
    CardFlipView()
}
