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
    
    public func extractYouTubeVideoID(from url: String) -> String? {
        let pattern = "(?:youtu\\.be/|youtube\\.com/(?:embed/|v/|watch\\?v=|.*[?&]v=))([a-zA-Z0-9_-]{11})"
        
        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            let nsString = url as NSString
            let results = regex.firstMatch(in: url, options: [], range: NSRange(location: 0, length: nsString.length))
            
            if let range = results?.range(at: 1) {
                return nsString.substring(with: range)
            }
        }
        
        return nil
    }
    
    public func loadFavorites() {
        apods = coreDataManager.fetchAPODs()
        print(apods)
    }
    
    public func saveAPOD(title: String, date: String, description: String, image: UIImage?, videoURL: String?, mediaType: String) {
        
        coreDataManager.saveAPOD(title: title,
                                 date: date,
                                 description: description,
                                 image: image,
                                 videoURL: videoURL,
                                 mediaType: mediaType)
        
        loadFavorites()
    }
}
