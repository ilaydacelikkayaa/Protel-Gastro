//
//  NewCartView.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 20.07.2026.
//

import SwiftUI

struct NewCartView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: NewCartViewModel
    @State private var finalOrderAmount: Double = 0.0
    @EnvironmentObject private var router: NavigationRouter

    var body: some View {
        ZStack {
            Color.themeBackground
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                
                headerSection
                
                if viewModel.cartItems.isEmpty {
                    emptyCartView
                } else {
                    cartListView
                }
                
                if !viewModel.cartItems.isEmpty {
                    VStack(spacing: 16) {
                        summaryCardView
                        
                        kitchenButton
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                }
            }
        }

    }
}

// MARK: - Subviews
private extension NewCartView {
    
    var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Masa \(viewModel.tableId) — Yeni Sepet")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Text("Mutfağa göndermeden önce kontrol edin")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
    
    var cartListView: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.cartItems, id: \.menuItem.id) { item in
                    CartCellView(
                        item: item,
                        onIncrement: {
                            viewModel.incrementQuantity(for: item)
                        },
                        onDecrement: {
                            viewModel.decrementQuantity(for: item)
                        }
                    )
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    var emptyCartView: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: "cart.badge.minus")
                .font(.system(size: 48))
                .foregroundColor(.gray)
            Text("Sepetinizde ürün bulunmamaktadır.")
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
        }
    }
    
    var kitchenButton: some View {
        Button (action:{

            finalOrderAmount = viewModel.goToKitchen()

            router.path.append(
                Route.success(
                    tableId: viewModel.tableId,
                    amount: finalOrderAmount
                )
            )

        })
        {
            Text("Siparişi Mutfağa Gönder")
                .font(.headline)
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.themeOrange)
                .cornerRadius(16)
        }
        .buttonStyle(.plain)
    }
}
// MARK: - Subviews Extension
private extension NewCartView {
    
    var summaryCardView: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Ara Toplam")
                    .foregroundColor(.gray)
                Spacer()
                Text(String(format: "%.2f ₺", viewModel.subtotal))
                    .bold()
                    .foregroundColor(.white)
            }
            .font(.subheadline)
            
            HStack {
                Text("Servis Bedeli (%10)")
                    .foregroundColor(.gray)
                Spacer()
                Text(String(format: "%.2f ₺", viewModel.serviceFee))
                    .bold()
                    .foregroundColor(.white)
            }
            .font(.subheadline)
            
            Divider()
                .background(Color.white.opacity(0.15))
                .padding(.vertical, 4)
            
            HStack {
                Text("Genel Toplam")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Text(String(format: "%.2f ₺", viewModel.total))
                    .font(.title3)
                    .bold()
                    .foregroundColor(.themeOrange)
            }
        }
        .padding(20)
        .background(Color.themeCardBackground)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}
