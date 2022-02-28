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
    
    let viewController = ViewController()
    window.rootViewController = viewController
    
    window.makeKeyAndVisible()
    return window
}

@available(iOS 13, *)
func mainWindow(withWindowScene windowScene: UIWindowScene) -> UIWindow {
    let window = mainWindow()
    window.windowScene = windowScene
    return window
}
