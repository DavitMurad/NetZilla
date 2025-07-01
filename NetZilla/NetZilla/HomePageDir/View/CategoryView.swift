//
//  CategoryView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 01.07.25.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var movieViewModel = MovieViewModel()
    @Binding var selectedGenre: GenreTypes?

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple.opacity(0.4)]),
                startPoint: .top,
                endPoint: .bottom
            ).ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Choose a Category")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .padding(.top)

                ScrollView {
                                   VStack(spacing: 16) {
                                       ForEach(GenreTypes.allCases) { genre in
                                           Button {
                                               
                                               selectedGenre = genre
                                               dismiss()
                                           } label: {
                                               HStack {
                                                   Text(genre.rawValue)
                                                       .font(.headline)
                                                       .foregroundColor(.white)
                                                   Spacer()
                                               }
                                               .padding()
                                               .background(
                                                   RoundedRectangle(cornerRadius: 10)
                                                       .fill(Color.purple.opacity(0.2))
                                               )
                                           }
                                       }
                                   }
                               }
                               .frame(maxHeight: 400)

//                Button("Disable Filter") {
//                    selectedGenre = nil
//                    dismiss()
//                }
//                .foregroundStyle(.white)
//                .font(.headline)
//                .frame(maxWidth: .infinity)
//                .frame(height: 55)
//                .background(.blue)
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .padding(.horizontal)

                Button {
                    dismiss()
                } label: {
                    Circle()
                        .fill(.secondary)
                        .frame(width: 50, height: 50)
                        .overlay {
                            Image(systemName: "xmark")
                                .font(.title2)
                        }
                }
                .padding(.bottom)
            }
            .padding()

        }
    }
}

#Preview {
    FilterBarView().environmentObject(FiltersViewModel())
        .environmentObject(MovieViewModel())
    
}
