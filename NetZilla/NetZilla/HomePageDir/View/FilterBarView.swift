//
//  FilterBarView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import SwiftUI

struct FilterBarView: View {
    
    @EnvironmentObject var filterViewModel: FiltersViewModel
    @State private var selectedFilter: FilterModel? = nil
    
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
                            selectedFilter = nil
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                }
                
                
                ForEach(filterViewModel.filters, id: \.self) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        FilterCell(title: filter.title, isDropDpwn: filter.isDropDown, isSelected: selectedFilter == filter)
                            .background(.black.opacity(0.001))
                            .onTapGesture {
                                selectedFilter = filter
                                
                    }
                            .padding(.leading, leadPadding(selectedFilter: selectedFilter, filter: filter))
                   
                    
                }
              
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
    
    func leadPadding(selectedFilter: FilterModel?, filter: FilterModel) -> CGFloat {
        if selectedFilter == nil && filter == filterViewModel.filters[0] {
            return 16
        }
        return 0
    }
}

#Preview {
    FilterBarView()
        .environmentObject(FiltersViewModel())
}
