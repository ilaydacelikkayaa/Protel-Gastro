//
//  CategoryCellView.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 16.07.2026.
//

import SwiftUI

struct CategoryCellView: View {
    let categoryName: String
    let isSelected: Bool
    
    var body: some View {
        Text(categoryName)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(isSelected ? .white : .themeSecondaryText)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(isSelected ? Color.themeOrange : Color.themeCardBackground)
            .clipShape(Capsule()) 
    }
}
