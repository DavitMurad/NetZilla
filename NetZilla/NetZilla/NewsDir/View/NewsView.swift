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
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple.opacity(0.4)]),
                startPoint: .top,
                endPoint: .bottom
            )

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

#Preview {
    NewsView()
}
