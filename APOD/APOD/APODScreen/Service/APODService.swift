//
//  APODService.swift
//  APOD
//
//  Created by Fabricio Pujol on 14/02/25.
//

import Foundation

final class APODService {
    func getAPOD(completion: @escaping (Result<APODResponse,NetworkError>) -> Void) {
        let urlString: String = "https://api.nasa.gov/planetary/apod?api_key=0LkAF0pB3OzKR35aMoxV6u1n61keu1hgY231CH4L"
        let endpoint = Endpoint(url: urlString,
                                method: .get)
        
        ServiceManager.shared.request(with: endpoint, decodeType: APODResponse.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getAPODByDate(date: String, completion: @escaping (Result<APODResponse,NetworkError>) -> Void) {
        let urlString: String = "https://api.nasa.gov/planetary/apod?api_key=0LkAF0pB3OzKR35aMoxV6u1n61keu1hgY231CH4L&date=\(date)"
        let endpoint = Endpoint(url: urlString,
                                method: .get)
        
        ServiceManager.shared.request(with: endpoint, decodeType: APODResponse.self) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
