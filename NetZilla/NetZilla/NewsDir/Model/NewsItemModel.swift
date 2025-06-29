//
//  NewsItemModel.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import Foundation
import SwiftUI

enum Category {
    case horror, action, drama
}

struct NewsItemModel: Identifiable, Equatable, Codable {
    let id: Int
    let title: String
    let description: String
    let releaseDate: String
    let genre: [String]
    let posterImageName: String
    let logoImageName: String
    let runtime: Int
    let director: String
    let cast: [String]
}
