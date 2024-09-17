//
//  BikeFit.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 07/09/2024.
//

import Foundation
import SwiftData
import Combine
import SwiftUI

extension BikeFit {
    var bikeFitAppLink: String {
        get {
            let url = "https://ryden.bike/bikeFit"
            + "?created=\(Int64(created.timeIntervalSince1970 * 1000))"
            + "&name=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
            + "&notes=\(notes.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"
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

extension BikeFit {
    
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

extension BikeFit {
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
                
                bikeFit.computeSaddleXAndY()
                bikeFit.computeHandlebarXAndY()
                bikeFit.computeHandXAndY()

                return bikeFit
            }
        }
        
        return nil
    }
}

extension BikeFit : CustomStringConvertible {
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
