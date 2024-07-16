//
//  Product.swift
//  SwiftUIMultiPageApp
//
//  Created by 黑马程序员 on 2024/7/16.
//

import Foundation

/// 商品数据模型
struct Product: Identifiable {
    /// 唯一标识
    var id = UUID()
    /// 商品名称
    var name: String
    /// 商品价格
    var price: Double
    /// 商品描述
    var description: String
    /// 图像名称
    var imageName: String
}

/// 共享商品数据
class SharedProducts: ObservableObject {
    /// 初始商品列表
    @Published var products: [Product] = [
        Product(name: "苹果", price: 9.9, description: "一种美味的水果", imageName: "book"),
        Product(name: "香蕉", price: 19.9, description: "富含钾的水果", imageName: "cart"),
        Product(name: "橙子", price: 29.9, description: "富含维生素C的水果", imageName: "camera")
    ]
    
    /// 购物车列表
    @Published var cart: [Product] = []
}
