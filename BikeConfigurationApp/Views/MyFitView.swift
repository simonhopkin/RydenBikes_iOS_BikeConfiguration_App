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
                    MyFitSummaryView(bikeFit: bikeFit, 
                                     selectedBikeFit: $selectedBikeFit,
                                     showActionSheet: $showActionSheet,
                                     navigationPath: $navigationPath)
                }
                .listRowSpacing(15)
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
