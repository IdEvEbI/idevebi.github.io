//
//  EnvironmentObjectExampleView.swift
//  SwiftUITaskManager
//
//  Created by 黑马程序员 on 2024/7/7.
//

import SwiftUI

/// ### 2.4. @EnvironmentObject 属性包装器
/// 全局计数器模型
class GlobalCounterModel: ObservableObject {
    @Published var counter = 0
}

/// 环境对象实例视图
struct EnvironmentObjectExampleView: View {
    @StateObject private var model = GlobalCounterModel()
    
    var body: some View {
        VStack {
            Text("计数器: \(model.counter)")
                .font(.largeTitle)
            Button(action: {
                model.counter += 1
            }) {
                Text("增加")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Divider()
            EnvironmentChildView()
                .environmentObject(model)
        }
    }
}

/// 环境子视图
struct EnvironmentChildView: View {
    @EnvironmentObject var model: GlobalCounterModel
    
    var body: some View {
        Text("环境对象计数器: \(model.counter)")
            .font(.title)
    }
}

#Preview {
    EnvironmentObjectExampleView()
}
