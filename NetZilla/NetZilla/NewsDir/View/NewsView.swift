//
//  SearchView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import SwiftUI

struct NewsView: View {
    @ObservedObject var newsViewModel = NewsItemViewModel()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                Text("News")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle.bold())
                      .foregroundStyle(LinearGradient(
                          colors: [.purple, .blue],
                          startPoint: .leading,
                          endPoint: .trailing
                      ))
                
                      .padding()
                ScrollView {
                    LazyVStack(spacing: 30) {
                        ForEach(newsViewModel.news) { newMovie in
                            NewsItemView(newModel: newMovie)
                        }
                    }
                    .padding(.top, 20)
                }
            }
        }
        .onAppear {
            newsViewModel.fetchNews()
        }
    }
}

struct NewsItemView: View {
    let newModel: NewsItemModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(newModel.posterImageName)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipped()
                .cornerRadius(10)

            Text(newModel.title)
                .font(.title3)
                .bold()
                .foregroundStyle(.white)

            Text("Coming in \(newModel.releaseDate)")
                .font(.caption)
                .foregroundStyle(.gray)

            Text(newModel.description)
                .font(.caption)
                .foregroundStyle(.gray)
                .fixedSize(horizontal: false, vertical: true)

            Button(action: {
                
            }) {
                HStack {
                    Image(systemName: "bell")
                    Text("Remind Me")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(10)
            }
        }
        .padding()
        .background( LinearGradient(
            gradient: Gradient(colors: [Color.secondary, Color.purple.opacity(0.4)]),
            startPoint: .top,
            endPoint: .bottom
        ))
        .cornerRadius(15)
        .foregroundColor(.white)
        .padding(.horizontal)
    }
}

#Preview {
    NewsView()
}
