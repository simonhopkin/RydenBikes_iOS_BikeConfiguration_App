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

//@Observable
class MyFitDetailsViewModel: ObservableObject {
    
    var bikeFit: BikeFit {
        didSet {
            print("bikeFit didSet \(bikeFit)")
        }
    }
    
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
}
