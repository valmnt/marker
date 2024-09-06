//
//  CollectionRepositoryImpl.swift
//  Marker
//
//  Created by Valentin Mont on 06/09/2024.
//

import Foundation

class CollectionRepositoryImpl: CollectionRepository {
    
    let collectionDataSource: CollectionDataSource
    
    init(collectionDataSource: CollectionDataSource) {
        self.collectionDataSource = collectionDataSource
    }
    
    func getCollection(queryItems: [URLQueryItem]) async -> Result<[TVShow], Error> {
        do {
            let tvShows = try await collectionDataSource.getCollection(queryItems: queryItems)
            return .success(tvShows)
        } catch let error {
            return .failure(error)
        }
    }
}
