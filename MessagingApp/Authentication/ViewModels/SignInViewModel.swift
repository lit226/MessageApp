import SwiftUI

final class SignInViewModel: ObservableObject {
    var email: String = ""
    var password: String = ""
    
    func signInWithEmail() async throws {
        try await AuthenticationManager.shared.createAuth(email: email, password: password)
    }
}
