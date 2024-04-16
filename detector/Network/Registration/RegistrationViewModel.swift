import Foundation

class RegistrationViewModel {
    var showNextScreen: ((String) -> Void)?
    private let registrain: NetworkСonnection
    
    init (registrain: NetworkСonnection) {
        self.registrain = registrain
    }
    
    func connect(name: String?, email: String?, password: String?) {
        guard let name = name, let email = email, let password = password else { return }
        registrain.connection(password: password, email: email, name: name, setting: registrain.userRegister()) { [weak self] (result) in
            switch result {
            case .success(let message, _):
                DispatchQueue.main.async {
                    self?.showNextScreen?(message ?? "")
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

