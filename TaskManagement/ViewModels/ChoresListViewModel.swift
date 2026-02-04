import Foundation
import Combine

protocol ChoresListViewModel: ObservableObject {
    var viewfactory: ChoresListViewFactory? { get }
    var chores: [Chore] { get }
}

class ChoresListViewModelImpl: ChoresListViewModel {
    @Published var chores: [Chore] = []
    let viewfactory: ChoresListViewFactory?
    private let observeChoresUseCase: ObserveChoresUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(viewfactory: ChoresListViewFactory, observeChoresUseCase: ObserveChoresUseCase) {
        self.viewfactory = viewfactory
        self.observeChoresUseCase = observeChoresUseCase
        observeChores()
    }
    
    private func observeChores() {
        observeChoresUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] in
                self?.chores = $0
            }
            .store(in: &cancellables)
    }
}

class ChoresListViewModelMock: ChoresListViewModel{
    var viewfactory: ChoresListViewFactory? = nil
    var chores: [Chore] = [.init(id: UUID(), title: "Task 1", description: nil, status: .todo)]
}
