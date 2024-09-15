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
    
    @EnvironmentObject var customActivitySheet: CustomActivitySheet

    
    @State private var showSaddleHeightEntryDialog = false
    @State private var showSaddleAngleEntryDialog = false
    
    var body: some View {
//        NavigationView {
            GeometryReader { geometry in
                
                ZStack {
                    Image("SaddlePositionGuide")
                        .resizable()
                        .scaledToFit()
                    
                    Button {
                        customActivitySheet.showModal {
//                            Text("Hello")
                            CustomAlertSheet(isPresented: $customActivitySheet.isPresented, text: $bikeFit.name)
                                

                    //                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //                            .ignoresSafeArea()
                    //                            .zIndex(1)
                        }
//                        withAnimation {
//                            showSaddleHeightEntryDialog.toggle()
//                        }
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
                    .background(Color.white)
                    .position(x: geometry.size.width * 0.77, y: geometry.size.height * 0.45)
                    
                    
//                    if showSaddleHeightEntryDialog {
//                        CustomAlertSheet(isPresented: $showSaddleHeightEntryDialog, text: $bikeFit.name)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .ignoresSafeArea()
//                            .zIndex(1)
//                        
//                    }
                }
//            }
        }

//        .overlay {
//            if showSaddleHeightEntryDialog {
//                Rectangle()
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .ignoresSafeArea()
//                    .zIndex(0)
//                CustomAlertSheet(isPresented: $showSaddleHeightEntryDialog, text: $bikeFit.name)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .ignoresSafeArea()
//                    .zIndex(1)
//            }
//
//        }
        //        }
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
        
//        .overlay {
//                                if showSaddleHeightEntryDialog {
//                                    CustomAlertSheet(isPresented: $showSaddleHeightEntryDialog, text: $bikeFit.name)
//                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                        .ignoresSafeArea()
//                                        .zIndex(1)
//            
//                                }
//        }
//        .customPopupView(isPresented: $showSaddleHeightEntryDialog, popupView: { popupView })

        //        .onTapGesture {
        //            // dismiss keyboard when user presses away from focused text field
        //            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        //        }
    }
    
    
//    
//    var popupView: some View {
//         
//        CustomAlertSheet(isPresented: $showSaddleHeightEntryDialog, text: $bikeFit.name)
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .ignoresSafeArea()
//            .zIndex(1)
//        
////         RoundedRectangle(cornerRadius: 20.0)
////             .fill(Color.white)
////             .frame(width: 300.0, height: 200.0)
////             .overlay(
////                 
////                 Image(systemName: "xmark").resizable().frame(width: 10.0, height: 10.0)
////                     .foregroundColor(Color.black)
////                     .padding(5.0)
////                     .background(Color.red)
////                     .clipShape(Circle())
////                     .padding()
////                     .onTapGesture { showSaddleHeightEntryDialog.toggle() }
////                 
////                 , alignment: .topLeading)
////             
////             .overlay(Text("Custom PopUp View!"))
////             .transition(AnyTransition.slide)
////             .shadow(radius: 10.0)
//         
//     }
}

#Preview {
    @State var navigationPath = NavigationPath()
    return MeasureSaddlePositionView(bikeFit: BikeFit.new(), navigationPath: $navigationPath)
}
