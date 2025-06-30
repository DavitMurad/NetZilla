//
//  MovieDetailsView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 27.06.25.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    @Environment(\.dismiss) private var dismiss
    @State var isSoundPlaying = false
    @State var isPlayingRoar = false


    let movie: MovieModel
    var castMembers = ""
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            ScrollView {
                
        
            VStack(spacing: 15) {
                Image(movie.posterImageName)
                    .resizable()
                           .scaledToFill()
                           .frame(height: 250)
                           .clipped()
                    .overlay(alignment: .topTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title3)
                        }
                        
                        .padding()
                        .frame(alignment: .topTrailing)
                        .background(
                            Circle()
                                .fill(.black.opacity(0.5))
                                .frame(width: 35, height: 35)
                        )
                        
                    }
                    .overlay {
                        Button {
                            let impact = UIImpactFeedbackGenerator(style: .heavy)
                            impact.impactOccurred()

                            isPlayingRoar = true

                            AudioManager.shared.playSound(named: "godzilla_roar") {
                                isPlayingRoar = false
                            }

                        } label: {
                            Image(systemName: "play.circle")
                                .font(.system(size: 50))
                                .frame(width: 300, height: 300)
                                .foregroundStyle(.lightGray)
                                .scaleEffect(isPlayingRoar ? 1.1 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: isPlayingRoar)
                        }
                    }
                
                HStack() {
                    Text(movie.title)
                        .font(.headline)
                    
                        .padding(.horizontal)
                    Spacer()
                }
                
                HStack(spacing: 0) {
                    Group {
                        Text(movie.releaseDate.prefix(4))
                        Text("15")
                            .background(
                                Circle()
                                    .stroke(.white, lineWidth: 5)
                                    .fill(.pink)
                                    .frame(width: 30, height: 30)
                            )
                        Text(movie.runtime)
                    }
                    .font(.callout)
                    
                    .padding(.horizontal)
                    Spacer()
                    
                    
                }
                
                HStack {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 30, height: 30)
                        .overlay() {
                            Text("Top 10")
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .minimumScaleFactor(0.5)
                        }
                    Text("In MonsterVerse Universe.")
                    Spacer()
                }
                .padding(.horizontal)
                
                setUpInteractionImages(imageName: "play.fill", title: "Play", backColor: .white, fontColor: .black) {
                    AudioManager.shared.playSound(named: "godzilla_roar") {
                        isPlayingRoar = false
                    }
                }
                setUpInteractionImages(imageName: "arrow.down.to.line", title: "Download", backColor: .secondary, fontColor: .white) {
                    print("asd")
                }
                
                HStack {
                    Text(movie.description)
                        .font(.subheadline)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Director: \(movie.director)")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                   
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Text("Cast: \(movieViewModel.getCastMembers(movie))")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                   
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Button("more...") {
                        
                    }
                    .foregroundStyle(.secondary)
                    .font(.caption)
                    Spacer()
                }
                .offset(x: 0, y: -15)
                .padding(.horizontal)
                
                HStack(spacing: 30) {
                    Button {
                        movieViewModel.toggleLike(for: movie)
                    } label: {
                        VStack {
                            Image(systemName: movieViewModel.isLiked(movie) ? "hand.thumbsup.fill" :  "hand.thumbsup")
                                .font(.title2)
                               Text("Like")
                                .font(.caption)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        VStack {
                            Image(systemName: "paperplane")
                                .font(.title2)
                               Text("Share")
                                .font(.caption)
                        }
                       
                      
                    }
                   
                }
                .padding(.horizontal)
              

                
                Spacer()
            }
            .foregroundStyle(.white)
        }
            
        }
        
    }
    
    func setUpInteractionImages(imageName: String, title: String, backColor: Color, fontColor: Color, action: @escaping () -> Void) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(backColor)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .overlay {
                HStack {
                    Group {
                        Image(systemName: imageName)
                        
                        Text(title)
                    }
                    .foregroundStyle(fontColor)
                    .font(.headline)
                }
            }
            .padding(.horizontal)
    }
}

//#Preview {
//    MovieDetailsView(movie: )
//}
