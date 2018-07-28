//
//  BeerFilterViewModel.swift
//  BeerCrafts
//
//  Created by Abhishek on 28/07/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
import AppModel

class BeerFilterViewModel {
    
    var sections: [SectionModel] = []
    var reloadHandler: DataHandler = { }
    
    init(list: [Beer] = []) {
        self.configure(list: list)
    }
    
    func configure(list: [Beer]) {
        
        let abvDictionary = list.reduce(into: [String: Int]()) { (dictionary, model) in
            let type = model.abv.isEmpty ? "0.00" : model.abv
            dictionary[type] = 0
        }
        
        let ouncesDictionary = list.reduce(into: [String: Int]()) { (dictionary, model) in
            let type = String(model.ounces)
            dictionary[type] = 0
        }
        
        let styleDictionary = list.reduce(into: [String: Int]()) { (dictionary, model) in
            let type = model.style
            dictionary[type] = 0
        }
        
        let abvCellModels = abvDictionary.map { FilterCellModel(type: $0.key) }
        let ouncesCellModels = ouncesDictionary.map { FilterCellModel(type: $0.key) }
        let styleCellModels = styleDictionary.map { FilterCellModel(type: $0.key) }
        
        self.sections = [
            SectionModel(headerModel: HeaderModel(text: "Style"),
                         cellModels: styleCellModels),
            SectionModel(headerModel: HeaderModel(text: "Ounces"),
                         cellModels: ouncesCellModels),
            SectionModel(headerModel: HeaderModel(text: "Alcohol(By Vol.)"),
                         cellModels: abvCellModels)
        ]
    }
}

extension BeerFilterViewModel {
    
    func item(at indexPath: IndexPath) -> Any {
        return self.sections[
            indexPath.section
        ].cellModels[
            indexPath.row
        ]
    }
    
    func items(at indexPath: IndexPath) -> [Any] {
        return self.sections[
            indexPath.section
        ].cellModels
    }
    
    func itemCount(at section: Int) -> Int {
        return self.sections[
            section
        ].cellModels.count
    }
    
    var sectionCount: Int {
        return self.sections.count
    }
    
    func sectionModel(at section: Int) -> Any? {
        return self.sections[
            section
        ].headerModel
    }
}

// APPLY and CLEAR
extension BeerFilterViewModel {
    
    func clearFilters() {
        self.sections.forEach {
            ($0.headerModel as? HeaderModel)?.isSelected = false
            $0.cellModels.forEach { model in
                (model as? FilterCellModel)?.isSelected = false
            }
        }
        self.reloadHandler()
    }
    
}
