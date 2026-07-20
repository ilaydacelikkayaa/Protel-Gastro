
//
//  CartCellView.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 20.07.2026.
//

import SwiftUI

struct CartCellView: View {
    
    // MARK: - Properties
    let item: CartItems
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            
            AsyncImage(url: URL(string: item.menuItem.imageUrl)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure, .empty:
                    Image(systemName: "fork.knife")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white.opacity(0.05))
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 64, height: 64)
            .cornerRadius(12)
            .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
                Text(item.menuItem.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                if let note = item.kitchenNote, !note.isEmpty {
                    Text("Not: \(note)")
                        .font(.caption)
                        .foregroundColor(.themeOrange)
                        .lineLimit(1)
                }
                
                Text(String(format: "%.2f ₺ (%.2f x %d)", item.totalItemPrice, item.menuItem.price, item.quantity))
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.themeOrange)
            }
            
            Spacer(minLength: 0)
            
            HStack(spacing: 8) {
                Button(action: onDecrement) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.gray)
                }
                .buttonStyle(.plain)
                
                Text("\(item.quantity)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(minWidth: 20)
                
                Button(action: onIncrement) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 26))
                        .foregroundColor(.themeOrange)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(12)
        .background(Color.themeCardBackground)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.08), lineWidth: 1)
        )
    }
}
