//
//  BikeFitDataStoreProtocol.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import Foundation
import Combine

/// Protocol for the bike fit repository to allow different sources for bike fit retrieval
protocol BikeFitRepositoryProtocol {
    func fetchBikeFits() -> [BikeFit]
    func addBikeFit(_ bikeFit: BikeFit)
    func deleteBikeFit(_ bikeFit: BikeFit)
}
