//
//  BillSummaryView.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 20.07.2026.
//

import SwiftUI


struct BillSummaryView: View {
    
    let subtotal: Double
    let serviceCharge: Double
    let total: Double
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            summaryRow(
                title: "Ara Toplam",
                value: subtotal
            )
            
            summaryRow(
                title: "Servis Ücreti (%10)",
                value: serviceCharge
            )
            
            Divider()
                .background(Color.gray.opacity(0.5))
            
            summaryRow(
                title: "Genel Toplam",
                value: total,
                isTotal: true
            )
            
        }
        .padding(20)
        .background(
            Color(red: 23/255,
                  green: 23/255,
                  blue: 23/255)
        )
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    Color(red:44/255,
                          green:44/255,
                          blue:46/255),
                    lineWidth:1
                )
        )
        .padding(.horizontal,20)
    }
}
private extension BillSummaryView {
    
    func summaryRow(
        title:String,
        value:Double,
        isTotal:Bool = false) -> some View {
        
        HStack {
            
            Text(title)
                .font(
                    isTotal ?
                        .headline :
                            .subheadline
                )
                .foregroundColor(
                    isTotal ? .white : .gray
                )
            
            Spacer()
            
            Text(
                String(format:"%.2f ₺", value)
            )
            .font(
                isTotal ?
                    .headline :
                        .subheadline
            )
            .foregroundColor(.white)
        }
    }
}
