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
                    Color(.black),
                    Color.black
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
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .onTapGesture {
                                searchPopoverPresent.toggle()
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
                                ForEach(movieViewModel.filteredMovies) { movie in
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
        .popover(isPresented: $searchPopoverPresent, content: {
            SearchView()
        })
        .onAppear {
            if movieViewModel.movies.isEmpty {
                movieViewModel.fetchMovies()
            }
        }
//        .onChange(of: movieViewModel.movies) { newMovies in
//            print("Updated: \(newMovies.count) items")
//        }
    }
}




struct SearchView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State private var textFieldtxt = ""

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var filteredMovies: [MovieModel] {
        if textFieldtxt.isEmpty {
            return []
        }
        return movieViewModel.movies.filter {
            $0.title.localizedCaseInsensitiveContains(textFieldtxt)
        }
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .center) {
                TextField("Search movies or shows", text: $textFieldtxt)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .foregroundStyle(.white)

                if textFieldtxt.isEmpty {
                    Text("“Let them fight.” – Dr. Serizawa")
                        .font(.callout.italic())
                        .foregroundColor(.gray)
                        .padding(.top, 100)
                }
                else if filteredMovies.isEmpty {
                    Text("No results found")
                        .foregroundColor(.gray)
                        .padding(.top, 50)
                }
                else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 24) {
                            ForEach(filteredMovies) { movie in
                                CarouselMovieView(movie: movie)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }

                Spacer()
            }
            .padding()
            .foregroundStyle(.white)
        }
    }
}



#Preview {
    HomePageView()
        .environmentObject(FiltersViewModel())
        .environmentObject(MovieViewModel())
        
}



