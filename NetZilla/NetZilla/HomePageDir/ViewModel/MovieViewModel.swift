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
    
    @Published var selectedGenre: GenreTypes? = nil
    
    private let likedManager = LikedMoviesManager()
    
    var filteredMovies: [MovieModel] {
        var result = movies
        
        if let type = selectedMediaType {
            result = result.filter { $0.mediaType == type }
        }

        if let genre = selectedGenre {
            result = result.filter { $0.genre.contains(genre.rawValue) }
        }
        
        return result
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
    
    func toggleLike(for movie: MovieModel) {
            likedManager.toggleLike(id: movie.id)
            objectWillChange.send()
        }

        func isLiked(_ movie: MovieModel) -> Bool {
            likedManager.isLiked(movie.id)
        }

        func getLikedMovies() -> [MovieModel] {
            movies.filter { likedManager.isLiked($0.id) }
        }
    
    
    func filterByGenre(_ genre: GenreTypes) -> [MovieModel] {
        var filteredMovies: [MovieModel] = []
        for movie in movies {
            if movie.genre.contains(genre.rawValue) {
                filteredMovies.append(movie)
            }
        }
        return filteredMovies
    }
}
