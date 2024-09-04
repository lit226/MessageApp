import Foundation
import FirebaseAuth
import AuthenticationServices
import CryptoKit

final class AuthenticationManager {
    public static let shared = AuthenticationManager()
    private init() {}

    func currentUser() throws -> AuthenticationManagerModel {
        guard let user = Auth.auth().currentUser else {
            print("AuthenticationManager.currentUser Error:")
            throw URLError(.badServerResponse)
        }

        return AuthenticationManagerModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() throws {
        guard let user = Auth.auth().currentUser else {
            print("AuthenticationManager.currentUser Error:")
            throw URLError(.badServerResponse)
        }
        
        user.delete()
    }
}

// email authentication
extension AuthenticationManager {

    @discardableResult
    func createAuth(email: String, password: String) async throws -> AuthenticationManagerModel {
        let authorizedUser = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthenticationManagerModel(user: authorizedUser.user)
    }
}

// Anonymously authentication
extension AuthenticationManager {
    
    @discardableResult
    func signInAnonymously() async throws -> AuthenticationManagerModel {
        let user = try await Auth.auth().signInAnonymously()
        return AuthenticationManagerModel(user: user.user)
    }
}
