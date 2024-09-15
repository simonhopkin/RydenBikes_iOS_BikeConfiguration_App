//
//  CustomAlertSheet.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 13/09/2024.
//

import SwiftUI

struct CustomAlertSheet: View {
    @Binding var isPresented: Bool
    @Binding var text: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer() // Push the bottom sheet to the bottom of the screen
                
                VStack(spacing: 20) {
                    Text("Enter Your Text hhh \(geometry.size.height)")
                        .font(.headline)
                        .padding(.top, 20)
                    
                    TextField("Placeholder", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 20)
                    
                    HStack {
                        Button("Cancel") {
                            withAnimation {
                                isPresented = false // Dismiss the sheet
                            }
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        
                        Button("OK") {
                            // Handle the OK action here
                            print("User entered: \(text)")
                            withAnimation {
                                isPresented = false // Dismiss the sheet
                            }
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 40)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(radius: 10)
                .frame(width: geometry.size.width, alignment: .center) // Fit width to screen
//                .offset(y: isPresented ? 0 : geometry.size.height) // Slide up from bottom
            }
//            .onTapGesture {
//                withAnimation {
//                    isPresented = false // Dismiss when tapping outside
//                }
//            }

//            .background(
//                Color.black.opacity(0.3)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        withAnimation {
//                            isPresented = false // Dismiss when tapping outside
//                        }
//                    }
//            ) // Dimmed background
        }
    }
}

