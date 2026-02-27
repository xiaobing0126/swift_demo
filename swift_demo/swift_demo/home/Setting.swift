//
//  list.swift
//  iOS_demo
//
//  Created by 小饼子 on 2026/2/24.
//

import SwiftUI

class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }

    func area() ->  Double {
        return sideLength * sideLength
    }

    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}

struct SettingView: View {
    // 示例数据
    @State private var items = [
        "首页",
        "消息",
        "设置",
        "关于我们",
        "帮助中心"
    ]
    
    var body: some View {
        Button {
            let test = Square(sideLength: 5.2, name: "my test square")
            let area = test.area()
            print(area)
            let text = test.simpleDescription()
            print(text)
        } label: {
            Text("test")
        }
        List {
            // 用户信息区域
            Section {
                HStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.blue)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("欢迎回来！")
                            .font(.headline)
                        Text("登录成功")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 8)
            }
            
            // 功能列表
            Section("功能菜单") {
                ForEach(items, id: \.self) { item in
                    NavigationLink {
                        DetailView(title: item)
                    } label: {
                        Label(item, systemImage: iconForItem(item))
                    }
                }
            }
            
            // 退出登录按钮
            Section {
                Button(role: .destructive) {
                    logout()
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("退出登录")
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("主页")
        .navigationBarBackButtonHidden(true)
    }
    
    // 根据菜单项返回对应图标
    private func iconForItem(_ item: String) -> String {
        switch item {
        case "首页": return "house.fill"
        case "消息": return "message.fill"
        case "设置": return "gearshape.fill"
        case "关于我们": return "info.circle.fill"
        case "帮助中心": return "questionmark.circle.fill"
        default: return "circle.fill"
        }
    }
    
    // 退出登录
    private func logout() {
        // 清除 token
        UserDefaults.standard.removeObject(forKey: "userToken")
        print("✅ 已退出登录")
    }
}

// 详情页面
struct DetailView: View {
    let title: String
    
    var body: some View {
        VStack {
            Image(systemName: "doc.text")
                .font(.system(size: 60))
                .foregroundStyle(.blue)
                .padding()
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Text("这是 \(title) 的详情页面")
                .foregroundStyle(.secondary)
                .padding()
            
            Spacer()
        }
        .navigationTitle(title)
    }
}

#Preview {
    NavigationStack {
        SettingView()
    }
}
