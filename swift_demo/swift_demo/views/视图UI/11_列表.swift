//
//  11_列表.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/4/2.
//

import SwiftUI

struct Student: Identifiable{
    let name: String
    let id: String
    let age: Int
    let subject: String
}

struct SwiftListView: View {
    // move dynamic data to a stored property
    @State private var elements = ["SwiftUI", "iOS Development", "Swift Programming"]
    
    @State private var lang = ""
    @FocusState private var langFieldFocused: Bool
    
    @State private var stud = [
        Student(name: "Mohina", id:"1", age: 19, subject: "Maths"),
        Student(name: "Rohita", id:"2", age: 18, subject: "Science"),
        Student(name: "Soman", id:"3", age: 10, subject: "Maths"),
        Student(name: "Soha", id:"4", age: 17, subject: "Science"),
    ]
    @State private var select = Set<Student.ID>()
    
    private func addLanguage() {
        let trimmed = lang.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        elements.append(trimmed)
        lang = ""
        langFieldFocused = false
    }
    
    //删除选定元素的函数
    private func deleteElements(at offsets: IndexSet) {
        elements.remove(atOffsets: offsets)
    }
    
    var body: some View {
        
        Text("选中(\(select)")
            .font(.subheadline)
            

        GeometryReader { geo in
            VStack(spacing: 12) {
                // List takes upper half
                List {
                    Section("固定列表") {
                        Text("SwiftUI")
                        Text("iOS Development")
                        Text("Swift Programming")
                    }

                    Section("动态列表") {
                        ForEach(elements, id: \.self) { item in
                            Text(item)
                        }
                        .onDelete(perform: deleteElements)
                    }

                    Section(header: Text("添加语言")) {
                        HStack {
                            TextField("Add Language", text: $lang)
                                .textFieldStyle(.roundedBorder)
                                .submitLabel(.done)
                                .focused($langFieldFocused)
                                .onSubmit {
                                    addLanguage()
                                }

                            Button(action: addLanguage) {
                                Text("Add")
                            }
                            .disabled(lang.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                        .padding(.vertical, 6)
                    }
                }
                .listStyle(.insetGrouped)
                .navigationTitle("列表示例")
                .frame(height: max(200, geo.size.height * 0.45))

                // Table-like area below (iOS-friendly)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Original Table")
                        .font(.title2)
                        .padding(.leading, 12)

                    // Header row
                    HStack {
                        Text("") // selection column
                            .frame(width: 32)
                        Text("Student Names")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Age")
                            .frame(width: 50, alignment: .center)
                        Text("Favourite Subject")
                            .frame(width: 140, alignment: .leading)
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                    // Scrollable rows
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(stud) { s in
                                Button(action: {
                                    if select.contains(s.id) { select.remove(s.id) }
                                    else { select.insert(s.id) }
                                }) {
                                    HStack {
                                        Image(systemName: select.contains(s.id) ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(select.contains(s.id) ? .blue : .gray)
                                            .frame(width: 32)

                                        Text(s.name)
                                            .frame(maxWidth: .infinity, alignment: .leading)

                                        Text("\(s.age)")
                                            .frame(width: 50, alignment: .center)

                                        Text(s.subject)
                                            .frame(width: 140, alignment: .leading)
                                    }
                                    .padding(.vertical, 10)
                                    .padding(.horizontal)
                                    .background(select.contains(s.id) ? Color.blue.opacity(0.12) : Color.clear)
                                }
                                .buttonStyle(PlainButtonStyle())
                                Divider()
                            }
                        }
                    }
                    .frame(height: max(150, geo.size.height * 0.45))
                    .padding(.horizontal)
                }
                .background(Color(.systemBackground))
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .top)
        }
    }
}

#Preview {
    NavigationStack {
        SwiftListView()
    }
}
