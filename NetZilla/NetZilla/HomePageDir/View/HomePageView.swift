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
    
    var body: some View {
        
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(UIColor(named: "MainColor") ?? UIColor.blue),
                    Color.purple
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
                            .font(.title)
                        
                        Spacer()
                        Image(systemName: "tv.badge.wifi")
                            .font(.title2)
                            .onTapGesture {
                                
                            }
                        Image(systemName: "arrow.down.to.line")
                            .font(.title2)
                            .onTapGesture {
                                
                            }
                    }
                    .padding()
                    
                    
                    FilterBarView()
                    
                    FeaturedMovieView()
                    
                    ForEach(GenreTypes.allCases, id: \.self) { genre in
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
                                ForEach(movieViewModel.movies) { movie in
//                                    if movie.genre.contains(where: { $0 == genre.rawValue }) {
//                                        CarouselMovieView(movie: movie)
//                                    }
                                    if movieViewModel.checkIfContainsGenre(genre: genre, movie: movie) {
                                        CarouselMovieView(movie: movie)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                 
                    
                    Spacer()
                }
                .foregroundStyle(.white)
            }
            
            
        }
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



