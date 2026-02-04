import SwiftUI

struct UpdateChoreView<ViewModel>: View where ViewModel: UpdateChoreViewModel {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ViewModel
  
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 34) {
                TextField(text: $viewModel.title) {
                    Text("Title")
                }
                .textFieldStyle(.roundedBorder)
                
                TextField(text: $viewModel.description, axis: .vertical) {
                    Text("Description")
                }
                .lineLimit(15, reservesSpace: true)
                .textFieldStyle(.roundedBorder)
                
                Picker("Status", selection: $viewModel.selectedStatus) {
                    ForEach(viewModel.availableStatuses, id: \.self) { status in
                        Text(status.title).tag(status)
                    }
                }
                .pickerStyle(.segmented)
                
                Spacer()
            }
            .padding(.top, 16)
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { viewModel.cancelTapped() } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button { viewModel.doneTapped() } label: {
                        Image(systemName: "checkmark")
                    }.disabled(!viewModel.doneEnabled)
                }
            }
            .onChange(of: viewModel.goBack) { oldValue, newValue in
                if newValue {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    UpdateChoreView(viewModel: UpdateChoreViewModelMock())
}
