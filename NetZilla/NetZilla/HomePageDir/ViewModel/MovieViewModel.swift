//
//  MovieViewModel.swift
//  NetZilla
//
//  Created by Davit Muradyan on 26.06.25.
//

import Foundation



@MainActor
class MovieViewModel: ObservableObject {
    @Published var movies = [MovieModel]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @Published var selectedMediaType: MediaType? = nil
    
    var filteredMovies: [MovieModel] {
        guard let selectedType = selectedMediaType else {
            return movies
        }
        return movies.filter { $0.mediaType == selectedType }
    }
    
    let genres: GenreTypes = .action
    
    let service = MovieService()
    
    func fetchMovies() {
        Task {
            do {
                isLoading = true
                let fetched = try await service.loadMovies()
                self.movies = fetched
                print("Loaded movies: \(fetched.count)")
                isLoading = false
                
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
                print("Failed: \(errorMessage!)")
            }
        }
        
    }
    func checkIfContainsGenre(genre: GenreTypes, movie: MovieModel) -> Bool {
        return movie.genre.contains(where: { $0 == genre.rawValue })
    }
    
    func getCastMembers(_ movieModel: MovieModel) -> String {
        var resStr = ""
        for member in movieModel.cast {
            resStr += "\(member), "
        }
        return resStr
    }
}
