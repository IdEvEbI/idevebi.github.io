//
//  CartView.swift
//  SwiftUICartNavigation
//
//  Created by 黑马程序员 on 2024/7/15.
//

import SwiftUI

/// 购物车视图
struct CartView: View {
    @Binding var cart: [Product]
    @State private var isEditing = false
    
    var body: some View {
        List {
            ForEach(cart) { product in
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
            .onDelete(perform: removeProducts)
        }
        .navigationTitle("购物车")
        .navigationBarItems(trailing: Button(action: {
            isEditing.toggle()
        }) {
            Text(isEditing ? "完成" : "编辑")
                .foregroundColor(.blue)
                .font(.headline)
        })
        .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
    }
    
    private func removeProducts(at offsets: IndexSet) {
        cart.remove(atOffsets: offsets)
    }
}

#Preview {
    NavigationView {
        CartView(cart: .constant([
            Product(name: "商品1",
                    price: 10.0,
                    description: "这是商品1的描述",
                    imageName: "photo"),
            Product(name: "商品2",
                    price: 20.0,
                    description: "这是商品2的描述",
                    imageName: "book")
        ]))
    }
}
