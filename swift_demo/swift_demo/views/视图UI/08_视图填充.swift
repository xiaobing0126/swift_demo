//
//  08_视图填充.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/4/1.
//

import SwiftUI

struct SwiftPaddingView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("无 padding")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            Rectangle()
                .fill(Color.yellow)
                .frame(width: 300, height: 100, alignment: .center)
                .overlay(
                    Text("TutorialsPoint")
                        .bold()
                        .background(Color.red.opacity(0.35)) // 文字紧贴背景
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.red, lineWidth: 1)
                        )
                )

            Text("有 padding")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            Rectangle()
                .fill(Color.yellow)
                .frame(width: 300, height: 100, alignment: .center)
                .overlay(
                    Text("TutorialsPoint")
                        .bold()
                        .padding(25) // 内边距生效
                        .background(Color.red.opacity(0.35)) // 背景会变大
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.red, lineWidth: 1)
                        )
                )
        }
        .padding()
    }
}

#Preview {
    SwiftPaddingView()
}
