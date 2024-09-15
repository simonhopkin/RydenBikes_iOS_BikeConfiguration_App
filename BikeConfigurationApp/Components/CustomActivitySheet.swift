//
//  CustomActivitySheet.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 14/09/2024.
//
import SwiftUI
//
//class CustomActivitySheet: ObservableObject {
//    @Published var isPresented: Bool = false
//    @Published var activitySheetContent: AnyView = AnyView(EmptyView())
//    let animation: Animation? = .easeInOut(duration: 10)
//
////    let backgroundColor: Color
////    let animation: Animation?
//    
////    init(isPresented: Bool, content: AnyView, backgroundColor: Color, animation: Animation?) {
////        self.isPresented = isPresented
////        self.activitySheetContent = activitySheetContent
////        self.backgroundColor = backgroundColor
////        self.animation = animation
////    }
//    
////    init(isPresented: Bool, content: AnyView, activitySheetContent: AnyView, backgroundColor: Color, animation: Animation?) {
////        self.isPresented = isPresented
////        self.content = content
////        self.activitySheetContent = activitySheetContent
////        self.backgroundColor = backgroundColor
////        self.animation = animation
////    }
//    
////    init(isPresented: Bool, content: AnyView, activitySheetContent: AnyView, backgroundColor: Color, animation: Animation?) {
////        self.isPresented = isPresented
////        self.content = content
////        self.activitySheetContent = activitySheetContent
////        self.backgroundColor = backgroundColor
////        self.animation = animation
////    }
//
//    func showModal<Content: View>(@ViewBuilder content: () -> Content) {
//        self.activitySheetContent = AnyView(content())
//        withAnimation(animation) {
//            self.isPresented = true
//        }
//    }
//    
//    func hideModal() {
//        withAnimation(animation) {
//            self.isPresented = false
//        } completion: {
//            print("hidden")
//            self.activitySheetContent = AnyView(EmptyView())
//        }
//    }
//    
//    var overlay: some View {
//        
//        ZStack {
////            if isPresented {
//                // Dull background with opacity
//                Color.black.opacity(0.4)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        withAnimation {
//                            self.hideModal()
//                        }
//                    }
//                
//                // Dynamically injected modal content
////                activitySheetContent
////            }
//        }
////        content
//        .animation(nil, value: isPresented)
////        .overlay(isPresented ? backgroundColor.ignoresSafeArea() : nil)
//        .overlay(isPresented ? activitySheetContent : nil)
////        .animation(animation, value: isPresented)
//    }
//    
//}

//class CustomPopupView<Content, PopupView>: View where Content: View, PopupView: View {
//    
//    var isPresented: Bool
//    @ViewBuilder let content: () -> Content
//    @ViewBuilder let popupView: () -> PopupView
//    let backgroundColor: Color
//    let animation: Animation?
//    
//    var body: some View {
//        
//        content()
//            .animation(nil, value: isPresented)
//            .overlay(isPresented ? backgroundColor.ignoresSafeArea() : nil)
//            .overlay(isPresented ? popupView() : nil)
//            .animation(animation, value: isPresented)
//        
//    }
//}

//struct CustomPopupView<Content, PopupView>: View where Content: View, PopupView: View {
//    
//    @Binding var isPresented: Bool
//    @ViewBuilder let content: () -> Content
//    @ViewBuilder let popupView: () -> PopupView
//    let backgroundColor: Color
//    let animation: Animation?
//    
//    var body: some View {
//        
//        content()
//            .animation(nil, value: isPresented)
//            .overlay(isPresented ? backgroundColor.ignoresSafeArea() : nil)
//            .overlay(isPresented ? popupView() : nil)
//            .animation(animation, value: isPresented)
//        
//    }
//}

class CustomActivitySheet: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var activitySheetContent: AnyView = AnyView(EmptyView())
    var content: AnyView?
    var backgroundColor: Color = .black.opacity(0.7)
    var animation: Animation? = .easeInOut(duration: 30)
        
    func showModal<Content: View>(@ViewBuilder content: () -> Content) {
        self.activitySheetContent = AnyView(content())
//        withAnimation(animation) {
            self.isPresented = true
//        }
    }
    
    func hideModal() {
//        withAnimation(animation) {
            self.isPresented = false
//        } completion: {
//            print("hidden")
//            self.activitySheetContent = AnyView(EmptyView())
//        }
    }
    
    private var backgroundOverlay: some View {
        backgroundColor
            .ignoresSafeArea()
            .onTapGesture {
                print(self.isPresented)
                if self.isPresented {
                    withAnimation {
                        self.isPresented = false // Dismiss when tapping outside
                    }
                }
            }
    }
    
    var overlay: some View {
        content?
            .animation(nil, value: isPresented)
            .overlay(isPresented ? backgroundOverlay : nil)
            .overlay(isPresented ? activitySheetContent.transition(.move(edge: .bottom)) : nil)
            .animation(animation, value: isPresented)
    }
}

extension View {
    func customActivitySheet(customActivitySheet: CustomActivitySheet, 
                             backgroundColor: Color = .black.opacity(0.7),
                             animation: Animation? = .default) -> some View {
        customActivitySheet.content = AnyView(self)
        customActivitySheet.backgroundColor = backgroundColor
        customActivitySheet.animation = animation
//        customActivitySheet.isPresented = true
        return customActivitySheet.overlay
//        return CustomActivitySheet(isPresented: isPresented, content: { self }, popupView: content, backgroundColor: backgroundColor, animation: animation)
        
//        return CustomActivitySheet(isPresented: isPresented, content: { self as! AnyView }(), activitySheetContent: content(), backgroundColor: backgroundColor, animation: animation).overlay
    }
}
