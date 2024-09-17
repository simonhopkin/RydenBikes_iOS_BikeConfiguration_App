//
//  MeasurementView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 16/09/2024.
//

import SwiftUI

struct MeasurementView: View {
        
    @State var bikeFit: BikeFit
    @State var selectedPage = 0
    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack {
            TabView(selection: $selectedPage) {
                MeasureSaddlePositionView(bikeFit: bikeFit, navigationPath: $navigationPath).tag(0)
                MeasureHandPositionView(bikeFit: bikeFit, navigationPath: $navigationPath).tag(1)
                MeasureHandlebarPositionView(bikeFit: bikeFit, navigationPath: $navigationPath).tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
            
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
