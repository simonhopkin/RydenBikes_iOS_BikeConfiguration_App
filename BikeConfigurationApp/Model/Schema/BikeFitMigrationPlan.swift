//
//  BikeFitMigrationPlan.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 17/09/2024.
//

import SwiftData

/// Schema migration plan executes whenever there is a schema change and the presistent data needs migrating on updating the app
enum BikeFitMigrationPlan: SchemaMigrationPlan {
    static var schemas : [any VersionedSchema.Type] = [DataSchemaV1.self, DataSchemaV2.self]
    
    static var stages: [MigrationStage] {
        [migrateV1ToV2]
    }
        
    static let migrateV1ToV2 = MigrationStage.custom(
        fromVersion: DataSchemaV1.self,
        toVersion: DataSchemaV2.self) { context in
            print("BikeFitMigrationPlan migrating from V1 to V2")
        } didMigrate: { context in
            print("BikeFitMigrationPlan didMigrate post migration activities")
            if let bikeFits = try? context.fetch(FetchDescriptor<DataSchemaV2.BikeFit>()) {
                for bikeFit in bikeFits {
                    bikeFit.computeHandXAndY()
                }
                try? context.save()
            }
            print("BikeFitMigrationPlan didMigrate from V1 to V2 complete")
        }
}
