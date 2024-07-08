//
//  PersonCardView.swift
//  SwiftUIPersonCard
//
//  Created by 黑马程序员 on 2024/7/8.
//

import SwiftUI

/// ## 4. 综合案例：个人信息卡片
/// 个人信息模型
struct Person {
    var name: String                    // 姓名
    var age: Int                        // 年龄
    var occupation: String              // 职业
}

/// 自定义修饰符
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.white)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding()
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
}

/// 带有状态的个人信息视图
struct StatefulPersonCardView: View {
    @State private var person: Person = Person(name: "壹刀流", 
                                               age: 30,
                                               occupation: "iOS 开发工程师")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("姓名: \(person.name)")
                .font(.headline)
            Text("年龄: \(person.age)")
                .font(.subheadline)
            Text("职业: \(person.occupation)")
                .font(.subheadline)
            Button("修改信息") {
                person.name = "新名字"
                person.age = 25
                person.occupation = "全栈开发工程师"
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .cardStyle()
    }
}

/// 带有绑定的个人信息视图
struct BindingPersonCardView: View {
    @Binding var person: Person
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("姓名: \(person.name)")
                .font(.headline)
            Text("年龄: \(person.age)")
                .font(.subheadline)
            Text("职业: \(person.occupation)")
                .font(.subheadline)
        }
        .cardStyle()
    }
}

/// 综合示例视图
struct PersonCardExampleView: View {
    @State private var person = Person(name: "壹刀流", 
                                       age: 30,
                                       occupation: "iOS 开发工程师")
    
    var body: some View {
        VStack {
            StatefulPersonCardView()
            BindingPersonCardView(person: $person)
            Button("修改绑定信息") {
                person.name = "新名字（绑定）"
                person.age = 28
                person.occupation = "后端开发工程师"
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

#Preview {
    PersonCardExampleView()
}
