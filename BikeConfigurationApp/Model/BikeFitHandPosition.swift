//
//  BikeFitHandPosition.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 07/09/2024.
//

import Foundation

class BikeFitHandPosition : Codable {
    var saddleCentreToHand: Double
    var saddleToHandDrop: Double
    
    init(saddleCentreToHand: Double, saddleToHandDrop: Double) {
        self.saddleCentreToHand = saddleCentreToHand
        self.saddleToHandDrop = saddleToHandDrop
    }
}
