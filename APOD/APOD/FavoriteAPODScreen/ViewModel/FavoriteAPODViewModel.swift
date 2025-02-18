//
//  FavoriteAPODViewModel.swift
//  APOD
//
//  Created by Fabricio Pujol on 17/02/25.
//

import Foundation

final class FavoriteAPODViewModel {
    private var favoriteAPODItem: APODFavorite
    
    init(favoriteAPODItem: APODFavorite) {
        self.favoriteAPODItem = favoriteAPODItem
    }
    
    public func getFavoriteAPODItem() -> APODFavorite {
        return favoriteAPODItem
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
    
    public func getFormatedDate(dateString: String) -> String {
        return dateString.toFormattedDate()
    }
}
