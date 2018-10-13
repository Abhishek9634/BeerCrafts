//
//  CartManager.swift
//  BeerCrafts
//
//  Created by Abhishek Thapliyal on 13/10/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
import AppModel
import RxSwift
import RxCocoa

struct CartProduct {
    var beer: Beer
    var quantity: Int
}

class CartManager {
    
    static let shared = CartManager()
    
    private init() { }
    
    private(set) var cartItems = BehaviorRelay<[CartProduct]>(value: [])
    
    var itemCount: Int {
        return self.cartItems.value.count
    }
    
    func item(at index: Int) -> CartProduct {
        return self.cartItems.value[index]
    }
    
    func add(beer: Beer) {
        var value = self.cartItems.value
        if let index = self.cartItems.value.index(where: { $0.beer.id == beer.id }) {
            value[index].quantity += 1
        } else {
            value.append(CartProduct(beer: beer, quantity: 1))
        }
        self.cartItems.accept(value)
    }
    
    func remove(beer: Beer) {
        guard let index = self.cartItems.value.index(where: {
            $0.beer.id == beer.id
        }) else { return }
        var value = self.cartItems.value
        value.remove(at: index)
        self.cartItems.accept(value)
    }
    
    //TODO: DECRESE NOT WORKING PROPERLY AFTER COUNT = 1
    func updateQuantity(beer: Beer, isIncreasing: Bool = true) {
        guard let index = self.cartItems.value.index(where: {
            $0.beer.id == beer.id
        }) else { return }
        
        var value = self.cartItems.value
        
        if isIncreasing {
            // CASE QUANTITY INCREASING
            value[index].quantity += 1
        } else {
            // CASE QUANTITY DECREASING
            if value[index].quantity == 1 {
                self.remove(beer: beer)
            } else {
                value[index].quantity -= 1
            }
        }
        
        self.cartItems.accept(value)
    }
}
