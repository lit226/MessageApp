import SwiftUI

@MainActor
class AuthenticationViewModel: ObservableObject {
    
    func signInAnonymously() async throws {
        _ = try await AuthenticationManager.shared.signInAnonymously()
    }
}
