import GRDB
import Foundation
import Combine

protocol DatabaseService {
    func observeChores() -> AnyPublisher<[ChoreEntity], Error>
    func observeChore(with id: UUID) -> AnyPublisher<ChoreEntity?, Error>
    func update(chore: ChoreEntity) throws
    func removeChore(with id: UUID) throws
}

struct DatabaseServiceImpl: DatabaseService {
    private let dbWriter: any DatabaseWriter
    
    init() {
        do {
            let fileManager = FileManager.default
            let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let dbURL = urls[0].appendingPathComponent("taskmanagement.sqlite")
            
            let config = Configuration()
            
            dbWriter = try DatabasePool(path: dbURL.path, configuration: config)
            
            try DatabaseServiceImpl.migrator.migrate(dbWriter)
        } catch {
            fatalError("Could not initialize GRDB database: \(error)")
        }
    }
    
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("v1_chore_tables") { db in
            try db.create(table: ChoreEntity.databaseTableName) { t in
                t.column("id", .text).primaryKey()
                t.column("title", .text).notNull()
                t.column("description", .text)
                t.column("status", .text).notNull()
            }
        }

        return migrator
    }
    
    func observeChores() -> AnyPublisher<[ChoreEntity], any Error> {
        ValueObservation.tracking { db in
            try ChoreEntity.fetchAll(db)
        }
        .publisher(in: dbWriter)
        .eraseToAnyPublisher()
    }
    
    func observeChore(with id: UUID) -> AnyPublisher<ChoreEntity?, any Error> {
        ValueObservation.tracking { db in
            try ChoreEntity.fetchOne(db, key: id)
        }
        .publisher(in: dbWriter)
        .eraseToAnyPublisher()
    }
    
    func update(chore: ChoreEntity) throws {
        try dbWriter.write { db in
            if (try ChoreEntity.fetchOne(db, key: chore.id)) != nil {
                try chore.update(db, onConflict: .replace)
            } else {
                try chore.insert(db, onConflict: .replace)
            }
        }
    }
    
    func removeChore(with id: UUID) throws {
        let _ = try dbWriter.write { db in
            try ChoreEntity.filter(key: id).deleteAll(db)
        }
    }
}
