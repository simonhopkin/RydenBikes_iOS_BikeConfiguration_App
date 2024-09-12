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
    
    func deleteBikeFit(_ bikeFit: BikeFit) {
        bikeFitRepository.deleteBikeFit(bikeFit)
        bikeFits = bikeFitRepository.fetchBikeFits()
    }
}

extension BikeFit {
    var bikeFitAppLink: String {
        get {
            let url = "https://ryden.bikes/bikeFit"
            + "?created=\(Int64(created.timeIntervalSince1970 * 1000))"
            + "&name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))"
            + "&notes=\(notes.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))"
            + "&bb2SC=\(String(format: "%.1f", bbToSaddleCentre))"
            + "&bb2SA=\(String(format: "%.2f", bbToSaddleAngle))"
//            + "&bb2SX=\(String(format: "%.1f", bbToSaddleX))"
//            + "&bb2SY=\(String(format: "%.1f", bbToSaddleY))"
            + "&sC2H=\(String(format: "%.1f", saddleCentreToHand))"
            + "&s2HD=\(String(format: "%.1f", saddleToHandDrop))"
            + "&bb2HC=\(String(format: "%.1f", bbToHandlebarCentre))"
            + "&bb2HA=\(String(format: "%.2f", bbToHandlebarAngle))"
//            + "&bb2HX=\(String(format: "%.1f", bbToHandlebarX))"
//            + "&bb2HY=\(String(format: "%.1f", bbToHandlebarY))"
            return url
        }
    }
}
