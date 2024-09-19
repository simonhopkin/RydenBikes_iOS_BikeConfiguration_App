//
//  ViewCoordinator.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import SwiftUI
import SwiftData

/// Possible page routes
enum Route : Hashable {
    case myFitView
    case myFitDetailsView(BikeFit)
    case measurementView(BikeFit, Int)
    case myBikes
}

/// Page coordinator to create views when navigation to a `Route`
struct Coordinator {

    /// Creates and initialises the correct view for the requested route.
    @MainActor @ViewBuilder func getViewForRoute(_ destination: Route, navigationPath: Binding<NavigationPath>, modelContext: ModelContext) -> some View {

        switch destination {
            
        case .myFitView:
            MyFitView(navigationPath: navigationPath,
                      viewModel: MyFitViewModel(bikeFitRepository: BikeFitRepository(modelContext: modelContext)))
            .onAppear(perform: {
                // ensure idle timer is not disabled so that screen can be dimmed when not in use
                UIApplication.shared.isIdleTimerDisabled = false
            })
            
        case .myFitDetailsView(let bikeFit):
            MyFitDetailsView(navigationPath: navigationPath,
                             viewModel: MyFitDetailsViewModel(bikeFitRepository: BikeFitRepository(modelContext: modelContext),
                                                              bikeFit: bikeFit))
            .onAppear(perform: {
                // ensure idle timer is enabled so that screen is not dimmed when making measurement adjustments
                UIApplication.shared.isIdleTimerDisabled = true
            })
            
        case .measurementView(let bikeFit, let selectedPage):
            MeasurementView(bikeFit: bikeFit, selectedPage: selectedPage, navigationPath: navigationPath)
                .onAppear(perform: {
                    // ensure idle timer is enabled so that screen is not dimmed when making measurement adjustments
                    UIApplication.shared.isIdleTimerDisabled = true
                })
            
        case .myBikes:
            MyBikes(navigationPath: navigationPath)
                .onAppear(perform: {
                    // ensure idle timer is not disabled so that screen can be dimmed when not in use
                    UIApplication.shared.isIdleTimerDisabled = false
                })
        }
    }
    
    /// Opens the browser and goes to the appropriate store based on the users locale
    func goToStore() {
        switch Locale.current.region?.identifier {
        case "US":
            UIApplication.shared.open(URL(string: "https://shop.rydenusa.bike")!)
        default:
            UIApplication.shared.open(URL(string: "https://shop.ryden.bike")!)
        }
    }
}
