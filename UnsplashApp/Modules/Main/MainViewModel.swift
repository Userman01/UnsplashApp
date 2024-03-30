//
//  FirstViewModel.swift
//  UnsplashApp
//
//  Created by Петр Постников on 30.03.2024.
//

import Foundation
import Combine

final class MainViewModel {
    
    private let networkProvider = NetworkProvider()
    private var timer: Timer?
    var cancellables = Set<AnyCancellable>()
    
    @Published var images: [Result] = []
    
    func fetchImages(searchText: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] _ in
            self?.networkProvider.getImages(searchText: searchText) { [weak self] result in
                guard let result else { return }
                self?.images = result.results
            }
        })
    }
}
