//
//  09_控件.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/4/2.
//

import SwiftUI
import UIKit

struct SwiftComponentView: View {
    
    @State private var toggleValue1 = false
    @State private var toggleValue2 = false
    // Add state for the search bar text
    @State private var searchText: String = ""
    
    @State private var fname : String = ""
    @State private var lname : String = ""
    @State private var contact : String = ""
    @State private var age : String = ""
    
    @State private var selectedOption = "Open"
    let options = ["New", "Open", "SaveAs", "Save", "Recent"]
    
    var body: some View {
        ScrollView(content: {
            VStack(alignment: .leading, spacing: 16) {
                Text("控件示例")
                    .font(.title2)
                    .padding(.bottom, 4)
                
                // 带标签的菜单
                Menu{
                    Button("Open", action: openfile)
                    Button("New", action: newfile)
                    Button("Save", action: savefile)
                    Button("Save As", action: saveasfile)
                    Menu("Recent Open"){
                        Button("file1", action:file1)
                        Button("file2", action:file3)
                        Button("file3", action:file3)
                    }
                    
                }label:{
                    Label("File", systemImage: "doc").font(.title)
                }
                
                //下拉菜单
                VStack{
                    Text("Picker 1").font(.title)
                    Picker("Select an option", selection: $selectedOption){
                        ForEach(options, id:\.self){x  in Text(x)}
                    }.pickerStyle(.inline)
                    Text("Picker 2").font(.title)
                    Picker("Select an option", selection: $selectedOption){
                        ForEach(options, id:\.self){x  in Text(x)}
                    }.pickerStyle(.menu)
                    Text("Picker 3").font(.title)
                    Picker("Select an option", selection: $selectedOption){
                        ForEach(options, id:\.self){x  in Text(x)}
                    }.pickerStyle(.palette)
                    Text("Picker 4").font(.title)
                    Picker("Select an option", selection: $selectedOption){
                        ForEach(options, id:\.self){x  in Text(x)}
                    }.pickerStyle(.segmented)
                    Text("Picker 5").font(.title)
                    Picker("Select an option", selection: $selectedOption){
                        ForEach(options, id:\.self){x  in Text(x)}
                    }.pickerStyle(.wheel)
                }
                
                //开关
                VStack {
                    Toggle("Notification", isOn:$toggleValue1)
                    Toggle("Sub-Notification", isOn:$toggleValue2)
                }
                
                //自定义进度条
                CustomProgressBar(progress: 0.4, height: 100, type: .circular)
                
                CustomProgressBar(progress: 0.4, height: 10, type: .horizontal)
                    .padding()
                
                //按钮
                Button("haha", role: .close) {
                    print("111")
                }
                
                // Image button: show circular background so background color is visible
                Button(action: {
                    print("222")
                }, label: {
                    ZStack {
                        // circular background behind the image
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 100)
                        
                        Image("myphone")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 86, height: 86)
                            .clipShape(Circle())
                    }
                })
                .buttonStyle(PlainButtonStyle())
                
                //复选框
                CheckBox(isChecked: $toggleValue2, label: "Check me too",
                         onToggle: {
                    print("点击了复选框，当前状态：\(toggleValue2)")
                },
                         onLabelTap: {
                    print("点击了标签，当前状态：\(toggleValue2)")
                })
                
                // 搜索框：Replace direct UIKit view with SwiftUI wrapper
                SearchBar(text: $searchText)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                //文本字段 —— 用容器包装背景，避免 textFieldStyle 覆盖
                VStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("First Name")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("Enter First Name", text: $fname)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow.opacity(0.3)))
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Last Name")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField(text: $lname, label: { Text("Enter Last Name") })
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.yellow.opacity(0.3)))
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Contact")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("Contact Number", text: $contact, prompt: Text("Contact Number"))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Age")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        TextField("Enter Age", text: $age)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray6)))
                            .keyboardType(.numberPad)
                    }
                }
                
            }
            .padding()
        })
    }
}

func openfile(){
    print("File is opened")
}
func newfile(){
    print("New File")
}
func savefile(){
    print("File is saved")
}
func saveasfile(){
    print("Save as file")
}
func file1(){
    print("File 1 is opened")
}
func file2(){
    print("File 2 is opened")
}
func file3(){
    print("File 3 is opened")
}

#Preview {
    SwiftComponentView()
}
