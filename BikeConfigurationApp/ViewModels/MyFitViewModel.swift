//
//  MyFitViewModel.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import Foundation

/// View model  used to maintain BikeFit reporistory objects
class MyFitViewModel {
    
    private let bikeFitRepository: BikeFitRepositoryProtocol
    
    init(bikeFitRepository: BikeFitRepositoryProtocol) {
        self.bikeFitRepository = bikeFitRepository
    }

    func deleteBikeFit(_ bikeFit: BikeFit) {
        bikeFitRepository.deleteBikeFit(bikeFit)
    }
}

