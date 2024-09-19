//
//  ContentView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 05/09/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var showAlert = false
    @Binding var navigationPath: NavigationPath
    @Environment(\.modelContext) var modelContext
    @Environment(\.openURL) var openURL
    @State var rootActivitySheet: (any View)?
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 20) {
                Button(action: {
                    navigationPath.append(Route.myBikes)
                }) {
                    Text("My Bikes")
                        .font(.custom("Roboto-Regular", size: 30))
                        .foregroundStyle(Color("PrimaryTextColor"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Button(action: {
                    navigationPath.append(Route.myFitView)
                }) {
                    Text("My Fit")
                        .font(.custom("Roboto-Regular", size: 30))
                        .foregroundStyle(Color("PrimaryTextColor"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Button(action: {
                    openURL(URL(string: "https://shop.ryden.bike")!)
                }) {
                    Text("Store")
                        .font(.custom("Roboto-Regular", size: 30))
                        .foregroundStyle(Color("PrimaryTextColor"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .alert("Not Yet Implemented", isPresented: $showAlert) { }
            .navigationTitle("Ryden Bikes")
            .navigationBarTitleDisplayMode(.inline)
            .tintedNavigationBar(tintColor: UIColor(Color.primary),
                                 backgroundColor: UIColor.systemBackground)
            .navigationDestination(for: Route.self) { route in
                
                Coordinator().getViewForRoute(route,
                                              navigationPath: $navigationPath,
                                              modelContext: modelContext)
            }
        }
    }
}

#Preview {
    @State var navigationPath = NavigationPath()
    return HomeView(navigationPath: $navigationPath)
}
