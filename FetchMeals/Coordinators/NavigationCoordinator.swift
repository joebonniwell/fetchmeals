//
//  NavigationCoordinator.swift
//  FetchMeals
//
//  Created by Joe Bonniwell on 2/28/22.
//

import Foundation
import UIKit

func mainWindow() -> UIWindow {
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    let repository = MealDBRepository()
    let categoriesViewModel = CategoriesViewModel(repository: repository, categoryViewModels: nil)
    // todo: need to pass the categoriesViewModel a way to call a method on self (which actually doesn't exist at this point since this is just a global function)
    let categoriesViewController = CategoriesTableViewController()
    categoriesViewController.configureWithViewModel(viewModel: categoriesViewModel)
    
    let navigationController = UINavigationController(rootViewController: categoriesViewController)
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
    return window
}

@available(iOS 13, *)
func mainWindow(withWindowScene windowScene: UIWindowScene) -> UIWindow {
    let window = mainWindow()
    window.windowScene = windowScene
    return window
}
