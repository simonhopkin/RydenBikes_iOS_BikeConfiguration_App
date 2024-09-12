//
//  MyFitViewModel.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import Foundation

@Observable
class MyFitViewModel {
    
    private let bikeFitRepository: BikeFitRepositoryProtocol
    var bikeFits = [BikeFit]()
    
    init(bikeFitRepository: BikeFitRepositoryProtocol) {
        self.bikeFitRepository = bikeFitRepository
        fetchData()
    }
    
    func fetchData() {
        bikeFits = bikeFitRepository.fetchBikeFits()
    }
    
//    func addBikeFit() {
//        let bikeFit = BikeFit(name: "1st Road Bike Fit",
//                              notes: "From first bike fit session in June 2022, after raising saddle 15mm, shortening stem 20mm, and raising bars 5mm",
//                              bbToSaddleCentre: 10,
//                              bbToSaddleAngle: 20,
//                              bbToSaddleX: 30,
//                              bbToSaddleY: 40,
//                              saddleCentreToHand: 50,
//                              saddleToHandDrop: 60,
//                              bbToHandlebarCentre: 70,
//                              bbToHandlebarAngle: 80,
//                              bbToHandlebarX: 90,
//                              bbToHandlebarY: 100)
//        
//        bikeFitRepository.addBikeFit(bikeFit)
//        fetchData()
//    }
}
