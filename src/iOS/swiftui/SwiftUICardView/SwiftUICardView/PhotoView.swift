//
//  PhotoView.swift
//  SwiftUICardView
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

struct PhotoView: View {
    var photo: Photo

    var body: some View {
        VStack {
            Image(photo.imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(10)
                .shadow(radius: 10)
            Text(photo.title)
                .font(.headline)
                .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

#Preview {
    PhotoView(photo: Photo(imageName: "example", title: "示例照片"))
}
