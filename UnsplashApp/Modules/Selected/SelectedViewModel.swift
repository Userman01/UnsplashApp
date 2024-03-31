//
//  SelectedViewModel.swift
//  UnsplashApp
//
//  Created by Петр Постников on 30.03.2024.
//

import UIKit
import Combine

final class SelectedViewModel {
    
    @Published var isSaved: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    func saveImage(model: Result) {
        isSaved = DataStoreService.saveData(model: model)
    }
    
    func isSavedImage(model: Result) {
        isSaved = DataStoreService.isSavedData(model: model)
    }
}
