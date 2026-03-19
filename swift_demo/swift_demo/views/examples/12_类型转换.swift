//
//  12_类型转换.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/3/17.
//

import SwiftUI

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

// 数组 library 的类型被推断为 [MediaItem]，因为它包含 MediaItem 类的子类 Movie 和 Song 的实例。
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

// Any 可以表示任何类型，包括函数类型。
// AnyObject 可以表示任何类类型的实例。

struct SwiftTypeConversionView: View {
    var body: some View {
        Text("类型转换示例")
        
        
        // 向下转型 as?（可选判断） 和 as!（强制判断）
        Button(action: {
            for item in library {
                if let movie = item as? Movie {
                    print("电影: \(movie.name), 导演: \(movie.director)")
                } else if let song = item as? Song {
                    print("歌曲: \(song.name), 艺术家: \(song.artist)")
                }
            }
        }, label: {
            Text("向下转型")
        })
        
        // 检查类型
        Button(action: {
            // 检查类型，用 is 操作符来检查一个实例是否属于特定子类
            var movieCount = 0
            var songCount = 0
            for item in library {
                if item is Movie {
                    movieCount += 1
                } else if item is Song {
                    songCount += 1
                }
            }
            print("电影数量: \(movieCount), 歌曲数量: \(songCount)")
            
            library.forEach { item in
                print(item)
            }
            
        }, label: {
            Text("检查类型")
        })
    }
}

#Preview {
    NavigationStack {
        SwiftTypeConversionView()
    }
}



