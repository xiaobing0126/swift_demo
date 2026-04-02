//
//  Check.swift
//  swift_demo
//
//  Created by 小饼子 on 2026/4/2.
//

import SwiftUI

struct CheckBox: View {
    @Binding var isChecked: Bool
    var label: String

    // Callback when the icon is tapped (toggle happened)
    var onToggle: (() -> Void)? = nil

    // Callback when the label/text is tapped
    var onLabelTap: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 8) {
            // Icon-only button: toggles the binding and notifies via onToggle
            Button(action: {
                isChecked.toggle()
                onToggle?()
            }) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .foregroundColor(isChecked ? .blue : .gray)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
            .accessibilityLabel(isChecked ? Text("Checked") : Text("Unchecked"))

            // Label is a separate tappable area that triggers onLabelTap
            Button(action: {
                onLabelTap?()
            }) {
                Text(label)
                    .foregroundColor(.primary)
            }
            .buttonStyle(PlainButtonStyle())

            Spacer()
        }
        .contentShape(Rectangle()) // make the whole HStack tappable if needed
    }
}
