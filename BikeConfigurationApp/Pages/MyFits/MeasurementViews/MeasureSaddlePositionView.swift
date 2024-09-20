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
    @Binding var showGuidanceSheet: Bool

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
                                                    targetValue: $bikeFit.bbToSaddleCentre, measurementApplied:  {
                            // apply adjustment to saddle x to account for use of measurement tool
                            bikeFit.applyBBToSaddleXAdjustment(adjustment: 3)
                        })
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
                .background(Color(.secondarySystemBackground))
                .overlay( // Overlay a RoundedRectangle for the border
                    RoundedRectangle(cornerRadius: 3) // Set the corner radius
                        .stroke(Color.red, lineWidth: 5) // Set border color and thickness
                )
                .position(x: geometry.size.width * 0.65, y: geometry.size.height * 0.28)
                
                Button {
                    customActivitySheet.showModal {
                        SaddleAngleMeasurementView(isPresented: $customActivitySheet.isPresented,
                                                   targetValue: $bikeFit.bbToSaddleAngle, measurementApplied:   {
                            // apply adjustment to saddle x to account for use of measurement tool
                            bikeFit.applyBBToSaddleXAdjustment(adjustment: 3)
                        })
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
                .background(Color(.secondarySystemBackground))
                .position(x: geometry.size.width * 0.25, y: geometry.size.height * 0.48)
                
                
                // Display setback x on the measurement view
                
                HStack {
                    Text("Setback")
                        .font(.custom("Roboto-Regular", size: 16))
                        .foregroundColor(Color.gray)
                    Text(String(format: "%.0f", bikeFit.bbToSaddleX))
                        .font(.custom("Roboto-Medium", size: 18))
                        .foregroundColor(Color.primary)
                    Text("mm")
                        .font(.custom("Roboto-Regular", size: 16))
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 10)
                        .padding(.top, 10)
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .overlay( // Overlay a RoundedRectangle for the border
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.primary, lineWidth: 5)
                )
                .background(Color(.secondarySystemBackground))
                .position(x: geometry.size.width * 0.4, y: geometry.size.height * 0.1)
            }
        }
        .ignoresSafeArea(.keyboard)  // prevents the view from resizing when the keyboard appears
        .navigationTitle("Saddle Position")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            leading: Button(action: {
                navigationPath.removeLast()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Fit Details")
                }
            }, trailing: Button(action: {
                showGuidanceSheet = true
            }) {
                Image(systemName: "questionmark.circle")
            })
        .sheet(isPresented: $showGuidanceSheet) {
            GuidanceSaddlePositionView(showGuidanceSheet: $showGuidanceSheet)
        }
        .onAppear {
            
        }
    }
    
    struct SaddleHeightMeasurementView: View {
        @Binding var isPresented: Bool
        @Binding var targetValue: Double
        
        @State private var value: Double = 0

        /// called before the measurement update has been applied to the target value so that any adjustments can be made to it before
        /// it is applied to the bike fit
        var appliedAdjustment: ((_ value: Double) -> Double)?
        
        /// called after the measurement update has been applied to the target value so that any further adjustments can be made
        var measurementApplied: (() -> Void)?
        
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
                .background(Color(.secondarySystemBackground))
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
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .shadow(radius: 10)
                .onTapGesture {
                    targetValue = appliedAdjustment?(value) ?? value
                    measurementApplied?()
                    isPresented = false // Dismiss the sheet
                }
            }
            .padding(8)
            .onAppear {
                value = targetValue
            }
        }
    }
    
    
    struct SaddleAngleMeasurementView: View {
        @Binding var isPresented: Bool
        @Binding var targetValue: Double

        @State private var value: Double = 0
        @State var captureAngle: Bool = false
        
        let motionManager = MotionManager(motionManager: CMMotionManager())
        
        /// called before the measurement update has been applied to the target value so that any adjustments can be made to it before
        /// it is applied to the bike fit
        var appliedAdjustment: ((_ value: Double) -> Double)?
        
        /// called after the measurement update has been applied to the target value so that any further adjustments can be made
        var measurementApplied: (() -> Void)?
        
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
                .background(Color(.secondarySystemBackground))
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
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .shadow(radius: 10)
                .onTapGesture {
                    targetValue = appliedAdjustment?(value) ?? value
                    measurementApplied?()
                    isPresented = false // Dismiss the sheet
                }
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .onAppear {
                value = targetValue
            }
            .onDisappear {
                captureAngle = false
                motionManager.stopDeviceOrientationUpdates()
            }
        }
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    @Previewable @State var showGuidanceSheet = false
    @Previewable @StateObject var customActivitySheetModal = CustomActivitySheetModal()
    return MeasureSaddlePositionView(bikeFit: BikeFit.new(), navigationPath: $navigationPath, showGuidanceSheet: $showGuidanceSheet)
        .environmentObject(customActivitySheetModal)
        .customActivitySheet(customActivitySheetModal: customActivitySheetModal, backgroundColor: Color.primary.opacity(0.2))
    
}
