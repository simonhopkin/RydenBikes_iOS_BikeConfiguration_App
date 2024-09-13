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
    
    @State private var navigationPath = NavigationPath()

    let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: BikeFit.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(navigationPath: $navigationPath)
                .modelContainer(modelContainer) // inject the model container
                .onOpenURL(perform: { url in    // handle incoming urls
                    handleIncomingURL(url)
                })
        }
    }
    
    @MainActor private func handleIncomingURL(_ url: URL) {
        // Parse the URL and perform navigation based on its content
        print("Received URL: \(url.absoluteString)")
        print("Received URL path components: \(url.pathComponents)")
        
        if url.pathComponents.contains("bikeFit") {
            if let bikeFit = BikeFit.bikeFitFromUrl(url) {
                print("bikeFit: \(bikeFit)")
                BikeFitRepository(modelContext: modelContainer.mainContext).addBikeFit(bikeFit)
            }
        }
    }
}
