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
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteAPODImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            favoriteAPODImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            favoriteAPODImage.heightAnchor.constraint(equalToConstant: 48),
            favoriteAPODImage.widthAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: favoriteAPODImage.trailingAnchor, constant: 16),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: favoriteAPODImage.trailingAnchor, constant: 16),
        ])
    }
}
