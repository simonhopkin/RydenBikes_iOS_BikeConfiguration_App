//
//  ViewCoordinator.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import SwiftUI
import SwiftData

enum Route : Hashable {
    case myFitView
    case myFitDetailsView(BikeFit)
    case measurementView(BikeFit, Int)
    case myBikes
}

struct Coordinator {

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
}
