//
//  WeatherView.swift
//  SwiftUIWeatherApp
//
//  Created by 黑马程序员 on 2024/7/10.
//

import SwiftUI
import Alamofire

/// ## 5. 综合案例：天气应用
/// 天气结果数据模型
struct WeatherResult: Codable {
    /// 位置数据模型
    struct Location: Codable {
        let name: String
    }
    
    /// 当前天气数据模型
    struct Now: Codable {
        let text: String
        let temperature: String
    }
    
    let location: Location
    let now: Now
    let last_update: String
}

/// 响应数据模型
struct WeatherResponse: Codable {
    let results: [WeatherResult]
}

/// 天气查询视图
struct WeatherView: View {
    @State private var city: String = "beijing"
    @State private var weatherInfo: WeatherResult?
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            TextField("输入城市名称", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("查询天气") {
                print("开始查询天气")
                fetchWeather()
            }
            .padding()
            
            if let weatherInfo = weatherInfo {
                Text("城市: \(weatherInfo.location.name)")
                Text("天气: \(weatherInfo.now.text)")
                Text("温度: \(weatherInfo.now.temperature)°C")
                Text("更新时间: \(weatherInfo.last_update)")
            } else if let errorMessage = errorMessage {
                Text("错误: \(errorMessage)")
                    .foregroundColor(.red)
            } else {
                Text("请输入城市名称并查询")
            }
        }
        .padding()
    }
    
    /// 获取天气信息
    func fetchWeather() {
        let parameters: [String: String] = ["location": city,
                                            "key": "SZVdOwLAmFIbRNmkC",
                                            "language": "zh-Hans",
                                            "unit": "c"]
        AF.request("https://api.seniverse.com/v3/weather/now.json",
                   parameters: parameters)
        .responseDecodable(of: WeatherResponse.self) { response in
            switch response.result {
            case .success(let data):
                weatherInfo = data.results.first
                print(data)
                print("响应结果")
            case .failure(let error):
                errorMessage = "请求失败：\(error.localizedDescription)"
            }
        }
        // 根据响应字符串辅助 天气结果数据模型 定义
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
    WeatherView()
}
