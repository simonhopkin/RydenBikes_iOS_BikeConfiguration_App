//
//  FooterToolbarView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 19/09/2024.
//

import SwiftUI

/// Footer to display at the bottom of all main pages
struct FooterToolbarView: View {
    
    /// navigation path for requesting page changes
    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack (spacing: 20) {
            
            Divider()

            HStack {
                VStack {
                    Image(systemName: "bicycle")
                        .foregroundColor(Color("PrimaryTextColor"))
                        .font(.system(size: 20))
                        .frame(width: 20, height: 20)
                    Text("My Bikes")
                        .foregroundColor(Color("PrimaryTextColor"))
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .onTapGesture {
                    navigationPath = NavigationPath()
                    navigationPath.append(Route.myBikes)
                }
                VStack {
                    Image(systemName: "ruler")
                        .foregroundColor(Color("PrimaryTextColor"))
                        .font(.system(size: 20))
                        .frame(width: 20, height: 20)
                    Text("My Fit")
                        .foregroundColor(Color("PrimaryTextColor"))
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .onTapGesture {
                    navigationPath = NavigationPath()
                    navigationPath.append(Route.myFitView)
                }

                VStack {
                    Image(systemName: "basket")
                        .foregroundColor(Color("PrimaryTextColor"))
                        .font(.system(size: 20))
                        .frame(width: 20, height: 20)
                    Text("Store")
                        .foregroundColor(Color("PrimaryTextColor"))
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .onTapGesture {
                    Coordinator().goToStore()
                }
            }
        }
        .padding(0)
        .padding(.bottom, 5)
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    return FooterToolbarView(navigationPath: $navigationPath)
}
