//
//  03_SwiftString.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/10.
//

import SwiftUI


struct SwiftStringView: View {
    
    // 测试结果
    @State private var testBtnText: String = ""
    @State private var testResult: String = ""
    
    let greeting = "Hello,Swift!"
    
    var body: some View {
        Text("Hello, World!")
        
        Text("测试类型：\(testBtnText)\n测试结果：\(testResult)")
        
        Button {
            testBtnText = "字符串索引"
            // 获取字符串的第一个字符, last最后一个
            if let firstCharacter = greeting.first {
                print("第一个字符是: \(firstCharacter)") // 输出: H
                testResult += "第一个字符是: \(firstCharacter)\n"
            }
            if let firstIndex = greeting.firstIndex(of: "S") {
                print("字符 'S' 的索引是: \(firstIndex)") // 输出: String.Index(_rawBits: 131072)
                testResult += "字符 'S' 的索引是: \(firstIndex)\n"
            }
            let startIndex = greeting.startIndex
            let startIndexInt = greeting.distance(from: greeting.startIndex, to: startIndex)
            print("startIndex---", startIndexInt) // 输出: 0
        } label: {
            Text("字符串索引示例")
        }
    }
}

#Preview {
    NavigationStack {
        SwiftStringView()
    }
}
