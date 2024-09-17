//
//  BikeFitMigrationPlan.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 17/09/2024.
//

import SwiftData

enum BikeFitMigrationPlan: SchemaMigrationPlan {
    static var schemas : [any VersionedSchema.Type] = [BikeFitSchemaV1.self, BikeFitSchemaV2.self]
    
    static var stages: [MigrationStage] {
        [migrateV1ToV2]
    }
        
    
    static let migrateV1ToV2 = MigrationStage.custom(
        fromVersion: BikeFitSchemaV1.self,
        toVersion: BikeFitSchemaV2.self) { context in
            print("BikeFitMigrationPlan migrating from V1 to V2")
        } didMigrate: { context in
            print("BikeFitMigrationPlan didMigrate post migration activities")
            if let bikeFits = try? context.fetch(FetchDescriptor<BikeFitSchemaV2.BikeFit>()) {
                for bikeFit in bikeFits {
                    bikeFit.computeHandXAndY()
                }
                try? context.save()
            }
            print("BikeFitMigrationPlan didMigrate from V1 to V2 complete")
        }
}
