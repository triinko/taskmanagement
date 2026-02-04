import Foundation
import GRDB

struct ChoreEntity: Codable, PersistableRecord, FetchableRecord {
    static var databaseTableName: String = "chores"
    
    let id: UUID
    let title: String
    let description: String?
    let status: String
    
    enum Columns {
        static let id = Column("id")
        static let title = Column("title")
        static let description = Column("description")
        static let status = Column("status")
    }
}
