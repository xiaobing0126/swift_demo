//
//  03_图像视图.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/24.
//

import SwiftUI

struct SwiftImageView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            ScrollView(.horizontal, showsIndicators: true, content: {
                
                VStack(alignment: .leading, content: {
                    Image("assets/myphone")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    Text("这是一个图片视图示例")
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                })
                
                
            })
            
            ZStack {
                Circle()
                    .stroke(Color.orange)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 250, height: 250)
                Rectangle()
                    .fill(Color.pink)
                    .frame(width: 150, height: 150)
                    .overlay {
                        Text("SwiftUI")
                            .foregroundStyle(Color.white)
                    }
            }
            
            
            HStack(content: {
                VStack(alignment: .leading, content: {
                    Image("assets/myphone")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    Text("这是一个图片视图示例")
                        .font(.headline)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                    
                })
                
            })
            .frame(maxWidth: .infinity, alignment: .leading)

            // alignment：对齐方式，默认是center，可以设置为top、bottom、leading、trailing等
            HStack(alignment: .top, content: {
                Text("广东省")
                    .frame(width: 20, height: 100)
                    .background(Color.red.opacity(0.2))
                Spacer()
                Text("深圳市")
                    .frame(width: 20, height: 130)
                    .background(Color.green.opacity(0.2))
                Spacer()
                Text("南山区")
                    .frame(width: 20, height: 150)
                    .background(Color.orange.opacity(0.2))
            })
            // .padding(20)
            // padding：内边距，默认是0，可以设置为具体数值或者EdgeInsets来指定不同方向的边距
            .padding(EdgeInsets(top: 10, leading: 50, bottom: 50, trailing: 0))
            .background(Color.blue.opacity(0.2))
            
            // spacing：子视图之间的间距，默认是0，可以设置为具体数值来指定间距大小
            HStack(spacing: 120) {
                Text("1")
                    .background(Color.red.opacity(0.2))
                Text("1")
                    .background(Color.green.opacity(0.2))
                Text("1")
                    .background(Color.orange.opacity(0.2))
            }
            .background(Color.blue.opacity(0.2))
        })
    }
}

#Preview {
    SwiftImageView()
}
