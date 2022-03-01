//
//  CategoryViewModel.swift
//  FetchMeals
//
//  Created by Joe Bonniwell on 3/1/22.
//

import Foundation

class CategoryViewModel: BaseViewModel {
    let repository: MealDBRepository
    let category: MealCategory
    var localCategoryImageData: Data?
    
    init(withMealCategory mealCategory: MealCategory, repository: MealDBRepository) {
        self.category = mealCategory
        self.repository = repository
    }
    
    func categoryTitle() -> String {
        return self.category.title
    }
    
    func categoryImageData() -> Data? {
        if self.localCategoryImageData == nil {
            self.repository.getImageForCategory(category: self.category, callback: {data in
                self.localCategoryImageData = data
                self.updateAllObservers()
            })
        }
        return self.localCategoryImageData
    }
}
