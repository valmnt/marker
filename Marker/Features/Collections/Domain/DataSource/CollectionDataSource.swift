//
//  CollectionDataSource.swift
//  Marker
//
//  Created by Valentin Mont on 06/09/2024.
//

import Foundation

protocol CollectionDataSource {
    func getCollection(queryItems: [URLQueryItem]) async throws -> [TVShow]
}
