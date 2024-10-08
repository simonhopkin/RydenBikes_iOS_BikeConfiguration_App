//
//  BikeFitDataStore.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import Foundation
import SwiftData
import Combine
import _SwiftData_SwiftUI

/// Repository for accessing and modifying bike fits from presistent storage
struct BikeFitRepository : BikeFitRepositoryProtocol {

    private let modelContext: ModelContext
    
    @MainActor
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchBikeFits() -> [BikeFit] {
        do {
            return try modelContext.fetch(FetchDescriptor<BikeFit>())
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addBikeFit(_ bikeFit: BikeFit) {
        modelContext.insert(bikeFit)
        do {
            try modelContext.save()
        } 
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteBikeFit(_ bikeFit: BikeFit) {
        modelContext.delete(bikeFit)
        do {
            try modelContext.save()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
}
