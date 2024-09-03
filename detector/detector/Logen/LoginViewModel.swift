import Foundation

class LoginViewModel{
    var showNextScreen: ((String) -> Void)?
    private let networkAuthorization: NetworkLogin
    
    init(networkAuthorization: NetworkLogin){
        self.networkAuthorization = networkAuthorization
    }
    
    func connect(password: String?, login: String?) {
        guard let login = login, let password = password else { return }
        networkAuthorization.connectionAUT(password: password, login: login, setting: networkAuthorization.logins()) { result in
            switch result {
            case .success(let message, _):
                if let message = message {
                    DispatchQueue.main.async {
                        self.showNextScreen?(message)
                    }
                }
            case .failure(let error):
                print("Error: \(error)")}
        }}}
