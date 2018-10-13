//
//  CartProductTableViewCell.swift
//  BeerCrafts
//
//  Created by Abhishek Thapliyal on 13/10/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

protocol CartProductCellDelegate: class {
    func updateQuantity(_ cell: CartProductTableViewCell, isIncreasing: Bool)
    func remove(_ cell: CartProductTableViewCell)
}

class CartProductTableViewCell: TableViewCell {

    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var alcoholContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func configure(_ item: Any?) {
        guard let model = item as? CartProduct else { return }
        self.themeLabel.text = model.beer.style
        self.nameLabel.text = model.beer.name
        self.alcoholContentLabel.text = model.beer.abv
        self.countLabel.text = String(model.quantity)
    }
    
    @IBAction func removeAction(_ sender: UIButton) {
        (self.delegate as? CartProductCellDelegate)?.remove(self)
    }
    
    @IBAction func incAction(_ sender: UIButton) {
        (self.delegate as? CartProductCellDelegate)?.updateQuantity(self,
                                                                    isIncreasing: true)
    }
    
    @IBAction func decAction(_ sender: UIButton) {
        (self.delegate as? CartProductCellDelegate)?.updateQuantity(self,
                                                                    isIncreasing: false)
    }
}
