//
//  11_错误处理.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/13.
//

import SwiftUI

enum VendingMachineError: Error {
    case invalidSelection // 无效选择
    case insufficientFunds(coinsNeeded: Int) // 金钱不足，需要的金额
    case outOfStock // 缺货
}

struct vendItem {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": vendItem(price: 12, count: 7),
        "Chips": vendItem(price: 10, count: 4),
        "Pretzels": vendItem(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct SwiftErrorHandleView: View {
    
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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // 标题
                Text("Swift 可选链式调用")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Divider()

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

                // 测试按钮区
                VStack(spacing: 12) {
                                        
                    Button(action: {
                        testBtnText = "错误处理示例"
                        // 用 do-catch 捕获 throwing 函数抛出的错误
                        let machine = VendingMachine()
                        machine.coinsDeposited = 8 // 存入8枚硬币，Chips需要10枚，会触发insufficientFunds
                        do {
                            try buyFavoriteSnack(person: "Alice", vendingMachine: machine)
                            testResult = "购买成功！"
                        } catch VendingMachineError.invalidSelection {
                            testResult = "❌ 错误：无效的商品选择"
                        } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
                            testResult = "❌ 错误：金币不足，还需要 \(coinsNeeded) 枚硬币"
                        } catch VendingMachineError.outOfStock {
                            testResult = "❌ 错误：商品已售罄"
                        } catch {
                            testResult = "❌ 未知错误：\(error)"
                        }
                    }, label: {
                        Text("错误处理")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle("错误处理")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview() {
    NavigationStack {
        SwiftErrorHandleView()
    }
}
