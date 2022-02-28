//
//  MealDBAPIService.swift
//  FetchMeals
//
//  Created by Joe Bonniwell on 2/28/22.
//

import Foundation

let APIBaseURLString = "https://www.themealdb.com/api/json/v1/1"
let CategoriesSlug = "/categories.php"
let CategoryMealsSlug = "/filter.php?c="
let MealLookupSlug = "/lookup.php?i="

func allCategoriesURL() -> URL {
    return URL(string: APIBaseURLString + CategoriesSlug)!
}

struct AllCategoriesResponse: Decodable {
    let categories: [CategoryDTO]
}

struct CategoryDTO: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
}

extension MealCategory {
    convenience init(withCategoryDTO categoryDTO: CategoryDTO) {
        self.init(
            identifier: categoryDTO.idCategory,
            title: categoryDTO.strCategory,
            imageURL: categoryDTO.strCategoryThumb
        )
    }
}

class MealDBAPIService {
    
    func getDataFromURL(_ url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: allCategoriesURL(), completionHandler: {(data, response, error) in
            completionHandler(data, response, error)
        }).resume()
    }
    
    func fetchAllCategories(withCallback callback: @escaping (_: [MealCategory]) -> Void) {
        self.getDataFromURL(allCategoriesURL(), completionHandler: {(data, response, error) in
            if let error = error {
                print("error fetching categories: \(error)")
                callback([])
            } else if let categoryData = data {
                callback(categoriesFromResponseData(categoryData))
            }
        })
    }
    
    // Fetch Meal List for Category Name
    
    // Fetch Meal detail(s) by ID
    
    // Fetch Image by URL
    
}

func categoriesFromResponseData(_ responseData: Data) -> [MealCategory] {
    if let allCategoriesResponse = try? JSONDecoder().decode(AllCategoriesResponse.self, from: responseData) {
        return allCategoriesResponse.categories.map() { MealCategory(withCategoryDTO: $0) }
    }
    return []
}
    
