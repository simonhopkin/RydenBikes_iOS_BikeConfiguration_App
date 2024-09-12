//
//  BikeFitSaddlePosition.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 07/09/2024.
//

import Foundation

class BikeFitSaddlePosition : Codable {
    var bbToSaddleCentre: Double
    var bbToSaddleAngle: Double
    var bbToSaddleX: Double
    var bbToSaddleY: Double
    
    init(bbToSaddleCentre: Double, bbToSaddleAngle: Double, bbToSaddleX: Double, bbToSaddleY: Double) {
        self.bbToSaddleCentre = bbToSaddleCentre
        self.bbToSaddleAngle = bbToSaddleAngle
        self.bbToSaddleX = bbToSaddleX
        self.bbToSaddleY = bbToSaddleY
    }
}
