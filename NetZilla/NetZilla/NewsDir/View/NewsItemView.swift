//
//  NewsItemView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 01.07.25.
//

import SwiftUI

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
        .background(LinearGradient(
            gradient: Gradient(colors: [Color.indigo.opacity(0.7), Color.purple.opacity(0.4), Color.black]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ))
        .cornerRadius(15)
        .foregroundColor(.white)
        .padding(.horizontal)
    }
}
