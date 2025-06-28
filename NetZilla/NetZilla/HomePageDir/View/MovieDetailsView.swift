//
//  MovieDetailsView.swift
//  NetZilla
//
//  Created by Davit Muradyan on 27.06.25.
//

import SwiftUI

struct MovieDetailsView: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                Image("Godzila1")
                    .resizable()
                
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .overlay(alignment: .topTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title3)
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .frame(alignment: .topTrailing)
                        .background(
                            Circle()
                                .fill(.black.opacity(0.5))
                                .frame(width: 35, height: 35)
                        )

                    }
                    .overlay {
                        Button {
                            
                        } label: {
                            Image(systemName: "play.circle")
//                                .font(.title)
                                .frame(width: 200, height: 200)
                        }
                    }
                   
                
                Spacer()
            }
        }
       
    }
}

#Preview {
    MovieDetailsView()
}
