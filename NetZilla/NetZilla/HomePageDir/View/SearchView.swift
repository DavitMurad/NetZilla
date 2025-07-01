//
//  SearchView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 30.06.25.
//

import SwiftUI


struct SearchView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State private var textFieldtxt = ""
    @FocusState private var isTextFieldFocused: Bool


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
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple.opacity(0.4)]),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()
            VStack(alignment: .center) {
                TextField("Search movies or shows", text: $textFieldtxt)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(.secondary)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .foregroundStyle(.white)
                    .focused($isTextFieldFocused)

                    

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
        .onAppear {
            isTextFieldFocused = true
        }
    }
}

#Preview {
    SearchView()
}
