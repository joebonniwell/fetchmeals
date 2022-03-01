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
    
    func getAllMealCategories(withCallback callback: @escaping ([MealCategory]) -> Void) {
        // todo: ask local storage for them
        self.apiRepository.fetchAllCategories(withCallback: {categories in
            // todo: send the categories to the local storage
            callback(categories)
        })
    }
    
    // get meals for category
    
    // image for category
    
    // image for meal
}
