//
//  DataSchema.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 17/09/2024.
//

import Foundation
import SwiftData

/// BikeFit model type aliases to point to model from the latest schema
typealias BikeFit = DataSchemaV2.BikeFit

/// Data persistance schema V1
enum DataSchemaV1: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [BikeFit.self]
    }
}

/// Data persistance schema V2
enum DataSchemaV2: VersionedSchema {
    
    static var versionIdentifier = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [BikeFit.self]
    }
}
