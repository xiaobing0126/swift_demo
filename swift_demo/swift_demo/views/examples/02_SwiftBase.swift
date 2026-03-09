//
//  SwiftBase.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/3.
//

import SwiftUI

struct SwiftBaseView: View {
    // 接收从上一个页面传过来的参数
    let id: Int
    @State private var title: String
    
    init(id: Int, title: String) {
//        外部传入参数 (let)
//            ↓
//        init 中用 State(initialValue:) 转成 @State
//            ↓
//        @State var title ← 可变状态，支持 UI 自动刷新
//            ↓
//        $title ← 双向绑定，TextField 可以读和写
        self.id = id
        self._title = State(initialValue: title)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Swift 基础页面")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("ID: \(id)")
                .font(.title2)
                .foregroundStyle(.blue)
            
            Text("标题: \(title)")
                .font(.title3)
                .foregroundStyle(.secondary)

            TextField("请输入", text: $title)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
    }
}

#Preview {
    SwiftBaseView(id: 102, title: "swift基础部分")
}

