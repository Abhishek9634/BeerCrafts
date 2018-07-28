//
//  FilterHeaderView.swift
//  BeerCrafts
//
//  Created by Abhishek on 28/07/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

protocol FilterHeaderViewDelegate: class {
    func didSelect(headerView: FilterHeaderView)
}

class FilterHeaderView: TableHeaderFooterView {

    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configure(_ item: Any?) {
        guard let model = item as? HeaderModel else { return }
        self.titleLabel.text = model.text
    }
    
    @IBAction func tapAction(_ sender: Any) {
        guard let model = item as? HeaderModel else { return }
        model.isSelected = !model.isSelected
        (self.delegate as? FilterHeaderViewDelegate)?.didSelect(headerView: self)
    }
}
