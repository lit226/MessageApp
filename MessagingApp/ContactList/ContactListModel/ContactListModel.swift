import Foundation
import Firebase

struct ContactListModel: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var email: String?
    var phoneNumber: Int64?
    var messages: [MessageModel]?
    
    init(user: User) {
        self.id = user.uid
        self.name = user.displayName ?? ""
        self.email = user.email
        self.phoneNumber = Int64(user.phoneNumber ?? "")
        self.messages = nil
    }
    
    init(id: String = UUID().uuidString, name: String, email: String? = nil, phoneNumber: Int64? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.messages = nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encodeIfPresent(self.email, forKey: .email)
        try container.encodeIfPresent(self.phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(self.messages, forKey: .messages)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
        case phoneNumber = "phoneNumber"
        case messages = "messages"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.phoneNumber = try container.decodeIfPresent(Int64.self, forKey: .phoneNumber)
        self.messages = try container.decodeIfPresent([MessageModel].self, forKey: .messages)
    }
}
