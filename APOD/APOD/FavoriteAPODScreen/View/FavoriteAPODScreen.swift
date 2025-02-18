//
//  FavoriteAPODScreen.swift
//  APOD
//
//  Created by Fabricio Pujol on 17/02/25.
//

import UIKit
import youtube_ios_player_helper

class FavoriteAPODScreen: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var APODImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var APODVideoView: YTPlayerView = {
        let playerView = YTPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.backgroundColor = .black
        playerView.isHidden = true
        return playerView
    }()
    
    private lazy var APODStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [APODImageView, APODVideoView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(titleText: String, dateText: String, descriptionText: String, mediaType: String, videoId: String?, imageData: Data?) {
        titleLabel.text = titleText
        dateLabel.text = dateText
        descriptionLabel.text = descriptionText
        
        if mediaType == "video" {
            APODImageView.isHidden = true
            APODVideoView.isHidden = false
            APODVideoView.load(withVideoId: videoId ?? "", playerVars: ["playsinline":1])
        } else {
            if let imageData = imageData {
                APODImageView.image = UIImage(data: imageData)
            }
            APODImageView.isHidden = false
            APODVideoView.isHidden = true
        }
    }
    
    func setupImage(image: UIImage) {
        self.APODImageView.contentMode = .scaleAspectFill
        self.APODImageView.image = image
    }
}

extension FavoriteAPODScreen: ViewCode {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(APODStackView)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.dateLabel.leadingAnchor, constant: -8),
            
            APODStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            APODStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            APODStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            APODImageView.heightAnchor.constraint(equalToConstant: 400),
            
            APODVideoView.heightAnchor.constraint(equalToConstant: 400),
            
            descriptionLabel.topAnchor.constraint(equalTo: self.APODStackView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    func setupStyle() {
        backgroundColor = .APOD
    }
}
