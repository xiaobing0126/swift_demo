//
//  08_下标.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/12.
//

import SwiftUI

struct SwiftIndexView: View {
    
    // 下标选项
    struct Matrix {
        let rows: Int, columns: Int
        var grid: [Double]
        init(rows: Int, columns: Int) {
            self.rows = rows
            self.columns = columns
            grid = Array(repeating: 0.0, count: rows * columns)
        }
        func indexIsValid(row: Int, column: Int) -> Bool {
            return row >= 0 && row < rows && column >= 0 && column < columns
        }
        subscript(row: Int, column: Int) -> Double {
            get {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                return grid[(row * columns) + column]
            }
            set {
                assert(indexIsValid(row: row, column: column), "Index out of range")
                grid[(row * columns) + column] = newValue
            }
        }
    }
    
    // 通过传入合适的 row 和 column 数值来构造一个新的 Matrix 实例
    var matrix = Matrix(rows: 2, columns: 2)

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
                    
                    Button(action: {
                        testBtnText = "下标"
                        var m = Matrix(rows: 2, columns: 2)
                        // 通过下标设置值
                        m[0, 0] = 1.0
                        m[0, 1] = 2.0
                        m[1, 0] = 3.0
                        m[1, 1] = 4.0
                        // 通过下标读取值
                        testResult = """
                        m[0, 0] = \(m[0, 0])
                        m[0, 1] = \(m[0, 1])
                        m[1, 0] = \(m[1, 0])
                        m[1, 1] = \(m[1, 1])
                        """
                    }, label: {
                        Text("下标")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle("下标")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SwiftPropertyView()
    }
}
