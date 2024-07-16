//
//  MultiPageAppView.swift
//  SwiftUIMultiPageApp
//
//  Created by 黑马程序员 on 2024/7/16.
//

import SwiftUI

/// 主视图
struct MultiPageAppView: View {
    @StateObject private var data = SharedProducts()
    
    var body: some View {
        TabView {
            ProductListView()
                .tabItem {
                    Label("商品列表", systemImage: "list.dash")
                }
            CartView()
                .tabItem {
                    Label("购物车", systemImage: "cart")
                }
        }
        .environmentObject(data)
    }
}

/// 商品列表视图
struct ProductListView: View {
    @EnvironmentObject var data: SharedProducts
    
    var body: some View {
        NavigationView {
            List(data.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
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
        }
    }
}

/// 购物车视图
struct CartView: View {
    @EnvironmentObject var data: SharedProducts
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data.cart) { product in
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
    }
    
    private func removeProducts(at offsets: IndexSet) {
        data.cart.remove(atOffsets: offsets)
    }
}

/// 商品详情视图
struct ProductDetailView: View {
    @EnvironmentObject var data: SharedProducts
    var product: Product
    
    var body: some View {
        VStack {
            Image(systemName: product.imageName)
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
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
                data.cart.append(product)
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
    MultiPageAppView()
        .environmentObject(SharedData())
}
