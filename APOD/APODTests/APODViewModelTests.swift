//
//  APODViewModelTests.swift
//  APODTests
//
//  Created by Fabricio Pujol on 18/02/25.
//

import XCTest
import CoreData
@testable import APOD

final class APODViewModelTests: XCTestCase {
    
    var viewModel: APODViewModel!
    var mockService: MockAPODViewModelService!
    var mockDelegate: MockAPODViewModelDelegate!
    var mockCoreDataManager: MockCoreDataManager!

    override func setUpWithError() throws {
        mockCoreDataManager = MockCoreDataManager()
        mockService = MockAPODViewModelService()
        viewModel = APODViewModel(service: mockService, coreDataManager: mockCoreDataManager)
        mockDelegate = MockAPODViewModelDelegate()
        viewModel.delegate(delegate: mockDelegate)
    }

    override func tearDownWithError() throws {
        mockService = nil
        viewModel = nil
        mockDelegate = nil
    }
    
    func testFetchAPODSuccess() throws {
        viewModel.fetchAPOD()
        XCTAssertTrue(mockDelegate.successCalled)
    }
    
    func testFetchAPODFailure() throws {
        mockService.result = .failure(NetworkError.invalidResponse)
        viewModel.fetchAPOD()
        
        XCTAssertTrue(mockDelegate.errorCalled)
    }
    
    func testFetchAPODByDateSuccess() throws {
        viewModel.fetchAPODByDate(date: "2025-02-16")
        XCTAssertTrue(mockDelegate.successCalled)
    }
    
    func testFetchAPODByDateFailure() throws {
        mockService.result = .failure(NetworkError.invalidResponse)
        viewModel.fetchAPODByDate(date: "2025-02-16")
        
        XCTAssertTrue(mockDelegate.errorCalled)
    }
    
    func testSaveAPOD() {
        let title = "Test APOD"
        let date = "2024-02-07"
        let description = "This is a test description."
        let image = UIImage(systemName: "star.fill")
        let videoURL: String? = nil
        let mediaType = "image"
        
        viewModel.saveAPOD(title: title,
                           date: date,
                           description: description,
                           image: image,
                           videoURL: videoURL,
                           mediaType: mediaType)
        
        XCTAssertTrue(mockCoreDataManager.saveAPODCalled, "saveAPOD não foi chamado no CoreDataManager.")
        XCTAssertEqual(mockCoreDataManager.savedAPODs[0].title, title, "Título do APOD salvo está incorreto.")
        XCTAssertEqual(mockCoreDataManager.savedAPODs[0].date, date, "Data do APOD salvo está incorreta.")
        XCTAssertEqual(mockCoreDataManager.savedAPODs[0].explanation, description, "Descrição do APOD salvo está incorreta.")
        XCTAssertEqual(mockCoreDataManager.savedAPODs[0].mediaType, mediaType, "MediaType do APOD salvo está incorreto.")
        XCTAssertNil(mockCoreDataManager.savedAPODs[0].videoURL, "Vídeo URL deveria ser nil.")
        XCTAssertNotNil(mockCoreDataManager.savedAPODs[0].imageData, "Imagem deveria estar presente.")
    }
    
    func testDeleteAPOD() {
        let title = "Test APOD"
        let date = "2024-02-07"
        let description = "This is a test description."
        let image = UIImage(systemName: "star.fill")
        let videoURL: String? = nil
        let mediaType = "image"
        
        viewModel.saveAPOD(title: title,
                           date: date,
                           description: description,
                           image: image,
                           videoURL: videoURL,
                           mediaType: mediaType)
        
        XCTAssertEqual(mockCoreDataManager.savedAPODs.count, 1)
        
        let savedAPOD = mockCoreDataManager.savedAPODs[0]
        
        viewModel.deleteAPOD(item: savedAPOD)
        
        XCTAssertEqual(mockCoreDataManager.savedAPODs.count, 0)
        XCTAssertTrue(mockCoreDataManager.deleteAPODCalled, "deleteAPODCalled não foi chamado no CoreDataManager.")
    }
    
    func testGetCurrentAPODFromFavorites() {
        let title = "Perijove 11: Passing Jupiter"
        let date = "2024-02-07"
        let description = "This is a test description."
        let image = UIImage(systemName: "star.fill")
        let videoURL: String? = nil
        let mediaType = "image"
        
        viewModel.saveAPOD(title: title,
                           date: date,
                           description: description,
                           image: image,
                           videoURL: videoURL,
                           mediaType: mediaType)
        
        viewModel.fetchAPOD()
        
        let apodFetched = viewModel.APODfetched
        
        let currentAPODFromFavorites = viewModel.getCurrentAPODFromFavorites()
        
        XCTAssertNotNil(currentAPODFromFavorites, "currentAPODFromFavorites não deveria ser nil.")
    }
}

class MockAPODViewModelDelegate: APODViewModelProtocol {
    var successCalled = false
    var errorCalled = false
    
    func success() {
        successCalled = true
    }
    
    func error(message: String) {
        errorCalled = true
    }
}

class MockAPODViewModelService: APODServiceProtocol {
    var result: Result<APODResponse, NetworkError> = .success(APODResponse(copyright: nil,
                                                                    date: "2025-02-16",
                                                                    explanation: "Here comes Jupiter. NASA's robotic spacecraft Juno is continuing on its highly elongated orbits around our Solar System's largest planet.  The featured video is from perijove 11 in early 2018, the eleventh time Juno passed near Jupiter since it arrived in mid-2016.  This time-lapse, color-enhanced movie covers about four hours and morphs between 36 JunoCam images. The video begins with Jupiter rising as Juno approaches from the north. As Juno reaches its closest view -- from about 3,500 kilometers over Jupiter's cloud tops -- the spacecraft captures the great planet in tremendous detail. Juno passes light zones and dark belts of clouds that circle the planet, as well as numerous swirling circular storms, many of which are larger than hurricanes on Earth.  After the perijove, Jupiter recedes into the distance, then displaying the unusual clouds that appear over Jupiter's south.  To get desired science data, Juno swoops so close to Jupiter that its instruments are exposed to very high levels of radiation.",
                                                                    hdurl: nil,
                                                                    mediaType: "video",
                                                                    serviceVersion: "v1",
                                                                    title: "Perijove 11: Passing Jupiter",
                                                                    url: "https://www.youtube.com/embed/OfM7VlonD5c?rel=0",
                                                                    thumb: nil))
    
    func getAPOD(completion: @escaping (Result<APOD.APODResponse, APOD.NetworkError>) -> Void) {
        completion(result)
    }
    
    func getAPODByDate(date: String, completion: @escaping (Result<APOD.APODResponse, APOD.NetworkError>) -> Void) {
        completion(result)
    }
}

class MockCoreDataManager: CoreDataManagerProtocol {
    
    var savedAPODs: [APODFavorite] = []
    
    var saveAPODCalled = false
    var fetchAPODsCalled = false
    var deleteAPODCalled = false
        
        func saveAPOD(title: String, date: String, description: String, image: UIImage?, videoURL: String?, mediaType: String) {
            let apod = APODFavorite(context: persistentContainer.viewContext)
            apod.title = title
            apod.date = date
            apod.explanation = description
            apod.imageData = image?.pngData()
            apod.videoURL = videoURL
            apod.mediaType = mediaType
            savedAPODs.append(apod)
            saveAPODCalled = true
        }
        
        func fetchAPODs() -> [APODFavorite] {
            fetchAPODsCalled = true
            return savedAPODs
        }
        
        func deleteAPOD(apod: APODFavorite) {
            savedAPODs.removeAll { $0.title == apod.title }
            deleteAPODCalled = true
        }
        
        // Criando um PersistentContainer in-memory para evitar gravação real no banco
        private lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "APODModel")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType // Usa apenas em memória
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { (_, error) in
                if let error = error {
                    fatalError("Erro ao carregar store in-memory: \(error)")
                }
            }
            return container
        }()
}
