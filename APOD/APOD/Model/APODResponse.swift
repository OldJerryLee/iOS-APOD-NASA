//
//  APODResponse.swift
//  APOD
//
//  Created by Fabricio Pujol on 13/02/25.
//

import Foundation

struct APODResponse: Codable {
    let copyright, date, explanation: String
    let hdurl: String
    let mediaType, serviceVersion, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
