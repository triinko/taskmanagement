import SwiftUI

@main
struct TaskManagementApp: App {
    let databaseService: DatabaseService = DatabaseServiceImpl()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ChoresListView(
                    viewModel: ChoresListViewModelImpl(
                        viewfactory: ChoresListViewFactory(databaseService: databaseService),
                        observeChoresUseCase: ObserveChoresUseCaseImpl(
                            databaseService: databaseService
                        )
                    )
                )
            }
        }
    }
}
