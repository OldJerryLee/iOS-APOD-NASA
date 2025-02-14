//
//  RequestBuilder.swift
//  APOD
//
//  Created by Fabricio Pujol on 13/02/25.
//

import Foundation

protocol RequestBuilder {
    func buildRequest(with endpoint: Endpoint, url: URL) -> URLRequest
}
