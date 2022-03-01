//
//  CategoryViewModel.swift
//  FetchMeals
//
//  Created by Joe Bonniwell on 3/1/22.
//

import Foundation

class CategoryViewModel {
    let category: MealCategory!
    
    init(withMealCategory mealCategory: MealCategory) {
        self.category = mealCategory
    }
    
    func categoryTitle() -> String {
        return self.category.title
    }
    
    // category Image
}
