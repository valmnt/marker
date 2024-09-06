//
//  CollectionsViewModel.swift
//  Marker
//
//  Created by Valentin Mont on 06/09/2024.
//

import Foundation

class CollectionsViewModel {
    
    var collections = [(key: Int, data: [TVShow])]()
    
    private var tasks = [(genre: Genre, usecase: CollectionUseCase)]()
    
    init() {
        let collectionDataSource: CollectionDataSource = RemoteCollectionDataSource()
        let collectionRepository: CollectionRepository = CollectionRepositoryImpl(collectionDataSource: collectionDataSource)
        
        tasks.append((Genre.actionAdventure, GetActionAdventureCollectionUseCase(repository: collectionRepository)))
        tasks.append((Genre.comedy, GetComedyCollectionUseCase(repository: collectionRepository)))
        tasks.append((Genre.reality, GetRealityCollectionUseCase(repository: collectionRepository)))
        tasks.append((Genre.drama, GetDramaCollectionUseCase(repository: collectionRepository)))
    }
    
    func getCollections(completionHandler: @escaping (() -> Void)) {
        Task {
            for task in tasks {
                await process(key: task.genre.rawValue, result: task.usecase.execute())
            }
            completionHandler()
        }
    }
    
    private func process(key: Int, result: Result<[TVShow], any Error>?) {
        switch result {
        case .success(let data):
            if (!data.isEmpty) {
                collections.append((key, data))
            }
            break
        case .failure(_):
            break
        case .none:
            break
        }
    }
}
