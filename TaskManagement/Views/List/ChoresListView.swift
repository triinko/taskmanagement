import SwiftUI

struct ChoresListView<ViewModel>: View where ViewModel: ChoresListViewModel {
    @StateObject private var viewModel: ViewModel
    @State private var showAddChore: Bool = false
    @State private var showChoreDetails: Bool = false
    
    init(viewModel: ViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            List(viewModel.chores, id: \.self) { chore in
                NavigationLink {
                    viewModel.viewfactory?.choreDetailsView(with: chore.id)
                } label: {
                    ChoreListItemView(chore: chore)
                }
            }
            .overlay {
                if viewModel.chores.isEmpty {
                    ContentUnavailableView(
                        "No tasks.",
                        systemImage: "list.clipboard",
                        description: Text("Tap + to add a new task.")
                    )
                }
            }
        }
        .toolbar {
            Button {
                showAddChore = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showAddChore) {
            viewModel.viewfactory?.addChoreView()
        }
    }
}

#Preview {
    ChoresListView(viewModel: ChoresListViewModelMock())
}

extension Chore.Status {
    var title: String {
        switch self {
        case .todo:
            return "To-do"
            
        case .inProgress:
            return "In Progress"
            
        case .done:
            return "Done"
        }
    }
    
    var color: Color {
        switch self {
        case .todo:
            return .orange
            
        case .inProgress:
            return .blue
            
        case .done:
            return .green
        }
    }
}
