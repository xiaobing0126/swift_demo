//
//  02_SwiftBase.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/3.
//

import SwiftUI

/**基本运算符开始------------------------*/
// 1.空合运算符,实现在默认颜色名和可选自定义颜色名之间选择
private let defaultColorName = "red"
private var userDefinedColorName: String?
// userDefinedColorName 的值为空，所以colorNameToUse 将会使用 defaultColorName 的值 "red"
private var colorNameToUse = userDefinedColorName ?? defaultColorName
/**基本运算符结束------------------------*/

/**class实战开始---------------------------*/
// 必须实现init方法，才可以这么声明
// @State private var arr: [Person] = [
//    Person(name: "xiaozong", age: 18),
//    Person(name: "xiaoli", age: 20)
// ]
@Observable
class Person {
    var name: String = ""
    var age: Int = 0
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let xiaoxiao = Person(name: "xiaoxiao", age: 18)
let xiaoxiao1 = xiaoxiao
let xiaoxiao2 = xiaoxiao
/**class实战结束---------------------------*/


/**struct实战结束---------------------------*/
struct Car {
    var name: String
    var price: String
}
/**struct实战结束---------------------------*/

struct SwiftBaseView: View {
    // 接收从上一个页面传过来的参数
    let id: Int
    @State private var title: String

    init(id: Int, title: String) {
//        外部传入参数 (let)
//            ↓
//        init 中用 State(initialValue:) 转成 @State
//            ↓
//        @State var title ← 可变状态，支持 UI 自动刷新
//            ↓
//        $title ← 双向绑定，TextField 可以读和写
        self.id = id
        self._title = State(initialValue: title)
    }

    // 测试的显示结果
    @State private var testBtnText: String = "测试类型"
    @State private var testResult: String = "测试结果"

    // 测试 Person 数组
    @State private var personArr: [Person] = [
        Person(name: "xiaozong", age: 18),
        Person(name: "xiaoli", age: 20),
    ]

    // 测试 car 数组
    @State private var carArr: [Car] = [
        Car(name: "BMW", price: "50000"),
        Car(name: "Audi", price: "45000"),
    ]

    var body: some View {
        VStack(spacing: 20) {
            Text("Swift 基础页面")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("ID: \(id)")
                .font(.title2)
                .foregroundStyle(.blue)

            Text("标题: \(title)")
                .font(.title3)
                .foregroundStyle(.secondary)

            TextField("请输入", text: $title)
                .textFieldStyle(.roundedBorder)
                .padding()

            Text("测试类型：\(testBtnText)----测试结果:\(testResult)")

            Text(personArr.map {
                item in
                "name: \(item.name), age: \(item.age)"
            }.joined(separator: ", "))
                .padding()

            Text("\(xiaoxiao.name)")

            Text("\(xiaoxiao1.name)")

            Text("\(xiaoxiao2.name)")

            Text(carArr.map { item in
                "name: \(item.name), price: \(item.price)"
            }.joined(separator: "\n"))
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding()

            /**测试功能-------------------------*/
            // struct测试
            Button {
                let obj = Car(name: "奔驰", price: "60000")
                carArr.append(obj)
            } label: {
                Text("struct测试")
            }

            // class测试
            Button {
                xiaoxiao.name = "你们三用一个名字"
                let obj = Person(name: "xiaohong", age: 22)
                personArr.append(obj)
            } label: {
                Text("class测试")
            }
            
            // 半开区间运算符
            Button {
                for (index, item) in (1..<5).enumerated() {
                    print("\(item) * 5 = \(item * 5), index = \(index)")
                }
            } label: {
                Text("半开区间运算测试")
            }

            // 闭区间运算符
            Button {
                for index in 1...5 {
                    print(index)
                }
                for index in 1...5 {
                    print("\(index) * 5 = \(index * 5)")
                }

                for item in personArr {
                    print("name: \(item.name), age: \(item.age)")
                }
            } label: {
                Text("闭区间运算测试")
            }

            // 空合运算测试
            Button {
                testBtnText = "合运空算"
                // 点击事件
                testResult = colorNameToUse
            } label: {
                Text("空合运算测试")
            }
        }
    }
}

#Preview {
    SwiftBaseView(id: 102, title: "swift基础部分")
}
