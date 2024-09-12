//
//  BikeFitHandlebarPosition.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 07/09/2024.
//

import Foundation

class BikeFitHandlebarPosition : Codable {
    var bbToHandlebarCentre: Double
    var bbToHandlebarAngle: Double
    var bbToHandlebarX: Double
    var bbToHandlebarY: Double
    
    init(bbToHandlebarCentre: Double, bbToHandlebarAngle: Double, bbToHandlebarX: Double, bbToHandlebarY: Double) {
        self.bbToHandlebarCentre = bbToHandlebarCentre
        self.bbToHandlebarAngle = bbToHandlebarAngle
        self.bbToHandlebarX = bbToHandlebarX
        self.bbToHandlebarY = bbToHandlebarY
    }
}
