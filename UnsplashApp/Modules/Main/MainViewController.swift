//
//  ViewController.swift
//  UnsplashApp
//
//  Created by Петр Постников on 29.03.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private enum Apperance {
        static let itemsPerRow: CGFloat = 2
        static let sectionEdgeInserts = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    private let viewModel = MainViewModel()
    private lazy var customView = self.view as? MainView
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "PHOTO"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MainView(frame: .zero, collectionViewDelegate: self, collectionViewDataSource: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupStateObservers()
    }
    
    private func setupStateObservers() {
        viewModel.$images
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.customView?.reloadDataCollectionView()
            }
            .store(in: &viewModel.cancellables)
    }

    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}

// MARK: UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchImages(searchText: searchText)
    }
}

// MARK: UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseID)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseID, for: indexPath) as? ImageCollectionViewCell
        guard let cell else { return UICollectionViewCell() }
        let image = viewModel.images[indexPath.item]
        cell.configure(image: image)
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = viewModel.images[indexPath.item]
        let padding = Apperance.sectionEdgeInserts.left * (Apperance.itemsPerRow + 1)
        let availableWidth = view.frame.width - padding
        let width = availableWidth / Apperance.itemsPerRow
        guard let imageHeight = image.height, let imageWidth = image.width else {return .zero}
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
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell
        guard let cell else { return }
        let image = cell.getImage()
        let model = viewModel.images[indexPath.item]
        let controller = SelectedViewController(image: image, model: model)
        navigationController?.pushViewController(controller, animated: true)
    }
}
