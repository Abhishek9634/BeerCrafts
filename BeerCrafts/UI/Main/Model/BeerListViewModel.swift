//
//  BeerListViewModel.swift
//  BeerCrafts
//
//  Created by Abhishek on 27/07/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
import AppModel
import RxSwift
import RxCocoa

typealias DataHandler = () -> Void

let disposableBag = DisposeBag()

class BeerListViewModel {
    
    var items: [BeerCellModel] = []
    var searchItems = BehaviorRelay<[BeerCellModel]>(value: [])
    var reloadHandler: DataHandler = { }
    private var isAscending: Bool = false
    var filterModel = BeerFilterViewModel()
    
    var itemCount: Int {
        return self.searchItems.value.count
    }
    
    init() {
        let _ = self.searchItems.asObservable().subscribe(onNext: { _ in
            self.reloadHandler()
        }).disposed(by: disposableBag)
    }
    
    func item(_ indexPath: IndexPath) -> BeerCellModel {
        return self.searchItems.value[indexPath.row]
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
        self.searchItems.accept(self.items)
    }
}

// FILTER
extension BeerListViewModel {
    
    func configureFilters(list: [Beer]) {
        self.filterModel = BeerFilterViewModel(list: list)
    }
    
    func clearFilters() {
        self.resetData()
    }
    
    func applyFilters(filters: [FilterType: [String]]) {
		let filterItems = self.items.filter { item -> Bool in
			var acceptArray: [Bool] = []
			for (key, value) in filters {
				switch key {
				case .style:
					acceptArray.append(value.isEmpty ? true : value.contains(item.beer.style))
				case .ounces:
					acceptArray.append(value.isEmpty ? true : value.contains(String(item.beer.ounces)))
				case .abv:
					acceptArray.append(value.isEmpty ? true : value.contains(item.beer.abv))
				}
			}
			return acceptArray.reduce(true, { (result, value) -> Bool in
				return result && value
			})
		}
        self.searchItems.accept(filterItems)
    }
}

// SEARCH
extension BeerListViewModel {
    
    func filterSearch(searchText: String) {
        if searchText.isEmpty {
            self.searchItems.accept(self.items)
        } else {
            let value = self.items.filter {
                $0.beer.name.lowercased().contains(searchText.lowercased())
            }
            self.searchItems.accept(value)
        }
    }
    
    func resetData() {
        self.searchItems.accept(self.items)
    }
}

// SORT
extension BeerListViewModel {
    
    func sortItems() {
        self.isAscending = !self.isAscending
        let value = self.searchItems.value.sorted(by: {
            let order = $0.beer.abv.compare($1.beer.abv,
                                            options: .numeric)
            return self.isAscending ?
                   order == .orderedAscending :
                   order == .orderedDescending
        })
        self.searchItems.accept(value)
    }
}
