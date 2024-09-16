//
//  ViewCoordinator.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import Foundation

struct Coordinator {
    enum View : Hashable {
        case myFitView
        case myFitDetailsView(BikeFit)
        case measurementView(BikeFit, Int)
        case measureSaddlePositionView(BikeFit)
        case measureHandlebarPositionView(BikeFit)
    }
}
