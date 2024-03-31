//
//  FirstView.swift
//  UnsplashApp
//
//  Created by Петр Постников on 29.03.2024.
//

import UIKit

final class MainView: UIView {
    
    private enum ViewMetrics {
        static let layoutMargins = UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
    }
    
    private var delegate: MainViewControllerDelegate?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.layoutMargins = ViewMetrics.layoutMargins
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.refreshControl = refreshControl
        return collectionView
    }()
    
    init(frame: CGRect,
         collectionViewDelegate: UICollectionViewDelegate,
         collectionViewDataSource: UICollectionViewDataSource,
         delegate: MainViewControllerDelegate) {
        self.delegate = delegate
        super.init(frame: frame)
        setupLayout()
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadDataCollectionView() {
        collectionView.reloadData()
    }
    
    private func setupLayout() {
        backgroundColor = .backgroundColor
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        delegate?.fetchImagesForRefreshControl()
        sender.endRefreshing()
    }
}
