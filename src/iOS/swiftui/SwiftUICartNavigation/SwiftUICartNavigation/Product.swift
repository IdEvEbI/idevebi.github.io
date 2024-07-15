//
//  Product.swift
//  SwiftUICartNavigation
//
//  Created by 黑马程序员 on 2024/7/15.
//

import Foundation

/// 商品数据模型
struct Product: Identifiable {
    /// 唯一标识
    var id = UUID()
    /// 商品名称
    var name: String
    /// 价格
    var price: Double
    /// 商品描述
    var description: String
    /// 图像名称
    var imageName: String
}
