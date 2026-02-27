//
//  ClassAndStruct_demo.swift
//  iOS_demo
//
//  复杂对象响应式更新示例
//

import SwiftUI

// MARK: - 方法一：@Observable (iOS 17+ 推荐)

// 1️⃣ 使用 @Observable 标记类
@Observable
class UserProfile {
    var name: String = "" // 所有属性自动响应
    var age: Int = 18
    var email: String = ""
    var isVIP: Bool = false
    var address: Address = Address() // 嵌套对象
    var hobbies: [String] = []
    
    // 计算属性也会自动响应
    var displayInfo: String {
        "\(name), \(age)岁, \(isVIP ? "VIP会员" : "普通用户")"
    }
    
    // 2️⃣ 嵌套对象也要标记为 @Observable，才能实现响应式更新
    // 嵌套对象
    @Observable
    class Address {
        var province: String = ""
        var city: String = ""
        var street: String = ""
        
        var fullAddress: String {
            "\(province) \(city) \(street)"
        }
    }
    
    // 方法
    func addHobby(_ hobby: String) {
        if !hobby.isEmpty && !hobbies.contains(hobby) {
            hobbies.append(hobby)
        }
    }
    
    func removeHobby(at index: Int) {
        hobbies.remove(at: index)
    }
}


struct PersonProfile {
    var name: String = "" // private var自动响应
    var age: Int = 18
    var info: String {
        "\(name), \(age)岁"
    }
}

// MARK: - 示例视图

struct ClassAndStructView: View {
    // 3️⃣ 在视图中使用 @State 来持有 @Observable 对象实例
    @State private var user = UserProfile()
    @State private var newHobby = ""
    
    @State private var person = PersonProfile() // private var自动响应
    
    var body: some View {
        NavigationStack {
            Form {
                Section("struct演示：PersonProfile") {
                    TextField("姓名:", text: $person.name) // 计算属性自动更新
                    Stepper("年龄: \(person.age)", value: $person.age, in: 1...120)
                    Text(person.info) // 计算属性自动更新
                }
                
                // 基本信息
                Section("class演示：UserProfile") {
                    // 4️⃣ 使用 $ 绑定属性，任何修改都会自动更新视图
                    TextField("姓名", text: $user.name)
                    
                    Stepper("年龄: \(user.age)", value: $user.age, in: 1...120)
                    
                    TextField("邮箱", text: $user.email)
                        .keyboardType(.emailAddress)
                    
                    Toggle("VIP会员", isOn: $user.isVIP)
                }
                
                // 地址信息 - 嵌套对象绑定
                Section("地址信息") {
                    TextField("省份", text: $user.address.province)
                    TextField("城市", text: $user.address.city)
                    TextField("街道", text: $user.address.street)
                }
                
                // 爱好列表 - 数组操作
                Section("爱好") {
                    HStack {
                        TextField("添加爱好", text: $newHobby)
                        Button("添加") {
                            user.addHobby(newHobby)
                            newHobby = ""
                        }
                        .disabled(newHobby.isEmpty)
                    }
                    
                    ForEach(user.hobbies.indices, id: \.self) { index in
                        Text(user.hobbies[index])
                    }
                    .onDelete { indexSet in
                        user.hobbies.remove(atOffsets: indexSet)
                    }
                }
                
                // 实时预览 - 数据变化自动更新
                Section("实时预览") {
                    // 5️⃣ 数据变化时自动更新。只读信息不用$，需要双向绑定的才需要$修饰
                    Text(user.displayInfo)
                        .font(.headline)
                    
                    if !user.address.fullAddress.trimmingCharacters(in: .whitespaces).isEmpty {
                        Text("地址: \(user.address.fullAddress)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    if !user.hobbies.isEmpty {
                        Text("爱好: \(user.hobbies.joined(separator: ", "))")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("用户资料")
        }
    }
}

// MARK: - Preview

#Preview {
    ClassAndStructView()
}
