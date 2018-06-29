//
//  BeerListViewController.swift
//  BeerCrafts
//
//  Created by Abhishek on 29/06/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit
import AppModel

class BeerListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var cellItems: [BeerCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.fetchBeerList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cartAction(_ sender: Any) {
        
    }
}

extension BeerListViewController {
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "BeerTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "BeerTableViewCell")
    }
    
    private func fetchBeerList() {
        self.showLoader()
        Beer.getBeerList { (list, error) in
            self.hideLoader()
            if !list.isEmpty {
                self.cellItems = list.map { BeerCellModel(beer: $0) }
                self.tableView.reloadData()
            }
        }
    }
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BeerTableViewCell"
        ) as! BeerTableViewCell
        cell.delegate = self
        cell.item = self.cellItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension BeerListViewController: BeerTableViewCellDelegate {
    
    func didTapAddButton(cell: BeerTableViewCell) {
        
    }
}
