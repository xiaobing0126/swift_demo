//
//  09_继承.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/12.
//

import SwiftUI

struct SwiftInheritanceView: View {
    
    // 一个类可以继承另一个类的方法，属性和其它特性。当一个类继承其它类时，继承类叫子类，被继承类叫超类（或父类）。在 Swift 中，继承是区分「类」与其它类型的一个基本特征。

    // 定义一个基类
    class Vehicle {
        var currentSpeed = 0.0
        var description: String {
            return "以 \(currentSpeed) 公里/小时的速度行驶"
        }
        func makeNoise() -> String {
            return "爸爸的速速 是 \(currentSpeed) 公里/小时"
        }
    }
    
    // 自行车继承父类
    class Bicycle: Vehicle {
        var hasBasket: Bool = false
        // 重写父类 makeNoise 方法
        override func makeNoise() -> String {
             // 调用父类的方法，可以保留父类的行为
            return "\(super.makeNoise()), 自行车的速度是 \(currentSpeed) 公里/小时"
        }
        // 重新父类 description属性
        override var description: String {
            return super.description + (hasBasket ? "，有篮子" : "，没有篮子")
        }
        init(hasBasket: Bool) {
            self.hasBasket = hasBasket
        }
    }

    @State private var testBtnText: String = ""
    @State private var testResult: Any? = nil // 这里用 Any? 来存储不同类型的测试结果，方便展示

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
                Text("Swift 继承")
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
                        testBtnText = "继承"
                        
                        let father = Vehicle()
                        father.currentSpeed = 10.0
                        print("父类描述：\(father.description)") // 输出：以 10.0 公里/小时的速度行驶
                        print(father.makeNoise())  // 输出：没速度，没噪音 爸爸的速速 是 10.0 公里/小时
                        
                        let bycle = Bicycle(hasBasket: true)
                        bycle.currentSpeed = 15.0
                        print("自行车描述：\(bycle.description)")
                        print(bycle.makeNoise()) //
                        
                    }, label: {
                        Text("继承")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle("继承")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SwiftInheritanceView()
    }
}
