import SwiftUI

struct MessagingView: View {
    @State var contact: ContactListModel
    @StateObject var viewModel = MessageViewModel()

    var body: some View {
        VStack {
            ScrollView {
                if let messages = contact.messages {
                    ForEach(messages) { message in
                        MessageView(message: message)
                    }
                }
            }
            
            HStack {
                TextField("Type your message", text: $viewModel.message)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                .clipShape(.capsule)
                
                Button(action: {
                    viewModel.saveMessage(contact: self.contact)
                    viewModel.message = ""
                }, label: {
                    Image(systemName: "arrow.up.message.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                })
            }
        }
    }
}

struct MessageView: View {
    @State var message: MessageModel
    var body: some View {
        VStack {
            if let user = message.user {
                Text(user)
            }
            Text(message.message)
        }
        
    }
}

#Preview {
    MessagingView(contact: ContactListModel(name: "ASdf"))
}
