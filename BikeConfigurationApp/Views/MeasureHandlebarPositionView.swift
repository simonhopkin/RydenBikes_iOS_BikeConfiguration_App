//
//  MeasureHandlebarPositionView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 16/09/2024.
//

import SwiftUI
import Motion
import CoreMotion

struct MeasureHandlebarPositionView: View {
    
    @State var bikeFit: BikeFit
    @State private var showHandlebarHeightEntryDialog = false
    @State private var showHandlebarAngleEntryDialog = false
    
    @Binding var navigationPath: NavigationPath
    
    @EnvironmentObject var customActivitySheet: CustomActivitySheetModal
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Image("HandlebarPositionGuide")
                    .resizable()
                    .scaledToFit()
                
                Button {
                    customActivitySheet.showModal {
                        HandlebarHeightMeasurementView(isPresented: $customActivitySheet.isPresented,
                                                    value: $bikeFit.bbToHandlebarCentre)
                    }
                } label: {
                    HStack {
                        if bikeFit.bbToHandlebarCentre != 0 {
                            Text(String(format: "%.0f", bikeFit.bbToHandlebarCentre))
                                .font(.custom("Roboto-Regular", size: 16))
                                .foregroundColor(Color("PrimaryTextColor"))
                            Text("mm")
                                .font(.custom("Roboto-Regular", size: 14))
                                .foregroundColor(Color.gray)
                                .padding(.bottom, 10)
                                .padding(.top, 10)
                        }
                        else {
                            Text("Enter Handlebar Height")
                                .font(.custom("Roboto-Regular", size: 16))
                                .foregroundColor(Color.gray)
                                .padding(.bottom, 10)
                                .padding(.top, 10)
                        }
                        
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
                .background(Color.white)
                .overlay( // Overlay a RoundedRectangle for the border
                    RoundedRectangle(cornerRadius: 3) // Set the corner radius
                        .stroke(Color.red, lineWidth: 4) // Set border color and thickness
                )
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.30)
                
                Button {
                    customActivitySheet.showModal {
                        HandlebarAngleMeasurementView(isPresented: $customActivitySheet.isPresented,
                                                   value: $bikeFit.bbToHandlebarAngle)
                    }
                } label: {
                    HStack {
                        if bikeFit.bbToHandlebarAngle != 0 {
                            Text(String(format: "%.0f", bikeFit.bbToHandlebarAngle))
                                .font(.custom("Roboto-Regular", size: 16))
                                .foregroundColor(Color("PrimaryTextColor"))
                            Text("°")
                                .font(.custom("Roboto-Regular", size: 14))
                                .foregroundColor(Color.gray)
                                .padding(.bottom, 10)
                                .padding(.top, 10)
                        }
                        else {
                            Text("Enter Handlebar Angle")
                                .font(.custom("Roboto-Regular", size: 16))
                                .foregroundColor(Color.gray)
                                .padding(.bottom, 10)
                                .padding(.top, 10)
                        }
                        
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
                .overlay( // Overlay a RoundedRectangle for the border
                    RoundedRectangle(cornerRadius: 3) // Set the corner radius
                        .stroke(Color.red, lineWidth: 4) // Set border color and thickness
                )
                .background(Color.white)
                .position(x: geometry.size.width * 0.7, y: geometry.size.height * 0.55)
            }
        }
        .ignoresSafeArea(.keyboard)  // prevents the view from resizing when the keyboard appears
        .navigationTitle("Handlebar Position")
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
    
    struct HandlebarHeightMeasurementView: View {
        @Binding var isPresented: Bool
        @Binding var value: Double

        var body: some View {
            VStack {
                Spacer() // Push the bottom sheet to the bottom of the screen
                
                VStack(spacing: 20) {
                    Text("Enter the distance from the bottom bracket to the centre of the handlebars in millimetres")
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
                        Button("Done") {
                            isPresented = false // Dismiss the sheet
                        }
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                    }
                }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
            }
            .padding(8)
        }
    }
    
    
    struct HandlebarAngleMeasurementView: View {
        @Binding var isPresented: Bool
        @Binding var value: Double
        @State var captureAngle: Bool = false
        let motionManager = MotionManager(motionManager: CMMotionManager())
        
        var body: some View {
            VStack {
                Spacer() // Push the bottom sheet to the bottom of the screen
                
                VStack(spacing: 20) {
                    Text("Enter the angle from the bottom bracket to the centre of the handlebars")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                    
                    DecimalTextField(placeholder: "", value: $value)
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
                                try motionManager.startDeviceOrientationUpdates { pitch, roll, yaw in
                                    value = roll
                                }
                            }
                            catch {
                                print("HandlebarAngleMeasurementView -- ERROR: \(error)")
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
                        Button("Done") {
                            isPresented = false // Dismiss the sheet
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                    }
                }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
        }
    }
}

#Preview {
    @State var navigationPath = NavigationPath()
    @StateObject var customActivitySheetModal = CustomActivitySheetModal()
    return MeasureHandlebarPositionView(bikeFit: BikeFit.new(), navigationPath: $navigationPath)
        .environmentObject(customActivitySheetModal)
        .customActivitySheet(customActivitySheetModal: customActivitySheetModal, backgroundColor: Color.primary.opacity(0.2))
    
}
