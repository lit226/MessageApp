import SwiftUI
import FirebaseFirestore

@MainActor
class MessageViewModel: ObservableObject {
    @Published var message: String = ""
    let manager = ContactManager.shared
    
    func saveMessage(contact: ContactListModel) {
        if message != "" {
            let messageModel = MessageModel(message: message)
            Task {
                try await manager.addMessage(user: contact.id, message: messageModel)
            }
        }
    }
}
