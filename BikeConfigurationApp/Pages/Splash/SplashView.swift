//
//  SplashScreenView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 06/09/2024.
//

import SwiftUI

/// Splash page extends the launch screen so that its visible for longer than the default launch screen
/// Once it has been shown for a period of time it shows the `HomeView`
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
    @Previewable @State var navigationPath = NavigationPath()
    return SplashView(navigationPath: $navigationPath)
}
