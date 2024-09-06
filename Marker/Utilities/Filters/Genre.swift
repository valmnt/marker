//
//  Genre.swift
//  Marker
//
//  Created by Valentin Mont on 08/09/2024.
//

import Foundation

enum Genre: Int, CaseIterable {
    case actionAdventure = 10759
    case comedy = 35
    case reality = 10764
    case drama = 18
    
    static func from(rawValue: Int) -> Genre? {
        return self.init(rawValue: rawValue)
    }
    
    func string() -> String {
        switch self {
        case .actionAdventure:
            return "Action & Adventure"
        case .comedy:
            return "Comedy"
        case .reality:
            return "Reality"
        case .drama:
            return "Drama"
        }
    }
}
