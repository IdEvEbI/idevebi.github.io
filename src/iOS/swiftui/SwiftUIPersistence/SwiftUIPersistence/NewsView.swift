//
//  NewsView.swift
//  SwiftUIPersistence
//
//  Created by 黑马程序员 on 2024/7/15.
//

import SwiftUI
import SQLite

/// ### 6.3.1 新闻视图展示
struct NewsView: SwiftUI.View {
    /// 新闻列表数组
    @State private var articles: [Article] = []
    /// 定时器
    @State private var timer: Timer?
    /// 默认新闻页面
    @State private var page: Int = 1
    
    /// 数据库连接对象
    private var db: Connection?
    /// 数据表及数据列定义
    private var articlesTable = Table("articles")
    private var idColumn = Expression<String>("id")
    private var titleColumn = Expression<String>("title")
    private var contentColumn = Expression<String>("content")
    private var publishedAtColumn = Expression<String>("publishedAt")
    private var isMultiImageColumn = Expression<Bool>("isMultiImage")
    private var imagesColumn = Expression<String>("images")
    private var authorNameColumn = Expression<String>("authorName")
    private var authorProfileImageURLColumn = Expression<String>("authorProfileImageURL")
    
    /// 文档目录路径
    var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }
    
    init() {
        setupDatabase()
        // 获取缓存新闻
        fetchCachedArticles()
        // 启动始终定时刷新
        startTimer()
    }
    
    var body: some SwiftUI.View {
        NavigationView {
            List {
                ForEach(articles) { article in
                    VStack(alignment: .leading) {
                        Text(article.title)
                            .font(.headline)
                        Text("作者: \(article.author.name)")
                            .font(.subheadline)
                        Text(article.content)
                            .font(.body)
                    }
                }
                .onAppear {
                    // 加载更多新闻
                    loadMoreArticles()
                }
                if articles.isEmpty {
                    Text("加载中...")
                        .onAppear {
                            // 获取新闻
                            fetchArticles()
                        }
                }
            }
            .refreshable {
                // 获取新闻
                fetchArticles()
            }
            .navigationTitle("新闻列表")
        }
    }
    
    /// 设置数据库
    mutating func setupDatabase() {
        do {
            db = try Connection(documentsDirectory.appendingPathComponent("news.sqlite3").path)
            try db?.run(articlesTable.create(ifNotExists: true) { t in
                t.column(idColumn, primaryKey: true)
                t.column(titleColumn)
                t.column(contentColumn)
                t.column(publishedAtColumn)
                t.column(isMultiImageColumn)
                t.column(imagesColumn)
                t.column(authorNameColumn)
                t.column(authorProfileImageURLColumn)
            })
        } catch {
            print("数据库连接失败：\(error.localizedDescription)")
        }
    }
}

/// ### 6.3.2 Mock 数据和新闻缓存
extension NewsView {
    /// 从服务器获取新闻数据
    func fetchArticles() {
        print("从服务器获取新闻数据")
        
        let mockData = """
        {
            "articles": [
                {
                    "id": "b1b1b1b1-b1b1-b1b1-b1b1-b1b1b1b1b1b1",
                    "title": "新闻标题 1",
                    "content": "新闻内容 1",
                    "publishedAt": "2024-06-01",
                    "isMultiImage": false,
                    "images": [],
                    "author": {
                        "name": "作者 1",
                        "profileImageURL": "https://example.com/avatar1.jpg"
                    }
                },
                {
                    "id": "c1c1c1c1-c1c1-c1c1-c1c1-c1c1c1c1c1c1",
                    "title": "新闻标题 2",
                    "content": "新闻内容 2",
                    "publishedAt": "2024-06-02",
                    "isMultiImage": true,
                    "images": ["https://example.com/image1.jpg", "https://example.com/image2.jpg"],
                    "author": {
                        "name": "作者 2",
                        "profileImageURL": "https://example.com/avatar2.jpg"
                    }
                }
            ]
        }
        """
        
        if let data = mockData.data(using: .utf8) {
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(NewsResponse.self, from: data)
                if page == 1 {
                    articles = response.articles
                } else {
                    articles.append(contentsOf: response.articles)
                }
                saveArticlesToCache(response.articles)
                page += 1
            } catch {
                print("解析 Mock 数据失败：\(error.localizedDescription)")
            }
        }
    }
    
    /// 从缓存获取新闻数据
    func fetchCachedArticles() {
        guard let db = db else { return }
        do {
            let cachedArticles = try db.prepare(articlesTable)
            articles = cachedArticles.map { row in
                Article(
                    id: UUID(uuidString: row[idColumn])!,
                    title: row[titleColumn],
                    content: row[contentColumn],
                    publishedAt: row[publishedAtColumn],
                    isMultiImage: row[isMultiImageColumn],
                    images: row[imagesColumn].components(separatedBy: ","),
                    author: Article.Author(
                        name: row[authorNameColumn],
                        profileImageURL: row[authorProfileImageURLColumn]
                    )
                )
            }
        } catch {
            print("获取缓存数据失败：\(error.localizedDescription)")
        }
    }
    
    /// 保存新闻数据到缓存
    func saveArticlesToCache(_ articles: [Article]) {
        guard let db = db else { return }
        do {
            for article in articles {
                try db.run(articlesTable.insert(
                    or: .replace,
                    idColumn <- article.id.uuidString,
                    titleColumn <- article.title,
                    contentColumn <- article.content,
                    publishedAtColumn <- article.publishedAt,
                    isMultiImageColumn <- article.isMultiImage,
                    imagesColumn <- article.images?.joined(separator: ",") ?? "",
                    authorNameColumn <- article.author.name,
                    authorProfileImageURLColumn <- article.author.profileImageURL
                ))
            }
        } catch {
            print("保存缓存数据失败：\(error.localizedDescription)")
        }
    }
    
    /// 加载更多新闻
    func loadMoreArticles() {
        fetchArticles()
    }
    
    /// 启动定时器
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60 * 60, repeats: true) { _ in
            page = 1
            fetchArticles()
        }
    }
}

#Preview {
    NewsView()
}
