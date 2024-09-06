//
//  TVShow.swift
//  Marker
//
//  Created by Valentin Mont on 08/09/2024.
//

import Foundation

struct TVShow: Decodable {
    let originalName: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case posterPath = "poster_path"
    }
}
