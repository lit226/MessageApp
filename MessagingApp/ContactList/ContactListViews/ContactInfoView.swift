import SwiftUI

struct ContactInfoView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isContactCreated: Bool
    @State var nameText: String = ""
    @State var viewModel = ContactsViewModel()

    var body: some View {
        VStack(spacing:5) {
            TextField("    Add a name", text: $viewModel.nameText)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(.capsule)
                .padding()
                .shadow(radius: 10)

            TextField("    Add a number", text: $viewModel.numberText)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(.capsule)
                .padding()
                .keyboardType(.numberPad)
                .shadow(radius: 10)

            TextField("    Add an email", text: $viewModel.emailText)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(.capsule)
                .padding()
                .keyboardType(.numberPad)
                .shadow(radius: 10)

            Button(action: {
                Task {
                    do {
                        try await viewModel.addContact()
                    } catch {
                        print("Error: \(error)")
                    }
                }
                dismiss()
            }, label: {
                Text("Add")
                    .frame(width: 100, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(.capsule)
                    .shadow(color: .blue, radius: 10)
            })
            
            Spacer()
        }
    }
    
    
}

#Preview {
    ContactInfoView(isContactCreated: .constant(false))
}
