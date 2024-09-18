//
//  MeasureSaddlePositionView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 13/09/2024.
//

import SwiftUI
import Motion
import CoreMotion

struct MeasureSaddlePositionView: View {
    
    @State var bikeFit: BikeFit
    @State private var showSaddleHeightEntryDialog = false
    @State private var showSaddleAngleEntryDialog = false
    
    @Binding var navigationPath: NavigationPath
    
    @EnvironmentObject var customActivitySheet: CustomActivitySheetModal
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Image("SaddlePositionGuide")
                    .resizable()
                    .scaledToFit()
                
                Button {
                    customActivitySheet.showModal {
                        SaddleHeightMeasurementView(isPresented: $customActivitySheet.isPresented,
                                                    value: $bikeFit.bbToSaddleCentre)
                    }
                } label: {
                    HStack {
                        Text(String(format: "%.0f", bikeFit.bbToSaddleCentre))
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
                .position(x: geometry.size.width * 0.65, y: geometry.size.height * 0.28)
                
                Button {
                    customActivitySheet.showModal {
                        SaddleAngleMeasurementView(isPresented: $customActivitySheet.isPresented,
                                                   value: $bikeFit.bbToSaddleAngle)
                    }
                } label: {
                    HStack {
                        Text(String(format: "%.1f", bikeFit.bbToSaddleAngle))
                            .font(.custom("Roboto-Medium", size: 18))
                            .foregroundColor(Color("PrimaryTextColor"))
                        Text("°")
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
                .position(x: geometry.size.width * 0.25, y: geometry.size.height * 0.48)
            }
        }
        .ignoresSafeArea(.keyboard)  // prevents the view from resizing when the keyboard appears
        .navigationTitle("Saddle Position")
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
    
    struct SaddleHeightMeasurementView: View {
        @Binding var isPresented: Bool
        @Binding var value: Double

        var body: some View {
            VStack {
                Spacer() // Push the bottom sheet to the bottom of the screen
                
                VStack(spacing: 20) {
                    Text("Enter the distance from the bottom bracket to the centre of the saddle in millimetres")
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
    
    
    struct SaddleAngleMeasurementView: View {
        @Binding var isPresented: Bool
        @Binding var value: Double
        @State var captureAngle: Bool = false
        let motionManager = MotionManager(motionManager: CMMotionManager())
        
        var body: some View {
            VStack {
                Spacer() // Push the bottom sheet to the bottom of the screen
                
                VStack(spacing: 20) {
                    Text("Enter the angle from the bottom bracket to the centre of the saddle")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                    
                    DecimalTextField(placeholder: "", value: $value, format: "%.1f")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(minWidth: 150, alignment: .trailing)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                        .suffix("°", minWidth: 30, color: Color.gray, font: .title)
                        .foregroundColor(Color("PrimaryTextColor"))
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.trailing, 8)
                        .overlay( // Overlay a RoundedRectangle for the border
                            RoundedRectangle(cornerRadius: 3)       // Set the corner radius
                                .stroke(Color.red, lineWidth: 4)    // Set border color and thickness
                        )
                    
                    Toggle(isOn: $captureAngle) {
                        Text("Capture angle from device")
                    }
                    .tint(Color("PrimaryTextColor"))
                    .padding(.horizontal)
                    .onChange(of: captureAngle) { oldValue, newValue in
                        if newValue {
                            //dismiss keyboard if shown
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            do {
                                try motionManager.startDeviceOrientationUpdates { roll, pitch, yaw in
                                    value = pitch
                                }
                                
                            
                            }
                            catch {
                                print("SaddleAngleMeasurementView -- ERROR: \(error)")
                                captureAngle = false
                            }
                        }
                        else {
                            motionManager.stopDeviceOrientationUpdates()
                        }
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
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .onDisappear {
                captureAngle = false
                motionManager.stopDeviceOrientationUpdates()
            }
        }
    }
}

#Preview {
    @State var navigationPath = NavigationPath()
    @StateObject var customActivitySheetModal = CustomActivitySheetModal()
    return MeasureSaddlePositionView(bikeFit: BikeFit.new(), navigationPath: $navigationPath)
        .environmentObject(customActivitySheetModal)
        .customActivitySheet(customActivitySheetModal: customActivitySheetModal, backgroundColor: Color.primary.opacity(0.2))
    
}
