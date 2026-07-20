//
//  FoodCellView.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 17.07.2026.
//

import SwiftUI

struct FoodCellView: View {
    
    // MARK: - Properties
    let itemModel: MenuItem
    var didTapPlusButton: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            
           //imageloader sınıfının karşılığı asyncimage
            AsyncImage(url: URL(string: itemModel.imageUrl)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure, .empty:
                    Image(systemName: "fork.knife")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.systemGray6))
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 96, height: 96)
            .cornerRadius(12)
            .clipped()
            .padding(.leading, 12)
            
            // MARK: - 2. Metin İçerik Alanı (VStack)
            VStack(alignment: .leading, spacing: 4) {
                Text(itemModel.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text("Puan: \(String(format: "%.1f", itemModel.rating)) | Bugün \(itemModel.orderCount) kez sipariş edildi")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                Spacer(minLength: 0)
                
                Text(String(format: "%.2f ₺", itemModel.price))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.themeOrange)
            }
            .padding(.vertical, 12)
            
            Spacer(minLength: 4)
            
            // MARK: - 3. Plus Butonu
            VStack {
                Spacer()
                Button(action: {
                    didTapPlusButton()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(Color.themeOrange)
                        .clipShape(Circle())
                }
                .padding(.trailing, 12)
                .padding(.bottom, 12)
            }
        }
        .frame(height: 120)
        .background(Color.themeCardBackground)
        .cornerRadius(16)
    }
}
