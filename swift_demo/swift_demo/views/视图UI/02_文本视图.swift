//
//  02_文本视图.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/24.
//

import SwiftUI

struct SwiftTextView: View {
    @State private var title: String = "Hello, SwiftUI!"
    
    var body: some View {
        // 垂直排列
        VStack(content: {
            Text(title)
                // 设置文本框的宽高
                .frame(width: UIAdapter.size(200), height: UIAdapter.size(100))
                .font(.system(size: UIAdapter.font(24), weight: .bold))
                .foregroundColor(.red) // 文本颜色
                .padding(UIAdapter.spacing(30)) // 内边距
                .background(Color.yellow.opacity(0.5)) // 背景颜色
                .cornerRadius(UIAdapter.size(20)) // 圆角
                .tracking(UIAdapter.size(10)) // 字符间距
                .lineSpacing(UIAdapter.size(20)) // 行间距
                .multilineTextAlignment(.center) // 多行文本对齐方式
                .underline() // 下划线
                .strikethrough() // 删除线
                .lineLimit(2) // 行数限制
                .border(Color.blue, width: UIAdapter.size(5)) // 边框
            
            Text("123")
        })
    }
}

#Preview {
    SwiftTextView()
}
