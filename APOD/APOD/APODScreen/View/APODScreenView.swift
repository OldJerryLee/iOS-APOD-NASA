//
//  View.swift
//  APOD
//
//  Created by Fabricio Pujol on 13/02/25.
//

import UIKit
import youtube_ios_player_helper

protocol APODScreenViewDelegate: AnyObject {
    func didTapCalendarButton()
    func didTapFavoriteButton()
}

class APODScreenView: UIView {
    
    private lazy var calendarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "calendar")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .apodLetters
        button.addTarget(self, action: #selector(self.didTapCalendarButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = .apodLetters
        button.addTarget(self, action: #selector(self.didTapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.text = "Template"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.text = "xx/xx/xxxx"
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .apodLetters
        label.text = "What's happening in the core of the Carina Nebula?  Stars are forming, dying, and leaving an impressive tapestry of dark dusty filaments.  The entire Carina Nebula, cataloged as NGC 3372, spans over 300 light years and lies about 8,500 light-years away in the constellation of Carina. The nebula is composed predominantly of hydrogen gas, which emits the pervasive red and orange glows seen mostly in the center of this highly detailed featured image.  The blue glow around the edges is created primarily by a trace amount of glowing oxygen. Young and massive stars located in the nebula's center expel dust when they explode in supernovas.  Eta Carinae, the most energetic star in the nebula's center, was one of the brightest stars in the sky in the 1830s, but then faded dramatically.    Your Sky Surprise: What picture did APOD feature on your birthday? (post 1995)"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private lazy var APODImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.tintColor = .apodLetters
        //imageView.isHidden = true
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
    
    private var loadingView: LoadingView?
    
    weak var delegate: APODScreenViewDelegate?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func delegate(delegate: APODScreenViewDelegate?) {
        self.delegate = delegate
    }
    
    func setup(titleText: String, dateText: String, descriptionText: String, mediaType: String) {
        titleLabel.text = titleText
        dateLabel.text = dateText
        descriptionLabel.text = descriptionText
        
        if mediaType == "video" {
            APODImageView.isHidden = true
            APODVideoView.isHidden = false
            APODVideoView.load(withVideoId: "OfM7VlonD5c", playerVars: ["playsinline":1])
        } else {
            APODImageView.isHidden = false
            APODVideoView.isHidden = true
        }
    }
    
    func setupImage(image: UIImage) {
        self.APODImageView.contentMode = .scaleAspectFill
        self.APODImageView.image = image
    }
    
    func setupImageTemplate() {
        self.APODImageView.contentMode = .center
        self.APODImageView.image = UIImage(systemName: "camera.fill")
    }
    
    @objc private func didTapCalendarButton() {
        delegate?.didTapCalendarButton()
    }
    
    @objc private func didTapFavoriteButton() {
        delegate?.didTapFavoriteButton()
    }
    
    func startPlaceholder() {
        self.titleLabel.textColor = .clear
        self.dateLabel.textColor = .clear
        self.descriptionLabel.textColor = .clear
        
        self.titleLabel.backgroundColor = .templateGray
        self.dateLabel.backgroundColor = .templateGray
        self.descriptionLabel.backgroundColor = .templateGray
    }
    
    func stopPlaceholder() {
        self.titleLabel.textColor = .apodLetters
        self.dateLabel.textColor = .apodLetters
        self.descriptionLabel.textColor = .apodLetters
        
        self.titleLabel.backgroundColor = .clear
        self.dateLabel.backgroundColor = .clear
        self.descriptionLabel.backgroundColor = .clear
    }
    
    func showLoading() {
        guard loadingView == nil else { return }

        let loading = LoadingView()
        addSubview(loading)

        loadingView = loading
    }
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
}

extension APODScreenView: ViewCode {
    func addSubviews() {
        addSubview(calendarButton)
        addSubview(favoriteButton)
        addSubview(titleLabel)
        addSubview(dateLabel)
        addSubview(APODStackView)
        addSubview(descriptionLabel)
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
            
            dateLabel.topAnchor.constraint(equalTo: self.calendarButton.bottomAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: self.calendarButton.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: self.dateLabel.leadingAnchor, constant: -8),
            
            
            
            APODStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            APODStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            APODStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            APODImageView.heightAnchor.constraint(equalToConstant: 400),
            
            APODVideoView.heightAnchor.constraint(equalToConstant: 400),
            
            descriptionLabel.topAnchor.constraint(equalTo: self.APODStackView.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    func setupStyle() {
        backgroundColor = .APOD
    }
}
