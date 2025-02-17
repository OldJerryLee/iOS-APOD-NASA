//
//  APODViewModel.swift
//  APOD
//
//  Created by Fabricio Pujol on 14/02/25.
//

import UIKit

protocol APODViewModelProtocol: AnyObject {
    func success()
    func error(message: String)
}

final class APODViewModel {
    
    private var service: APODService = APODService()
    private let coreDataManager = CoreDataManager.shared
    private weak var delegate: APODViewModelProtocol?
    
    public var APODfetched: APODResponse?
    private(set) var apods: [APODFavorite] = []
    
    public func delegate(delegate: APODViewModelProtocol?) {
        self.delegate = delegate
    }
    
    public func fetchAPOD() {
        service.getAPOD() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                APODfetched = response
                delegate?.success()
            case .failure(let failure):
                delegate?.error(message: failure.errorDescription ?? "")
            }
        }
    }
    
    public func fetchAPODByDate(date: String) {
        service.getAPODByDate(date: date) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                APODfetched = response
                delegate?.success()
            case .failure(let failure):
                delegate?.error(message: failure.errorDescription ?? "")
            }
        }
    }
    
    public func getFormatedDate(dateString: String) -> String {
        return dateString.toFormattedDate()
    }
    
    func loadFavorites() {
        apods = coreDataManager.fetchAPODs()
        print(apods)
    }
    
    func saveAPOD(title: String, date: String, description: String, image: UIImage?, videoURL: String?, mediaType: String) {
        
        coreDataManager.saveAPOD(title: title,
                                 date: date,
                                 description: description,
                                 image: mediaType == "video" ? nil : image,
                                 videoURL: videoURL,
                                 mediaType: mediaType)
        
        loadFavorites()
    }
}
