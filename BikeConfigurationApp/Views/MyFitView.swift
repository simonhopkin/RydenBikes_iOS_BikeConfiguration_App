//
//  MyFitView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 07/09/2024.
//

import SwiftUI
import SwiftData

/// Displays a list of `BikeFit` objects in persistent storage
struct MyFitView: View {
    
    /// navigation path for requesting page changes
    @Binding var navigationPath: NavigationPath
    
    @State var viewModel: MyFitViewModel
    @State var showActionSheet = false
    @State var selectedBikeFit: BikeFit?
    @State var showDeleteBikeFitAlert = false
    @State var showShareSheet = false
    
    /// Query to fetch the BikeFits from persistent storage and respond to updates.  Would rather have done this in the
    /// view model but SwiftData doesn't yet support querying and observing Swift Data changes outside of Views
    @Query(sort: \BikeFit.created, order: .reverse) private var bikeFits: [BikeFit]
    
    var body: some View {
        GeometryReader { geometry in
            
            if bikeFits.isEmpty {
                HStack {
                    Text("Create your first bike fit by pressing the + button above")
                        .font(.custom("Roboto-Light", size: 22))
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.center)
                }
                .padding(50)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            else {
                List(bikeFits) { bikeFit in
                    
                    VStack (alignment: .leading) {
                        
                        Button {
                            navigationPath.append(Route.myFitDetailsView(bikeFit))
                        } label: {
                            VStack(alignment: .leading, content: {
                                
                                HStack(alignment: .center) {
                                    
                                    Text(bikeFit.name)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.primary)
                                    
                                    Spacer()
                                    
                                    // button to access action sheet to delete or share a `BikeFit`
                                    Button {
                                        selectedBikeFit = bikeFit
                                        showActionSheet = true
                                    } label: {
                                        HStack (spacing: 1) {
                                            Image(systemName: "circle.fill").font(.system(size: 5))
                                            Image(systemName: "circle.fill").font(.system(size: 5))
                                            Image(systemName: "circle.fill").font(.system(size: 5))
                                        }
                                    }
                                }
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text("Setback: ").fontWeight(.medium)
                                            Text(String(format: "%.0f", bikeFit.bbToSaddleX)).foregroundStyle(Color("PrimaryTextColor"))
                                        }
                                        HStack {
                                            Text("Saddle Y: ").fontWeight(.medium)
                                            Text(String(format: "%.0f", bikeFit.bbToSaddleY)).foregroundStyle(Color("PrimaryTextColor"))
                                        }
                                        HStack {
                                            Text("Handlebar X: ").fontWeight(.medium)
                                            Text(String(format: "%.0f", bikeFit.bbToHandlebarX)).foregroundStyle(Color("PrimaryTextColor"))
                                        }
                                        HStack {
                                            Text("Handlebar Y: ").fontWeight(.medium)
                                            Text(String(format: "%.0f", bikeFit.bbToHandlebarY)).foregroundStyle(Color("PrimaryTextColor"))
                                        }
                                        HStack {
                                            Text("Grip X: ").fontWeight(.medium)
                                            Text(String(format: "%.0f", bikeFit.bbToHandX)).foregroundStyle(Color("PrimaryTextColor"))
                                        }
                                        HStack {
                                            Text("Grip Y: ").fontWeight(.medium)
                                            Text(String(format: "%.0f", bikeFit.bbToHandY)).foregroundStyle(Color("PrimaryTextColor"))
                                        }
                                    }
                                    .font(.custom("Roboto-Medium", size: 14))
                                    .foregroundStyle(Color.primary)
                                    
                                    Spacer()
                                    
                                    if bikeFit.image != nil {
                                        bikeFit.image!
                                            .resizable()
                                            .aspectRatio(1.6, contentMode: .fit)
                                            .cornerRadius(10)
                                            .frame(width: geometry.size.width * 0.5)
                                    }
                                    else {
                                        Image("BikeGuides")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geometry.size.width * 0.5)
                                    }
                                }
                                
                                // Display the bike notes if not empty
                                if !bikeFit.notes.isEmpty {
                                    Text("Notes")
                                        .font(.custom("Roboto-Bold", size: 14))
                                        .foregroundStyle(Color.primary)
                                    Text(bikeFit.notes)
                                        .font(.custom("Roboto-Regular", size: 14))
                                        .foregroundStyle(Color.primary)
                                }
                            })
                        }
                    }
                }
                .listRowSpacing(5)
                .background(Color.gray)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("My Fit")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            // Override the navigation header bar to contain a back and add buttons
            leading: Button(action: {
                navigationPath.removeLast()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Home")
                }
            },
            trailing:  Button(action: {
                navigationPath.append(Route.myFitDetailsView(BikeFit.new()))
            }) {
                HStack {
                    Image(systemName: "plus")
                    
                }
            })
        .actionSheet(isPresented: $showActionSheet, content: {
            // Action sheet allowing user to delete or share a BikeFit
            ActionSheet(title: Text("Bike Fit Options"),
                        message: nil,
                        buttons: [
                            .default(Text("Share Bike Fit"),
                                     action: {
                                         showActionSheet = false
                                         showShareSheet = true
                                     }),
                            .cancel({
                                showActionSheet = false
                                selectedBikeFit = nil
                            }),
                            .destructive(Text("Delete Bike Fit"),
                                         action: {
                                             showActionSheet = false
                                             showDeleteBikeFitAlert = true
                                         })
                        ])
        })
        .alert("Delete \(selectedBikeFit?.name ?? "unknown")", isPresented: $showDeleteBikeFitAlert) {
            // Alert to confirm deletion of a bike fit
            Button("Cancel", role: .cancel) {
                showDeleteBikeFitAlert = false
            }
            Button("Delete", role: .destructive) {
                viewModel.deleteBikeFit(selectedBikeFit!)
                selectedBikeFit = nil
                showDeleteBikeFitAlert = false
            }
        }
        .sheet(isPresented: $showShareSheet) {
            defer {
                showShareSheet = false
            }
            return ShareSheet(sharedItems: [selectedBikeFit!.bikeFitAppLink])
        }
    }
}



#Preview {
    @State var navigationPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    let viewModel = MyFitViewModel(bikeFitRepository: BikeFitRepository(modelContext: modelContext))
    return MyFitView(navigationPath: $navigationPath, viewModel: viewModel)
}
