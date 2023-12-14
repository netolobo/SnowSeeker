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
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    
    private var filteredResorts: [Resort] {
        return searchText.isEmpty ? resorts : resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
    }
    
    var body: some View {
        NavigationStack {
            List(filteredResorts) { resort in
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
                }
            }
            .navigationTitle("Retorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            
//            WelcomeView()
        }
        .phoneOnlyNavigationView()
    }
}

#Preview {
    ContentView()
}
