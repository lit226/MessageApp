import SwiftUI

struct AuthenticationView: View {
    @Binding var isUserSignIn: Bool
    @StateObject var viewModel = AuthenticationViewModel()

    var body: some View {
        VStack {
            Spacer(minLength: 10)
    
            Button(action: {
                Task {
                    do {
                        try await viewModel.signInAnonymously()
                    } catch {
                        print("Error: \(error)")
                    }
                }
                isUserSignIn = false
            }, label: {
                Text("Sign in Anonymously")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(10)
            })

            NavigationLink{
                SignInView(isUserSignIn: $isUserSignIn)
            } label: {
                Text("Sign in with Gmail")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            Spacer(minLength: 400)
        }
        .padding()
        .navigationTitle("Sign In")
        
    }
}

#Preview {
    NavigationStack {
        AuthenticationView(isUserSignIn: .constant(false))
    }
}
