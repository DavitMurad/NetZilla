//
//  FiltersViewModel.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import Foundation

class FiltersViewModel: ObservableObject {
    @Published var filters: [FilterModel] = []
    
    init() {
        getFilters()
    }
    
    func getFilters() {
        filters.append(contentsOf: [
            FilterModel(title: "TV Shows", isDropDown: false),
            FilterModel(title: "Movies", isDropDown: false),
            FilterModel(title: "Categories", isDropDown: true),
        ])
    }
}
