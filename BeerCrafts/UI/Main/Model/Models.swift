//
//  Models.swift
//  BeerCrafts
//
//  Created by Abhishek on 30/06/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
import AppModel

struct BeerCellModel {
    var beer: Beer
}

class SectionModel {
    
    var headerModel: Any?
    var cellModels: [Any] = []
    var footerModel: Any?
    
    init(headerModel: Any? = nil,
         cellModels: [Any] = [],
         footerModel: Any? = nil) {
        self.headerModel = headerModel
        self.cellModels = cellModels
        self.footerModel = footerModel
    }
}

class FilterCellModel {
    
    var value: String
    var isSelected: Bool
    
    init(value: String,
         isSelected: Bool = false) {
        self.value = value
        self.isSelected = isSelected
    }
}

class HeaderModel {
    
    var type: String
    var isSelected: Bool
    
    init(type: String,
         isSelected: Bool = false) {
        self.type = type
        self.isSelected = isSelected
    }
}
