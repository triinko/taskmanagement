import Foundation

struct Chore: Hashable {
    enum Status: String, CaseIterable {
        case todo, inProgress, done
    }
    
    let id: UUID
    let title: String
    let description: String?
    let status: Status
}

extension Chore {
    init() {
        self.id = UUID()
        self.title = ""
        self.description = nil
        self.status = .todo
    }
}
