//
//  MealCategory.swift
//  FetchMeals
//
//  Created by Joe Bonniwell on 2/28/22.
//

import Foundation

class MealCategory {
    let identifier: String
    let title: String
    let imageURL: String
    
    init(identifier: String, title: String, imageURL: String) {
        self.identifier = identifier
        self.title = title
        self.imageURL = imageURL
    }
}
