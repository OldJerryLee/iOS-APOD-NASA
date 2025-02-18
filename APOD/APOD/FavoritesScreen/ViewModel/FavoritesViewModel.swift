//
//  FavoritesViewModel.swift
//  APOD
//
//  Created by Fabricio Pujol on 16/02/25.
//

import Foundation

protocol FavoritesViewModelProtocol: AnyObject {
    func updateViewController()
}

final class FavoritesViewModel {
    
    private let coreDataManager = CoreDataManager.shared
    private weak var delegate: FavoritesViewModelProtocol?
    
    private(set) var apods: [APODFavorite] = []
    
    public func delegate(delegate: FavoritesViewModelProtocol?) {
        self.delegate = delegate
    }
    
    func loadFavorites() {
        apods = coreDataManager.fetchAPODs()
        delegate?.updateViewController()
    }
    
    func deleteFavoriteAPOD(item: APODFavorite) {
        coreDataManager.deleteAPOD(apod: item)
        loadFavorites()
    }
    
    public func getFormatedDate(dateString: String) -> String {
        return dateString.toFormattedDate()
    }
}
