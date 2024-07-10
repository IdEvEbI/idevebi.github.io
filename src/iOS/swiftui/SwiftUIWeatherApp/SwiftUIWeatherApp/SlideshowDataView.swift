//
//  SlideshowDataView.swift
//  SwiftUIWeatherApp
//
//  Created by 黑马程序员 on 2024/7/10.
//

import SwiftUI
import Alamofire

/// ### 3.1 Slideshow 数据结构
struct Slideshow: Codable {
    struct Slide: Identifiable, Codable {
        let id: UUID? = UUID()  // 用于为 List 提供数据源，使用可选类型并提供默认值
        let title: String
        let type: String
        let items: [String]?
        
        // 手动添加 CodingKeys 枚举，确保 id 不会被解码
        enum CodingKeys: String, CodingKey {
            case title, type, items
        }
    }
    
    let author: String
    let date: String
    let slides: [Slide]
    let title: String
}

/// 响应数据模型
struct SlideshowResponse: Codable {
    let slideshow: Slideshow
}

/// ### 3.2 数据解析示例
struct SlideshowDataView: View {
    @State private var slideshow: Slideshow?
    
    var body: some View {
        VStack {
            if let slideshow = slideshow {
                Text(slideshow.title)
                    .font(.largeTitle)
                    .padding()
                Text("作者: \(slideshow.author)")
                Text("日期: \(slideshow.date)")
                List(slideshow.slides) { slide in
                    VStack(alignment: .leading) {
                        Text(slide.title)
                            .font(.headline)
                        if let items = slide.items {
                            ForEach(items, id: \.self) { item in
                                Text(item)
                                    .padding(.leading, 10)
                            }
                        }
                    }
                }
            } else {
                Text("加载中...")
                    .onAppear {
                        fetchComplexData()
                    }
            }
        }
    }
    
    /// 获取复杂数据
    func fetchComplexData() {
        AF.request("http://localhost:3000/api/complex-data")
            .responseDecodable(of: SlideshowResponse.self) { response in
                switch response.result {
                case .success(let data):
                    slideshow = data.slideshow
                case .failure(let error):
                    print("请求失败：\(error.localizedDescription)")
                }
            }
            // 开发技巧：输出响应字符串可以辅助 数据模型 定义
            .responseString { response in
                switch response.result {
                case .success(let responseString):
                    print("响应字符串: \(responseString)")
                case .failure(let error):
                    print( "请求失败：\(error.localizedDescription)")
                }
            }
    }
}

#Preview {
    SlideshowDataView()
}
