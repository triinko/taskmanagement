import Foundation
import Combine

protocol RemoveChoreUseCase {
    func execute(with id: UUID) throws
}

class RemoveChoreUseCaseImpl: RemoveChoreUseCase {
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    func execute(with id: UUID) throws {
        try databaseService.removeChore(with: id)
    }
}
