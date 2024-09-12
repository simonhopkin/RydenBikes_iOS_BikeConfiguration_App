//
//  SplashScreenView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 06/09/2024.
//

import SwiftUI

struct SplashView: View {
    @State var shouldDisplaySplashView: Bool = true
    
    var body: some View {
        ZStack {
            if shouldDisplaySplashView {
                GeometryReader { geometry in
                    
                    Image("SplashBackground")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height)
                        .clipped()
                        .ignoresSafeArea()
                    
                    VStack(spacing: 10) {
                        Spacer().background(Color.red)
                            .frame(height: geometry.size.height * 0.1)
                        Image("RydenBikesIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 85, height: 85)
                        Text("Ryden Bikes")
                            .font(.custom("Roboto-Black", size: 48))
                            .bold()
                            .foregroundColor(Color("PrimaryTextColor"))
                    }
                    .frame(width: geometry.size.width)
                }
                .ignoresSafeArea()
            }
            else {
                HomeView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                shouldDisplaySplashView = false
            }
        }
    }
}

#Preview {
    SplashView()
}
