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

struct NewsItemModel {
    let id = UUID().uuidString
    let logo: Image
    let relaseDate: String
    let description: String
    let category: Category
}
