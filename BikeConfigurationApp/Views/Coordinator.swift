//
//  ViewCoordinator.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

//import Foundation
import SwiftUI
import SwiftData

enum Route : Hashable {
    case myFitView
    case myFitDetailsView(BikeFit)
    case measurementView(BikeFit, Int)
//        case measureSaddlePositionView(BikeFit)
//        case measureHandlebarPositionView(BikeFit)
}

//protocol RoutedView : View {
//    var route: Route { get }
//}

struct Coordinator {

    
    @MainActor @ViewBuilder func getViewForRoute(_ destination: Route, navigationPath: Binding<NavigationPath>, modelContext: ModelContext) -> some View {
//        UIApplication.shared.isIdleTimerDisabled = false

        switch destination {
        case .myFitView:
            MyFitView(navigationPath: navigationPath,
                      viewModel: MyFitViewModel(bikeFitRepository: BikeFitRepository(modelContext: modelContext)))
            .onAppear(perform: {
                print("MyFitView isIdleTimerDisabled false")
                UIApplication.shared.isIdleTimerDisabled = false
            })
            
        case .myFitDetailsView(let bikeFit):
//            UIApplication.shared.isIdleTimerDisabled = true
            MyFitDetailsView(navigationPath: navigationPath,
                             viewModel: MyFitDetailsViewModel(bikeFitRepository: BikeFitRepository(modelContext: modelContext),
                                                              bikeFit: bikeFit))
            .onAppear(perform: {
                print("MyFitDetailsView isIdleTimerDisabled true")
                UIApplication.shared.isIdleTimerDisabled = true
            })
            
        case .measurementView(let bikeFit, let selectedPage):
//            UIApplication.shared.isIdleTimerDisabled = true
            MeasurementView(bikeFit: bikeFit, selectedPage: selectedPage, navigationPath: navigationPath)
                .onAppear(perform: {
                    print("MeasurementView isIdleTimerDisabled true")
                    UIApplication.shared.isIdleTimerDisabled = true
                })
        }
    }
    
//    func updateIdleTimer(for route: Route) {
//        switch route {
//        case .myFitView:
//            UIApplication.shared.isIdleTimerDisabled = false
//        case .myFitDetailsView(_):
//            UIApplication.shared.isIdleTimerDisabled = true
//        case .measurementView(_, _):
//            UIApplication.shared.isIdleTimerDisabled = true
//        }
//    }
}
