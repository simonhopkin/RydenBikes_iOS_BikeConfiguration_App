//
//  MyFitViewModel.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import Foundation

//@Observable
class MyFitViewModel {
    
    private let bikeFitRepository: BikeFitRepositoryProtocol
//    var bikeFits = [BikeFit]()
    
    init(bikeFitRepository: BikeFitRepositoryProtocol) {
        self.bikeFitRepository = bikeFitRepository
//        fetchData()
    }
    
//    func fetchData() {
//        bikeFits = bikeFitRepository.fetchBikeFits()
//    }
    
    func deleteBikeFit(_ bikeFit: BikeFit) {
        bikeFitRepository.deleteBikeFit(bikeFit)
//        bikeFits = bikeFitRepository.fetchBikeFits()
    }
}

