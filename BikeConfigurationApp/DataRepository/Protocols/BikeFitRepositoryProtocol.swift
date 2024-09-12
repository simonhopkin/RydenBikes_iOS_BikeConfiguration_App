//
//  BikeFitDataStoreProtocol.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import Foundation

protocol BikeFitRepositoryProtocol {
    func fetchBikeFits() -> [BikeFit]
    func addBikeFit(_ bikeFit: BikeFit)
}
