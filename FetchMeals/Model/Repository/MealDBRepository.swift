//
//  MealDBRepository.swift
//  FetchMeals
//
//  Created by Joe Bonniwell on 3/1/22.
//

import Foundation


class MealDBRepository {
    
    let apiRepository: MealDBAPIRepository!
    
    init(apiRepository: MealDBAPIRepository = MealDBAPIRepository()) {
        self.apiRepository = apiRepository
    }
    
    var allMealCategoriesCallbacks: [([MealCategory]) -> Void]?
    
    func getAllMealCategories(withCallback callback: @escaping ([MealCategory]) -> Void) {
        // todo: ask local storage for them
        if self.allMealCategoriesCallbacks != nil {
            self.allMealCategoriesCallbacks?.append(callback)
        } else {
            self.allMealCategoriesCallbacks = [callback]
            self.apiRepository.fetchAllCategories(withCallback: {categories in
                // todo: send the categories to the local storage
                self.allMealCategoriesCallbacks?.forEach({ $0(categories) })
                self.allMealCategoriesCallbacks = nil
            })
        }
    }
    
    // get meals for category
//    func mealsForCategory(category: MealCategry, callback: @escaping ([Meal]) -> Void) -> Void {
//
//    }
    
    var categoryImageCallbacks: [String: [(Data?) -> Void]] = [:]
    
    // todo: I think this refactors to a common getImageFor by extracting the string from either category or meal...
    func getImageForCategory(category: MealCategory, callback: @escaping (Data?) -> Void) {
        // todo: ask local storage for the image data
        if var existingCategoryCallbacks = self.categoryImageCallbacks[category.imageURL] {
            existingCategoryCallbacks.append(callback)
        } else {
            self.categoryImageCallbacks[category.imageURL] = [callback]
            self.apiRepository.fetchImageWithURL(urlString: category.imageURL, callback: {data in
                self.categoryImageCallbacks[category.imageURL]?.forEach({ $0(data) })
                self.categoryImageCallbacks.removeValue(forKey: category.imageURL)
            })
        }
    }
    
    // image for meal
}
