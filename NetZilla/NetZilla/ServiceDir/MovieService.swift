//
//  Untitled.swift
//  NetZilla
//
//  Created by Davit Muradyan on 26.06.25.
//

import Foundation

class MovieService {
    func loadMovies() async throws -> [MovieModel] {
        guard let url = Bundle.main.url(forResource: "MovieData", withExtension: "json") else {
            throw URLError(.badURL)
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        
        return try decoder.decode([MovieModel].self, from: data)
    }
}
