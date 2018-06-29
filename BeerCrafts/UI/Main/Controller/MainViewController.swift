//
//  MainViewController.swift
//  BeerCrafts
//
//  Created by Abhishek on 29/06/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit
import AppModel

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchBeerList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func fetchBeerList() {
        Beer.getBeerList { (list, error) in
            print(list)
        }
    }
}

