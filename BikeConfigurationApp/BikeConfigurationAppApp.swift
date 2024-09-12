//
//  BikeConfigurationAppApp.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 05/09/2024.
//

import SwiftUI
import SwiftData

@main
struct BikeConfigurationAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: [
                    BikeFit.self
                ])
        }
    }
}
