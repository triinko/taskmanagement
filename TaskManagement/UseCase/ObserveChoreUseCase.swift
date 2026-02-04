import Foundation
import Combine

protocol ObserveChoreUseCase {
    func execute(with id: UUID) -> AnyPublisher<Chore?, Error>
}

class ObserveChoreUseCaseImpl: ObserveChoreUseCase {
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    func execute(with id: UUID) -> AnyPublisher<Chore?, Error> {
        databaseService.observeChore(with: id)
            .map(\.?.model)
            .eraseToAnyPublisher()
    }
}
