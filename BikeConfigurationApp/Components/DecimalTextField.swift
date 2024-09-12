//
//  DecimalTextField.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import SwiftUI

struct DecimalTextField: View {
    var placeholder: String
    @Binding var value: Double
    
    var body: some View {
        TextField(placeholder, text: Binding (
            get: { value != 0 ? String(format: "%.1f", value) : "" },
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
    func suffix(_ suffix: String, minWidth: CGFloat? = 0, color: Color = .gray, font: Font = .body) -> some View {
        self.modifier(DecimalTextFieldSuffixModifier(suffix: suffix, minWidth: minWidth, color: color, font: font))
    }
}

struct DecimalTextFieldSuffixModifier: ViewModifier {

    let suffix: String
    let minWidth: CGFloat?
    let color: Color
    let font: Font

    init(suffix: String, minWidth: CGFloat? = nil, color: Color = .gray, font: Font = .body) {
        self.suffix = suffix
        self.minWidth = minWidth
        self.color = color
        self.font = font
    }
    
    func body(content: Content) -> some View {
        HStack(alignment: .bottom) {
            content
            Text(suffix)
                .foregroundColor(color)
                .font(font)
                .frame(minWidth: minWidth, alignment: .leading)
                .padding(.bottom, 8)
                .padding(.top, 8)
        }
    }
}
