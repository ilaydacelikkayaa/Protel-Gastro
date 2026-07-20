//
//  ProductDetailView.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 20.07.2026.
//

import SwiftUI

struct ProductDetailView: View {
    
    // MARK: - Properties
    @StateObject var viewModel: ProductDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.themeBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Scrollable İçerik
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        
                        headerView
                        
                        productImageView
                        
                        productInfoView
                        
                        kitchenNoteSection
                                      
                        stepperView
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 24)
                }
                .onTapGesture {
                    hideKeyboard()
                }

                // MARK: - Alt Buton
                addToCartButton
                    .padding(.horizontal, 20)
                    .padding(.bottom, 16)
                    .padding(.top, 12)
            }
        }
    }
}

// MARK: - Subviews
private extension ProductDetailView {
    
    var headerView: some View {
        HStack {
            if viewModel.isPopular {
                HStack(spacing: 6) {
                    Image(systemName: "flame.fill")
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    Text("Popüler")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.themeOrange)
                .cornerRadius(8)
            }
            
            Spacer()
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white.opacity(0.85))
                    .background(Color.black.opacity(0.2))
                    .clipShape(Circle())
            }
            .buttonStyle(.borderless)
            .contentShape(Rectangle())
        }
        .padding(.top, 16)
    }
    
    var productImageView: some View {
        AsyncImage(url: URL(string: viewModel.product.imageUrl)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure, .empty:
                Image(systemName: "fork.knife")
                    .font(.system(size: 48))
                    .foregroundColor(.white.opacity(0.4))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.opacity(0.05))
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: 280)
        .cornerRadius(24)
        .clipped()
    }
    
    var productInfoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Text(viewModel.productName)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(viewModel.productPriceText)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.themeOrange)
            }
            
            Text(viewModel.orderCountText)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.white.opacity(0.6))
        }
    }
    
    var kitchenNoteSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Mutfak Notu (İsteğe bağlı)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.7))
            
            ZStack(alignment: .topLeading) {
                if viewModel.kitchenNote.isEmpty {
                    Text("\"Sos olmasın\", \"Burger az pişsin\"...")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.35))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                }
                
                TextField("", text: $viewModel.kitchenNote, axis: .vertical)
                    .lineLimit(3...4)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(14)
            }
            .background(Color.white.opacity(0.08))
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
            )
        }
    }
    
        var stepperView: some View {
            HStack(spacing: 32) {
                Button(action: {
                    viewModel.decreaseQuantity()
                }) {
                    Image(systemName: "minus")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 48, height: 48)
                        .background(Color.white.opacity(0.18))
                        .clipShape(Circle())
                }
                .buttonStyle(.borderless)
                
                Text("\(viewModel.quantity)")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .frame(minWidth: 40)
                
                Button(action: {
                    viewModel.increaseQuantity()
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 48, height: 48)
                        .background(Color.themeOrange)
                        .clipShape(Circle())
                }
                .buttonStyle(.borderless)
            }
            .frame(maxWidth: .infinity)
        }
    
    var addToCartButton: some View {
        Button(action: {
            viewModel.addToCart()
            dismiss()
        }) {
            HStack(spacing: 10) {
                Image(systemName: "bag.fill")
                    .font(.title3)
                
                Text("Adisyona Ekle — \(viewModel.totalPriceText)")
                    .font(.headline)
                    .bold()
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(Color.themeOrange)
            .cornerRadius(18)
        }
        .buttonStyle(.borderless)
    }
}

// MARK: - Helper Extensions
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

