//
// HallView.swift
//  Protel-Gastro-SwiftUI
//
//  Created by İlayda Çelikkaya on 16.07.2026.
//

import SwiftUI

struct HallView: View {
    @StateObject private var viewModel = HallViewModel()
    let columns:[GridItem]=[
        GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
    ]
    var body: some View {
        ZStack{
            Color.themeBackground
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20)
            {
                VStack(alignment: .leading , spacing: 4){
                    Text("Restoran")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.themeSecondaryText)
                    HStack{
                        Text("Salon Düzeni")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        Text("14:02")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.themeOrange)
                    }
                    HStack(spacing:12){
                        HStack(spacing: 12) {
                            Image(systemName: "fork.knife")
                                .font(.system(size: 24))
                                .foregroundColor(.green)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("\(viewModel.emptyTableCount)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                Text("Boş")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.themeSecondaryText)
                            }
                        }
                        .padding(.horizontal, 12)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.themeCardBackground)
                            .cornerRadius(16)
                        
                        HStack(spacing:12){
                            Image(systemName: "person.2.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.themeOrange)
                            VStack(spacing:4){
                                Text("\(viewModel.fullTableCount)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("Dolu")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.themeSecondaryText)
                                
                            }
                        }
                        .padding(.horizontal,12)
                        .padding(.vertical,12)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .background(Color.themeCardBackground)
                        .cornerRadius(16)
                        HStack(spacing:12){
                            Image(systemName: "cart.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.green)
                            
                            VStack(spacing:4){
                                Text("\(viewModel.totalOrderCount)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("Sipariş")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.themeSecondaryText)
                            }
                        }
                        .padding(.horizontal,12)
                        .padding(.vertical,12)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .background(Color.themeCardBackground)
                        .cornerRadius(16)
                        
                    }
                    
                }
                
                ScrollView{
                    LazyVGrid(columns: columns,spacing:16){
                        ForEach(viewModel.tables,id: \.id){ table in
                            TableCellView(table: table)
                        }
                    }
   
                }

            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
  
        }
    }
}


#Preview {
    HallView()
}
