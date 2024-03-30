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
    
    func saveImage(image: UIImage?, model: Result) {
        guard let id = model.id else { return }
        let model = SaveModel(
            id: id,
            urlImage: model.urls["regular"] ?? "",
            name: model.user?.name ?? "",
            description: model.description ?? "",
            instagramUsername: model.user?.instagramUsername ?? "",
            portfolioURL: model.user?.portfolioURL ?? "",
            width: model.width ?? .zero,
            height: model.height ?? .zero)
        isSaved = DataStoreService.saveData(model: model)
    }
}
