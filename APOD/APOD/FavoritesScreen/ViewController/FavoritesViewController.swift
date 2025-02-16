//
//  FavoritesViewController.swift
//  APOD
//
//  Created by Fabricio Pujol on 16/02/25.
//

import UIKit

final class FavoritesViewController: UIViewController {

    private var favoriteScreen: FavoritesScreenView?
    private let viewModel: FavoritesViewModel = FavoritesViewModel()
    
    override func loadView() {
        self.favoriteScreen = FavoritesScreenView()
        self.view = self.favoriteScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteScreen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteAPODTableViewCell.identifier, for: indexPath) as? FavoriteAPODTableViewCell
        
        cell?.setupHomeCell(title: "Perijove 11: Passing Jupiter",
                            date: "16/02/2025")

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
