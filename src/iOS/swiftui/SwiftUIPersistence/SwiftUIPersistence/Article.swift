//
//  Article.swift
//  SwiftUIPersistence
//
//  Created by 黑马程序员 on 2024/7/15.
//

import Foundation

/// ### 6.2 新闻数据模型
struct Article: Identifiable, Codable {
    /// 新闻 ID
    var id: UUID
    /// 新闻标题
    var title: String
    /// 新闻内容
    var content: String
    /// 发布时间
    var publishedAt: String
    /// 是否多图
    var isMultiImage: Bool
    /// 图像 URL 字符串数组（可选）
    var images: [String]?
    /// 新闻作者
    var author: Author
    
    struct Author: Codable {
        /// 作者姓名
        var name: String
        /// 用户头像 URL 字符串
        var profileImageURL: String
    }
}

/// 新闻响应模型，返回新闻数据数组
struct NewsResponse: Codable {
    var articles: [Article]
}
