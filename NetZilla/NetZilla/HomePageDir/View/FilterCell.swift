//
//  FilterCell.swift
//  NetZilla
//
//  Created by Davit Muradyan on 25.06.25.
//

import SwiftUI

struct FilterCell: View {
    var title: String
    var isDropDpwn: Bool
    var isSelected: Bool
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
            
            if isDropDpwn {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack {
                Capsule(style: .circular)
                    .fill(.gray)
                    .opacity(isSelected ? 1 : 0)
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
                
            }
        )
    }
}

//#Preview {
//    FilterCell()
//}
