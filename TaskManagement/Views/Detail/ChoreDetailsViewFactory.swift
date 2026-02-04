import Foundation

class ChoreDetailsViewFactory {
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    func updateChoreView(chore: Chore?) -> UpdateChoreView<UpdateChoreViewModelImpl> {
        UpdateChoreView(
            viewModel: UpdateChoreViewModelImpl(
                chore: chore,
                updateChoreUseCase: UpdateChoreUseCaseImpl(databaseService: databaseService)
            )
        )
    }
}
