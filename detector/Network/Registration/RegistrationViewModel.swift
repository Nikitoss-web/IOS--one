import Foundation

class RegistrationViewModel {
    let registrain = NetworkСonnectionAPI()
    var nextScreen: ((String) -> Void)?
    func connect(name: String?, email: String?, password: String?) {
        guard let name = name, let email = email, let password = password else { return }
        registrain.connection(password: password, email: email, name: name, setting: registrain.userRegister()) { message, error in
            if let message = message {
                DispatchQueue.main.async {
                    self.nextScreen?(message)
                }
            }
        }
    }
}
