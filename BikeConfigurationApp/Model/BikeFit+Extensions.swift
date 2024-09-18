//
//  BikeFit+Extensions.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 07/09/2024.
//

import Foundation
import SwiftData
import Combine
import SwiftUI

extension BikeFit {
    
    /// Computes `bbToSaddleX` and `bbToSaddleY` from `bbToSaddleCentre` and `bbToSaddleAngle`
    func computeSaddleXAndY(bbToSaddleAngle: Double, bbToSaddleCentre: Double) -> (bbToSaddleX: Double, bbToSaddleY: Double)? {
        guard bbToSaddleAngle != 0 && bbToSaddleCentre != 0 else {
            return nil
        }
            
        let saddleAngleRadians = (90 - bbToSaddleAngle) * .pi / 180.0
        
        let x = bbToSaddleCentre * sin(saddleAngleRadians) // calculate the opposite (X)
        let y = bbToSaddleCentre * cos(saddleAngleRadians) // calculate the adjacent (Y)
               
        return (bbToSaddleX: x, bbToSaddleY: y)
    }
    
    /// Computes `bbToSaddleAngle` and `bbSaddleY` from `bbToSaddleX` and `bbToSaddleCentre`
    func computeSaddleAngleAndY(bbToSaddleCentre: Double, bbToSaddleX: Double) -> (bbToSaddleAngle: Double, bbToSaddleY: Double)? {
        
        guard bbToSaddleX != 0 && bbToSaddleCentre != 0 else {
            return nil
        }
            
        let angle = acos(bbToSaddleX / bbToSaddleCentre) * 180.0 / .pi
        let y = sqrt(pow(bbToSaddleCentre, 2) - pow(bbToSaddleX, 2))
            
        return (bbToSaddleAngle: angle, bbToSaddleY: y)
    }
    
    /// Computes `bbToSaddleCentre` and `bbToSaddleAngle` from `bbToSaddleX` and `bbToSaddleY`
    func computeSaddleCentreAndAngle(bbToSaddleX: Double, bbToSaddleY: Double) -> (bbToSaddleAngle: Double, bbToSaddleCentre: Double)? {
        
        guard bbToSaddleX != 0 && bbToSaddleY != 0 else {
            return nil
        }
        
        let angle = atan(bbToSaddleY / bbToSaddleX) * 180.0 / .pi
        let height = sqrt(pow(bbToSaddleX, 2) + pow(bbToSaddleY, 2))
        
        return (bbToSaddleAngle: angle, bbToSaddleCentre: height)
    }
    
    /// Computes `bbToHandX` and `bbToHandY` from `saddleCentreToHand`, `saddleToHandDrop`, `bbToSaddleX`, and`bbToSaddleY`
    func computeHandXAndY(saddleCentreToHand: Double, saddleToHandDrop: Double, bbToSaddleX: Double, bbToSaddleY: Double) -> (bbToHandX: Double, bbToHandY: Double)? {
        guard saddleCentreToHand != 0 && saddleToHandDrop != 0 && bbToSaddleX != 0 && bbToSaddleY != 0 else {
            return nil
        }
        
        let x = sqrt(pow(saddleCentreToHand, 2) - pow(saddleToHandDrop, 2)) - bbToSaddleX
        let y = bbToSaddleY - saddleToHandDrop
        
        return (bbToHandX: x, bbToHandY: y)
    }
    
    /// Computes `saddleCentreToHand` and `saddleToHandDrop` from  `bbToHandX`, `bbToHandY`, `bbToSaddleX` and `bbToSaddleY`
    func computeHandPositions(bbToHandX: Double, bbToHandY: Double, bbToSaddleX: Double, bbToSaddleY: Double) -> (saddleCentreToHand: Double, saddleToHandDrop: Double)? {
        guard bbToHandX != 0 && bbToHandY != 0 && bbToSaddleX != 0 && bbToSaddleY != 0 else {
            return nil
        }
            
        let y = bbToSaddleY - bbToHandY
        let x = sqrt(pow(y, 2) + pow(bbToHandX + bbToSaddleX, 2))
        
        return (saddleCentreToHand: x, saddleToHandDrop: y)
    }
    
    /// Computes `bbToHandlebarX` and `bbToHandlebarY` from `bbToHandlebarCentre` and `bbToHandlebarAngle`
    func computeHandlebarXAndY(bbToHandlebarAngle: Double, bbToHandlebarCentre: Double) -> (bbToHandlebarX: Double, bbToHandlebarY: Double)? {
        guard bbToHandlebarAngle != 0 && bbToHandlebarCentre != 0 else {
            return nil
        }
        
        let handlebarAngleRadians = (90 - bbToHandlebarAngle) * .pi / 180.0
        
        let x = bbToHandlebarCentre * sin(handlebarAngleRadians) // calculate the opposite (X)
        let y = bbToHandlebarCentre * cos(handlebarAngleRadians) // calculate the adjacent (Y)
        
        return (bbToHandlebarX: x, bbToHandlebarY: y)
    }
    
    /// Computes `bbToHandlebarAngle` and `bbToHandlebarY` from `bbToHandlebarX` and `bbToHandlebarCentre`
    func computeHandlebarAngleAndY(bbToHandlebarCentre: Double, bbToHandlebarX: Double) -> (bbToHandlebarAngle: Double, bbToHandlebarY: Double)? {
        
        guard bbToHandlebarCentre != 0 && bbToHandlebarX != 0 else {
            return nil
        }
            
        let angle = 90 - asin(bbToHandlebarX / bbToHandlebarCentre) * 180.0 / .pi
        let y = sqrt(pow(bbToHandlebarCentre, 2) - pow(bbToHandlebarX, 2))
        
        return (bbToHandlebarAngle: angle, bbToHandlebarY: y)
    }
    
    /// Computes `bbToHandlebarCentre` and `bbToHandlebarAngle` from `bbToHandlebarX` and `bbToHandlebarY`
    func computeHandlebarCentreAndAngle(bbToHandlebarX: Double, bbToHandlebarY: Double) -> (bbToHandlebarAngle: Double, bbToHandlebarCentre: Double)? {
        
        guard bbToHandlebarX != 0 && bbToHandlebarY != 0 else {
            return nil
        }
            
        let angle = 90 - atan(bbToHandlebarX / bbToHandlebarY) * 180.0 / .pi
        let height = sqrt(pow(bbToHandlebarX, 2) + pow(bbToHandlebarY, 2))
        
        return (bbToHandlebarAngle: angle, bbToHandlebarCentre: height)
    }
    
    func updatePropertyIfChanged( _ property: inout Double, value: Double) {
        if property != value {
            property = value
        }
    }
}


/// `BikeFit` extension adding capability to export `BikeFit` to a URL string and construct a `BikeFit` from a `URL`
extension BikeFit {
    
    /// Generates a link for sharing BikeFit
    var bikeFitAppLink: String {
        get {
            let url = "https://ryden.bike/bikeFit"
            + "?created=\(Int64(created.timeIntervalSince1970 * 1000))"
            + "&name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
            + "&notes=\(notes.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
            + "&bb2SC=\(String(format: "%.1f", bbToSaddleCentre))"
            + "&bb2SA=\(String(format: "%.2f", bbToSaddleAngle))"
            + "&sC2H=\(String(format: "%.1f", saddleCentreToHand))"
            + "&s2HD=\(String(format: "%.1f", saddleToHandDrop))"
            + "&bb2HC=\(String(format: "%.1f", bbToHandlebarCentre))"
            + "&bb2HA=\(String(format: "%.2f", bbToHandlebarAngle))"
            return url
        }
    }
    
    /// Creates a new BikeFit object from a url
    static func bikeFitFromUrl(_ url: URL) -> BikeFit? {
        
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let queryItems = components.queryItems {
            
            if let created = Double(queryItems.first(where: { $0.name == "created" })?.value ?? ""),
               let name = queryItems.first(where: { $0.name == "name" })?.value,
               let bb2SC = Double(queryItems.first(where: { $0.name == "bb2SC" })?.value ?? ""),
               let bb2SA = Double(queryItems.first(where: { $0.name == "bb2SA" })?.value ?? ""),
               let sC2H = Double(queryItems.first(where: { $0.name == "sC2H" })?.value ?? ""),
               let s2HD = Double(queryItems.first(where: { $0.name == "s2HD" })?.value ?? ""),
               let bb2HC = Double(queryItems.first(where: { $0.name == "bb2HC" })?.value ?? ""),
               let bb2HA = Double(queryItems.first(where: { $0.name == "bb2HA" })?.value ?? "") {
                
                let createdDate = Date(timeIntervalSince1970: created / 1000)
                let notes = queryItems.first(where: { $0.name == "notes" })?.value ?? ""
                
                let bikeFit = BikeFit(created: createdDate, name: name, notes: notes, bbToSaddleCentre: bb2SC, bbToSaddleAngle: bb2SA, bbToSaddleX: 0, bbToSaddleY: 0, saddleCentreToHand: sC2H, saddleToHandDrop: s2HD, bbToHandX: 0, bbToHandY: 0, bbToHandlebarCentre: bb2HC, bbToHandlebarAngle: bb2HA, bbToHandlebarX: 0, bbToHandlebarY: 0)
                
                bikeFit.updateSaddleXAndYIfChanged()
                bikeFit.updateHandlebarXAndYIfChanged()
                bikeFit.updateHandXAndYIfChanged()

                return bikeFit
            }
        }
        
        return nil
    }
}

/// `BikeFit` extension adding convenience functions to create an empty `BikeFit` and validate a `BikeFit`
extension BikeFit {
    
    /// Convenience function to create a new empty BikeFit object
    static func new() -> BikeFit {
        BikeFit(name: "",
                notes: "",
                bbToSaddleCentre: 0,
                bbToSaddleAngle: 0,
                bbToSaddleX: 0,
                bbToSaddleY: 0,
                saddleCentreToHand: 0,
                saddleToHandDrop: 0,
                bbToHandX: 0,
                bbToHandY: 0,
                bbToHandlebarCentre: 0,
                bbToHandlebarAngle: 0,
                bbToHandlebarX: 0,
                bbToHandlebarY: 0)
    }
    
    /// Validation function to check all the properties of BikeFit have been set
    func isValid() -> Bool {
        
        if name.isEmpty {
            return false
        }
        
        if bbToSaddleCentre == 0 {
            return false
        }
        
        if bbToSaddleAngle == 0 {
            return false
        }
        
        if bbToSaddleX == 0 {
            return false
        }
        
        if bbToSaddleY == 0 {
            return false
        }
        
        if saddleCentreToHand == 0 {
            return false
        }
        
        if saddleToHandDrop == 0 {
            return false
        }
        
        if bbToHandX == 0 {
            return false
        }
        
        if bbToHandY == 0 {
            return false
        }
        
        if bbToHandlebarCentre == 0 {
            return false
        }
        
        if bbToHandlebarAngle == 0 {
            return false
        }
        
        if bbToHandlebarX == 0 {
            return false
        }
        
        if bbToHandlebarY == 0 {
            return false
        }
        
        return true
    }
    
}

/// `BikeFit` extension adding capability to convert a `BikeFit` to a human readable string representation
extension BikeFit : CustomStringConvertible {
    
    /// Generates a string from a BikeFit object for debugging purposes
    var description: String {
        return "BikeFit("
        + "id: \(id),"
        + "created: \(created),"
        + "name: \(name),"
        + "notes: \(notes),"
        + "bbToSaddleCentre: \(bbToSaddleCentre),"
        + "bbToSaddleAngle: \(bbToSaddleAngle),"
        + "bbToSaddleX: \(bbToSaddleX),"
        + "bbToSaddleY: \(bbToSaddleY),"
        + "saddleCentreToHand: \(saddleCentreToHand),"
        + "saddleToHandDrop: \(saddleToHandDrop),"
        + "bbToHandX: \(bbToHandX),"
        + "bbToHandY: \(bbToHandY),"
        + "bbToHandlebarCentre: \(bbToHandlebarCentre),"
        + "bbToHandlebarAngle: \(bbToHandlebarAngle),"
        + "bbToHandlebarX: \(bbToHandlebarX),"
        + "bbToHandlebarY: \(bbToHandlebarY),"
        + ")"
    }
}
