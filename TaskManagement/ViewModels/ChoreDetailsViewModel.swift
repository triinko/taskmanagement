import Foundation
import Combine

protocol ChoreDetailsViewModel: ObservableObject {
    var chore: Chore? { get }
    var goBack: Bool { get }
    var viewFactory: ChoreDetailsViewFactory? { get }
    
    func deleteConfirmed()
}

class ChoreDetailsViewModelImpl: ChoreDetailsViewModel {
    @Published var chore: Chore?
    @Published var goBack: Bool = false
    let viewFactory: ChoreDetailsViewFactory?
    
    private let id: UUID
    private let observeChoreUseCase: ObserveChoreUseCase
    private let removeChoreUseCase: RemoveChoreUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(
        viewFactory: ChoreDetailsViewFactory?,
        id: UUID,
        observeChoreUseCase: ObserveChoreUseCase,
        removeChoreUseCase: RemoveChoreUseCase
    ) {
        self.viewFactory = viewFactory
        self.id = id
        self.observeChoreUseCase = observeChoreUseCase
        self.removeChoreUseCase = removeChoreUseCase
        observeChore()
    }
    
    func deleteConfirmed() {
        try? removeChoreUseCase.execute(with: id)
        goBack = true
    }
    
    private func observeChore() {
        observeChoreUseCase.execute(with: id)
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] in
                self?.chore = $0
            }
            .store(in: &cancellables)
    }
}

class ChoreDetailsViewModelMock: ChoreDetailsViewModel {
    var chore: Chore? = .init(id: UUID(), title: "Task 1", description: "Description", status: .todo)
    var goBack: Bool = false
    var viewFactory: ChoreDetailsViewFactory? = nil
    
    func deleteConfirmed() {}
    func deleteCancelled() {}
    
    
}
