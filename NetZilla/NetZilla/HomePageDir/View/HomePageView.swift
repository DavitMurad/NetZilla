//
//  HomePageView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var filtersViewModel: FiltersViewModel
    @EnvironmentObject var movieViewModel: MovieViewModel
    
    @State var searchPopoverPresent = false
    var body: some View {
        
        ZStack {
            LinearGradient(
                   gradient: Gradient(colors: [
                       Color(red: 0.059, green: 0.047, blue: 0.161),
                       Color(red: 0.188, green: 0.169, blue: 0.388),
                       Color(red: 0.141, green: 0.141, blue: 0.243)
                   ]),
                   startPoint: .topLeading,
                   endPoint: .bottomTrailing
               )

            .ignoresSafeArea(.container, edges: [.top]).ignoresSafeArea(.container, edges: [.top])
            ScrollView {
                VStack(spacing: 8) {
                    HStack(spacing: 16) {
                        Text("For You")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.largeTitle.bold())
                              .foregroundStyle(LinearGradient(
                                  colors: [.purple, .blue],
                                  startPoint: .leading,
                                  endPoint: .trailing
                              ))
                        
                        Spacer()
                        Image(systemName: "tv.badge.wifi")
                            .font(.title2)
                            .onTapGesture {
                                
                            }
                        Image(systemName: "arrow.down.to.line")
                            .font(.title2)
                            .onTapGesture {
                                
                            }
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .onTapGesture {
                                searchPopoverPresent.toggle()
                            }
                    }
                    .padding()
                    
                    
                    FilterBarView()
                    
                    FeaturedMovieView()
                    
                    if movieViewModel.selectedGenre == nil {
                        ForEach(GenreTypes.allCases, id: \.self) { genre in
                            let genreMovies = movieViewModel.filteredMovies.filter { movie in
                                movieViewModel.checkIfContainsGenre(genre: genre, movie: movie)
                            }
                            
                            if !genreMovies.isEmpty {
                                Section() {
                                    HStack {
                                        Text(genre.rawValue)
                                            .font(.title2.bold())
                                            .padding(.horizontal)
                                            .foregroundColor(.white)
                                            .overlay(
                                                Rectangle()
                                                    .frame(height: 2)
                                                    .foregroundColor(.purple)
                                                    .offset(y: 12),
                                                alignment: .bottomLeading
                                            )
                                        Spacer()
                                    }
                                    .padding()
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 16) {
                                        ForEach(genreMovies) { movie in
                                            CarouselMovieView(movie: movie)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    } else {
                        
                        if let selectedGenre = movieViewModel.selectedGenre {
                            let genreMovies = movieViewModel.filteredMovies.filter { movie in
                                movieViewModel.checkIfContainsGenre(genre: selectedGenre, movie: movie)
                            }
                            
                            if !genreMovies.isEmpty {
                                Section() {
                                    HStack {
                                        Text(selectedGenre.rawValue)
                                            .font(.title2.bold())
                                            .padding(.horizontal)
                                            .foregroundColor(.white)
                                            .overlay(
                                                Rectangle()
                                                    .frame(height: 2)
                                                    .foregroundColor(.purple)
                                                    .offset(y: 12),
                                                alignment: .bottomLeading
                                            )
                                        Spacer()
                                    }
                                    .padding()
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 16) {
                                        ForEach(genreMovies) { movie in
                                            CarouselMovieView(movie: movie)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            } else {
                                // Show message when no movies found for selected genre
                                Text("No movies found for \(selectedGenre.rawValue)")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                    }
                 
                    
                    Spacer()
                }
                .foregroundStyle(.white)
            }
            
            
        }
        .popover(isPresented: $searchPopoverPresent, content: {
            SearchView()
        })
        .onAppear {
            if movieViewModel.movies.isEmpty {
                movieViewModel.fetchMovies()
            }
        }
    }
}

#Preview {
    HomePageView()
        .environmentObject(FiltersViewModel())
        .environmentObject(MovieViewModel())
        
}



// Next up like page, category filter
// Finishing touches - "the additional func", playing music?, theme
