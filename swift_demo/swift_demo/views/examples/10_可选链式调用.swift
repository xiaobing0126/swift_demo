//
//  10_可选链式调用.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/13.
//

import SwiftUI

struct SwiftOptionalChainingView: View {
    
    @State private var testBtnText: String = ""
    @State private var testResult: Any? = nil // 这里用 Any? 来存储不同类型的测试结果，方便展示
    
    struct Person {
        var name: String = ""
        var residence: Residence?
    }
    
    struct Residence {
        var numberOfRooms: Int
    }
    
    // 将任意类型转成可展示的字符串
    private func formatResultText(_ value: Any?) -> String {
        guard let value = value else { return "" }
        if let arr = value as? [Any] {
            return arr.map { "\($0)" }.joined(separator: "\n")
        }
        return "\(value)"
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 标题
                Text("Swift 可选链式调用")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Divider()

                // 测试结果展示区
                if !testBtnText.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("测试按钮：\(testBtnText)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(formatResultText(testResult))
                            .font(.body)
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }

                Divider()

                // 测试按钮区
                VStack(spacing: 12) {
                                        
                    Button(action: {
                        testBtnText = "可选链式调用"
                        
                        // 这样可以访问 residence 属性，但如果 residence 是 nil，就会导致运行时错误
//                        let residence = Residence(numberOfRooms: 3)
//                        let john = Person(name: "John", residence: residence)
                        
                        let john = Person()
                        // 这会引发运行时错误
//                        let roomCount = john.residence!.numberOfRooms

                        // 使用可选链式调用来安全地访问 numberOfRooms 属性
                        if let roomCount = john.residence?.numberOfRooms {
                            testResult = "John 的住所有 \(roomCount) 个房间。"
                        } else {
                            testResult = "无法获取 John 的住所信息。"
                        }
                        
                    }, label: {
                        Text("可选链式调用")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle("可选链式调用")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview() {
    NavigationStack {
        SwiftOptionalChainingView()
    }
}
