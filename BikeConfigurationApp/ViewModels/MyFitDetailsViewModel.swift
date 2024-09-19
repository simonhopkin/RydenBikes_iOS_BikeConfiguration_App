//
//  MyFitDetailsViewModel.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import Foundation
import _PhotosUI_SwiftUI
import SwiftUI
import SwiftData

/// View model for managing changes to the bike fit for the details page.
class MyFitDetailsViewModel: ObservableObject {
    
    var bikeFit: BikeFit
    
    private let bikeFitRepository: BikeFitRepositoryProtocol
    
    var bikeImage: Image?

    var imageSelection: PhotosPickerItem? {
        didSet {
            Task {
                if let loaded = try? await imageSelection?.loadTransferable(type: Image.self) {
                    bikeImage = loaded
                } else {
                    print("Failed")
                }
            }
        }
    }
    
    init(bikeFitRepository: BikeFitRepositoryProtocol, bikeFit: BikeFit) {
        self.bikeFitRepository = bikeFitRepository
        self.bikeFit = bikeFit
    }
    
    func saveBikeFit() {
        bikeFitRepository.addBikeFit(bikeFit)
    }
    
    func saveImageDataToDocuments(imageData: Data) {
        let filename = bikeFit.id.uuidString + ".jpg"
        
        do {
            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(filename)
            try imageData.write(to: fileURL)
            bikeFit.imagePath = filename
        }
        catch {
            print("Error saving image: \(error)")
        }
    }
}
