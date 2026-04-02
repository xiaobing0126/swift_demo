//
//  Custome.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/4/2.
//

import SwiftUI

//进度条类型：水平，环形
enum ProgressBarType {
    case horizontal
    case circular
}

struct CustomProgressBar: View {
    var progress: CGFloat // 进度值，范围从 0.0 到 1.0
    var height: CGFloat = 20 // 进度条的高度，默认值为 20
    var type: ProgressBarType = .horizontal // 进度条类型，默认为水平
    
    var body: some View {
        
        if type == .circular {
            // 环形进度条
            ZStack {
                //自定义环形进度条
                //外层圆环
                Circle()
                    .stroke(Color.pink.opacity(0.2), lineWidth: 10)
                    .frame(width: height, height: height)
                
                //进度圆环
                Circle()
                    .trim(from: 0, to: progress) // 根据进度值截取圆环的一部分
                    .stroke(Color.pink, lineWidth: 10)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90)) // 从顶部开始绘制
                
                // 以百分比显示进度
                Text(String(format: "%.0f %%", min(progress, 1.0) * 100.0))
                    .font(.title)
            }
        } else if type == .horizontal {
            GeometryReader { geometry in
                
                ZStack(alignment: .leading) {
                    // 背景条
                    RoundedRectangle(cornerRadius: geometry.size.height / 2)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: geometry.size.height)
                    
                    // 前景条
                    RoundedRectangle(cornerRadius: geometry.size.height / 2)
                        .fill(Color.blue)
                        .frame(width: geometry.size.width * progress, height: geometry.size.height)
                }
            }
            .frame(height: height) // 设置进度条的高度
        }
    }
}

