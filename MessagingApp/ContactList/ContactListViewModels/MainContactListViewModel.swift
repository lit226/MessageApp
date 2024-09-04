import SwiftUI
import FirebaseFirestore

@MainActor
class MainContactListViewModel: ObservableObject {
    @Published var contacts: [ContactListModel] = []
    let manager = ContactManager.shared
    
    func getData() async throws {
            let data = try await manager.fetchData()
            contacts = data
    }
}
