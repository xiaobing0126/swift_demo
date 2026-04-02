//
//  UIAdapter.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/19.
//

import SwiftUI

enum UIAdapter {
    // 以 iPhone 13/14 宽度 390 作为设计基准
    private static let baseWidth: CGFloat = 390.0
    private static let minScale: CGFloat = 0.85
    private static let maxScale: CGFloat = 1.25

    // 当前屏幕宽度（取主屏）
    private static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    // 统一缩放比例（限制上下限，避免过大或过小）
    static var scale: CGFloat {
        let raw = screenWidth / baseWidth
        return min(max(raw, minScale), maxScale)
    }

    // 字体尺寸适配
    static func font(_ size: CGFloat) -> CGFloat {
        size * scale
    }

    // 图片/控件尺寸适配
    static func size(_ value: CGFloat) -> CGFloat {
        value * scale
    }

    // 间距适配
    static func spacing(_ value: CGFloat) -> CGFloat {
        value * scale
    }
}
