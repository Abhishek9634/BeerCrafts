//
//  BeerTableViewCell.swift
//  BeerCrafts
//
//  Created by Abhishek on 29/06/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

protocol BeerTableViewCellDelegate: class {
    func didTapAddButton(cell: BeerTableViewCell)
}

class BeerTableViewCell: TableViewCell {

    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alcoholContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configure(_ item: Any?) {
        if let model = item as? BeerCellModel {
            self.themeLabel.text = model.beer.style
            self.nameLabel.text = model.beer.name
            self.alcoholContentLabel.text = model.beer.abv
        }
    }
    
    @IBAction func addAction(_ sender: Any) {
        (self.delegate as? BeerTableViewCellDelegate)?.didTapAddButton(cell: self)
    }
}
