//
//  DecimalTextField.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import SwiftUI

/// Wrappper around `TextField` to display `Double` values with an optional suffix label
struct DecimalTextField: View {
    var placeholder: String
    @Binding var value: Double
    var format: String = "%.0f"
    
    var body: some View {
        TextField(placeholder, text: Binding (
            get: { value != 0 ? String(format: format, value) : "" },
            set: { newValue in
                if let doubleValue = Double(newValue) {
                    value = doubleValue
                }
            }
        ))
        .keyboardType(.decimalPad)
        .multilineTextAlignment(.trailing)
    }
}

extension View {
    func suffix(_ suffix: String, minWidth: CGFloat? = 0, color: Color = .gray, font: Font = .body, padding: CGFloat = 8) -> some View {
        self.modifier(DecimalTextFieldSuffixModifier(suffix: suffix, minWidth: minWidth, color: color, font: font, padding: padding))
    }
}

struct DecimalTextFieldSuffixModifier: ViewModifier {

    let suffix: String
    let minWidth: CGFloat?
    let color: Color
    let font: Font
    let padding: CGFloat

    init(suffix: String, minWidth: CGFloat? = nil, color: Color = .gray, font: Font = .body, padding: CGFloat = 8) {
        self.suffix = suffix
        self.minWidth = minWidth
        self.color = color
        self.font = font
        self.padding = padding
    }
    
    func body(content: Content) -> some View {
        HStack(alignment: .bottom) {
            content
            Text(suffix)
                .foregroundColor(color)
                .font(font)
                .frame(minWidth: minWidth, alignment: .leading)
                .padding(.bottom, padding)
                .padding(.top, padding)
        }
    }
}
