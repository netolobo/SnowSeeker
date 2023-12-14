//
//  ContentViewModel.swift
//  SnowSeeker
//
//  Created by Neto Lobo on 14/12/23.
//

import Foundation

@Observable
class ContentViewModel {
    let savePath = FileManager.documentsDirectory.appending(path: "Resorts")
    
    var searchText = ""
    
    var filteredResorts: [Resort] {
        return searchText.isEmpty ? resorts : resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)}
    }
    
    private var resorts = [Resort]() {
        didSet {
            do {
                let data = try JSONEncoder().encode(resorts)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
    }
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decodedResorts = try? JSONDecoder().decode([Resort].self, from: data) {
                resorts = decodedResorts
                return
            }
        }
        resorts = Bundle.main.decode("resorts.json")
    }
    
    func updateResort(resort: Resort) {
        if let index = resorts.firstIndex(of: resort) {
            resorts[index] = resort
        }
    }
}
