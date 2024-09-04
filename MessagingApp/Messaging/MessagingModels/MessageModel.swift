import Foundation
import Firebase

struct MessageModel: Identifiable, Codable {
    var id = UUID().uuidString
    var user: String?
    var message: String
    
}
