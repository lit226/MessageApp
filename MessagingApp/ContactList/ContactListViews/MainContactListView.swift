import SwiftUI

struct MainContactListView: View {
    @Binding var isUserSingIn: Bool
    @State var isContactAdded: Bool = true
    @StateObject var viewModel = MainContactListViewModel()
    
    var body: some View {
        NavigationStack {
            List(content: {
                ForEach(viewModel.contacts) { contact in
                    NavigationLink {
                        MessagingView(contact: contact)
                    } label: {
                        contactView(model: contact)
                    }

                }
            })
            .task {
                try? await viewModel.getData()
            }
            .navigationTitle("Chats")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationStack {
                        Menu {
                            if isContactAdded {
                                NavigationLink("Add User") {
                                    ContactInfoView(isContactCreated: $isContactAdded)
                                }
                            }
                            
                            Button("Sign out") {
                                Task {
                                    try AuthenticationManager.shared.signOut()
                                }
                                isUserSingIn = true
                            }
                            Button("Delete Account") {
                                Task {
                                    try AuthenticationManager.shared.deleteAccount()
                                }
                                isUserSingIn = true
                            }
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                    
                }
            }
        }
//            .ignoresSafeArea()
    }
}

struct contactView: View {
    
    let model: ContactListModel
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
            Text(model.name)
        }
    }
}

#Preview {
    NavigationStack {
        MainContactListView(isUserSingIn: .constant(false))
    }
}
