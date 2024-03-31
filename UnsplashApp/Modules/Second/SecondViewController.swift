//
//  SecondViewController.swift
//  UnsplashApp
//
//  Created by Петр Постников on 29.03.2024.
//

import UIKit

class SecondViewController: UIViewController {
    
    private enum Apperance {
        static let itemsPerRow: CGFloat = 3
        static let sectionEdgeInserts = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    private let viewModel = SecondViewModel()
    private lazy var customView = self.view as? SecondView
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Избранное"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SecondView(frame: .zero, collectionViewDelegate: self, collectionViewDataSource: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStateObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getDataSaved()
    }
    
    private func setupStateObservers() {
        viewModel.$model
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.customView?.reloadDataCollectionView()
            }
            .store(in: &viewModel.cancellables)
    }
}

// MARK: UICollectionViewDataSource

extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseID)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseID, for: indexPath) as? ImageCollectionViewCell
        guard let cell else { return UICollectionViewCell() }
        let model = viewModel.model[indexPath.item]
        cell.configure(image: model)
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let model = viewModel.model[indexPath.item]
        let padding = Apperance.sectionEdgeInserts.left * (Apperance.itemsPerRow + 1)
        let availableWidth = view.frame.width - padding
        let width = availableWidth / Apperance.itemsPerRow
        guard let imageHeight = model.height, let imageWidth = model.width else {return .zero}
        let height = CGFloat(imageHeight) * width / CGFloat(imageWidth)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        Apperance.sectionEdgeInserts
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        Apperance.sectionEdgeInserts.left
    }
}

// MARK: UICollectionViewDelegate
extension SecondViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell
        guard let cell else { return }
        let image = cell.getImage()
        let model = viewModel.model[indexPath.item]
        let controller = SelectedViewController(
            image: image,
            model: model,
            selectedType: .withoutNavBar)
        navigationController?.pushViewController(controller, animated: true)
    }
}
