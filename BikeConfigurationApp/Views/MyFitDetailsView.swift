//
//  MyFitDetailsView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 10/09/2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct MyFitDetailsView: View {
    
    @Binding var navigationPath: NavigationPath
    @State var viewModel: MyFitDetailsViewModel
    
    @State private var bikeItem: PhotosPickerItem?
    @State private var bikeImage = Image("BikeImagePlaceholder")
    
    @State private var displayInvalidBikeFitAlert = false
    
    var body: some View {
        GeometryReader { geometry in
            
            ScrollView {
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        TextField("Bike fit name", text: $viewModel.bikeFit.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .fontWeight(!viewModel.bikeFit.name.isEmpty ? .bold : .regular)
                            .font(.custom("Roboto-Regular", size: 16))
                        
                        
                        HStack(alignment: .top, spacing: 20) {
                            
                            VStack (alignment: .leading) {
                                Text("Notes")
                                    .padding(.top, 10)
                                    .padding(.bottom, 1)
                                    .font(.custom("Roboto-Light", size: 12))
                                
                                TextField("Bike fit notes", text: $viewModel.bikeFit.notes, axis: .vertical)
                                    .lineLimit(4)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(.custom("Roboto-Regular", size: 16))
                            }
                            .frame(width: geometry.size.width * 0.6)
                            
                            bikeImage
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(5)
                                .overlay(alignment: .topTrailing) {
                                    PhotosPicker(selection: $bikeItem,
                                                 matching: .images,
                                                 photoLibrary: .shared()) {
                                        Image(systemName: "plus.circle.fill")
                                            .font(.system(size: 35))
                                            .foregroundColor(.white)
                                            .opacity(0.6)
                                    }
                                                 .buttonStyle(.borderless)
                                }
                        }
                    }
                    .padding()
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        fitSection("Saddle Position")
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                fitField("BB to Saddle Centre", suffix: "mm", value: $viewModel.bikeFit.bbToSaddleCentre)
                                fitField("BB to Saddle Angle", suffix: "°", value: $viewModel.bikeFit.bbToSaddleAngle)
                                fitField("BB to Saddle X", suffix: "mm", value: $viewModel.bikeFit.bbToSaddleX)
                                fitField("BB to Saddle Y", suffix: "mm", value: $viewModel.bikeFit.bbToSaddleY)
                            }
                            .frame(width: geometry.size.width * 0.6)
                            
                            Image("SaddlePositionGuide")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        fitSection("Hand Position")
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                fitField("Saddle Centre to Hand", suffix: "mm", value: $viewModel.bikeFit.saddleCentreToHand)
                                fitField("Saddle to Hand Drop", suffix: "mm", value: $viewModel.bikeFit.saddleToHandDrop)
                            }
                            .frame(width: geometry.size.width * 0.6)
                            
                            Image("HandPositionGuide")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                    Divider()
                    
                    VStack(alignment: .leading) {
                        fitSection("Handlebar Position")
                        HStack(alignment: .center) {
                            VStack(alignment: .leading) {
                                fitField("BB to Handlebar", suffix: "mm", value: $viewModel.bikeFit.bbToHandlebarCentre)
                                fitField("BB to Handlebar Angle", suffix: "mm", value: $viewModel.bikeFit.bbToHandlebarAngle)
                                fitField("BB to Handlebar X", suffix: "mm", value: $viewModel.bikeFit.bbToHandlebarX)
                                fitField("BB to Handlebar Y", suffix: "mm", value: $viewModel.bikeFit.bbToHandlebarY)
                            }
                            .frame(width: geometry.size.width * 0.6)
                            
                            Image("HandlebarPositionGuide")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    
                }
                .onTapGesture {
                    // dismiss keyboard when user presses away from focused text field
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Fit Details")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: Button(action: {
                if viewModel.bikeFit.isValid() {
                    viewModel.saveBikeFit()
                    navigationPath.removeLast()
                }
                else {
                    displayInvalidBikeFitAlert = true
                }
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("My Fit")
                }
            })
            .alert(isPresented: $displayInvalidBikeFitAlert) {
                Alert(
                    title: Text("Bike Fit Incomplete"),
                    message: Text("Please ensure all measurements are populated to save this bike fit"),
                    primaryButton: .default(Text("OK")),
                    secondaryButton: .destructive(Text("Discard Bike Fit"), action: {
                        navigationPath.removeLast()
                    })
                )
            }
        }
        .onChange(of: bikeItem) {
            // manage the loading of the bike image from the photo picker
            Task {
                if let loaded = try? await bikeItem?.loadTransferable(type: Image.self) {
                    bikeImage = loaded
                } else {
                    print("Failed")
                }
            }
        }
    }
    
    func fitSection(_ title: String) -> some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
                .font(.custom("Roboto-Regular", size: 16))
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Text("measure")
                    .font(.custom("Roboto-Regular", size: 12))
            })
        }
    }
    
    
    func fitField(_ title: String, suffix: String, value: Binding<Double>) -> some View {
        HStack {
            Text(title)
                .frame(alignment: .leading)
                .font(.custom("Roboto-Regular", size: 14))
            
            Spacer()
            
            DecimalTextField(placeholder: "", value: value)
                .font(.custom("Roboto-Regular", size: 14))
                .frame(minWidth: 75, alignment: .trailing)
                .suffix(suffix, minWidth: 30, color: Color.gray, font: .custom("Roboto-Regular", size: 12))
                .foregroundColor(Color("PrimaryTextColor"))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fixedSize(horizontal: true, vertical: false)

        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    @State var navigationPath = NavigationPath()
    let modelContainer = try! ModelContainer(for: BikeFit.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    let modelContext = modelContainer.mainContext
    let viewModel = MyFitDetailsViewModel(bikeFitRepository: BikeFitRepository(modelContext: modelContext), bikeFit: BikeFit.new())
    return MyFitDetailsView(navigationPath: $navigationPath, viewModel: viewModel)
}
