//
//  NetworkLayer.swift
//  APOD
//
//  Created by Fabricio Pujol on 13/02/25.
//

import Foundation

protocol NetworkLayer {
    func request<T>(with endpoint: Endpoint, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable
}
