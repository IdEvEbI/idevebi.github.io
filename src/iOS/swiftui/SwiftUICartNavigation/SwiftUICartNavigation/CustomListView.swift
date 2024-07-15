//
//  CustomListView.swift
//  SwiftUICartNavigation
//
//  Created by 黑马程序员 on 2024/7/15.
//

import SwiftUI

/// ### 1.1 创建简单列表
struct SimpleListView: View {
    let items = ["苹果", "香蕉", "橙子", "西瓜"]
    
    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
        }
    }
}

//#Preview {
//    SimpleListView()
//}

/// ### 1.2 自定义列表单元格
struct CustomListView: View {
    let items = ["苹果", "香蕉", "橙子", "西瓜"]
    
    var body: some View {
        List(items, id: \.self) { item in
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(item)
                    .font(.headline)
            }
        }
    }
}

//#Preview {
//    CustomListView()
//}

/// ### 1.3 动态列表
struct Fruit: Identifiable {
    /// ID 唯一标识符
    var id = UUID()
    /// 名称
    var name: String
}

struct DynamicListView: View {
    @State private var fruits = [
        Fruit(name: "苹果"),
        Fruit(name: "香蕉"),
        Fruit(name: "橙子"),
        Fruit(name: "西瓜")
    ]
    @State private var newFruitName = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("输入水果名称", text: $newFruitName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("添加") {
                    addFruit()
                }
                .padding()
            }
            List(fruits) { fruit in
                Text(fruit.name)
                    .font(.headline)
            }
        }
        .padding()
    }
    
    /// 添加水果
    private func addFruit() {
        // 判断内容是否为空
        guard !newFruitName.isEmpty else { return }
        // 新建水果对象
        let newFruit = Fruit(name: newFruitName)
        // 添加到 fruits 数组
        fruits.append(newFruit)
        // 清空 newFruitName 达到清空文本框的效果
        newFruitName = ""
    }
}

//#Preview {
//    DynamicListView()
//}

/// ### 1.4 Section 和 GroupedListStyle
struct SectionedListView: View {
    var body: some View {
        List {
            Section(header: Text("水果")) {
                Text("苹果")
                Text("香蕉")
            }
            Section(header: Text("蔬菜")) {
                Text("西红柿")
                Text("黄瓜")
            }
        }
        .listStyle(GroupedListStyle())
    }
}

//#Preview {
//    SectionedListView()
//}

/// ### 1.5 动态列表和静态列表
struct MixedListView: View {
    let dynamicItems = ["苹果", "香蕉", "橙子"]
    
    var body: some View {
        List {
            Section(header: Text("动态列表")) {
                ForEach(dynamicItems, id: \.self) { item in
                    Text(item)
                }
            }
            Section(header: Text("静态列表")) {
                Text("西瓜")
                Text("梨")
            }
        }
        .listStyle(GroupedListStyle())
    }
}

//#Preview {
//    MixedListView()
//}

/// ### 1.6 复杂单元格的定制
struct ComplexItemView: View {
    var title: String
    var subtitle: String
    var images: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack {
                ForEach(images, id: \.self) { image in
                    Image(systemName: image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

struct ComplexListView: View {
    let items = [
        ("新闻标题1", "发布时间：2024-01-01", ["photo", "globe", "heart", "house", "gear"]),
        ("新闻标题2", "发布时间：2024-01-02", ["cart", "bell", "camera", "book"]),
        ("新闻标题3", "发布时间：2024-01-03", [])
    ]
    
    var body: some View {
        List(items, id: \.0) { item in
            ComplexItemView(title: item.0, subtitle: item.1, images: item.2)
        }
    }
}

#Preview {
    ComplexListView()
}
