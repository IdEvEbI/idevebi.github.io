//
//  ProductListView.swift
//  SwiftUICartNavigation
//
//  Created by 黑马程序员 on 2024/7/15.
//

import SwiftUI

/// 商品列表视图
struct ProductListView: View {
    @State private var products = [
        Product(name: "商品1",
                price: 10.0,
                description: "这是商品1的描述",
                imageName: "book"),
        Product(name: "商品2",
                price: 20.0,
                description: "这是商品2的描述",
                imageName: "cart"),
        Product(name: "商品3",
                price: 30.0,
                description: "这是商品3的描述",
                imageName: "camera")
    ]
    @State private var cart = [Product]()
    
    var body: some View {
        NavigationView {
            List(products) { product in
                NavigationLink(destination: ProductDetailView(product: product, cart: $cart)) {
                    HStack {
                        Image(systemName: product.imageName)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text(product.name)
                                .font(.headline)
                            Text("\(product.price, specifier: "%.2f") 元")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("商品列表")
            .navigationBarItems(trailing: NavigationLink(destination: CartView(cart: $cart)) {
                Text("购物车(\(cart.count))")
            })
        }
    }
}

#Preview {
    ProductListView()
}
