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
                NavigationLink(destination: ResortView(resort: resort)) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                viewModel.favoriteResort(resort: resort)
                            }
                            
                        } label: {
                            Image(systemName: resort.favorite ? "star.fill" : "star")
                        }
                        .buttonStyle(BorderlessButtonStyle())//without this the tap doesn't work
                    }
                }
            }
            .navigationTitle("Resorts")
            .toolbar {
                Menu {
                    Button("Name") { viewModel.order(by: .name) }
                    
                    Button("Country") {
                        viewModel.order(by: .country)
                    }
                    
                    Button("Favorites") {
                        viewModel.order(by: .favorite)
                    }
                    
                    Button("None") {
                        viewModel.order(by: .none)
                    }
                    
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
                
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .onChange(of: searchText) {
                viewModel.search(searchText)
            }
            .onChange(of: viewModel.order) {
                viewModel.loadResorts()
            }
            .onAppear { viewModel.loadResorts() }
            
            
            //WelcomeView()
        }
        .phoneOnlyNavigationView()
    }
}

#Preview {
    ContentView()
}
