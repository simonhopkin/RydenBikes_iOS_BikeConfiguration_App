//
//  BikeFitV2.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 17/09/2024.
//

import SwiftData
import Foundation
import SwiftUI

/// `BikeFit` is a SwiftData model object used to persist bike fit measurements.
///
/// This class has computed properties which adjust when other properties update.
///
/// Unfortunately property observers didSet/willSet do not work with classes annotated with the
/// SwiftData @Model macro.  So instead a public computed property is used backed by a persisted
/// private property.

/// `BikeFit` namespaced to `DataSchemaV2`
extension DataSchemaV2 {
    
    @Model
    class BikeFit : Identifiable {
        let id: UUID
        let created: Date
        var name: String
        var notes: String
        
        var imagePath: String?
        @Transient var image: Image? {
            get {
                print("imagePath \(String(describing: imagePath))")
                
                guard let imagePath = imagePath else {
                    return nil
                }
                if let uiImage = UIImage(contentsOfFile: imagePath) {
                    return Image(uiImage: uiImage)
                }
                return nil
            }
        }
        
        // Saddle Position Properties
        
        private var _bbToSaddleCentre: Double
        @Transient var bbToSaddleCentre: Double {
            get { return _bbToSaddleCentre}
            set {
                print("bbToSaddleCentre set")
                _bbToSaddleCentre = newValue
                computeSaddleXAndY()
                computeHandPositions()
            }
        }
        
        private var _bbToSaddleAngle: Double
        @Transient var bbToSaddleAngle: Double {
            get { return _bbToSaddleAngle}
            set {
                print("bbToSaddleAngle set")
                _bbToSaddleAngle = newValue
                computeSaddleXAndY()
                computeHandPositions()
            }
        }
        
        private var _bbToSaddleX: Double
        @Transient var bbToSaddleX: Double {
            get { return _bbToSaddleX }
            set {
                print("bbToSaddleX set")
                _bbToSaddleX = newValue
                computeSaddleAngleAndY()
                computeHandPositions()
            }
        }
        
        private var _bbToSaddleY: Double
        @Transient var bbToSaddleY: Double {
            get { return _bbToSaddleY }
            set {
                print("bbToSaddleY set")
                _bbToSaddleY = newValue
                computeSaddleCentreAndAngle()
                computeHandPositions()
            }
        }
        
        // Hand Position Properties
        
        @Attribute(originalName: "saddleCentreToHand") private var _saddleCentreToHand: Double      // rename property
        @Attribute(originalName: "saddleToHandDrop") private var _saddleToHandDrop: Double          // rename property
        private var _bbToHandX: Double = 0                                                          // new property
        private var _bbToHandY: Double = 0                                                          // new property
        
        @Transient var saddleCentreToHand: Double {
            get { return _saddleCentreToHand}
            set {
                print("saddleCentreToHand set")
                _saddleCentreToHand = newValue
                computeHandXAndY()
            }
        }
        
        @Transient var saddleToHandDrop: Double {
            get { return _saddleToHandDrop}
            set {
                print("saddleToHandDrop set")
                _saddleToHandDrop = newValue
                computeHandXAndY()
            }
        }
        
        @Transient var bbToHandX: Double {
            get { return _bbToHandX}
            set {
                print("bbToHandX set")
                _bbToHandX = newValue
                computeHandPositions()
            }
        }

        @Transient var bbToHandY: Double {
            get { return _bbToHandY}
            set {
                print("bbToHandY set")
                _bbToHandY = newValue
                computeHandPositions()
            }
        }
        
        
        // Handlebar Position Properties
        
        private var _bbToHandlebarCentre: Double
        @Transient var bbToHandlebarCentre: Double {
            get { return _bbToHandlebarCentre}
            set {
                print("bbToHandlebarCentre set")
                _bbToHandlebarCentre = newValue
                computeHandlebarXAndY()
            }
        }
        
        private var _bbToHandlebarAngle: Double
        @Transient var bbToHandlebarAngle: Double {
            get { return _bbToHandlebarAngle}
            set {
                print("bbToHandlebarAngle set")
                _bbToHandlebarAngle = newValue
                computeHandlebarXAndY()
            }
        }
        
        private var _bbToHandlebarX: Double
        @Transient var bbToHandlebarX: Double {
            get { return _bbToHandlebarX }
            set {
                print("bbToHandlebarX set")
                _bbToHandlebarX = newValue
                computeHandlebarAngleAndY()
            }
        }
        
        private var _bbToHandlebarY: Double
        @Transient var bbToHandlebarY: Double {
            get { return _bbToHandlebarY }
            set {
                print("bbToHandlebarY set")
                _bbToHandlebarY = newValue
                computeHandlebarCentreAndAngle()
            }
        }
        
        init(id: UUID, created: Date, name: String, notes: String, bbToSaddleCentre: Double, bbToSaddleAngle: Double, 
             bbToSaddleX: Double, bbToSaddleY: Double, saddleCentreToHand: Double, saddleToHandDrop: Double, bbToHandX: Double,
             bbToHandY: Double, bbToHandlebarCentre: Double, bbToHandlebarAngle: Double, bbToHandlebarX: Double, bbToHandlebarY: Double) {
            self.id = id
            self.created = created
            self.name = name
            self.notes = notes
            self._bbToSaddleCentre = bbToSaddleCentre
            self._bbToSaddleAngle = bbToSaddleAngle
            self._bbToSaddleX = bbToSaddleX
            self._bbToSaddleY = bbToSaddleY
            self._saddleCentreToHand = saddleCentreToHand
            self._saddleToHandDrop = saddleToHandDrop
            self._bbToHandX = bbToHandX
            self._bbToHandY = bbToHandX
            self._bbToHandlebarCentre = bbToHandlebarCentre
            self._bbToHandlebarAngle = bbToHandlebarAngle
            self._bbToHandlebarX = bbToHandlebarX
            self._bbToHandlebarY = bbToHandlebarY
        }
        
        convenience init(created: Date, name: String, notes: String, bbToSaddleCentre: Double, bbToSaddleAngle: Double, 
                         bbToSaddleX: Double, bbToSaddleY: Double, saddleCentreToHand: Double, saddleToHandDrop: Double,
                         bbToHandX: Double, bbToHandY: Double, bbToHandlebarCentre: Double, bbToHandlebarAngle: Double,
                         bbToHandlebarX: Double, bbToHandlebarY: Double) {
            self.init(id: UUID(),
                      created: created,
                      name: name,
                      notes: notes,
                      bbToSaddleCentre:
                        bbToSaddleCentre,
                      bbToSaddleAngle: bbToSaddleAngle,
                      bbToSaddleX: bbToSaddleX,
                      bbToSaddleY: bbToSaddleY,
                      saddleCentreToHand: saddleCentreToHand,
                      saddleToHandDrop: saddleToHandDrop,
                      bbToHandX: bbToHandX,
                      bbToHandY: bbToHandY,
                      bbToHandlebarCentre: bbToHandlebarCentre,
                      bbToHandlebarAngle: bbToHandlebarAngle,
                      bbToHandlebarX: bbToHandlebarX,
                      bbToHandlebarY: bbToHandlebarY)
        }
        
        convenience init(name: String, notes: String, bbToSaddleCentre: Double, bbToSaddleAngle: Double, bbToSaddleX: Double, 
                         bbToSaddleY: Double, saddleCentreToHand: Double, saddleToHandDrop: Double, bbToHandX: Double,
                         bbToHandY: Double, bbToHandlebarCentre: Double, bbToHandlebarAngle: Double, bbToHandlebarX: Double,
                         bbToHandlebarY: Double) {
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
                      bbToHandX: bbToHandX,
                      bbToHandY: bbToHandY,
                      bbToHandlebarCentre: bbToHandlebarCentre,
                      bbToHandlebarAngle: bbToHandlebarAngle,
                      bbToHandlebarX: bbToHandlebarX,
                      bbToHandlebarY: bbToHandlebarY)
        }
        
        
        /// Computes `bbToSaddleX` and `bbToSaddleY` from `bbToSaddleCentre` and `bbToSaddleAngle`
        func computeSaddleXAndY() {
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
        func computeSaddleAngleAndY() {
            
            if _bbToSaddleAngle != 0 && _bbToSaddleY != 0 && _bbToSaddleCentre != 0 {
                
                let angle = acos(_bbToSaddleX / _bbToSaddleCentre) * 180.0 / .pi
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
        func computeSaddleCentreAndAngle() {
            
            if _bbToSaddleAngle != 0 && _bbToSaddleX != 0 && _bbToSaddleCentre != 0 {
                
                let angle = atan(_bbToSaddleY / _bbToSaddleX) * 180.0 / .pi
                let height = sqrt(_bbToSaddleX * _bbToSaddleX + _bbToSaddleY * _bbToSaddleY)
                
                if _bbToSaddleAngle != angle {
                    _bbToSaddleAngle = angle
                }
                
                if _bbToSaddleCentre != height {
                    _bbToSaddleCentre = height
                }
            }
        }
        
        /// Computes `bbToHandX` and `bbToHandY` from `saddleCentreToHand`, `saddleToHandDrop`, `bbToSaddleX`, and`bbToSaddleY`
        func computeHandXAndY() {
            if _saddleCentreToHand != 0 && _saddleToHandDrop != 0 && _bbToSaddleX != 0 && _bbToSaddleY != 0 {
                
                let x = sqrt((_saddleCentreToHand * _saddleCentreToHand) - (_saddleToHandDrop * _saddleToHandDrop)) - _bbToSaddleX
                let y = _bbToSaddleY - _saddleToHandDrop
                
                if _bbToHandX != x {
                    _bbToHandX = x
                }
                
                if _bbToHandY != y {
                    _bbToHandY = y
                }
            }
        }
        
        func computeHandPositions() {
            if _bbToHandX != 0 && _bbToHandY != 0 && _bbToSaddleX != 0 && _bbToSaddleY != 0 {
                
                let y = _bbToSaddleY - _bbToHandY
                let x = sqrt((y * y) + ((_bbToHandX + _bbToSaddleX) * (_bbToHandX + _bbToSaddleX)))

                if _saddleCentreToHand != x {
                    _saddleCentreToHand = x
                }
                
                if _saddleToHandDrop != y {
                    _saddleToHandDrop = y
                }
            }
        }
        
        /// Computes `bbToHandlebarX` and `bbToHandlebarY` from `bbToHandlebarCentre` and `bbToHandlebarAngle`
        func computeHandlebarXAndY() {
            if _bbToHandlebarAngle != 0 && _bbToHandlebarCentre != 0 {
                
                let handlebarAngleRadians = (90 - _bbToHandlebarAngle) * .pi / 180.0
                
                let x = _bbToHandlebarCentre * sin(handlebarAngleRadians) // calculate the opposite (X)
                let y = _bbToHandlebarCentre * cos(handlebarAngleRadians) // calculate the adjacent (Y)
                
                print("recalculating bbToHandlebarX (\(bbToHandlebarX)) and bbToHandlebarY (\(bbToHandlebarY)) to \(x) and \(y)")
                
                if _bbToHandlebarX != x {
                    _bbToHandlebarX = x
                }
                
                if _bbToHandlebarY != y {
                    _bbToHandlebarY = y
                }
            }
        }
        
        /// Computes `bbToHandlebarAngle` and `bbToHandlebarY` from `bbToHandlebarX` and `bbToHandlebarCentre`
        func computeHandlebarAngleAndY() {
            
            if _bbToHandlebarAngle != 0 && _bbToHandlebarY != 0 && _bbToHandlebarCentre != 0 {
                
                let angle = 90 - asin(_bbToHandlebarX / _bbToHandlebarCentre) * 180.0 / .pi
                let y = sqrt(_bbToHandlebarCentre * _bbToHandlebarCentre - _bbToHandlebarX * _bbToHandlebarX)
                
                if _bbToHandlebarAngle != angle {
                    _bbToHandlebarAngle = angle
                }
                
                if _bbToHandlebarY != y {
                    _bbToHandlebarY = y
                }
            }
        }
        
        /// Computes `bbToHandlebarCentre` and `bbToHandlebarAngle` from `bbToHandlebarX` and `bbToHandlebarY`
        func computeHandlebarCentreAndAngle() {
            
            if _bbToHandlebarAngle != 0 && _bbToHandlebarX != 0 && _bbToHandlebarCentre != 0 {
                
                let angle = 90 - atan(_bbToHandlebarX / _bbToHandlebarY) * 180.0 / .pi
                let height = sqrt(_bbToHandlebarX * _bbToHandlebarX + _bbToHandlebarY * _bbToHandlebarY)
                
                if _bbToHandlebarAngle != angle {
                    _bbToHandlebarAngle = angle
                }
                
                if _bbToHandlebarCentre != height {
                    _bbToHandlebarCentre = height
                }
            }
        }
    }
}
