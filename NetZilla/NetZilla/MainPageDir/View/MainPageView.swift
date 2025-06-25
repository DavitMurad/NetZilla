//
//  ContentView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import SwiftUI

struct MainPageView: View {
    var body: some View {
        TabView {
            Tab("Home Page", systemImage: "house.fill") {
                HomePageView()
            }
            Tab("Seach", systemImage: "magnifyingglass") {
                SearchView()
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
