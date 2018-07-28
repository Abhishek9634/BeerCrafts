//
//  FiltersViewController.swift
//  BeerCrafts
//
//  Created by Abhishek on 30/06/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

protocol FiltersViewControllerDelegate: class {
    func applyFilters(filters: [Any])
}

class FiltersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellItems: [Any] = []
    var selectedFilters: [Any] = []
    
    weak var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateFilters()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clearAction(_ sender: Any) {
        self.selectedFilters.removeAll()
        self.tableView.reloadData()
    }
    
    @IBAction func applyAction(_ sender: Any) {
        self.delegate?.applyFilters(filters: self.selectedFilters)
        self.navigationController?.popViewController(animated: true)
    }
}

extension FiltersViewController {
    
    private func updateFilters() {
//        for item in self.cellItems {
//            if self.selectedFilters.contains(where: { $0.style == item.style }) {
//                item.isSelected = true
//            }
//        }
    }
}

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "FilterTableViewCell"
        ) as! FilterTableViewCell
        cell.item = self.cellItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let model = self.cellItems[indexPath.row]
//        model.isSelected = !model.isSelected
//        
//        if model.isSelected {
//            self.selectedFilters.append(model)
//        } else {
//            self.selectedFilters = self.selectedFilters.filter {
//                $0.style != model.style
//            }
//        }
//        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
}
