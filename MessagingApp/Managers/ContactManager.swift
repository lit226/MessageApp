import SwiftUI
import FirebaseFirestore

struct ContactManager {
    public static var shared = ContactManager()
    private init() {}

    private let collection = Firestore.firestore().collection("Contacts")
    private func getDocument(userId: String) -> DocumentReference {
        return collection.document(userId)
    }
    
    private let encoder: Firestore.Encoder = {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    func addContactToDatabase(contact: ContactListModel) async throws {
        var userData: [String: Any] = [
            "id": contact.id,
            "name": contact.name
        ]
        
        if let email = contact.email, let phoneNumber = contact.phoneNumber {
            userData["email"] = email
            userData["phoneNumber"] = phoneNumber
        }
        
        try await getDocument(userId: contact.id).setData(userData)
    }

    func getAllContactQuery() -> Query {
        collection
    }
    
    func fetchData() async throws -> [ContactListModel] {
        let query = getAllContactQuery()
        return try await query.getDocument(as: ContactListModel.self)
    }
    
    func addMessage(user: String, message: MessageModel) async throws {
        guard let message = try? encoder.encode(message) else {
            throw URLError(.badURL)
        }

        let data: [String: Any] = [
            ContactListModel.CodingKeys.messages.rawValue: FieldValue.arrayUnion([message])
        ]
        
        try await getDocument(userId: user).updateData(data)
    }
}

extension Query {
    func getDocument<T>(as Type: T.Type) async throws -> [T] where T: Decodable {
        try await getDocumentWithSnapshot(as: Type).products
    }
    
    func getDocumentWithSnapshot<T>(as Type: T.Type) async throws -> (products: [T], lastSnapshot: DocumentSnapshot?) where T: Decodable {
        let snapshot = try await self.getDocuments()
        let product = try snapshot.documents.map ({ document in
            try document.data(as: T.self)
        })
        
        return (product, snapshot.documents.last)
    }
    
    func startOptionally(document: DocumentSnapshot?) -> Query {
        guard let document else { return self }
        return self.start(afterDocument: document)
    }
    
    func getAggregateCount() async throws -> Int {
        let snapshot = try await self.count.getAggregation(source: .server)
        return Int(truncating: snapshot.count)
    }
}
