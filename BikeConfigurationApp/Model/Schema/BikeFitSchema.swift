//
//  BikeFitSchema.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 17/09/2024.
//

import Foundation
import SwiftData

typealias BikeFit = BikeFitSchemaV2.BikeFit

enum BikeFitSchemaV1: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [BikeFit.self]
    }
}

enum BikeFitSchemaV2: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [BikeFit.self]
    }
}
