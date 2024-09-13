//
//  MyFitView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 07/09/2024.
//

import SwiftUI
import SwiftData

struct MyFitView: View {
    @Binding var navigationPath: NavigationPath
    @State var viewModel: MyFitViewModel
    @State var showActionSheet = false
    @State var selectedBikeFit: BikeFit?
    @State var showDeleteBikeFitAlert = false
    @State var showShareSheet = false
    
    @Query(sort: \BikeFit.created, order: .reverse) private var bikeFits: [BikeFit]

    var body: some View {
        GeometryReader { geometry in
            List(bikeFits) { bikeFit in
                VStack (alignment: .leading) {
                    Button {
                        navigationPath.append(Coordinator.View.myFitDetailsView(bikeFit))
                    } label: {
                        VStack(alignment: .leading, content: {
                            HStack(alignment: .center) {
                                Text(bikeFit.name)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.primary)
                                Spacer()
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
                                        Text("Saddle X: ").fontWeight(.medium)
                                        Text(String(format: "%.1f", bikeFit.bbToSaddleX)).foregroundStyle(Color("PrimaryTextColor"))
                                    }
                                    HStack {
                                        Text("Saddle Y: ").fontWeight(.medium)
                                        Text(String(format: "%.1f", bikeFit.bbToSaddleY)).foregroundStyle(Color("PrimaryTextColor"))
                                    }
                                    HStack {
                                        Text("Handle X: ").fontWeight(.medium)
                                        Text(String(format: "%.1f", bikeFit.bbToHandlebarX)).foregroundStyle(Color("PrimaryTextColor"))
                                    }
                                    HStack {
                                        Text("Handle Y: ").fontWeight(.medium)
                                        Text(String(format: "%.1f", bikeFit.bbToHandlebarY)).foregroundStyle(Color("PrimaryTextColor"))
                                    }
                                    HStack {
                                        Text("Bars X: ").fontWeight(.medium)
                                        Text("???").foregroundStyle(Color("PrimaryTextColor"))
                                    }
                                    HStack {
                                        Text("Bars Y: ").fontWeight(.medium)
                                        Text("???").foregroundStyle(Color("PrimaryTextColor"))
                                    }
                                }
                                .font(.custom("Roboto-Medium", size: 14))
                                .foregroundStyle(Color.primary)
                                
                                Spacer()
                                
                                Image("BikeGuides")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.5)
                            }
                            
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("My Fit")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .background(Color.gray)
            .navigationBarItems(leading: Button(action: {
                navigationPath.removeLast()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Home")
                }
            }, trailing:  Button(action: {
                navigationPath.append(Coordinator.View.myFitDetailsView(BikeFit.new()))
            }) {
                HStack {
                    Image(systemName: "plus")

                }
            })
            .actionSheet(isPresented: $showActionSheet, content: {
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
//            .onAppear {
//                print("MyFitView onAppear")
//                viewModel.fetchData()
//            }
        }
    }
}



#Preview {
    @State var navigationPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    let viewModel = MyFitViewModel(bikeFitRepository: BikeFitRepository(modelContext: modelContext))
    return MyFitView(navigationPath: $navigationPath, viewModel: viewModel)
}
