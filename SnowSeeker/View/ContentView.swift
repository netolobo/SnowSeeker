//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Neto Lobo on 13/12/23.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    private var viewModel = ContentViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black,lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        
                        Text("\(resort.runs) runs")
                            .foregroundStyle(.secondary)
                    }
                    Button {
                        viewModel.updateResort(resort: resort)
                    } label: {
                        Image(systemName: resort.favorite ? "star.fill" : "star")
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .onChange(of: searchText) {
                viewModel.searchText = searchText
            }
            
//            WelcomeView()
        }
        .phoneOnlyNavigationView()
    }
}

#Preview {
    ContentView()
}
