//
//  BaseViewModel.swift
//  FetchMeals
//
//  Created by Joe Bonniwell on 3/1/22.
//

import Foundation

protocol ObservableViewModel {
    func subscribeToChanges(callback: @escaping (ObservableViewModel) -> Void) -> UUID
    func unsubscribeFromChanges(identifier: UUID) -> Void
}

class BaseViewModel: ObservableViewModel {
    var observers = [UUID: (ObservableViewModel) -> Void]()
    
    func subscribeToChanges(callback: @escaping (ObservableViewModel) -> Void) -> UUID {
        let observerUUID = UUID()
        self.observers[observerUUID] = callback
        return observerUUID
    }
    
    func unsubscribeFromChanges(identifier: UUID) {
        self.observers.removeValue(forKey: identifier)
    }
    
    func updateAllObservers() {
        self.observers.values.forEach { $0(self) }
    }
}

