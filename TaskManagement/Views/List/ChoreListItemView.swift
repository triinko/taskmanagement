import SwiftUI

struct ChoreListItemView: View {
    @State var chore: Chore
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(chore.title)
                    .font(.title3)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                if let description = chore.description {
                    Text(description)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }
            Spacer()
            Text(chore.status.title)
                .font(.caption)
                .bold()
                .foregroundStyle(chore.status.color)
        }
    }
}

#Preview {
    ChoreListItemView(chore: .init(id: UUID(), title: "Task 1", description: "Task description", status: .inProgress))
}
