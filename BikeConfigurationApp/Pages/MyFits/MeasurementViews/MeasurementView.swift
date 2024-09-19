//
//  MeasurementView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 16/09/2024.
//

import SwiftUI

/// TabView to display the 3 bike measurement views
struct MeasurementView: View {
        
    @State var bikeFit: BikeFit
    @State var selectedPage = 0
    @Binding var navigationPath: NavigationPath
    @State var showSaddleGuidance: Bool = false
    @State var showHandGuidance: Bool = false
    @State var showHandlebarGuidance: Bool = false

    var body: some View {
        VStack {
            TabView(selection: $selectedPage) {
                MeasureSaddlePositionView(bikeFit: bikeFit, navigationPath: $navigationPath, showGuidanceSheet: $showSaddleGuidance).tag(0)
                MeasureHandPositionView(bikeFit: bikeFit, navigationPath: $navigationPath, showGuidanceSheet: $showHandGuidance).tag(1)
                MeasureHandlebarPositionView(bikeFit: bikeFit, navigationPath: $navigationPath, showGuidanceSheet: $showHandlebarGuidance).tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .onChange(of: selectedPage) {
                print(selectedPage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    setGuidanceVisibilityForSelectedPage(selectedPage)
                }
            }
            
            HStack(spacing: 10) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(index == selectedPage ? Color("PrimaryTextColor") : Color.gray)
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.top, 10)
        }
        .ignoresSafeArea(.keyboard)  // prevents the view from resizing when the keyboard appears
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                setGuidanceVisibilityForSelectedPage(selectedPage)
            }
        }
    }
    
    private func setGuidanceVisibilityForSelectedPage(_ selectedPage: Int) {
        switch selectedPage {
        case 0:
            showSaddleGuidance = !getAndSetDefaultsBool(forKey: "hasSeenSaddleGuidance6", newValue: true)
        case 1:
            showHandGuidance = !getAndSetDefaultsBool(forKey: "hasSeenHandGuidance6", newValue: true)
        case 2:
            showHandlebarGuidance = !getAndSetDefaultsBool(forKey: "hasSeenHandlebarGuidance6", newValue: true)
        default:
            break
        }
    }
    
    private func getAndSetDefaultsBool(forKey key: String, newValue: Bool) -> Bool {
        let dafaults = UserDefaults.standard
        let currentValue = dafaults.bool(forKey: key)
        dafaults.setValue(newValue, forKey: key)
        return currentValue
    }
}

#Preview {
    @State var navigationPath = NavigationPath()
    @StateObject var customActivitySheetModal = CustomActivitySheetModal()
    let bikeFit = BikeFit.new()
    return MeasurementView(bikeFit: bikeFit, navigationPath: $navigationPath)
        .environmentObject(customActivitySheetModal)
        .customActivitySheet(customActivitySheetModal: customActivitySheetModal, backgroundColor: Color.primary.opacity(0.2))
}
