import SwiftUI

struct OrderSuccessView: View {
    
    let viewModel: OrderSuccessViewModel
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        ZStack {
            Color.themeBackground
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.themeOrange)
                    .frame(width: 100, height: 100)
                    .background(Color.themeOrange.opacity(0.15))
                    .clipShape(Circle())
                
                VStack(spacing: 12) {
                    Text(viewModel.titleText)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text(viewModel.subtitleText)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                
                // MARK: - Tutar Kartı
                VStack(spacing: 6) {
                    Text(viewModel.amountText)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.themeOrange)
                    
                    Text("sipariş tutarı")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width: 180, height: 100)
                .background(Color.white.opacity(0.05))
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
                
                Spacer()
                
                // MARK: - Salona Dön Butonu
                Button(action: {
                    router.path = NavigationPath()
                    }) {
                        Text("Salona Dön")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.themeOrange)
                            .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
