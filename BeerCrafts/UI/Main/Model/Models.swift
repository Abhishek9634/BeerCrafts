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

class FilterCellModel {
    
    var style: String
    var isSelected: Bool
    
    init(style: String, isSelected: Bool = false) {
        self.style = style
        self.isSelected = isSelected
    }
}
