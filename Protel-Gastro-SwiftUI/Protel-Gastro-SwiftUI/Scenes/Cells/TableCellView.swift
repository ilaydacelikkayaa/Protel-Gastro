//
//  TableCellView.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 16.07.2026.
//
import SwiftUI

struct TableCellView: View {
    let table: RestaurantTable
    var body: some View {
        ZStack(alignment: .topTrailing){
            VStack(spacing:8){
                Text("MASA")
                    .font(.system(size: 12,weight: .bold))
                    .foregroundColor(table.isFull ? .themeOrange : .themeSecondaryText)
                Text("\(table.id)")
                    .font(.system(size: 44, weight: .bold))
                    .foregroundColor(.white)
                Text(table.isFull ? String(format: "%.2f ₺", table.currentTotal) : "Boş")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(table.isFull ? .white : .themeSecondaryText)
            }
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(table.isFull ? Color.themeOrange.opacity(0.15) : Color.themeCardBackground)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(table.isFull ? Color.themeOrange : Color.clear, lineWidth: 1)
            )
            if table.isFull {
                Circle()
                    .fill(Color.themeOrange)
                    .frame(width: 8, height: 8)
                    .padding([.top, .trailing], 12)
            }
        }
    }
}

