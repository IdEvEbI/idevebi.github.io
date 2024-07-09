//
//  RatingView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/9.
//

import SwiftUI

/// ### 4.3 创建自定义评分控件
struct RatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { number in
                Image(systemName: number > rating ? "star" : "star.fill")
                    .foregroundColor(number > rating ? .gray : .yellow)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
}

/// 测试评分控件
struct TestRatingView: View {
    @State var rating: Int = 3
    
    var body: some View {
        RatingView(rating: $rating)
            .padding()
        Text("当前评分: \(rating)")
    }
}

#Preview {
    TestRatingView()
}
