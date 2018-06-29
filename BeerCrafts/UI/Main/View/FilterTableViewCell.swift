//
//  FilterTableViewCell.swift
//  BeerCrafts
//
//  Created by Abhishek on 30/06/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class FilterTableViewCell: TableViewCell {

    @IBOutlet weak var styleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configure(_ item: Any?) {
        if let model = item as? FilterCellModel {
            self.styleLabel.text = model.style
            self.styleLabel.textColor = isSelected ? .blue : .black
        }
    }
}
