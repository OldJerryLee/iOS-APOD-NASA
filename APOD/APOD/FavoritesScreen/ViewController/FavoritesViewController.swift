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
        let favoriteAPODItem = self.viewModel.apods[indexPath.row]
        let viewModel = FavoriteAPODViewModel(favoriteAPODItem: favoriteAPODItem)
        let viewController = FavoriteAPODViewController(viewModel: viewModel)
        
        self.present(viewController, animated: true)
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
        
        let alertController: UIAlertController = UIAlertController(title: "Deletar", message: "Gostaria de deletar esse APOD?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { [weak self] _ in
            guard let indexPath = self?.favoriteScreen?.favoritesTableView.indexPath(for: cell) else { return }
            guard let favorite = self?.viewModel.apods[indexPath.row] else { return }
            self?.viewModel.deleteFavoriteAPOD(item: favorite)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
