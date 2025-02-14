//
//  ViewCode.swift
//  APOD
//
//  Created by Fabricio Pujol on 13/02/25.
//

import Foundation

protocol ViewCode {
    func addSubviews()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func setup() {
        addSubviews()
        setupConstraints()
        setupStyle()
    }
}
