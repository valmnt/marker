//
//  GetDramaCollectionUseCase.swift
//  Marker
//
//  Created by Valentin Mont on 08/09/2024.
//

import Foundation

class GetDramaCollectionUseCase: CollectionUseCase {
    
    let repository: CollectionRepository
    
    init(repository: CollectionRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[TVShow], Error> {
        let queryItems = [
            URLQueryItem(name: "with_original_language", value: "en"),
            URLQueryItem(name: "with_genres", value:"\(Genre.drama.rawValue)"),
            URLQueryItem(name: "without_genres", value: "\(Genre.comedy.rawValue), \(Genre.reality.rawValue), \(Genre.actionAdventure.rawValue)"),
        ]
        return await repository.getCollection(queryItems: queryItems)
    }
}
