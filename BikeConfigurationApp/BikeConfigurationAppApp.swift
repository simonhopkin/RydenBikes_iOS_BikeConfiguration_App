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
                .onOpenURL(perform: { url in
                    handleIncomingURL(url)
                })
        }
    }
    
    private func handleIncomingURL(_ url: URL) {
        // Parse the URL and perform navigation based on its content
        print("Received URL: \(url.absoluteString)")
        print("Received URL path components: \(url.pathComponents)")
        
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            print("components path: \(components.path)")
            print("components query: \(components.queryItems)")
        }

        
        
//        // Example: Handling a link to an article
//        if url.pathComponents.contains("bikeFit") {
//            if let articleId = url.lastPathComponent {
//                appRouter.navigateToArticle(withId: articleId)
//            }
//        }
    }
}
