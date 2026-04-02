//
//  Untitled.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/19.
//

import SwiftUI

extension View {
    // 自适配字号
    func adaptedFont(_ size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.font(.system(size: UIAdapter.font(size), weight: weight))
    }

    // 自适配图片/控件尺寸
    func adaptedFrame(_ value: CGFloat) -> some View {
        self.frame(width: UIAdapter.size(value), height: UIAdapter.size(value))
    }

    // 自适配宽高
    func adaptedFrame(width: CGFloat? = nil, height: CGFloat? = nil) -> some View {
        self.frame(
            width: width.map { UIAdapter.size($0) },
            height: height.map { UIAdapter.size($0) }
        )
    }

    // 自适配内边距
    func adaptedPadding(_ value: CGFloat) -> some View {
        self.padding(UIAdapter.spacing(value))
    }
}
