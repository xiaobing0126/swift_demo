//
//  SettingView.swift
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
        "帮助中心",
    ]

    // swift 练习 —— 用结构体携带 id + 目标页面
    struct PracticeItem: Identifiable, Hashable {
        let id: Int
        let name: String
        // 用闭包返回目标页面，避免立即初始化 AnyView
        let destination: () -> AnyView

        // Hashable 只比较 id，destination 闭包不参与比较
        static func == (lhs: PracticeItem, rhs: PracticeItem) -> Bool { lhs.id == rhs.id }
        func hash(into hasher: inout Hasher) { hasher.combine(id) }
    }
    
    @State private var uilist: [PracticeItem] = [
        PracticeItem(id: 1, name: "swift组件",    destination: { AnyView(SwiftUIComponentView()) }),
    ]

    @State private var lists: [PracticeItem] = [
        PracticeItem(id: 1, name: "swift初见",    destination: { AnyView(SwiftPracticeView(id: 1, title: "swift初见")) }),
        PracticeItem(id: 2, name: "swift基础部分", destination: { AnyView(SwiftBaseView(id: 2, title: "swift基础部分")) }),
        PracticeItem(id: 3, name: "swift字符串",   destination: { AnyView(SwiftStringView()) }),
        PracticeItem(id: 4, name: "swift集合类型", destination: { AnyView(SwiftCollectionView()) }),
        PracticeItem(id: 5, name: "swift函数",    destination: { AnyView(SwiftFunctionView()) }),
        PracticeItem(id: 6, name: "swift属性",    destination: { AnyView(SwiftPropertyView()) }),
        PracticeItem(id: 7, name: "swift下标", destination: { AnyView(SwiftIndexView()) }),
        PracticeItem(id: 8, name: "swift继承", destination: { AnyView(SwiftInheritanceView()) }),
        PracticeItem(id: 9, name: "swift可选链式调用", destination: { AnyView(SwiftOptionalChainingView()) }),
        PracticeItem(id: 10, name: "swift错误处理", destination: { AnyView(SwiftErrorHandleView()) }),
        PracticeItem(id: 11, name: "swift类型转换", destination: { AnyView(SwiftTypeConversionView()) }),
        PracticeItem(id: 12, name: "swift嵌套类型", destination:  { AnyView(SwiftNestedTypeView()) }),
        PracticeItem(id: 13, name: "swift扩展", destination:  { AnyView(SwiftExtensionView()) }),
        PracticeItem(id: 14, name: "swift协议", destination:  { AnyView(SwiftProtocolView()) })
    ]

    // ✅ 用 @State 控制跳转目标（存储选中的 item）
    @State private var selectedItem: PracticeItem?

    var body: some View {
        List {
            Section("UI组件") {
                ForEach(uilist) { item in
                    Button(action: {
                        print("点击了 \(item.name), id = \(item.id)")
                        selectedItem = item
                    }, label: {
                        //水平布局，左边是文本，右边是箭头
                        HStack {
                            Text(item.name)
                                .foregroundStyle(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                    })
                }
            }
            
            Section("练习菜单") {
                ForEach(lists) { item in
                    Button(action: {
                        print("点击了 \(item.name), id = \(item.id)")
                        selectedItem = item
                    }, label: {
                        HStack {
                            Text(item.name)
                                .foregroundStyle(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                        }
                    })
                }
            }

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
                ForEach(items, id: \.self, content: { item in
                    NavigationLink(destination: {
                        DetailView(title: item)
                    }, label: {
                        Label(item, systemImage: iconForItem(item))
                    })
                })
            }

            // 退出登录按钮
            Section {
                Button(role: .destructive, action: {
                    logout()
                }, label: {
                    HStack {
                        Spacer()
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("退出登录")
                        Spacer()
                    }
                })
            }
        }
        .navigationTitle("主页")
        .navigationBarBackButtonHidden(true)
        // ✅ 直接调用 item.destination()，无需任何 if else
        .navigationDestination(item: $selectedItem, destination: { item in
            item.destination()
        })
    }

    // 根据菜单项返回对应图标
    private func iconForItem(_ item: String) -> String {
        switch item {
        case "首页": "house.fill"
        case "消息": "message.fill"
        case "设置": "gearshape.fill"
        case "关于我们": "info.circle.fill"
        case "帮助中心": "questionmark.circle.fill"
        default: "circle.fill"
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
