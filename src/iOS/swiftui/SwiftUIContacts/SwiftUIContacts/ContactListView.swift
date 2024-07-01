//
//  ContactListView.swift
//  SwiftUIContacts
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

/// 联系人列表视图
struct ContactListView: View {
    @State private var contacts = [
        Contact(name: "张三", phoneNumber: "123-456-7890", image: Image(systemName: "person.circle")),
        Contact(name: "李四", phoneNumber: "987-654-3210", image: nil)
    ]
    
    var body: some View {
        NavigationView {
            List($contacts) { $contact in
                NavigationLink(destination: ContactDetailView(contact: $contact)) {
                    HStack {
                        if let image = contact.image {
                            image
                                .resizable()  // 调整图像大小
                                .frame(width: 50, height: 50)  // 设置图像的宽度和高度
                                .clipShape(Circle())  // 裁剪为圆形
                                .shadow(radius: 5)  // 添加阴影
                        } else {
                            Circle()
                                .fill(Color.gray)  // 灰色填充
                                .frame(width: 50, height: 50)  // 设置圆形的宽度和高度
                        }
                        VStack(alignment: .leading) {
                            Text(contact.name)
                                .font(.headline)  // 设置字体为标题
                            Text(contact.phoneNumber)
                                .font(.subheadline)  // 设置字体为副标题
                                .foregroundColor(.gray)  // 字体颜色为灰色
                        }
                    }
                }
            }
            .navigationTitle("联系人列表")  // 设置导航标题
        }
    }
}

#Preview {
    ContactListView()
}
