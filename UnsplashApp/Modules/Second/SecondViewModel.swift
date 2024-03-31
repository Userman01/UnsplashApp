//
//  SecondViewModel.swift
//  UnsplashApp
//
//  Created by Петр Постников on 30.03.2024.
//

import UIKit
import Combine

final class SecondViewModel {
    
    var cancellables = Set<AnyCancellable>()
    
    @Published var model: [Result] = []
    
    func getDataSaved() {
        model = DataStoreService.getData()
    }
    
}
