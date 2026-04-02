//
//  05_动画.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/31.
//

import SwiftUI

struct SwiftAnimationView: View {
    @State private var scale = false
    @State private var color = false
    @State private var rotate = false
    
    @State private var size = 1.0
    
    @State private var myState = false
    
    var body: some View {
        VStack {
            Text("SwiftUI动画示例")
                .font(.largeTitle)
                .padding()
            
            //withAnimation(_:_:)方法:用于创建基于状态的动画。它允许您指定动画类型，并在状态变量改变其状态时执行动画。状态管理
            //            Circle()
            //                .stroke(color ? Color.blue : Color.red, lineWidth: 4)
            //                .frame(width: 100, height: 100)
            //                .padding(10)
            //                .scaleEffect(scale ? 2.0 : 1.0)
            //            Button(action: {
            //                withAnimation(.easeInOut(duration: 3)){
            //                    scale.toggle()
            //                    withAnimation(.easeInOut(duration: 3)){
            //                        color.toggle()
            //                    }
            //                }
            //            }, label: {
            //                Text("点击我动起来")
            //                    .font(.system(size: 30))
            //            })
            //            .padding(.bottom, 24)
            
            //.animation(:value:)方法：用于将动画插入特定视图，意味着当其状态被改变时，它会自动为指定视图的更改制作动画
            //            Button(action: {
            //                size += 1
            //            }, label: {
            //                Text("animation动画1")
            //            })
            //            .frame(width: 56, height: 56)
            //            .padding(20)
            //            .background(Circle().fill(.mint))
            //            .scaleEffect(size)
            //            .animation(.easeOut, value: size)
            
            //多个动画
            //            Ellipse()
            //                .fill(.orange)
            //                .frame(width: 100, height: 50)
            //                .rotationEffect(.degrees(scale ? 360 : 0))
            //                .scaleEffect(scale ? 2.0 : 1.0)
            //                .animation(.easeInOut(duration: 3), value: scale)
            //                .animation(.easeInOut(duration: 3), value: rotate)
            //
            //            Button(action: {
            //                scale.toggle()
            //                rotate.toggle()
            //            }, label: {
            //                Text("点击我动起来")
            //                    .font(.system(size: 30))
            //            })
            
            //过渡动画
            
        }
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.blue)
                .frame(width: 200, height: 200)
            //                .overlay {
            //                    Text("SwiftUI")
            //                        .font(.title)
            //                        .foregroundStyle(.white)
            //                }
            //                .transition(.scale)
            
            if myState {
                //                RoundedRectangle(cornerRadius: 20)
                //                    .fill(.orange)
                //                    .frame(width: 200, height: 200)
                //                    .overlay {
                //                        Text("SwiftUI")
                //                            .font(.title)
                //                            .foregroundStyle(.white)
                //                    }
                //                    .transition(.scale)
                
                //.transition修饰符用于将过渡附加到给定的视图。当指定的视图出现或从屏幕上移除时，将应用转换。
                Text("文字出来了")
                    .font(Font.largeTitle)
                    .foregroundStyle(.white)
//                    .transition(.scale)
                    .transition(.slide)
            }
            
        }
        Button("Click Me"){
            withAnimation(.default){
                myState.toggle()
            }
        }.font(.title)
            .padding(.top, 20)
    }
}

#Preview {
    SwiftAnimationView()
}
