//
//  NavigationExampleView.swift
//  SwiftUICartNavigation
//
//  Created by 黑马程序员 on 2024/7/15.
//

import SwiftUI

/// ### 2.1 使用 NavigationView 和 NavigationLink
struct NavigationExampleView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("这是第二个视图")) {
                    Text("点击导航到第二个视图")
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("导航示例")
        }
    }
}

//#Preview {
//    NavigationExampleView()
//}

/// ### 2.2 列表中的导航
struct FruitDetailView: View {
    var fruit: String
    
    var body: some View {
        Text("你选择了 \(fruit)")
            .font(.largeTitle)
            .padding()
    }
}

struct NavigableListView: View {
    let fruits = ["苹果", "香蕉", "橙子", "西瓜"]
    
    var body: some View {
        NavigationView {
            List(fruits, id: \.self) { fruit in
                NavigationLink(destination: FruitDetailView(fruit: fruit)) {
                    Text(fruit)
                }
            }
            .navigationTitle("水果列表")
        }
    }
}

//#Preview {
//    NavigableListView()
//}

/// ### 2.3 视图间的导航和传递数据
struct Item: Identifiable {
    var id = UUID()
    var name: String
    var description: String
}

struct ItemDetailView: View {
    var item: Item
    
    var body: some View {
        VStack {
            Text(item.name)
                .font(.largeTitle)
                .padding()
            Text(item.description)
                .padding()
            Spacer()
        }
        .navigationTitle("详细信息")
    }
}

struct ItemListView: View {
    let items = [
        Item(name: "苹果", description: "一种美味的水果"),
        Item(name: "香蕉", description: "富含钾的水果"),
        Item(name: "橙子", description: "富含维生素C的水果")
    ]
    
    var body: some View {
        NavigationView {
            List(items) { item in
                NavigationLink(destination: ItemDetailView(item: item)) {
                    Text(item.name)
                }
            }
            .navigationTitle("水果列表")
        }
    }
}

//#Preview {
//    ItemListView()
//}

/// ### 2.4 模态视图和全屏视图
struct ModalExampleView: View {
    @State private var showModal = false
    @State private var showFullScreen = false
    
    var body: some View {
        VStack {
            Button("显示模态视图") {
                showModal.toggle()
            }
            .padding()
            .sheet(isPresented: $showModal) {
                ModalContentView(isPresented: $showModal)
            }
            
            Button("显示全屏视图") {
                showFullScreen.toggle()
            }
            .padding()
            .fullScreenCover(isPresented: $showFullScreen) {
                FullScreenContentView(isPresented: $showFullScreen)
            }
        }
    }
}

struct ModalContentView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("这是一个模态视图")
                .font(.largeTitle)
                .padding()
            Button("关闭") {
                isPresented = false
            }
            .padding()
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

struct FullScreenContentView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("这是一个全屏视图")
                .font(.largeTitle)
                .padding()
            Button("关闭") {
                isPresented = false
            }
            .padding()
            .background(.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    ModalExampleView()
}
