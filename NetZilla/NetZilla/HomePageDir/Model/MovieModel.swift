//
//  FilmModel.swift
//  NetZilla
//
//  Created by Davit Muradyan on 26.06.25.
//

import Foundation

enum GenreTypes: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case action = "Action"
    case sci_fi = "Sci-Fi"
    case monster = "Monster"
    case advendutre = "Adventure"
    case drama = "Drama"
}

struct MovieModel: Identifiable, Equatable, Codable {
    let id: Int
    let title: String
    let description: String
    let releaseDate: String
    let rating: Double
    let genre: [String]
    let posterImageName: String
    let backdropURL: String
    var isFavorite: Bool
    let runtime: Int
    let director: String
    let cast: [String]
}
