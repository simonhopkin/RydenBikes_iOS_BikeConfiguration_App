//
//  MeasureSaddlePositionView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 13/09/2024.
//

import SwiftUI

struct MeasureSaddlePositionView: View {
    
    @State var bikeFit: BikeFit
    @Binding var navigationPath: NavigationPath
    
    @State private var showSaddleHeightEntryDialog = false
    @State private var showSaddleAngleEntryDialog = false
    
    var body: some View {
        HStack {
            //            ScrollView {
            GeometryReader { geometry in
                
                ZStack {
                    
                    Image("SaddlePositionGuide")
                        .resizable()
                        .scaledToFit()
                    //                        .background(Color.blue)
                    
                    Button {
                        withAnimation {
                            showSaddleHeightEntryDialog.toggle()
                        }
                    } label: {
                        HStack {
                            if bikeFit.bbToSaddleCentre != 0 {
                                Text(String(format: "%.1f", bikeFit.bbToSaddleCentre))
                                    .font(.custom("Roboto-Regular", size: 16))
                                    .foregroundColor(Color("PrimaryTextColor"))
                                Text("mm")
                                    .font(.custom("Roboto-Regular", size: 14))
                                    .foregroundColor(Color.gray)
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                            }
                            else {
                                Text("Enter Saddle Height")
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
                    .position(x: geometry.size.width * 0.7, y: geometry.size.height * 0.18)
                    
                    //
                    //                    DecimalTextField(placeholder: "Saddle Height", value: $bikeFit.bbToSaddleCentre)
                    //                        .font(.custom("Roboto-Regular", size: 16))
                    //                        .frame(minWidth: 75, alignment: .trailing)
                    //                        .foregroundColor(Color("PrimaryTextColor"))
                    //                        .padding(.leading, 10)
                    //                        .padding(.top, 10)
                    //                        .padding(.bottom, 10)
                    //                        .suffix("mm", minWidth: 30, color: Color.gray, font: .custom("Roboto-Regular", size: 14), padding: 10)
                    //                        .background(Color.white)
                    //
                    //                        .overlay( // Overlay a RoundedRectangle for the border
                    //                            RoundedRectangle(cornerRadius: 3) // Set the corner radius
                    //                                .stroke(Color.red, lineWidth: 4) // Set border color and thickness
                    //                        )
                    //                        .padding()
                    //                        .fixedSize(horizontal: true, vertical: false)
                    //                        .position(x: 260, y: 220)
                    
                    
                    Button {
                        showSaddleAngleEntryDialog = true
                    } label: {
                        HStack {
                            if bikeFit.bbToSaddleAngle != 0 {
                                Text(String(format: "%.1f", bikeFit.bbToSaddleAngle))
                                    .font(.custom("Roboto-Regular", size: 16))
                                    .foregroundColor(Color("PrimaryTextColor"))
                                Text("mm")
                                    .font(.custom("Roboto-Regular", size: 14))
                                    .foregroundColor(Color.gray)
                                    .padding(.bottom, 10)
                                    .padding(.top, 10)
                            }
                            else {
                                Text("Enter Saddle Angle")
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
//                    .shadow(color: Color.primary.opacity(0.7), radius: 10)
                    .background(Color.white)
                    .position(x: geometry.size.width * 0.77, y: geometry.size.height * 0.45)

                    
                    //                    DecimalTextField(placeholder: "Saddle Angle", value: $bikeFit.bbToSaddleAngle)
                    //                        .font(.custom("Roboto-Regular", size: 16))
                    //                        .frame(minWidth: 75, alignment: .trailing)
                    //                        .foregroundColor(Color("PrimaryTextColor"))
                    //                        .padding(.leading, 10)
                    //                        .padding(.top, 10)
                    //                        .padding(.bottom, 10)
                    //                        .suffix("°", minWidth: 30, color: Color.gray, font: .custom("Roboto-Regular", size: 14), padding: 10)
                    //                        .background(Color.white)
                    //                        .overlay( // Overlay a RoundedRectangle for the border
                    //                            RoundedRectangle(cornerRadius: 3)
                    //                                .stroke(Color.red, lineWidth: 4)
                    //                        )
                    //                        .padding()
                    //                        .fixedSize(horizontal: true, vertical: false)
                    //                        .position(x: 310, y: 410)
                    
                    
                    if showSaddleHeightEntryDialog {
                        CustomAlertSheet(isPresented: $showSaddleHeightEntryDialog, text: $bikeFit.name)
                    }
                    
                }
                //                .background(Color.yellow)
                
            }
            //            .background(Color.green)
        }
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
        .onTapGesture {
            // dismiss keyboard when user presses away from focused text field
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
//        .alert("Login", isPresented: $showSaddleHeightEntryDialog, actions: {
////            TextField("Username", text: $bikeFit.name)
//
//                        DecimalTextField(placeholder: "sdfsdf", value: $bikeFit.bbToSaddleCentre)
//                            .font(.custom("Roboto-Regular", size: 14))
//                            .frame(minWidth: 75, alignment: .trailing)
//                            .suffix("mm", minWidth: 30, color: Color.gray, font: .custom("Roboto-Regular", size: 12))
//                            .foregroundColor(Color("PrimaryTextColor"))
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .fixedSize(horizontal: true, vertical: false)
//                    
//                    Button("Login", action: {})
//                    Button("Cancel", role: .cancel, action: {})
//                }, message: {
//                    Text("Please enter your username and password.")
//                })
//        .overlay(

//        )
//        .alert("Saddle Height", isPresented: $showSaddleHeightEntryDialog) {
//            Button("OK", role: .cancel) { }
////            if displayInvalidBikeFitDiscardOption {
////                Button("Discard Bike Fit", role: .destructive) {
////                    navigationPath.removeLast()
////                }
////            }
////            TextField("Bike fit name", text: $bikeFit.bbToSaddleCentre)
////                .textFieldStyle(RoundedBorderTextFieldStyle())
//////                .fontWeight((!viewModel.bikeFit.name.isEmpty ? .bold : .regular))
////                .font(.custom("Roboto-Regular", size: 16)) 
////
//            DecimalTextField(placeholder: "", value: $bikeFit.bbToSaddleCentre)
//                .font(.custom("Roboto-Regular", size: 14))
//                .frame(minWidth: 75, alignment: .trailing)
//                .suffix("mm", minWidth: 30, color: Color.gray, font: .custom("Roboto-Regular", size: 12))
//                .foregroundColor(Color("PrimaryTextColor"))
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .fixedSize(horizontal: true, vertical: false)
//            
//        } message: {
//            Text("Enter the distance (in mm) from the bottom bracket to the centre of the saddle")
//        }
    }
}

#Preview {
    @State var navigationPath = NavigationPath()
    return MeasureSaddlePositionView(bikeFit: BikeFit.new(), navigationPath: $navigationPath)
}
