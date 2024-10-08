//
//  MyBikes.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 19/09/2024.
//

import SwiftUI

/// Placeholder page for the bikes section
struct MyBikes: View {
    
    /// navigation path for requesting page changes
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        VStack (spacing: 0) {
            Text("Hello, My Bikes")
            
            Spacer()
            
            FooterToolbarView(navigationPath: $navigationPath)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("My Bikes")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            // Override the navigation header bar to contain a back button
            leading: Button(action: {
                navigationPath.removeLast()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Home")
                }
            })
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    return MyBikes(navigationPath: $navigationPath)
}
