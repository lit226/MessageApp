import Foundation
import FirebaseAuth
import AuthenticationServices
import CryptoKit

struct AuthenticationManagerModel {
    let uuid: String
    let email: String?
    let photoUrl: String?
    let isAnonymous: Bool
    
    init(user: User) {
        self.uuid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        self.isAnonymous = user.isAnonymous
    }
}
