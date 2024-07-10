//
//  RequestView.swift
//  SwiftUIWeatherApp
//
//  Created by 黑马程序员 on 2024/7/10.
//

import SwiftUI
import Alamofire

/// ### 2.2 发送 GET 请求
struct GetRequestView: View {
    @State private var message = "加载中..."
    
    var body: some View {
        Text(message)
            .onAppear {
                fetchData()
            }
    }
    
    /// 获取数据
    func fetchData() {
        /// 响应结果：
        /// {"message":"这是一个 GET 请求返回的数据"}
        AF.request("http://localhost:3000/api/data").responseDecodable(of: ResponseData.self) { response in
            switch response.result {
            case .success(let data):
                message = data.message
            case .failure(let error):
                message = "请求失败：\(error.localizedDescription)"
            }
        }
    }
}

/// 响应数据结构
struct ResponseData: Decodable {
    let message: String
}

//#Preview {
//    GetRequestView()
//}

/// ### 2.3 发送 POST 请求
struct PostRequestView: View {
    @State private var name = "壹刀流"
    @State private var email = "example@example.com"
    @State private var responseMessage = "等待响应..."
    
    var body: some View {
        VStack {
            TextField("姓名", text: $name)
                .padding()
                .border(Color.gray)
            TextField("邮箱", text: $email)
                .padding()
                .border(Color.gray)
            Button("发送请求") {
                sendData()
            }
            .padding()
            Text(responseMessage)
                .padding()
        }
    }
    
    /// 发送数据
    func sendData() {
        let parameters: [String: Any] = ["name": name, "email": email]
        /// 响应结果：
        /// {
        /// "message": "接收到的 POST 请求数据：姓名 - 壹刀流, 邮箱 - example@example.com"
        /// }
        AF.request("http://localhost:3000/api/data",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default)
        .responseDecodable(of: ResponseData.self) { response in
            switch response.result {
            case .success(let data):
                responseMessage = data.message
            case .failure(let error):
                responseMessage = "请求失败：\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    PostRequestView()
}
