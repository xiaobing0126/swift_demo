//
//  07_属性.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/12.
//

import SwiftUI

/**属性开始---------*/
// 计算属性
// 计算属性不直接存储值，而是提供一个getter和一个可选的setter，来间接获取和设置其他属性或变量的值。
struct Point {
    var x: Double = 0
    var y: Double = 0
}
struct Size {
    var width: Double = 0
    var height: Double = 0
}
struct Rect {
    // struct要有初始值，才能这么实例化，没有初始值就只能在init里赋值，或者直接声明成常量（let）
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        // 可以简化，去掉（newCenter）
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

// 只读计算属性
// 必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值。
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

/**属性结束---------*/

struct SwiftPropertyView: View {

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
                Text("Swift 属性")
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
                    
                    
                    // 只读计算属性
                    Button {
                        testBtnText = "只读计算属性"
                        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
                        testResult = fourByFiveByTwo.volume
                        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
                        // 打印“the volume of fourByFiveByTwo is 40.0”
                    } label: {
                        Text("只读计算属性")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    
                    // 计算属性
                    Button(action: {
                        testBtnText = "计算属性"
                        // ✅ 用 Rect() 创建实例，传入 origin 和 size 初始值
                        var square = Rect(
                            origin: Point(x: 0, y: 0),
                            size: Size(width: 10, height: 10)
                        )
                        let centerBefore = square.center
                        // 通过 setter 修改 center，因为宽高不变，origin 会自动跟着变
                        square.center = Point(x: 15, y: 15)
                        let centerAfter = square.center
                        testResult = """
                        初始 center: (\(centerBefore.x), \(centerBefore.y))
                        设置 center 为 (15, 15) 后
                        新 center: (\(centerAfter.x), \(centerAfter.y))
                        新 origin: (\(square.origin.x), \(square.origin.y))
                        """
                    }, label: {
                        Text("计算属性")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle("属性")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SwiftPropertyView()
    }
}
