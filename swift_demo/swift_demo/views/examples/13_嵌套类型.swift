//
//  13_嵌套类型.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/17.
//

import SwiftUI

// 嵌套类型实践
// 在 Swift 中，你可以在一个类型（如类、结构体或枚举）内部定义另一个类型，这被称为嵌套类型。嵌套类型可以帮助你组织代码，使相关的类型更紧密地联系在一起，提高代码的可读性和可维护性。
// BlackjackCard(21点的游戏)结构体中包含俩个 枚举 类型 Suit 和 Rank，分别表示扑克牌的花色和点数。这些枚举类型被嵌套在 BlackjackCard 结构体内部，因为它们与 BlackjackCard 紧密相关。
// ace代表1或者11，J，Q，K代表10，其他的则是自己的数值。
struct BlackjackCard {
    enum Suit: String, Hashable {
        case spades = "♠️"
        case hearts = "❤️"
        case diamonds = "♦️"
        case clubs = "♣️"
    }
    
    enum Rank: Int, Hashable {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack = 11, queen, king, ace
        
        struct Values {
            let first: Int
            let second: Int?
        }
        
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjardCard 结构体的属性和方法
    var suit: Suit
    var rank: Rank
    var description: String {
            var output = "suit is \(suit.rawValue),"
        output += "value is \(rank.values.first)"
        if let secondValue = rank.values.second {
            output += " or \(secondValue)"
        }
        return output
    }
}

struct SwiftNestedTypeView: View {
    
    @State private var testBtnText: String = ""
    @State private var testResult: Any? = nil // 这里用 Any? 来存储不同类型的测试结果，方便展示
    
    // 将任意类型转成可展示的字符串
    private func formatResultText(_ value: Any?) -> String {
        guard let value = value else { return "" }
        if let arr = value as? [Any] {
            return arr.map { "\($0)" }.joined(separator: "\n")
        }
        return "\(value)"
    }
    
    var body: some View {
       
        // 测试结果展示区
        if !testBtnText.isEmpty {
            VStack(alignment: .leading, spacing: 6) {
                Text("测试按钮：\(testBtnText)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(formatResultText(testResult))
                    .font(.body)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
        
        Divider()
        
        Button(action: {
            
            testBtnText = "嵌套类型实践"
            let card = BlackjackCard(suit: .hearts, rank: .ace)
            testResult = "类型：\(testBtnText), 结果：\(card.description)"
            
        }, label: {
            Text("嵌套类型实践")
        })
        
    }
}

#Preview {
    NavigationStack {
        SwiftNestedTypeView()
    }
}
