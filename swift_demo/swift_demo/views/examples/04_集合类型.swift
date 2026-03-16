//
//  04_集合类型.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/10.
//

import SwiftUI

// 创建一个空数组
let someInts: [Int] = []

// 创建一个带有默认值的数组
var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles 是一种 [Double] 数组，等价于 [0.0, 0.0, 0.0]

var shoppingList: [String] = ["🥑", "🥦", "🌽"]

// 创建一个空字典
var nameOfIntegers: [Int: String] = [:]

struct SwiftCollectionView: View {
    var body: some View {
        Text("集合类型示例")
        
        Button {
            let integerToDescribe = 5
            var description = "The number \(integerToDescribe) is"
            switch integerToDescribe {
            case 2, 3, 5, 7, 11, 13, 17, 19:
                description += " a prime number, and also"
                fallthrough // 加了这个修饰，会执行下一个case里的代码
            case 1, 4, 6, 8, 9, 10, 12, 14, 15, 16, 18:
                description += " not."
            default:
                description += " an integer."
            }
            print(description)
            // 输出“The number 5 is a prime number, and also an integer.”
        } label: {
            Text("fallthrough")
        }
        
        Button {
            var i = 5
            repeat {
                i += 1
                print("i: \(i)")
            } while i < 5
            
            var j = 5
            while j < 5 {
                j += 1
                print("j: \(j)")
            }
        } label: {
            Text("repeat while")
        }
        
        
        Button {
            nameOfIntegers[1] = "one"
            nameOfIntegers[2] = "two"
            print(nameOfIntegers) // 输出字典: [2: "two", 1: "one"]
            
            nameOfIntegers.forEach { key, value in
                print("key: \(key), value: \(value)")
            }
            
            for (key, val) in nameOfIntegers {
                print("key:\(key) val:\(val)") // 输出: one two
            }
            
            nameOfIntegers.removeValue(forKey: 1)
            print(nameOfIntegers)
        } label: {
            Text("测试字典")
        }
        
        Button {
           print(threeDoubles) // 输出: [0.0, 0.0, 0.0]
            
            for shoppingItem in shoppingList {
                print(shoppingItem)
            }
        } label: {
            Text("测试数组")
        }
    }
}

#Preview {
    NavigationStack {
        SwiftCollectionView()
    }
}
