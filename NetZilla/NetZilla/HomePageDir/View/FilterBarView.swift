//
//  FilterBarView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import SwiftUI

struct FilterBarView: View {
    
    @EnvironmentObject var filterViewModel: FiltersViewModel
    @State var selectedFilter: FilterModel? = nil
    @EnvironmentObject var movieViewModel: MovieViewModel
    @State var isFullScreenPresent = false
    @State var selectedGenre: GenreTypes? = nil
    
    var onXPressed:(() -> Void)? = nil
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.gray)
                        .onTapGesture {
                            movieViewModel.selectedMediaType = nil
                            movieViewModel.selectedGenre = nil 
                            selectedFilter = nil
                            selectedGenre = nil
                            
                            if let index = filterViewModel.filters.firstIndex(where: { GenreTypes.allCases.map(\.rawValue).contains($0.title) }) {
                                   filterViewModel.filters[index].title = "Categories"
                               }
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                }
                
                
                ForEach($filterViewModel.filters, id: \.self) { $filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        FilterCell(title: filter.title, isSelected: selectedFilter == filter, isDropDown: filter.isDropDown)
                            .background(.black.opacity(0.001))
                            .onTapGesture {
                                if filter.title == "Categories" {
                                    isFullScreenPresent.toggle()
                                    
                                } else {
                                    selectedFilter = filter
                                    movieViewModel.selectedMediaType = determineMediaType()
                                }
                                
                            }
                            .padding(.leading, leadPadding(selectedFilter: selectedFilter, filter: filter))
                    }
                }
                
                
            }
        }
        .padding(.vertical, 4)
        
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
        .fullScreenCover(isPresented: $isFullScreenPresent) {
            CategoryView(selectedGenre: $selectedGenre)
        }
        
        .onChange(of: selectedGenre) { oldValue, newValue in
            guard let genre = newValue else { return }
            movieViewModel.selectedGenre = genre
            
            if let index = filterViewModel.filters.firstIndex(where: { $0.title == "Categories" }) {
                filterViewModel.filters[index].title = genre.rawValue
                selectedFilter = filterViewModel.filters[index]
            }
        }
    }
    
    
    func leadPadding(selectedFilter: FilterModel?, filter: FilterModel) -> CGFloat {
        if selectedFilter == nil && filter == filterViewModel.filters[0] {
            return 16
        }
        return 0
    }
    
    func determineMediaType() -> MediaType? {
        switch selectedFilter?.title ?? "" {
        case "Movies":
            return .movie
        case "TV Shows":
            return .tvShow
        default:
            return nil
        }
    }
}

struct CategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var movieViewModel = MovieViewModel()
    @Binding var selectedGenre: GenreTypes?

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    .black,
                    .purple
                    
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Choose a Category")
                    .font(.largeTitle.bold())
                    .foregroundStyle(LinearGradient(
                        colors: [.purple, .blue, .pink],
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
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
