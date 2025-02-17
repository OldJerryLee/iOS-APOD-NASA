//
//  FavoriteAPODTableViewCell.swift
//  APOD
//
//  Created by Fabricio Pujol on 16/02/25.
//

import UIKit

protocol FFavoriteAPODTableViewCellProtocol: AnyObject {
    func deleteFavoriteItem(in cell: FavoriteAPODTableViewCell)
}

final class FavoriteAPODTableViewCell: UITableViewCell {
    
    static let identifier: String = "FavoriteAPODTableViewCell"
    private weak var delegate: FFavoriteAPODTableViewCellProtocol?

    lazy var screen: FavoritesTableViewCellScreen = {
        let view = FavoritesTableViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubView()
        setupConstraints()
        
        screen.onDeleteFavorite = { [weak self] in
            guard let self = self else { return }
            self.delegate?.deleteFavoriteItem(in: self)
        }
    }
    
    public func delegate(delegate: FFavoriteAPODTableViewCellProtocol?) {
        self.delegate = delegate
    }
    
    private func addSubView() {
        contentView.addSubview(screen)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func setupHomeCell(title: String, date: String, isVideo: Bool, imageData: Data?) {
        screen.titleLabel.text = title
        screen.dateLabel.text = date
        
        if isVideo {
            screen.mediaTypeImage.image = UIImage(systemName: "video.fill")?.withRenderingMode(.alwaysTemplate)
        } else {
            screen.mediaTypeImage.image = UIImage(systemName: "camera.fill")?.withRenderingMode(.alwaysTemplate)
        }
        
        screen.mediaTypeImage.isHidden = false
        
        if let image = imageData {
            screen.favoriteAPODImage.image = UIImage(data: image)
        }
    }
}
