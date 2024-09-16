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
    @State var rootActivitySheet: (any View)?

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 20) {
                Button(action: {
                    showAlert = true
                }) {
                    Text("My Bikes")
                        .font(.custom("Roboto-Regular", size: 30))
                        .foregroundStyle(Color("PrimaryTextColor"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Button(action: {
                    navigationPath.append(Coordinator.View.myFitView)
                }) {
                    Text("My Fit")
                        .font(.custom("Roboto-Regular", size: 30))
                        .foregroundStyle(Color("PrimaryTextColor"))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                Button(action: {
                    showAlert = true
                }) {
                    Text("Knowledge")
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
            .navigationDestination(for: Coordinator.View.self) { view in
                switch view {
                    
                case .myFitView:
                    MyFitView(navigationPath: $navigationPath,
                              viewModel: MyFitViewModel(bikeFitRepository: BikeFitRepository(modelContext: modelContext)))
                    
                case .myFitDetailsView(let bikeFit):
                    MyFitDetailsView(navigationPath: $navigationPath,
                                     viewModel: MyFitDetailsViewModel(bikeFitRepository: BikeFitRepository(modelContext: modelContext),
                                                                      bikeFit: bikeFit))
                    
                case .measureSaddlePositionView(let bikeFit):
                    MeasureSaddlePositionView(bikeFit: bikeFit, navigationPath: $navigationPath)
                }
            }
        }
    }
    
}

#Preview {
    @State var navigationPath = NavigationPath()
    return HomeView(navigationPath: $navigationPath)
}
