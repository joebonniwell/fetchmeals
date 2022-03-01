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
    
    func configureWithViewModel(_ viewModel: CategoryViewModel) {
        self.categoryViewModel = viewModel
        
//        self.backgroundColor = UIColor.white
        
        if #available(iOS 14, *) {
            var contentConfig = self.defaultContentConfiguration()
            contentConfig.text = self.categoryViewModel?.categoryTitle()
            self.contentConfiguration = contentConfig
        } else {
            self.textLabel?.text = self.categoryViewModel?.categoryTitle()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
