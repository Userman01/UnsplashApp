//
//  SelectedView.swift
//  UnsplashApp
//
//  Created by Петр Постников on 30.03.2024.
//

import UIKit

final class SelectedView: UIView {
    private enum ViewMetrics {
        static let layoutMargins = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layoutMargins = ViewMetrics.layoutMargins
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = .top
        stackView.axis = .vertical
        stackView.spacing = .zero
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configure(image: UIImage?, model: Result) {
        imageView.image = image
        addStackView(model: model)
    }
    
    private func addStackView(model: Result) {
        stackView.addArrangedSubview(makeLabel(text: "Автор: \(model.user?.name ?? "")"))
        stackView.addArrangedSubview(makeLabel(text: "Описание: \(model.description ?? "")"))
        stackView.addArrangedSubview(makeLabel(text: "Instagram: \(model.user?.instagramUsername ?? "")"))
        stackView.addArrangedSubview(makeLabel(text: "portfolioURL: \(model.user?.portfolioURL ?? "")"))
    }
    
    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = .zero
        label.textAlignment = .left
        label.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        return label
    }
}
