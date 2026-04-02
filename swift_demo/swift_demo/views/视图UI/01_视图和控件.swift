//
//  Untitled.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/18.
//

import SwiftUI
import Combine

//推荐规则（简单记）：
//• 会变+影响界面 >放 View里（@state / @stateObject）
//• 不会变的配置常量 >可以放 View 外（如 private let dateFormatter）
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .medium
    return formatter
}()

private let gridRows: [GridItem] = Array(repeating: .init(.fixed(20)), count: 2)
private let gridColumns: [GridItem] = Array(repeating: .init(.fixed(20)), count: 5)

struct SwiftUIComponentView: View {
    @State private var now = Date()
    
    // 每组独立控制展开状态
    @State private var isTextSectionExpanded = true
    @State private var isLabelSectionExpanded = false
    @State private var isHstackSectionExpanded = false
    
    // 放到 body 外，避免在 List/ViewBuilder 内声明局部常量导致构建器报错
    private let rows: [GridItem] = Array(repeating: .init(.fixed(20)), count: 2)
    private let columns: [GridItem] = Array(repeating: .init(.fixed(20)), count: 5)
    
    //动画
    @State private var size: CGFloat = 1.0
    
    // 单向绑定
    @State private var singleText: String = "Hello, World!"
    
    var body: some View {
        List {
            
            // 分组 1
            DisclosureGroup(
                "Text控件",
                isExpanded: $isTextSectionExpanded,
                content: {
                    Text("What time is it?: \(now, formatter: dateFormatter)")
                    Text("Hello, World!")
                    
                    Button(action: {
                        print("按钮被点击了")
                        singleText = "Button Clicked!"
                    }, label: {
                        Text(singleText)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    })
                    
                    //动画效果，点击放大
                    Button("Tap me to see the magic") {
                        withAnimation {
                            self.size *= 1.1
                        }
                    }.scaleEffect(size)
                }
            )
            
            // 分组 2
            DisclosureGroup(
                "Label控件",
                isExpanded: $isLabelSectionExpanded,
                content: {
                    Label("Hello, World!", systemImage: "star.fill")
                }
            )
            
            // 分组 3
            DisclosureGroup(
                "水平滚动布局",
                isExpanded: $isHstackSectionExpanded,
                content: {
                    ScrollView(.horizontal) {
                        LazyHStack(alignment: .center, spacing: 20) {
                            ForEach(1...100, id: \.self) {
                                Text("Column \($0)")
                            }
                        }
                    }
                    
                }
            )
            
            
            //            //将其子视图排列在水平增长的网格中的容器视图，仅根据需要创建项目。
            //            ScrollView(.horizontal) {
            //                LazyHGrid(rows: gridRows, alignment: .top) {
            //                    ForEach((0...100), id: \.self) {
            //                        Text("\($0)").background(Color.pink)
            //                    }
            //                }
            //            }
            
            //            //将其子视图排列在垂直增长的网格中的容器视图，仅根据需要创建项目。
            //            ScrollView {
            //                LazyVGrid(columns: gridColumns) {
            //                    ForEach((0...100), id: \.self) {
            //                        Text("\($0)")
            //                            .background(Color.pink)
            //                            .frame(width: 50, height: 20)
            //                    }
            //                }
            //            }
            
            
            HStack {
                Text("左侧文字")
                    .adaptedFont(14, weight: .heavy)
                    .onTapGesture {
                        print("点击了左侧文字1")
                    }
                    .onTapGesture(count: 2) {
                        print("双击了左侧文字2")
                    }
                
                Spacer()          // 占据中间所有剩余空间
                Button("右侧按钮") { }
            }
            
            VStack {
                Text("顶部标题")
                Spacer()          // 把下方所有剩余空间占满
                Text("底部脚注")
            }
            
            ZStack {
                Color.black.opacity(0.1)
                Text("中心文本")
                Button("中间按钮") { }
            }
        }
        .listStyle(.insetGrouped)
        .onReceive(
            Timer.publish(every: 1, on: .main, in: .common).autoconnect(),
            perform: { value in
                now = value
            }
        )
    }
}

#Preview {
    NavigationStack {
        SwiftUIComponentView()
    }
}
