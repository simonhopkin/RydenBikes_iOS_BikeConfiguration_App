//
//  BikeFit.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 07/09/2024.
//

import Foundation
import SwiftData
import Combine

/// `BikeFit` is a SwiftData model object used to persist bike fit measurements.
///
/// This class has computed properties which adjust when other properties update.
///
/// Unfortunately property observers didSet/willSet do not work with classes annotated with the
/// SwiftData @Model macro.  So instead a public computed property is used backed by a persisted
/// private property.
@Model
class BikeFit : Identifiable {
    let id: UUID
    let created: Date
    var name: String
    var notes: String
    
    // Saddle Position Properties
    
    private var _bbToSaddleCentre: Double
    @Transient var bbToSaddleCentre: Double {
        get { return _bbToSaddleCentre}
        set { 
            print("bbToSaddleCentre set")
            _bbToSaddleCentre = newValue
            computeSaddleXAndY() // saddle height has changed, so recalculate x and y if saddle angle is known
        }
    }
    
    private var _bbToSaddleAngle: Double
    @Transient var bbToSaddleAngle: Double {
        get { return _bbToSaddleAngle}
        set {
            print("bbToSaddleAngle set")
            _bbToSaddleAngle = newValue
            computeSaddleXAndY() // saddle angle has changed, so recalculate x and y if saddle height is known
        }
    }
    
    private var _bbToSaddleX: Double
    @Transient var bbToSaddleX: Double {
        get { return _bbToSaddleX }
        set {
            print("bbToSaddleX set")
            _bbToSaddleX = newValue
            // if X is edited and Y, angle and saddle height are known then recalculate the angle and Y
            computeSaddleAngleAndY()
        }
    }
    
    private var _bbToSaddleY: Double
    @Transient var bbToSaddleY: Double {
        get { return _bbToSaddleY }
        set {
            print("bbToSaddleY set")
            _bbToSaddleY = newValue
            // if Y is edited and X, angle and saddle height are known then recalculate the angle and saddle height
            computeSaddleCentreAndAngle()
        }
            
    }

    // Hand Position Properties
    
    var saddleCentreToHand: Double
    var saddleToHandDrop: Double
    
    // Handlebar Position Properties
    
    var bbToHandlebarCentre: Double
    var bbToHandlebarAngle: Double
    var bbToHandlebarX: Double
    var bbToHandlebarY: Double
    
    @Transient
    private var cancellables = Set<AnyCancellable>()
    
    init(id: UUID, created: Date, name: String, notes: String, bbToSaddleCentre: Double, bbToSaddleAngle: Double, bbToSaddleX: Double, bbToSaddleY: Double, saddleCentreToHand: Double, saddleToHandDrop: Double, bbToHandlebarCentre: Double, bbToHandlebarAngle: Double, bbToHandlebarX: Double, bbToHandlebarY: Double) {
        self.id = id
        self.created = created
        self.name = name
        self.notes = notes
        self._bbToSaddleCentre = bbToSaddleCentre
        self._bbToSaddleAngle = bbToSaddleAngle
        self._bbToSaddleX = bbToSaddleX
        self._bbToSaddleY = bbToSaddleY
        self.saddleCentreToHand = saddleCentreToHand
        self.saddleToHandDrop = saddleToHandDrop
        self.bbToHandlebarCentre = bbToHandlebarCentre
        self.bbToHandlebarAngle = bbToHandlebarAngle
        self.bbToHandlebarX = bbToHandlebarX
        self.bbToHandlebarY = bbToHandlebarY
    }
    
    convenience init(name: String, notes: String, bbToSaddleCentre: Double, bbToSaddleAngle: Double, bbToSaddleX: Double, bbToSaddleY: Double, saddleCentreToHand: Double, saddleToHandDrop: Double, bbToHandlebarCentre: Double, bbToHandlebarAngle: Double, bbToHandlebarX: Double, bbToHandlebarY: Double) {
        self.init(id: UUID(),
                  created: Date.now,
                  name: name,
                  notes: notes,
                  bbToSaddleCentre:
                    bbToSaddleCentre,
                  bbToSaddleAngle: bbToSaddleAngle,
                  bbToSaddleX: bbToSaddleX,
                  bbToSaddleY: bbToSaddleY,
                  saddleCentreToHand: saddleCentreToHand,
                  saddleToHandDrop: saddleToHandDrop,
                  bbToHandlebarCentre: bbToHandlebarCentre,
                  bbToHandlebarAngle: bbToHandlebarAngle,
                  bbToHandlebarX: bbToHandlebarX,
                  bbToHandlebarY: bbToHandlebarY)
    }

    
    static func new() -> BikeFit {
        BikeFit(name: "",
                notes: "",
                bbToSaddleCentre: 0,
                bbToSaddleAngle: 0,
                bbToSaddleX: 0,
                bbToSaddleY: 0,
                saddleCentreToHand: 0,
                saddleToHandDrop: 0,
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
    
    /// Computes `bbSaddleX` and `bbSaddleY` from `bbToSaddleCentre` and `bbToSaddleAngle`
    private func computeSaddleXAndY() {
        if _bbToSaddleAngle != 0 && _bbToSaddleCentre != 0 {
            
            let saddleAngleRadians = (90 - _bbToSaddleAngle) * .pi / 180.0
            
            let x = _bbToSaddleCentre * sin(saddleAngleRadians) // calculate the opposite (X)
            let y = _bbToSaddleCentre * cos(saddleAngleRadians) // calculate the adjacent (Y)
            
            print("recalculating bbToSaddleX (\(bbToSaddleX)) and bbToSaddleY (\(bbToSaddleY)) to \(x) and \(y)")
            
            if _bbToSaddleX != x {
                _bbToSaddleX = x
            }
            
            if _bbToSaddleY != y {
                _bbToSaddleY = y
            }
        }
    }
    
    /// Computes `bbToSaddleAngle` and `bbSaddleY` from `bbToSaddleX` and `bbToSaddleCentre`
    private func computeSaddleAngleAndY() {
        
        if _bbToSaddleAngle != 0 && _bbToSaddleY != 0 && _bbToSaddleCentre != 0 {
            
            let angle = 90 - asin(_bbToSaddleX / _bbToSaddleCentre) * 180.0 / .pi
            let y = sqrt(_bbToSaddleCentre * _bbToSaddleCentre - _bbToSaddleX * _bbToSaddleX)
            
            if _bbToSaddleAngle != angle {
                _bbToSaddleAngle = angle
            }
            
            if _bbToSaddleY != y {
                _bbToSaddleY = y
            }
        }
    }
    
    /// Computes `bbToSaddleCentre` and `bbToSaddleAngle` from `bbToSaddleX` and `bbToSaddleY`
    private func computeSaddleCentreAndAngle() {
        
        if _bbToSaddleAngle != 0 && _bbToSaddleX != 0 && _bbToSaddleCentre != 0 {
            
            let angle = 90 - atan(_bbToSaddleX / _bbToSaddleY) * 180.0 / .pi
            let height = sqrt(_bbToSaddleX * _bbToSaddleX + _bbToSaddleY * _bbToSaddleY)
            
            if _bbToSaddleAngle != angle {
                _bbToSaddleAngle = angle
            }
            
            if _bbToSaddleCentre != height {
                _bbToSaddleCentre = height
            }
        }
    }
}
