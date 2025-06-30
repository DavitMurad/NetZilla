//
//  FeaturedMovieView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 27.06.25.
//

import SwiftUI

struct FeaturedMovieView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State private var featuredMovie: MovieModel?
    @State private var isFullScreenPresented = false
    var body: some View {
        VStack(spacing: 0) {
            if let movie = featuredMovie {
                Image(movie.posterImageName)
                    .resizable()
                    .frame(height: 500)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding()
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.black.opacity(0.5))
                                .padding()
                                .onTapGesture {
                                    isFullScreenPresented.toggle()
                                }
                            
                            
                            VStack {
                                Spacer()
                                HStack(spacing: 20) {
                                    movieInteractionButton(imageName: "play.fill", title: "Play") {
                                        isFullScreenPresented.toggle()
                                    }
                                    
                                    movieInteractionButton(imageName: movieViewModel.isLiked(featuredMovie!) ? "hand.thumbsup.fill" : "hand.thumbsup", title: "Like") {
                                        withAnimation {
                                            movieViewModel.toggleLike(for: featuredMovie!)


                                        }
                                    }
                                }
                                .offset(x: 0, y: -30)
                            }
                        }
                    }
            } else {
                ProgressView("Roaaaading...")
            }
        }
        .fullScreenCover(isPresented: $isFullScreenPresented,  content: {
            if let featuredMovie = featuredMovie {
                MovieDetailsView(movie: featuredMovie)
            }
           
        })
        
        .onAppear {
            if movieViewModel.movies.isEmpty {
                movieViewModel.fetchMovies()
            }
        }
        
        .onChange(of: movieViewModel.movies) { oldValue, newValue in
            if !newValue.isEmpty && featuredMovie == nil {
                featuredMovie = newValue.randomElement()
            }
        }
    }
    
    func movieInteractionButton(imageName: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: imageName)
                Text(title)
            }
            .font(.callout)
            .fontWeight(.semibold)
            .padding()
            .padding(.horizontal, 20)
            .foregroundStyle(.black)
            .frame(height: 45)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    FeaturedMovieView()
        .environmentObject(MovieViewModel())
        .background(
            Color.blue
        )
}
