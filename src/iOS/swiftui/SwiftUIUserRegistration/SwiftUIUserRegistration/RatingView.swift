//
//  RatingView.swift
//  SwiftUIUserRegistration
//
//  Created by 黑马程序员 on 2024/7/2.
//

import SwiftUI

/// ### 2.1 自定义评分控件
struct RatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(index <= rating ? .yellow : .gray)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}

/// ### 测试评分视图
struct TestRatingView: View {
    @State var rating: Int = 3
    
    var body: some View {
        RatingView(rating: $rating)
    }
}

#Preview {
    TestRatingView()
}
