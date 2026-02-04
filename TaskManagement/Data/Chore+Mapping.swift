import Foundation

extension ChoreEntity {
    init(from model: Chore) {
        self.id = model.id
        self.title = model.title
        self.description = model.description
        self.status = model.status.rawValue
    }
    
    var model: Chore {
        Chore(
            id: id,
            title: title,
            description: description,
            status: Chore.Status(rawValue: status) ?? .todo
        )
    }
}
