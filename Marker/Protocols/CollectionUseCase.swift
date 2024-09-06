//
//  UseCase.swift
//  Marker
//
//  Created by Valentin Mont on 13/09/2024.
//

import Foundation

protocol CollectionUseCase {
    func execute() async -> Result<[TVShow], Error>
}
