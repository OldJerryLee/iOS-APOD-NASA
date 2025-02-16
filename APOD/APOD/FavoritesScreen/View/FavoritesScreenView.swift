//
//  FavoritesScreenView.swift
//  APOD
//
//  Created by Fabricio Pujol on 16/02/25.
//

import UIKit

final class FavoritesScreenView: UIView {

    lazy var favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteAPODTableViewCell.self, forCellReuseIdentifier: FavoriteAPODTableViewCell.identifier)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .APOD
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        return tableView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        favoritesTableView.delegate = delegate
        favoritesTableView.dataSource = dataSource
    }
}

extension FavoritesScreenView: ViewCode {
    func addSubviews() {
        addSubview(self.favoritesTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setupStyle() {
        self.backgroundColor = .APOD
    }
}
