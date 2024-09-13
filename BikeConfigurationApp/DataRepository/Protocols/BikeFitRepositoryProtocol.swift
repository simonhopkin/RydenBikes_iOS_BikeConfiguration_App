//
//  BikeFitDataStoreProtocol.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import Foundation
import Combine

protocol BikeFitRepositoryProtocol {
    func fetchBikeFits() -> [BikeFit]
    func addBikeFit(_ bikeFit: BikeFit)
    func deleteBikeFit(_ bikeFit: BikeFit)
    
//    func fetchBikeFitsPublisher() -> AnyPublisher<[BikeFit], Error>
}
