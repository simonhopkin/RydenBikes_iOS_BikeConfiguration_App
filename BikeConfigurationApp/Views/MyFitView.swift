//
//  MyFitView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 07/09/2024.
//

import SwiftUI

struct MyFitView: View {
    @Binding var navigationPath: NavigationPath
    @State var viewModel: MyFitViewModel
    
    var body: some View {
        GeometryReader { geometry in
            List(viewModel.bikeFits) { bikeFit in
                VStack (alignment: .leading) {
                    Button {
                        navigationPath.append(Coordinator.View.myFitDetailsView(bikeFit))
                    } label: {
                        VStack(alignment: .leading, content: {
                            Text(bikeFit.name)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.primary)
                            
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
                                .font(.custom("Roboto-Light", size: 14))
                                .foregroundStyle(Color.primary)
                                
                                Spacer()
                                
                                Image("BikeGuides")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.4)
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
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
}



#Preview {
    @State var navigationPath = NavigationPath()
    @Environment(\.modelContext) var modelContext
    let viewModel = MyFitViewModel(bikeFitRepository: BikeFitRepository(modelContext: modelContext))
    return MyFitView(navigationPath: $navigationPath, viewModel: viewModel)
}
