//
//  SwiftPractice.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/3.
//

import SwiftUI

/** -------------函数和闭包开始-------------------------------------------------------------------------------------------------------------------------------------------------- */

// 函数是第一等类型，这意味着函数可以作为另一个函数的返回值。
// 返回一个函数，这个函数将一个整数作为参数并返回一个整数。
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return number + 1
    }
    return addOne
}

// 函数当参数传给另一个函数
func hasAnyMatches(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}


/** -------------函数和闭包结束-------------------------------------------------------------------------------------------------------------------------------------------------- */



/** -------------对象和类开始-------------------------------------------------------------------------------------------------------------------------------------------------- */
class NamedShape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
        self.name = name
    }

    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}


class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() ->  Double {
        return sideLength * sideLength
    }

//    子类如果要重写父类的方法的话，需要用 override 标记——如果没有添加 override 就重写父类方法的话编译器会报错。编译器同样会检测 override 标记的方法是否确实在父类中。
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)."
    }
}
/** -------------对象和类结束-------------------------------------------------------------------------------------------------------------------------------------------------- */


/** -------------枚举和结构体开始-------------------------------------------------------------------------------------------------------------------------------------------- */
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

enum Suit: CaseIterable {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "♠️"
        case .hearts:
            return "❤️"
        case .diamonds:
            return "♦️"
        case .clubs:
            return "♣️"
        }
    }
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        case .hearts, .diamonds:
            return "red"
        }
    }
}

// 使用 struct 来创建一个结构体。结构体和类有很多相同的地方，包括方法和构造器。它们之间最大的一个区别就是结构体是传值，类是传引用。
struct Card {
    var rank: Rank
    var suit: Suit
    func simpleDescription() -> String {
        return "The struct Card {\(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}


// 枚举实战
// 使用枚举来创建一副扑克牌。每张牌都有一个花色和一个点数。使用枚举来表示花色和点数，使用结构体来表示牌。最后创建一个函数来生成一副完整的扑克牌。
enum aSuit: CaseIterable {
    case spades, hearts, diamonds, clubs
    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "♠️"
        case .hearts:
            return "❤️"
        case .diamonds:
            return "♦️"
        case .clubs:
            return "♣️"
        }
    }
}

enum aRank: CaseIterable {
    case ace, two, three, four, five, six, seven, eight, nine, ten, jack, queen, king
    func simpleDescription() -> String {
        switch self {
        case .ace: return "A"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .ten: return "10"
        case .jack: return "J"
        case .queen: return "Q"
        case .king: return "K"
        }
    }
}

struct aCard {
    var description: String  // 存 "♠️ace" 这样的组合字符串
}

// 用枚举创建一副扑克牌
func createDeck() -> [aCard] {
    var deck = [aCard]()
    for suit in aSuit.allCases {
        for rank in aRank.allCases {
            // ✅ 拼接成 "♠️ace"、"❤️2" 这样的格式
            let card = aCard(description: "\(suit.simpleDescription())\(rank.simpleDescription())")
            deck.append(card)
        }
    }
    return deck
}
    

/** -------------枚举和结构体结束-------------------------------------------------------------------------------------------------------------------------------------------- */

/** -------------协议和扩展开始----------------------------------------------------------------------------------------------------------------------------------------------- */
// 使用 protocol 来声明一个协议。
// 协议让不同的类型可以以相同的方式被使用。可以理解成创建了一个种【新的类型数据】。
// 它定义了某些方法和属性，但没有提供实现。协议可以被类、结构体或枚举采纳来提供这些方法和属性的具体实现。
protocol ExampleProtocol {
    var simpleDescription: String { get } // 只读， { get, set } 代表可读可写
    mutating func adjust()
}

// 类、枚举和结构体都可以遵循协议。
class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var anthorProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted."
    }
}

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

/** -------------协议和扩展结束----------------------------------------------------------------------------------------------------------------------------------------------- */


struct SwiftPracticeView: View {
    // 接收从上一个页面传过来的参数
    let id: Int
    let title: String
    
    // 测试结果
    @State private var testBtnText: String = ""
    @State private var testResult: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("练习页面")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("ID: \(id)")
                .font(.title2)
                .foregroundStyle(.blue)
            
            Text("标题: \(title)")
                .font(.title3)
                .foregroundStyle(.secondary)
            
            Text("当前测试：\(testBtnText)")
            Text(testResult)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            /** 测试功能-------------------------------------------------------------------------------------------------------------------------------------------------------- */
            // 测试协议和扩展
            Button {
                
                // 验证 SimpleClass 是否正确遵循了 ExampleProtocol 协议，并且 adjust() 方法是否正确修改了 simpleDescription 属性
                let a = SimpleClass()
//                a.adjust()
                testResult = a.simpleDescription
                
                Task {
                    // 延迟 5 秒（单位：纳秒，5_000_000_000 纳秒 = 5 秒）
                    try? await Task.sleep(nanoseconds: 5_000_000_000)
                    // 注意：这里可能不在主线程，如果需要更新 UI，要切换到主 actor
                    await MainActor.run {
                        print("5 秒后执行，主线程")
                                        a.adjust()
                                        testResult = a.simpleDescription
                    }
                }
    
            } label: {
                Text("测试协议和扩展")
            }
            
            
            
            
            // 测试验证扑克牌
            Button {
                
                // 验证 createDeck 函数是否正确生成了 52 张牌，并且每张牌的 description 格式正确
                let arr = createDeck()
                // ✅ map 取出每张牌的 description，再用 joined 拼成一个字符串
                let deckArr = arr.map({
                    aCard in
                    return aCard.description
                })
                let deckStr = deckArr.joined(separator: "  ")
                print(deckStr)
                testResult = deckStr
                
            } label: {
                Text("扑克牌")
            }
            
            
            // 测试枚举和结构体
            Button {
                
                // 验证 createDeck 函数是否正确生成了 52 张牌，并且每张牌的 description 格式正确
                let arr = createDeck()
                // ✅ map 取出每张牌的 description，再用 joined 拼成一个字符串
                let deckArr = arr.map({
                    aCard in
                    return aCard.description
                })
                let deckStr = deckArr.joined(separator: "  ")
                print(deckStr)
                
                testBtnText = "枚举和结构体"
                let ace = Rank.jack
                let aceRawValue = ace.rawValue
                let hearts = Suit.hearts
                let heartsDescription = hearts.simpleDescription()
                
                let threeOfSpades = Card(rank: .three, suit: .spades)
                let threeOfSpadesDescription = threeOfSpades.simpleDescription()
                testResult = """
                ace: \(ace)
                aceRawValue: \(aceRawValue)
                hearts: \(hearts)
                heartsDescription: \(heartsDescription)
                threeOfSpades: \(threeOfSpades)
                threeOfSpadesDescription: \(threeOfSpadesDescription)
                """
            } label: {
                Text("枚举和结构体")
            }
            
            
            // 测试函数和闭包
            Button {
                
                let arrs = [1,2,3,4]
                // ✅ 完整写法（指定参数类型和返回类型）
                let res = arrs.map({ (item: Int) -> Int in
                    return item * 3
                })

                // ✅ 省略类型（Swift 可自动推断）
                let res1 = arrs.map({ item in
                    return item * 3
                })
                print(res)
                print(res1)
                
                testBtnText = "测试函数和闭包"
                // 测试函数当作参数
//                let increment = makeIncrementer()
//                testResult = "\(increment(7))"
                
                // 测试函数当作参数
                let numbers = [1, 2, 4, 8, 16]
                testResult = hasAnyMatches(list: numbers, condition: lessThanTen) ? "有小于10的数" : "没有小于10的数"
            } label: {
                Text("测试函数和闭包")
            }
            
            // 测试对象和类
            Button {
                testBtnText = "测试对象和类"
                // 测试对象和类
                let nameShape = NamedShape(name: "my test shape")
                print(nameShape.simpleDescription())
                print(nameShape.name)
                nameShape.numberOfSides = 7
                print(nameShape.numberOfSides)
                testResult = "\(nameShape.numberOfSides)"
            } label: {
                Text("测试对象和类")
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(title)
    }
}

// ⚠️ 这里只是 Xcode 预览用的模拟数据，不影响实际运行
// 实际运行时参数由 SettingView 的 NavigationLink 动态传入
#Preview {
    NavigationStack {
        SwiftPracticeView(id: 101, title: "swift初见")
    }
}
