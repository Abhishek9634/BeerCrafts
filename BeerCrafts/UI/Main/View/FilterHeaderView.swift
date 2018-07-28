//
//  FilterHeaderView.swift
//  BeerCrafts
//
//  Created by Abhishek on 28/07/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class FilterHeaderView: TableHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure(_ item: Any?) {
        guard let model = item as? HeaderModel else { return }
        self.titleLabel.text = model.text
    }
}
