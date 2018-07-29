//
//  BeerListViewModel.swift
//  BeerCrafts
//
//  Created by Abhishek on 27/07/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
import AppModel

typealias DataHandler = () -> Void

class BeerListViewModel {
    
    init() { }
    
    var items: [BeerCellModel] = []
    var searchItems: [BeerCellModel] = []
    var reloadHandler: DataHandler = { }
    private var isAscending: Bool = false
    var filterModel = BeerFilterViewModel()
    
    var itemCount: Int {
        return self.searchItems.count
    }
    
    func item(_ indexPath: IndexPath) -> BeerCellModel {
        return self.searchItems[indexPath.row]
    }
    
    func fetchItems(completion: @escaping (_ error: Error?) -> Void) {
        Beer.getBeerListOffline { [weak self] (list, error) in
            if let error = error {
                completion(error)
            } else {
                self?.configureModels(list: list)
                self?.configureFilters(list: list)
                completion(nil)
            }
        }
    }
    
    private func configureModels(list: [Beer]) {
        self.items = list.map { BeerCellModel(beer: $0) }
        self.searchItems = self.items
    }
}

// FILTER
extension BeerListViewModel {
    
    func configureFilters(list: [Beer]) {
        self.filterModel = BeerFilterViewModel(list: list)
    }
    
    func applyFilters(filters: [String: [String]]) {
        // TODO
        self.reloadHandler()
    }
}

// SEARCH
extension BeerListViewModel {
    
    func filterSearch(searchText: String) {
        if searchText.isEmpty {
            self.searchItems = self.items
        } else {
            self.searchItems.removeAll()
            self.searchItems = self.items.filter {
                $0.beer.name.lowercased().contains(searchText.lowercased())
            }
        }
        self.reloadHandler()
    }
    
    func resetData() {
        self.searchItems = self.items
        self.reloadHandler()
    }
}

// SORT
extension BeerListViewModel {
    
    func sortItems() {
        self.isAscending = !self.isAscending
        self.searchItems = self.searchItems.sorted(by: {
            let order = $0.beer.abv.compare($1.beer.abv,
                                            options: .numeric)
            return self.isAscending ?
                   order == .orderedAscending :
                   order == .orderedDescending
        })
        self.reloadHandler()
    }
}
