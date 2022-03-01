//
//  CategoriesViewModel.swift
//  FetchMeals
//
//  Created by Joe Bonniwell on 3/1/22.
//

import Foundation

class CategoriesViewModel: BaseViewModel {
    let repository: MealDBRepository
    private var localCategoryViewModels: [CategoryViewModel]?
    
    init(repository: MealDBRepository, categoryViewModels: [CategoryViewModel]?) {
        self.repository = repository
        self.localCategoryViewModels = categoryViewModels
    }
    
    func categoryViewModels() -> [CategoryViewModel] {
        if let currentCategoryViewModels = self.localCategoryViewModels {
            return currentCategoryViewModels
        }
        
        self.repository.getAllMealCategories(withCallback: {mealCategories in
            self.localCategoryViewModels = mealCategories.map({ CategoryViewModel(withMealCategory: $0)}).sorted(by: { $0.categoryTitle() < $1.categoryTitle() })
            self.updateAllObservers()
        })
        
        return []
    }
    
    func categorySelected(selectedCategoryViewModel: CategoryViewModel) {
        print("category selected: \(selectedCategoryViewModel.categoryTitle())")
        // todo: route to navigation coordinator for display
    }
}
