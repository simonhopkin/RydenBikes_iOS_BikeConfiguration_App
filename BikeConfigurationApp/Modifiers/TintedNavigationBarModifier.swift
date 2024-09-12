//
//  TintedNavigationBarModifier.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 07/09/2024.
//

import Foundation
import SwiftUI

struct TintedNavigationBarModifier: ViewModifier {

    let tintColor: UIColor
    let backgroundColor: UIColor
    
    init(tintColor: UIColor, backgroundColor: UIColor) {
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: tintColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
        
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func tintedNavigationBar(tintColor: UIColor, backgroundColor: UIColor) -> some View {
        self.modifier(TintedNavigationBarModifier(tintColor: tintColor, backgroundColor: backgroundColor))
    }
}
