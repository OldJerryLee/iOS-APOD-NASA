//
//  CoreDataManager.swift
//  APOD
//
//  Created by Fabricio Pujol on 17/02/25.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "APODFavorite") // Nome do modelo CoreData
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Erro ao carregar Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Salvar APOD
    func saveAPOD(title: String, date: String, description: String, image: UIImage?, videoURL: String?, mediaType: String) {
        let apod = APODFavorite(context: context)
        apod.title = title
        apod.date = date
        apod.explanation = description
        apod.imageData = image?.jpegData(compressionQuality: 0.8)
        apod.videoURL = videoURL
        apod.mediaType = mediaType
        saveContext()
    }

    // MARK: - Buscar APODs salvos
    func fetchAPODs() -> [APODFavorite] {
        let request: NSFetchRequest<APODFavorite> = APODFavorite.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Erro ao buscar APODs: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Deletar APOD
    func deleteAPOD(apod: APODFavorite) {
        context.delete(apod)
        saveContext()
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Erro ao salvar no Core Data: \(error.localizedDescription)")
        }
    }
}
