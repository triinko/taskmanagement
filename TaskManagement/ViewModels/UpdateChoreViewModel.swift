import Foundation
import Combine

protocol UpdateChoreViewModel: ObservableObject {
    var title: String { get set }
    var description: String { get set }
    var selectedStatus: Chore.Status { get set }
    var availableStatuses: [Chore.Status] { get }
    var doneEnabled: Bool { get }
    var goBack: Bool { get }
    
    func cancelTapped()
    func doneTapped()
}

class UpdateChoreViewModelImpl: UpdateChoreViewModel {
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var selectedStatus: Chore.Status = .todo
    @Published var doneEnabled: Bool = false
    @Published var goBack: Bool = false
    var availableStatuses: [Chore.Status] = Chore.Status.allCases
    
    private let chore: Chore
    private let updateChoreUseCase: UpdateChoreUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(chore: Chore?, updateChoreUseCase: UpdateChoreUseCase) {
        self.chore = chore ?? .init()
        self.title = self.chore.title
        self.description = self.chore.description ?? ""
        self.selectedStatus = self.chore.status
        self.updateChoreUseCase = updateChoreUseCase
        
        observeUserInput()
    }
    
    func cancelTapped() {
        goBack = true
    }
    
    func doneTapped() {
        try? updateChoreUseCase.execute(with: .init(
            id: chore.id,
            title: title,
            description: description,
            status: selectedStatus
        ))
        goBack = true
    }
    
    private func observeUserInput() {
        $title.combineLatest($description, $selectedStatus)
            .sink { [weak self] (title, description, status) in
                guard let self else { return }
                doneEnabled = !title.isEmpty
                && (title != chore.title || description != (chore.description ?? "") || status != chore.status)
            }
            .store(in: &cancellables)
    }
}

class UpdateChoreViewModelMock: UpdateChoreViewModel {
    var title: String = ""
    var description: String = ""
    var selectedStatus: Chore.Status = .todo
    var availableStatuses: [Chore.Status] = Chore.Status.allCases
    var doneEnabled: Bool = false
    var goBack: Bool = false
    
    func cancelTapped() {}
    
    func doneTapped() {}
}
