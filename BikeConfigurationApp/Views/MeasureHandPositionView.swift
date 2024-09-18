//
//  MeasureHandPositionView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 16/09/2024.
//


import SwiftUI
import Motion
import CoreMotion

struct MeasureHandPositionView: View {
    
    @State var bikeFit: BikeFit
    @State private var showHandHeightEntryDialog = false
    @State private var showHandAngleEntryDialog = false

    @Binding var navigationPath: NavigationPath
    
    @EnvironmentObject var customActivitySheet: CustomActivitySheetModal
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Image("HandPositionGuide")
                    .resizable()
                    .scaledToFit()
                
                Button {
                    customActivitySheet.showModal {
                        SaddleToHandMeasurementView(isPresented: $customActivitySheet.isPresented,
                                                    value: $bikeFit.saddleCentreToHand)
                    }
                } label: {
                    HStack {
                        Text(String(format: "%.0f", bikeFit.saddleCentreToHand))
                            .font(.custom("Roboto-Medium", size: 18))
                            .foregroundColor(Color("PrimaryTextColor"))
                        Text("mm")
                            .font(.custom("Roboto-Regular", size: 16))
                            .foregroundColor(Color.gray)
                            .padding(.bottom, 10)
                            .padding(.top, 10)
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
                .background(Color.white)
                .overlay( // Overlay a RoundedRectangle for the border
                    RoundedRectangle(cornerRadius: 3) // Set the corner radius
                        .stroke(Color.red, lineWidth: 5) // Set border color and thickness
                )
                .position(x: geometry.size.width * 0.65, y: geometry.size.height * 0.22)
                
                Button {
                    customActivitySheet.showModal {
                        SaddleToHandDropMeasurementView(isPresented: $customActivitySheet.isPresented,
                                                        value: $bikeFit.saddleToHandDrop)
                    }
                } label: {
                    HStack {
                        Text(String(format: "%.0f", bikeFit.saddleToHandDrop))
                            .font(.custom("Roboto-Medium", size: 18))
                            .foregroundColor(Color("PrimaryTextColor"))
                        Text("mm")
                            .font(.custom("Roboto-Regular", size: 16))
                            .foregroundColor(Color.gray)
                            .padding(.bottom, 10)
                            .padding(.top, 10)
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
                .overlay( // Overlay a RoundedRectangle for the border
                    RoundedRectangle(cornerRadius: 3) // Set the corner radius
                        .stroke(Color.red, lineWidth: 5) // Set border color and thickness
                )
                .background(Color.white)
                .position(x: geometry.size.width * 0.2, y: geometry.size.height * 0.3)
            }
        }
        .ignoresSafeArea(.keyboard)  // prevents the view from resizing when the keyboard appears
        .navigationTitle("Grip Position")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button(action: {
            navigationPath.removeLast()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text("Fit Details")
            }
        })
    }
    
    struct SaddleToHandMeasurementView: View {
        @Binding var isPresented: Bool
        @Binding var value: Double
        
        var body: some View {
            VStack {
                Spacer() // Push the bottom sheet to the bottom of the screen
                
                VStack(spacing: 20) {
                    Text("Enter the distance from the centre of the saddle to the grip position in millimetres")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                    
                    DecimalTextField(placeholder: "", value: $value)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(minWidth: 150, alignment: .trailing)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                        .suffix("mm", minWidth: 30, color: Color.gray, font: .title)
                        .foregroundColor(Color("PrimaryTextColor"))
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.trailing, 8)
                        .overlay( // Overlay a RoundedRectangle for the border
                            RoundedRectangle(cornerRadius: 3)       // Set the corner radius
                                .stroke(Color.red, lineWidth: 4)    // Set border color and thickness
                        )
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Done")
                            .foregroundStyle(Color.blue)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                    }
                }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                .onTapGesture {
                    isPresented = false // Dismiss the sheet
                }
            }
            .padding(8)
        }
    }
    
    
    struct SaddleToHandDropMeasurementView: View {
        @Binding var isPresented: Bool
        @Binding var value: Double
        @State private var groundToSaddleHeight: Double = 0
        @State private var groundToGripHeight: Double = 0
        
        var body: some View {
            VStack {
                Spacer() // Push the bottom sheet to the bottom of the screen
                
                VStack(spacing: 20) {
                    Text("Enter the vertical distance from the ground to the saddle and ground to the grip in millimetres")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                    
                    DecimalTextField(placeholder: "Saddle", value: $groundToSaddleHeight)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(minWidth: 200, alignment: .trailing)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                        .suffix("mm", minWidth: 30, color: Color.gray, font: .title)
                        .foregroundColor(Color("PrimaryTextColor"))
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.trailing, 8)
                        .overlay( // Overlay a RoundedRectangle for the border
                            RoundedRectangle(cornerRadius: 3)       // Set the corner radius
                                .stroke(Color.red, lineWidth: 4)    // Set border color and thickness
                        )
                        .onChange(of: groundToSaddleHeight) {
                            value = groundToSaddleHeight - groundToGripHeight
                        }
                    
                    DecimalTextField(placeholder: "Grip", value: $groundToGripHeight)
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(minWidth: 200, alignment: .trailing)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                        .suffix("mm", minWidth: 30, color: Color.gray, font: .title)
                        .foregroundColor(Color("PrimaryTextColor"))
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.trailing, 8)
                        .overlay( // Overlay a RoundedRectangle for the border
                            RoundedRectangle(cornerRadius: 3)       // Set the corner radius
                                .stroke(Color.red, lineWidth: 4)    // Set border color and thickness
                        )
                        .onChange(of: groundToGripHeight) {
                            value = groundToSaddleHeight - groundToGripHeight
                        }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .padding(.horizontal, 30)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Done")
                            .foregroundStyle(Color.blue)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                    }
                }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                .onTapGesture {
                    isPresented = false // Dismiss the sheet
                }
            }
            .padding(8)
        }
    }
    
}

#Preview {
    @State var navigationPath = NavigationPath()
    @StateObject var customActivitySheetModal = CustomActivitySheetModal()
    return MeasureHandPositionView(bikeFit: BikeFit.new(), navigationPath: $navigationPath)
        .environmentObject(customActivitySheetModal)
        .customActivitySheet(customActivitySheetModal: customActivitySheetModal, backgroundColor: Color.primary.opacity(0.2))
    
}
