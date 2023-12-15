//
//  ContentViewModel.swift
//  SnowSeeker
//
//  Created by Neto Lobo on 14/12/23.
//

import Foundation

@Observable
class ContentViewModel {
    private let savePath = FileManager.documentsDirectory.appending(path: "Resorts")
    
    var order = Order.none
    
    var filteredResorts = [Resort]()
    
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
    
    func search(_ searchText: String) {
        filteredResorts = searchText.isEmpty ? resorts : resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func order(by order: Order) {
        self.order = order
    }
    
    func loadResorts() {
        switch order {
        case .none:
            filteredResorts = resorts
        case .name:
            filteredResorts = resorts.sorted { $0.name < $1.name }
        case .country:
            filteredResorts = resorts.sorted { $0.country < $1.country }
        case .favorite:
            filteredResorts = resorts.filter { $0.favorite }
        }
    }
    
}
