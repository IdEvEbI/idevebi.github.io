//
//  ProductDetailView.swift
//  SwiftUICartNavigation
//
//  Created by 黑马程序员 on 2024/7/15.
//

import SwiftUI

/// 商品详情视图
struct ProductDetailView: View {
    var product: Product
    @Binding var cart: [Product]
    
    var body: some View {
        VStack {
            Image(systemName: product.imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding()
            Text(product.name)
                .font(.largeTitle)
                .padding()
            Text("\(product.price, specifier: "%.2f") 元")
                .font(.title)
                .padding()
            Text(product.description)
                .padding()
            Button("加入购物车") {
                cart.append(product)
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationTitle(product.name)
    }
}

#Preview {
    ProductDetailView(product: Product(name: "商品1",
                                       price: 10.0,
                                       description: "这是商品1的描述",
                                       imageName: "photo"),
                      cart: .constant([]))
}
