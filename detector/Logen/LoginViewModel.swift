import Foundation

class LoginViewModel{
    let networkAuthorization = NetworkLoginAPI()
    var nextScreen: ((String) -> Void)?
    func connect(password: String?, login: String?) {
        guard let login = login, let password = password else { return }
        networkAuthorization.connectionAUT(password: password, login: login , setting: networkAuthorization.logins()){ message, error in
            if let message = message {
                DispatchQueue.main.async {
                    self.nextScreen?(message)
                }
            }
        }
    }}
