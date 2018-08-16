//
//  MainViewController.swift
//  BeerCrafts
//
//  Created by Abhishek on 29/06/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private struct Segue {
        static let BeerList = "BeerListVCSegueId"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func beerListAction(_ sender: Any) {
        self.performSegue(withIdentifier: Segue.BeerList, sender: nil)
    }
}

