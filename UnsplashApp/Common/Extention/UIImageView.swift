//
//  ImageView.swift
//  UnsplashApp
//
//  Created by Петр Постников on 30.03.2024.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: URL) {
        ImageProvider.fetchImage(from: url) { data, response, error in
            guard let data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }
    }
}
