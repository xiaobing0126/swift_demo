//
//  05_函数.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/11.
//

import SwiftUI

/**函数的定义与调用开始---------*/
// 普通函数定义 -> String? 表示 age 参数是可选的，可以传入一个字符串或者不传入（默认为 nil）
func greet(name: String, age: String? = nil) -> String {
    if let age = age {
        return "Hello, \(name), 我是 \(age) 岁的小伙伴!"
    }
    return "Hello, \(name)!"
}

let greetingMessage = greet(name: "Swift", age:"18")


// 多重返回值函数
func minMax(arr: [Int]) -> (min: Int, max: Int)? {
    guard !arr.isEmpty else { return nil } // 处理空数组的情况
    var minValue = arr[0]
    var maxValue = arr[0]
    for item in arr {
        print("item---", item)
        if item < minValue {
            minValue = item
        }
        if item > maxValue {
            maxValue = item
        }
    }
    return (minValue, maxValue)
}

// 可变参数函数
func arithmeticMean(numbers: [Double]) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

// 函数作为参数类型
// 可以用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。
// 这样你可以将函数的一部分实现留给函数的调用者来提供。
func performOperation(a: Int, b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

func addTwoInts(a: Int, b: Int) -> Int {
    return a + b
}

// 定义减法函数
func subtractTwoInts(a: Int, b: Int) -> Int {
    return a - b
}

// 定义乘法函数
func multiplyTwoInts(a: Int, b: Int) -> Int {
    return a * b
}

/**函数的定义与调用结束---------*/

struct SwiftFunctionView: View {

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
                Text("Swift 函数")
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
                    
                    // 函数作为参数类型的定义与调用
                    Button {
                        testBtnText = "可变参数函数的定义与调用"
                        //                        testResult = performOperation(a: 10, b: 20, operation: addTwoInts)
                        // 根据用户选择调用不同函数
                        let choice = "+" // 假设用户选择了加法
                        // 这是笨办法，if else判断
//                        var result = 0
//                        if choice == "+" {
//                            result = add(a: 10, b: 20)
//                        } else if choice == "-" {
//                            result = subtract(a: 10, b: 20)
//                        } else if choice == "*" {
//                            result = multiply(a: 10, b: 20)
//                        }
                        
                        // 可以把 performOperation 理解为对执行运算函数(add, sub, mul)的一层封装，它接受一个函数作为参数，并在内部调用这个函数来执行具体的运算。这样就实现了函数作为参数类型的定义与调用。
                        var operation: (Int, Int) -> Int
                        switch choice {
                            case "+": operation = addTwoInts      // 假设 add 函数已定义
                            case "-": operation = subtractTwoInts
                            case "*": operation = multiplyTwoInts
                            default: fatalError("未知操作")
                        }
                        
                        
                        testResult = performOperation(a: 10, b: 20, operation: operation)
                    } label: {
                        Text("函数作为参数类型的定义与调用")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    // 可变参数函数的定义与调用
                    Button {
                        testBtnText = "可变参数函数的定义与调用"
                        let mean1 = arithmeticMean(numbers: [1, 2, 3, 4, 5])
                        let mean2 = arithmeticMean(numbers: [3, 8.2, 1.2])
                        // String(format:) 保留两位小数
                        testResult = "[1,2,3,4,5] 平均值: \(String(format: "%.2f", mean1))\n[3,8.2,1.2] 平均值: \(String(format: "%.2f", mean2))"
                    } label: {
                        Text("可变参数函数的定义与调用")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    // 多重返回值函数的定义与调用
                    Button {
                        testBtnText = "多重返回值函数的定义与调用"
                        testResult = formatResultText(minMax(arr: [1,2,3,4,5]))
                    } label: {
                        Text("多重返回值函数的定义与调用")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    // 函数的定义与调用
                    Button {
                        testBtnText = "普通函数的定义与调用"
                        testResult = greet(name: "Swift")
                    } label: {
                        Text("普通函数的定义与调用")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle("函数")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SwiftFunctionView()
    }
}
