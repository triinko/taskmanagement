import Foundation
import Combine

protocol UpdateChoreUseCase {
    func execute(with chore: Chore) throws
}

class UpdateChoreUseCaseImpl: UpdateChoreUseCase {
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    func execute(with chore: Chore) throws {
        try databaseService.update(chore: .init(from: chore))
    }
}
