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
                            selectedFilter = nil
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                }
                
                
                ForEach($filterViewModel.filters, id: \.self) { $filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        FilterCell(title: filter.title, isSelected: selectedFilter == filter, isDropDown: filter.isDropDown)
                            .background(.black.opacity(0.001))
                            .onTapGesture {
                                selectedFilter = filter
                                movieViewModel.selectedMediaType = determineMediaType()
                            }
                            .padding(.leading, leadPadding(selectedFilter: selectedFilter, filter: filter))
                    }
                }
            }
        }
        .padding(.vertical, 4)
        
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
        
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

//struct CategoryView: View {
//    @Environment(\.dismiss) private var dismiss
//    @ObservedObject var movieViewModel = MovieViewModel()
//    @State var selectedGenre: GenreTypes? = nil
//    
//    var body: some View {
//        List {
//            ForEach(GenreTypes.allCases) { genre in
//                Button {
//                    print(genre.rawValue)
//                    selectedGenre = genre
//                    dismiss()
//                } label: {
//                    HStack {
//                        Text(genre.rawValue)
//                            .padding(.vertical, 20)
//                        Spacer()
//                    }
//                }
//                .contentShape(Rectangle())
//                .listRowSeparatorTint(.purple)
//            }
//        }
//        .listStyle(.plain)
//        
//        
//        Button {
//            dismiss()
//        } label: {
//            Circle()
//                .fill(.secondary)
//                .frame(width: 50, height: 50)
//                .overlay {
//                    Image(systemName: "xmark")
//                        .font(.title2)
//                }
//        }
//        
//        
//    }
//}

//#Preview {
//    CategoryView()
//    
//}
