import SwiftUI

struct SignInView: View {
    @Binding var isUserSignIn: Bool
    @State var inFocus: Bool = true
    @StateObject var viewModel = SignInViewModel()

    var body: some View {
        Spacer(minLength: 50)
        VStack(spacing: 20) {
            TextField("Type email here", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)

            SecureField("Type password here", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button(action: {
                Task {
                    do {
                        try await viewModel.signInWithEmail()
                    } catch {
                        print("Error: \(error)")
                    }
                }
                isUserSignIn = false
            }, label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            
            Spacer()
        }
    }
}

#Preview {
    SignInView(isUserSignIn: .constant(true))
}
