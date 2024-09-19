//
//  SplashScreenView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 06/09/2024.
//

import SwiftUI

/// Not currently used but can be if we want to show the launch screen for longer
struct SplashView: View {
    @State var shouldDisplaySplashView: Bool = true
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        ZStack {
            if shouldDisplaySplashView {
                
                Image("SplashBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height)
                    .clipped()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer()
                        .frame(height: UIScreen.main.bounds.size.height * 0.098)
                    
                    Image("BrandAndLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 357, height: 150)
                        .padding(0)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else {
                HomeView(navigationPath: $navigationPath)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                shouldDisplaySplashView = false
            }
        }
    }
}

#Preview {
    @State var navigationPath = NavigationPath()
    return SplashView(navigationPath: $navigationPath)
}
