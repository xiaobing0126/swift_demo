//
//  Untitled.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/18.
//

import SwiftUI
import Combine

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .medium
    return formatter
}()

struct SwiftUIComponentView: View {
    @State private var now = Date()
    
    // 每组独立控制展开状态
    @State private var isTextSectionExpanded = true
    @State private var isLabelSectionExpanded = false
    @State private var isHstackSectionExpanded = false
    
    var body: some View {
        List {
            // 分组 1
            DisclosureGroup(
                "Text控件",
                isExpanded: $isTextSectionExpanded,
                content: {
                    Text("What time is it?: \(now, formatter: dateFormatter)")
                    Text("Hello, World!")
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
            
            
            //将其子视图排列在水平增长的网格中的容器视图，仅根据需要创建项目。
            let rows: [GridItem] =
            Array(repeating: .init(.fixed(20)), count: 2)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .top) {
                    ForEach((0...100), id: \.self) {
                        Text("\($0)").background(Color.pink)
                    }
                }
            }
            
            //将其子视图排列在垂直增长的网格中的容器视图，仅根据需要创建项目。
            let columns: [GridItem] =
            Array(repeating: .init(.fixed(20)), count: 5)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach((0...100), id: \.self) {
                        Text("\($0)")
                            .background(Color.pink)
                            .frame(width: 50, height: 20)
                    }
                }
            }
            
            
            HStack {
                Text("左侧文字")
                Spacer()          // 占据中间所有剩余空间
                Button("右侧按钮") { }
            }
            
            VStack {
                Text("顶部标题")
                Spacer()          // 把下方所有剩余空间占满
                Text("底部脚注")
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
