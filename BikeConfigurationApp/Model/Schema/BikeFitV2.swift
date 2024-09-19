//
//  BikeFitV2.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 17/09/2024.
//

import SwiftData
import Foundation
import SwiftUI

/// Namespace for V2 data model changes
///
/// `BikeFit` updates to hand(grip) position properties
///
///  - `saddleCentreToHand` renamed to `_saddleCentreToHand`
///  - `saddleToHandDrop` renamed to `_saddleToHandDrop`
///  - new property `_bbToHandX`
///  - new property `_bbToHandY`
///
extension DataSchemaV2 {
    
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
        var created: Date
        var name: String
        var notes: String
        
        var imagePath: String?  // rename to imagePath imageFilename in next schema migration
        @Transient var image: Image? {
            get {
                if let imagePath = imagePath, let documentURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
                    let imageURL = documentURL.appendingPathComponent(imagePath)
                    if let uiImage = UIImage(contentsOfFile: imageURL.path) {
                        return Image(uiImage: uiImage)
                    }
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
                updateSaddleXAndYIfChanged()
                updateHandPositionsIfChanged()
            }
        }
        
        private var _bbToSaddleAngle: Double
        @Transient var bbToSaddleAngle: Double {
            get { return _bbToSaddleAngle}
            set {
                print("bbToSaddleAngle set")
                _bbToSaddleAngle = newValue
                updateSaddleXAndYIfChanged()
                updateHandPositionsIfChanged()
            }
        }
        
        private var _bbToSaddleX: Double
        @Transient var bbToSaddleX: Double {
            get { return _bbToSaddleX }
            set {
                print("bbToSaddleX set")
                _bbToSaddleX = newValue
                updateSaddleAngleAndYIfChanged()
                updateHandPositionsIfChanged()
            }
        }
        
        private var _bbToSaddleY: Double
        @Transient var bbToSaddleY: Double {
            get { return _bbToSaddleY }
            set {
                print("bbToSaddleY set")
                _bbToSaddleY = newValue
                updatgeSaddleCentreAndAngleIfChanged()
                updateHandPositionsIfChanged()
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
                updateHandXAndYIfChanged()
            }
        }
        
        @Transient var saddleToHandDrop: Double {
            get { return _saddleToHandDrop}
            set {
                print("saddleToHandDrop set")
                _saddleToHandDrop = newValue
                updateHandXAndYIfChanged()
            }
        }
        
        @Transient var bbToHandX: Double {
            get { return _bbToHandX}
            set {
                print("bbToHandX set")
                _bbToHandX = newValue
                updateHandPositionsIfChanged()
            }
        }

        @Transient var bbToHandY: Double {
            get { return _bbToHandY}
            set {
                print("bbToHandY set")
                _bbToHandY = newValue
                updateHandPositionsIfChanged()
            }
        }
        
        
        // Handlebar Position Properties
        
        private var _bbToHandlebarCentre: Double
        @Transient var bbToHandlebarCentre: Double {
            get { return _bbToHandlebarCentre}
            set {
                print("bbToHandlebarCentre set")
                _bbToHandlebarCentre = newValue
                updateHandlebarXAndYIfChanged()
            }
        }
        
        private var _bbToHandlebarAngle: Double
        @Transient var bbToHandlebarAngle: Double {
            get { return _bbToHandlebarAngle}
            set {
                print("bbToHandlebarAngle set")
                _bbToHandlebarAngle = newValue
                updateHandlebarXAndYIfChanged()
            }
        }
        
        private var _bbToHandlebarX: Double
        @Transient var bbToHandlebarX: Double {
            get { return _bbToHandlebarX }
            set {
                print("bbToHandlebarX set")
                _bbToHandlebarX = newValue
                updateHandlebarAngleAndYIfChanged()
            }
        }
        
        private var _bbToHandlebarY: Double
        @Transient var bbToHandlebarY: Double {
            get { return _bbToHandlebarY }
            set {
                print("bbToHandlebarY set")
                _bbToHandlebarY = newValue
                updateHandlebarCentreAndAngleIfChanged()
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
        
        /// computes saddle x and y and updates the stored propoerties if they are different
        func updateSaddleXAndYIfChanged() {
            if let saddleXAndY = BikeFitUtils.computeSaddleXAndY(bbToSaddleAngle: _bbToSaddleAngle, bbToSaddleCentre: _bbToSaddleCentre) {
                BikeFitUtils.updatePropertyIfChanged(&_bbToSaddleX, value: saddleXAndY.bbToSaddleX)
                BikeFitUtils.updatePropertyIfChanged(&_bbToSaddleY, value: saddleXAndY.bbToSaddleY)
            }
        }

        /// computes saddle angle and y and updates the stored propoerties if they are different
        func updateSaddleAngleAndYIfChanged() {
            if let saddleAngleAndY = BikeFitUtils.computeSaddleAngleAndY(bbToSaddleCentre: _bbToSaddleCentre, bbToSaddleX: _bbToSaddleX) {
                BikeFitUtils.updatePropertyIfChanged(&_bbToSaddleAngle, value: saddleAngleAndY.bbToSaddleAngle)
                BikeFitUtils.updatePropertyIfChanged(&_bbToSaddleY, value: saddleAngleAndY.bbToSaddleY)
            }
        }
        
        /// computes saddle centre and angle and updates the stored propoerties if they are different
        func updatgeSaddleCentreAndAngleIfChanged() {
            if let saddleCentreAndAngle = BikeFitUtils.computeSaddleCentreAndAngle(bbToSaddleX: _bbToSaddleX, bbToSaddleY: _bbToSaddleY) {
                BikeFitUtils.updatePropertyIfChanged(&_bbToSaddleAngle, value: saddleCentreAndAngle.bbToSaddleAngle)
                BikeFitUtils.updatePropertyIfChanged(&_bbToSaddleCentre, value: saddleCentreAndAngle.bbToSaddleCentre)
            }
        }

        /// computes hand x and y and updates the stored propoerties if they are different
        func updateHandXAndYIfChanged() {
            if let handXAndY = BikeFitUtils.computeHandXAndY(saddleCentreToHand: _saddleCentreToHand, saddleToHandDrop: _saddleToHandDrop, bbToSaddleX: _bbToSaddleX, bbToSaddleY: _bbToSaddleY) {
                BikeFitUtils.updatePropertyIfChanged(&_bbToHandX, value: handXAndY.bbToHandX)
                BikeFitUtils.updatePropertyIfChanged(&_bbToHandY, value: handXAndY.bbToHandY)
            }
        }
        
        /// computes hand position properties and updates the stored propoerties if they are different
        func updateHandPositionsIfChanged() {
            if let handPositions = BikeFitUtils.computeHandPositions(bbToHandX: _bbToHandX, bbToHandY: _bbToHandY, bbToSaddleX: _bbToSaddleX, bbToSaddleY: _bbToSaddleY) {
                BikeFitUtils.updatePropertyIfChanged(&_saddleCentreToHand, value: handPositions.saddleCentreToHand)
                BikeFitUtils.updatePropertyIfChanged(&_saddleToHandDrop, value: handPositions.saddleToHandDrop)
            }
        }

        /// computes handlebar x and y properties and updates the stored propoerties if they are different
        func updateHandlebarXAndYIfChanged() {
            if let handlebarXAndY = BikeFitUtils.computeHandlebarXAndY(bbToHandlebarAngle: _bbToHandlebarAngle, bbToHandlebarCentre: _bbToHandlebarCentre) {
                BikeFitUtils.updatePropertyIfChanged(&_bbToHandlebarX, value: handlebarXAndY.bbToHandlebarX)
                BikeFitUtils.updatePropertyIfChanged(&_bbToHandlebarY, value: handlebarXAndY.bbToHandlebarY)
            }
        }

        func updateHandlebarAngleAndYIfChanged() {
            if let handlebarAngleAndY = BikeFitUtils.computeHandlebarAngleAndY(bbToHandlebarCentre: _bbToHandlebarCentre, bbToHandlebarX: _bbToHandlebarX) {
                BikeFitUtils.updatePropertyIfChanged(&_bbToHandlebarAngle, value: handlebarAngleAndY.bbToHandlebarAngle)
                BikeFitUtils.updatePropertyIfChanged(&_bbToHandlebarY, value: handlebarAngleAndY.bbToHandlebarY)
            }
        }
        
        /// computes handlebar centre and angle properties and updates the stored propoerties if they are different
        func updateHandlebarCentreAndAngleIfChanged() {
            if let handlebarCentreAndAngle = BikeFitUtils.computeHandlebarCentreAndAngle(bbToHandlebarX: _bbToHandlebarX, bbToHandlebarY: _bbToHandlebarY) {
                BikeFitUtils.updatePropertyIfChanged(&_bbToHandlebarAngle, value: handlebarCentreAndAngle.bbToHandlebarAngle)
                BikeFitUtils.updatePropertyIfChanged(&_bbToHandlebarCentre, value: handlebarCentreAndAngle.bbToHandlebarCentre)
            }
        }
    }
}
