//
//  SelectedViewController.swift
//  UnsplashApp
//
//  Created by Петр Постников on 30.03.2024.
//

import UIKit

class SelectedViewController: UIViewController {
    private let viewModel = SelectedViewModel()
    private lazy var customView = self.view as? SelectedView
    private var image: UIImage?
    private var resultModel: Result
    private lazy var actionBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(actionButtonTapped))
    }()

    init(image: UIImage?, model: Result) {
        self.image = image
        self.resultModel = model
        super.init(nibName: nil, bundle: nil)
        title = "Selected"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SelectedView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView?.configure(image: image, model: resultModel)
        setupNavigationBar()
        setupStateObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = actionBarButtonItem
    }
    
    @objc func actionButtonTapped() {
        viewModel.saveImage(image: image, model: resultModel)
    }
    
    private func setupStateObservers() {
        viewModel.$isSaved
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isSaved in
                if isSaved {
                    self?.navigationItem.rightBarButtonItem?.isEnabled = false
                    self?.navigationItem.rightBarButtonItem?.tintColor = .lightGray
                    let alert = UIAlertController(title: "", message: "Сохранено", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true)
                } else {
                    self?.navigationItem.rightBarButtonItem?.isEnabled = true
                }
            }
            .store(in: &viewModel.cancellables)
    }
}
