//
//  View.swift
//  APOD
//
//  Created by Fabricio Pujol on 13/02/25.
//

import UIKit

protocol ViewDelegate: AnyObject {
    func didTapButton()
}

class APODScreenView: UIView {
    
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .apodLetters
        //button.addTarget(self, action: #selector(self.tappedFiltersButtons), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .apodLetters
        //button.addTarget(self, action: #selector(self.tappedFiltersButtons), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.text = "In the Core of the Carina Nebula"
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.text = "14/02/2025"
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    //private lazy var APODImageView: UIImageView = {
    lazy var APODImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.image = UIImage(systemName: "photo.artframe")
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: ViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func delegate(delegate: ViewDelegate?) {
        self.delegate = delegate
    }
    
//    func setup(labelText: String, buttonTitle: String) {
//        titleLabel.text = labelText
//        button.setTitle(buttonTitle, for: .normal)
//    }
    
    @objc private func didTapButton() {
        delegate?.didTapButton()
    }
}

extension APODScreenView: ViewCode {
    func addSubviews() {
        addSubview(calendarButton)
        addSubview(favoriteButton)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(APODImageView)
        addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            calendarButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            calendarButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            calendarButton.heightAnchor.constraint(equalToConstant: 32),
            calendarButton.widthAnchor.constraint(equalToConstant: 32),
            
            favoriteButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            favoriteButton.heightAnchor.constraint(equalToConstant: 32),
            favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            
            dateLabel.topAnchor.constraint(equalTo: self.calendarButton.bottomAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: self.calendarButton.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.dateLabel.leadingAnchor),
            
            APODImageView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16),
            APODImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            APODImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            APODImageView.heightAnchor.constraint(equalToConstant: 400),
            
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            button.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupStyle() {
        backgroundColor = .APOD
    }
}
