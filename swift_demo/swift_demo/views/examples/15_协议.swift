//
//  15_协议.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/17.
//

import SwiftUI

// 属性协议要求---
//FullyNamed 协议除了要求遵循协议的类型提供 fullName 属性外，并没有其他特别的要求。这个协议表示，任何遵循 FullyNamed 的类型，都必须有一个可读的 String 类型的实例属性 fullName。
protocol FullyNamed {
    var fullName: String { get }
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    //必须要有遵循FullyNamed协议的属性 fullName，否则会报错：Type 'Starship' does not conform to protocol 'FullyNamed'
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName 为 "USS Enterprise"



//委托设计模式
//委托是一种设计模式，它允许 类 或 结构体 将一些需要它们（类/结构体）负责的功能委托给其他类型的实例。
//委托模式的实现很简单：定义协议来封装那些需要被委托的功能，这样就能确保遵循协议的类型能提供这些功能。
//委托模式可以用来响应特定的动作，或者接收外部数据源提供的数据，而无需关心外部数据源的类型。

protocol RandomNumberGenerator {
    func random() -> Double
}
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
//print("Here's a random number: \(generator.random())")
// 打印 “Here's a random number: 0.374649919981//print("And another one: \(generator.random())`)))")
// 打印 “And another one: 0.729023776863283”
//下面的例子定义了2个基于骰子的游戏协议。
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}


struct SwiftProtocolView: View {
    var body: some View {
        Text("协议示例")
        
        Button(action: {
            
            let a = 10
            var b = a
            b = 11
            print("a: \(a), b: \(b)") // 输出 a: 10, b: 11，说明 a 和 b 是独立的值
            
        }, label: {
            Text("赋值")
        })
    }
}

#Preview {
    NavigationStack {
        SwiftProtocolView()
    }
}
