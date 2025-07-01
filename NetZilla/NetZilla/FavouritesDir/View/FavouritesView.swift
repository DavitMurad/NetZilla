//
//  FavouritesView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import SwiftUI

struct FavouritesView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple.opacity(0.4)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                HStack {
                    Text("Your Favourites")
                        .font(.largeTitle.bold())
                        .foregroundStyle(LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                    Spacer()
                }
                .padding(.horizontal)

                if movieViewModel.getLikedMovies().isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "heart.slash.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray.opacity(0.6))

                        Text("No favourites yet...")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 16) {
                            ForEach(movieViewModel.getLikedMovies()) { movie in
                                CarouselMovieView(movie: movie)
                                    .frame(width: 160, height: 260)
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                Spacer()
            }
            .padding(.top)
            .foregroundColor(.white)
        }
    }
}


