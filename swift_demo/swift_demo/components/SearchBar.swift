//
//  SearchBar.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/4/2.
//

import SwiftUI
import UIKit

// UIViewRepresentable wrapper for UISearchBar so it can be used in SwiftUI
struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        init(text: Binding<String>) { _text = text }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let sb = UISearchBar(frame: .zero)
        sb.delegate = context.coordinator
        sb.searchBarStyle = .minimal
        sb.placeholder = "搜索"
        return sb
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
    }
}
