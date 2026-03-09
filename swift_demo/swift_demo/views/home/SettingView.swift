//
//  list.swift
//  iOS_demo
//
//  Created by 小饼子 on 2026/2/24.
//

import SwiftUI

struct SettingView: View {
    // 示例数据
    @State private var items = [
        "首页",
        "消息",
        "设置",
        "关于我们",
        "帮助中心"
    ]
    
    // swift 练习 —— 用结构体携带 id
    struct PracticeItem: Identifiable, Hashable {
        let id: Int
        let name: String
    }
    
    @State private var lists: [PracticeItem] = [
        PracticeItem(id: 1, name: "swift初见"),
        PracticeItem(id: 2, name: "swift基础部分")
    ]
    
    // ✅ 用 @State 控制跳转目标（存储选中的 item）
    @State private var selectedItem: PracticeItem?
    
    var body: some View {
        
        List {
            Section("练习菜单") {
                ForEach(lists) { item in
                    // ✅ 用 Button，在 action 里执行逻辑后触发跳转
                    Button {
                        // 这里可以写任意逻辑：打印日志、条件判断、数据处理等
                        print("点击了 \(item.name), id = \(item.id)")
                        selectedItem = item  // 所有都跳转，只是演示可以加条件
                    } label: {
                        HStack {
                            Text(item.name)
                                .foregroundStyle(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
        // ✅ 监听 selectedItem 变化，自动跳转到对应页面
        .navigationDestination(item: $selectedItem) { item in
            if item.id == 1 {
                SwiftPracticeView(id: item.id, title: item.name)
            } else if item.id == 2 {
                SwiftBaseView(id: item.id, title: item.name)
            }
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
