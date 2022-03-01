//
//  CategoriesTableViewController.swift
//  FetchMeals
//
//  Created by Joe Bonniwell on 3/1/22.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    var viewModel: CategoriesViewModel?
    var viewModelSubscriptionUUID: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.backgroundColor = UIColor.white
        self.navigationItem.title = NSLocalizedString("Categories", comment: "Categories title for list of meal categories")
        self.tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCellIdentifier)
    }

    deinit {
        if let viewModelSubscriptionUUID = self.viewModelSubscriptionUUID {
            self.viewModel?.unsubscribeFromChanges(identifier: viewModelSubscriptionUUID)
        }
    }
    
    func configureWithViewModel(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        self.tableView.reloadData()
        self.viewModelSubscriptionUUID = self.viewModel?.subscribeToChanges(callback: {viewModel in
            DispatchQueue.main.async{ self.tableView.reloadData() }
        })
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.categoryViewModels().count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCellIdentifier, for: indexPath)
        if let categoryCell = cell as? CategoryTableViewCell, let categoryViewModelForRow = self.viewModel?.categoryViewModels()[indexPath.row] {
            categoryCell.configureWithViewModel(categoryViewModelForRow)
        }
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedCategory = self.viewModel?.categoryViewModels()[indexPath.row] else {
            print("missing selected category for row: \(indexPath.row)")
            return
        }
        self.viewModel?.categorySelected(selectedCategoryViewModel: selectedCategory)
    }
}
