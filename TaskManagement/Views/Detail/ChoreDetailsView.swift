import SwiftUI

struct ChoreDetailsView<ViewModel>: View where ViewModel: ChoreDetailsViewModel {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ViewModel
    @State private var showEditing: Bool = false
    @State private var showDeleteConfirmation: Bool = false
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let chore = viewModel.chore {
                        Text(chore.title)
                            .font(.title2)
                        
                        Text(chore.status.title)
                            .foregroundStyle(chore.status.color)
                            .font(.footnote)
                            .bold()
                        
                        Text(chore.description ?? "")
                            .frame(maxWidth: .infinity)
                        
                        Spacer()
                    }
                }
                .padding(.top, 16)
                .padding(.horizontal)
            }
            .toolbar {
                Button {
                    showEditing = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Delete Task") { showDeleteConfirmation = true }
                        .confirmationDialog("Delete Task?", isPresented: $showDeleteConfirmation) {
                            Button("Delete Task", role: .destructive) { viewModel.deleteConfirmed() }
                            Button("Cancel") {}
                        }
                }
            }
            .onChange(of: viewModel.goBack) { oldValue, newValue in
                if newValue {
                    dismiss()
                }
            }
        }
        .sheet(isPresented: $showEditing) {
            viewModel.viewFactory?.updateChoreView(chore: viewModel.chore)
        }
    }
}

#Preview {
    ChoreDetailsView(viewModel: ChoreDetailsViewModelMock())
}
