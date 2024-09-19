//
//  GuidanceHandPositionView.swift
//  BikeConfigurationApp
//
//  Created by Simon Hopkin on 18/09/2024.
//

import SwiftUI

struct GuidanceHandPositionView: View {
    
    @Binding var showGuidanceSheet: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    showGuidanceSheet = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 30))
                }
            }
            
            TabView {
                VStack {
                    Text("Hand Guidance 1 Headline")
                        .font(.title)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .background(Color.gray)
                        .aspectRatio(0.9, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Text("Guidance 1 Image")
                        }
                    
                    Text("Guidance text 1")
                        .font(.headline)
                        .padding(.vertical, 30)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)

                VStack {
                    Text("Hand Guidance2 Headline")
                        .font(.title)

                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .background(Color.gray)
                        .aspectRatio(0.9, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Text("Guidance 2 Image")
                        }
                    
                    Text("Guidance text 2")
                        .font(.headline)
                        .padding(.vertical, 30)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)

                VStack {
                    Text("Hand Guidance 3 Headline")
                        .font(.title)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .background(Color.gray)
                        .aspectRatio(0.9, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .overlay {
                            Text("Guidance 3 Image")
                        }
                    
                    Text("Guidance text 3")
                        .font(.headline)
                        .padding(.vertical, 30)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 20)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .padding(20)
    }
}

#Preview {
    @State var showGuidanceSheet: Bool = false
    return GuidanceHandPositionView(showGuidanceSheet: $showGuidanceSheet)
}
