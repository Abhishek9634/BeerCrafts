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
    private var filterItems: [BeerCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupSearchBar()
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
        Beer.getBeerList { [weak self] (list, error) in
            guard let this = self else { return }
            this.hideLoader()
            if !list.isEmpty {
                this.cellItems = list.map { BeerCellModel(beer: $0) }
                this.filterItems = this.cellItems
                this.tableView.reloadData()
            }
        }
    }
}

extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "BeerTableViewCell"
        ) as! BeerTableViewCell
        cell.delegate = self
        cell.item = self.filterItems[indexPath.row]
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

extension BeerListViewController: UISearchBarDelegate {
    
    func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filterItems = self.cellItems
        } else {
            self.filterItems.removeAll()
            let array = self.cellItems.filter {
                ($0.beer.name.lowercased().contains(searchText.lowercased()) || $0.beer.style.lowercased().contains(searchText.lowercased()))
            }
            self.filterItems.append(contentsOf: array)
        }
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetData()
    }
    
    private func resetData() {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        self.filterItems = self.cellItems
        self.tableView.reloadData()
    }
}
