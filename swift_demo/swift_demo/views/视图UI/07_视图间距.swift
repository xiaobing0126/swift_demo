//
//  07_视图间距.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/4/1.
//

import SwiftUI
struct SwiftSpacerView: View {
    var body: some View {
        VStack{
            HStack{
                // Without Spacer
                Text("Hello").font(.title2)
                Text("TutorialsPoint").font(.title2)
            }
            
            Spacer()
            
            HStack{
                // With Spacer
                Text("Hello").font(.title2)
                Spacer()
                Text("TutorialsPoint").font(.title2)
                
            }
            
            
            // 无间距参数的堆叠
            VStack(){
                Text("1").font(.title2)
                Text("111").font(.title2)
            }
            // 带间距参数的堆叠
            VStack(spacing: 20){
                Text("2").font(.title2)
                Text("222").font(.title2)
            }
        }
    }
}
#Preview {
    SwiftSpacerView()
}
