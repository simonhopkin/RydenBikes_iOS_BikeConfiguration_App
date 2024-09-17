//
//  ShareSheet.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 12/09/2024.
//

import SwiftUI
import UIKit

/// View controller used to display the sharing screen
struct ShareSheet: UIViewControllerRepresentable {
    var sharedItems: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No need to implement this for our simple use case
    }
}
