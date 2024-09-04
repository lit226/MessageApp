import SwiftUI

class ContactsViewModel: ObservableObject {
    @Published var contactModels: AuthenticationManagerModel?
    var nameText = ""
    var numberText = ""
    var emailText = ""

    
    func addContact() async throws {
        contactModels = try AuthenticationManager.shared.currentUser()
        let contact = ContactListModel(name: nameText, email: emailText, phoneNumber: Int64(numberText))
        try await ContactManager.shared.addContactToDatabase(contact: contact)
    }
}
