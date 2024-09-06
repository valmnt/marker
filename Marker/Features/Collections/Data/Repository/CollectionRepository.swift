//
//  CollectionRepository.swift
//  Marker
//
//  Created by Valentin Mont on 06/09/2024.
//

import Foundation

protocol CollectionRepository {
    func getCollection(queryItems: [URLQueryItem]) async -> Result<[TVShow], Error>
}
