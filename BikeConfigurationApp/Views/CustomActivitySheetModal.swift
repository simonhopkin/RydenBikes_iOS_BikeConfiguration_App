//
//  CustomActivitySheetModal.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 14/09/2024.
//
import SwiftUI

/// Custom activity sheet style view to display any type of content rather than just buttons
class CustomActivitySheetModal: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var activitySheetContent: AnyView = AnyView(EmptyView())
    var content: AnyView?
    var backgroundColor: Color = .black.opacity(0.7)
    var animation: Animation? = .easeInOut(duration: 1)
    
    func showModal(@ViewBuilder content: () -> any View) {
        if !isPresented {
            self.activitySheetContent = AnyView(content())
            self.isPresented = true
        }
    }
    
    func hideModal() {
        if isPresented {
            self.isPresented = false
        }
    }
    
    private var backgroundOverlay: some View {
        backgroundColor
            .ignoresSafeArea()
            .onTapGesture {
                print(self.isPresented)
                if self.isPresented {
                    self.isPresented = false // Dismiss when tapping outside
                }
            }
    }
    
    var overlay: some View {
        content?
            .overlay(isPresented ? backgroundOverlay : nil)
            .overlay(isPresented ? activitySheetContent.transition(.move(edge: .bottom)) : nil)
            .animation(animation, value: isPresented)
    }
}

extension View {
    func customActivitySheet(customActivitySheetModal: CustomActivitySheetModal,
                             backgroundColor: Color = .black.opacity(0.7),
                             animation: Animation? = .easeInOut(duration: 0.25)) -> some View {
        customActivitySheetModal.content = AnyView(self)
        customActivitySheetModal.backgroundColor = backgroundColor
        customActivitySheetModal.animation = animation
        return customActivitySheetModal.overlay
    }
}
