//
//  Contact.swift
//  SwiftUIContacts
//
//  Created by 黑马程序员 on 2024/7/1.
//

import SwiftUI

/// 联系人结构体
struct Contact: Identifiable {
    var id = UUID()             // 唯一标识
    var name: String            // 姓名
    var phoneNumber: String     // 电话
    var image: Image?           // 头像
}
