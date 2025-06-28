//
//  CarouselMovieView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 27.06.25.
//

import SwiftUI

struct CarouselMovieView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State var isFullScreenPresented: Bool = false
    let movie: MovieModel
    
    var body: some View {
        VStack {
            Image(movie.posterImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 225)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(movie.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(width: 120, height: 50, alignment: .top)
         
        }
        .onTapGesture {
            isFullScreenPresented.toggle()
        }
        .fullScreenCover(isPresented: $isFullScreenPresented) {
            Text(movie.title)
        }
    }
}

//#Preview {
//    CarouselMovieView()
//        .environmentObject(MovieViewModel())
//}
