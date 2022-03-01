//
//  CategoryTableViewCell.swift
//  FetchMeals
//
//  Created by Joe Bonniwell on 3/1/22.
//

import UIKit

let CategoryTableViewCellIdentifier = "CategoryTableViewCellIdentifier"

class CategoryTableViewCell: UITableViewCell {

    var categoryViewModel: CategoryViewModel?
    var categoryViewModelSubscriptionUUID: UUID?
    
    // Since UITableViewCells can be reused, we rely on configureWithViewModel to clear out any previous view model subscription and update the UI with the current view model updates
    func configureWithViewModel(_ viewModel: CategoryViewModel) {
        if let oldUUID = self.categoryViewModelSubscriptionUUID {
            self.categoryViewModel?.unsubscribeFromChanges(identifier: oldUUID)
            self.categoryViewModelSubscriptionUUID = nil
        }
        
        self.categoryViewModel = viewModel
        
        self.categoryViewModelSubscriptionUUID = self.categoryViewModel?.subscribeToChanges(callback: {_ in
            DispatchQueue.main.async {
                self.updateViews()
            }
        })
        
        self.updateViews()
    }
    
    func updateViews() {
        let title = self.categoryViewModel?.categoryTitle()
        
//        self.backgroundColor = UIColor.white
        
        var image: UIImage?
        if let imageData = self.categoryViewModel?.categoryImageData() {
            image = UIImage(data: imageData)
        } else {
            if #available(iOS 13, *) {
                image = UIImage(systemName: "fork.knife.circle")
            }
        }
        
        if #available(iOS 14, *) {
            var contentConfig = self.defaultContentConfiguration()
            contentConfig.image = image
            contentConfig.text = title
            self.contentConfiguration = contentConfig
        } else {
            self.textLabel?.text = title
            self.imageView?.image = image
        }
    }
}
