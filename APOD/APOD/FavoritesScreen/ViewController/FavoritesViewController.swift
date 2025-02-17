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
        self.viewModel.delegate(delegate: self)
        self.favoriteScreen?.configTableViewProtocols(delegate: self, dataSource: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.loadFavorites()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.apods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteAPODTableViewCell.identifier, for: indexPath) as? FavoriteAPODTableViewCell
        
        cell?.delegate(delegate: self)
        
        let favoriteItem = viewModel.apods[indexPath.row]
        
        cell?.setupHomeCell(title: favoriteItem.title ?? "",
                            date: favoriteItem.date ?? "",
                            isVideo: favoriteItem.mediaType == "video" ? true : false,
                            imageData: favoriteItem.imageData)

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
}

extension FavoritesViewController: FavoritesViewModelProtocol {
    func updateViewController() {
        DispatchQueue.main.async {
            self.favoriteScreen?.favoritesTableView.reloadData()
        }
    }
}

extension FavoritesViewController: FFavoriteAPODTableViewCellProtocol {
    func deleteFavoriteItem(in cell: FavoriteAPODTableViewCell) {
        guard let indexPath = favoriteScreen?.favoritesTableView.indexPath(for: cell) else { return }
        viewModel.deleteFavoriteAPOD(item: viewModel.apods[indexPath.row])
    }
}
