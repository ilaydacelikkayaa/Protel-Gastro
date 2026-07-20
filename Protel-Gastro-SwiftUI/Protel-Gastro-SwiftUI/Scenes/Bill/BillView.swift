import SwiftUI
import Combine

struct BillView: View {

    @ObservedObject var viewModel: BillViewModel
    @EnvironmentObject var router: NavigationRouter

    var body: some View {
        ZStack {
            Color.themeBackground
                .ignoresSafeArea()

            VStack(spacing: 16) {

                headerSection

                ScrollView {

                    VStack(spacing:12) {

                        ForEach(viewModel.finalizedItems, id:\.menuItem.id) { item in
                            
                            BillCellView(item: item)
                        }
                    }
                    .padding(.horizontal,20)
                }
                .frame(maxHeight: .infinity)

                BillSummaryView(
                    subtotal: viewModel.subtotal,
                    serviceCharge: viewModel.serviceCharge,
                    total: viewModel.generalTotal
                )

                closeTableButton

            }
            .alert(
                "Masayı Kapat",
                isPresented: $viewModel.showCloseConfirmation
            ) {
                
                Button("Vazgeç", role: .cancel) {
                    
                }
                
                Button("Evet", role: .destructive) {
                    
                    viewModel.closeTable()
                    
                    if !router.path.isEmpty {
                        router.path.removeLast()
                    }
                }
                
            } message: {
                
                Text("Bu masanın hesabını kapatmak istediğinize emin misiniz?")
            }
        }
    }
}

// MARK: - Subviews
private extension BillView {

    var headerSection: some View {

        VStack(alignment: .leading, spacing: 4) {

            Text(viewModel.title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)

            Text("Sipariş Özeti")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
    
    var closeTableButton: some View {
        
        Button {
            viewModel.requestCloseTable()
        } label: {
            
            Text("Masayı Kapat")
                .font(.headline)
                           .foregroundColor(.white)
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.red)
                           .cornerRadius(14)
        }
        .padding(.horizontal,20)

       
    }
}
