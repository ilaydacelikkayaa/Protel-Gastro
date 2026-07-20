//
//  BillCellView.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 20.07.2026.
//

import SwiftUI

struct BillCellView: View {
    let item: CartItems
    
    var body: some View {
        HStack(spacing: 16) {
            // MARK: - Adet Badge
            Text("\(item.quantity)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Color.white.opacity(0.1))
                .clipShape(Circle())
            
            // MARK: - Ürün Bilgisi
            VStack(alignment: .leading, spacing: 4) {
                Text(item.menuItem.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(String(format: "%.2f ₺ / adet", item.menuItem.price))
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // MARK: - Toplam Fiyat
            Text(String(format: "%.2f ₺",item.totalItemPrice))
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(16)
        .background(Color.cardBackground)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(red: 44/255, green: 44/255, blue: 46/255), lineWidth: 1)
        )
    }
}
