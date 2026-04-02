//
//  Untitled.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/24.
//

import SwiftUI

struct ZStackView: View {
    var body: some View {
        ZStack{
            Image("wallpaper")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment:.leading){
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.teal)
                    .frame(width: 350, height: 150)
                    .overlay(
                        Text("SwiftUI")
                            .font(.largeTitle))
            }
            .padding(.bottom, 410)
            Spacer()
            
            HStack(alignment:.bottom){
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.yellow)
                    .frame(width: 200, height: 200)
                    .overlay(
                        Text("Chapters")
                            .font(.title))
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.yellow)
                    .frame(width: 200, height: 200)
                    .overlay(
                        Text("Programs")
                            .font(.title))
            }
            .padding(.top, 90)
        }
        .padding()
    }
}

#Preview {
    ZStackView()
}

