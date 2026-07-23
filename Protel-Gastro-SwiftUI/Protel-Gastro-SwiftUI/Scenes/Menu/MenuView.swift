//
//  MenuView.swift
//  Protel-Gastro-SwiftUI
//

import SwiftUI

struct MenuView: View {

    // MARK: - Properties
    let tableId: Int

    @StateObject private var viewModel = MenuViewModel()
    @ObservedObject private var cartManager = CartManager.shared
    @EnvironmentObject private var router: NavigationRouter

    @State private var selectedProduct: MenuItem?

    var body: some View {
        ZStack {
            Color.themeBackground
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: - Kategori Alanı
                if !viewModel.categories.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.categories, id: \.self) { category in
                                CategoryCellView(
                                    categoryName: category,
                                    isSelected: viewModel.selectedCategory == category
                                )
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        viewModel.filterMenu(by: category)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .padding(.vertical, 16)
                    .frame(height: 82)
                }

                // MARK: - İçerik
                ZStack {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.themeOrange)
                            .scaleEffect(1.5)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.filteredItems) { itemModel in
                                    FoodCellView(itemModel: itemModel) {
                                        cartManager.addItem(
                                            tableId: tableId,
                                            menuItem: itemModel,
                                            quantity: 1,
                                            kitchenNote: nil
                                        )
                                    }
                                    .onTapGesture {
                                        selectedProduct = itemModel
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(
                                .bottom,
                                cartManager.getTotalCount(tableId: tableId) > 0 ? 80 : 16
                            )
                        }
                    }
                }
            }

            // MARK: - Dinamik Sepet Barı
            if cartManager.getTotalCount(tableId: tableId) > 0 {
                VStack {
                    Spacer()

                    Button {
                        router.path.append(Route.cart(tableId: tableId))
                    } label: {
                        Text(
                            "Sepeti Gör (\(cartManager.getTotalCount(tableId: tableId)) Ürün) — \(String(format: "%.2f ₺", cartManager.getTotalPrice(tableId: tableId)))"
                        )
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.themeOrange)
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 16)
                    .background(
                        Color.themeBackground
                            .ignoresSafeArea(edges: .bottom)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: -5)
                    )
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("")
          .alert("Hata", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .fullScreenCover(item: $selectedProduct) { product in
            ProductDetailView(
                viewModel: ProductDetailViewModel(
                    product: product,
                    tableId: tableId
                )
            )
        }
    }
}

#Preview {
    NavigationStack {
        MenuView(tableId: 1)
    }
    .environmentObject(NavigationRouter())
}
