//
//  FavoritesTableViewCellScreen.swift
//  APOD
//
//  Created by Fabricio Pujol on 16/02/25.
//

import UIKit

final class FavoritesTableViewCellScreen: UIView {
    
    lazy var favoriteAPODImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "camera")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .apodLetters
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .apodLetters
        image.layer.cornerRadius = 8
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "trash.fill")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .apodLetters
        button.addTarget(self, action: #selector(self.didTapDeleteButton), for: .touchUpInside)
        return button
    }()
    
    lazy var mediaTypeImage:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "camera")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .apodLetters
        image.contentMode = .center
        image.isHidden = true
        return image
    }()
    
    var onDeleteFavorite: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configSuperView()
        setupConstraints()
        self.backgroundColor = .APOD
    }
    
    private func configSuperView() {
        addSubview(favoriteAPODImage)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(deleteButton)
        addSubview(mediaTypeImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteAPODImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            favoriteAPODImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            favoriteAPODImage.heightAnchor.constraint(equalToConstant: 100),
            favoriteAPODImage.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: favoriteAPODImage.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: favoriteAPODImage.trailingAnchor, constant: 16),
            
            mediaTypeImage.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            mediaTypeImage.leadingAnchor.constraint(equalTo: favoriteAPODImage.trailingAnchor, constant: 16),
            
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    @objc private func didTapDeleteButton() {
        onDeleteFavorite?()
    }
}
