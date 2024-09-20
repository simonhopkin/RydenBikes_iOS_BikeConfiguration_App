//
//  MyFitSummaryView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 19/09/2024.
//

import SwiftUI

/// Bike fit summary view displayed on my fit page
struct MyFitSummaryView: View {
    
    /// the bike fit shown in this summary
    var bikeFit: BikeFit
    
    /// binding to allow selection of this bike fit and show the action sheet with options
    @Binding var selectedBikeFit: BikeFit?
    @Binding var showActionSheet: Bool

    /// navigation path for requesting page changes
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        
        Button {
            navigationPath.append(Route.myFitDetailsView(bikeFit))
        } label: {
            
            VStack(alignment: .leading) {
                
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
                            Text("Saddle Height: ").fontWeight(.medium)
                            Spacer()
                            Text(String(format: "%.0f", bikeFit.bbToSaddleCentre)).foregroundStyle(Color("PrimaryTextColor"))
                        }
                        
                        HStack {
                            Text("Saddle Setback: ").fontWeight(.medium)
                            Spacer()
                            Text(String(format: "%.0f", bikeFit.bbToSaddleX)).foregroundStyle(Color("PrimaryTextColor"))
                        }
                        .padding(.top, 1)

                        HStack {
                            Text("Saddle to Grip Reach: ").fontWeight(.medium)
                            Spacer()
                            Text(String(format: "%.0f", bikeFit.saddleCentreToHand)).foregroundStyle(Color("PrimaryTextColor"))
                        }
                        .padding(.top, 1)
                        
                        HStack {
                            Text("Saddle to Grip Drop: ").fontWeight(.medium)
                            Spacer()
                            Text(String(format: "%.0f", bikeFit.saddleToHandDrop)).foregroundStyle(Color("PrimaryTextColor"))
                        }
                        .padding(.top, 1)
                    }
                    .font(.custom("Roboto-Regular", size: 14))
                    .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    if bikeFit.image != nil {
                        bikeFit.image!
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity
                            )
                            .frame(
                                width: UIScreen.main.bounds.width * 0.45
                            )
                            .aspectRatio(16 / 9, contentMode: .fill)
                            .cornerRadius(10)
                            .padding(.vertical, 5)
                    }
                    else {
                        Image("BikeGuides")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity
                            )
                            .frame(
                                width: UIScreen.main.bounds.width * 0.45
                            )
                            .aspectRatio(16 / 9, contentMode: .fill)
                            .cornerRadius(10)
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
            }
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    @Previewable @State var navigationPath = NavigationPath()
    @Previewable @State var selectedBikeFit: BikeFit?
    @Previewable @State var showActionSheet: Bool = false
    let bikeFit = BikeFit.new()
    return MyFitSummaryView(bikeFit: bikeFit, selectedBikeFit: $selectedBikeFit, showActionSheet: $showActionSheet, navigationPath: $navigationPath)
}
