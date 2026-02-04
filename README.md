# TaskManagement

## Architectural Decisions

- **MVVM with SwiftUI**: Views bind to `ObservableObject` view models so UI state is driven by Combine publishers.
- **Use cases**: Interacting with the database goes through use-cases to keep business logic out of views and keep dependencies explicit.
- **GRDB for local persistance**: GRDB library is used to save tasks to local SQLite database.
- **Entities**: database records are kept as entities, which encode the database schema and GRDB record behaviors while keeping the `Chore` model clean and UI-focused.
- **View factories**: Factories build views and inject dependencies, keeping wiring out of SwiftUI views.
