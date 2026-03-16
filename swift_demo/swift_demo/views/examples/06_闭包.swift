//
//  06_闭包.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/11.
//

import SwiftUI

/**闭包开始---------*/

// 逃逸闭包
// 当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。
// 当你定义接受闭包作为参数时，你可以在参数名之前标注 @escaping 来指明这个闭包是允许逃逸的。
func fetchData(completion: @escaping (String) -> Void) {
    DispatchQueue.global().async {
        // 模拟网络请求
        sleep(2)
        let data = "Fetched data from server"
        DispatchQueue.main.async {
            completion(data)
        }
    }
}


/**闭包结束---------*/

struct SwiftClouserView: View {

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
                    
                    // 逃逸闭包
                    Button {
                        testBtnText = "逃逸闭包"
                        // 这里 { data in ... } 是一个闭包，作为参数传递给 fetchData 函数。当 fetchData 内部异步操作完成后，这个闭包会被调用，接收从服务器获取的数据。
                        fetchData { data in
                            print("Received data: \(data)")
                            testResult = data
                        }
                    } label: {
                        Text("普通函数的定义与调用")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle("闭包")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SwiftClouserView()
    }
}

        
