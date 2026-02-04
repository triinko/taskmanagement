import Foundation
import SwiftUI

class ChoresListViewFactory {
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    func choreDetailsView(with id: UUID) -> ChoreDetailsView<ChoreDetailsViewModelImpl> {
        ChoreDetailsView(viewModel: ChoreDetailsViewModelImpl(
            viewFactory: ChoreDetailsViewFactory(databaseService: databaseService),
            id: id,
            observeChoreUseCase: ObserveChoreUseCaseImpl(databaseService: databaseService),
            removeChoreUseCase: RemoveChoreUseCaseImpl(databaseService: databaseService)
        ))
    }
    
    func addChoreView() -> UpdateChoreView<UpdateChoreViewModelImpl> {
        UpdateChoreView(
            viewModel: UpdateChoreViewModelImpl(
                chore: nil,
                updateChoreUseCase: UpdateChoreUseCaseImpl(databaseService: databaseService)
            )
        )
    }
}
