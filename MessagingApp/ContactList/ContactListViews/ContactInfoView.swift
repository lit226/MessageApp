import SwiftUI

enum Field : String {
    case name
    case number
    case email
}

struct ContactInfoView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isContactCreated: Bool
    @State var nameText: String = ""
    @State var viewModel = ContactsViewModel()

    var body: some View {
        VStack(spacing:5) {
            createTextField(for: "    Add a name", field: .name)

            createTextField(for: "    Add a number", field: .number)

            createTextField(for: "    Add an email", field: .email)

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
    
    func createTextField(for title: String, field: Field) -> some View {
        switch field {
        case .name:
            return TextField(title, text: $viewModel.nameText)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(.capsule)
                .padding()
                .keyboardType(.numberPad)
                .shadow(radius: 10)
        case .email:
            return TextField(title, text: $viewModel.emailText)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(.capsule)
                .padding()
                .keyboardType(.numberPad)
                .shadow(radius: 10)
        case .number:
            return TextField(title, text: $viewModel.numberText)
                .padding()
                .background(.gray.opacity(0.2))
                .clipShape(.capsule)
                .padding()
                .keyboardType(.numberPad)
                .shadow(radius: 10)
        }
    }
    
}

#Preview {
    ContactInfoView(isContactCreated: .constant(false))
}
