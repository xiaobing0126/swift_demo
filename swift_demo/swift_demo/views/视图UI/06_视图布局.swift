//
//  06_视图布局.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/4/1.
//

import SwiftUI

private struct ChildSizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear.preference(
                    key: ChildSizePreferenceKey.self,
                    value: proxy.size
                )
            }
        )
        .onPreferenceChange(ChildSizePreferenceKey.self, perform: onChange)
    }
}

struct SwiftLayoutView: View {
    @State private var childRealSize: CGSize = .zero
    @State private var widthRatio: CGFloat = 0.5
    @State private var heightRatio: CGFloat = 0.5

    var body: some View {
        GeometryReader { geometry in
            let parentWidth = geometry.size.width
            let parentHeight = geometry.size.height
            
            // 根据父容器动态计算目标尺寸
            let rectWidth = parentWidth * widthRatio
            let rectHeight = parentHeight * heightRatio
            
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Group {
                        Text("Parent width: \(Int(parentWidth))")
                        Text("Parent height: \(Int(parentHeight))")
                        Text("Target rect width: \(Int(rectWidth))")
                        Text("Target rect height: \(Int(rectHeight))")
                        Text("Measured child width: \(Int(childRealSize.width))")
                        Text("Measured child height: \(Int(childRealSize.height))")
                    }
                    .font(.system(size: 16, weight: .medium))
                    
                    Rectangle()
                        .fill(.mint)
                        .frame(width: rectWidth, height: rectHeight)
                        .overlay(
                            Text("Dynamic Rectangle")
                                .font(.headline)
                                .foregroundColor(.white)
                        )
                        .readSize { size in
                            childRealSize = size
                        }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Width ratio: \(String(format: "%.2f", widthRatio))")
                        Slider(value: $widthRatio, in: 0.2...1.0, step: 0.05)
                        
                        Text("Height ratio: \(String(format: "%.2f", heightRatio))")
                        Slider(value: $heightRatio, in: 0.2...1.0, step: 0.05)
                    }
                    .padding(.top, 8)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        
        VStack(alignment: .leading, spacing: 16) {
                    Text("上方固定区域")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.blue.opacity(0.15))
                        .cornerRadius(10)

                    // GeometryReader 放在 VStack 中，并且限制高度
                    GeometryReader { geometry in
                        let parentWidth = geometry.size.width
                        let parentHeight = geometry.size.height

                        let rectWidth = parentWidth * 0.6
                        let rectHeight = parentHeight * 0.5

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Geometry 区域 width: \(Int(parentWidth))")
                            Text("Geometry 区域 height: \(Int(parentHeight))")
                            Text("Rectangle width: \(Int(rectWidth))")
                            Text("Rectangle height: \(Int(rectHeight))")

                            Rectangle()
                                .fill(.mint)
                                .frame(width: rectWidth, height: rectHeight)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding()
                        .background(Color.gray.opacity(0.12))
                        .cornerRadius(10)
                    }
                    .frame(height: 260) // 关键：限制 GeometryReader 的可用高度

                    Text("下方固定区域")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.orange.opacity(0.15))
                        .cornerRadius(10)
                }
                .padding()
    }
}

#Preview {
    SwiftLayoutView()
}
