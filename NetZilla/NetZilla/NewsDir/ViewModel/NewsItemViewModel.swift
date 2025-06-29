//
//  NewsItemViewModel.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import Foundation
import SwiftUI

class NewsItemViewModel: ObservableObject {
    @Published var news = [NewsItemModel]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let service = MovieService()
    
    func fetchNews() {
        Task {
            do {
                isLoading = true
                let fetched = try await service.loadUpcomingMovies()
                self.news = fetched
                print("Loaded movies: \(fetched.count)")
                isLoading = false
                
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
                print("Failed: \(errorMessage!)")
            }
        }
    }
    
}
