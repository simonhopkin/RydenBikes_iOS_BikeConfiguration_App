//
//  BikeFitUtils.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 18/09/2024.
//

import Foundation

/// Utility structure to house all the bike fit calculations
struct BikeFitUtils {
    
    /// Computes `bbToSaddleX` and `bbToSaddleY` from `bbToSaddleCentre` and `bbToSaddleAngle`
    static func computeSaddleXAndY(bbToSaddleAngle: Double, bbToSaddleCentre: Double) -> (bbToSaddleX: Double, bbToSaddleY: Double)? {
        guard bbToSaddleAngle != 0 && bbToSaddleCentre != 0 else {
            return nil
        }
            
        let saddleAngleRadians = (90 - bbToSaddleAngle) * .pi / 180.0
        
        var x = bbToSaddleCentre * sin(saddleAngleRadians) // calculate the opposite (X)
        let y = bbToSaddleCentre * cos(saddleAngleRadians) // calculate the adjacent (Y)
        
        x += 3  // add 3mm to setback x to account for tool used to measure saddle angle and centre
               
        return (bbToSaddleX: x, bbToSaddleY: y)
    }
    
    /// Computes `bbToSaddleAngle` and `bbSaddleY` from `bbToSaddleX` and `bbToSaddleCentre`
    static func computeSaddleAngleAndY(bbToSaddleCentre: Double, bbToSaddleX: Double) -> (bbToSaddleAngle: Double, bbToSaddleY: Double)? {
        
        guard bbToSaddleX != 0 && bbToSaddleCentre != 0 else {
            return nil
        }
            
        let angle = acos(bbToSaddleX / bbToSaddleCentre) * 180.0 / .pi
        let y = sqrt(pow(bbToSaddleCentre, 2) - pow(bbToSaddleX, 2))
            
        return (bbToSaddleAngle: angle, bbToSaddleY: y)
    }
    
    /// Computes `bbToSaddleCentre` and `bbToSaddleAngle` from `bbToSaddleX` and `bbToSaddleY`
    static func computeSaddleCentreAndAngle(bbToSaddleX: Double, bbToSaddleY: Double) -> (bbToSaddleAngle: Double, bbToSaddleCentre: Double)? {
        
        guard bbToSaddleX != 0 && bbToSaddleY != 0 else {
            return nil
        }
        
        let angle = atan(bbToSaddleY / bbToSaddleX) * 180.0 / .pi
        let height = sqrt(pow(bbToSaddleX, 2) + pow(bbToSaddleY, 2))
        
        return (bbToSaddleAngle: angle, bbToSaddleCentre: height)
    }
    
    /// Computes `bbToHandX` and `bbToHandY` from `saddleCentreToHand`, `saddleToHandDrop`, `bbToSaddleX`, and`bbToSaddleY`
    static func computeHandXAndY(saddleCentreToHand: Double, saddleToHandDrop: Double, bbToSaddleX: Double, bbToSaddleY: Double) -> (bbToHandX: Double, bbToHandY: Double)? {
        guard saddleCentreToHand != 0 && saddleToHandDrop != 0 && bbToSaddleX != 0 && bbToSaddleY != 0 else {
            return nil
        }
        
        let x = sqrt(pow(saddleCentreToHand, 2) - pow(saddleToHandDrop, 2)) - bbToSaddleX
        let y = bbToSaddleY - saddleToHandDrop
        
        return (bbToHandX: x, bbToHandY: y)
    }
    
    /// Computes `saddleCentreToHand` and `saddleToHandDrop` from  `bbToHandX`, `bbToHandY`, `bbToSaddleX` and `bbToSaddleY`
    static func computeHandPositions(bbToHandX: Double, bbToHandY: Double, bbToSaddleX: Double, bbToSaddleY: Double) -> (saddleCentreToHand: Double, saddleToHandDrop: Double)? {
        guard bbToHandX != 0 && bbToHandY != 0 && bbToSaddleX != 0 && bbToSaddleY != 0 else {
            return nil
        }
            
        let y = bbToSaddleY - bbToHandY
        let x = sqrt(pow(y, 2) + pow(bbToHandX + bbToSaddleX, 2))
        
        return (saddleCentreToHand: x, saddleToHandDrop: y)
    }
    
    /// Computes `saddleCentreToHand` and `saddleToHandDrop` from  `bbToHandX`, `bbToHandY`, `bbToSaddleX` and `bbToSaddleY`
    static func computeHandPositions(bbToHandX: Double, bbToHandY: Double, bbToSaddleX: Double, bbToSaddleY: Double, groundToSaddle: Double) -> (saddleCentreToHand: Double, groundToGrip: Double)? {
        guard bbToHandX != 0 && bbToHandY != 0 && bbToSaddleX != 0 && bbToSaddleY != 0 && groundToSaddle != 0 else {
            return nil
        }
            
        let saddleToGripDrop = bbToSaddleY - bbToHandY
        let y = groundToSaddle - saddleToGripDrop
        let x = sqrt(pow(y, 2) + pow(bbToHandX + bbToSaddleX, 2))
        
        return (saddleCentreToHand: x, groundToGrip: y)
    }
    
    /// Computes `bbToHandlebarX` and `bbToHandlebarY` from `bbToHandlebarCentre` and `bbToHandlebarAngle`
    static func computeHandlebarXAndY(bbToHandlebarAngle: Double, bbToHandlebarCentre: Double) -> (bbToHandlebarX: Double, bbToHandlebarY: Double)? {
        guard bbToHandlebarAngle != 0 && bbToHandlebarCentre != 0 else {
            return nil
        }
        
        let handlebarAngleRadians = (90 - bbToHandlebarAngle) * .pi / 180.0
        
        let x = bbToHandlebarCentre * sin(handlebarAngleRadians) // calculate the opposite (X)
        let y = bbToHandlebarCentre * cos(handlebarAngleRadians) // calculate the adjacent (Y)
        
        return (bbToHandlebarX: x, bbToHandlebarY: y)
    }
    
    /// Computes `bbToHandlebarAngle` and `bbToHandlebarY` from `bbToHandlebarX` and `bbToHandlebarCentre`
    static func computeHandlebarAngleAndY(bbToHandlebarCentre: Double, bbToHandlebarX: Double) -> (bbToHandlebarAngle: Double, bbToHandlebarY: Double)? {
        
        guard bbToHandlebarCentre != 0 && bbToHandlebarX != 0 else {
            return nil
        }
            
        let angle = 90 - asin(bbToHandlebarX / bbToHandlebarCentre) * 180.0 / .pi
        let y = sqrt(pow(bbToHandlebarCentre, 2) - pow(bbToHandlebarX, 2))
        
        return (bbToHandlebarAngle: angle, bbToHandlebarY: y)
    }
    
    /// Computes `bbToHandlebarCentre` and `bbToHandlebarAngle` from `bbToHandlebarX` and `bbToHandlebarY`
    static func computeHandlebarCentreAndAngle(bbToHandlebarX: Double, bbToHandlebarY: Double) -> (bbToHandlebarAngle: Double, bbToHandlebarCentre: Double)? {
        
        guard bbToHandlebarX != 0 && bbToHandlebarY != 0 else {
            return nil
        }
            
        let angle = 90 - atan(bbToHandlebarX / bbToHandlebarY) * 180.0 / .pi
        let height = sqrt(pow(bbToHandlebarX, 2) + pow(bbToHandlebarY, 2))
        
        return (bbToHandlebarAngle: angle, bbToHandlebarCentre: height)
    }
    
    static func computeBBToHandlebarCentreToolAdjustment(bbToHandlebarCentre: Double) -> Double {
        return sqrt(pow(32, 2) + pow(bbToHandlebarCentre, 2))
    }
    
    static func computeBBToHandlebarAngleToolAdjustment(bbToHandlebarAngle: Double, bbToHandlebarCentre: Double) -> Double {
        return  bbToHandlebarAngle - atan(32 / bbToHandlebarCentre)
    }
    
    static func updatePropertyIfChanged( _ property: inout Double, value: Double) {
        if property != value {
            property = value
        }
    }
}
