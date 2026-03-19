//
//  14_扩展.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/17.
//

import SwiftUI

// 扩展（Extension）是 Swift 中的一种强大功能，允许你为现有的类、结构体、枚举或协议添加新的功能，而无需修改原始类型的源代码。扩展可以添加新的计算属性、方法、下标以及协议遵循等。

// 计算属性扩展---
// Double 类型的 1.0 代表的是“一米”
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

// 构造器的扩展---
struct originSize {
    var width = 0.0, height = 0.0
}

struct originPoint {
    var x = 0.0, y = 0.0
}

struct originRect {
    var origin = Point()
    var size = Size()
}

// 因为 Rect 结构体给所有的属性都提供了默认值，所以它自动获得了一个默认构造器和一个成员构造器，就像 默认构造器 中描述的一样。这些构造器可以用来创建新的 Rect 实例：
let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))


//你可以通过扩展 Rect 结构体来提供一个允许指定 center 和 size 的构造器：
//这个新的构造器首先根据提供的 center 和 size 计算一个适当的原点。然后这个构造器调用结构体自带的成员构造器 init(origin:size:)，它会将新的 origin 和 size 值储存在适当的属性中：
extension Rect {
    init(center: Point, size: Size) {
        let x = center.x - (size.width / 2)
        let y = center.y - (size.height / 2)
        self.origin = Point(x: x, y: y)
        self.size = size
    }
}


// 扩展方法---
// repetitions(task:) 方法仅接收一个 () -> Void 类型的参数，它表示一个没有参数没有返回值的方法。
// 定义了这个扩展之后，你可以对任意整形数值调用 repetitions(task:) 方法，来执行对应次数的任务：
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

//扩展可变实例方法
//通过扩展添加的实例方法同样也可以修改（或 mutating（改变））实例本身。结构体和枚举的方法，若是可以修改 self 或者它自己的属性，则必须将这个实例方法标记为 mutating，就像是改变了方法的原始实现。
//在下面的例子中，对 Swift 的 Int 类型添加了一个新的 mutating 方法，叫做 square，它将原始值求平方：
extension Int {
    mutating func square() {
        self = self * self
    }
}



struct SwiftExtensionView: View {
    var body: some View {
        Text("扩展示例")
        
        Button(action: {
            
            var someInt = 3
            someInt.square()
            print("someInt 的平方是 \(someInt)") // 输出: someInt 的平方是 9
            
        }, label: {
            Text("实例方法扩展")
        })
        
        Button(action: {
            
            3.repetitions {
                print("Hello!")
            }
            
        }, label: {
            Text("方法扩展")
        })
        
        Button(action: {
            
            print("memberwiseRect: \(memberwiseRect)")
            
            let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                                  size: Size(width: 3.0, height: 3.0))
            print("扩展后的Rect：\(centerRect)")
            
        }, label: {
            Text("构造器扩展")
        })
        
        Button("计算距离") {
            let onekm = 1.km
            print("1 千米等于 \(onekm) 米") // 输出: 1 千米等于 1000.0 米
            
            let twomm = 2.0.mm
            print("2 毫米等于 \(twomm) 米") // 输出: 2 毫米等于 0.002 米
        }
    }
}

#Preview {
    NavigationStack {
        SwiftExtensionView()
    }
}
