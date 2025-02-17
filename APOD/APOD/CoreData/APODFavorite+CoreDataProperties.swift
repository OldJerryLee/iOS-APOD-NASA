//
//  APODFavorite+CoreDataProperties.swift
//  
//
//  Created by Fabricio Pujol on 17/02/25.
//
//

import Foundation
import CoreData


extension APODFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<APODFavorite> {
        return NSFetchRequest<APODFavorite>(entityName: "APODFavorite")
    }

    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var explanation: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var videoURL: String?
    @NSManaged public var mediaType: String?

}
