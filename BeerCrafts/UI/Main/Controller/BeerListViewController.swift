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
    private var appliedFilters: [FilterCellModel] = []
    private var isAscending: Bool = false
    
    private struct Segue {
        static let Filters = "FiltersVCSegueId"
    }
    
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
    
    @IBAction func sortAction(_ sender: Any) {
        self.sortList()
    }
    
    @IBAction func filterAction(_ sender: Any) {
        self.filterList()
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
                this.sortList()
                this.tableView.reloadData()
            }
        }
    }
    
    private func sortList() {
        
        self.isAscending = !self.isAscending

        if self.isAscending {
            self.filterItems = self.filterItems.sorted(by: {
                let order = $0.beer.abv.compare($1.beer.abv, options: .numeric)
                return order == .orderedAscending
            })
        } else {
            self.filterItems = self.filterItems.sorted(by: {
                let order = $0.beer.abv.compare($1.beer.abv, options: .numeric)
                return order == .orderedDescending
            })
        }
        
        self.tableView.reloadData()
    }
    
    private func filterList() {
        self.performSegue(withIdentifier: Segue.Filters, sender: self.appliedFilters)
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

extension BeerListViewController: FiltersViewControllerDelegate {
    
    func applyFilters(filters: [FilterCellModel]) {
        
    }
}

extension BeerListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination, sender) {
        case (Segue.Filters?,
              let vc as FiltersViewController,
              let filters as [FilterCellModel]):
            vc.selectedFilters = filters
        default:
            break
        }
        super.prepare(for: segue, sender: sender)
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
                $0.beer.name.lowercased().contains(searchText.lowercased())
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
        self.sortList()
    }
}
