import SwiftUI

struct ContentView: View {
    @State var isUserSignIn: Bool = false
    var body: some View {
        VStack {
            NavigationStack {
                MainContactListView(isUserSingIn: $isUserSignIn)
            }
        }
        .onAppear {
            let user = try? AuthenticationManager.shared.currentUser()
            isUserSignIn = user == nil
        }
        .fullScreenCover(isPresented: $isUserSignIn, content: {
            NavigationStack {
                AuthenticationView(isUserSignIn: $isUserSignIn)
            }
        })
    }
}

#Preview {
    ContentView()
}
