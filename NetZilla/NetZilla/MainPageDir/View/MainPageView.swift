//
//  ContentView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import SwiftUI

struct MainPageView: View {
    @StateObject var filtersViewModel = FiltersViewModel()
    @StateObject var movieViewModel = MovieViewModel()
    var body: some View {
        TabView {
            Tab("Home Page", systemImage: "house.fill") {
                HomePageView()
                    .environmentObject(filtersViewModel)
                    .environmentObject(movieViewModel)
            }
            Tab("News", systemImage: "newspaper.fill") {
                NewsView()
            }
            Tab("Favourites", systemImage: "hand.thumbsup.fill") {
                FavouritesView()
            }
        }
        
    }
}

#Preview {
    MainPageView()
}
