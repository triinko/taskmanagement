import Foundation
import Combine

protocol ObserveChoresUseCase {
    func execute() -> AnyPublisher<[Chore], Error>
}

class ObserveChoresUseCaseImpl: ObserveChoresUseCase {
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    func execute() -> AnyPublisher<[Chore], any Error> {
        databaseService.observeChores()
            .map { $0.map(\.model) }
            .eraseToAnyPublisher()
    }
}
