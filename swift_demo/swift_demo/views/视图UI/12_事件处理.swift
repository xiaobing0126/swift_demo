//
//  12_事件处理.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/4/2.
//

import SwiftUI

enum Gender: String, CaseIterable, Identifiable {
    case male = "男"
    case female = "女"
    
    var id: Self { self }
    var displayName: String { rawValue }
}

struct Params {
    var name: String = ""
    var age: Int = 0
    var gender: Gender = .male
}

struct SwiftEventView: View {
    
    @State private var testBtnText: String = ""
    
    @State private var params = Params()
    
    // 追踪位置
    @State private var position = CGSize.zero
    
    // 跟踪拖动偏移
    @State private var dragOffsetValue = CGSize.zero
    
    // 给定文本字段的焦点状态
    @FocusState private var isFocused: Bool
    
    @State private var myAlert : Bool = false
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            
            TextField("Username", text: $username).textFieldStyle(.roundedBorder)
            TextField("passcode", text: $password).textFieldStyle(.roundedBorder)
            
            Button("Click Here"){
                myAlert = true
            }.font(.largeTitle)
                .alert("Alert", isPresented: $myAlert){
                    Button("Signup", role: .none){}
                    Button("Cancel", role: .cancel){}
                }message: {
                    Text("Do you want to SignUp or not?")
                }
            
            VStack{
                // Bind this TextField to params.name so the displayed 姓名 comes from the same source
                TextField("Enter your name", text: $params.name)
                    .padding()
                    .background(.teal.opacity(0.4))
                    .cornerRadius(8)
                    .focused($isFocused)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Focus on Field") {
                    isFocused = true
                }
                Button("Dismiss Focus") {
                    isFocused = false
                }
            }
            .padding()
            
            Text("position: \(position.width), \(position.height)")
            Text("dragOffsetValue: \(dragOffsetValue.width), \(dragOffsetValue.height)")
            
            // 可拖拽圆圈
            Circle()
                .fill(.mint)
                .frame(width: 100)
                .offset(x: position.width + dragOffsetValue.width, y: position.height + dragOffsetValue.height)
                .gesture(
                    DragGesture()
                        .onChanged { g in
                            
                            // 拖动过程中更新偏移值
                            dragOffsetValue = g.translation
                        }
                        .onEnded { _ in
                            
                            // 拖动完成后更新位置。
                            position.width += dragOffsetValue.width
                            position.height += dragOffsetValue.height
                            dragOffsetValue = .zero
                        }
                )
                .animation(.easeIn, value: position)
            
            Section("单个字段双向绑定", content: {
                Text("测试类型：\(testBtnText)")
                TextField("请输入内容", text: $testBtnText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            })
            
            Section("对象双向绑定", content: {
                // show nicely formatted values
                Text("姓名：\(params.name.isEmpty ? "（未填写）" : params.name)\n年龄：\(params.age)\n性别：\(params.gender.displayName)")
                    .padding()
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                
                Stepper("年龄: \(params.age)", value: $params.age, in: 1...120)
                
                // Use a Picker for enum binding instead of TextField
                Picker("性别", selection: $params.gender) {
                    ForEach(Gender.allCases) { g in
                        Text(g.displayName).tag(g)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
            })
        }
        .padding()
    }
}

#Preview {
    SwiftEventView()
}
