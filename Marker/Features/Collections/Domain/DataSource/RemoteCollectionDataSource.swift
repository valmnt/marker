//
//  RemoteCollectionDataSource.swift
//  Marker
//
//  Created by Valentin Mont on 06/09/2024.
//

import Foundation

class RemoteCollectionDataSource: CollectionDataSource {
    
    private let url = URL(string: NetworkConstants.baseUrl +
                          NetworkConstants.version +
                          NetworkConstants.Paths.discover +
                          NetworkConstants.Categories.tv)!
    private var apiKey: String? = Bundle.main.infoDictionary?["ApiKey"] as? String
    
    func getCollection(queryItems: [URLQueryItem]) async throws -> [TVShow] {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let apiKey = apiKey else {
            throw APICallerErrors.internalServer
        }
        
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
        
        guard let url = components.url else {
            throw APICallerErrors.internalServer
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.GET.rawValue
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer \(apiKey)"
        ]
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedResult = try JSONDecoder().decode(Response.self, from: data)
            let tvShows = Array(decodedResult.results.prefix(8))
            NSLog("%@", tvShows)
            return tvShows
        } catch let error {
            NSLog("%@", error.localizedDescription)
            throw error
        }
    }
}

struct Response: Decodable {
    let results: [TVShow]
}
