//
//  LoadingView.swift
//  APOD
//
//  Created by Fabricio Pujol on 15/02/25.
//

import UIKit

class LoadingView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        return indicator
    }()

    init() {
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        isUserInteractionEnabled = true
        
        addSubview(activityIndicator)
        activityIndicator.center = center
    }
}
