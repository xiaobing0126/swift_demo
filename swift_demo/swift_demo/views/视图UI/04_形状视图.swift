//
//  04_形状视图.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/24.
//

import SwiftUI

struct mySquare: Shape {
    //此方法用于指定矩形参考框架中的形状轮廓。它只接受一个rect参数，它表示为给定形状指定的参考框架。
    func path(in rect: CGRect) -> Path {
        //        var path = Path()
        //        let side = min(rect.width, rect.height)
        //        let xOffset = (rect.width - side) / 2
        //        let yOffset = (rect.height - side) / 2
        //        path.addRect(CGRect(x: rect.minX + xOffset, y: rect.minY + yOffset, width: side, height: side))
        //        return path
        
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct fourRect: Shape {
    func path(in rect: CGRect) -> Path {
        var xPath = Path()
        xPath.move(to: CGPoint(x: 50, y: 50))
        xPath.addLine(to: CGPoint(x: 110, y: 50))
        xPath.addLine(to: CGPoint(x: 110, y: 100))
        xPath.addLine(to: CGPoint(x: 50, y: 100))
        xPath.closeSubpath()
        return xPath
    }
    
}

//绘制线条
struct MyLine: Shape {
    func path(in rect: CGRect) -> Path {
        var linePath = Path()
        linePath.move(to: CGPoint(x: 0, y: 0))
        linePath.addLine(to: CGPoint(x: 100, y: 100))
        linePath.closeSubpath()
        return linePath
    }
}

//绘制矩形
struct MyRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var rectanglePath = Path()
        print(rect.minX, rect.minY, rect.maxX, rect.maxY)
        rectanglePath.move(to: CGPoint(x: rect.minX, y: rect.minY))
        rectanglePath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        rectanglePath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        rectanglePath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        rectanglePath.closeSubpath()
        return rectanglePath
    }
}


struct SwiftShapeView: View {
    @State private var myColor: Color = .yellow

    var body: some View {

        
//        mySquare()
//            .fill(Color.blue)
//            .frame(width: 200, height: 200)
//            .background(Color.gray)
//        
//        fourRect()
//            .stroke(Color.red, lineWidth: 5)
//            .background(Color.yellow)
//            .frame(width: 150, height: 150)
//        
//        MyLine()
//            .stroke(Color.green, lineWidth: 2)
//            .background(Color.black)
//            .frame(width: 100, height: 100)
        
        MyRectangle()
            .stroke(Color.purple, lineWidth: 3)
//            .background(Color.orange)
            .frame(width: 150, height: 100)
    }
}

  

#Preview {
    NavigationStack {
        SwiftShapeView()
    }
}
