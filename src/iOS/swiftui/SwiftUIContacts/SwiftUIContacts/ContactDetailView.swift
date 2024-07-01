//
//  ContactDetailView.swift
//  SwiftUIContacts
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

struct ContactDetailView: View {
    @Binding var contact: Contact  // 绑定联系人数据
    @State private var showingImagePicker = false  // 显示图片选择器的状态
    
    var body: some View {
        VStack {
            if let image = contact.image {
                image
                    .resizable()  // 调整图像大小
                    .frame(width: 200, height: 200)  // 设置图像的宽度和高度
                    .clipShape(Circle())  // 裁剪为圆形
                    .shadow(radius: 10)  // 添加阴影
                    .padding()  // 添加内边距
            } else {
                Circle()
                    .fill(Color.gray)  // 灰色填充
                    .frame(width: 200, height: 200)  // 设置圆形的宽度和高度
                    .padding()  // 添加内边距
            }
            Button("上传头像") {
                showingImagePicker.toggle()  // 切换图片选择器的显示状态
            }
            .padding()  // 添加内边距
            .background(Color.blue)  // 设置按钮背景颜色为蓝色
            .foregroundColor(.white)  // 设置按钮文字颜色为白色
            .cornerRadius(10)  // 设置按钮圆角
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $contact.image)  // 显示图片选择器
            }
            Spacer()  // 占用剩余空间
        }
        .navigationTitle(contact.name)  // 设置导航标题为联系人姓名
    }
}

#Preview {
    ContactDetailView(contact: .constant(Contact(name: "张三", phoneNumber: "123-456-7890", image: nil)))
}
